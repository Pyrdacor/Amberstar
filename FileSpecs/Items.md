# Items

**Note:** This is **WIP** and many values are not present yet as they are not decoded.


Size: 40 Bytes (0x28)

Offset | Type | Name | Description
--- | --- | --- | ---
00 | Byte | Graphic index |
01 | Byte | Item type | See below
02 | Byte | Used ammunition type | See below (slings, bows or crossbows use this)
03 | Byte | **Unknown** |
04 | Byte | Number of hands |
05 | Byte | Number of fingers |
06 | Byte[9] | **Unknown** |
0F | Byte | Ammunition type | See below (ammo itself uses this)
10 | Byte | Defense |
11 | Byte | Damage |
12 | Byte | Equip slot | See below
13 | Byte[11] | **Unknown** |
18 | Word | Usable classes | Bitfield
20 | Word | Buy price |
22 | Word | Weight | In grams
24 | Word | KeyID | Special marker for quest items (e.g., door keys)
26 | Word | Name | Item name, as index into the global string table

## Item types

- 00: Armor
- 01: Hat
- 02: Shoes
- 03: Shield
- 04: Melee weapon
- 05: Ranged weapon
- 06: Ammunition
- 07: Text scroll
- 08: Spell scroll
- 09: Potion
- 0A: Chain / Necklace
- 0B: Brooch
- 0C: Ring
- 0D: Special item (clock, compass, etc)
- 0E: Magical item (torch, etc)
- 0F: Key
- 10: Normal item (quest items, etc)

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

## Ammunition types

- 0: None
- 1: Stone
- 2: Arrow
- 3: Bolt
