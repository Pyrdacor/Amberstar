# Events

Events are part of [Maps](Maps.md), tied to "hotspots" on particular map tiles and triggered under certain conditions.
Unless noted otherwise, the condition is that the player enters the hotspot tile.
Events are encoded in 10 bytes, summarised below, with the byte at offset `00` in column ID:

| Name          | Where | ID   | `01`  | `02`  | `03`  | `04`  | `05`   | `06`  | `07`    | `08`  | `09`  |
|---------------|-------|------|-------|-------|-------|-------|--------|-------|---------|-------|-------|
| **Teleport**  |       | `01` | *x*   | *y*   | U01.3 | `00`  | `00`   | `00`  | *map*   | `00`  | `00`  |
| **Door**      |       | `02` | *cr*  | U02.2 | U02.3 | `00`  | U2.5   | U2.6  | U2.7    | `00`  | `00`  |
| **Message**   |       | `03` | *img* | *msg* | U03.3 | `00`  | U3.5   | *kw*  | *kw*    | `00`  | `00`  |
| **Chest**     |       | `04` | U04.1 | U04.2 | U04.3 | U04.4 | *flag* | `00`  | *chest* | `00`  | *msg* |
|               |       | `05` | U05.1 | U05.2 | U05.3 | U05.4 | U05.5  | `00`  | U05.7   | `00`  | U05.9 |
|               |       | `06` | U06.1 | U06.2 | U06.3 | U06.4 | U06.5  | `00`  | U06.7   | `00`  | `00`  |
|               |       | `07` | U07.1 | U07.2 | U07.3 | U07.4 | `00`   | `00`  | U07.7   | `00`  | `00`  |
|               | 3D    | `08` | U08.1 | `00`  | `00`  | U08.4 | U08.5  | `00`  | `00`    | `00`  | `00`  |
|               |       | `09` | U09.1 | U09.2 | U09.3 | U09.4 | U09.5  | U09.6 | U09.7   | U09.8 | U09.9 |
|               |       | `0a` | U0a.1 | U0a.2 | `00`  | U0a.4 | `00`   | `00`  | `00`    | `00`  | `00`  |
| **RestoreLP** | 2D    | `0b` | `00`  | `00`  | `00`  | *msg* | `00`   | `00`  | `00`    | `00`  | `00`  |
| **RestoreSP** | 2D    | `0c` | `00`  | `00`  | `00`  | *msg* | `00`   | `00`  | `00`    | `00`  | `00`  |
|               |       | `0d` | U0d.1 | `00`  | U0d.3 | `1a`  | U0d.5  | `00`  | `00`    | `00`  | `00`  |
|               |       | `0e` | U0e.1 | U0e.2 | U0e.3 | U0e.4 | U0e.5  | U0e.6 | U0e.7   | U0e.8 | `00`  |
|               |       | `0f` | U0f.1 | `01`  | U0f.3 | U0f.4 | U0f.5  | `00`  | `00`    | `00`  | U0f.9 |
|               |       | `10` | U10.1 | U10.2 | `00`  | U10.4 | U10.5  | `00`  | U10.7   | `00`  | `00`  |
|               |       | `11` | U11.1 | `00`  | U11.3 | U11.4 | U11.5  | `0`   | U11.7   | `00`  | `00`  |
|               |       | `12` | U12.1 | U12.2 | U12.3 | U12.4 | `00`   | `00`  | U12.7   | `00`  | U12.9 |
|               |       | `13` | U13.1 | U13.2 | `00`  | U13.4 | U13.5  | U13.6 | U13.7   | `00`  | U13.9 |
| **Door3D**    | 3D    | `14` | `01`  | `00`  | `00`  | U14.4 | U14.5  | `00`  | U14.7   | `00`  | `00`  |
|               | 2D    | `15` | U15.1 | U15.2 | U15.3 | `00`  | `00`   | `00`  | U15.7   | `00`  | `00`  |
|               | 2D    | `16` | `00`  | `00`  | `00`  | `00`  | `00`   | `00`  | `00`    | `00`  | `00`  |
| **Win**       | 2D    | `17` | `00`  | `00`  | `00`  | `00`  | `00`   | `00`  | `00`    | `00`  | `00`  |


* Column `Where` indicates whether the event only appears in 2D or 3D maps.
* Parameters of the form "U00.0" indicate an unknown parameter.
* `00` indicates that this paramter always appears as `00`.

This information is observational: the Amberstar *engine* might support more options values, but the *game* does not seeem to use them (unless events can be triggered in other ways than observed so far).

<!-- ---------------------------------------- -->
## Event 01: Teleport

Teleports the party to the specified *map* - 1, coordinates (*x*, *y*).

Unknown: *map*=0 might teleport the player to a different location in the same map (?)

### Unknowns
* U01.3: [`00-03`]

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
*Trigger*: Entering, if U03.3 is 0, or Looking if U03.3 is 1.  (Other values for U03.3: Unknown.)

Displays message *msg*, from the local `MAPTEXT.AMB` resources, and possibly shows image *img* - 1 from `PICS80.AMB`, if *img* is nonzero.
The party learns the dictionary keyword *kw* for use in conversation with NPCs.

### Unknowns
* U03.3: [`00`, `02`, `07`, `09`, `0a`, `14`, `19`, `32`] (migt be flags?)
* U03.5: [`00-28`]

<!-- ---------------------------------------- -->
## Event 04: Chest
*Trigger*: Looking

The party accesses the that contains the items from `CHESTDAT.AMB` resource number *chest*, while displaying message *msg*.  Once the chest is empty,
the game records this fact with chest flag *flag* and no longer allows chest access.

The gold for this chest is stored in u16 values in `PARTYDAT.SAV`, starting at `00001ef0` for chest `01`.

### Unknowns
* U04.1: [`00`, `01`, `0a`]: Lockpick difficulty?  `0a` only in 3D maps.
* U04.2: [`00-07`]
* U04.3: [`00`], or [`01`, `05`] in 3D maps
* U04.4: [`00-2a`]

<!-- ---------------------------------------- -->
## Event 05

### Unknowns
* What does this do?
* What do the unknown parameters do?
<!--
2D    INCOMPLETE event op type 05 [0a,1a]        [1a,23]              [01]     [00,05]  [00-01]  [00]  [4b,6f]              [00]  [03,0a]
3D    INCOMPLETE event op type 05 [09,10-11,1f]  [09,15-16,19-1a,1f]  [00-01]  [00,1a]  [00-01]  [00]  [5d,69,6c,80,92-93]  [00]  [00,0a,0f]
-->

<!-- ---------------------------------------- -->
## Event 06

### Unknowns
* What does this do?
* What do the unknown parameters do?

<!--
    INCOMPLETE event op type 06 [09,0b,0e-0f,11,16]  [06,09,0f-10,14,18]  {mask:06/exclusive:06}                                      [02,1a]  [00]  [00]  [3d,40,4d,6d,97]           [00]  [00]
    INCOMPLETE event op type 06 [02,07-12,14-15,17-1d,1f-23,25-27]  [07-14,18-1b,1d-1f,21-23,25,27,2c,33]  [00-04]  [00-01,05,08-0d,1a]  [00,03,13]  [00]  {mask:ff/exclusive:a0,c0}  [00]  [00]
-->
<!-- ---------------------------------------- -->
## Event 07

### Unknowns
* What does this do?
* What do the unknown parameters do?
<!--
    INCOMPLETE event op type 07 [0c,0e,11-15,17,19-1a,1c-1d,2c,2f-30]  {mask:3f/exclusive:12,30}  [00-03]  [00,1a]  [00]  [00]  {mask:7f/exclusive:41,42,48}  [00]  [00]
    INCOMPLETE event op type 07                                                                                      [14]  [0d]  [03]  [1a]  [00]  [00]  [33]  [00]  [00]
-->
<!-- ---------------------------------------- -->
## Event 08

### Unknowns
* What does this do?
* What do the unknown parameters do?
<!--
3D    INCOMPLETE event op type 08 [00-04]  [00]  [00]  [1a]  [00-01,06-07]  [00]  [00]  [00]  [00]
-->
<!-- ---------------------------------------- -->
## Event 09

### Unknowns
* What does this do?
* What do the unknown parameters do?
<!--
    INCOMPLETE event op type 09 {mask:3f/exclusive:05,12,2c}  [02]  [00]  [01-02,1a]  [00]  [00]  [00]  [00]  [00]
    INCOMPLETE event op type 09                            [19,1e]  [00]  [00]  [1a]  [00]  [00]  [00]  [00]  [00]
-->
<!-- ---------------------------------------- -->
## Event 0a

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
## Event 0d

### Unknowns
* What does this do?
* What do the unknown parameters do?
<!--
    INCOMPLETE event op type 0d [03-04,07]  [00]  [00]     [1a]                    [1e-20]  [00]  [00]  [00]  [00]
    INCOMPLETE event op type 0d [01,03-05]  [00]  [00,0f]  [1a]  {mask:17/exclusive:07,16}  [00]  [00]  [00]  [00]
-->
<!-- ---------------------------------------- -->
## Event 0e

### Unknowns
* What does this do?
* What do the unknown parameters do?
<!--
    INCOMPLETE event op type 0e {mask:3f/exclusive:11,22,24,28}  {mask:1f/exclusive:09,18}  [00-04]  [01-03,05,08]  [01-04]  [01,06]  [49,4f-52,56,87]  [00]  [4a-4b,52,af,e9]
    INCOMPLETE event op type 0e {mask:3f/exclusive:21,22,30}  {mask:3f/exclusive:28}  {mask:1f/exclusive:06,18,12}  [01-07,0c,0e,12,16]  {mask:3f/exclusive:32,34,18}  [01-04,07,09,0b-0d]  {mask:ff}  [00]  [00-02,04-05]
-->
<!-- ---------------------------------------- -->
## Event 0f

### Unknowns
* What does this do?
* What do the unknown parameters do?
<!--
    INCOMPLETE event op type 0f [03,05-06]  [00-01]  [01]  [18-19]  [1b-1d]  [00]  [00]  [00]  [0f,14]
    INCOMPLETE event op type 0f [01-02]        [00]  [01]  [08-09]  [0a,12]  [00]  [00]  [00]  [0a]
-->
<!-- ---------------------------------------- -->
## Event 10

### Unknowns
* What does this do?
* What do the unknown parameters do?
<!--
    INCOMPLETE event op type 10 [0b,11-12,14,16,1a,1c,1f]  [0d-0f,13,22]  [00]  [02,04,13,1a]           [00-01,04-07,10-11]  [00]  [13,19,4b,52,ef]  [00]  [00]
    INCOMPLETE event op type 10 {mask:3f/exclusive:28,30}  {mask:3f}      [00]  [01-04,0b,0e-11,1a]  [00-02,08,0e-10,19-20]  [00]  [01-02,04-05]  [00]  [00]
-->
<!-- ---------------------------------------- -->
## Event 11

### Unknowns
* What does this do?
* What do the unknown parameters do?
<!--
    INCOMPLETE event op type 11 {mask:7f}  [00]  [00,1a]  [01,1a]  [00-07]     [00]  {mask:7f/exclusive:12,44,48,60}  [00]  [00]
    INCOMPLETE event op type 11 [64]       [00]  [00]  [01,07,1a]  [03,06,08]  [00]  [04,33,3d]                       [00]  [00]
-->
<!-- ---------------------------------------- -->
## Event 12

### Unknowns
* What does this do?
* What do the unknown parameters do?
<!--
    INCOMPLETE event op type 12 {mask:1f/exclusive:14,18}  [00,0f,12,14,16]  [00,02-0a,0d,10-12]  [00-04,1a]  [00]  [00]  {mask:3f/exclusive:30}     [00]  [00,02-08,0c-0d]
    INCOMPLETE event op type 12 [00-01,06-0a,0c-0d]  [00,07,0f-12,14,16]  [01,09-0a,0c-10]  [00,05,0b-0c,10]  [00]  [00]  {mask:3f/exclusive:18,30}  [00]  [00-01,07,09-0b,0e-10]
-->

<!-- ---------------------------------------- -->
## Event 13

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
## Event 15

### Unknowns
* What does this do?
* U15.01:
* U15.02:
* U15.03: [`00-03`]
* U15.07: [`43-8c`]

<!-- ---------------------------------------- -->
## Event 16

### Unknowns
* What does this do?

<!-- ---------------------------------------- -->
## Event 17: Win
Triggers the end-game sequence.
