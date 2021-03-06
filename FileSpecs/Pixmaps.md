# Pixmaps

Pixmaps describe pixel graphics.  The format in Amberstar is analogous to Ambermoon, described here (*FIXME*)

Amberstar seems to mainly (exclusively?) use 4-bit (16 colour) graphics.

Brief summary below:
For an image of dimensions `width`x`height` with `4` bitplanes, the pixmap data is encoded as a sequence of lines that contain bitplanes, which in turn contain 16-bit words:

## Lines

Each image contains *lines* in the sequence:

- `line[0]`
- ...
- `line[height-1]`

Each record has exactly the same size and consists of of *bitplanes*:

## Bitplanes

- `bitplane[0]`
- `bitplane[1]`
- `bitplane[2]`
- `bitplane[3]`

Each of which again has the same size.  (Add or remove bitplanes as appropriate if n=3/n=5).
These bitplanes contain enough *16-bit words* to contain the width of the image, i.e.:
- width 1-16: 1 16-bit word
- width 17-32: 2 16-bit words
- ...

yielding
- `xword[0]`
- `xword[1]`
- ...

The total size of such an image is this `((width + 15) >> 4) * num_bitplanes * height`.
The palette index of a pixel at index `x`, `y` is now given by the combination (bitwise-of) of the bits
- `line[y].bitplane[0].xword[x >> 4] & (0x8000 > (x & 0xf))` << 0
- `line[y].bitplane[0].xword[x >> 4] & (0x8000 > (x & 0xf))` << 1
- `line[y].bitplane[0].xword[x >> 4] & (0x8000 > (x & 0xf))` << 2
- `line[y].bitplane[0].xword[x >> 4] & (0x8000 > (x & 0xf))` << 3

