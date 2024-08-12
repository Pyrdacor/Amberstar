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
| **Riddlemouth**        |       | `0e` | U0e.1  | U0e.2   | *greet* | *reply* | *kw*      | U0e.9     | Riddlemouth |
| **RaiseStat**          |       | `0f` | *stat* | U0f.2   | `01`    | *msg*   | `0000`    | U0f.9     |             |
| **ChangeTile**         |       | `10` | *x*    | *y*     | `00`    | *msg*   | *tile*    | `0000`    |             |
| **Fight**              |       | `11` | U11.1  | `00`    | U11.3   | U11.4   | U11.7     | `0000`    |             |
| **Merchant**           |       | `12` | *open* | *close* | *type*  | *msg*   | *merchID* | *waresID* | Merchant    |
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

### Unknowns
* What do the unknown parameters do?
<!--
    INCOMPLETE event op type 0e {mask:3f/exclusive:11,22,24,28}  {mask:1f/exclusive:09,18}  [00-04]                       [01-03,05,08]  [01-04]  [01,06]  [49,4f-52,56,87]  [00]  [4a-4b,52,af,e9]
    INCOMPLETE event op type 0e {mask:3f/exclusive:21,22,30}     {mask:3f/exclusive:28}     {mask:1f/exclusive:06,18,12}  [01-07,0c,0e,12,16]  {mask:3f/exclusive:32,34,18}  [01-04,07,09,0b-0d]  {mask:ff}  [00]  [00-02,04-05]
-->
<!-- ---------------------------------------- -->
## Event 0f: RaiseStat

* Raises one of the stats of some party member (the first? random?) by one point and shows message *msg*
  - *stat* 1 means "strength", 2 means "intelligence" etc.

### Unknowns
* What do the unknown parameters do?
<!--
    INCOMPLETE event op type 0f [03,05-06]  [00-01]  [01]  [18-19]  [1b-1d]  [00]  [00]  [00]  [0f,14]
    INCOMPLETE event op type 0f [01-02]        [00]  [01]  [08-09]  [0a,12]  [00]  [00]  [00]  [0a]
-->
<!-- ---------------------------------------- -->
## Event 10: ChangeTile

- If *flagID* is not `0` and the corresponding state flag is already set, does nothing
- Shows *msg*
- Replaces the tile at coordiantes (*x*, *y*) on the current map by tile number *tile*
- If *flagID* is not `0`, set the state flag indicated by *flagID*

### Unknowns
* Which other event types are the *flagID* shared with?
<!--
    INCOMPLETE event op type 10 [0b,11-12,14,16,1a,1c,1f]  [0d-0f,13,22]  [00]  [02,04,13,1a]           [00-01,04-07,10-11]  [00]  [13,19,4b,52,ef]  [00]  [00]
    INCOMPLETE event op type 10 {mask:3f/exclusive:28,30}  {mask:3f}      [00]  [01-04,0b,0e-11,1a]  [00-02,08,0e-10,19-20]  [00]  [01-02,04-05]  [00]  [00]
-->
<!-- ---------------------------------------- -->
## Event 11: Fight

Starts a fight
- U11.1 seems to be the probability (in percent)?
- U11.7 might be the `MON_DATA.AMB` encounter reference

### Unknowns
* What do the unknown parameters do?
<!--
    INCOMPLETE event op type 11 {mask:7f}  [00]  [00,1a]  [01,1a]  [00-07]     [00]  {mask:7f/exclusive:12,44,48,60}  [00]  [00]
    INCOMPLETE event op type 11 [64]       [00]  [00]  [01,07,1a]  [03,06,08]  [00]  [04,33,3d]                       [00]  [00]
-->
<!-- ---------------------------------------- -->
## Event 12: Merchant

Merchant open from *open*-*close*, or around the clock if both are `00`.
- If the party tries to enter outside of the opening hours, shows *msg* and pushes the player back to the previous tile.

The merchant's name and further details are stored in `AMBERDEV.UDO` and indexed by *merchID*.  For late versions of the (English version of the) game, the offsets are:
- Name: index 1 starts at `4b238`, each name is 30 characters long and padded with blanks
- Details: index 1 starts at `4add0`, each entry is `18` (hex) / 24 (decimal) bytes in length
  - `00`: u16: cost for basic services
  - `02`: for raft seller: raft location x
  - `04`: for raft seller: raft location y
  - `06`: for raft seller: raft map

- The shop *type* is one of:
  - `01`: Guild of Warriors
  - `02`: Guild of Paladines
  - `03`: Guild of Rangers
  - `04`: Guild of Thieves
  - `05`: Guild of Monks
  - `06`: Guild of the White Wizards
  - `07`: Guild of the Grey Wizards
  - `08`: Guild of the Black Wizards
  - `09`: Merchant
  - `0a`: Food shop
  - `0b`: **unused and invalid**
  - `0c`: Horse Merchant
  - `0d`: Healer
  - `0e`: Sage
  - `0f`: Raft Merchant
  - `10`: Boat Merchant
  - `11`: Guest House
  - `12`: Library (same as `09`, but with different picture)
- To be verified: *waresID* is likely the `WARESDAT.AMB` reference

### Unknowns
* What do the unknown parameters do?
<!--
    INCOMPLETE event op type 12 {mask:1f/exclusive:14,18}  [00,0f,12,14,16]  [00,02-0a,0d,10-12]  [00-04,1a]  [00]  [00]  {mask:3f/exclusive:30}     [00]  [00,02-08,0c-0d]
    INCOMPLETE event op type 12 [00-01,06-0a,0c-0d]  [00,07,0f-12,14,16]  [01,09-0a,0c-10]  [00,05,0b-0c,10]  [00]  [00]  {mask:3f/exclusive:18,30}  [00]  [00-01,07,09-0b,0e-10]
-->

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
