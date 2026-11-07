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

def assemble(addr, body, eq):
    src = '\n'.join(eq) + '\n\torg\t$%x\n' % addr + '\n'.join(body) + '\n'
    for attempt in range(8):
        open(SP, 'w', encoding='latin-1').write(src)
        if os.path.exists(BP): os.remove(BP)
        r = subprocess.run([vasm, '-quiet', '-m68000', '-Fbin', '-no-opt', '-nowarn=62', '-o', BP, SP], capture_output=True, text=True, encoding='latin-1')
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

only = os.environ.get('ONLY')
added = {}
order = list(routine_lines)
candidates = {}
for round_nr in range(12):
    results, votes, counts = check_all(sym, only)
    new = 0
    # candidates of the last round are only kept if they assemble to the same bytes
    for u in list(candidates):
        if results.get(u, {}).get('state') == 'same':
            added[u] = (sym[u], 0); new += 1
        else:
            del sym[u]
        del candidates[u]
    # the next routine of the same file starts behind a confirmed routine
    for k, nm in enumerate(order[:-1]):
        v = results.get(nm)
        nxt = order[k + 1]
        if v and v['state'] == 'same' and nxt not in sym and routine_lines[nxt][0] == v['file']:
            sym[nxt] = v['addr'] + v['size']; candidates[nxt] = True
    for u, c in votes.items():
        a, n = c.most_common(1)[0]
        if u not in sym and n / sum(c.values()) >= 0.75:
            sym[u] = a; added[u] = (a, n); new += 1
    print('round', round_nr + 1, dict(counts), 'new names', new, 'candidates', len(candidates))
    if not new or only: break

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
