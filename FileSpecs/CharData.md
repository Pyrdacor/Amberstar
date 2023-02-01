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
0037 | Byte | Languages | See below
003D | Byte | Quest Completion Flag | ID of a flag that toggles which of the two NPC interaction blocks to use, see "NPC Interactions" below
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
00CE | Word | Experience Points
00EC | Long | Total weight in grams |
00F0 | Byte[16] | Name | 15 chars for the name and a terminating 0 (the game allows entering 19 chars but only stores 15)
0132 | Item[9] | Equipped items |
029A | Item[12] | Inventory items |
047A | Byte[560] | Interactions | Up to 20 NPC Interactions (see below)
06AA | [Pixmap](Pixmaps.md)) | Portrait (optional) | Portrait [Pixmap](Pixmaps.md) with full header.
08D0 | [CompressedText](CompressedText.md) | Dialogue Messages (optional)

**Notes**
- If the NPC has no interactions, *Portrait* and *Dialogue Messages* are missing (discernible via length of the entire record or by the *Portrait* entry giving image width `0`).
- Item slots may keep their data even if the slot is empty. The amount value at the top is important. Even if it is 0, the char data might still contain the item data.

Each item is stored as 40 bytes so in contrast to Ambermoon, not only an item slot with a reference to the item is stored but the whole item data for each slot.

## Language Flags
|------|----------|
| `01` | Human    |
| `02` | Elf      |
| `04` | Dwarf    |
| `08` | Gnome    |
| `10` | Halfling |
| `20` | Orc      |
| `40` | Animal   |

## NPC Interactions

Each NPC has up to 20 *NPC Interactions*, which are split into two blocks of 10:
- 10 *Incomplete Quest* interactions (available when the *Quest Completion Flag* for this NPC is **not** set)
- 10 *Completed Quest* interactions (avialable when the *Quest Completion Flag* for this NPC **is** set)

Only one of these two blocks is available at any given time.  Initially, the Quest Completion Flags for all NPCs
are not  set.  Not all NPCs use a Quest Completion Flag, in which case their second 10 interactions are not accessible
(and unused, in practice).

Each interaction consists of an interaction type and key that are the triggers for the interaction,
and five *Reactions*.  Amberstar encodes these as follows:

| Global Offset | Type        | Description               |
|---------------|-------------|---------------------------|
| 047A          | Byte[20]    | Interaction Trigger Types |
| 048E          | Word[20]    | Interaction Trigger Key   |
| 04B6          | Byte[5][20] | Reaction Types            |
| 051A          | Byte[5][20] | Reaction arguments 0      |
| 057E          | Byte[5][20] | Reaction arguments 1      |
| 05E2          | Word[5][20] | Reaction arguments 2      |

where:
- indices `0`..`9` are *Incomplete Quest* interactions
- indices `10`..`19` are *Completed Quest* interactions
- Byte[5][20] means 5 bytes for interaction `0`, followed by 5 bytes for interaction `1` etc.


### Interaction Triggers

| Trigger Type | Name  | Trigger Key | Meaning                                                                      |
|--------------|-------|-------------|------------------------------------------------------------------------------|
| `00`         | Empty |             | No interaction stored here                                                   |
| `01`         | Ask   | *keyword*   | Ask NPC about *keyword* (player must have learned *keyword* first)           |
| `02`         | Show  | *KeyID*     | Show item with *KeyID* (cf. [Items](Items.md) to NPC                         |
| `03`         | Give  | *KeyID*     | Give item with *KeyID* (cf. [Items](Items.md) to NPC                         |
| `04`         | Pay   | *amount*    | Pay *amount* gp to NPC.  Must be the exact right amount, or NPC will refuse. |
| `05`         | Feed  | *amount*    | Give food to NPC (used only for Spike).                                      |
| `06`         | Join  |             | Ask NPC to join.                                                                             |

**Notes**
- *Give*, *Pay*, and *Feed* will implicitly remove the item / gp / food that is offered to the NPC.
- *Join* will implicitly add the NPC to the party (if possible, otherwise the interaction presumably does not trigger (?)).


### Reactions

| Reaction Type | Name          | Arg0   | Arg1 | Arg2      | Meaning                                                                                                            |
|---------------|---------------|--------|------|-----------|--------------------------------------------------------------------------------------------------------------------|
| `00`          | None          |        |      |           | No reaction                                                                                                        |
| `01`          | Say           |        |      | *msg*     | Says string *msg* from the NPC's Dialogue Message table                                                            |
| `02`          | TeachWord     |        |      | *keyword* | Teaches the party the given *keyword* for future dialogue                                                          |
| `03`          | GiveItem      |        |      | *index*   | Gives the party a copy of the item at the NPC's item *index* (`0`: first equipped item, `a`: first inventory item) |
| `04`          | GiveGold      |        |      | *gp*      | Gives the specified number of *gp*                                                                                 |
| `05`          | GiveFood      |        |      | *amount*  | Gives the specified *amount* of food                                                                               |
| `06`          | CompleteQuest |        |      | *flag*    | Sets the specified Quest Completion *flag*                                                                         |
| `07`          | RaiseStat     | *stat* | `1`  | *amount*  | Increases the given *stat* (u16 / Word) by the given *amount*                                                      |
| `07`          | SetFlag       | *stat* | `4`  | *bitnr*   | Sets the *bitnr*th bit in the given *stat* (u8 / Byte)                                                             |

**Notes**
- *GiveItem* will clone the NPC's item.  This happens e.g. if the players ask repeatedly for a key to the sewers-- they can get as many keys as they would like.
- *CompleteQuest* can affect some other NPC's quest completion flag, hence the need for an explicit parameter.  In the game, Mera can set Shir'kar's quest flag, allowing the party to recruit Shir'kar.
- The NPCs Satine and Shandra share their quest completion flags, so that Satine's interaction options change when Shandra's quest is completed
- *RaiseStat* uses offsets into character data to identify the stat to raise, so e.g. *stat*=`004E` will raise the "Speed" stat.
- *RaiseStat* uses offset `00cc` to raise experience points.  This is two bytes before the actual experience point stat; this extra word is likely used to "stage" imminent experience raises
- *SetFlag* is only used with *stat* = `0037` to teach the first character in the party a new language.
