THe main executables are GEMDOS PRG files (see https://freemint.github.io/tos.hyp/en/gemdos_programs.html).

The `*.udo` files usually are [LOB](Containers.md) compressed PRG files.

## PRG file header

Offset | Size | Meaning
--- | --- | ---
`00` | 2 | `0x60 0x1A`
`02` | 4 | `TEXT` (code) segment length
`06` | 4 | `DATA` segment length
`0A` | 4 | `BSS` segment length
`0E` | 4 | symbol table length
`12` | 4 | reserved -> `0`
`16` | 4 | flags (not important for reading)
`1A` | 2 | reloc info (if 0, there is a reloc table!)


## PRG data

After the header (18 bytes) first the code segment and then the data segment follow (sizes given in header).

Then the symbol table and optionally reloc table follow.


## Relocation table

The relocation table starts with a 32-bit value which marks the offset of the first value to be relocated relative
to the start of the code segment. Single bytes are then used for all following offsets. To be able to handle offsets greater
than 255 correctly, one proceeds as follows:

If a 1 is found as an offset (this is not possible due to the characteristics of the MC-680x0 processor family) then the value
254 is added automatically to the offset. For very large offsets this procedure can of course be repeated.

Incidentally, an empty relocation table is flagged with a LONG value of 0.
