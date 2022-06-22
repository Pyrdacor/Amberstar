# Icon data

The container ICON_DAT.AMB contains two sub-files 001 and 002. They hold the data for 2D map tiles. Both information and the tile graphics.
- 001: World map
- 002: Indoor maps

The tilesets also provide the player sprites.

Both tilesets have 250 tiles. But each tile can have multiple frames.

Offset | Type | Name | Description
--- | --- | --- | ---
0000 | Word | Player sprite index | The index of the player tile. For world map this is 237, for indoor maps it is 249.
0002 | Byte[250] | Frame counts | Gives the number of frames for each tile (1 = single frame)
00FC | Word[250] | Image index | Index of the first frame's image index
02F0 | Long[250] | Tile flags | Flags for each tile (bitfield, not yet checked each bit but most likely movement blocking etc)
06D8 | Byte[250] | Colors | Most likely the colors of each tile displayed on the minimap (indices into the palette)
07D2 | Palette | Tile palette | See [Palettes](Palettes.md)
0814 | Image[\*] | Images | See below

## Images

Each image starts with a header of 3 words. The first word gives the width, the second the height and the third the bits per pixel.

Width and height are stored 1 lower than the real value. So a value of 0 means 1 and a value of 0xF means 16.

All tile graphics have a size of 16x16 and use 4 bits per pixel. So they all start with 00 0F 00 0F 00 04. I guess this is specified to work on different systems with the same format. I only document the Amiga version here!

After the header the image data follows. In case of the Amiga data each image uses 128 (0x80) bytes. 16x16 * 4 bits = 128 bytes. The format are bit planes like in Ambermoon. See [here](https://github.com/Pyrdacor/Ambermoon/blob/master/FileSpecs/Graphics.md).




