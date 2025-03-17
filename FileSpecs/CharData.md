# Characters

Party members, NPCs and monsters.

**Note:** This is **WIP** and many values are not present yet as they are not decoded.

| Offset | Type                                | Name                         | Description                                                                                            |
| ------ | ----------------------------------- | ---------------------------- | ------------------------------------------------------------------------------------------------------ |
| 0002   | Byte                                | Type                         | 0: NPC/Player, 1: Monster ?                                                                            |
| 0003   | Byte                                | Gender                       | 0: Male, 1: Female                                                                                     |
| 0004   | Byte                                | Race                         | See below                                                                                              |
| 0005   | Byte                                | Class                        | See below                                                                                              |
| 0006   | Byte                                | Current ATK                  | Attack                                                                                                 |
| 0007   | Byte                                | Current PAR                  | Parry                                                                                                  |
| 0008   | Byte                                | Current SWI                  | Swim                                                                                                   |
| 0009   | Byte                                | Current LIS                  | Listen                                                                                                 |
| 000A   | Byte                                | Current F-T                  | Find traps                                                                                             |
| 000B   | Byte                                | Current D-T                  | Disarm traps                                                                                           |
| 000C   | Byte                                | Current P-L                  | Pick locks                                                                                             |
| 000D   | Byte                                | Current SEA                  | Search                                                                                                 |
| 000E   | Byte                                | Current RMS                  | Read magic scrolls                                                                                     |
| 000F   | Byte                                | Current U-M                  | Use magic                                                                                              |
| 0010   | Byte                                | Max ATK                      | Attack                                                                                                 |
| 0011   | Byte                                | Max PAR                      | Parry                                                                                                  |
| 0012   | Byte                                | Max SWI                      | Swim                                                                                                   |
| 0013   | Byte                                | Max LIS                      | Listen                                                                                                 |
| 0014   | Byte                                | Max F-T                      | Find traps                                                                                             |
| 0015   | Byte                                | Max D-T                      | Disarm traps                                                                                           |
| 0016   | Byte                                | Max P-L                      | Pick locks                                                                                             |
| 0017   | Byte                                | Max SEA                      | Search                                                                                                 |
| 0018   | Byte                                | Max RMS                      | Read magic scrolls                                                                                     |
| 0019   | Byte                                | Max U-M                      | Use magic                                                                                              |
| 001A   | Byte                                | Magic Schools                | Flags; 2: white, 4: grey: 8: black, 128: special                                                       |
| 001B   | Byte                                | Level                        |
| 001C   | Byte                                | Number of used hands?        |
| 001D   | Byte                                | Number of used fingers?      |
| 001E   | Byte                                | DEF                          | Base Defense                                                                                           |
| 001F   | Byte                                | DAM                          | Base Damage                                                                                            |
| 0020   | Byte                                | M-B-W                        | Magic bonus weapon                                                                                     |
| 0021   | Byte                                | M-B-A                        | Magic bonus armour                                                                                     |
| 0022   | Byte[9]                             | Item amounts                 | For equipped items (0 = none)                                                                          |
| 002B   | Byte[12]                            | Item amounts                 | For inventory items (0 = none)                                                                         |
| 0037   | Byte                                | Languages                    | See below                                                                                              |
| 0038   | Byte                                | Current language             | Unused                                                                                                 |
| 0039   | Byte                                | Unused                       | Unused                                                                                                 |
| 003A   | Byte                                | Physical Ailments            | See below                                                                                              |
| 003B   | Byte                                | Mental Ailments              | See below                                                                                              |
| 003D   | Byte                                | Quest Completion Flag        | ID of a flag that toggles which of the two NPC interaction blocks to use, see "NPC Interactions" below |
| 003E   | Byte                                | Battle GFX                   | Graphics used in Battle (Monsters only? PC Icon may depend on class value)                             |
| 0040   | Byte                                | M-B-A                        | Magic armor level                                                                                      |
| 0041   | Byte                                | Morale                       | Monsters flee when that amount in % of same Monster is defeated                                        |
| 0043   | Byte                                | APR                          | Attacks per Round                                                                                      |
| 0044   | Byte                                | Monster flags                | 1: Undead, 2: Demon, 4: Ailment immunity                                                               |
| 0045   | Byte                                | Monster elemental flags      | See below                                                                                              |
| 0048   | Word                                | Current STR                  | Strength                                                                                               |
| 004A   | Word                                | Current INT                  | Intelligence                                                                                           |
| 004C   | Word                                | Current DEX                  | Dexterity                                                                                              |
| 004E   | Word                                | Current SPE                  | Speed                                                                                                  |
| 0050   | Word                                | Current CON                  | Constitution                                                                                           |
| 0052   | Word                                | Current CHA                  | Charisma                                                                                               |
| 0054   | Word                                | Current LUC                  | Luck                                                                                                   |
| 0056   | Word                                | Current MAG                  | Magic?                                                                                                 |
| 0058   | Word                                | Current AGE                  | Age                                                                                                    |
| 005A   | Word                                | Current unused attribute?    | Always 0?                                                                                              |
| 005C   | Word                                | Max STR                      | Strength                                                                                               |
| 005E   | Word                                | Max INT                      | Intelligence                                                                                           |
| 0060   | Word                                | Max DEX                      | Dexterity                                                                                              |
| 0062   | Word                                | Max SPE                      | Speed                                                                                                  |
| 0064   | Word                                | Max CON                      | Constitution                                                                                           |
| 0066   | Word                                | Max CHA                      | Charisma                                                                                               |
| 0068   | Word                                | Max LUC                      | Luck                                                                                                   |
| 006A   | Word                                | Max MAG                      | Magic?                                                                                                 |
| 006C   | Word                                | Max AGE                      | Character will die at this age (race dependent)                                                        |
| 006E   | Word                                | Max unused attribute?        | Always 0?                                                                                              |
| 0071   | Byte                                | Lvl/Att                      | PC gets additional Attack per round every X levels                                                     |
| 0072   | Word                                | HP/lvl                       | (This is not exact, but modified by some yet unknown factors)                                          |
| 0074   | Word                                | SP/lvl                       | (This is not exact, but modified by some yet unknown factors)                                          |
| 0076   | Word                                | SLP/lvl                      | (This is not exact, but modified by some yet unknown factors)                                          |
| 0078   | Word                                | TP/lvl                       | Training Points per level                                                                              |
| 0086   | Word                                | Current HP                   |
| 0088   | Word                                | Max HP                       |
| 008A   | Word                                | Current SP                   |
| 008C   | Word                                | Max SP                       |
| 0090   | Word                                | Current gold                 |
| 0092   | Word                                | Current food                 |
| 0094   | Word                                | Defense                      | Seems to be used by players only? Maybe each byte has a meaning like variable and base defense?        |
| 0096   | Word                                | Damage                       | Seems to be used by players only? Maybe each byte has a meaning like variable and base damage?         |
| 00CC   | Long                                | Experience Points            |
| 00D0   | Long                                | Known spells (white)         | See [Spells](Spells.md)                                                                                |
| 00D4   | Long                                | Known spells (grey)          | See [Spells](Spells.md)                                                                                |
| 00D8   | Long                                | Known spells (black)         | See [Spells](Spells.md)                                                                                |
| 00E8   | Long                                | Known spells (special)       | See [Spells](Spells.md)                                                                                |
| 00EC   | Long                                | Total weight in grams        |
| 00F0   | Byte[16]                            | Name                         | 15 chars for the name and a terminating 0 (the game allows entering 19 chars but only stores 15)       |
| 0100   | Byte[25]                            | Monster spell schools        | See below                                                                                              |
| 0119   | Byte[25]                            | Monster spell ids            | See below                                                                                              |
| 0132   | Item[9]                             | Equipped items               |
| 029A   | Item[12]                            | Inventory items              |
| 047A   | Byte[560]                           | Interactions                 | Up to 20 NPC Interactions (see below)                                                                  |
| 06AA   | [Pixmap](Pixmaps.md))               | Portrait (optional)          | Portrait [Pixmap](Pixmaps.md) with full header.                                                        |
| 08D0   | [CompressedText](CompressedText.md) | Dialogue Messages (optional) |

**Notes**

- If the NPC has no interactions, _Portrait_ and _Dialogue Messages_ are missing (discernible via length of the entire record or by the _Portrait_ entry giving image width `0`).
- Item slots may keep their data even if the slot is empty. The amount value at the top is important. Even if it is 0, the char data might still contain the item data.

Each item is stored as 40 bytes so in contrast to Ambermoon, not only an item slot with a reference to the item is stored but the whole item data for each slot.

## Language Flags

| Bit  | Name     |
| ---- | -------- |
| `01` | Human    |
| `02` | Elf      |
| `04` | Dwarf    |
| `08` | Gnome    |
| `10` | Halfling |
| `20` | Orc      |
| `40` | Animal   |

## Races

| Value | Name     |
| ----- | -------- |
| 0     | Human    |
| 1     | Elf      |
| 2     | Dwarf    |
| 3     | Gnome    |
| 4     | Halfling |
| 5     | Half Elf |
| 6     | Half Orc |
| 13    | Animal   |
| 14    | Monster  |

## Classes

| Value | Name       |
| ----- | ---------- |
| 0     | None       |
| 1     | Warrior    |
| 2     | Paladin    |
| 3     | Ranger     |
| 4     | Thief      |
| 5     | Monk       |
| 6     | White Mage |
| 7     | Grey Mage  |
| 8     | Black Mage |
| 9     | Animal     |
| 10    | Monster    |

## Physical Ailments

| Bit  | Name      |
| ---- | --------- |
| `01` | stunned   |
| `02` | poisoned  |
| `04` | petrified |
| `08` | diseased  |
| `10` | aging     |
| `20` | dead      |
| `40` | ash       |
| `80` | dust      |

## Mental Ailments

| Bit  | Name       |
| ---- | ---------- |
| `01` | irritated  |
| `02` | mad        |
| `04` | sleeping   |
| `08` | afraid     |
| `10` | blind      |
| `20` | overloaded |

## Monster elemental flags

| Bit  | Name             |
| ---- | ---------------- |
| `01` | Fire immune      |
| `02` | Earth immune     |
| `04` | Water immune     |
| `08` | Wind immune      |
| `10` | Fire vulnerable  |
| `20` | Earth vulnerable |
| `40` | Water vulnerable |
| `80` | Wind vulnerable  |

Vulnerable means double damage

## Monster spells

The “learned spells” flags are only used by Characters. For monsters it works like this:

- There are 25 bytes with spell school values, follwed by 25 bytes with spell ids.
- A monster can cast a spell if school[i] is set to a spell school and id[i] is set to the corresponding spell id in this school.
- Example: school[0] = 7, id[0] = 2 means that monster can cast poison., school[1] = 3, id[1] = 20 means it can cast Whirlwind.
- A monster can have the same spell in multiple slots, probably increasing the chance of casting it (needs confirmation).

For values see [Spells](Spells.md)

## NPC Interactions

Each NPC has up to 20 _NPC Interactions_, which are split into two blocks of 10:

- 10 _Incomplete Quest_ interactions (available when the _Quest Completion Flag_ for this NPC is **not** set)
- 10 _Completed Quest_ interactions (avialable when the _Quest Completion Flag_ for this NPC **is** set)

Only one of these two blocks is available at any given time. Initially, the Quest Completion Flags for all NPCs
are not set. Not all NPCs use a Quest Completion Flag, in which case their second 10 interactions are not accessible
(and unused, in practice).

Each interaction consists of an interaction type and key that are the triggers for the interaction,
and five _Reactions_. Amberstar encodes these as follows:

| Global Offset | Type        | Description               |
| ------------- | ----------- | ------------------------- |
| 047A          | Byte[20]    | Interaction Trigger Types |
| 048E          | Word[20]    | Interaction Trigger Key   |
| 04B6          | Byte[5][20] | Reaction Types            |
| 051A          | Byte[5][20] | Reaction arguments 0      |
| 057E          | Byte[5][20] | Reaction arguments 1      |
| 05E2          | Word[5][20] | Reaction arguments 2      |

where:

- indices `0`..`9` are _Incomplete Quest_ interactions
- indices `10`..`19` are _Completed Quest_ interactions
- Byte[5][20] means 5 bytes for interaction `0`, followed by 5 bytes for interaction `1` etc.

### Interaction Triggers

| Trigger Type | Name  | Trigger Key | Meaning                                                                     |
| ------------ | ----- | ----------- | --------------------------------------------------------------------------- |
| `00`         | Empty |             | No interaction stored here                                                  |
| `01`         | Ask   | _keyword_   | Ask NPC about _keyword_ (player must have learned _keyword_ first)          |
| `02`         | Show  | _KeyID_     | Show item with _KeyID_ (cf. [Items](Items.md) to NPC                        |
| `03`         | Give  | _KeyID_     | Give item with _KeyID_ (cf. [Items](Items.md) to NPC                        |
| `04`         | Pay   | _amount_    | Pay _amount_ gp to NPC. Must be the exact right amount, or NPC will refuse. |
| `05`         | Feed  | _amount_    | Give food to NPC (used only for Spike).                                     |
| `06`         | Join  |             | Ask NPC to join.                                                            |

**Notes**

- _Give_, _Pay_, and _Feed_ will implicitly remove the item / gp / food that is offered to the NPC.
- _Join_ will implicitly add the NPC to the party (if possible, otherwise the interaction presumably does not trigger (?)).

### Reactions

| Reaction Type | Name          | Arg0   | Arg1 | Arg2      | Meaning                                                                                                            |
| ------------- | ------------- | ------ | ---- | --------- | ------------------------------------------------------------------------------------------------------------------ |
| `00`          | None          |        |      |           | No reaction                                                                                                        |
| `01`          | Say           |        |      | _msg_     | Says string _msg_ from the NPC's Dialogue Message table                                                            |
| `02`          | TeachWord     |        |      | _keyword_ | Teaches the party the given _keyword_ for future dialogue                                                          |
| `03`          | GiveItem      |        |      | _index_   | Gives the party a copy of the item at the NPC's item _index_ (`0`: first equipped item, `a`: first inventory item) |
| `04`          | GiveGold      |        |      | _gp_      | Gives the specified number of _gp_                                                                                 |
| `05`          | GiveFood      |        |      | _amount_  | Gives the specified _amount_ of food                                                                               |
| `06`          | CompleteQuest |        |      | _flag_    | Sets the specified Quest Completion _flag_                                                                         |
| `07`          | RaiseStat     | _stat_ | `1`  | _amount_  | Increases the given _stat_ (u16 / Word) by the given _amount_                                                      |
| `07`          | SetFlag       | _stat_ | `4`  | _bitnr_   | Sets the *bitnr*th bit in the given _stat_ (u8 / Byte)                                                             |

**Notes**

- _GiveItem_ will clone the NPC's item. This happens e.g. if the players ask repeatedly for a key to the sewers-- they can get as many keys as they would like.
- _CompleteQuest_ can affect some other NPC's quest completion flag, hence the need for an explicit parameter. In the game, Mera can set Shir'kar's quest flag, allowing the party to recruit Shir'kar.
- The NPCs Satine and Shandra share their quest completion flags, so that Satine's interaction options change when Shandra's quest is completed
- _RaiseStat_ uses offsets into character data to identify the stat to raise, so e.g. _stat_=`004E` will raise the "Speed" stat.
- _RaiseStat_ uses offset `00cc` to raise experience points. This is two bytes before the actual experience point stat; this extra word is likely used to "stage" imminent experience raises
- _SetFlag_ is only used with _stat_ = `0037` to teach the first character in the party a new language.
