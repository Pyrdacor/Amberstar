# Compressed Text

Much of the Amberstar in-game text is compressed via a dictionary lookup scheme, based on a *string fragment table* stored in `AMBERDEV.UDO`.

## String Fragment Table

The String Fragment Table is a sequence of strings that are each preceded by a single byte indicating the string's length plus one. For instance, the string "ELF" is preceded by `04`. The last string is followed by a `00` byte. These strings form an indexable table of English/German words:

| Index | Word    |
|-------|---------|
| 1     | `HUMAN` |
| 2     | `ELF`   |
| 3     | `DWARF` |
| ....  | ...     |

The special character `#` indicates a newline.

The German version of the game presumably uses codepage 850 for German characters (*TO VERIFY*).

## Compressed Text Table Format

The Compressed Text table format describes a table of strings that encode dictionary lookups to the string fragment tabele.
Compressed Text tables consist either of two `00` bytes, indicating that the table is empty, or of the following:

| Name                 | Format                                   |
|----------------------|------------------------------------------|
| `num_text`           | u8                                       |
| 0                    | u8                                       |
| `pos[0]`             | u16                                      |
| ...                  |                                          |
| `pos[num_text]`      | u16                                      |
| `text[0]`            | u16[`pos[1] - pos[0]`]                   |
| ...                  |                                          |
| `text[num_text - 1]` | u16[`pos[num_text] - pos[num_text - 1]`] |

Note that there are `num_text + 1` text position entries, but only `num_text` texts; this simplifies determining how long each text is.
The text is then encoded as a sequence of u16 indices into the String Fragment Table. Since this sequence does not include whitespace, decoding text requires inserting whitespace at certain positions.

The following heuristic seems to produce decent results:

- When decoding, Insert a blank before the next string fragment if:
    - The next fragment is NOT the first fragment in the text
    - The previous fragment was NOT a newline
    - The next fragment starts with a letter, a number, a dash or a tilde symbol
