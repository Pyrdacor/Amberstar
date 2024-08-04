# Amberstar

Information and resources for the Amiga classic Amberstar

## File specs

Contain information about decoded game data formats.

- [FileSpecs](FileSpecs/)
  - [Background Music](FileSpecs/Hippel-CoSo.md) (In-game music)
  - [Containers](FileSpecs/Containers.md) (Container file formats, which encode the resources below)
  - [CharData](FileSpecs/CharData.md) (NPCs, monsters and party members)
  - [Compressed Text](FileSpecs/CompressedText.md) (In-game text)
  - [IconData](FileSpecs/IconData.md) (Tilesets)
  - [LabBlock](FileSpecs/LabData.md) (Labyrinth, i.e. first-person map, graphics)
  - [Maps](FileSpecs/Maps.md) (Maps, both for top-down views and for Labyrinths)
  - [Palettes](FileSpecs/Palettes.md) (Color palettes)
  - [Pixmaps](FileSpecs/Pixmaps.md) (In-game graphics)
- [Graphics](Graphics/)
  - [Indoor](Graphics/Indoor/) (Indoor 2D tile graphics)
  - [Worldmap](Graphics/Worldmap/) (Worldmap tile graphics)

## Container files overview

| File           | Container | Elements | Format                                                                                              | Explanation                     | Decoded                                                 |
|----------------|-----------|----------|-----------------------------------------------------------------------------------------------------|---------------------------------|---------------------------------------------------------|
| `AMBERDEV.UDO` | `LOB`     | 1        | [Various](FileSpecs/Amberdev.md)                                                                    | Assortment of data              | only very partially                                     |
| `Amberload`    |           |          |                                                                                                     |                                 |                                                         |
| `AUTOMAP.AMB`  | `AMBR`    | 152      |                                                                                                     |                                 |                                                         |
| `BACKGRND.AMB` | `AMPC`    | 10       | [Pixmap List](FileSpecs/Pixmaps.md) 144x144, 4bpp                                                   | Town (+dungeon) backgrounds     | yes (outdoors sunrise/sunset gradients missing)         |
| `CHARDATA.AMB` | `AMBR`    | 78       | [Character Data](FileSpecs/CharData.md)                                                             |                                 |                                                         |
| `CHESTDAT.AMB` | `AMPC`    | 163      |                                                                                                     |                                 |                                                         |
| `CODETXT.AMB`  | `AMBR`    | 2        | [Compressed Text](FileSpecs/CompressedText.md)                                                      |                                 | yes                                                     |
| `COL_PALL.AMB` | `AMBR`    | 10       | [Palettes](FileSpecs/Palettes.md)                                                                   |                                 | yes                                                     |
| `COM_BACK.AMB` | `AMPC`    | 14       | [Raw Pixmaps](FileSpecs/Pixmaps.md)  176x112, 4bpp                                                  | Combat background images        | yes                                                     |
| `EXTRO.UDO`    |           |          | (incl. Hippel-7V)                                                                                   | Extro + music                   |                                                         |
| `F_T_ANIM.ICN` |           |          | [Raw Pixmaps](FileSpecs/Pixmaps.md) (16x16, 4bpp)                                                   | Combat grid magic animations    | yes (missing association between animations and spells) |
| `ICON_DAT.AMB` | `AMPC`    | 2        | [IconData](FileSpecs/IconData.md)                                                                   | Map tilesets                    | mostly                                                  |
| `INTRO_P.UDO`  | `LOB`     | 1        | (incl. Hippel-7V)                                                                                   | Intro music                     |                                                         |
| `INTRO.UDO`    | `LOB`     | 1        |                                                                                                     |                                 |                                                         |
| `LABBLOCK.AMB` | `AMPC`    | 68       | [LabBlock](FileSpecs/LabData.md)                                                                    | First-person map graphics       | yes                                                     |
| `LAB_DATA.AMB` | `AMBR`    | 23       | [LabData](FileSpecs/LabData.md)                                                                     | First-person map resource index | yes                                                     |
| `MAP_DATA.AMB` | `AMPC`    | 152      | [Maps](FileSpecs/Maps.md)                                                                           | Maps                            | mostly                                                  |
| `MAPTEXT.AMB`  | `AMBC`    | 152      | [Compressed Text](FileSpecs/CompressedText.md)                                                      | Map-specific text               | yes                                                     |
| `MON_DATA.AMB` | `AMBR`    | 67       | [Combat Layout](FileSpecs/CombatLayout.md)                                                          |                                 | yes                                                     |
| `MON_GFX.AMB`  | `AMPC`    | 21       | [Pixmap List](FileSpecs/Pixmaps.md) of first-person in-combat monster animations                    |                                 | yes (missing exact rules for animation)                 |
| `PARTYDAT.SAV` |           |          |                                                                                                     |                                 |                                                         |
| `PICS80.AMB`   | `AMPC`    | 52       | [Raw Pixmaps](FileSpecs/Pixmaps.md) (80x80, 4bpp) + [Palettes](FileSpecs/Palettes.md) (alternating) | Pixmap followed by palette      | yes                                                     |
| `PUZZLE.ICN`   |           |          |                                                                                                     |                                 |                                                         |
| `PUZZLE.TXT`   |           |          |                                                                                                     |                                 |                                                         |
| `SAMPLEDA.IMG` |           |          | [Background Music](FileSpecs/Hippel-CoSo.md)                                                        | Sample data for in-game songs   | yes                                                     |
| `TACTIC.ICN`   |           |          | [Raw Pixmaps](FileSpecs/Pixmaps.md) (16x16, 4bpp)                                                   | Combat grid creature animations | yes                                                     |
| `TH_LOGO.UDO`  | `LOB`     | 1        |                                                                                                     |                                 |                                                         |
| `WARESDAT.AMB` | `AMPC`    | 16       |                                                                                                     |                                 |                                                         |

## Practical Notes and Notation

- Unless noted otherwise, all numbers are encoded in big-endian two's complement format (e.g., a 16 bit representation of the number 1000 is encoded as the two bytes `03e8`).
- Numbers need not be aligned to word boundaries. Trying to read unaligned numbers with a 16 bit or 32 bit memory read may produce unexpected results on some CPUs. (In C and C++, unaligned loads depend on parts of the language semantics that are explicitly undefined, so if in doubt, make use to read each byte individually and reassemble later.)
- The types "u8", "u16", "u32` and "i8", "i16", "i32" refer to unsigned 8/16/32 bit numbers, and to signed 8/16/32 bit numbers (respectively).

