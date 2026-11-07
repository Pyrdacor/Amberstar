# Creates CHANGES.md from the CHANGE comments of the merged source.
import sys, re, collections

src, out = sys.argv[1], sys.argv[2]
routines = collections.OrderedDict()   # file -> [(routine, [change lines])]
taken = collections.Counter()
cur = None
for line in open(src, encoding='latin-1'):
    line = line.rstrip('\n')
    m = re.match(r'; ---- (\S+) \(original source: (.+)\)$', line)
    if m:
        cur = (m.group(2), m.group(1), [])
        routines.setdefault(cur[0], []).append(cur)
        taken[cur[0]] += 1
        continue
    if cur is None: continue
    if re.match(r'^(; ----|[A-Za-z_]\w*:)', line) and not line.startswith(cur[1] + ':'):
        # end of the routine (next global label)
        if not line.startswith('.'):
            cur = None if not line.startswith(';') else cur
            if cur is None: continue
    c = re.search(r';\s*CHANGE: (.*)$', line)
    if c:
        code = line.split(';')[0].strip()
        if line.lstrip().startswith(';'): code = ''
        cur[2].append((code, c.group(1)))

total_changed = sum(1 for f in routines for r in routines[f] if r[2])
with open(out, 'w', encoding='utf-8') as f:
    f.write('# Changes compared to the original source code\n\n')
    f.write('This list is generated from the `; CHANGE:` comments of the merged source (`merged/AMBRSTAR_GERMAN.S`).\n')
    f.write('It shows how the shipped program (German Atari ST version) differs from the original source in the routines\n')
    f.write('which are taken from the original source. The original source is an older snapshot, so these are the changes\n')
    f.write('of the later development (bugfixes and other changes).\n\n')
    f.write('* `was "…"` – the instruction of the original source which was replaced by the instruction of the program\n')
    f.write('* `added` – an instruction of the program which is not in the original source\n')
    f.write('* `removed "…"` – an instruction of the original source which is not in the program\n\n')
    f.write('Some changes may also come from the assembler which built the program (e.g. other encodings of the same\n')
    f.write('instruction). %d routines are taken from the original source, %d of them have changes.\n\n' % (sum(taken.values()), total_changed))
    for file in sorted(routines):
        changed = [r for r in routines[file] if r[2]]
        f.write('## %s\n\n' % file)
        f.write('%d routines taken, %d with changes.\n\n' % (taken[file], len(changed)))
        for _, name, ch in changed:
            f.write('### %s\n\n' % name)
            for code, text in ch:
                if code:
                    f.write('* `%s` – %s\n' % (code.replace('\t', ' '), text))
                else:
                    f.write('* %s\n' % text)
            f.write('\n')
print('files', len(routines), 'routines', sum(taken.values()), 'with changes', total_changed)
