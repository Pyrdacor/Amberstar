# Applies SYMBOLS_RECONSTRUCTED.txt (reconstructed names and corrections, addresses of the German version) to a
# SYMBOLS file. For another version the addresses are found by the bytes of the German program around them.
import sys, struct

symbols_path, overrides_path, german_prg, target_prg = sys.argv[1:5]

def load(path):
    prg = open(path, 'rb').read()
    _, tlen, dlen = struct.unpack('>HII', prg[:10])
    img = prg[28:28 + tlen + dlen]
    p = 28 + tlen + dlen
    relocs = set()
    first = struct.unpack('>I', prg[p:p + 4])[0]
    if first:
        a = first; relocs.add(a); p += 4
        while True:
            c = prg[p]; p += 1
            if c == 0: break
            if c == 1: a += 254; continue
            a += c; relocs.add(a)
    return img, relocs, tlen

gimg, grel, gtlen = load(german_prg)
timg, trel, ttlen = load(target_prg)
same_program = gimg == timg

def pattern(img, relocs, a, n=24):
    # bytes with the relocated longwords masked
    mask = set()
    for r in range(a - 3, a + n):
        if r in relocs: mask.update(range(r, r + 4))
    return [(None if x in mask else img[x]) for x in range(a, min(a + n, len(img)))]

def translate_code(a):
    pat = pattern(gimg, grel, a)
    if sum(1 for p in pat if p is not None) < 8: return None
    for d in sorted(range(-64, 65), key=abs):
        b = a + d
        if 0 <= b and b + len(pat) <= len(timg) and all(p is None or timg[b + i] == p for i, p in enumerate(pat)):
            return b
    return None

def translate(a):
    if same_program: return a
    # the BSS has no bytes: it follows the text and the data
    if a >= len(gimg): return a - len(gimg) + len(timg)
    pat = pattern(gimg, grel, a)
    if sum(1 for p in pat if p is not None) < 8:
        # e.g. a table of pointers: a reference in the code gives the address in the other program
        for r in sorted(grel):
            if r < gtlen and struct.unpack('>I', gimg[r:r + 4])[0] == a:
                for start in range(r - 6, r - 1, 2):
                    t = translate_code(start)
                    if t is not None and (t + (r - start)) in trel:
                        return struct.unpack('>I', timg[t + (r - start):t + (r - start) + 4])[0]
        return None
    if a >= gtlen:
        # the data of the versions differ in size (texts), so the whole data is searched (unique match only)
        hits = [b for b in range(ttlen, len(timg) - len(pat)) if all(p is None or timg[b + i] == p for i, p in enumerate(pat))]
        return hits[0] if len(hits) == 1 else None
    best = None
    for d in range(-64, 65):
        b = a + d
        if b < 0 or b + len(pat) > len(timg): continue
        if all(p is None or timg[b + i] == p for i, p in enumerate(pat)):
            if best is None or abs(d) < abs(best - a): best = b
    return best

rows = [l.rstrip('\n').split('\t') for l in open(symbols_path) if l.strip()]
header, rows = rows[0], rows[1:]
removed = set()
added = []
for l in open(overrides_path, encoding='utf-8'):
    if l.startswith('#') or not l.strip(): continue
    c = l.rstrip('\n').split('\t')
    a = translate(int(c[0], 16))
    if a is None:
        print('not found in the target program:', c[1]); continue
    if c[1].startswith('-'):
        removed.add((a, c[1][1:])); continue
    added.append((a, c[1], c[2] if len(c) > 2 else '', c[3] if len(c) > 3 else ''))

names_added = {n for _, n, _, _ in added}
out = []
for r in rows:
    a, nm = int(r[0], 16), r[2]
    if (a, nm) in removed or nm in names_added: continue
    out.append(r + [''] * (6 - len(r)))
for a, nm, f, comment in added:
    tl = ttlen
    sec = 'T' if a < tl else 'D' if a < len(timg) else 'B'
    out.append(['%05x' % a, '%s_%05x' % (sec, a), nm, f, 'R', comment])
out.sort(key=lambda r: (int(r[0], 16), r[4] != 'R'))
with open(symbols_path, 'w') as f:
    f.write('\t'.join(header[:5] + ['Comment']) + '\n')
    for r in out:
        f.write('\t'.join(r[:6]) + '\n')
print('removed', len(removed), 'added', len(added))
