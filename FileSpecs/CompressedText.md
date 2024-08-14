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
 
- The original code does it like this:
  - Is it an opening bracket? Yes? Just add.
  - Else if it is a carriage return, add a newline.
  - Else if it is a paragraph marker, add a newline and increase the paragraph counter.
  - Else if it is **not** a punctuation, add it and an additional space.
  - If it is a punctuation, check if start of line. If so, add it and an additional space.
  - If a punctuation is not the start of line, check if last character is a space. If not, add and an additional space.
  - And if there was a space before a punctuation, just go 1 char back, add it and an additional space.
- So in short: For most cases just add them and an additional space and remove previous spaces if a punctuation is encountered which does not start a new line.
- Whenever a space is added, there is a check if the line is or would be too long. If so the previous space is searched and replaced by a carriage return. I guess this would even crash or access other memory parts if there would be no previous space as there are no additional security checks for that.

The following text fragments have special meaning (index as decimal):

Index | Meaning
------|--------
1580  | OpenBracket
1576  | CarrReturn
1577  | ParaMark
631   | !
1581  | )
1300  | '
166   | ,
155   | :
1302  | ;
170   | .
743   | ?

The last 8 are used as "end punctuation" to determine if a previous space should be removed.

All those offsets must never change when creating other text fragment lists! Note that those indices are 1-based. The first entry ("Human"/"Mensch") has index 1. I guess index 0 is just an empty string.

The maximum textblock size is 1000\*21. The maximum number of paragraphs is 16.

## Character Set

Amberstar seems to use the Atari ST character set (even on the Amiga).  This is not relevant for the English version of the game, but it affects the German version,
due to the placement of the `ß` character.  Concretely, the German release of Amberstar uses the following characters that are outside the ASCII character range:

| Character | Codepoint |
|-----------|-----------|
| Ä         | `8e`      |
| Ö         | `99`      |
| Ü         | `9a`      |
| ß         | `9e`      |
