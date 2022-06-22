# Palettes

In the Amiga version there are 10 external palettes stored in COL_PALL.AMB. But there are other palettes as well. For example the [tilesets](IconData.md) store their own palette internally.

The Amiga palettes have a total size of 66 (0x42) bytes. They start with a word which seems to give the number of colors. In Amberstar I've only seen 00 10 (= 16 colors) so far.

After that the colors themselves follow. Each color is represented by 4 bytes. The first byte gives alpha, then red, then green and last blue. But alpha seems to be unused and always has a value of 0. The other color components are given by very low values in the range 0 to 7. You have to mulitply them by 32 to get the right color value. Maybe even add 16 in the end as well.

Another approach would be (value | (value << 4)) << 2.

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
