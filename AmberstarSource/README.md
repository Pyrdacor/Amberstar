# Amberstar – source code of the main program (Atari ST)

This folder is the work on a complete source code of the Amberstar main program `AMBRSTAR.68K` (Atari ST,
German and English version). Like the Ambermoon source in the Ambermoon repository, it shall be created by merging

* the **original source code** of Amberstar by Jurie Horneman
  ([github.com/jhorneman/amberstar](https://github.com/jhorneman/amberstar), folder `src`), which is an
  older and incomplete snapshot, and
* the **disassembly of the shipped program**.

The original modules shall keep their names, comments and structure. The parts which are missing in the original
snapshot (most of all the combat, which is only a stub in `COMBAT.ASM`, and the music player) shall be
reconstructed from the disassembly, using the names the original code uses wherever possible.

## Status

| Step | State |
|------|-------|
| 1. Disassembly which assembles to a byte-identical program (German and English) | **done** (`disassembly/`) |
| 2. Names of the original source for the routines and variables of the disassembly (`SYMBOLS.txt`) | **first pass**: 1103 names for 842 addresses |
| 3. Original modules merged with the changes of the shipped program | open |
| 4. Missing parts (combat, music, …) reconstructed with names and comments | open |

## The program file

`AMBRSTAR.68K` on the game disk is a small program whose data segment is an LHA archive. The archive contains the
actual main program, a normal Atari ST program (PRG). The disassemblies are made of this inner program:

| Version | Size | Text | Data | BSS | Relocations |
|---------|------|------|------|-----|-------------|
| German  | 364342 bytes | $1dc94 | $37edc | $20bfa | 12446 |
| English | 351955 bytes | $1dc92 | $34eac | $20bfa | 12446 |

The addresses in the disassembly (and in the notes of the Amberstar.net project, e.g. `$f12` for the routine which
plays a song) are offsets from the start of the text segment.

## The disassembly

`disassembly/AMBRSTAR_GERMAN.s` and `disassembly/AMBRSTAR_ENGLISH.s` assemble to programs which are byte-identical
to the inner programs (header, text, data and relocation table):

```
vasmm68k_mot -m68000 -Ftos -tos-flags=1 -nosym -no-opt -o AMBRSTAR.PRG AMBRSTAR_GERMAN.s
```

(`vasmm68k_mot` 1.9 is in `Disks/Bugfixing/Executables` of the Ambermoon repository.)

* Labels are named after their section and offset: `T_` text, `D_` data, `B_` BSS (e.g. `T_00f12`).
* Every relocated longword of the program is a label reference, so the assembled program has the same relocations.
* Code is found by following the control flow from the start of the program and from the code pointers in the data
  (e.g. the module tables). Everything else is written as data (`dc.b`/`dc.l`). Some code which is only reached
  by indirect jumps is still data.
* Instructions which can't be written so that vasm creates the same bytes are written as `dc.w` with the instruction
  as a comment (e.g. `cmpi.b #$ff` which the original assembler encoded as `$ffff`).

`tools/ambrdis.py` creates the disassembly (Python 3 with [capstone](https://www.capstone-engine.org/)):

```
python ambrdis.py <inner program> <output.s> [SYMBOLS.txt]
python compare.py <inner program> <assembled program>
```

## The names (`SYMBOLS.txt`, `SYMBOLS_ENGLISH.txt`)

The labels of the disassembly have the names of the original source where they could be found. `SYMBOLS.txt` lists
them: address, label without a name, name in the original source, file of the original source and the number of
votes for the name. Labels without a name keep their address name (`T_00f12`).

`tools/symmatch.py` finds the names:

```
python ambrdis.py <inner program> <output.s>          (also writes <output.s>.code.tsv)
python symmatch.py <original src folder> <output.s>.code.tsv SYMBOLS.txt <inner program>
python ambrdis.py <inner program> <named.s> SYMBOLS.txt
```

* Both the routines of the original source (with the macros of the original expanded) and the code of the
  disassembly are turned into normalized instructions. Each routine of the original is searched in the disassembly
  by rare sequences of instructions and aligned with it.
* Aligned instructions give the names of their operands: `move.w Hour,d0` aligned with `move.w B_5c34e,d0` is one
  vote for `Hour` = `B_5c34e`. A name needs at least 2 votes and a clear majority. The start of a routine is only
  taken from the alignment if almost all of its instructions match.
* Pointer tables of the data (e.g. the module tables in `MODULES.ASM`) are aligned with the relocated longwords of
  the program, using the entries whose names are already known.
* An address can have several names. The first one is used for references, the others are additional labels. Some
  names come from the position in a table only: several `…_ModExit` entries of the shipped program point to the
  same routine (`$162`), so all their names are at that address.

Names which are not in the original source (e.g. the music) will be added in step 4.

## Known differences between the original source and the shipped program

Found so far by the Amberstar.net project (addresses of the German version):

* `Battle_check` (PERSONS.ASM) is switched off by an `rts` in the source, but active in the program (`$62c6`).
  The program also stores the index of the monster, which is used to remove it after the battle.
* `MaxLevel` is 20 in PLACES.ASM, but the program allows level 50 (`cmpi.b #50,Level_nr` at `$b044`).
* Learning a spell from a scroll (EYE.ASM, `LearnSpell_objselect`) checks in the program if the spell is already
  known (`$ff7c`). Then the selection ends without a message, the scroll and the spell learning points are kept.
* The music is not part of the source. The routine at `$f12` plays the song in `d0` (0 stops the music). The camp
  module plays song 17 (LULLABY) when it is opened (`$fd3e`), leaving the camp plays the song of the map again
  (`$2754`, Set_map_music).
* Persons with a path are not shown at the path position 6,6 (`$5c9a`, `$5dc4`), like in the source.

## Origin and rights

The original source code was published by Jurie Horneman, one of the developers of Amberstar. The Amberstar
repository says: *"These files are provided as is. They are meant for education, discussion, and historical work,
allowing researchers and students to study how Amberstar worked. Researchers are encouraged to share their
discoveries about the information in this repository."* It is unknown who holds the rights to the games of Thalion
Software. No rights are claimed, except the moral rights of the developers of Amberstar to be identified as such.
