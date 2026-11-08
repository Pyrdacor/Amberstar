# Disassembles an Atari ST program (PRG) into vasm source which assembles to the same file.
# Relocated longwords become labels, code is found by following the control flow.
import sys, os, struct, re, collections
from capstone import Cs, CS_ARCH_M68K, CS_MODE_BIG_ENDIAN, CS_MODE_M68K_000

src = open(sys.argv[1], 'rb').read()
out_path = sys.argv[2]
extra_seeds = [int(x, 16) for x in sys.argv[3:] if not x.endswith(('.txt', '.json', '.i')) and not x.startswith('--')]
# optional merge.json: routines of the original source which assemble to the same bytes
import json
merge = {}
constants_include = None
for x in sys.argv[3:]:
    if x.endswith('.json'):
        for nm, v in json.load(open(x)).items():
            if v.get('state') == 'same' and v.get('source'):
                merge[v['addr']] = (nm, v['size'], v['source'], v['file'])
    if x.endswith('.i'):
        constants_include = x
split_dir = next((x[8:] for x in sys.argv[3:] if x.startswith('--split=')), None)
# optional --structs=FILE (structs.py): accesses to the fields of the character data, written with the names of OFFSETS.ASM
struct_fields = collections.defaultdict(list)
for x in sys.argv[3:]:
    if x.startswith('--structs='):
        for l in open(x[10:]):
            c = l.rstrip('\n').split('\t')
            if len(c) == 3: struct_fields[int(c[0], 16)].append((c[1], c[2]))
# order of the modules (TEST.ASM includes them in this order, the other parts are linked behind it)
MODULE_ORDER = ['MAIN/TEST.ASM', 'MAIN/STATUS.ASM', 'MAIN/MAP/MAP.ASM', 'MAIN/MAP/2DMAP.ASM', 'MAIN/MAP/3DMAP.ASM',
    'MAIN/MAP/2DWILD.ASM', 'MAIN/MAP/2DCITY.ASM', 'MAIN/MAP/3DDUNGEO.ASM', 'MAIN/MAP/3DCITY.ASM', 'MAIN/MAP/SHADOW.ASM',
    'MAIN/PERSONS.ASM', 'MAIN/TIME.ASM', 'LAYOUT/LAYOUT.ASM', 'MAIN/WORDS.ASM', 'MAIN/EVENTS.ASM', 'MAIN/WSELW.ASM',
    'MAIN/PLACES.ASM', 'MAIN/EYE.ASM', 'MAIN/MODCON.ASM', 'MAIN/MODULES.ASM', 'MAIN/INVENT.ASM', 'MAIN/MAGIC.ASM',
    'MAIN/COMBAT.ASM', 'LAYOUT/OBJFIND.ASM', 'LAYOUT/WINDOWS.ASM', 'LAYOUT/GRAPHICS.ASM', 'NUCLEUS/AMBRFILE.ASM',
    'NUCLEUS/COLOFADE.ASM', 'NUCLEUS/DIAGNOST.ASM', 'NUCLEUS/GFXROUTS.ASM', 'NUCLEUS/HBI.ASM', 'NUCLEUS/INTROUTS.ASM',
    'NUCLEUS/KBDROUTS.ASM', 'NUCLEUS/MEMORY.ASM', 'NUCLEUS/NUMERIC.ASM', 'NUCLEUS/SCREEN.ASM', 'NUCLEUS/TEXTPUT.ASM']
# optional SYMBOLS.txt with the names of the original source
symbol_names = {}
file_of_addr = {}
symbol_comments = {}
for x in sys.argv[3:]:
    if x.endswith('.txt'):
        for l in open(x):
            if l.startswith('#') or not l.strip(): continue
            c = l.rstrip('\n').split('\t')
            symbol_names.setdefault(int(c[0], 16), []).append(c[2].replace('.', '_'))
            if len(c) > 3 and c[3] and '.' not in c[2]: file_of_addr.setdefault(int(c[0], 16), c[3])
            if len(c) > 5 and c[5]: symbol_comments.setdefault(int(c[0], 16), c[5])
for x in sys.argv[3:]:
    if x.endswith('.json') and os.path.exists(x + '.names.txt'):
        for l in open(x + '.names.txt'):
            c = l.rstrip('\n').split('\t')
            if len(c) >= 2 and c[1] not in symbol_names.get(int(c[0], 16), []):
                symbol_names.setdefault(int(c[0], 16), []).append(c[1])

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

# --- more code: other pointers into the text and gaps behind the end of a routine.
# A candidate is only taken if it decodes cleanly up to the end of a routine.
def try_path(a, limit=600):
    path, pos = [], a
    while len(path) < limit:
        if pos >= tlen or pos in code_bytes: return None
        i = decode(pos)
        if i is None or isinstance(i, Pseudo) or i.mnemonic in ('illegal',): return None
        if any(pos < x < pos + i.size for x in code): return None
        # data which decodes as code mostly contains absolute addresses which are not relocated
        if re.search(r'\$[0-9a-f]{5,}\.l', i.op_str) and not any(r in relocs for r in range(pos + 2, pos + i.size)):
            return None
        # relocated longwords must be operands of the instruction (and not start inside it)
        for r in range(pos + 1, pos + i.size):
            if r in relocs:
                h = '$%x' % lval(r)
                if r == pos + 1 or r + 4 > pos + i.size or ('#' + h not in i.op_str and h + '.l' not in i.op_str):
                    return None
        if any(r in relocs for r in range(pos - 3, pos)):
            return None
        path.append(i)
        pos += i.size
        if i.mnemonic.split('.')[0] in END: return path
    return None

def add_code_from(a):
    # follows the control flow like the first pass, but only accepts clean paths
    todo, added = [a], 0
    while todo:
        s = todo.pop()
        if s in code or s >= tlen or s % 2: continue
        path = try_path(s)
        if not path: continue
        for i in path:
            code[i.address] = i
            code_bytes.update(range(i.address, i.address + i.size))
            added += 1
            mn = i.mnemonic.split('.')[0]
            if BRANCH.match(i.mnemonic) or mn in ('jsr',):
                m = re.search(r'\$([0-9a-f]+)(?:\.l)?$', i.op_str)
                if m:
                    t = int(m.group(1), 16)
                    if mn == 'jsr' and not any(r in relocs for r in range(i.address + 2, i.address + i.size)): continue
                    if t < tlen and t % 2 == 0: todo.append(t)
    return added

for _ in range(3):
    extra = 0
    for r in sorted(relocs):
        t = lval(r)
        if t < tlen and t not in code_bytes:
            extra += add_code_from(t)
    for a in sorted(code):
        i = code[a]
        nxt = a + i.size
        if i.mnemonic.split('.')[0] in END and nxt < tlen and nxt not in code_bytes:
            extra += add_code_from(nxt)
    if not extra: break

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

# all named addresses get a label (the merged original code refers to them)
for t in symbol_names:
    if t <= end: want(t)

refs_from = {}   # label -> addresses which refer to it
def add_ref(t, src_addr):
    want(t)
    refs_from.setdefault(t, set()).add(src_addr)

for r in relocs: add_ref(lval(r), r)
for a, i in code.items():
    if BRANCH.match(i.mnemonic):
        m = re.search(r'\$([0-9a-f]+)$', i.op_str)
        if m: add_ref(int(m.group(1), 16), a)
    for m in re.finditer(r'\$([0-9a-f]+)\(pc', i.op_str):
        add_ref(int(m.group(1), 16) + pc_fix(i), a)



def section_of(t):
    return 'T' if t < tlen else 'D' if t < tlen + dlen else 'B'

def name(t): return symbol_names[t][0] if t in symbol_names else '%s_%05x' % (section_of(t), t)
def label_lines(t):
    # all names of an address (the first one is used for references)
    comment = ['; ' + symbol_comments[t]] if t in symbol_comments else []
    return comment + ([n + ':' for n in symbol_names.get(t, [])] or [name(t) + ':'])

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

# routines of the original source replace the disassembly; labels inside them which are used from outside are
# defined relative to the start of the routine
merge_inner = {}
for a in list(merge):
    nm, size, src, f = merge[a]
    if a + size > tlen or any(a < x < a + size for x in merge if x != a):
        del merge[a]; continue
    merge_inner[a] = sorted(t for t, srcs in refs_from.items() if a < t < a + size and any(not (a <= s < a + size) for s in srcs))
    merge_inner[a] += sorted(t for t in symbol_names if a < t < a + size and t not in merge_inner[a])
    merge_inner[a] += sorted(t for t in set(inside.values()) if a < t < a + size and t not in merge_inner[a])

# --- local labels (option --locals): labels of the text which are only used inside their routine (the code between
# two global labels) become local labels. Each label which becomes local joins two routines, so this is repeated.
local_labels = set()
if '--locals' in sys.argv[3:]:
    import bisect as _bisect
    merged_ranges = sorted((a, a + v[1]) for a, v in merge.items())
    def merged_range_of(x):
        k = _bisect.bisect_right(merged_ranges, (x, float('inf'))) - 1
        if k >= 0 and merged_ranges[k][0] <= x < merged_ranges[k][1]: return merged_ranges[k]
        return None
    fixed = set(symbol_names) | set(inside.values()) | {t for t in labels if t >= tlen}
    for a, (s, e) in [(a, r) for a, r in zip([r[0] for r in merged_ranges], merged_ranges)]:
        fixed.add(s)
        fixed.update(t for t in labels if s < t < e)
    candidates = {t for t in labels if t < tlen and t not in fixed and t in refs_from}
    changed = True
    while changed:
        changed = False
        glob = sorted((set(labels) - local_labels) | {r[0] for r in merged_ranges})
        for t in sorted(candidates - local_labels):
            k = _bisect.bisect_left(glob, t)
            lo = glob[k - 1] if k > 0 else 0
            hi = glob[k + 1] if k + 1 < len(glob) else tlen
            ok = True
            for src_addr in refs_from[t]:
                # references from the data, from merged routines or from another routine keep the label global
                if src_addr >= tlen or merged_range_of(src_addr) or not (lo <= src_addr < hi):
                    ok = False; break
            if ok:
                local_labels.add(t); changed = True
                glob.remove(t)
_name = name
def name(t):
    if t in local_labels: return '.l_%05x' % t
    return _name(t)

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

def emit_bytes(lines, a, b_end, on_pos=None):
    # data bytes with relocated longwords as labels and labels at their offsets
    pos = a
    while pos < b_end:
        if on_pos: on_pos(pos)
        if pos in labels and pos not in inside:
            lines.extend(label_lines(pos))
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
code_list = []
if constants_include:
    lines[2:2] = ['\tinclude\t"%s"' % constants_include, '']
merged_count = 0
# files of the merged routines
for a, v in merge.items(): file_of_addr[a] = v[3]
segments = [(len(lines), MODULE_ORDER[0])]
# The modules follow each other in MODULE_ORDER. The boundaries are chosen so that as few known routines as
# possible are in another module than their file (single misplaced names don't move a boundary).
def module_boundaries(lo, hi):
    # The modules follow each other in MODULE_ORDER (in the text, the data and the BSS). The boundaries are chosen so
    # that as few known names as possible are in another module than their file (single misplaced names don't count).
    known = sorted((a, MODULE_ORDER.index(fl)) for a, fl in file_of_addr.items() if lo <= a < hi and fl in MODULE_ORDER)
    M = len(MODULE_ORDER)
    INF = 10 ** 9
    cost = [0] * M
    back = []
    for a, m in known:
        new_cost, choice = [0] * M, [0] * M
        run_min, run_arg = INF, 0
        for k in range(M):
            if cost[k] < run_min: run_min, run_arg = cost[k], k
            new_cost[k] = run_min + (0 if k == m else 1)
            choice[k] = run_arg
        back.append(choice)
        cost = new_cost
    if not known: return {}
    k = min(range(M), key=lambda x: cost[x])
    assign = [0] * len(known)
    for i in range(len(known) - 1, -1, -1):
        assign[i] = k
        k = back[i][k]
    result, prev = {}, 0
    for (a, _), m in zip(known, assign):
        if m != prev:
            result[a] = MODULE_ORDER[m]
            prev = m
    return result
boundaries = module_boundaries(0, tlen)
data_boundaries = module_boundaries(tlen, tlen + dlen)
bss_boundaries = module_boundaries(tlen + dlen, end + 1)
data_segments, bss_segments = [], []
def module_boundary(p):
    if p in boundaries:
        segments.append((len(lines), boundaries[p]))
text_start = len(lines)
while pos < tlen:
    if split_dir: module_boundary(pos)
    if pos in merge:
        nm, size, src, f = merge[pos]
        own = nm
        body_labels = {l[:-1] for l in src if re.fullmatch(r'[A-Za-z_]\w*:', l)}
        lines.append('; ---- %s (original source: %s)' % (nm, f))
        lines.extend(l for l in label_lines(pos) if l.rstrip(':') not in body_labels)
        # address names of program lines refer to the current names
        lines.extend(re.sub(r'\b[TDB]_([0-9a-f]{5})\b', lambda m: ref(int(m.group(1), 16)), l) for l in src)
        own_name = own or nm
        for t in merge_inner.get(pos, []):
            for n in (symbol_names.get(t) or [name(t)]):
                lines.append('%s	equ	%s+%d' % (n, own_name, t - pos))
            if t not in symbol_names: pass
        merged_count += 1
        pos += size
        continue
    if pos in code and pos in labels: lines.extend(label_lines(pos))
    if pos in code:
        i = code[pos]
        text = convert(i)
        if text is None:
            failed += 1
            # relocated longwords stay label references
            x, parts = pos, []
            while x < pos + i.size:
                if x in relocs:
                    if parts: lines.append('\tdc.w\t' + ','.join(parts)); parts = []
                    lines.append('\tdc.l\t' + ref(lval(x))); x += 4
                else:
                    parts.append('$%04x' % struct.unpack('>H', img[x:x + 2])[0]); x += 2
            if parts: lines.append('\tdc.w\t' + ','.join(parts))
            lines[-1] += '\t; ' + i.mnemonic + ' ' + i.op_str
        else:
            code_list.append('%x\t%s' % (pos, text))
            for old, new in struct_fields.get(pos, []):
                text = re.sub(r'(?<![\w$-])' + re.escape(old) + r'(?=[,)])', new, text)
            lines.append('\t' + text)
        pos += i.size
    else:
        nxt = pos + 1
        while nxt < tlen and nxt not in code and nxt not in labels: nxt += 1
        emit_bytes(lines, pos, nxt)
        pos = nxt

# names of addresses inside an instruction (or a relocated longword) are defined relative to its start
for t in sorted(inside):
    for n in symbol_names.get(t, []):
        lines.append('%s\tequ\t%s' % (n, ref(t)))

text_end = len(lines)
lines += ['', '\tsection\tdata', '']
data_segments.append((len(lines), MODULE_ORDER[0]))
def data_boundary(p):
    if split_dir and p in data_boundaries: data_segments.append((len(lines), data_boundaries[p]))
emit_bytes(lines, tlen, tlen + dlen, data_boundary)
data_end = len(lines)

lines += ['', '\tsection\tbss', '']
bss_segments.append((len(lines), MODULE_ORDER[0]))
bss_labels = sorted(t for t in labels if t >= tlen + dlen)
pos = tlen + dlen
for t in bss_labels:
    if t > pos: lines.append('\tds.b\t%d' % (t - pos)); pos = t
    if split_dir and t in bss_boundaries: bss_segments.append((len(lines), bss_boundaries[t]))
    lines.extend(label_lines(t))
if end > pos: lines.append('\tds.b\t%d' % (end - pos))

open(out_path, 'w', encoding='latin-1').write('\n'.join(lines) + '\n')
if split_dir:
    # one file per module, the data and the BSS in their own files, AMBRSTAR.S includes them
    def write(rel, content):
        p = os.path.join(split_dir, rel)
        os.makedirs(os.path.dirname(p), exist_ok=True)
        open(p, 'w', encoding='latin-1').write('\n'.join(content) + '\n')
    build = ['; Amberstar (Atari ST) - main program AMBRSTAR.68K', '; Build file: includes the modules in the order of',
             '; the program (TEST.ASM includes them in this order, the other parts are linked behind it).', '']
    if constants_include: build += ['\tinclude\t"CONSTANTS.I"', '']
    # the equates of names inside instructions are behind the modules
    EQU_LINE = re.compile(r'^\S+\tequ\t')
    inner_equ = [l for l in lines[text_start:text_end] if EQU_LINE.match(l)]
    parts = collections.defaultdict(lambda: {'text': [], 'data': [], 'bss': []})
    def collect(segs, stop_line, kind, skip_equ=False):
        bounds = segs + [(stop_line, None)]
        for (start, fl), (stop, _) in zip(bounds, bounds[1:]):
            part = lines[start:stop]
            if skip_equ: part = [l for l in part if not EQU_LINE.match(l)]
            parts[fl][kind] += part
    collect([(max(s, text_start), fl) for s, fl in segments], text_end, 'text', True)
    collect(data_segments, data_end, 'data')
    collect(bss_segments, len(lines), 'bss')
    for fl in MODULE_ORDER:
        if fl not in parts: continue
        p = parts[fl]
        rel = fl.replace('.ASM', '.S')
        content = ['; ' + fl + ' (original module, merged with the disassembly of the shipped program)', '', '\tsection\ttext', '']
        content += p['text']
        # vasm appends the sections in the order of the modules, so the data and the variables stay at their place
        if any(l.strip() for l in p['data']): content += ['', '\tsection\tdata', ''] + p['data']
        if any(l.strip() for l in p['bss']): content += ['', '\tsection\tbss', ''] + p['bss']
        write(rel, content)
        build.append('\tinclude\t"%s"' % rel)
    build += ['', '\tsection\ttext', ''] + inner_equ
    write('AMBRSTAR.S', build)
open(out_path + '.code.tsv', 'w', encoding='latin-1').write('\n'.join(code_list) + '\n')
print('merged routines', merged_count, 'code instructions', len(code), 'code bytes', len(code_bytes), 'of', tlen, 'labels', len(labels), 'inside', len(inside), 'unconverted', failed)
