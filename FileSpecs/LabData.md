# Labyrinth Data

Amberstar refers to first-person map resources as "Lab" resources, so we here adopt the terms "Labyrinth" to refer to them.

## LabData

A LabData resource collects all indices needed for drawing a particular type of Labyrinth, including background images and palette information.
These resources are stored in `LAB_DATA.AMB`.

| offset                       | name                  | size | meaning                                                                              |
|------------------------------|-----------------------|------|--------------------------------------------------------------------------------------|
| 0x0                          | `magic_0`             | u8   | = `0x00`                                                                             |
| 0x1                          | `num_pixmaps`         | u8   | Total number of pixmaps (not including bg images)                                    |
| 0x2                          | `num_labblock_refs`   | u8   | Number of LabBlock references                                                        |
| 0x3..0x3+`num_labblock_refs` | `labblock_ref[i]` + 1 | u8   | Reference to LabBlock resource, with `1` referencing resource 0                      |
| 0x4 + `num_labblock_refs`    | `magic_0`             | u8   | = `0x00`                                                                             |
| 0x5 + `num_labblock_refs`    | `outdoors`            | u8   | `0x03` for outdoors map (don't flip ceiling when moving forward), `0x02` for indoors |
| 0x6 + `num_labblock_refs`    | `magic_2`             | u8   | = `0x02`                                                                             |
| 0x7 + `num_labblock_refs`    | `ceiling`             | u8   | Ceiling image: index into the `BACKGRND.AMB` resources, plus 1                       |
| 0x8 + `num_labblock_refs`    | `floor`               | u8   | Floor image: index into the `BACKGRND.AMB` resources, plus 1                         |
| 0x9 + `num_labblock_refs`    | `magic_1`             | u8   | = `0x01`                                                                             |
| 0xa + `num_labblock_refs`    | `palette` + 1         | u8   | Index into the list of [Palettes](Palettes.md), plus 1                               |

- Ceiling and floor images, as well as all indexed LabBlock resources, use the specified palette.
- For 3D city views, the colour `11`/`0x0b` has a special meaning: transparency relative to the day/night sky gradient (see below)
- When moving around in a Labyrinth, the floor and ceiling images are flipped after every step, except for outdoors images, where the ceiling image is flipped only when rotating.
- When rotating, the ceiling image is also flipped (UNKNOWN: outdoors only or also in dungeons?)
- When rotating, the floor images is not flipped outdoors (UNKNOWN: how about in dungeons?)


## LabBlock

These resources are stored in `LABBLOCK.AMB`.

| offset                                    | name               | size              | meaning                                                                                                                     |
|-------------------------------------------|--------------------|-------------------|-----------------------------------------------------------------------------------------------------------------------------|
| 0x00                                      | `magic_0`          | u8                | = `0x00`                                                                                                                    |
| 0x01                                      | `format`           | u8                | Format specifier.  1 = **Solid**, 2 = **Decoration**, 3 = **Furniture/NPC**                                                 |
| 0x02                                      | `num_perspectives` | u8                | Number of perspectives for this block.  For **Solid**: 13 decimal, for **Decoration**: 17 decimal, for **Furniture/NPC**: 4 |
| 0x03                                      | `num_frames`       | u8                | Number of animation frames (same for all perspectives, but see note about **Furniture/NPC** below                           |
| 0x04..0x04+`num_offsets`                  | `xoffset[i]`       | u8[`num_offsets`] | x offsets.  `num_offsets` is `18` decimal for **Furniture/NPC**, `17` decimal otherwise.                                    |
| 0x04+`num_offset`..0x04+2 * `num_offsets` | `yoffset[i]`       | u8[`num_offsets`] | y offsets.  `num_offsets` is `18` decimal for **Furniture/NPC**, `17` decimal otherwise.                                    |
| 0x04+2*`num_offsets`                      | `sized_pixmap[i]`  | see below         | Pixmaps for each (frame, perspective) combination                                                                           |

The `sized_pixmap` entries have the following structure:
- `size` : u32 : Number of bytes (excluding `size`) of the pixmap
- `pixmap`: A [Pixmap with Header](Pixmaps.md)

Notes:
- The pixmap are ordered first by animation frames, and then by perspectives.  E.g., with two animation frames, the file first lists all
  perspectives for frame 0, then all for frame 1.
- The `xoffset`, `yoffset` information indicates where the upper left corner of the pixmap should be drawn, relative to the background image, with one exception for **Furniture/NPC**.
- For **Furniture/NPC**, the last perspective (index 3) follows a special rule:
    - All animation frames other than frame 0 are drawn on top of frame 0
	- Frame 0 itself is not a complete animation frame, so **Furniture/NPC** has de facto one animation frame less than the other perspectives in the same resource
	- The offsets for frames 1 and later use `xoffset[17]` and `yoffset[17]` for screen positioning
- Perspectives must be drawn in order, i.e., lower-indexed perspectives are drawn first.

## Perspectives

The perspectives have different for the different `format`s.
Each perspective describes a different view on the same entity, depending on where it is positioned relative to the player's view port.
In the following, we will describe this using tables that assume a right-facing player/party, marked as `@>`:

|        |   |   |
|--------|---|---|
|        |   | 2 |
| `@>` 3 | 0 | 1 |
|        |   |   |

This table would mean that:
- perspective 0 is "one step ahead of the player" (in the direction the player is facing)
- perspective 1 is "two steps ahead of the player"
- perspective 2 is "two steps ahead of the player and one to the left"
- perspective 3 is "same tile as the player"

### Perspectives for **Solid** blocks

|      |   |   |   |
|------|---|---|---|
|      |   |   | 0 |
| 9    | 6 | 3 | 0 |
| `@>` | 8 | 5 | 2 |
| A    | 7 | 4 | 1 |
|      |   |   | 1 |


Note:
- perspectives 0 and 1 are drawn if either of the blocks indicated in the table contains the block in question.
  - This does mean that they are somewhat inaccurate.  The game seems to avoid this by mostly using narrow corridors / obstacles to hide this property
- ***UNKNOWN**: what happens if there are two blocks with this property and they overlap?  Who wins?


### Perspectives for **Decoration** blocks

Decoration blocks are drawn over a **Solid** block and decorate it.
If the decoration is visible from more than one side, it may have to be drawn multiple times.

The table below is used for decorations that are facing towards the player/party:

|      |   |   |   |
|------|---|---|---|
|      | 6 | 3 | 0 |
| `@>` | 8 | 5 | 2 |
|      | 7 | 4 | 1 |


The table below is used for decorations that
- are to the left of the player, facing right (9, F, D, B)
- are to the right of the player, facing left (A, 10, E, C)

|      |    |   |   |
|------|----|---|---|
| 9    | F  | D | B |
| `@>` |    |   |   |
| A    | 10 | E | C |


### Perspectives for **Furniture/NPC** blocks

Furniture/decoration blocks are the only blocks that are drawn when on the same tile as the player.

|        |   |   |   |
|--------|---|---|---|
| `@>` 3 | 2 | 1 | 0 |


## Sky Gradient

Cities have a background sky gradient.  This gradient is stored in [AMBERDEV.UDO](Amberdev.mc) and consists of three [Compact palettes](Palettes.md), in order:
- Day gradient
- Night gradient
- Twilight gradient (dawn/dusk)

Each gradient has 83 palette entries.  The gradients are stored without any intervening separator.
Each palette entry specifies the sky colour for the corresponding scanline in the first-person view, going downwards.
The game selects the gradients based on the time of day:

| Time of day | Gradient |
|-------------|----------|
| 06:00-07:59 | Twilight |
| 08:00-17:59 | Day      |
| 18:00-19:59 | Twilight |
| 20:00-05:59 | Night    |

During twilight hours, there is some blending between the gradients; details tbd.
