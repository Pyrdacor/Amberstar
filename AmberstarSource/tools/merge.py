# Checks which routines of the original source assemble to the same bytes as the shipped program.
# Each routine is converted to vasm syntax and assembled at its address with all known names as constants.
import sys, os, re, subprocess, struct, json, tempfile, collections
os.environ['AMBERSTAR_SRC'] = sys.argv[1]
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from origsrc import *

src_dir, prg_path, symbols_path, vasm, out_json = sys.argv[1:6]

prg = open(prg_path, 'rb').read()
_, tlen, dlen, blen = struct.unpack('>HIII', prg[:14])
img = prg[28:28 + tlen + dlen]

sym = {}
for l in open(symbols_path):
    if l.startswith('#') or not l.strip(): continue
    c = l.rstrip('\n').split('\t')
    sym.setdefault(c[2], int(c[0], 16))

# ------------------------------------------------------------------ conversion to vasm syntax
DIRECTIVES = {'.DC.B': 'dc.b', '.DC.W': 'dc.w', '.DC.L': 'dc.l', '.DS.B': 'ds.b', '.DS.W': 'ds.w', '.DS.L': 'ds.l',
              '.EVEN': 'even'}
IGNORE = {'.TEXT', '.DATA', '.BSS', '.LOCAL', '.XDEF', '.XREF', '.GLOBL', '.END', '.SECTION', '.INCLUDE', '.ABS'}

current_addr = 0

def convert_instr(mn, ops):
    up = mn.upper()
    # The assembler of the shipped program turned jsr/jmp into bsr.w/bra.w if the target is in the text and in reach
    if up in ('JSR', 'JMP') and re.fullmatch(r'[A-Za-z_.][\w.]*', ops.strip()):
        target = ops.strip()
        t = sym.get(target)
        if target.startswith('.') or (t is not None and t < tlen and abs(t - current_addr) < 32768 - 1024):
            return '\t%s\t%s' % ('bsr.w' if up == 'JSR' else 'bra.w', target)
    # branches without a size were made short by the original assembler where possible (see assemble)
    if re.fullmatch(r'(bra|bsr|b(hi|ls|cc|cs|ne|eq|vc|vs|pl|mi|ge|lt|gt|le|hs|lo))', mn, re.I):
        return '\t%s.s\t%s	;AUTOSIZE' % (mn, ops)
    if up in DIRECTIVES: return '\t%s\t%s' % (DIRECTIVES[up], ops)
    if up in IGNORE: return None
    if up.startswith('.'): return '; ' + mn + ' ' + ops
    return '\t%s\t%s' % (mn, ops)

def convert_lines(lines):
    out = []
    wait_count = 0
    for l in lines:
        p = parse_line(l)
        if not p:
            continue
        label, mn, ops = p
        if label:
            out.append(label + ':')
        if not mn: continue
        ex = expand(mn, ops)
        if ex is not None:
            for emn, eops in ex:
                if eops == '*':
                    # the loop of Wait_4_unclick
                    out[-1:] = []
                    wait_count += 1
                    out.append('.Wait_%d:' % wait_count)
                    out.append('\tbtst\t#1,Mouse_button_state')
                    out.append('\tbne.s\t.Wait_%d' % wait_count)
                    continue
                c = convert_instr(emn, eops)
                if c is not None: out.append(c)
            continue
        c = convert_instr(mn, ops)
        if c is not None: out.append(c)
    return out

# ------------------------------------------------------------------ raw line ranges of the routines
routine_lines = {}   # name -> (file, [lines])
for f, lines in raw.items():
    rel = os.path.relpath(f, src_dir).replace('\\', '/')
    section, cur = 'text', None
    for l in lines:
        p = parse_line(l)
        if p:
            label, mn, ops = p
            if mn and mn.upper() == '.TEXT': section = 'text'
            elif mn and mn.upper() in ('.DATA', '.BSS', '.ABS'): section = 'other'; cur = None
            if label and not label.startswith('.') and section == 'text' and (mn is None or not mn.startswith('.')) and mn != '=' and (mn or '').upper() not in ('EQU', 'SET'):
                cur = label
                routine_lines[cur] = (rel, [])
        if cur and section == 'text':
            routine_lines[cur][1].append(l)

# ------------------------------------------------------------------ assemble each routine at its address
tmp = tempfile.mkdtemp()
SP = os.path.join(tmp, 'r.s'); BP = os.path.join(tmp, 'r.bin')
UNDEF = re.compile(r'undefined symbol <([A-Za-z_][\w.]*)>')

def equates_for(sym, skip):
    eq = []
    for nm, v in consts.items():
        if nm not in sym and nm != skip and re.fullmatch(r'[A-Za-z_]\w*', nm):
            eq.append('%s\tequ\t%d' % (nm, v))
    for nm, a in sym.items():
        if nm != skip and re.fullmatch(r'[A-Za-z_]\w*', nm):
            eq.append('%s\tequ\t$%x' % (nm, a))
    return eq

import hashlib, pickle, atexit
# Results of vasm by source text. Only the names which the routine uses are defined, so the source of a routine stays
# the same while other names are found, and the rounds (and later runs) take the results from the cache.
CACHE_PATH = os.path.join(os.path.dirname(os.path.abspath(out_json)), 'vasm.cache')   # shared by both versions
try:
    asm_cache = pickle.load(open(CACHE_PATH, 'rb'))
except Exception:
    asm_cache = {}
cache_stats = collections.Counter()
def save_cache():
    pickle.dump(asm_cache, open(CACHE_PATH, 'wb'))
atexit.register(save_cache)
WORD = re.compile(r'[A-Za-z_]\w*')

def assemble(addr, body, eq):
    used = set(WORD.findall('\n'.join(body)))
    eq = [e for e in eq if e.split('\t', 1)[0] in used]
    src = '\n'.join(eq) + '\n\torg\t$%x\n' % addr + '\n'.join(body) + '\n'
    key = hashlib.sha1(src.encode('latin-1', 'replace')).digest()
    if key in asm_cache:
        cache_stats['hit'] += 1
        return asm_cache[key]
    cache_stats['vasm'] += 1
    result = assemble_vasm(src)
    if not (result[2] or '').endswith('vasm did not end'):
        asm_cache[key] = result
    return result

def assemble_vasm(src):
    for attempt in range(8):
        open(SP, 'w', encoding='latin-1').write(src)
        if os.path.exists(BP): os.remove(BP)
        try:
            r = subprocess.run([vasm, '-quiet', '-m68000', '-Fbin', '-no-opt', '-nowarn=62', '-o', BP, SP], capture_output=True, text=True, encoding='latin-1', timeout=20)
        except subprocess.TimeoutExpired:
            # (it happened once that vasm did not end)
            open(SP + '.hang', 'w', encoding='latin-1').write(src)
            return None, src, 'error: vasm did not end'
        out = r.stdout + r.stderr
        # short branches which don't reach their target become word branches
        far = [int(m.group(1)) for m in re.finditer(r'in line (\d+) of "[^"]*": (?:branch destination )?out of range', out)]
        if not far: break
        src_lines = src.split('\n')
        for ln in set(far):
            if 0 < ln <= len(src_lines) and ';AUTOSIZE' in src_lines[ln - 1]:
                src_lines[ln - 1] = src_lines[ln - 1].replace('.s\t', '.w\t', 1).replace(';AUTOSIZE', ';SIZED')
        new_src = '\n'.join(src_lines)
        if new_src == src: break
        src = new_src
    if r.returncode != 0 or not os.path.exists(BP):
        return None, src, out
    b = open(BP, 'rb').read()
    os.remove(BP)
    return b, src, out

MARKER = 0x00e00000

def check_all(sym, only=None):
    results, votes, counts = {}, collections.defaultdict(collections.Counter), collections.Counter()
    global current_addr
    for nm, (rel, lines) in sorted(routine_lines.items()):
        if only and nm != only: continue
        if nm not in sym or sym[nm] >= tlen:
            counts['no address'] += 1; continue
        addr = sym[nm]
        current_addr = addr
        body = convert_lines(lines)
        eq = equates_for(sym, nm)
        b, src, out = assemble(addr, body, eq)
        if b is None:
            undefined = sorted(set(UNDEF.findall(out)))
            other = [x for x in out.splitlines() if 'error' in x and 'undefined symbol' not in x]
            results[nm] = {'file': rel, 'addr': addr, 'state': 'error', 'error': (other or [x for x in out.splitlines() if 'error' in x] or [''])[0][:200], 'undefined': undefined}
            counts['error'] += 1
            # unknown names get marker values; if everything else matches, the program gives their addresses
            if undefined and not other:
                markers = {u: MARKER + k * 0x1000 for k, u in enumerate(undefined)}
                bm, _, _ = assemble(addr, body, eq + ['%s\tequ\t$%x' % (u, v) for u, v in markers.items()])
                if bm is not None and len(bm) <= len(img) - addr:
                    prog = img[addr:addr + len(bm)]
                    marked = set()
                    found = []
                    for o in range(0, len(bm) - 3):
                        v = struct.unpack('>I', bm[o:o + 4])[0]
                        for u, mv in markers.items():
                            if mv <= v < mv + 0x1000:
                                found.append((u, v - mv, struct.unpack('>I', prog[o:o + 4])[0]))
                                marked.update(range(o, o + 4))
                    if found and all(bm[o] == prog[o] for o in range(len(bm)) if o not in marked):
                        for u, offset, real in found:
                            votes[u][real - offset] += 1
            continue
        if only:
            from capstone import Cs, CS_ARCH_M68K, CS_MODE_BIG_ENDIAN, CS_MODE_M68K_000
            md = Cs(CS_ARCH_M68K, CS_MODE_BIG_ENDIAN | CS_MODE_M68K_000)
            mine = list(md.disasm(b, addr)); prog = list(md.disasm(img[addr:addr + len(b) + 8], addr))
            for k in range(max(len(mine), len(prog))):
                x = mine[k] if k < len(mine) else None; y = prog[k] if k < len(prog) else None
                fx = '%x %s %s' % (x.address, x.mnemonic, x.op_str) if x else ''
                fy = '%x %s %s' % (y.address, y.mnemonic, y.op_str) if y else ''
                print(('   ' if fx == fy else '>> ') + fx.ljust(50) + fy)
            print('\n'.join(body))
        same = img[addr:addr + len(b)] == b
        diff = None if same else next(i for i in range(len(b)) if addr + i >= len(img) or img[addr + i] != b[i])
        final = src.split('\n\torg\t', 1)[1].split('\n', 1)[1].rstrip('\n').split('\n') if same else None
        if final: final = [re.sub(r'\s*;(AUTOSIZE|SIZED)$', '', x) for x in final]
        results[nm] = {'file': rel, 'addr': addr, 'size': len(b), 'state': 'same' if same else 'different', 'first_diff': diff, 'source': final}
        counts['same' if same else 'different'] += 1
    return results, votes, counts

# ------------------------------------------------------------------ routines which differ: merged with the program
# The instructions of the original routine are aligned with the instructions of the program. Equal instructions keep
# the original line, the others take the instruction of the program with a comment.
import difflib
prog = []
prog_index = {}
if len(sys.argv) > 7:
    plain_tsv, named_tsv = sys.argv[6], sys.argv[7]
    prog = []   # (addr, size, full, shape, refs, named text)
    plain = [l.rstrip('\n').split('\t', 1) for l in open(plain_tsv, encoding='latin-1') if l.strip()]
    named = [l.rstrip('\n').split('\t', 1) for l in open(named_tsv, encoding='latin-1') if l.strip()]
    for (a, t), (_, nt) in zip(plain, named):
        parts = t.split('\t', 1)
        mn, ops = parts[0], parts[1] if len(parts) > 1 else ''
        if mn.startswith('dc.'): full, shape, refs = 'dc', 'dc', []
        else: full, shape, refs = norm_instr(mn, ops, 'd')
        prog.append([int(a, 16), 0, full, shape, refs, nt])
    for k in range(len(prog) - 1): prog[k][1] = prog[k + 1][0] - prog[k][0]
    prog_index = {p[0]: k for k, p in enumerate(prog)}

    def source_items(lines):
        # (kind, text, normalized, source line) for labels and instructions; macros are expanded
        items = []
        for l in lines:
            pl = parse_line(l)
            if not pl: continue
            label, mn, ops = pl
            if label: items.append(('label', label, None, l))
            if not mn: continue
            ex = expand(mn, ops)
            if ex is not None:
                for emn, eops in ex:
                    if eops == '*': eops = '.wait_loop'
                    items.append(('ins', '%s\t%s' % (emn, eops), norm_instr(emn, eops, 'o'), l.strip()))
                continue
            up = mn.upper()
            if up in DIRECTIVES or up.startswith('.') or not re.fullmatch(r'[A-Za-z]+(\.[bwlsBWLS])?', mn): continue
            items.append(('ins', '%s\t%s' % (mn, ops), norm_instr(mn, ops, 'o'), l.strip()))
        return items

    def refs_equal(oref, pref, ptext=''):
        for ro, rp in zip(oref, pref):
            if (ro is None) != (rp is None): return False
            if ro is None: continue
            if ro[0] != 'name' or rp[0] != 'addr': return False
            if ro[1].startswith('.'): continue   # local label (checked by the assembler)
            if ro[1] in sym:
                if sym[ro[1]] + ro[2] != rp[1]: return False
            elif not re.search(r'\b%s\b' % re.escape(ro[1]), ptext):
                return False   # the name of the program line is another one
        return True

    def comment_text(s):
        return re.sub(r'\s+', ' ', s.split(';')[0]).strip()


def refine_one(nm, v, rcounts):
    global current_addr
    rel, lines = routine_lines[nm]
    addr = v['addr']
    if addr not in prog_index: rcounts['no code'] += 1; return False
    items = source_items(lines)
    ins = [it for it in items if it[0] == 'ins']
    if not ins: return False
    start = prog_index[addr]
    window = prog[start:start + len(ins) * 2 + 40]
    sm = difflib.SequenceMatcher(None, [i[2][1] for i in ins], [p[3] for p in window], autojunk=False)
    ops_list = sm.get_opcodes()
    # the routine ends behind the program instruction which is aligned with the last original instruction
    last = [op for op in ops_list if op[0] == 'equal']
    # the first instructions may differ, the end must be aligned
    # (but no additional instructions of the program before the routine, they belong to the previous routine)
    if not last or last[-1][2] != len(ins) or last[0][1] > 4 or last[0][3] > last[0][1]:
        rcounts['unaligned'] += 1; return False
    end_k = last[-1][4]
    end_addr = window[end_k - 1][0] + window[end_k - 1][1]
    # program position of every original instruction (for the labels)
    out, ins_pos = [], {}
    lines_out = []
    k_ins = 0
    changes = 0
    prog_lines = {}
    for tag, i1, i2, j1, j2 in ops_list:
        if j1 >= end_k and tag != 'delete': break
        j2 = min(j2, end_k)
        if tag == 'equal':
            for d in range(i2 - i1):
                o, p = ins[i1 + d], window[j1 + d]
                ins_pos[i1 + d] = p[0]
                if refs_equal(o[2][2], p[4], p[5]) and o[2][1] == p[3] and (o[2][0] == p[2] or '?' in o[2][0]):
                    lines_out.append((p[0], 'orig', o, p))
                else:
                    lines_out.append((p[0], 'replace', o, p)); changes += 1
        elif tag == 'replace':
            n = max(i2 - i1, j2 - j1)
            for d in range(n):
                o = ins[i1 + d] if i1 + d < i2 else None
                p = window[j1 + d] if j1 + d < j2 else None
                if p is None:
                    lines_out.append((None, 'delete', o, None))
                else:
                    if o is not None: ins_pos[i1 + d] = p[0]
                    lines_out.append((p[0], 'replace' if o else 'insert', o, p))
                changes += 1
        elif tag == 'delete':
            for d in range(i2 - i1):
                lines_out.append((None, 'delete', ins[i1 + d], None)); changes += 1
        elif tag == 'insert':
            for d in range(j2 - j1):
                p = window[j1 + d]
                lines_out.append((p[0], 'insert', None, p)); changes += 1
    # addresses of the original labels: the address of the next original instruction
    label_at = collections.defaultdict(list)
    pending = []
    idx = 0
    for it in items:
        if it[0] == 'label':
            pending.append(it[1])
        else:
            if pending:
                pos = ins_pos.get(idx)
                if pos is None:
                    later = [ins_pos[x] for x in range(idx, len(ins)) if x in ins_pos]
                    pos = later[0] if later else end_addr
                label_at[pos].extend(pending)
                pending = []
            idx += 1
    if pending: label_at[end_addr].extend(pending)
    local_of = {a: [x for x in l if x.startswith('.')] for a, l in label_at.items()}
    # program lines with branch targets inside the routine use local labels
    new_locals = {}
    def fix_targets(text):
        def repl(m):
            t = int(m.group(1), 16)
            if addr <= t < end_addr:
                if local_of.get(t): return local_of[t][0]
                new_locals[t] = '.c_%05x' % t
                return new_locals[t]
            return m.group(0)
        return re.sub(r'\bT_([0-9a-f]{5})\b', repl, text)
    body = []
    emitted_labels = set()
    def emit_labels(a):
        for lab in label_at.get(a, []):
            if lab not in emitted_labels:
                body.append(lab + ':'); emitted_labels.add(lab)
    texts = []
    for a, kind, o, p in lines_out:
        if kind == 'orig':
            txt = o[1]
            mn = txt.split('\t')[0]
            pm = p[5].split('\t')[0]
            # sizes and jsr -> bsr.w of the program
            if BRANCH.match(mn.lower().split('.')[0]) or mn.lower() in ('jsr', 'jmp'):
                if pm.split('.')[0] in ('bsr', 'bra') or BRANCH.match(pm.split('.')[0]):
                    size = pm.split('.')[1] if '.' in pm else ''
                    base = pm.split('.')[0]
                    txt = '%s%s\t%s' % (base, '.' + ('s' if size == 'b' else size) if size else '', txt.split('\t', 1)[1])
            texts.append((a, '\t' + txt))
        elif kind == 'replace':
            texts.append((a, '\t%s\t; CHANGE: was "%s"' % (fix_targets(p[5]), comment_text(o[3]))))
        elif kind == 'insert':
            texts.append((a, '\t%s\t; CHANGE: added' % fix_targets(p[5])))
        elif kind == 'delete':
            texts.append((None, '; CHANGE: removed "%s"' % comment_text(o[3])))
    for a, t in texts:
        if a is not None:
            for lab in sorted(set(label_at.get(a, []))):
                if lab not in emitted_labels:
                    body.append(lab + ':'); emitted_labels.add(lab)
            if a in new_locals and new_locals[a] not in emitted_labels:
                body.append(new_locals[a] + ':'); emitted_labels.add(new_locals[a])
        body.append(t)
    body = [l.replace('.wait_loop', '*-8') for l in body]
    # check
    current_addr = addr
    eq = equates_for(sym, nm)
    tnames = set(re.findall(r'\b[TDB]_([0-9a-f]{5})\b', '\n'.join(body)))
    eq += ['%s_%s\tequ\t$%s' % ('T' if int(x, 16) < tlen else 'D' if int(x, 16) < tlen + dlen else 'B', x, x) for x in tnames]
    b, src, out = assemble(addr, body, eq)
    if b is None:
        rcounts['error'] += 1; v['refine_error'] = [x for x in out.splitlines() if 'error' in x][:2]; return False
    if b != img[addr:addr + len(b)] or addr + len(b) != end_addr:
        rcounts['different'] += 1; return False
    v['state'] = 'same'; v['size'] = len(b); v['source'] = body; v['changes'] = changes
    rcounts['merged'] += 1
    return True


only = os.environ.get('ONLY')
added = {}
order = list(routine_lines)
candidates = {}

def assembled_size(nm, addr):
    # size of the original routine assembled at an address (None if it can't be assembled)
    global current_addr
    current_addr = addr
    b, _, _ = assemble(addr, convert_lines(routine_lines[nm][1]), equates_for(sym, nm))
    return len(b) if b is not None else None

last_tried = None
for outer in range(100):
    results, votes, counts = check_all(sym, only)
    rcounts = collections.Counter()
    if prog and not only:
        for nm, v in results.items():
            if v['state'] == 'different':
                refine_one(nm, v, rcounts)
    new = 0
    # candidates of the last round are only kept if they assemble to the same bytes (also with changes)
    for u in list(candidates):
        if results.get(u, {}).get('state') == 'same':
            added[u] = (sym[u], 0); new += 1
        else:
            del sym[u]
        del candidates[u]
    for u, c in votes.items():
        a, n = c.most_common(1)[0]
        if u not in sym and n / sum(c.values()) >= 0.75:
            sym[u] = a; added[u] = (a, n); new += 1
    # neighbours in the same file: the next routine starts behind a confirmed routine, the previous one ends at it
    for k, nm in enumerate(order):
        v = results.get(nm)
        if not v or v['state'] != 'same': continue
        if k + 1 < len(order):
            nxt = order[k + 1]
            if nxt not in sym and routine_lines[nxt][0] == v['file']:
                sym[nxt] = v['addr'] + v['size']; candidates[nxt] = True
        if k > 0:
            prv = order[k - 1]
            if prv not in sym and routine_lines[prv][0] == v['file']:
                s0 = assembled_size(prv, max(0, v['addr'] - 2000))
                if s0:
                    s1 = assembled_size(prv, v['addr'] - s0)
                    if s1 and v['addr'] - s1 >= 0:
                        sym[prv] = v['addr'] - s1; candidates[prv] = True
    print('round', outer + 1, dict(counts), 'refined', dict(rcounts), 'new names', new, 'candidates', len(candidates), 'assembled', dict(cache_stats), flush=True)
    # ends when a round finds nothing new (the same candidates are tried again and again)
    tried = {u: sym[u] for u in candidates}
    if (not new and (not candidates or tried == last_tried)) or only: break
    last_tried = tried

# open candidates: confirmed if a routine which assembles to the same bytes uses them
used = set()
for v in results.values():
    if v.get('state') == 'same' and v.get('source'):
        used.update(re.findall(r'[A-Za-z_][\w]*', '\n'.join(v['source'])))
for u in list(candidates):
    if u in used:
        added[u] = (sym[u], 0)
    else:
        del sym[u]

json.dump(results, open(out_json, 'w'), indent=1)
with open(out_json + '.names.txt', 'w') as f:
    for u, (a, n) in sorted(added.items(), key=lambda x: x[1][0]):
        f.write('%05x\t%s\t%d\n' % (a, u, n))
# constants for the merged source (the ones which are no labels)
with open(out_json + '.constants.i', 'w') as f:
    f.write('; Constants of the original source (CONST5X.ASM, OFFSETS.ASM and the other modules)\n')
    for nm in sorted(consts):
        if nm not in sym and re.fullmatch(r'[A-Za-z_]\w*', nm):
            f.write('%s\tequ\t%d\n' % (nm, consts[nm]))