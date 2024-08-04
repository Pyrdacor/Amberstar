# Palettes

Amberstar on the Amiga uses (at least) two palette representations:
- wide palettes, which include a header and represent each color by 4 bytes
- compact palettes, which lack a header and represent each color by 2 bytes

In the Amiga version there are several palettes stored:
- 10 wide palettes in `COL_PALL.AMB`, for [labyrinth data](LabData.md).  Color 0 is the color key for transparency.
- 26 compact palettes in `PICS80.AMB`, each following a raw pixmap
- 2 wide palettes stored internally in each [tilesets](IconData.md)

There may be other palettes stored elsewhere..

## Wide Palettes

Wide palettes have a total size of 66 (0x42) bytes. They start with a word which seems to give the number of colors. In Amberstar I've only seen 00 10 (= 16 colors) so far.

After that the colors themselves follow. Each color is represented by 4 bytes. The first byte gives alpha, then red, then green and last blue. But alpha seems to be unused and always has a value of 0. The other color components are given by very low values in the range 0 to 7. You have to mulitply them by 32 to get the right color value. Maybe even add 16 in the end as well.

In the Amiga palette registers, the values are doubled, meaning that e.g. the black value `000` maps to RGB triple `#000000`, while the brightest possibel value `777` maps to RGB triple `#EEEEEE`.

Another approach would be `(value | (value << 4)) << 2`.

## Compact palettes

Compact palettes have a size of 32 (0x20) bytes.  They lack a header and store alpha, red, green, and blue information in one _nibble_ (half-byte) each.
- red is `byte[0] & 0x07`
- green is `byte[1] & 0x70 >> 4`
- blue is `byte[1] & 0x07`

Some palettes use values greater than 7, though the extra bit does not have any known meaning.
To get the correct colour, it needs to be masked out (hence `... & 0x07` instead of `... & 0x0f`).

## Color component interpretation

First approach color components:

Stored value | Result
--- | ---
00 | 10 (16)
01 | 30 (48)
02 | 50 (80)
03 | 70 (112)
04 | 90 (144)
05 | B0 (176)
06 | D0 (208)
07 | F0 (240)

Second approach color components:

Stored value | Result
--- | ---
00 | 00 (0)
01 | 22 (34)
02 | 44 (68)
03 | 66 (102)
04 | 88 (136)
05 | AA (170)
06 | CC (204)
07 | EE (238)


## The Combat Palettes

The palettes for combat graphics are stored in the
[AMBERDEV](Amberdev.md) resource (see there for the exact offsets).
They are encoded as compact palettes and split into two parts:

- `Combat palette template`: A 16 colour compact palette, with colour indices `c`, `d`, and `e` mapped to black.
- `Combat palette variants`: A sequence of 14 compact palette colour triplets; in other words, an array of 14 entries of 6 bytes each.

The fourteen variants override the r/g/b components of the combat palette template:

| offset | meaning                                      |
|--------|----------------------------------------------|
| 0      | red component for colour index `c`           |
| 1      | green / blue components for colour index `c` |
| 2      | red component for colour index `d`           |
| 3      | green / blue components for colour index `d` |
| 4      | red component for colour index `e`           |
| 5      | green / blue components for colour index `e` |

Each variant provides the palette for the corresponding `COM_BACK.AMB` record.

