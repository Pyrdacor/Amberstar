The main executable for the AtariST `AMBRSTAR.68k` contains all kind of data.

- Layout definitions
- Layout graphics
- Button graphics
- Status icons
- Item graphics
- Text fragments
- Spell names
- Class names
- Skill names
- Item type names
- Other UI graphics
- And much more


Most of the time the data was integrated by including data files into the code. For an example see https://github.com/jhorneman/amberstar/blob/main/src/LAYOUT/GRAPHICS.ASM.

If you find the offset of the first included data of the source file, you can expect that the other data is directly behind it in the same order you see in the original sources.

For the example of `GRAPHICS.ASM` you would find the offset of the data for `Bot_corners` inside `AMBRSTAR.68k`  and can read all the following data in a sequence.

Of course all the source files were merged into one executable so some byte sequence searching might be needed to find the first offsets per source file.

# Data formats

As the data comes from data files, their formats should be the same on Amiga and Atari ST. So I will document them here with their data filenames.

## Layout definitions

Those were located in the files `FRAME.001` to `FRAME.011`. They define how a layout is assembled.

There are the layout block images which are located inside the file `LAYOUT.ICN`. These are 16x16 4-bit planar images. The file contains 132 such images.

The layout definitions are a sequence of 220 bytes. Each is the index of a layout block image. Index 1 is the first image, index 132 would be the last one.

There are 20 such images per screen row (20*16 = 320 pixels).

The first row only uses the lower 12 pixels of each image. The last row only uses the upper 7 pixels of each image. So you have 11*20 images (thus the 220 bytes). The total height is 12+9\*16+7 = 163 pixels. So a layout is 320x163 pixels which is displayed at 0,37 (right below the portrait area).
