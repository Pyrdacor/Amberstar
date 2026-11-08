# Finds the address registers which point to character data (the structure of CHARDATA.nnn in OFFSETS.ASM, which the
# monsters use as well) and writes the accesses to the fields with the names of OFFSETS.ASM.
#
# A forward data flow analysis over the code of the program: the type of each address register (character data,
# the table of the pointers to the character data of the party, unknown) is followed through branches, calls, copies
# and the stack (movem, move to -(a7)). Only accesses whose register has the type on every path are named.
#
# Pointers to character data come from:
#   movea.l Current_active_char_data / Current_inventory_chardat_ptr / Dialogue_chard_ptr,an
#   an entry of the table Chard_ptrs (lea Chard_ptrs,am / movea.l d(am,...),an)
#   movea.l $c(am),an in the combat module (the data pointer of an action or participant, see Docs/Combat.md of
#   Amberstar.net)
#
# python structs.py <code.tsv of the disassembly without names> <SYMBOLS.txt> <OFFSETS.ASM> <constants.i> <out.tsv>
import sys, re, collections, os

code_tsv, symbols_path, offsets_path, constants_path, out_path = sys.argv[1:6]

# ------------------------------------------------------------------ fields of the character data
fields = []   # (offset, size, name)
pos = None
for l in open(offsets_path, encoding='latin-1'):
    s = l.split(';')[0].rstrip()
    if '.ABS' in s:
        if pos is not None: break   # only the first structure (CHARDATA.nnn)
        pos = 0; continue
    if pos is None: continue
    m = re.match(r'^(?:([A-Za-z_]\w*):)?\s*\.DS\.([bwl])\s+(\d+)', s.strip())
    if not m: continue
    size = {'b': 1, 'w': 2, 'l': 4}[m.group(2)] * int(m.group(3))
    if m.group(1): fields.append((pos, size, m.group(1)))
    pos += size
char_size = pos
consts = {}
for l in open(constants_path, encoding='latin-1'):
    c = l.split('\t')
    if len(c) >= 3 and c[1] == 'equ':
        try: consts[c[0]] = int(c[2].strip().lstrip('$'), 16 if c[2].strip().startswith('$') else 10)
        except ValueError: pass

def field_expr(off):
    # name of the field (+ offset inside it), only names which the constants define with the same value
    for fo, fs, fn in fields:
        if fo <= off < fo + fs:
            if consts.get(fn) != fo: return None
            return fn if off == fo else '%s+%d' % (fn, off - fo)
    return None

# ------------------------------------------------------------------ symbols and code
sym = {}
for l in open(symbols_path):
    c = l.rstrip('\n').split('\t')
    if len(c) > 2 and re.fullmatch(r'[0-9a-f]+', c[0]): sym.setdefault(c[2], int(c[0], 16))
CHAR_VARS = {sym[n] for n in ('Current_active_char_data', 'Current_inventory_chardat_ptr', 'Dialogue_chard_ptr') if n in sym}
TABLE = sym.get('Chard_ptrs')
combat_lo, combat_hi = sym['Combat_ModInit'], sym['Coso_player']

code = []
for l in open(code_tsv, encoding='latin-1'):
    if not l.strip(): continue
    a, t = l.rstrip('\n').split('\t', 1)
    p = t.split('\t', 1)
    code.append((int(a, 16), p[0], p[1] if len(p) > 1 else ''))
index = {a: k for k, (a, _, _) in enumerate(code)}

def split_ops(ops):
    out, depth, cur = [], 0, ''
    for ch in ops:
        if ch == '(': depth += 1
        elif ch == ')': depth -= 1
        if ch == ',' and depth == 0: out.append(cur); cur = ''
        else: cur += ch
    if cur: out.append(cur)
    return out

ADDR_NAME = re.compile(r'^[TDB]_([0-9a-f]{5})$')
def addr_of(op):
    m = ADDR_NAME.match(op)
    return int(m.group(1), 16) if m else None

AREG = re.compile(r'^a([0-7])$')
def regs_of_list(lst):
    # register list of movem (d0-d7/a0-a6) -> list of (kind, nr) in the order of memory (d0..d7, a0..a7)
    out = []
    for part in lst.split('/'):
        m = re.match(r'^([ad])(\d)(?:-([ad])(\d))?$', part)
        if not m: return None
        k1, n1 = m.group(1), int(m.group(2))
        k2, n2 = (m.group(3), int(m.group(4))) if m.group(3) else (k1, n1)
        i1, i2 = (0 if k1 == 'd' else 8) + n1, (0 if k2 == 'd' else 8) + n2
        out += list(range(i1, i2 + 1))
    return sorted(out)

BRANCH = re.compile(r'^(b(ra|sr|hi|ls|cc|cs|ne|eq|vc|vs|pl|mi|ge|lt|gt|le|hs|lo)|db\w+)(\.[sbwl])?$')
def kind(mn):
    b = mn.split('.')[0]
    if b in ('rts', 'rte', 'rtr', 'illegal'): return 'ret'
    if b == 'jmp': return 'jmp'
    if b in ('bra',): return 'jmp'
    if b in ('bsr', 'jsr'): return 'call'
    if BRANCH.match(mn): return 'cond'
    return 'op'

def successor(k):
    return code[k + 1][0] if k + 1 < len(code) else None

# addresses which are reached in other ways than by direct branches (pointers in the data, lea, pea, move #, tables)
indirect = set()
for a, mn, ops in code:
    if kind(mn) in ('jmp', 'call', 'cond'): continue
    for name in re.findall(r'\bT_([0-9a-f]{5})\b', ops):
        indirect.add(int(name, 16))
import struct as st
prg = open(sys.argv[6], 'rb').read() if len(sys.argv) > 6 else None
if prg:
    _, tlen, dlen = st.unpack('>HII', prg[:10])
    img = prg[28:28 + tlen + dlen]
    p = 28 + tlen + dlen + st.unpack('>I', prg[14:18])[0]
    first = st.unpack('>I', prg[p:p + 4])[0]
    relocs = []
    if first:
        r = first; relocs.append(r); p += 4
        while True:
            c = prg[p]; p += 1
            if c == 0: break
            if c == 1: r += 254; continue
            r += c; relocs.append(r)
    # extents of the instructions: relocated longwords inside an instruction are its operands (found above), the
    # others are pointers (tables in the text and in the data)
    from capstone import Cs, CS_ARCH_M68K, CS_MODE_BIG_ENDIAN, CS_MODE_M68K_000
    md = Cs(CS_ARCH_M68K, CS_MODE_BIG_ENDIAN | CS_MODE_M68K_000)
    in_instr = set()
    for a, _, _ in code:
        for i in md.disasm(img[a:a + 10], a, 1):
            in_instr.update(range(a + 2, a + i.size))
    for r in relocs:
        t = st.unpack('>I', img[r:r + 4])[0]
        if t < tlen and r not in in_instr: indirect.add(t)

def target(ops):
    return addr_of(split_ops(ops)[-1]) if ops else None

# ------------------------------------------------------------------ registers which a routine changes
written_cache = {}
def written_regs(k):
    # address registers which the instruction changes (a7 excluded)
    a, mn, ops = code[k]
    b = mn.split('.')[0]
    out = set()
    o = split_ops(ops)
    for x in o:
        m = re.match(r'^-?\(a([0-6])\)\+?$', x)
        if m and (x.startswith('-(') or x.endswith('+')): out.add(int(m.group(1)))
    if o:
        m = AREG.match(o[-1])
        if m and b not in ('cmpa', 'cmp', 'tst', 'btst', 'pea', 'jmp', 'jsr') and int(m.group(1)) < 7: out.add(int(m.group(1)))
        if b == 'exg':
            for x in o:
                m = AREG.match(x)
                if m and int(m.group(1)) < 7: out.add(int(m.group(1)))
    if b == 'movem' and len(o) == 2 and not o[1].startswith('-('):
        rl = regs_of_list(o[1])
        if rl: out.update(r - 8 for r in rl if 8 <= r < 15)
    return out

ALL = set(range(7))
def routine_reach(entry):
    seen, todo, calls, indirect_call = set(), [entry], set(), False
    while todo:
        a = todo.pop()
        if a in seen or a not in index: continue
        seen.add(a)
        k = index[a]
        mn, ops = code[k][1], code[k][2]
        kd = kind(mn)
        t = target(ops)
        if kd == 'ret': continue
        if kd == 'jmp':
            if t is not None: todo.append(t)
            else: indirect_call = True
            continue
        if kd == 'call':
            if t is not None: calls.add(t)
            else: indirect_call = True
        if kd == 'cond' and t is not None: todo.append(t)
        s = successor(k)
        if s is not None: todo.append(s)
    return seen, calls, indirect_call

entries = set()
for a, mn, ops in code:
    if kind(mn) == 'call' and target(ops) is not None: entries.add(target(ops))
reach = {e: routine_reach(e) for e in entries if e in index}
saved = {}
for e in reach:
    a, mn, ops = code[index[e]]
    o = split_ops(ops)
    rl = regs_of_list(o[0]) if mn.startswith('movem') and len(o) == 2 and o[1] == '-(a7)' else None
    saved[e] = {r - 8 for r in rl if 8 <= r < 15} if rl else set()
clobbers = {}
for e, (seen, calls, ind) in reach.items():
    w = set()
    for a in seen: w |= written_regs(index[a])
    if ind: w |= ALL
    clobbers[e] = w - saved[e]
changed = True
while changed:
    changed = False
    for e, (seen, calls, ind) in reach.items():
        w = set(clobbers[e])
        for c in calls: w |= clobbers.get(c, ALL)
        w -= saved[e]
        if w != clobbers[e]: clobbers[e] = w; changed = True

# ------------------------------------------------------------------ data flow
UNK, CHAR, TAB = 'U', 'C', 'T'
def meet_t(x, y):
    if x is None: return y
    if y is None: return x
    return x if x == y else UNK
def meet(s1, s2):
    if s1 is None: return s2
    if s2 is None: return s1
    regs = tuple(meet_t(x, y) for x, y in zip(s1[0], s2[0]))
    stack = s1[1] if s1[1] == s2[1] else 'X'
    return (regs, stack)
TOP = (tuple([UNK] * 7), ())   # the stack is followed relative to the entry of a routine

def push(stack, items):
    return 'X' if stack == 'X' else stack + tuple(items)
def pop(stack, n_bytes):
    # returns (items, stack) - items are the slots, None if unknown
    if stack == 'X': return None, 'X'
    items, s = [], list(stack)
    while n_bytes > 0:
        if not s: return None, 'X'
        x = s.pop()
        sz = 2 if x == 'W' else 4
        if sz > n_bytes: return None, 'X'
        items.append(x); n_bytes -= sz
    return items, tuple(s)

def src_type(regs, op, combat):
    m = AREG.match(op)
    if m: return regs[int(m.group(1))] if int(m.group(1)) < 7 else UNK
    a = addr_of(op)
    if a is not None and a in CHAR_VARS: return CHAR
    m = re.match(r'^(-?\$[0-9a-f]+)?\(a([0-6])(,[ad]\d\.[wl])?\)\+?$', op)
    if m:
        base = regs[int(m.group(2))]
        if base == TAB: return CHAR
        if combat and m.group(1) == '$c' and not m.group(3): return CHAR
    return UNK

def transfer(k, state):
    regs, stack = list(state[0]), state[1]
    a, mn, ops = code[k]
    b = mn.split('.')[0]
    sz = mn.split('.')[1] if '.' in mn else ''
    o = split_ops(ops)
    combat = combat_lo <= a < combat_hi
    # stack
    if b == 'movem' and len(o) == 2:
        if o[1] == '-(a7)':
            rl = regs_of_list(o[0])
            if rl is None: stack = 'X'
            else:
                # the first register of the list ends at the lowest address (the top of the stack)
                slots = []
                for r in reversed(rl):
                    if sz != 'l': slots.append('W')
                    else: slots.append(regs[r - 8] if 8 <= r < 15 else UNK)
                stack = push(stack, slots)
            return (tuple(regs), stack)
        if o[0] in ('(a7)+', '(a7)'):
            rl = regs_of_list(o[1])
            n = 4 if sz == 'l' else 2
            if rl is None: return TOP
            items, new_stack = pop(stack, n * len(rl))
            # the first register of the list is at the lowest address (the top of the stack)
            for j, r in enumerate(rl):
                if 8 <= r < 15:
                    regs[r - 8] = items[j] if items is not None and n == 4 and items[j] in (UNK, CHAR, TAB) else UNK
            if o[0] == '(a7)+': stack = new_stack
            return (tuple(regs), stack)
    if len(o) == 2 and o[1] == '-(a7)':
        m = AREG.match(o[0])
        t = regs[int(m.group(1))] if m and int(m.group(1)) < 7 else UNK
        stack = push(stack, ['W'] if sz == 'w' else [t])
    elif b == 'pea':
        stack = push(stack, [UNK])
    elif len(o) >= 1 and o[0] == '(a7)+':
        items, stack = pop(stack, 2 if sz == 'w' else 4)
        if len(o) == 2 and AREG.match(o[1]) and int(o[1][1]) < 7:
            regs[int(o[1][1])] = items[0] if items and items[0] in (CHAR, TAB, UNK) else UNK
            return (tuple(regs), stack)
    elif len(o) == 2 and o[1] == 'a7':
        m = re.match(r'^#\$?([0-9a-f]+)$', o[0])
        if b in ('addq', 'adda') and m:
            _, stack = pop(stack, int(m.group(1), 16) if '$' in o[0] else int(m.group(1)))
        else: stack = 'X'
    elif b == 'lea' and len(o) == 2 and o[1] == 'a7':
        stack = 'X'
    # registers
    if b == 'exg' and len(o) == 2 and AREG.match(o[0]) and AREG.match(o[1]):
        x, y = int(o[0][1]), int(o[1][1])
        if x < 7 and y < 7: regs[x], regs[y] = regs[y], regs[x]
        return (tuple(regs), stack)
    new = {}
    if b in ('movea', 'move') and len(o) == 2 and AREG.match(o[1]) and sz == 'l':
        new[int(o[1][1])] = src_type(regs, o[0], combat)
    elif b == 'lea' and len(o) == 2 and AREG.match(o[1]):
        if addr_of(o[0]) is not None and addr_of(o[0]) == TABLE: new[int(o[1][1])] = TAB
        elif re.match(r'^\(a[0-6]\)$', o[0]): new[int(o[1][1])] = regs[int(o[0][2])]
        else: new[int(o[1][1])] = UNK
    elif b in ('adda', 'suba', 'addq', 'subq', 'addi', 'subi') and len(o) == 2 and AREG.match(o[1]):
        r = int(o[1][1])
        if r < 7: new[r] = TAB if regs[r] == TAB else UNK
    for r in written_regs(k):
        if r not in new:
            # (an)+ / -(an) of the table stays in the table
            new[r] = TAB if regs[r] == TAB and any(x in ('(a%d)+' % r, '-(a%d)' % r) for x in o) else UNK
    for r, t in new.items():
        if r < 7: regs[r] = t
    return (tuple(regs), stack)

state_in = {}
work = []
for a in indirect | entries:
    pass
TRACE = {int(x, 16) for x in os.environ.get('TRACE', '').split(',') if x}
cur_src = [None]
def add(a, s):
    if a not in index: return
    if a in TRACE: print('to %x from %s: %s' % (a, cur_src[0], s))
    old = state_in.get(a)
    new = meet(old, s)
    if new != old:
        state_in[a] = new
        work.append(a)
# unknown entries: pointers and the start of the program
for a in indirect: add(a, TOP)
add(code[0][0], TOP)
# routines which are only called are analysed from their calls (their entry state is the meet of the calls)
while work:
    a = work.pop()
    cur_src[0] = '%x' % a
    k = index[a]
    s = state_in[a]
    mn, ops = code[k][1], code[k][2]
    kd = kind(mn)
    t = target(ops)
    if kd == 'ret': continue
    if kd == 'jmp':
        # bra stays in the routine (the stack is kept), jmp to a label is a tail call (a routine of its own)
        if t is not None: add(t, transfer(k, s) if mn.startswith('bra') else (transfer(k, s)[0], ()))
        continue
    out = transfer(k, s)
    if kd == 'call':
        if t is not None:
            add(t, (s[0], ()))   # the callee starts with an empty stack of its own
            cl = clobbers.get(t, ALL)
        else:
            cl = ALL
        out = (tuple(UNK if r in cl else x for r, x in enumerate(s[0])), s[1])
    if kd == 'cond' and t is not None: add(t, out)
    nxt = successor(k)
    if nxt is not None: add(nxt, out)

# code which is reached by nothing that the analysis knows (e.g. behind a jump table) stays unknown
# ------------------------------------------------------------------ named accesses
FIELD_OP = re.compile(r'(?<![\w$-])(\$[0-9a-f]+)\(a([0-6])(?=[,)])')
out = []
counts = collections.Counter()
for a, mn, ops in code:
    s = state_in.get(a)
    if s is None: continue
    if mn.startswith('movem') and False: pass
    for m in FIELD_OP.finditer(ops):
        r = int(m.group(2))
        if s[0][r] != CHAR: continue
        off = int(m.group(1)[1:], 16)
        if off >= char_size: counts['beyond'] += 1; continue
        fe = field_expr(off)
        if fe is None: counts['no name'] += 1; continue
        # lea computes the base of an array, often in front of a field for an index which starts at 1 (the original
        # writes Inventory_1_place_counter-1(a0) or Inv_data+320(a0)), so only the start of an array is named
        if mn.startswith('lea') and not any(fo == off and fs > 4 for fo, fs, fn in fields):
            counts['lea'] += 1; continue
        out.append('%x\t%s(a%d\t%s(a%d' % (a, m.group(1), r, fe, r))
        counts['combat' if combat_lo <= a < combat_hi else 'other'] += 1
import os
if os.environ.get('DEBUG'):
    st_c = collections.Counter()
    per_routine = collections.Counter()
    names_by_addr = {}
    for l in open(symbols_path):
        c = l.rstrip('\n').split('\t')
        if len(c) > 2 and re.fullmatch(r'[0-9a-f]+', c[0]): names_by_addr.setdefault(int(c[0], 16), c[2])
    for a0_, mn_, ops_ in code:
        if combat_lo <= a0_ < combat_hi and a0_ in indirect | entries: names_by_addr.setdefault(a0_, 'T_%05x' % a0_)
    for a, mn, ops in code:
        if not (combat_lo <= a < combat_hi): continue
        s = state_in.get(a)
        for m in FIELD_OP.finditer(ops):
            r = int(m.group(2))
            st_c['unreached' if s is None else s[0][r]] += 1
            if s is not None and s[0][r] == UNK:
                rn = max((x for x in names_by_addr if x <= a), default=0)
                per_routine[(names_by_addr.get(rn, '?'), 'a%d' % r)] += 1
    for (rn, r), n in per_routine.most_common(25): print('  ', rn, r, n)
    print('combat accesses by register state', dict(st_c))
open(out_path, 'w').write('\n'.join(out) + '\n')
print('named accesses', dict(counts), 'size of the character data', char_size)
