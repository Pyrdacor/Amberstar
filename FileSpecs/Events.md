# Events

Events are part of [Maps](Maps.md), tied to "hotspots" on particular map tiles and triggered under certain conditions.
Unless noted otherwise, the condition is that the player enters the hotspot tile.
- Events are encoded in 10 bytes, summarised below, with the byte at offset `00` in column ID.
- At offsets 6 and 8 there are words, in all other offsets single bytes.
- At offset 5 there is always a save index which specifies an index inside the savegame.
Saving means that the event is disabled if the associated save index bit is set. This is useful for one-time events.
If the byte is non-zero the event will disable itself after execution. When triggered again and the save bit is already
set, the event is not executed anymore.
There are two exceptions:
  - Chest events are always executed, even if disabled. Most likely to allow checking chests for more items and because empty chests won't show anything anyways.
  - Disabled door exit events will not be executed but their linked additional event is.
- We won't include offset 5 in the following table as it has the same meaning for all events.

| Name                   | Where | ID   | `01`   | `02`    | `03`    | `04`    | `06`      | `08`      | Automap     |
|------------------------|-------|------|--------|---------|---------|---------|-----------|-----------|-------------|
| **ChangeMap**          |       | `01` | *x*    | *y*     | *dir*   | `00`    | *map*     | `0000`    | Exit        |
| **Door**               |       | `02` | *cr*   | *trap*  | *dmg*   | `00`    | *item*    | `0000`    | Door        |
| **Message**            |       | `03` | *img*  | *msg*   | *act*   | `00`    | *kw*      | `0000`    | /           |
| **Chest**              |       | `04` | *cr*   | *trap*  | *dmg*   | *hid*   | *chest*   | *msg*     | Treasure    |
| **Trapdoor**           |       | `05` | *x*    | *y*     | *floor* | *msg*   | *map*     | *dmg*     | /           |
| **Teleport**           |       | `06` | *x*    | *y*     | *dir*   | *msg*   | *map*     | `0000`    | Teleporter  |
| **WindGate**           |       | `07` | *x*    | *y*     | *dir*   | *msg*   | *map*     | `0000`    |             |
| **Spinner**            | 3D    | `08` | *dir*  | `00`    | `00`    | *msg*   | `0000`    | `0000`    |             |
| **TakeDamage**         |       | `09` | *max*  | *sex*   | `00`    | *msg*   | `0000`    | `0000`    |             |
| **AntiMagic**          |       | `0a` | *buf*  | `00`    | `00`    | *msg*   | `0000`    | `0000`    |             |
| **RestoreLP**          | 2D    | `0b` | *hp*   | `00`    | `00`    | *msg*   | `0000`    | `0000`    | /           |
| **RestoreSP**          | 2D    | `0c` | *sp*   | `00`    | `00`    | *msg*   | `0000`    | `0000`    | /           |
| **Trap**               |       | `0d` | *trap* | `00`    | *dmg*   | *msg*   | `0000`    | `0000`    | /           |
| **Riddlemouth**        |       | `0e` | *x*    | *y*     | *greet* | *reply* | *kw*      | *tile*    | Riddlemouth |
| **ChangeStat**         |       | `0f` | *stat* | *add*   | *rnd*   | *msg*   | *target*  | *amount*  |             |
| **ChangeTile**         |       | `10` | *x*    | *y*     | `00`    | *msg*   | *tile*    | `0000`    |             |
| **Fight**              |       | `11` | *ch*   | *quest* | *msg1*  | *msg2*  | *mgroup*  | `0000`    |             |
| **Place**              |       | `12` | *open* | *close* | *type*  | *msg*   | *placeID* | *waresID* | Merchant    |
| **ChangeTileWithTool** |       | `13` | *x*    | *y*     | `00`    | *msg*   | U13.6     | U13.9     |             |
| **Door3D**             | 3D    | `14` | `01`   | `00`    | `00`    | U14.4   | U14.7     | `0000`    |             |
| **ChangeMapAlt**       | 2D    | `15` | *x*    | *y*     | *dir*   | `00`    | *map*     | `0000`    |             |
| **Altar**              | 2D    | `16` | `00`   | `00`    | `00`    | `00`    | `0000`    | `0000`    |             |
| **Win**                | 2D    | `17` | `00`   | `00`    | `00`    | `00`    | `0000`    | `0000`    |             |


* Column `Where` indicates whether the event only appears in 2D or 3D maps.
* Parameters of the form "U00.0" indicate an unknown parameter.
* `00` indicates that this paramter always appears as `00`.

This information is observational: the Amberstar *engine* might support more options values, but the *game* does not seeem to use them (unless events can be triggered in other ways than observed so far).

<!-- ---------------------------------------- -->
## Event 01: ChangeMap

Teleports the party to the specified *map* - 1, coordinates (*x*, *y*).

`dir` is the direction that the player will be facing:

| `dir` | Direction |
|-------|-----------|
| `0`   | North     |
| `1`   | East      |
| `2`   | South     |
| `3`   | West      |
| `4`   | Keep      |

<!-- ---------------------------------------- -->
## Event 02: Door

Party encounters a locked door.

*cr* reduces the lock-picking chance. If it is 100, the lock can't be picked at all (not even with a lockpick item)
and requires a special item given in *item*. If below 100, the value is subtracted from the active player's lockpicking skill
and then a random check against the remaining value is performed. The lockpick item can be used to open the lock with 100% chance
if *cr* is below 100 regardless of the value.

If *trap* is non-zero it specifies a trap type (see the Trap event). Only then *dmg* gives the maximum damage of the trap.


<!-- ---------------------------------------- -->
## Event 03: Message
*Trigger*:
- if *act* = `0`: enter tile
- if *act* = `1`: look at tile
- if *act* >= `2`: looking or entering

Displays message *msg*, from the local `MAPTEXT.AMB` resources, and possibly shows image *img* - 1 from `PICS80.AMB`, if *img* is nonzero.
The party learns the dictionary keywords *kw* for use in conversation with NPCs.

<!-- ---------------------------------------- -->
## Event 04: Chest
*Trigger*: Looking

The party accesses the that contains the items from `CHESTDAT.AMB` resource number *chest*, while displaying message *msg*. Once the chest is empty,
the game records this fact with chest flag *flagID* and no longer allows chest access.

If *hid* is non-zero the chest is hidden and a skill check against the active player's search skill is performed. If it fails, the chest is not shown.

The gold for this chest is stored in u16 values in `PARTYDAT.SAV`, starting at `00001ef0` for chest `01`.

*cr* reduces the lock-picking chance. If it is 100, the lock can't be picked by the skill at all. Chests can not specify
a key item. They can only be opened by the lockpick item or the skill. If below 100, the value is subtracted from the active player's lockpicking skill
and then a random check against the remaining value is performed. The lockpick item can be used to open the lock with 100% chance regardless of the value.
A value of 0 means that the chest is initially opened and no lock has to be picked.

If *trap* is non-zero it specifies a trap type (see the Trap event). Only then *dmg* gives the maximum damage of the trap.

<!-- ---------------------------------------- -->
## Event 05: Trapdoor

When looking at this field, the game reports it as a trapdoor.
Works similarly to ChangeMap (Event `01`).

Teleports the party to the given location (*x* and *y*) on the given *map*.

If *msg* is non-zero it is displayed before the fall.

If *floor* is set, the party falls down and receives random damage in the range of 1 to *dmg*.

If *floor* is not set, the party climbs up but receives *no damage*. Most likely only triggered if the levitation spell is used.

<!-- ---------------------------------------- -->
## Event 06: Teleport

Works similarly to ChangeMap (Event `01`).

But it can display an optional *msg* before the teleport.

If the map index is the current map, there will be no fading.

<!-- ---------------------------------------- -->
## Event 07: WindGate

Exactly the same as Teleport (Event `06`) but will abort early if you don't possess the wind chain item.

<!-- ---------------------------------------- -->
## Event 08: Spinner

When entering or leaving this tile, the party is rotated to face direction *dir* (cf. Event 01).
If *dir* is `4`, the direction is randomly selected every time the party enters or leaves the tile. This random direction can never be the same as the initial direction.

The optional *msg* can be shown before the spin.

<!-- ---------------------------------------- -->
## Event 09: TakeDamage

The players take between 1..*max* damage.

| `sex` | Affected    |
|-------|-------------|
| `0`   | Male only   |
| `1`   | Female only |
| `2`   | Both        |

The optional *msg* can be shown before the damaging.

<!-- ---------------------------------------- -->
## Event 0a: AntiMagic

Removes one or all active spells (buffs).

| `buf` | Meaning      |
|-------|--------------|
| `0`   | All spells   |
| `1`   | Light        |
| `2`   | Magic Armor  |
| `3`   | Magic Weapon |
| `4`   | Anti Magic   |
| `5`   | Clairvoyance |
| `6`   | Invisibility |

The optional *msg* can be shown before the debuff.

<!-- ---------------------------------------- -->
## Event 0b: RestoreLP

Restores *hp* life points and displays *msg* as a popup message in the style of **Message**.

If *hp* is zero, the full hp is filled up instead.

Only used in Sir Marillon's Tomb. And there with *hp* = 0.

<!-- ---------------------------------------- -->
## Event 0c: RestoreSP

Restores *sp* spell points and displays *msg* as a popup message in the style of **Message**.

If *sp* is zero, the full sp is filled up instead.

Only used in Sir Marillon's Tomb. And there with *sp* = 0.

<!-- ---------------------------------------- -->
## Event 0d: Trap

Triggers a trap of type *trap*. There are 7 predefined traps.

| `trap` | Meaning              | Affected      | Message
|--------|----------------------|---------------|--------
| `0`    | _none_               |               |
| `1`    | Damage Trap          | All members   | 7
| `2`    | Poison Needle        | Active player | 8
| `3`    | Poison Gas Cloud     | All members   | 9
| `4`    | Blinding Flash       | All members   | 10
| `5`    | Paralyzing Gas Cloud | All members   | 11
| `6`    | Stone Gaze           | Active player | 12
| `7`    | Disease              | Active player | 13

Only the Damage Trap will deal damage in the range 1..*dmg*. All other traps will just add some condition.

The optional *msg* can be shown before the trap is triggered. However each trap will display a fixed message as well shown in the table above.

<!-- ---------------------------------------- -->
## Event 0e: Riddlemouth

Greets party with message *greet*.  If the party replies with *kw*, the Riddlemouth gives its *reply*.

If *tile* is non-zero the map tile at *x*, *y* will be changed to *tile* after solving the riddle.

<!-- ---------------------------------------- -->
## Event 0f: ChangeStat

- If *add* is non-zero, increases the given *stat* of the targets by *amount*.
- If *add* is zero, decreases the given *stat* of the targets by *amount*.

If *target* is 0, all party members are affected, otherwise only the active player.

*stat* 1 means "strength", 2 means "intelligence" etc.

If *rnd* is non-zero the actual amount will be a random value in the range of 1..*amount* instead.

The optional *msg* can be shown before the stat is changed.

<!-- ---------------------------------------- -->
## Event 10: ChangeTile

Replaces the tile at coordiantes (*x*, *y*) on the current map by tile number *tile*.

The optional *msg* can be shown before the tile is changed.

<!-- ---------------------------------------- -->
## Event 11: Fight

Starts a fight with the monster group *mgroup* (`MON_DATA.AMB` encounter reference).

*ch* gives the chance in percent of starting the fight. A random check is performed against that value.

If *quest* is non-zero this specifies a quest bit inside the savegame. The fight only starts if the quest bit is set.

The message *msg1* is shown for quests, and *msg2* otherwise.

<!-- ---------------------------------------- -->
## Event 12: Place

Place open from *open*-*close*, or around the clock if *open* is `00`.
- If the party tries to enter outside of the opening hours, shows *msg* and pushes the player back to the previous tile.

The place's name and further details are stored in `AMBERDEV.UDO` and indexed by *placeID*.  For late versions of the (English version of the) game, the offsets are:
- Name: index 1 starts at `4b238`, each name is 30 characters long and padded with blanks
- Details: index 1 starts at `4add0`, each entry is `18` (hex) / 24 (decimal) bytes in length

The place data consists of 12 words (24 bytes) which has different meaning for each place. In the following table the relevant
data is shown in the `Place data` column. The numbers give the byte offsets into the place data and each value is a word.

| *type* | Name                       | Place data
|--------|----------------------------|-------------------------------------------------------------
| `01`   | Guild of Warriors          | `0`: Join price, `2`: Level up price
| `02`   | Guild of Paladines         | `0`: Join price, `2`: Level up price
| `03`   | Guild of Rangers           | `0`: Join price, `2`: Level up price
| `04`   | Guild of Thieves           | `0`: Join price, `2`: Level up price
| `05`   | Guild of Monks             | `0`: Join price, `2`: Level up price
| `06`   | Guild of the White Wizards | `0`: Join price, `2`: Level up price
| `07`   | Guild of the Grey Wizards  | `0`: Join price, `2`: Level up price
| `08`   | Guild of the Black Wizards | `0`: Join price, `2`: Level up price
| `09`   | Merchant                   | **unused**
| `0a`   | Food shop                  | `0`: Price per food
| `0b`   | **unused and invalid**     |
| `0c`   | Horse Merchant             | `0`: Price, `2`: X, `4`: Y, `6`: Map, `8`: Transport Type
| `0d`   | Healer                     | See below
| `0e`   | Sage                       | `0`: Price for identification
| `0f`   | Raft Merchant              | `0`: Price, `2`: X, `4`: Y, `6`: Map, `8`: Transport Type
| `10`   | Boat Merchant              | `0`: Price, `2`: X, `4`: Y, `6`: Map, `8`: Transport Type
| `11`   | Guest House / Inn          | `0`: Price for a room
| `12`   | Library                    | **unused**

The library is almost the same as the merchant (`09`), but with different picture and he usually sells scrolls instead of other items.

*waresID* is the `WARESDAT.AMB` reference and is only used for place type `09` and `12`.

The healer place data is shown here as it is quite big:

| Offset | Meaning
|--------|----------------------
| `00`   | Price to heal XY
| `02`   | Price to heal XY
| `04`   | Price to heal XY
| `06`   | Price to heal XY
| `08`   | Price to heal XY
| `0a`   | Price to heal XY
| `0c`   | Price to heal XY
| `0e`   | Price to heal XY
| `10`   | Price to heal XY
| `12`   | Price to heal XY
| `14`   | Price to remove curse

<!-- ---------------------------------------- -->
## Event 13: UnblockWithTool

Seems to be used to allow players to change a tile if they have the right tool (probably with key U13.7, and probably into tile U13.9).

### Unknowns
* What does this do?
* What do the unknown parameters do?
<!--
    INCOMPLETE event op type 13 {mask:1f/exclusive:12,14,18}  [06,08,10-12]        [00]  [00,02-05,1a]  [01,03,05-08]  [00]        [d2-d6,ea,fd]                          [00]  [8d,ae,b0,d9]
    INCOMPLETE event op type 13 {mask:3f/exclusive:30}  {mask:3f/exclusive:24,30}  [00]  [00-01,03-14,1a]  [01-18,2b]  [00-01]  [02,06,18,1e-1f,aa,ad,ba-c1,c4-cb,cf,fe]  [00]  [01,04-06]
-->

<!-- ---------------------------------------- -->
## Event 14: Door3D

Only used twice, in the `CITY OF TWINLAKE` map (`0x42`).

## Unknowns
* What does this do?  How is it different from **Door**?
* U14.04: [`11`, `1c`]
- U14.05: [`03`, `04`]
- U14.07: [`97`, `9b`]

<!-- ---------------------------------------- -->
## Event 15: ChangeMapAlt

Seems to operate the same as Event 01.
Perhaps this event has different behaviour when flying?

### Unknowns
* How is this different from Event 01?

<!-- ---------------------------------------- -->
## Event 16: Altar

Checks for whether the player has all pieces of the Amberstar.
If so, allows them to try to assemble it.
Otherwise, pushes the player back to the previous tile.

<!-- ---------------------------------------- -->
## Event 17: Win
Triggers the end-game sequence.
