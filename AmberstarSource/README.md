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
| 2. Names of the original source for the routines and variables of the disassembly (`SYMBOLS.txt`) | **done for the matching code**: 1431 names for 1392 addresses |
| 3. Original modules merged with the changes of the shipped program | **in progress**: 593 routines of the original source, 131 of them with the changes of the shipped program, one file per module (`src/`, `CHANGES.md`) |
| 4. Missing parts (combat, music, …) reconstructed with names and comments | **started**: 95 names with comments (`SYMBOLS_RECONSTRUCTED.txt`), among them the COSO music player, the code is still the disassembly |

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

* Labels are named after their section and offset: `T_` text, `D_` data, `B_` BSS (e.g. `T_00f12`). Labels of the text
  which are only used inside their routine (between two global labels) are local labels (`.l_17724`), option `--locals`.
* Every relocated longword of the program is a label reference, so the assembled program has the same relocations.
* Code is found by following the control flow from the start of the program and from the code pointers in the data
  (e.g. the module tables). Other pointers into the text and the gaps behind the end of a routine are taken as code
  if they decode cleanly up to the end of a routine. 95% of the text are code now, the rest is written as data
  (`dc.b`/`dc.l`).
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
  the program. Anchors are entries whose names are already known and which are only in this table, and the texts
  of the table (e.g. the ID `Camp screen.` of a module).
* The matching is repeated with the found names as part of the instructions (`jsr Free_memory` instead of a
  generic call), which makes short routines distinct.
* An address can have several names. The first one is used for references, the others are additional labels.

Names which are not in the original source are in `SYMBOLS_RECONSTRUCTED.txt` (addresses of the German version):
the music (`Play_song`, `Set_map_music`, `Current_song`, `Song_table`, the timer interrupt `My_timer_D` and about 30 names
of the COSO music player by Jochen Hippel: `Coso_player`, `Coso_play`, `Coso_init_module`, `Coso_YM_registers`, …), the
death of the party, the items in battles and about 55 routines of the combat (`Get_melee_targets`, `Flee`,
`Execute_attacks`, `End_of_combat`, …). It also contains 8 names of the original source which the matching did not find
because the shipped program differs there (e.g. `Init_computer`, which also sets the vector of timer D for the music).
They come from the notes of the Amberstar.net project (its `Docs/Combat.md` and the comments of its code) and have a
comment which is written in front of the label. The file also corrects names which were found at a wrong address
(e.g. `Set_spell_area` was found at the start of `Set_map_music`, because the shipped program calls the new music
routine where the original source calls `Set_spell_area`). `tools/overrides.py` applies it to a `SYMBOLS` file; for the
English version the addresses are found by the bytes of the German program (and by the references for tables).
In `SYMBOLS.txt` these names have an `R` instead of the number of votes.

## The merged source (`src/`, `src_english/`)

`src/` (German version) and `src_english/` contain the source in the structure of the original: one file per module of
the original source (`MAIN/EVENTS.S`, `MAIN/MAP/2DMAP.S`, `NUCLEUS/MEMORY.S`, …). `AMBRSTAR.S` includes them in the
order of the program, which is the order in which `TEST.ASM` includes the modules (followed by the layout and nucleus
modules which are linked behind it). Each module file contains its code, its data (`section data`) and its variables
(`section bss`) like the original modules. vasm appends the parts of a section in the order of the modules, so they
are at the same place as in the program. The boundaries of the modules in the data and the BSS are found in the same way
as in the code (by the names whose file is known).
Both versions assemble to byte-identical programs:

```
cd src
vasmm68k_mot -m68000 -Ftos -tos-flags=1 -nosym -no-opt -o AMBRSTAR.PRG AMBRSTAR.S
```

In the module files the routines of the original source replace the disassembled code wherever they could be made to
assemble to the same bytes. Each of them starts with a comment `; ---- <name> (original source: <file>)`. The other
code of a module is still the disassembly. `MAIN/COMBAT.S` is the combat, which is only a stub in the original source,
so it is completely disassembly for now (step 4).

`CONSTANTS.I` contains the constants of the original source (`CONST5X.ASM`, the structure offsets of `OFFSETS.ASM`
and the constants of the other modules).

### How it is made

`tools/merge.py` checks the routines (`origsrc.py` reads the original source for it and for `symmatch.py`):

```
python ambrdis.py <inner program> plain.s                          (also writes plain.s.code.tsv)
python symmatch.py <original src folder> plain.s.code.tsv SYMBOLS.txt <inner program>
python overrides.py SYMBOLS.txt SYMBOLS_RECONSTRUCTED.txt <German inner program> <inner program>
python ambrdis.py <inner program> named.s SYMBOLS.txt              (also writes named.s.code.tsv)
python merge.py <original src folder> <inner program> SYMBOLS.txt <vasm> merge.json plain.s.code.tsv named.s.code.tsv
python ambrdis.py <inner program> merged.s SYMBOLS.txt merge.json merge.json.constants.i --split=src
python changes.py merged.s CHANGES.md
```

* Each routine of the original is converted to vasm syntax (GFA directives, the macros of the original) and
  assembled at its address with all known names as constants. If the bytes are the same as in the program, the
  routine is taken. Names which are still unknown get marker values: if all other bytes match, the program gives
  their addresses.
* Routines whose address is unknown are tried behind the routine which is in front of them in their file, and in
  front of the routine which follows them. Checking, merging and these neighbours are repeated in rounds until a
  round finds nothing new.
* Only the names which a routine uses are defined in its source, so the source of a routine stays the same while other
  names are found. The results of vasm are kept by source text (`vasm.cache` next to `merge.json`), so the rounds and
  later runs only assemble what has changed.
* The assembler which built the shipped program optimized the code: `jsr`/`jmp` to a routine in reach became
  `bsr.w`/`bra.w`, and branches without a size became short branches where possible. The conversion does the same.
* Routines which differ are aligned instruction by instruction with the program. Equal instructions keep the line of
  the original source, the others are taken from the program with a comment: `; CHANGE: was "…"`,
  `; CHANGE: added` or `; CHANGE: removed "…"`. The local labels of the original stay at their addresses, new
  branch targets get local labels `.c_<address>`. The first instructions may differ, but a routine must not start
  with additional instructions of the program (they belong to the routine in front of it). The result must
  assemble to the same bytes as well.
* Labels inside a taken routine which are used from outside are defined behind the modules, relative to the start
  of the routine (`T_004e6 equ Member_left+24`).
* The boundaries of the modules are chosen so that as few known routines as possible are in another module than
  their file (a few names of the original are used in several modules).

So far 593 routines of the original source are in the merged source (German version), 131 of them with changes.
`CHANGES.md` lists these changes. About 120 routines of the original could not be found in the program yet, the
others could not be aligned or assembled.
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
