# Hippel-CoSo Format

Hippel-CoSo is a compressed song format defined by Jochen Hippel, used for 19 background songs in Amberstar.
In Amberstar, CoSo songs are stored in two files:
- `SAMPLEDA.IMG` consists of the instrument samples, shared across songs.  The indices into this file are stored as part of the CoSo song descriptions.
- `AMBERDEV.UDO` contains the song descriptions (among many other things).  The file should contain precisely 19 instances of the magic number `COSO`, which marks the beginning of each song.

The COSO uses TFMX on Amiga, but MMME on Atari ST:

   - TFMX (The Final Musicsystem eXtended)
   - MMME (Mad Max Music Editor)
   - COSO (COmpressed SOng) for TFMX and MMME songfiles
   - MMME-MMME (Mad Max Music Editor) with SID (first version only).

A CoSo record starts with the following header:

| Offset | Name                   | Format | Comments                       |
|--------|------------------------|--------|--------------------------------|
| 0x0000 | magic number           | u8[4]  | always  `COSO`                 |
| 0x0004 | `pos_instruments`      | u32    |                                |
| 0x0008 | `pos_timbres`          | u32    |                                |
| 0x000c | `pos_monopatterns`     | u32    |                                |
| 0x0010 | `pos_divisions`        | u32    |                                |
| 0x0014 | `pos_song`             | u32    |                                |
| 0x0018 | `pos_samples`          | u32    |                                |
| 0x001c | `total_length`         | u32    |                                |
| 0x0020 | magic number           | u8[4]  | always  `TFMX`                 |
| 0x0024 | `num_instruments - 1`  | u16     |                                |
| 0x0026 | `num_timbres - 1`      | u16     | 1 less than the actual count   |
| 0x0028 | `num_monopatterns - 1` | u16     | 1 less than the actual count   |
| 0x002a | `num_divisions - 1`    | u16     | 1 less than the actual count   |
| 0x002c | `0x40`                 | u16     | unknown / unused               |
| 0x002e | `0`                    | u16     | unknown / unused               |
| 0x0030 | `num_songs`            | u16     |                                |
| 0x0032 | `num_samples`          | u16     |                                |
| 0x0034 | `0`                    | u16[6]  | unknown / unused (!unverified) |

All `pos_` references are relative to the first byte of the header.

The remaining song data (except for the sample data) follows.


## CoSo Sections

A CoSo record contains the following additional sections, most of which deviate substantially from typical MOD files:

- **Instruments**, describing the samples and base tones associated with an instrument.
- **Timbres**, describing different volumes and vibrato styles for playing an instrument. Includes **Volume Envelopes**, which in turn are different (possibly infinite) sequences of volume information (in the sense of loudness).
- **Monopatterns**, which are compressed MOD-like "patterns", but for only one channel at a time. They select notes, timbres, and effects.
- **Divisions** map the four Amiga channels to monopatterns, but can also apply transpose patterns or adjust their volume.
- **Songs**, the different songs stored in a CoSo file (in Amberstar, there seems to be only one song per file).
- **Samples**, pointers to audio samples in `SAMPLEDA.IMG`.

These sections are in order, so that the corresponding position markers also indicate the end of the preceding section:

| Section              | Offset            | Format    | Element Size | Number of Elements |
|----------------------|-------------------|-----------|--------------|--------------------|
| Header               | 0                 | single    | 32           | 1                  |
| Instruments          | `pos_instruments` | *indexed* | variable     | `num_instruments`  |
| Timbres              | `pos_timbres`     | *indexed* | variable     | `num_timbres`      |
| Monopatterns         | `pos_patterns`    | *indexed* | variable     | `num_patterns`     |
| Divisions            | `pos_divisions`   | *array*   | 12           | `num_divisions`    |
| Songs                | `pos_song`        | *array*   | 6            | `num_songs`        |
| Samples              | `pos_samples`     | *array*   | 10           | `num_samples`      |
| (end of CoSo record) | `total_length`    |           |              | n/a                |

All sections except for the header may store multiple elements. The table above indicates how the section encodes these elements:

- *indexed*: The section contains variable-length entries and uses an <span class="underline">index table</span> (see below)
- *array*: The section contains fixed-length entries (of "Element Size" bytes) in sequence.


## CoSo Index Tables

Three sections (**Instruments**, **Timbres**, **Monopatterns**) store variable-length entries. If we set `num_elts` to the number of elements of that section (i.e., `num_instruments`, `num_timbres`, or `num_patterns`), these sections have the following format:

| Name                    | Format                          | Comments                                      |
|-------------------------|---------------------------------|-----------------------------------------------|
| `index[0]`              | u16                             | relative to CoSo header                       |
| ...                     |                                 |                                               |
| `index[num_elts - 1]`   | u16                             | relative to CoSo header                       |
| `element[0]`            | u8[`index[1]` - `index[0]`]     | variable length; meaning is section-dependent |
| ...                     |                                 |                                               |
| `element[num_elts - 1]` | u8[end - `index[num_elts - 1]`] | variable length; meaning is section-dependent |

where `end` is the offset of the start of the next section.

The indices point directly into the `elements` block (relative to the first CoSo header byte).


## Song Semantics and Duration

The **Instruments**, **Timbres**, and **Monopatterns** sections contain instructions that should be executed in sequence, and associated timing information. The programs for these three sections execute concurrently but can reset each other in a number of ways; e.g., an instrument can reset the current volume envelope program for the active timbre, and a monopattern can set new instruments and volume envelopes.

Program elements may have a duration, expressed in **ticks**. One tick has a duration of 0.02s, aligned with the timing of the PAL Amiga screen redraw interrupt.

1.  Notes, Pitch, and Period

    The **period** is the amount of time allotted for playing a sample, expressed in Amiga timer ticks. The sample frequency is then the number of times we can fit this period into one second's worth of timer ticks:
    
    frequency = 3546894.6 / period
    
    Adjusting this frequency allows adjusting the tone at which the sample plays.
    
    In CoSo, the period is determined by the <span class="underline">channel note</span>, which is the sum of the following:
    
    - **Instrument** pitch (which may be `RELATIVE` or `ABSOLUTE`)
    - **Monopattern** note (only with `RELATIVE` instrument pitch)
    - **Division** transpose (only with `RELATIVE` instrument pitch)
    
    Below are the note-to-period mappings, split by octave and semitone:
    
    | Octave | st<sub>0</sub> | st<sub>1</sub> | st<sub>2</sub> | st<sub>3</sub> | st<sub>4</sub> | st<sub>5</sub> | st<sub>6</sub> | st<sub>7</sub> | st<sub>8</sub> | st<sub>9</sub> | st<sub>10</sub> | st<sub>11</sub> |
    |--------|----------------|----------------|----------------|----------------|----------------|----------------|----------------|----------------|----------------|----------------|-----------------|-----------------|
    | 0      | 1712           | 1616           | 1524           | 1440           | 1356           | 1280           | 1208           | 1140           | 1076           | 1016           | 960             | 906             |
    | 1      | 856            | 808            | 762            | 720            | 678            | 640            | 604            | 570            | 538            | 508            | 480             | 453             |
    | 2      | 428            | 404            | 381            | 360            | 339            | 320            | 302            | 285            | 269            | 254            | 240             | 226             |
    | 3      | 214            | 202            | 190            | 180            | 170            | 160            | 151            | 143            | 135            | 127            | 120             | 113             |
    | 4      | 113            | 113            | 113            | 113            | 113            | 113            | 113            | 113            | 113            | 113            | 113             | 113             |
    | 5      | 3424           | 3232           | 3048           | 2880           | 2712           | 2560           | 2416           | 2280           | 2152           | 2032           | 1920            | 1812            |
    | 6      | 6848           | 6464           | 6096           | 5760           | 5424           | 5120           | 4832           | 4560           | 4304           | 4064           | 3840            | 3624            |
    
    In other words, the highest expected sampling rate is 31388 Hz, and the lowest is 518.
    
    CoSo discards the most significant bit of the note (i.e., note 130 = note 2). Any notes outside the above table (i.e., >= 84) are mapped to 0.
    
    The resultant period may be further adjusted by
    
    - **Vibrato**, and
    - **Portando**
    
    in that order, see below.

2.  Vibrato

    CoSo supports use a notion of **Vibrato** that modulates the audio frequency with a saw-tooth pattern. CoSo describes the saw-tooth function via **slope** an **depth** parameters.
    
    Let **period** = slope / depth (rounded up). Then the saw-tooth function has the form:
    
    $ v(t) = \left \{ \begin{array}{l[]lcl} \max&(-\frac{\textsf{depth}}{2}, \phantom{-}\frac{depth}{2} - \textsf{slope} * (t \mod (\textbf{period} \times 2))) &\iff& \lfloor \frac{t}{\textbf{period}} \rfloor\textrm{ is even} \\ \min&(\phantom{-}\frac{\textsf{depth}}{2}, -\frac{depth}{2} + \textsf{slope} * (t \mod (\textbf{period} \times 2))) &\iff& \lfloor \frac{t}{\textbf{period}} \rfloor\textrm{ is odd} \\ \end{array} \right . $

    Or, expressed in a form that GitHub's markdown renderer can handle:

    | Condition                                            | $v(t) = $                                                                                                   |
    |------------------------------------------------------|-------------------------------------------------------------------------------------------------------------|
    | $\lfloor \frac{t}{\textbf{period}} \rfloor$ is even: | $\max(-\frac{\textsf{depth}}{2}, \ \frac{depth}{2} - \textsf{slope} * (t \mod (\textbf{period} \times 2)))$ |
    | $\lfloor \frac{t}{\textbf{period}} \rfloor$ is odd:  | $\min(\ \frac{\textsf{depth}}{2}, -\frac{depth}{2} + \textsf{slope} * (t \mod (\textbf{period} \times 2)))$ |
    
    (though tick counting seems to start at 1, meaning that v(0) is never used).
    
    The **period** modulated by vibrato then becomes:
    
    $\textbf{period}'(t) = \textbf{period} \times \left (1 + \frac{v(t)}{1024} \right )$

4.  Portando

    CoSo supports a linear variant of **Portando**, parameterised by **portando_slope**. The effect is defined as follows:
    
    $p(t) = 1 - \frac{t \times \text{portando\\_delta}}{1024}$
    
    such that
    
    $\textbf{period}''(t) = \textbf{period} \times p(t)$
    
    The Portando effect always applies after Vibrato.

5.  Volume

    CoSo uses Amiga volume levels, which range from 0 to 64. A volume of 0 means "mute", and volumes between 1 and 64 progress logarithmically wrt their dB values:
    
    | dB    | Volume |
    |-------|--------|
    | `0`   | 64     |
    | `-6`  | 32     |
    | `-12` | 16     |
    | `-18` | 8      |
    | `-24` | 4      |
    | `-30` | 2      |
    | `-36` | 1      |
    
    The implications for mapping CoSo songs to PCM waveforms is that we can interpret volume as a factor on all amplitudes, effectively multiplying all amplitudes by `volume / 64.0`.
    
    In CoSo, the volume is the product of the following:
    
    -   **Volume Envelope** volume
    -   **Division** `channel_volume`, interpreted as a percentage

6.  Channels

    CoSo supports four audio channels:
    
    | Channel | Stereo output |
    |---------|---------------|
    | 0       | left          |
    | 1       | right         |
    | 2       | right         |
    | 3       | left          |
    
    Each channel maintains its individual state for **Instruments**, **Timbres**, and **Monopatterns**. Different channels may use the same timbres etc. without affecting each other's state.
    
    **Divisions** expose a structure that suggests that they synchronise channels, but there does not seem to be any actual channel synchronisation involved: if one channel's monopattern finishes before another channel's, it may move on to the next division before the other channels do. (**TO VERIFY**)


## Instruments

Instruments describe the "kind of tone" that the song should produce, mainly in the form of sample and pitch information.

Each instrument is described in a variable-length byte sequence, encoding various operations that describe the instrument. By using timing delays, instruments can vary their sample and pitch after being triggered.

The meanings of the bytes are below (in hexadecimal encoding):

| First Byte   | Parameters                                                                      | Operation                                                       | Duration | Notes               |
|--------------|---------------------------------------------------------------------------------|-----------------------------------------------------------------|----------|---------------------|
| `e0`         | [`pos`:u8]                                                                      | `LOOP(pos)`                                                     | 0        |                     |
| `e1`         |                                                                                 | `COMPLETED`                                                     | infinite |                     |
| `e2`         | [`sample`:u8]                                                                   | `SAMPLE(sample, 1)`                                             | 0        |                     |
| `e3`         | [`vslope`:u8]  [`vdepth`:u8]                                                    | .. unused: `VIBRATO(vslope, vdepth)`                            | 0        | Unused in Amberstar |
| `e4`         | [`sample`:d8]                                                                   | .. unused: `SAMPLE(num, 1)`                                     | 0        | Unused in Amberstar |
| `e5`         | [`sample`:u8]  [`loop`:u16]  [`len >> 1`:u16]  [`delta >> 1`:i16]  [`speed`:u8] | `SAMPLE(sample, 1)`                                             | 0        |                     |
|              |                                                                                 | \_if `loop` = 0xffff: `SLIDE(len, sample.length, delta, speed)` |          |                     |
|              |                                                                                 | \_otherwise:        `SLIDE(len, loop << 1, delta, speed)`       |          |                     |
|              |                                                                                 | `RESET-VOL`                                                     |          |                     |
| `e6`         | [`len >> 1`:u16]  [`delta >> 1`:i16]  [`speed`:u8]                              | .. unused: `SLIDE(len, ?, delta, speed)`                        | 0        | Unused in Amberstar |
| `e7`         | [`sample`:u8]                                                                   | `SAMPLE(sample, 0)`                                             | 0        |                     |
|              |                                                                                 | `RESET-VOL`                                                     |          |                     |
| `e8`         | [`ticks`:u8]                                                                    | .. unused: `INSTRUMENT-DELAY(ticks)`                            | ticks    | Unused in Amberstar |
| `e9`         | [`sample`:u8]  [`sample_offset`:u8]                                             | .. unused: `SAMPLE-CUSTOM(sample, sample_offset)`               | 0        | Unused in Amberstar |
| [`pitch`:u8] | \_if NOT `pitch` & 0x80                                                         | `PITCH(pitch, RELATIVE)`                                        | 1        | Default case (1)    |
| [`pitch`:u8] | \_if     `pitch` & 0x80                                                         | `PITCH(pitch & 0x7f, ABSOLUTE)`                                 | 1        | Default case (2)    |

The operations above are detailed below:

- `COMPLETED`: Instrument definition completed.
- `LOOP(pos)`: Jump back to the byte position `pos` in this instrument's byte sequence to loop.
- `PITCH(pitch, RELATIVE)`: Sets the instrument's pitch, effectively transposing the note that the instrument plays. Not cumulative, i.e., overrides the previous pitch setting. Wait one tick before continuing.
- `PITCH(pitch, ABSOLUTE)`: Sets the <span class="underline">channel note</span> directly. This overrides **Monopattern** notes and **Division** transpose effects. Wait one tick before continuing.
- `RESET-VOL`: Reset the volume envelope program in the current timbre to its starting position.
- `SAMPLE(sample, reset_position)`: Switch to the specified `sample` as the sample for this instrument. If `reset_position` is `1` or if the sample is different from the previously assigned sample for this channel, also reset the sample's loop.
- `SLIDE(len, loop, delta, speed)`: Interpret the current sample as a sample sequence, and "slide" across the sample data. Specifically, loop from `[loop..loop+len]` within the sample, and after each `speed` ticks, update `loop += delta`, unless this would take us outside the sample's data, at which point the loop window remains in position. The effect of `SLIDE` ends as soon as the instrument's sample is changed.

The following operations seem unused in Amberstar and are therefore less likely to be correct:

- `INSTRUMENT-DELAY(ticks)`: Wait for the specified number of ticks before running the next operation.
- `SAMPLE-CUSTOM(sample, offset)`: A variant of `SAMPLE(sample, 1)` that seems to allow access to alternative start offset and loop information for the same sample data (read from from the **Samples** section).
- `VIBRATO(vslope, vdepth)`: Update the current vibrato settings for this channel.

Each instrument ends with either `COMPLETED` or `LOOP(_)`.


## Timbres and Volume Envelopes

Timbres describe the volume and vibrato with which an instrument should be played. Each timbre begins with a header, followed by a variable-length **Volume Envelope**.

A timbre header has the following format:

| Name            | Format | Comments                                                                                                       |
|-----------------|--------|----------------------------------------------------------------------------------------------------------------|
| `speed`         | u8     | Default number of ticks between each step in the sound envelope                                                |
| `instrument`    | u8     | \_if NOT `instrument` == 0x80: set instrument.  Monopatterns may override the instrument selecting the timbre. |
|                 |        | \_if     `instrument` == 0x80: keep current instrument and ignore any monopattern instrument override.         |
| `vibrato_slope` | u8     |                                                                                                                |
| `vibrato_depth` | u8     |                                                                                                                |
| `vibrato_delay` | u8     | Number of ticks before vibrato begins                                                                          |

The volume envelope follows immediately, and consists of bytes with the following meaning:

| First Byte      | Parameters      | Meaning          | Duration | Notes                                          |
|-----------------|-----------------|------------------|----------|------------------------------------------------|
| `e0`            | [`ticks`:u8]    | `SUSTAIN(ticks)` | `ticks`  |                                                |
| `e1`, ..., `e7` |                 | `HOLD`           | infinite |                                                |
| `e8`            | [`offset+5`:u8] | `LOOP(offset)`   | 0        | Value is 5 bytes higher than the offset        |
| [`volume`:u8]   |                 | `VOLUME(volume)` | `speed`  | Default case; `speed` is taken from the header |


- `SUSTAIN(ticks)` only delays processing the next step of the volume envelope.
- `HOLD` maintains the current volume level indefinitely.
- `LOOP(offset)` loops back to an earlier volume envelope entry.
- `VOLUME(volume)` sets the current base volume (which will be affected by the channel volume).

## Monopatterns

Monopatterns encode a sequence of notes to play. They again use a sequential variable-length encoding:

| First Byte                         | Parameters                                              | Operations                                                  | Duration | Notes                            |
|------------------------------------|---------------------------------------------------------|-------------------------------------------------------------|----------|----------------------------------|
| `ff`                               |                                                         | `END-PATTERN`                                               | 0        |                                  |
| `fe`                               | [`ticks`:u8]                                            | `SET-SPEED(ticks + 1)`                                      | 0        | `pattern_speed := ticks + 1`     |
| `fd`                               | [`ticks`:u8]                                            | `SET-SPEED(ticks + 1)` <br> `PATTERN-DELAY`                 | `speed`  | `pattern_speed := ticks + 1`     |
| [`note`:i8] <br> (if `note` <= 0)  | [`_info`:u8] <br> (if NOT (`_info` & 0xe0))             | `NOTE(note)`                                                | `speed`  | only note=0 appears in Amberstar |
| [`note`:i8] <br> (if `note` <= 0)  | [`_info`:u8]  [`_info2`:u8] <br> (if `_info` & 0xe0)    | `NOTE(note)`                                                | `speed`  | only note=0 appears in Amberstar |
| [`note`:u8]                        | [`timbre`:u8] <br> (if NOT `timbre` & 0xe0)             | `NOTE(note)` <br> `TIMBRE(timbre + timbre_adjust, DEFAULT)` | `speed`  | Default case (1)                 |
| [`note`:u8]                        | [`timbre`:u8]  [`effect`:i8] <br> (if `timbre` & 0xe0`) | `NOTE(note)` <br> + **Extra Effects**                       | `speed`  | Default case (2)                 |

Here, `timbre_adjust` is from **Division**.
**Extra Effects** for Default Case (2) are:

| Condition              | Operations                                         |
|------------------------|----------------------------------------------------|
| if NOT `timbre & 0x40` | `TIMBRE((timbre & 0x1f) + timbre_adjust, DEFAULT)` |
| if     `timbre & 0x40` | `TIMBRE((timbre & 0x1f) + timbre_adjust, effect)`  |
| if     `timbre & 0x20` | `PORTANDO(effect)`                                 |


Note that the `speed` in the *Duration* column in the table above is defined as:

`speed = pattern_speed * channel_speed`

where `channel_speed` is determined by the **Division** that triggered this monopattern.

The explanations for the operations are below:

-   `END-PATTERN`: End of the monopattern.
-   `SET-SPEED(ticks)`: Sets the speed (in ticks) for all following `PATTERN-DELAY` and `NOTE` operations.
-   `PATTERN-DELAY`: Wait.
-   `NOTE(note)`: Set the current channel note. Resets any current Portando effect.
-   `TIMBRE(timbre, DEFAULT)`: Set the channel's timbre.
-   `TIMBRE(timbre, instrument)`: Set the channel's timbre but override its instrument with the one specified here.
-   `PORTANDO(portando_slope)`: Activate portando for this note, with the given (i.e., recomputed) `portando_slope`.


## Divisions

Divisions are the highest-level units that make up a song. Each division maps all four channels to a monopattern, which in turn will select timbre and instrument and play a sequence of notes.

Each division takes up twelve bytes; three for each channel `c`, from 0 to 3 (inclusive):

| Name             | Format | Comments                                   |
|------------------|--------|--------------------------------------------|
| `monopattern[c]` | u8     | Monopattern index to assign to the channel |
| `transpose[c]`   | i8     | Transpose for monopattern notes            |
| `effect[c]`      | u8     |                                            |

The effect can be one of the following, depending on the bit pattern matched by `effect[c]`:

| `effect[c]` = `... | Effect                               | Notes                                               |
|--------------------|--------------------------------------|-----------------------------------------------------|
| `0b0xxxxxxx`       | `timbre_adjust := effect[c]`         | NOT `(effect & 0x80)`                               |
| `0b1000yyyy`       | `FULL-STOP`                          | `(effect & 0xf0) == 0x80`                           |
| `0b1110yyyy`       | `channel_speed := 1 + 0byyyy`        | `(effect & 0xf0) == 0xe0`                           |
| `0b11110000`       | `channel_volume := 100`              | `effect == 0xf0`                                    |
| `0b1111yyyy`       | `channel_volume := (16 - 0byyy) * 6` | `(effect & 0xf0) == 0xf0` and `(effect & 0x0f) > 0` |

- `timbre_adjust` shifts the **Timbres** selected by the **Monopattern** up by the given amount.
- `channel_speed` gives a factor for slowing down the notes across **all** channels
- `FULL-STOP`: terminates the entire song.
- `channel_volume` permanently sets the channel's volume (as a percentage value).

Divisions play one monopattern on each of the channels until the pattern's completion. In principle, each channel might move onto the next division, independently of each other, though in practice the channels seem to be mapped to monopatterns of the same length (**TO VERIFY**).

The song terminates when the next division would be at or after the `end` of the Song.


## Songs

Songs are encoded as follows:

| Name         | Format | Comments                                                   |
|--------------|--------|------------------------------------------------------------|
| `start`      | u16    | byte index into the Division table: first division to play |
| `end`        | u16    | byte index into the Division table: end of song            |
| `song_speed` | u16    | initial `channel_speed` for all channels                   |

Initially, all channels are configured as follows:

- `channel_volume` = 100
- `timbre_adjust` = 0
- Vibrato disabled
- Portando disabled


## Samples

Samples follow the following format:

| Name          | Format | Comments                            |
|---------------|--------|-------------------------------------|
| `pos_sample`  | u32    |                                     |
| `length >> 1` | u16    | encoded as half of the actual value |
| `pos_loop`    | u16    |                                     |
| `repeat >> 1` | u16    | encoded as half of the actual value |

The sample ranges from `pos_sample..pos_sample + length - 1`. Once the sample has played through once, it will loop from `pos_loop..pos_loop + repeat - 1`.
