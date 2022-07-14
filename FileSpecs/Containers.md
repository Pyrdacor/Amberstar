# Container Formats

Amberstar encodes most of its data in *container files*, each of which contains a number of additional resources. The formats are as follows (using Ambermoon naming conventions):

- `LOB` (single file, compressed)
- `AMBR` (multi-file container, uncompressed)
- `AMPC` (multi-file container, optionally compressed)

A few files are raw files, i.e., stored without a surrounding container; we can read them directly.

The Amberstar container formats are a strict subset of the Ambermoon formats, so Ambermoon tools should work fine for handling Amberstar containers. The rest of this section details the Amberstar formats (only), for completeness.


## Automatically Identifying Containers

Each container starts with the following 4-byte header (expressed as a C string):

| Container | Header      |
|-----------|-------------|
| `LOB`     | `"\x01LOB"` |
| `AMBR`    | `"AMBR"`    |
| `AMPC`    | `"AMPC"`    |

Raw files do (coincidentally?) not match these headers.

## `LOB` Container format


`LOB` files have the format:

| Name         | Format       | Comments          |
|--------------|--------------|-------------------|
| `header`     | u8[4]        | always  `\x01LOB` |
| 6            | u8           | constant `6`      |
| `raw_size`   | u24          |                   |
| `compressed` | u8[&#x2026;] | until end of file |

Each `LOB` file stores one piece of compressed data. `raw_size` is the size of the output data after decompression. The compressed data follows the <span class="underline">LOB compression</span> scheme described below.

**Implementation Note**: When reading raw<sub>size</sub> as `u32`, make sure to mask out the most significant byte (the constant `06` byte).



### LOB Compression

The LOB compression scheme is detailed here: <https://github.com/Pyrdacor/Ambermoon/blob/master/Files/LOB.md>

Summary below:

LOB compression is an LZ77-style compression scheme that encodes data by giving a sequence of either literal bytes or back-references to previously decoded data. Conceptually, it is a stream of instructions that describe how to grow an (initially empty) output buffer:

- `BYTE(b)`: Append `b` to the output buffer, `out[pos++] = b` in C notation
- `BACKREF(p, l)`: Append `l` previously decoded bytes, starting at `out[pos - p]`, to the output buffer

These instructions are encoded in <span class="underline">chunks</span>, where each chunk consists of:

- 1 header byte
- 8 instructions (possibly fewer, at the end of the stream)

The header byte is a bitmask in which each bit describes the type of the 8 following instructions, in order from MSB to LSB:

- 0: instruction is `BACKREF(p, l)`, encoded as two bytes with nibbles `WX YZ` such that `l = X+3` and `p = WYZ`
- 1: instruction is `BYTE(b)`, encoded simply as `b`

Thus, a chunk is encoded as a sequence of 9 to 17 bytes, unless it is at the end of a stream.

Decompression ends as soon as the output buffer is full.


## `AMBR` Container Format

| Name                        | Format                        | Comments       |
|-----------------------------|-------------------------------|----------------|
| `header`                    | u8[4]                         | always  `AMBR` |
| `num_elements`              | u16                           |                |
| `sizes`                     | u32[`num_elements`]           |                |
| `element[0]`                | u8[`sizes[0]`]                | raw data       |
| ...                         |                               |                |
| `element[num_elements - 1]` | u8[`sizes[num_elements - 1]`] | raw data       |

This uncompressed format is straightforward, though it is oddly inefficient, in that looking up one element requires adding up the sizes of all preceding elements to find that element's offset.


## `AMPC` Container Format

| Name                              | Format                        | Comments                |
|-----------------------------------|-------------------------------|-------------------------|
| `header`                          | u8[4]                         | always  `AMPC`          |
| `num_elements`                    | u16                           |                         |
| `sizes`                           | u32[`num_elements`]           |                         |
| `element_block[0]`                | u8[`sizes[0]`]                | `LOB`-compressed or raw |
| ...                               |                               |                         |
| `element_block[num_elements - 1]` | u8[`sizes[num_elements - 1]`] | `LOB`-compressed or raw |

`AMPC` is similar to `AMBR`, except that instead of directly storing raw data, it may also store LOB-compressed data (see above). An `element_block` can thus be in one of:

- `LOB block` format
- raw format

The block is in `LOB block` format iff it matches the following format:

| Name              | Format              | Comments          |
|-------------------|---------------------|-------------------|
| `header`          | u8[4]               | always  `\x01LOB` |
| 6                 | u8                  | constant `6`      |
| `raw_size`        | u24                 |                   |
| `compressed_size` | u32                 |                   |
| `compressed`      | u8[compressed_size] |                   |

Otherwise, the block is raw, as in `AMBR` (implying that raw data must never "accidentally" start with the `LOB` header).
