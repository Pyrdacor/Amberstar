# Finds the names of the original source for the labels of the disassembly.
# The routines of the original source are aligned with the code of the disassembly. Aligned instructions give
# the names of their operands (routines, variables, data).
import sys, os, re, glob, difflib, collections, json

src_dir, code_tsv, out_path = sys.argv[1], sys.argv[2], sys.argv[3]

REGS = {'d%d' % i for i in range(8)} | {'a%d' % i for i in range(8)} | {'sp', 'sr', 'ccr', 'usp', 'pc'}
ALIAS = {'movea': 'move', 'adda': 'add', 'suba': 'sub', 'cmpa': 'cmp', 'cmpi': 'cmp', 'addi': 'add', 'subi': 'sub',
         'andi': 'and', 'ori': 'or', 'eori': 'eor', 'dbra': 'dbf', 'cmpm': 'cmp', 'addx': 'addx'}
SIZELESS = {'lea', 'pea', 'moveq', 'btst', 'bset', 'bclr', 'bchg', 'jsr', 'jmp', 'rts', 'rte', 'rtr', 'trap', 'exg',
            'swap', 'nop', 'illegal', 'stop', 'link', 'unlk', 'dbf', 'scc', 'st', 'sf', 'seq', 'sne', 'smi', 'spl',
            'shi', 'sls', 'scs', 'sge', 'slt', 'sgt', 'sle', 'svc', 'svs', 'chk', 'mulu', 'muls', 'divu', 'divs', 'tas',
            'nbcd', 'abcd', 'sbcd'}
BRANCH = re.compile(r'^(bra|bsr|bhi|bls|bcc|bcs|bne|beq|bvc|bvs|bpl|bmi|bge|blt|bgt|ble|bhs|blo|db\w+)$')

def split_ops(s):
    ops, depth, cur = [], 0, ''
    for c in s:
        if c == '(': depth += 1
        elif c == ')': depth -= 1
        if c == ',' and depth == 0:
            ops.append(cur); cur = ''
        else:
            cur += c
    if cur: ops.append(cur)
    return [o.strip() for o in ops]

# ------------------------------------------------------------------ constants of the original
consts = {}
def parse_number(t):
    t = t.strip()
    try:
        if t.startswith('$'): return int(t[1:], 16)
        if t.startswith('%'): return int(t[1:], 2)
        if re.fullmatch(r'\d+', t): return int(t)
        if re.fullmatch(r"'.'", t): return ord(t[1])
    except ValueError:
        return None
    return None

def evaluate(expr):
    expr = expr.strip()
    if not expr: return None
    n = parse_number(expr)
    if n is not None: return n
    toks = re.findall(r"\$[0-9A-Fa-f]+|%[01]+|\d+|[A-Za-z_.][\w.]*|'.'|[-+*/()<>&|!]", expr)
    if ''.join(toks).replace(' ', '') != expr.replace(' ', ''): return None
    py = ''
    for t in toks:
        v = parse_number(t)
        if v is not None: py += str(v)
        elif re.fullmatch(r'[A-Za-z_.][\w.]*', t):
            if t in consts: py += str(consts[t])
            else: return None
        elif t == '<': py += '<<'
        elif t == '>': py += '>>'
        elif t == '!': py += '|'
        else: py += t
    py = py.replace('<<<<', '<<').replace('>>>>', '>>').replace('/', '//')
    try:
        return int(eval(py, {'__builtins__': {}}))
    except Exception:
        return None

files = sorted(glob.glob(os.path.join(src_dir, '**', '*.ASM'), recursive=True))
raw = {}
for f in files:
    raw[f] = open(f, encoding='latin-1').read().splitlines()

LINE = re.compile(r'^(?:([A-Za-z_.~\\][\w.~\\]*)(::?)?)?\s*(?:([A-Za-z_.][\w.]*)\s*(.*?))?\s*(?:;.*)?$')

def parse_line(l):
    if not l.strip() or l.lstrip().startswith(';') or l.lstrip().startswith('*'): return None
    if l.lstrip().startswith('{'): return None
    # strip comments which are not inside quotes
    out, q = '', None
    for c in l:
        if q:
            out += c
            if c == q: q = None
        elif c in "'\"":
            q = c; out += c
        elif c == ';':
            break
        else:
            out += c
    l = out.rstrip()
    label = None
    m = re.match(r'^([A-Za-z_.][\w.]*)(::?)?(?=\s|$)', l)
    if m and not l[0].isspace():
        label = m.group(1).rstrip(':')
        if m.group(2) is None and not l[m.end():].strip().upper().startswith(('EQU', '=')):
            pass
        l = l[m.end():]
    rest = l.strip()
    mn, ops = None, ''
    if rest:
        parts = rest.split(None, 1)
        mn = parts[0]
        ops = parts[1].strip() if len(parts) > 1 else ''
    return label, mn, ops

# constants: EQU, = and .ABS structures (repeated until stable)
for _ in range(4):
    for f, lines in raw.items():
        abs_mode, offset = False, 0
        for l in lines:
            p = parse_line(l)
            if not p: continue
            label, mn, ops = p
            if mn and mn.upper() in ('=', 'EQU', '.EQU', 'SET', '.SET') and label:
                v = evaluate(ops)
                if v is not None: consts[label] = v
                continue
            if label and mn == '=':
                continue
            if mn and mn.upper() == '.ABS':
                abs_mode, offset = True, evaluate(ops) or 0
                continue
            if mn and mn.upper() in ('.TEXT', '.DATA', '.BSS', '.SECTION', '.END'):
                abs_mode = False
            if abs_mode:
                if label: consts[label] = offset
                if mn and mn.upper().startswith('.DS.'):
                    size = {'B': 1, 'W': 2, 'L': 4}[mn[-1].upper()]
                    n = evaluate(ops)
                    if n is None: abs_mode = False; continue
                    if size > 1 and offset % 2: offset += 1
                    offset += size * n
                elif mn and mn.upper() == '.EVEN':
                    offset += offset % 2
    # "Name = value" lines are parsed as label "Name" with mnemonic "="
    for f, lines in raw.items():
        for l in lines:
            m = re.match(r'^([A-Za-z_][\w.]*)\s*(=|\.?EQU|\.?SET)\s*(.+?)\s*(;.*)?$', l, re.I)
            if m:
                v = evaluate(m.group(3))
                if v is not None: consts[m.group(1)] = v

# ------------------------------------------------------------------ normalization
def canon_reglist(s):
    regs = set()
    for part in s.split('/'):
        if '-' in part:
            a, b = part.split('-')
            if a[0] == b[0]:
                for i in range(int(a[1]), int(b[1]) + 1): regs.add(a[0] + str(i))
        else:
            regs.add(part)
    regs = {('a7' if r == 'sp' else r) for r in regs}
    return '/'.join(sorted(regs))

def norm_operand(o, side):
    """Returns (normalized operand, symbol reference or None). side: 'o' original, 'd' disassembly"""
    o = o.strip().replace(' ', '')
    lo = o.lower()
    if lo == 'sp': return 'a7', None
    if lo in REGS: return lo, None
    if re.fullmatch(r'([da][0-7]|sp)([-/]([da][0-7]|sp))+', lo):
        return canon_reglist(lo), None
    if lo in ('(sp)', '(a7)'): return '(a7)', None
    if re.fullmatch(r'-\((a[0-7]|sp)\)', lo): return lo.replace('sp', 'a7'), None
    if re.fullmatch(r'\((a[0-7]|sp)\)\+?', lo): return lo.replace('sp', 'a7'), None
    def value_or_sym(expr):
        if side == 'd':
            m = re.fullmatch(r'([TDB]_[0-9a-f]+)(?:\+(\d+))?', expr)
            if m:
                base = int(m.group(1)[2:], 16) + (int(m.group(2)) if m.group(2) else 0)
                return 'S', ('addr', base)
            v = parse_number(expr.replace('-$', '-0x').replace('0x', '$') if False else expr)
            if expr.startswith('-$'): v = -int(expr[2:], 16)
            elif expr.startswith('$'): v = int(expr[1:], 16)
            elif re.fullmatch(r'-?\d+', expr): v = int(expr)
            return (str(v) if v is not None else '?'), None
        v = evaluate(expr)
        if v is not None: return str(v), None
        m = re.fullmatch(r'([A-Za-z_][\w.]*)(?:([+-])(.+))?', expr)
        if m:
            add = 0
            if m.group(3):
                a = evaluate(m.group(3))
                if a is None: return '?', None
                add = a if m.group(2) == '+' else -a
            return 'S', ('name', m.group(1), add)
        return '?', None
    # immediate
    if o.startswith('#'):
        v, r = value_or_sym(o[1:])
        return '#' + v, r
    # indexed / displacement
    m = re.fullmatch(r'(.*)\(([^)]*)\)', o)
    if m:
        disp, inner = m.group(1), m.group(2).lower().replace('sp', 'a7')
        parts = inner.split(',')
        if len(parts) == 2 and not re.search(r'\.[wl]$', parts[1]): parts[1] += '.w'
        inner = ','.join(parts)
        if parts[0] == 'pc':
            v, r = value_or_sym(disp) if disp else ('0', None)
            return 'S(' + inner + ')', r
        if disp == '': return '0(' + inner + ')', None
        v, r = value_or_sym(disp)
        return v + '(' + inner + ')', r
    # absolute with size
    m = re.fullmatch(r'(.*)\.([wl])', o, re.I)
    expr = m.group(1) if m else o
    v, r = value_or_sym(expr)
    if v not in ('S', '?') and side == 'd':
        n = int(v)
        if n >= 0xffff8000: n -= 0x100000000
        if 0xff8000 <= n <= 0xffffff: n -= 0x1000000
        v = str(n)
    elif v not in ('S', '?'):
        n = int(v)
        if n >= 0xffff8000: n -= 0x100000000
        if 0xff8000 <= n <= 0xffffff: n -= 0x1000000
        v = str(n)
    return v, r

def norm_instr(mn, ops, side):
    mn = mn.lower()
    if '.' in mn:
        base, size = mn.split('.', 1)
    else:
        base, size = mn, ''
    base = ALIAS.get(base, base)
    if BRANCH.match(base) or base in SIZELESS or base.startswith('db'):
        size = ''
        if base.startswith('db') and base != 'dbf' and base == 'dbra': base = 'dbf'
    elif size == '':
        size = 'w'
    if size == 's': size = ''
    olist = split_ops(ops) if ops else []
    nops, refs = [], []
    for o in olist:
        n, r = norm_operand(o, side)
        if BRANCH.match(base) and r is None and side == 'o' and n == '?':
            n = 'S'
        nops.append(n); refs.append(r)
    full = base + ('.' + size if size else '') + ' ' + ','.join(nops)
    shape = base + ('.' + size if size else '') + ' ' + ','.join(re.sub(r'-?\d+', 'N', x) for x in nops)
    return full, shape, refs

# ------------------------------------------------------------------ macro expansion (only the macros used in code)
def expand(mn, ops):
    up = mn.upper()
    a = split_ops(ops) if ops else []
    if up == 'PUSH':
        t, p = a[0], a[1]
        if p.startswith('#'): return [('move.w', p + ',d0'), ('jsr', 'Push_' + t)]
        return [('lea.l', p + ',a0'), ('jsr', 'Push_' + t)]
    if up == 'POP': return [('jsr', 'Pop_' + a[0])]
    if up == 'WAIT_4_UNCLICK': return [('btst', '#1,Mouse_button_state'), ('bne.s', '*'), ('clr.b', 'Mouse_click_state')]
    if up == 'UPDATE_SCREEN': return [('jsr', 'Switch_screen'), ('jsr', 'Copy_screen')]
    if up == 'ERROR': return [('lea.l', '__error,a1'), ('jsr', 'DI_Error')]
    if up in ('PLUSMES', 'HASHMES', 'MESMIN'):
        target = {'PLUSMES': 'Plus_message', 'HASHMES': 'Hash_message', 'MESMIN': 'Minus_message'}[up]
        return [('move.w', '#' + a[0] + ',d0'), ('jsr', target)]
    if up == 'SETMESMIN':
        return [('move.w', '#%s,Mesmin_X' % a[0]), ('move.w', '#%s,Mesmin_Y' % a[1]), ('move.w', '#%s,Mesmin_Wd' % a[2]), ('move.l', '#%s,Textfile_ptr' % a[3])]
    if up in ('GEMDOS', 'BIOS', 'XBIOS'):
        trap = {'GEMDOS': 1, 'BIOS': 13, 'XBIOS': 14}[up]
        tidy = evaluate(a[1]) if len(a) > 1 else None
        res = [('move.w', '#' + a[0] + ',-(sp)'), ('trap', '#%d' % trap)]
        if tidy is not None: res.append(('lea.l', '%d(sp),sp' % tidy) if tidy > 8 else ('addq.l', '#%d,sp' % tidy))
        return res
    return None

# ------------------------------------------------------------------ routines of the original
routines = []   # (name, file, [ (full, shape, refs) ])
data_labels = {}
for f, lines in raw.items():
    rel = os.path.relpath(f, src_dir).replace('\\', '/')
    section = 'text'
    cur = None
    for l in lines:
        p = parse_line(l)
        if not p: continue
        label, mn, ops = p
        if mn and mn.upper() in ('.TEXT',): section = 'text'
        elif mn and mn.upper() in ('.DATA',): section = 'data'
        elif mn and mn.upper() in ('.BSS',): section = 'bss'
        elif mn and mn.upper() in ('.ABS',): section = 'abs'
        if label and not label.startswith('.') and section == 'text' and (mn is None or not mn.startswith('.') and mn not in ('=',) and mn.upper() not in ('EQU',)):
            cur = [label, rel, []]
            routines.append(cur)
        if label and not label.startswith('.') and section in ('data', 'bss'):
            data_labels.setdefault(label, rel)
        if section != 'text' or not mn or mn.startswith('.') or mn == '=' or mn.upper() in ('EQU', 'SET'):
            continue
        if cur is None: continue
        ex = expand(mn, ops)
        for emn, eops in (ex if ex is not None else [(mn, ops)]):
            if not re.fullmatch(r'[A-Za-z]+(\.[bwlsBWLS])?', emn): continue
            cur[2].append(norm_instr(emn, eops, 'o'))

# ------------------------------------------------------------------ the disassembly
dis = []
for l in open(code_tsv, encoding='latin-1'):
    l = l.rstrip('\n')
    if not l: continue
    addr, text = l.split('\t', 1)
    parts = text.split('\t', 1)
    mn = parts[0]; ops = parts[1] if len(parts) > 1 else ''
    if mn.startswith('dc.'): full, shape, refs = 'dc', 'dc', []
    else: full, shape, refs = norm_instr(mn, ops, 'd')
    dis.append((int(addr, 16), full, shape, refs))
dshapes = [d[2] for d in dis]

# index of shape 4-grams
K = 4
grams = collections.defaultdict(list)
for i in range(len(dis) - K + 1):
    grams[tuple(dshapes[i:i + K])].append(i)

def tok_eq(o, d):
    if o == d: return True
    # wildcards of the original
    oo, dd = o.split(' ', 1), d.split(' ', 1)
    if oo[0] != dd[0]: return False
    op1, op2 = split_ops(oo[1]) if len(oo) > 1 else [], split_ops(dd[1]) if len(dd) > 1 else []
    if len(op1) != len(op2): return False
    for a, b in zip(op1, op2):
        if a == b: continue
        if a.replace('?', 'X') == b.replace('?', 'X'): continue
        if '?' in a and re.fullmatch(re.escape(a).replace(r'\?', r'-?\d+'), b): continue
        if a == 'S' and re.fullmatch(r'-?\d+', b): continue   # symbol which is absolute in the program
        return False
    return True

routine_addr = {}
votes = collections.defaultdict(collections.Counter)
stats = collections.Counter()
for name, rel, seq in routines:
    if len(seq) < 3:
        stats['short'] += 1; continue
    shapes = [s[1] for s in seq]
    # candidate positions from the 4-grams of the routine
    cand = collections.Counter()
    for j in range(len(shapes) - K + 1):
        g = tuple(shapes[j:j + K])
        hits = grams.get(g, [])
        if 0 < len(hits) <= 8:
            for h in hits: cand[h - j] += 1
    if not cand:
        stats['nocand'] += 1; continue
    best = None
    for start, cnt in cand.most_common(4):
        lo = max(0, start - 8); hi = min(len(dis), start + len(seq) + 16)
        sm = difflib.SequenceMatcher(None, shapes, dshapes[lo:hi], autojunk=False)
        blocks = sm.get_matching_blocks()
        matched = sum(b.size for b in blocks)
        score = matched / len(seq)
        if best is None or score > best[0]:
            best = (score, lo, blocks)
    score, lo, blocks = best
    if score < 0.75:
        stats['weak'] += 1; continue
    stats['matched'] += 1
    # address of the routine: the first instruction if it is aligned, otherwise derived from the first block
    b0 = blocks[0]
    if score >= 0.9 and b0.a == 0 and b0.size >= 3 and len(seq) >= 6:
        routine_addr[name] = (dis[lo + b0.b][0], rel, round(score, 2))
    for b in blocks:
        if b.size < 3: continue
        for k in range(b.size):
            o = seq[b.a + k]; d = dis[lo + b.b + k]
            if not tok_eq(o[0], d[1]): continue
            for ro, rd in zip(o[2], d[3]):
                if ro and rd and ro[0] == 'name' and rd[0] == 'addr':
                    votes[ro[1]][rd[1] - ro[2]] += 1

names = {}
for nm, c in votes.items():
    addr, n = c.most_common(1)[0]
    total = sum(c.values())
    if n >= 2 and n / total >= 0.75:
        names[nm] = (addr, n, total)
for nm, (addr, rel, score) in routine_addr.items():
    if addr is not None and nm not in names:
        names[nm] = (addr, 0, 0)

# ------------------------------------------------------------------ pointer tables of the data (e.g. modules)
import struct
prg = open(sys.argv[4], 'rb').read()
_, tlen, dlen, blen = struct.unpack('>HIII', prg[:14])
img = prg[28:28 + tlen + dlen]
p = 28 + tlen + dlen
relocs = {}
first = struct.unpack('>I', prg[p:p + 4])[0]
if first:
    a = first; p += 4
    relocs[a] = struct.unpack('>I', img[a:a + 4])[0]
    while True:
        c = prg[p]; p += 1
        if c == 0: break
        if c == 1: a += 254; continue
        a += c; relocs[a] = struct.unpack('>I', img[a:a + 4])[0]

tables = []   # (name, file, [entry name or None])
for f, lines in raw.items():
    rel = os.path.relpath(f, src_dir).replace('\\', '/')
    section, cur, glob_label = 'text', None, None
    for l in lines:
        pl = parse_line(l)
        if not pl: continue
        label, mn, ops = pl
        if mn and mn.upper() == '.TEXT': section = 'text'
        elif mn and mn.upper() == '.DATA': section = 'data'
        elif mn and mn.upper() in ('.BSS', '.ABS'): section = 'other'
        if section != 'data': cur = None; continue
        if label and not label.startswith('.'):
            glob_label = label
            cur = [label, rel, []]
            tables.append(cur)
        if cur is None: continue
        if mn and mn.upper() == '.DC.L':
            for o in split_ops(ops):
                o = o.strip()
                if o.startswith('.'): o = glob_label + o
                cur[2].append(o if re.fullmatch(r'[A-Za-z_][\w.]*', o) else None)
        elif mn:
            cur = None   # only the longword part at the start of a table

for it in range(6):
    known = {nm: v[0] for nm, v in names.items()}
    new = 0
    for tname, rel, entries in tables:
        if len(entries) < 2: continue
        starts = collections.Counter()
        for j, e in enumerate(entries):
            if e in known:
                for r, t in relocs.items():
                    if t == known[e] and r >= tlen:
                        starts[r - 4 * j] += 1
        if not starts: continue
        start, cnt = starts.most_common(1)[0]
        if cnt < 2: continue
        if tname not in names:
            names[tname] = (start, cnt, cnt); new += 1
            files_of_tables = rel
        for j, e in enumerate(entries):
            if e and e not in names and (start + 4 * j) in relocs:
                names[e] = (relocs[start + 4 * j], cnt, cnt); new += 1
    if not new: break

files_of = {r[0]: r[1] for r in routines}
for tname, rel, entries in tables:
    files_of.setdefault(tname, rel)
    for e in entries:
        if e and '.' in e: files_of.setdefault(e, rel)
files_of.update(data_labels)
# address -> name (unique)
by_addr = collections.defaultdict(list)
for nm, (addr, n, total) in names.items():
    by_addr[addr].append((n, nm))
# one name per address: the one with the most votes
for addr in list(by_addr):
    by_addr[addr] = sorted(by_addr[addr], reverse=True)
with open(out_path, 'w') as f:
    f.write('# Address\tLabel of the disassembly\tName in the original source\tFile\tVotes\n')
    for addr in sorted(by_addr):
        for n, nm in sorted(by_addr[addr], reverse=True):
            sec = 'T' if addr < 0x1dc94 else 'D' if addr < 0x1dc94 + 0x37edc else 'B'
            f.write('%05x\t%s_%05x\t%s\t%s\t%d\n' % (addr, sec, addr, nm, files_of.get(nm, ''), n))
print('routines', len(routines), dict(stats), 'names', len(names), 'addresses', len(by_addr), 'constants', len(consts))
