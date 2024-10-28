This lists the spells with their id and bit value. 
The id is used for Monsters and the bit value for PCs.
Spell names are in german (should better be translated by someone with the english version of Amberstar installed).

## Spell schools
| Id |  Bit | Name    |
|---:|-----:|---------|
|  1 |  `2` | white   |
|  2 |  `4` | grey    |
|  3 |  `8` | black   |
|  7 | `80` | special |


## White magic
| Id | Bit        | Name                  |
|---:|-----------:|-----------------------|
| 1  | `2`        | Heilung 1             |
| 2  | `4`        | Heilung 2             |
| 3  | `8`        | Heilung 3             |
| 4  | `10`       | Heilung 4             |
| 5  | `20`       | Heilung 5             |
| 6  | `40`       | Allheilung            |
| 7  | `80`       | Wiederbelebung        |
| 8  | `100`      | Asche wandeln         |
| 9  | `200`      | Staub wandeln         |
| 10 | `400`      | Gift neutralisieren   |
| 11 | `800`      | Lähmung heilen        |
| 12 | `1000`     | Krankheit heilen      |
| 13 | `2000`     | Alterung heilen       |
| 14 | `4000`     | Entsteinern           |
| 15 | `8000`     | Aufwecken             |
| 16 | `10000`    | Panik beseitigen      |
| 17 | `20000`    | Irritation beseitigen |
| 18 | `40000`    | Blindheit heilen      |
| 19 | `80000`    | Verrücktheit heilen   |
| 20 | `100000`   | Lähmen                |
| 21 | `200000`   | Schlaf                |
| 22 | `400000`   | Angst                 |
| 23 | `800000`   | Irritieren            |
| 24 | `1000000`  | Erblinden             |
| 25 | `2000000`  | Untote vernichten     |
| 26 | `4000000`  | Heiliges Wort         |
| 27 | `8000000`  | Fluch aufheben        |
| 28 | `10000000` | Essen erschaffen      |

## Grey magic
| Id | Bit       | Name              |
|---:|----------:|-------------------|
| 1  | `2`       | Licht             |
| 2  | `4`       | Licht 2           |
| 3  | `8`       | Licht 3           |
| 4  | `10`      | Rüstung Schutz 1  |
| 5  | `20`      | Rüstung Schutz 2  |
| 6  | `40`      | Rüstung Schutz 3  |
| 7  | `80`      | Waffen Macht 1    |
| 8  | `100`     | Waffen Macht 2    |
| 9  | `200`     | Waffen Macht 3    |
| 10 | `400`     | Anti-Magie 1      |
| 11 | `800`     | Anti-Magie 2      |
| 12 | `1000`    | Anti-Magie 3      |
| 13 | `2000`    | Hellsicht 1       |
| 14 | `4000`    | Hellsicht 2       |
| 15 | `8000`    | Hellsicht 3       |
| 16 | `10000`   | Unsichtbarkeit 1  |
| 17 | `20000`   | Unsichtbarkeit 2  |
| 18 | `40000`   | Unsichtbarkeit 3  |
| 19 | `80000`   | Magische Sphäre   |
| 20 | `100000`  | Magischer Kompass |
| 21 | `200000`  | Identifikation    |
| 22 | `400000`  | Levitation        |
| 23 | `800000`  | Hast              |
| 24 | `1000000` | Massen-Hast       |
| 25 | `2000000` | Teleport          |
| 26 | `4000000` | Durchblick        |

## Black magic
| Id | Bit      | Name            |
|---:|---------:|-----------------|
| 1  | `2`      | Feuerstrahl     |
| 2  | `4`      | Feuerstoß       |
| 3  | `8`      | Feuerball       |
| 4  | `10`     | Feuersturm      |
| 5  | `20`     | Feuerwalze      |
| 6  | `40`     | Wasserloch      |
| 7  | `80`     | Wasserfall      |
| 8  | `100`    | Eisball         |
| 9  | `200`    | Eisschauer      |
| 10 | `400`    | Hagelschlag     |
| 11 | `800`    | Dreckschleuder  |
| 12 | `1000`   | Steinschlag     |
| 13 | `2000`   | Sumpffeld       |
| 14 | `4000`   | Erdrutsch       |
| 15 | `8000`   | Erdbeben        |
| 16 | `10000`  | Windhauch       |
| 17 | `20000`  | Windteufel      |
| 18 | `40000`  | Windheuler      |
| 19 | `80000`  | Donnerschlag    |
| 20 | `100000` | Wirbelsturm     |
| 21 | `200000` | Auflösung       |
| 22 | `400000` | Magische Pfeile |

## Special spells (items & monsters)
| Id | Bit      | Name           |
|---:|---------:|----------------|
| 1  | `2`      | Lähmen         |
| 2  | `4`      | Vergiften      |
| 3  | `8`      | Versteinern    |
| 4  | `10`     | Krankheit      |
| 5  | `20`     | Altern         |
| 6  | `40`     | Irritieren     |
| 7  | `80`     | Verrücktheit   |
| 8  | `100`    | Schlaf         |
| 9  | `200`    | Angst          |
| 10 | `400`    | Blindheit      |
| 11 | `800`    | Versteinern    |
| 12 | `1000`   | Kartenschau    |
| 13 | `2000`   | Dämon Bann     |
| 14 | `4000`   | Spruchpunkte 1 |
| 15 | `8000`   | Spruchpunkte 2 |
| 16 | `10000`  | Waffen Balsam  |
| 17 | `20000`  | Jugend         |
| 18 | `40000`  | Schloss Öffnen |
| 19 | `80000`  | Adlerruf       |
| 20 | `100000` | Musik          |

## In-Memory-Data
| Offset | Type |                                Name |
|-------:|-----:|------------------------------------:|
|      0 | byte |        Element \| Flags \| Location |
|      1 | byte |                             SP Cost |
|      2 | byte | Effect Mod? Not clear how it works. |
|      3 | byte |                              Target |

Element | Flags | Location

| Hex |       Bit |          Name |
|----:|----------:|--------------:|
|   1 |           | Overworld Map |
|   2 |           |     2d or 3d? |
|   4 |           |     2d or 3d? |
|   8 |           |          Camp |
|  10 |           |        Combat |
|  20 |           |   IsElemental |
|  30 | 001x xxxx |          Fire |
|  70 | 011x xxxx |         Water |
|  b0 | 101x xxxx |         Earth |
|  f0 | 111x xxxx |          Wind |

Target

| Bit |             Name |
|----:|-----------------:|
|   1 |    One Character |
|   2 |   All Characters |
|   4 |        One Enemy |
|   8 | Group of Enemies |
|  10 |      All Enemies |
|  20 |        Inventory |
|  40 |      Party (Buf) |
|  80 |      Environment |
