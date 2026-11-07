import sys, struct
a = open(sys.argv[1], 'rb').read()
b = open(sys.argv[2], 'rb').read()
print('sizes', len(a), len(b))
ha = struct.unpack('>HIIIIIIH', a[:28]); hb = struct.unpack('>HIIIIIIH', b[:28])
print('header orig', ha); print('header new ', hb)
n = min(len(a), len(b))
diffs = [i for i in range(n) if a[i] != b[i]]
print('different bytes', len(diffs))
for i in diffs[:20]:
    print('  file %06x (text %06x): orig %02x new %02x' % (i, i - 28, a[i], b[i]))
