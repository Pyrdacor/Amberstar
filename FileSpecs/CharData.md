# Characters

Party members, NPCs and monsters.

**Note:** This is **WIP** and many values are not present yet as they are not decoded.

Offset | Type | Name | Description
--- | --- | --- | ---
0002 | Byte | Type | 0: NPC/Player, 1: Monster ?
0003 | Byte | Gender | 0: Male, 1: Female
0004 | Byte | Race | 0: Human, 14: Animal?
0005 | Byte | Class | 0: None, 10: Animal?
0006 | Byte | Current ATK | Attack
0007 | Byte | Current PAR | Parry
0008 | Byte | Current SWI | Swim
0009 | Byte | Current LIS | Listen
000A | Byte | Current F-T | Find traps
000B | Byte | Current D-T | Disarm traps
000C | Byte | Current P-L | Pick locks
000D | Byte | Current SEA | Search
000E | Byte | Current RMS | Read magic scrolls
000F | Byte | Current U-M | Use magic
0010 | Byte | Max ATK | Attack
0011 | Byte | Max PAR | Parry
0012 | Byte | Max SWI | Swim
0013 | Byte | Max LIS | Listen
0014 | Byte | Max F-T | Find traps
0015 | Byte | Max D-T | Disarm traps
0016 | Byte | Max P-L | Pick locks
0017 | Byte | Max SEA | Search
0018 | Byte | Max RMS | Read magic scrolls
0019 | Byte | Max U-M | Use magic
001C | Byte | Number of used hands? |
001D | Byte | Number of used fingers? |
0022 | Byte[9] | Item amounts | For equipped items (0 = none)
002B | Byte[12] | Item amounts | For inventory items (0 = none)
0048 | Word | Current STR | Strength
004A | Word | Current INT | Intelligence
004C | Word | Current DEX | Dexterity
004E | Word | Current SPE | Speed
0050 | Word | Current CON | Constitution
0052 | Word | Current CHA | Charisma
0054 | Word | Current LUC | Luck
0056 | Word | Current MAG | Magic?
0058 | Word | Current AGE | Age
005A | Word | Current unused attribute? | Always 0?
005C | Word | Max STR | Strength
005E | Word | Max INT | Intelligence
0060 | Word | Max DEX | Dexterity
0062 | Word | Max SPE | Speed
0064 | Word | Max CON | Constitution
0066 | Word | Max CHA | Charisma
0068 | Word | Max LUC | Luck
006A | Word | Max MAG | Magic?
006C | Word | Max AGE | Character will die at this age (race dependent)
006E | Word | Max unused attribute? | Always 0?
0086 | Word | Current HP |
0088 | Word | Max HP |
008A | Word | Current SP? |
008C | Word | Max SP? |
0090 | Word | Current gold |
0092 | Word | Current food |
0094 | Word | Defense | Seems to be used by players only? Maybe each byte has a meaning like variable and base defense?
0096 | Word | Damage | Seems to be used by players only? Maybe each byte has a meaning like variable and base damage?
00EC | Long | Total weight in grams |
00F0 | Byte[16] | Name | 15 chars for the name and a terminating 0 (the game allows entering 19 chars but only stores 15)
0132 | Item[9] | Equipped items |
029A | Item[12] | Inventory items |
06C0 | Byte[528] | Portrait graphic data | Most likely 32x33 pixels with 4bpp (not present for monsters)
08D0 | Byte | Number of NPC events? (not present for monsters), I think if this is 0, 3 zero bytes are appended to ensure long-word boundary but can also have different meaning

**Note**: Item slots may keep their data even if the slot is empty. The amount value at the top is important. Even if it is 0, the char data might still contain the item data.