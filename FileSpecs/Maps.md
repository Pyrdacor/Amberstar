# Maps

**Note:** This is **WIP**. Some data structures are incomplete, others may be incorrect.

Maps are stored in `MAP_DATA.AMB`.  Each resource describes one
in-game map, with 2D maps and Labyrinths sharing much of the file structure.
The files consist of the following sections:
* Header
* Event descriptions (e.g., popup messages, chests, locked doors, or transitions to other maps)
* NPC references (not including the actual NPC descriptions, which are in `CHARDATA.AMB`)
* A magic 9 byte sequence
* **3D maps / Labyrinths only**: LabInfo blocks (meaning currently unclear)
* The actual map
* **2D maps only**: An overlay tile map, drawn over the preceding map
* A hotspot map, which maps map locations to event descriptions
* NPC locations and/or movement routes


## Map Header and Structure

| Offset   | Format             | Name                 | Description                                                                                             |
|----------|--------------------|----------------------|---------------------------------------------------------------------------------------------------------|
| `0`      | u8                 | magic number         | = `0xff`                                                                                                |
| `1`      | u8                 | fill byte            | = `0x00`                                                                                                |                                                                                        |
| `2`      | u16                | tileset / background | 2D maps: tileset (`1` or `2`).  Labyrinths: [LabData](LabData.md) resource describing the graphics, + 1 |
| `4`      | u8                 | labyrinth marker     | `00` for top-down 2D maps, `01` for Labyrinths (dungeons, towns)                                        |
| `5`      | u8                 | flags                | See below                                                                                               |
| `6`      | u8                 | song                 | If ≠ `00`, set active song to this one                                                                  |
| `7`      | u8                 | width                | in # tiles                                                                                              |
| `8`      | u8                 | height               | in # tiles                                                                                              |
| `9`      | char[30]           | name                 | map name, padded with `0x20`, and `0x00`-terminated                                                     |
| `38`     | event[254]         | events               | `10` bytes per [event](Events.md)                                                                       |
| `a14`    | npc[24]            | NPCs                 | NPC list, See below                                                                                     |
| `abc`    | u16                | max steps per day    | = 0x120 (288), total amount of 5-minute steps per day                                                   |
| `abe`    | u8                 | months per year      | = 12                                                                                                    |
| `abf`    | u8                 | days per month       | = 30                                                                                                    |
| `ac0`    | u8                 | hours per day        | = 24                                                                                                    |
| `ac1`    | u8                 | minutes per hour     | = 60                                                                                                    |
| `ac2`    | u8                 | minutes per step     | = 5                                                                                                     |
| `ac3`    | u8                 | hours per daytime    | = 12                                                                                                    |
| `ac4`    | u8                 | hours per nighttime  | = 12                                                                                                    |
| `ac5`... |                    |                      | varies between 2D maps and Labyrinths, see below                                                        |
|          | LabInfo[..]        | labinfo              | Labyrinth only: Labyrinth tile descriptions                                                             |
|          | u8[width * height] | map[0]               | map data                                                                                                |
|          | u8[width * height] | map[1]               | 2D only: overlay map                                                                                    |
|          | u8[width * height] | hotspots             | hotspot map.  If hotspot[`pos`] = `n` > 0, then event[`n - 1`] triggers at `pos`                        |
|          | u8[..]             | NPC coordinates      | See below                                                                                               |


## Map Flags

The map flags indicate light sources, whether resting is possible etc.:

| Flag | Name | Exclusivity | Meaning                 | Example maps                                                                        |
|------|------|-------------|-------------------------|-------------------------------------------------------------------------------------|
| 0x01 |      | A           | Light: always           | Sir Marillon's Tomb, Family home                                                    |
| 0x02 |      | A           | Light: sunlight only    | Overworld, Twinlake Graveyard, Twinlake city                                        |
| 0x04 |      | A           | Light: none             | Lord Drebin's Cellar, Twinlake Sewers                                               |
| 0x08 |      |             | "Mapshow" spell allowed | Most maps.  NOT some advanced dungeons, such as Castle of Manyeye (minus the Tower) |
| 0x10 |      |             | Can rest here           | Overworld, Twinlake sewers, Family home. NOT Twinlake city or graveyard.            |
| 0x20 |      | B           | Wilderness              | All overworld maps                                                                  |
| 0x40 |      | B           | City                    | Twinlake Graveyard, Twinlake City                                                   |
| 0x80 |      | B           | Dungeon                 | Sir Marillon's Tomb, Twinlake Sewers                                                |

* A: Precisely one of {`01`, `02`, `04`} is set on every map
* B: Precisely one of {`20`, `40`, `80`} is set on every map

## Light

The light is calculated as follows:

- If active character is blind, all dark.
- Otherwise if Light bit is 1 (flags & 0x01 != 0), just show full brightness.
- Otherwise if Light bit is 0 (flags & 0x01 == 0), check for LightChange bit (flags & 0x02).
- If set, get the light radius by the hour.
  - Use this table: `16,16,16,16,16,16,40,64,200,200,200,200,200,200,200,200,200,64,64,40,16,16,16,16,16`.
  - Any active light spell will add its effect (multiplied by 8) to the radius.
- If the change bit was 0 instead, check the dark bit (flags & 0x04).
- If this is not set, just do nothing (no change). I guess no map uses this (all 3 bits would be 0).
- Otherwise check travel type first. Superchicken mode (cheat) grants full light.
- Otherwise if no light spell is active, use full darkness.
- Otherwise use a radius of 16 + (the light spell effect multiplied by 8).

## 2D Maps

| Offset              | Format             | Name            | Description                    |
|---------------------|--------------------|-----------------|--------------------------------|
| ...                 |                    |                 | (cf. Map Header and Structure) |
| `ac5`               | u8[width * height] | map[0]          | map data                       |
| `ac5` + mapsize     | u8[width * height] | map[1]          | overlay map                    |
| `ac5` + mapsize * 2 | u8[width * height] | hotspots        | hotspot map                    |
| `ac5` + mapsize * 3 | u8[..]             | NPC coordinates | See below                      |

where:
* mapsize = height * width


## Labyrinths

| Offset                            | Format             | Name               | Description                    |
|-----------------------------------|--------------------|--------------------|--------------------------------|
| ...                               |                    |                    | (cf. Map Header and Structure) |
| `ac5`                             | u8                 | #labinfo           | Number of LabInfo blocks       |
| `ac6`                             | u8[4 * #labinfo]   | labinfo[i].head    | See below                      |
| `ac6` + #labinfo * 4              | u8[#labinfo]       | labinfo[i].rest[0] | See below                      |
| `ac6` + #labinfo * 5              | u8[#labinfo]       | labinfo[i].rest[1] | See below                      |
| `ac6` + #labinfo * 6              | u8[#labinfo]       | labinfo[i].rest[2] | See below                      |
| `ac6` + labinfosize               | u8[width * height] | map[0]             | map data                       |
| `ac6` + labinfosize + mapsize     | u8[width * height] | hotspots           | hotspot map                    |
| `ac6` + labinfosize + mapsize * 2 | u8[..]             | NPC coordinates    | See below                      |

where:
* labinfosize = #labinfo * 7
* mapsize = height * width

### LabInfo blocks

LabInfo blocks consist of 7 bytes each and describe the meaning of the tile numbers on the map.
They reference the Labyrinth's associated [LabData](LabData.md) resource.

Going by similarity of the numbers observed in the various bytes, they seem to be grouped into four chunks:

* One chunk of u32 flags (`labinfo.flags`, below)
* Three chunks of u8 blocks (`labinfo.fg_image`, `labinfo.bg_image`, and `labinfo.rest`, respectively, below)

| Labinfo    | Meaning            | Notes                                                                                           |
|------------|--------------------|-------------------------------------------------------------------------------------------------|
| `flags`    | `flags`            | [Tile Flags](TileFlags.md)                                                                      |
| `fg_image` | foreground pixmaps | Foreground image; index into the `labblock_ref` table for LabData.  This image is drawn second. |
| `bg_image` | background pixmaps | Background image; index into the `labblock_ref` table for LabData.  This image is drawn first.  |
| rest       | ?                  | observed values: [`00-0c`, `0e-0f`]                                                             |


## NPCs

NPC map descriptions are split into two parts, which I will here call the *NPC list* and the *NPC movement routes*.
* NPC list: always starts at `a14`
* NPC movement routes: always start after the hotspot map (making them the final part of each map resource)

### NPC list

There are always precisely 24 (`0x18`) NPCs declared.  NPC declarations are chunked into six parts, with 24 entries each:

| Offset                   | type    | Name               | Meaning                                                         |
|--------------------------|---------|--------------------|-----------------------------------------------------------------|
| `a14`                    | u16[24] | npc[i].personality | `0` if disabled, otherwise NPC ID or popup message **plus `1`** |
| `a44` (= `a14` + 24 * 2) | u8[24]  | npc[i].sprite      | NPC sprite (on the active tile map)                             |
| `a5c` (= `a14` + 24 * 3) | u8[24]  | npc[i].move        | Travel mode of the NPC (basically collision classes)            |
| `a74` (= `a14` + 24 * 4) | u8[24]  | npc[i].flags       | See below                                                       |
| `a8c` (= `a14` + 24 * 5) | u8[24]  | npc[i].day         | Spawn day (see flags, must match current day of month)          |
| `aa4` (= `a14` + 24 * 6) | u8[24]  | npc[i].month       | Spawn month (see flags, must match current month)               |

| Flags          | Name        | Exclusivity   | Meaning                                   |
|----------------|-------------|---------------|-------------------------------------------|
| flags & `0x01` | type        | -             | 0: person, 1: monster                     |
| flags & `0x02` | random/path | Persons only  | 0: path, 1: walk around randomly          |
| flags & `0x04` | hunt/stay   | Monsters only | 0: stay, 1: hunt player                   |
| flags & `0x08` | spawn date  | Persons only  | 0: always there, 1: only on specific date |
| flags & `0x10` | popup-only  | Persons only  | talking to NPC pops up message            |

### Talking to NPCs

When the player talks to an NPC, the following happens:

* If *popup-only* is set, then pop up the `MAPTEXT` message indexed by  *personality* - `1`.
* If *attack* is set, enter combat for the [combat layout](CombatLayout.md) (`MON_DATA`) indexed by *personality* - `1`.
* Otherwise, enter chat mode for NPC from `CHARDATA`, indexed by *personality* - `1`.

### NPC Positions and Movement Routes

For each NPC with a nonzero personality, the map stores some number of bytes for their position and/or movement route.
There seem to be three possible movment modes for NPCs, which determine how many coordinates the movment routes table store:

| Movement mode   | Indication                               | # coordinates |
|-----------------|------------------------------------------|---------------|
| **ATTACK**      | *attack* is set                          | `1`           |
| **RANDOM-WALK** | *random-walk* is set                     | `1`           |
| **CIRCUIT**     | neither *attack* nor *stationary* is set | `0x120` = 288 |

The movement routes are stored in the same order in which the NPCs are stored:
- first all x coordinates for the NPC
- then all y coordinates for the NPC

Note:
- All coordinates are +1 relative to map positions.
- Coordinate values of `6` mean tha tthe NPC disappears.
- NPCs that enter a chair or a bed are drawn suitably.  The party cannot chat with NPCs that are in bed.
- The coordinates might plausibly be broken up across the day cycle.

For instance, if we have two stationary NPCs, then one circuit NPC, and another stationary NPC, the game will store
* NPC[0].x (`1` byte)
* NPC[0].y
* NPC[1].x
* NPC[1].y
* NPC[2].x[0..0x120]  (`0x120` bytes)
* NPC[2].y[0..0x120]
* NPC[3].x
* NPC[3].y

Movement algorithm:

* **RANDOM-WALK**: Every four party movements (?), move into one direction at random.
* **ATTACK**: move one field (incl. diagonally) closer to the player.  Unknown: do the NPCs see the player through walls?
* **CIRCUIT**: Iterate over the coordinates in the coordinate table.  Coordinates may repeat, indicating that the NPC stays still for a few rounds before moving on.

Unknown: can NPCs trigger events?

## Tile Map and Overlay Map

The overlay map (only present in 2D maps) is functionally identical to the tile map, so we refer to them as map[0] and map[1], respectively,
and refer to both jointly as "tile maps".

Tile maps store tiles in row-major order.  Tile 0 indicates "no tile" (nothing to draw), while tile 1 is the first tile (index 0).

## Hotspot Map

The hotspot map stores u8 values in row-major order:
* `0` means "no hotspot"
* `n` > 0 means "trigger event `n-1`".  Conditions for triggering an event vary by [event](Events.md).
