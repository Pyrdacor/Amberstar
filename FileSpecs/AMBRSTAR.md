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

For the example of `GRAPHICS.ASM` you would find the offset of the data for `Bot_corners` and can read the all the following data in a sequence.

Of course all the source files were merged into one executable so some byte sequence searching might be needed to find the first offsets per source file.
