# Disassembles an Atari ST program (PRG) into vasm source which assembles to the same file.
# Relocated longwords become labels, code is found by following the control flow.
import sys, struct, re
from capstone import Cs, CS_ARCH_M68K, CS_MODE_BIG_ENDIAN, CS_MODE_M68K_000

src = open(sys.argv[1], 'rb').read()
out_path = sys.argv[2]
extra_seeds = [int(x, 16) for x in sys.argv[3:]]

magic, tlen, dlen, blen, slen, res1, flags, absflag = struct.unpack('>HIIIIIIH', src[:28])
img = src[28:28 + tlen + dlen]
p = 28 + tlen + dlen + slen
relocs = set()
first = struct.unpack('>I', src[p:p + 4])[0]
if first:
    a = first; relocs.add(a); p += 4
    while True:
        c = src[p]; p += 1
        if c == 0: break
        if c == 1: a += 254; continue
        a += c; relocs.add(a)

def lval(a): return struct.unpack('>I', img[a:a + 4])[0]

end = tlen + dlen + blen
md = Cs(CS_ARCH_M68K, CS_MODE_BIG_ENDIAN | CS_MODE_M68K_000)

# --- code discovery
code = {}            # address -> instruction
code_bytes = set()   # all bytes covered by instructions
seeds = [0] + extra_seeds
for r in relocs:
    t = lval(r)
    if t < tlen and r >= tlen:   # code pointers in the data (e.g. module tables)
        seeds.append(t)

BRANCH = re.compile(r'^(b(ra|sr|hi|ls|cc|cs|ne|eq|vc|vs|pl|mi|ge|lt|gt|le)|db\w+)')
END = ('rts', 'rte', 'rtr', 'jmp', 'bra', 'illegal')

class Pseudo:
    # line A (Atari graphics) and line F words are 2 byte instructions
    def __init__(self, a, w):
        self.address, self.size, self.mnemonic, self.op_str = a, 2, 'dc.w', '$%04x' % w

def decode(a):
    w = struct.unpack('>H', img[a:a + 2])[0]
    if w >> 12 == 0xa:
        return Pseudo(a, w)
    for i in md.disasm(img[a:a + 10], a, count=1):
        return i
    return None

queue = list(dict.fromkeys(s for s in seeds if s < tlen and s % 2 == 0))
visited_starts = set()
while queue:
    a = queue.pop()
    if a in visited_starts: continue
    visited_starts.add(a)
    # disassemble a path; abort the whole path if it runs into garbage
    path = []
    ok = True
    pos = a
    while True:
        if pos in code: break
        if pos >= tlen or pos in code_bytes: ok = pos in code; break
        i = decode(pos)
        if i is None: ok = False; break
        size = i.size
        if any(pos < x < pos + size for x in code): ok = False; break
        path.append(i)
        mn = i.mnemonic.split('.')[0]
        targets = re.findall(r'\$([0-9a-f]+)(?:\.l)?$', i.op_str) if BRANCH.match(i.mnemonic) or mn in ('jsr', 'jmp') else []
        for t in targets:
            t = int(t, 16)
            # jsr/jmp absolute targets must be relocated to be code addresses
            if mn in ('jsr', 'jmp') and not any(r in relocs for r in range(pos + 2, pos + size)): continue
            if t < tlen and t % 2 == 0: queue.append(t)
        pos += size
        if mn in END: break
    if not ok and not path:
        continue
    if not ok:
        continue
    for i in path:
        code[i.address] = i
        code_bytes.update(range(i.address, i.address + i.size))

# --- labels
def pc_fix(i):
    # capstone takes the address of the instruction + 2 as the PC, but it is the address of the extension word
    # of the effective address (+4 for movem and bit instructions with an immediate bit number)
    base = i.mnemonic.split('.')[0]
    if base in ('movem',) or (base in ('btst', 'bset', 'bclr', 'bchg') and i.op_str.startswith('#')):
        return 2
    return 0

labels = {}
def want(t):
    labels.setdefault(t, None)

for r in relocs: want(lval(r))
for a, i in code.items():
    if BRANCH.match(i.mnemonic):
        m = re.search(r'\$([0-9a-f]+)$', i.op_str)
        if m: want(int(m.group(1), 16))
    for m in re.finditer(r'\$([0-9a-f]+)\(pc', i.op_str):
        want(int(m.group(1), 16) + pc_fix(i))

def section_of(t):
    return 'T' if t < tlen else 'D' if t < tlen + dlen else 'B'

def name(t): return '%s_%05x' % (section_of(t), t)

# a label must be at a boundary of an instruction; inside one it becomes an expression
inside = {}
code_starts = sorted(code)
import bisect
data_relocs = {r for r in relocs if r not in code_bytes}
for t in list(labels):
    if t < tlen and t not in code and t in code_bytes:
        start = code_starts[bisect.bisect_right(code_starts, t) - 1]
        inside[t] = start
    else:
        # inside a relocated longword of the data
        for r in (t - 1, t - 2, t - 3):
            if r in data_relocs:
                inside[t] = r
                break
for start in set(inside.values()):
    labels.setdefault(start, None)
# labels must not split relocated longwords
for t in list(labels):
    if t in inside: del labels[t]
def ref(t):
    if t in inside: return '%s+%d' % (name(inside[t]), t - inside[t])
    return name(t)

# --- conversion of an instruction
def convert(i):
    a, size = i.address, i.size
    ops = i.op_str
    rel = [r for r in range(a + 2, a + size) if r in relocs]
    mn = i.mnemonic
    if isinstance(i, Pseudo):
        return 'dc.w\t' + ops
    # byte immediates with a set upper byte (e.g. cmpi.b #-1 as $ffff) can't be written as instructions
    if mn.endswith('.b') and ops.startswith('#') and img[a + 2] != 0 and mn.split('.')[0] in ('cmpi', 'ori', 'andi', 'eori', 'addi', 'subi', 'move'):
        return None
    # relocated absolute addresses and immediates
    for r in rel:
        t = lval(r)
        hexs = '$%x' % t
        if '#' + hexs in ops:
            ops = ops.replace('#' + hexs, '#' + ref(t), 1)
        elif hexs + '.l' in ops:
            ops = ops.replace(hexs + '.l', ref(t), 1)
        else:
            return None
    if BRANCH.match(mn):
        m = re.search(r'\$([0-9a-f]+)$', ops)
        if m:
            ops = ops[:m.start()] + ref(int(m.group(1), 16))
    ops = re.sub(r'\$([0-9a-f]+)\(pc', lambda m: ref(int(m.group(1), 16) + pc_fix(i)) + '(pc', ops)
    ops = ops.replace(', ', ',')
    # capstone quirks
    base = mn.split('.')[0]
    if base in ('btst', 'bset', 'bclr', 'bchg'):
        mn = base   # the size is given by the destination
    # absolute short addresses are sign extended
    ops = re.sub(r'\$([89a-f][0-9a-f]{3})\.w', lambda m: '$ffff%s.w' % m.group(1), ops)
    if base == 'moveq':
        ops = re.sub(r'#\$([0-9a-f]+)', lambda m: '#%d' % (int(m.group(1), 16) - 256 if int(m.group(1), 16) >= 0x80 else int(m.group(1), 16)), ops)
    return '%s\t%s' % (mn, ops) if ops else mn

def emit_bytes(lines, a, b_end):
    # data bytes with relocated longwords as labels and labels at their offsets
    pos = a
    while pos < b_end:
        if pos in labels and pos not in inside:
            lines.append(name(pos) + ':')
        if pos in relocs:
            lines.append('\tdc.l\t%s' % ref(lval(pos)))
            pos += 4
            continue
        chunk = [img[pos]]
        pos += 1
        while pos < b_end and pos not in relocs and pos not in labels and len(chunk) < 16:
            chunk.append(img[pos]); pos += 1
        lines.append('\tdc.b\t' + ','.join('$%02x' % c for c in chunk))

lines = ['; Amberstar (Atari ST) - disassembly of AMBRSTAR.68K', '', '\tsection\ttext', '']
pos = 0
failed = 0
while pos < tlen:
    if pos in code and pos in labels: lines.append(name(pos) + ':')
    if pos in code:
        i = code[pos]
        text = convert(i)
        if text is None:
            failed += 1
            lines.append('\tdc.w\t' + ','.join('$%04x' % struct.unpack('>H', img[x:x + 2])[0] for x in range(pos, pos + i.size, 2)) + '\t; ' + i.mnemonic + ' ' + i.op_str)
        else:
            lines.append('\t' + text)
        pos += i.size
    else:
        nxt = pos + 1
        while nxt < tlen and nxt not in code and nxt not in labels: nxt += 1
        emit_bytes(lines, pos, nxt)
        pos = nxt

lines += ['', '\tsection\tdata', '']
emit_bytes(lines, tlen, tlen + dlen)

lines += ['', '\tsection\tbss', '']
bss_labels = sorted(t for t in labels if t >= tlen + dlen)
pos = tlen + dlen
for t in bss_labels:
    if t > pos: lines.append('\tds.b\t%d' % (t - pos)); pos = t
    lines.append(name(t) + ':')
if end > pos: lines.append('\tds.b\t%d' % (end - pos))

open(out_path, 'w', encoding='latin-1').write('\n'.join(lines) + '\n')
print('code instructions', len(code), 'code bytes', len(code_bytes), 'of', tlen, 'labels', len(labels), 'inside', len(inside), 'unconverted', failed)
