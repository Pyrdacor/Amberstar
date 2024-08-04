# Combat Layout Files

The Amberstar combat map has the bottom two rows reserved for the
player party, and the top three rows for monsters.  A Combat Layout
File describes the contents of the three monster rows.

| Offset | Format | Name           |
|--------|--------|----------------|
| `0`    | u16[3] | `monster-id`   |
| `6`    | u8[3]  | `monster-mask` |

The order of the three rows is form bottom to top (i.e., in increasing
distance from the party), meaning that `monster-id[0]` describes the
bottom row.

- `monster-id[i]` is either zero (no monsters in this row) or a
  reference to a [CharData](CharData.md) record that describes the
  monster in row i
- `monster-mask[i]` is a bitmask that specifies the columns in which
  the monster is present.  The least siginificant bit is the rightmost
  column.  Since there are six columns, `0x3f` means that the entire
  row is full of monsters.
