# Tile Flags

Tile flags appear both in labyrinth map data, as part of LabInfo
blocks, and in 2d map icon data, where they are hardwired to specific
map icons.  They appear similar in structure to Ambermoon tile flags
(https://github.com/Pyrdacor/Ambermoon/blob/master/FileSpecs/Enumerations/TileFlags.md).

The interpretations below are mostly observational and require full
validation.

| head flags | Icon | Lab | Meaning                  | Automap | Notes                                                                                      | Validation |
|------------|------|-----|--------------------------|---------|--------------------------------------------------------------------------------------------|------------|
| 00000001   | y    | y   | Back-and-forth animation |         | Animation frame goes from first to last, then back down to first                           |            |
| 00000002   |      | y   | Block sight?             |         |                                                                                            |            |
| 00000004   | y    |     |                          |         | Set for foreground tiles, maybe used for editor?                                           |            |
| 00000008   | y    |     | Seat                     |         | Chair or bed, if player occupies tile, show NEXT tile instead                              |            |
| 00000010   | y    | y   | Random animation offset  |         | Start animation for different uses of this tile at different points in time                |            |
| 00000020   | y    | y   | Icon:? / Lab:Illusion    |         | MapIcon: used for nonblocking foreground tiles / Labyrinth: marks illusory walls           |            |
| 00000040   | y    |     | Foreground               |         | Draw over player                                                                           |            |
| 00000080   | y    | y   | Block movement           | Wall    | Only used indoors?                                                                         |            |
| 00000100   | y    | y   |                          |         | MapIcon: travel on foot? / Lab: ?                                                          |            |
| 00000200   | y    | y   |                          |         | MapIcon: travel on horseback? / Lab: ?                                                     |            |
| 00000400   | y    | y   |                          |         | MapIcon: travel on raft? / Lab: ?                                                          |            |
| 00000800   | y    |     |                          |         | MapIcon: travel on boat?                                                                   |            |
| 00001000   | y    |     |                          |         | MapIcon: travel on disk?                                                                   |            |
| 00002000   | y    |     |                          |         | MapIcon: travel on eagles?                                                                 |            |
| 00004000   | y    |     |                          |         | MapIcon: travel on red triangle boat thing?                                                |            |
| 00008000   | y    |     |                          |         | MapIcon: used for world map forest, boat, indoors walls and doors; don't draw player here? |            |
| 00010000   | y    | y   |                          |         | Combat background?  Outdoors                                                               |            |
| 00020000   | y    |     |                          |         | Combat background?  Forest                                                                 |            |
| 00040000   | y    |     |                          |         | Combat background?  Desert                                                                 |            |
| 00080000   | y    |     |                          |         | Combat background?  Swamp                                                                  |            |
| 00100000   | y    |     |                          |         | Combat background?  Sea                                                                    |            |
| 00200000   | y    |     |                          |         | Combat background?  Mountain                                                               |            |
| 00400000   | y    |     |                          |         | Combat background?  River                                                                  |            |
| 00800000   | y    | y   |                          |         | Combat background?  Town                                                                   |            |
| 01000000   | y    | y   |                          |         | Combat background?  Tower/Tunnel/Cellar                                                    |            |
| 02000000   | y    | y   |                          |         | Combat background?  Temple of Sansri                                                       |            |
| 04000000   | y    | y   |                          |         | Combat background?  Sewers                                                                 |            |
| 08000000   | y    |     |                          |         | Combat background?  Graveyard                                                              |            |
| 10000000   | y    | y   |                          |         | Combat background?  Villa                                                                  |            |
| 20000000   | y    |     |                          |         | Combat background?  Bridge                                                                 |            |
| 40000000   |      |     |                          |         |                                                                                            |            |
| 80000000   | y    |     | Poison                   |         | Party is poisoned                                                                          |            |


Notes:
- Seat: used for four chair tiles and for the bed tile.  The immediate next tile is the same tile, except occupied by the player.
