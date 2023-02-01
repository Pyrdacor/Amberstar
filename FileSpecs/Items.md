# Items

**Note:** This is **WIP** and many values are not present yet as they are not decoded.


Size: 40 Bytes (0x28)

Offset | Type | Name | Description
--- | --- | --- | ---
00 | Byte | Graphic index |
01 | Byte | Item type | See below
04 | Byte | Number of hands |
05 | Byte | Number of fingers |
0E | Word | Usable classes | Bitfield
10 | Byte | Shield | Defense
11 | Byte | Damage |
12 | Byte | Equip slot | See below
20 | Word | Buy price |
22 | Word | Weight | In grams
24 | Word | KeyID | Special marker for quest items (e.g., door keys)
26 | Word | Name | Item name, as index into the global string table

## Item types

- 00: Armor
- 02: Shoes
- 03: Shield
- 04: Melee weapon
- 06: Ammunition
- 09: Potion
- 0F: Key
- 10: Item (normal item like a torch)

## Equip slots

- 0: None
- 1: Neck
- 2: Head
- 3: Chest
- 4: Weapon hand (right hand)
- 5: Armor
- 6: Shield hand (left hand)
- 7: Right finger
- 8: Feet
- 9: Left finger
