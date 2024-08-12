# Events

Events are part of [Maps](Maps.md), tied to "hotspots" on particular map tiles and triggered under certain conditions.
Unless noted otherwise, the condition is that the player enters the hotspot tile.
- Events are encoded in 10 bytes, summarised below, with the byte at offset `00` in column ID.
- At offsets 6 and 8 there are words, in all other offsets single bytes.
- At offset 5 there is always an event index which specifies an event to be saved.
Saving means that the event is disabled. This is useful for one-time events. There are two exceptions:
  - Chest events are always executed, even if disabled. Most likely to allow checking chests for more items and because empty chests won't show anything anyways.
  - Disabled door exit events will not be executed but their linked additional event is.
- We won't include offset 5 in the following table as it has the same meaning for all events.

| Name                   | Where | ID   | `01`   | `02`    | `03`    | `04`    | `06`      | `08`     | Automap     |
|------------------------|-------|------|--------|---------|---------|---------|-----------|-----------|-------------|
| **ChangeMap**          |       | `01` | *x*    | *y*     | *dir*   | `00`    | *map*     | `0000`    | Exit        |
| **Door**               |       | `02` | *cr*   | *trap*  | *dmg*   | `00`    | U2.6      | `0000`    | Door        |
| **Message**            |       | `03` | *img*  | *msg*   | *act*   | `00`    | *kw*      | `0000`    | /           |
| **Chest**              |       | `04` | U04.1  | U04.2   | U04.3   | U04.4   | *chest*   | *msg*     | Treasure    |
| **Trapdoor**           |       | `05` | U05.1  | U05.2   | U05.3   | U05.4   | *map*     | U05.9     | /           |
| **Teleport**           |       | `06` | *x*    | *y*     | U06.3   | U06.4   | *map*     | `0000`    | Teleporter  |
| **WindGate**           |       | `07` | U07.1  | U07.2   | U07.3   | U07.4   | U07.7     | `0000`    |             |
| **Spinner**            | 3D    | `08` | *dir*  | `00`    | `00`    | U08.4   | `0000`    | `0000`    |             |
| **TakeDamage**         |       | `09` | *max*  | U09.2   | `00`    | U09.4   | `0000`    | `0000`    |             |
|                        |       | `0a` | U0a.1  | U0a.2   | `00`    | U0a.4   | `0000`    | `0000`    |             |
| **RestoreLP**          | 2D    | `0b` | `00`   | `00`    | `00`    | *msg*   | `0000`    | `0000`    | /           |
| **RestoreSP**          | 2D    | `0c` | `00`   | `00`    | `00`    | *msg*   | `0000`    | `0000`    | /           |
| **Trap**               |       | `0d` | U0d.1  | `00`    | U0d.3   | `1a`    | `0000`    | `0000`    | /           |
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

<!-- ---------------------------------------- -->
## Event 02: Door

Party encounters a locked door.  The lock-picking difficulty seems to be indicated by *cr*, which is 1, 10, or 100.

### Unknowns
* Exact meaning of the challenge rating *cr*
* U02.2: [`00`, `01`, `03` (only 3D maps)]
* U02.3: [`00`, `0a`], on 3D maps also possibly [`05`, `0f`, `23`]
* U02.5: [`01-0f`], but not `0c-0d`.
* U02.6: `00`, but may be `01` on 3D maps
* U02.7: `00` or special number, likely the key ID?  Is nonzero iff *cr* = 100

<!-- ---------------------------------------- -->
## Event 03: Message
*Trigger*:
- if *act* = `0`: enter tile
- if *act* = `1`: look at tile
- if *act* >= `2`: looking or entering

*Precondition*
- Either *flagID* = `0`, or message flag ID *flagID* is not set

Displays message *msg*, from the local `MAPTEXT.AMB` resources, and possibly shows image *img* - 1 from `PICS80.AMB`, if *img* is nonzero.
The party learns the dictionary keywords *kw* for use in conversation with NPCs.

If *flagID* is nonzero, set message flag ID *flagID* so that this message will not be shown again.

<!-- ---------------------------------------- -->
## Event 04: Chest
*Trigger*: Looking

The party accesses the that contains the items from `CHESTDAT.AMB` resource number *chest*, while displaying message *msg*.  Once the chest is empty,
the game records this fact with chest flag *flagID* and no longer allows chest access.

The gold for this chest is stored in u16 values in `PARTYDAT.SAV`, starting at `00001ef0` for chest `01`.

### Unknowns
* U04.1: [`00`, `01`, `0a`]: Lockpick difficulty?  `0a` only in 3D maps.
* U04.2: [`00-07`]
* U04.3: [`00`], or [`01`, `05`] in 3D maps
* U04.4: [`00-2a`]

<!-- ---------------------------------------- -->
## Event 05: Trapdoor

When looking at this field, the game reports it as a trapdoor.
Works similarly to ChangeMap (Event `01`).

### Unknowns
* What do the unknown parameters do?
<!--
2D    INCOMPLETE event op type 05 [0a,1a]        [1a,23]              [01]     [00,05]  [00-01]  [00]  [4b,6f]              [00]  [03,0a]
3D    INCOMPLETE event op type 05 [09,10-11,1f]  [09,15-16,19-1a,1f]  [00-01]  [00,1a]  [00-01]  [00]  [5d,69,6c,80,92-93]  [00]  [00,0a,0f]
-->

<!-- ---------------------------------------- -->
## Event 06: Teleport

Works similarly to ChangeMap (Event `01`).

### Unknowns
* What do the unknown parameters do?

<!--
    INCOMPLETE event op type 06 [09,0b,0e-0f,11,16]  [06,09,0f-10,14,18]  {mask:06/exclusive:06}                                      [02,1a]  [00]  [00]  [3d,40,4d,6d,97]           [00]  [00]
    INCOMPLETE event op type 06 [02,07-12,14-15,17-1d,1f-23,25-27]  [07-14,18-1b,1d-1f,21-23,25,27,2c,33]  [00-04]  [00-01,05,08-0d,1a]  [00,03,13]  [00]  {mask:ff/exclusive:a0,c0}  [00]  [00]
-->
<!-- ---------------------------------------- -->
## Event 07

Possibly used for windgate teleporters (only operational once the corresponding quest is complete)

### Unknowns
* What does this do?
* What do the unknown parameters do?
<!--
    INCOMPLETE event op type 07 [0c,0e,11-15,17,19-1a,1c-1d,2c,2f-30]  {mask:3f/exclusive:12,30}  [00-03]  [00,1a]  [00]  [00]  {mask:7f/exclusive:41,42,48}  [00]  [00]
    INCOMPLETE event op type 07                                                                                      [14]  [0d]  [03]  [1a]  [00]  [00]  [33]  [00]  [00]
-->
<!-- ---------------------------------------- -->
## Event 08: Spinner

When entering or leaving this tile, the party is rotated to face direction *dir* (cf. Event 01).
If *dir* is `4`, the direction is randomly selected every time the party enters or leaves the tile..

### Unknowns
* What does this do?
* What do the unknown parameters do?
<!--
3D    INCOMPLETE event op type 08 [00-04]  [00]  [00]  [1a]  [00-01,06-07]  [00]  [00]  [00]  [00]
-->
<!-- ---------------------------------------- -->
## Event 09: TakeDamage

The players take between 1..*max* damage.

### Unknowns
* What do the unknown parameters do?
<!--
    INCOMPLETE event op type 09 {mask:3f/exclusive:05,12,2c}  [02]  [00]  [01-02,1a]  [00]  [00]  [00]  [00]  [00]
    INCOMPLETE event op type 09 [19,1e]                       [00]  [00]  [1a]        [00]  [00]  [00]  [00]  [00]
-->
<!-- ---------------------------------------- -->
## Event 0a

Seems to cause darkness, but might be a general debuff / anti-magic event.

### Unknowns
* What does this do?
* What do the unknown parameters do?
<!--
    INCOMPLETE event op type 0a [00]  [00]  [00]  [00]  [01]  [00]  [00]  [00]  [00]
    INCOMPLETE event op type 0a [00]  [00]  [00]  [1a]  [00]  [00]  [00]  [00]  [00]
-->
<!-- ---------------------------------------- -->
## Event 0b: RestoreLP

Restores all life points and displays *msg* as a popup message in the style of **Message**.

Only used in Sir Marillon's Tomb.

<!-- ---------------------------------------- -->
## Event 0c: RestoreSP

Restores all spell points and displays *msg* as a popup message in the style of **Message**.

Only used in Sir Marillon's Tomb.

<!-- ---------------------------------------- -->
## Event 0d: Trap

### Unknowns
* What do the unknown parameters do?
<!--
    INCOMPLETE event op type 0d [03-04,07]  [00]  [00]     [1a]                    [1e-20]  [00]  [00]  [00]  [00]
    INCOMPLETE event op type 0d [01,03-05]  [00]  [00,0f]  [1a]  {mask:17/exclusive:07,16}  [00]  [00]  [00]  [00]
-->
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
