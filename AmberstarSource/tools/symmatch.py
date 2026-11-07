# Finds the names of the original source for the labels of the disassembly.
# The routines of the original source are aligned with the code of the disassembly. Aligned instructions give
# the names of their operands (routines, variables, data).
import sys, os
os.environ['AMBERSTAR_SRC'] = sys.argv[1]
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from origsrc import *
import re, difflib, collections, struct
src_dir, code_tsv, out_path = sys.argv[1], sys.argv[2], sys.argv[3]

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
# ------------------------------------------------------------------ program (relocations for the pointer tables)
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
reloc_by_target = collections.defaultdict(list)
for r, t in relocs.items():
    if r >= tlen: reloc_by_target[t].append(r)

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

# texts of the local labels of the tables (e.g. Camp_Mod.ID = "Camp screen.")
local_texts = {}
for f, lines in raw.items():
    glob_label = None
    for l in lines:
        pl = parse_line(l)
        if not pl: continue
        label, mn, ops = pl
        if label and not label.startswith('.'): glob_label = label
        if label and label.startswith('.') and glob_label and mn and mn.upper() == '.DC.B':
            m = re.match(r'"([^"]+)"', ops)
            if m: local_texts[glob_label + label] = m.group(1).encode('latin-1')
# entries which are in several tables (e.g. Basic_VblQ) are no anchors
entry_tables = collections.Counter(e for t in tables for e in set(t[2]) if e)

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

def named_shape(entry, known, addr_name):
    # the shape with the names of known symbols (makes short routines distinct)
    full, shape, refs = entry[-3], entry[-2], entry[-1]
    if not any(refs): return shape
    head, _, rest = shape.partition(' ')
    ops = split_ops(rest) if rest else []
    for i, r in enumerate(refs):
        if r is None or i >= len(ops) or not ops[i].lstrip('#').startswith('S'): continue
        nm = None
        if r[0] == 'name' and r[1] in known and r[2] == 0: nm = r[1]
        elif r[0] == 'addr' and r[1] in addr_name: nm = addr_name[r[1]]
        if nm: ops[i] = ops[i].replace('S', 'S:' + nm, 1)
    return head + ' ' + ','.join(ops)

K = 4
def match_pass(known):
    addr_name = {}
    for nm, (addr, n, total) in known.items():
        if '.' not in nm and (addr not in addr_name or n > known[addr_name[addr]][1]): addr_name[addr] = nm
    dshapes = [named_shape(d, known, addr_name) for d in dis]
    grams = collections.defaultdict(list)
    for i in range(len(dis) - K + 1):
        grams[tuple(dshapes[i:i + K])].append(i)
    routine_addr, votes, stats = {}, collections.defaultdict(collections.Counter), collections.Counter()
    for name, rel, seq in routines:
        if len(seq) < 3:
            stats['short'] += 1; continue
        shapes = [named_shape(s, known, addr_name) for s in seq]
        cand = collections.Counter()
        for j in range(len(shapes) - K + 1):
            hits = grams.get(tuple(shapes[j:j + K]), [])
            if 0 < len(hits) <= 8:
                for h in hits: cand[h - j] += 1
        if not cand:
            stats['nocand'] += 1; continue
        best = None
        for start, cnt in cand.most_common(4):
            lo = max(0, start - 8); hi = min(len(dis), start + len(seq) + 16)
            sm = difflib.SequenceMatcher(None, shapes, dshapes[lo:hi], autojunk=False)
            blocks = sm.get_matching_blocks()
            score = sum(b.size for b in blocks) / len(seq)
            if best is None or score > best[0]:
                best = (score, lo, blocks)
        score, lo, blocks = best
        if score < 0.75:
            stats['weak'] += 1; continue
        stats['matched'] += 1
        b0 = blocks[0]
        if score >= 0.9 and b0.a == 0 and b0.size >= 3 and len(seq) >= 6:
            routine_addr[name] = dis[lo + b0.b][0]
        for b in blocks:
            if b.size < 3: continue
            for k in range(b.size):
                o = seq[b.a + k]; d = dis[lo + b.b + k]
                if not tok_eq(o[0], d[1]): continue
                for ro, rd in zip(o[2], d[3]):
                    if ro and rd and ro[0] == 'name' and rd[0] == 'addr' and not ro[1].startswith('.'):
                        votes[ro[1]][rd[1] - ro[2]] += 1
    names = {}
    for nm, c in votes.items():
        addr, n = c.most_common(1)[0]
        total = sum(c.values())
        if n >= 2 and n / total >= 0.75:
            names[nm] = (addr, n, total)
    for nm, addr in routine_addr.items():
        if nm not in names:
            names[nm] = (addr, 0, 0)
    # pointer tables
    for it in range(6):
        new = 0
        for tname, rel, entries in tables:
            if len(entries) < 2: continue
            starts = collections.Counter()
            for j, e in enumerate(entries):
                if e in names and entry_tables[e] == 1:
                    for r in reloc_by_target.get(names[e][0], []):
                        starts[r - 4 * j] += 1
            # a text of the table (e.g. the ID of a module) is a strong anchor
            for j, e in enumerate(entries):
                if e in local_texts:
                    txt = local_texts[e]
                    pos = img.find(txt + b'\0', tlen)
                    while pos >= 0:
                        for r in reloc_by_target.get(pos, []):
                            starts[r - 4 * j] += 2
                        pos = img.find(txt + b'\0', pos + 1)
            if not starts: continue
            start, cnt = starts.most_common(1)[0]
            if cnt < 2: continue
            if tname not in names:
                names[tname] = (start, cnt, cnt); new += 1
            for j, e in enumerate(entries):
                if e and e not in names and (start + 4 * j) in relocs:
                    names[e] = (relocs[start + 4 * j], cnt, cnt); new += 1
        if not new: break
    return names, stats

names, stats = match_pass({})
for pass_nr in range(2, 6):
    before = len(names)
    names, stats = match_pass(names)
    print('pass', pass_nr, 'names', len(names), dict(stats))
    if len(names) <= before: break

files_of = {r[0]: r[1] for r in routines}
for tname, rel, entries in tables:
    files_of.setdefault(tname, rel)
    for e in entries:
        if e and '.' in e: files_of.setdefault(e, rel)
files_of.update(data_labels)
by_addr = collections.defaultdict(list)
for nm, (addr, n, total) in names.items():
    by_addr[addr].append((n, nm))
with open(out_path, 'w') as f:
    f.write('# Address\tLabel of the disassembly\tName in the original source\tFile\tVotes\n')
    for addr in sorted(by_addr):
        for n, nm in sorted(by_addr[addr], reverse=True):
            sec = 'T' if addr < tlen else 'D' if addr < tlen + dlen else 'B'
            f.write('%05x\t%s_%05x\t%s\t%s\t%d\n' % (addr, sec, addr, nm, files_of.get(nm, ''), n))
print('routines', len(routines), dict(stats), 'names', len(names), 'addresses', len(by_addr), 'constants', len(consts))
