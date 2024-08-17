This lists the spells with their id and bit value.
The id is used for Monsters and the bit value for PCs.
The English spell names are tentative, based on their order in the dictionary file.

## Spell schools
| Id | Bit | Name    |
|---:|----:|---------|
| 1  | `2` | white   |
| 2  | `4` | grey    |
| 3  | `8` | black   |
| 7  | `80`| special |


## White magic
| Id |        Bit | Name (German)         | Name (English)      |
|---:|-----------:|-----------------------|---------------------|
|  1 |        `2` | Heilung 1             | Healing 1           |
|  2 |        `4` | Heilung 2             | Healing 2           |
|  3 |        `8` | Heilung 3             | Healing 3           |
|  4 |       `10` | Heilung 4             | Healing 4           |
|  5 |       `20` | Heilung 5             | Healing 5           |
|  6 |       `40` | Allheilung            | Salvation           |
|  7 |       `80` | Wiederbelebung        | Reincarnation       |
|  8 |      `100` | Asche wandeln         | Conversion of Ashes |
|  9 |      `200` | Staub wandeln         | Conversion of Dust  |
| 10 |      `400` | Gift neutralisieren   | Neutralise Poison   |
| 11 |      `800` | Lähmung heilen        | Heal Stun           |
| 12 |     `1000` | Krankheit heilen      | Heal Sickness       |
| 13 |     `2000` | Alterung heilen       | Rejuvenation        |
| 14 |     `4000` | Entsteinern           | De-Petrification    |
| 15 |     `8000` | Aufwecken             | Wake Up             |
| 16 |    `10000` | Panik beseitigen      | Calm Panic          |
| 17 |    `20000` | Irritation beseitigen | Remove irritation   |
| 18 |    `40000` | Blindheit heilen      | Heal Blindness      |
| 19 |    `80000` | Verrücktheit heilen   | Heal Madness        |
| 20 |   `100000` | Lähmen                | Stun                |
| 21 |   `200000` | Schlaf                | Sleep               |
| 22 |   `400000` | Angst                 | Fear                |
| 23 |   `800000` | Irritieren            | Irritation          |
| 24 |  `1000000` | Erblinden             | Blind               |
| 25 |  `2000000` | Untote vernichten     | Destroy Undead      |
| 26 |  `4000000` | Heiliges Wort         | Holy Word           |
| 27 |  `8000000` | Fluch aufheben        | Remove Curse        |
| 28 | `10000000` | Essen erschaffen      | Provide Food        |

## Grey magic
| Id |       Bit | Name (German)     | Name (English)      |
|---:|----------:|-------------------|---------------------|
|  1 |       `2` | Licht             | Light 1             |
|  2 |       `4` | Licht 2           | Light 2             |
|  3 |       `8` | Licht 3           | Light 3             |
|  4 |      `10` | Rüstung Schutz 1  | Armour Protection 1 |
|  5 |      `20` | Rüstung Schutz 2  | Armour Protection 2 |
|  6 |      `40` | Rüstung Schutz 3  | Armour Protection 3 |
|  7 |      `80` | Waffen Macht 1    | Weapons Power 1     |
|  8 |     `100` | Waffen Macht 2    | Weapons Power 2     |
|  9 |     `200` | Waffen Macht 3    | Weapons Power 3     |
| 10 |     `400` | Anti-Magie 1      | Anti-Magic 1        |
| 11 |     `800` | Anti-Magie 2      | Anti-Magic 2        |
| 12 |    `1000` | Anti-Magie 3      | Anti-Magic 3        |
| 13 |    `2000` | Hellsicht 1       | Clairvoyance 1      |
| 14 |    `4000` | Hellsicht 2       | Clairvoyance 2      |
| 15 |    `8000` | Hellsicht 3       | Clairvoyance 3      |
| 16 |   `10000` | Unsichtbarkeit 1  | Invisibility 1      |
| 17 |   `20000` | Unsichtbarkeit 2  | Invisibility 2      |
| 18 |   `40000` | Unsichtbarkeit 3  | Invisibility 3      |
| 19 |   `80000` | Magische Sphäre   | Magic Sphere        |
| 20 |  `100000` | Magischer Kompass | Magic Compass       |
| 21 |  `200000` | Identifikation    | Identification      |
| 22 |  `400000` | Levitation        | Lavitation          |
| 23 |  `800000` | Hast              | Haste               |
| 24 | `1000000` | Massen-Hast       | Mass Haste          |
| 25 | `2000000` | Teleport          | Teleport            |
| 26 | `4000000` | Durchblick        | X-Ray Vision        |

## Black magic
| Id |      Bit | Name (German)   | Name (English) |
|---:|---------:|-----------------|----------------|
|  1 |      `2` | Feuerstrahl     | Beam of Fire   |
|  2 |      `4` | Feuerstoß       | Wall of Fire   |
|  3 |      `8` | Feuerball       | Fireball       |
|  4 |     `10` | Feuersturm      | Fire Storm     |
|  5 |     `20` | Feuerwalze      | Fire Cascade   |
|  6 |     `40` | Wasserloch      | Waterhole      |
|  7 |     `80` | Wasserfall      | Waterfall      |
|  8 |    `100` | Eisball         | Ice Ball       |
|  9 |    `200` | Eisschauer      | Ice Shower     |
| 10 |    `400` | Hagelschlag     | Hail Storm     |
| 11 |    `800` | Dreckschleuder  | Mud Catapult   |
| 12 |   `1000` | Steinschlag     | Falling Rock   |
| 13 |   `2000` | Sumpffeld       | Bog            |
| 14 |   `4000` | Erdrutsch       | Landslide      |
| 15 |   `8000` | Erdbeben        | Earthquake     |
| 16 |  `10000` | Windhauch       | Strong Wind    |
| 17 |  `20000` | Windteufel      | Storm          |
| 18 |  `40000` | Windheuler      | Tornado        |
| 19 |  `80000` | Donnerschlag    | Thunder        |
| 20 | `100000` | Wirbelsturm     | Hurricane      |
| 21 | `200000` | Auflösung       | Desintegration |
| 22 | `400000` | Magische Pfeile | Magic Arrows   |

## Special spells (items & monsters)
| Id |      Bit | Name (German)  | Name (English) |
|---:|---------:|----------------|----------------|
|  1 |      `2` | Lähmen         | Stunned        |
|  2 |      `4` | Vergiften      | Poison         |
|  3 |      `8` | Versteinern    | Flesh to Stone |
|  4 |     `10` | Krankheit      | Make Ill       |
|  5 |     `20` | Altern         | Aging         |
|  6 |     `40` | Irritieren     | Irritation     |
|  7 |     `80` | Verrücktheit   | Make Mad       |
|  8 |    `100` | Schlaf         | Sleep          |
|  9 |    `200` | Angst          | Panic          |
| 10 |    `400` | Blindheit      | Blinding Flash |
| 11 |    `800` | Versteinern    | Flesh To Stone |
| 12 |   `1000` | Kartenschau    | Mapshow        |
| 13 |   `2000` | Dämon Bann     | Banish Demon   |
| 14 |   `4000` | Spruchpunkte 1 | Spellpoints 1  |
| 15 |   `8000` | Spruchpunkte 2 | Spellpoints 2  |
| 16 |  `10000` | Waffen Balsam  | Weapon Balm    |
| 17 |  `20000` | Jugend         | Youth          |
| 18 |  `40000` | Schloss Öffnen | Pick Lock      |
| 19 |  `80000` | Adlerruf       | Eagle Call     |
| 20 | `100000` | Musik          | Music          |

In at least some versions of the English AMBERDEV data file, the string indices for
the special spell names `18` and `20` seem to point to the wrong entries, with
`18` pointing to the string "POTIONS?" and `20` pointing to an invalid index.
