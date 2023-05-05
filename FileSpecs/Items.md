# Items

**Note:** This is **WIP** and many values are not present yet as they are not decoded.


Size: 40 Bytes (0x28)

Offset | Type | Name | Description
--- | --- | --- | ---
00 | Byte | Graphic index |
01 | Byte | Item type | See below
02 | Byte | Used ammunition type | See below (slings, bows or crossbows use this)
03 | Byte | **Unknown** | Only the 3 Sansri items have a value of 2 here
04 | Byte | Number of hands |
05 | Byte | Number of fingers |
06 | Byte | Hit points | Adds to max HP
07 | Byte | Spell points | Adds to max SP
08 | Byte | Attribute | 0: None, 1+: Strength, ...
09 | Byte | Attribute value | Value to add to the given attribute
0A | Byte | Skill | 0: None, 1+: Attack, ...
0B | Byte | Skill value | Value to add to the given skill
0C | Byte | Spell school | 0: None, 1: White, 2: Gray, 3: Black
0D | Byte | Spell index | 0: None, 1+ is the index inside the given school
0E | Byte | Spell charges | Number of spells one can cast from the item
0F | Byte | Ammunition type | See below (ammo itself uses this)
10 | Byte | Defense |
11 | Byte | Damage |
12 | Byte | Equip slot | See below
13 | Byte | M-B-W | Magic weapon level
14 | Byte | M-B-A | Magic armor level
15 | Byte | Special index | For special items it gives the type (see below), for text scrolls it is the text list index inside CODETXT.AMB (1 or 2)
16 | Byte[7] | **Unknown** |
1D | Byte | Text index | For text scrolls the index inside the given text list
1E | Word | Usable classes | Bitfield
20 | Word | Buy price |
22 | Word | Weight | In grams
24 | Word | KeyID | Special marker for quest items (e.g., door keys)
26 | Word | NameID | Item name, as index into the global string table

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

## Special item types

- 0: None
- 1: Compass
- 2: **Unknown**
- 3: Magical picture
- 4: Wind chain
- 5: Map locator
- 6: Clock

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
