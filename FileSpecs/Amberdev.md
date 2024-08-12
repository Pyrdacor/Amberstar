# AMBERDEV data

The `AMBERDEV.UDO` file contains an assortment of data (and possibly executable code?). Some known bits of interest below.
The start offsets are approximate and may vary across releases of the game; in particular, they vary between the English and German versions.

| Start offset      | Description                             | Format                                                                     |
|-------------------|-----------------------------------------|----------------------------------------------------------------------------|
| `2170b`           | String Fragment Table                   | Described for [Compressed Text](CompressedText.md)               |
| `31a46`           | Background song names                   | 0-terminated string, terminated by another 0                               |
| `31eda`           | [Combat Palette](Palettes.md): template | A palette used in combat with three "holes" (colours that are left black)  |
| `31efa`           | [Combat Palette](Palettes.md): variants | List of colour triplets to fill the "holes" in the combat palette template |
| `33d70` (approx.) | Graphics                                | 16x16, details tbd                                                         |
| `473a4`           | [Sky gradients](LabData.md)             | Palette gradients for in-city sky day/night cycle                          |
| `4ac0a`           | Spell names                             | individual u16 words of [Compressed Text](CompressedText.md)     |
| `4cdc0`           | Songs, starting with "City Walk"        | [Background Music](Hippel-CoSo.md)                                         |

## Finding the offsets

Below are some strategies for finding the correct offsets:

- *String Fragment Table*: Start of the first occurrence of "`HUMAN`" or "`MENSCH`", minus one byte.
- *Songs*: All occurrences of `COSO`
- *Spell Names*: Immediately after the first occurrence of `00 00 00 00 01 62`
- *Sky Gradients*: `0x3866` bytes before the spell name table
- *Combat Palette template*: `0x5e5` bytes after the first occurrence of `CODETXT.AMB`
- *Combat Palette variants*: `0x20` bytes after the Combat Palette template
