# Savegame

| Offset | Type                                | Name                         | Description
| ------ | ----------------------------------- | ---------------------------- | -----------
| 0000   | Byte                                | Month                        | Starts at 4 (April)
| 0001   | Byte                                | Day                          | Starts at 15
| 0002   | Byte                                | Hour                         | Starts at 16
| 0003   | Byte                                | Minute                       | Starts at 0
| 0004   | Byte                                | Party X                      | 1-based X position (1-200)
| 0005   | Byte                                | Party Y                      | 1-based Y position (1-200)
| 0006   | Byte                                | Party direction              | 0: Up, 1: Right, 2: Down, 3: Left
| 0007   | Byte[6]                             | ActiveSpellDurations         | Duration of each active spell
| 000D   | Byte                                | Party size                   | Number of characters in the party (1-6)
| 000E   | Byte                                | Active party member          | Slot index of the active party member (1-6)
| 000F   | Byte                                | Travel type                  | 0: Walk, 1: Horse, ...
| 0010   | Byte                                | Active special items         | Flag bits which special items (like clock) are active
| 0011   | Byte                                | Party size                   | Number of characters in the party (1-6)
| 0012   | Byte                                | Music off                    | `0xff` = off, `0x00` = on
| 0013   | Byte[6]                             | ActiveSpellValues            | Value of each active spell
| 0019   | Word                                | Year                         | Starts at 876
| 001B   | Word                                | Map index                    | Starts at 65 (Twinlake graveyard)
| 001D   | Word[6]                             | Character indices            | Character indices of all 6 party character slots (0 = empty)
| 0029   | Word                                | Travelled days               | Total amount of days (not sure if this is used for anything)
| 002B   | Word                                | Relative year                | Passed years since 876 (not sure if this is used for anything)
| 002D   | Byte[30]                            | Transport types              | Types of transports (none, horse, raft, ship)
| 004B   | Byte[30]                            | Transport X coords           | X coords of transports
| 0069   | Byte[30]                            | Transport Y coords           | Y coords of transports
| 0087   | Word[30]                            | Transport map indices        | Map indices of transports
| 00C3   | Byte[32]                            | Quest bits                   | Used to track quest progress
| 00E3   | Byte[4064]                          | Event bits                   | ...
| 10C3   | Byte[1502]                          | Character bits               | ...
| 16A1   | Byte[626]                           | Known words bits             | ...
| 1913   | Byte[1500]                          | Chest slot bits              | ...
| 1EEF   | Word[1000]                          | Chest gold                   | Gold of all chests (up to 1000 chests)
| 26BF   | Byte[1200]                          | Ware counts                  | Number of items of merchants (up to 100 merchants with 12 slots)
| 2B6F   | Byte[6]                             | Combat positions             | Position in combat for all 6 party member slots
| 2B75   | Word                                | Number of tile changes       | Tile change section has a dynamic size
| 2B77   | TileChange[n]                       | Tile change data             | n = Number of tile changes

## Tile changes

| Offset | Type                                | Name                        
| ------ | ----------------------------------- | ----------------------------
| 0000   | Word                                | Map index 
| 0002   | Byte                                | X 
| 0003   | Byte                                | Y 
| 0004   | Word                                | Tile index 

## Chest data

In contrast to Ambermoon, it is not possible to store items in chests. You can only take them out. This is also reflected in the savegames.
There is no chest data. Only the gold amounts and slot flags are stored. The slot flags are single bits per item slot which determine if
the item is present or not. If a chest is fully looted in the game, it will never be shown again.

## Merchant data

In contrast to Ambermoon, sold items will not be added to the merchant items. You just get the gold and the item vanishes forever.
Similar to chests, no item indices are stored in the savegame. Only the remaining amount of items in the slot. For chests only 1
item per slot is possible, so no count is needed there.
