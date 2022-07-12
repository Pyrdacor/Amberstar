# AMBERDEV data

The `AMBERDEV.UDO` file contains an assortment of data (and possibly executable code?). Some known bits of interest below:

| Start offset    | Description                      | Format                                                       |
|-----------------|----------------------------------|--------------------------------------------------------------|
| 2170b           | String Fragment Table            | Described for [Compressed Text](FileSpecs/CompressedText.md) |
| 31a46           | Background song names            | 0-terminated string, terminated by another 0                 |
| 33d70 (approx.) | Graphics                         | 16x16, details tbd                                           |
| 4cdc0           | Songs, starting with "City Walk" | [Background Music](Hippel-CoSo.md)                           |


