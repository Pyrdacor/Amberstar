# Changes compared to the original source code

This list is generated from the `; CHANGE:` comments of the merged source (`merged/AMBRSTAR_GERMAN.S`).
It shows how the shipped program (German Atari ST version) differs from the original source in the routines
which are taken from the original source. The original source is an older snapshot, so these are the changes
of the later development (bugfixes and other changes).

* `was "…"` – the instruction of the original source which was replaced by the instruction of the program
* `added` – an instruction of the program which is not in the original source
* `removed "…"` – an instruction of the original source which is not in the program

Some changes may also come from the assembler which built the program (e.g. other encodings of the same
instruction). 492 routines are taken from the original source, 79 of them have changes.

## LAYOUT/LAYOUT.ASM

15 routines taken, 5 with changes.

### Show_updated_status_block

* `sf.b Updated` – was "clr.b Updated"

### Update_status_block

* `clr.l $4(a1)` – added
* `clr.l $8(a1)` – added
* `clr.w $c(a1)` – added
* `bsr.w Erase_status_icon` – added
* `bsr.w Erase_bars` – added

### Erase_portrait

* `lea.l D_40aea,a0` – was "lea.l Void,a0"

### Show_control_icons

* removed "move.w #0,Draw_Cicon"
* removed "move.w #0,Erase_Cicon"

### Do_control_icons

* `jsr My_vsync` – added

## LAYOUT/OBJFIND.ASM

3 routines taken, 0 with changes.

## LAYOUT/WINDOWS.ASM

2 routines taken, 0 with changes.

## MAIN/EVENTS.ASM

62 routines taken, 8 with changes.

### Damage_trap

* `movem.l d1/a0,-(a7)` – was "movem.l d1/a5,-(sp)"

### Event_text

* removed "move.l (sp)+,.Filth+2"
* removed "move.l #.Dirty,Return_ptr(a0)"
* `move.w #$0,Draw_Cicon` – was "bra.s .Exit"
* `jsr Input_handler` – was ".Dirty: clr.l TxtW_Mod+Return_ptr"
* `movea.l Module_sp,a0` – was "movea.l Event_data_ptr,a5"
* `move.l (a0),d0` – was ".Filth: jsr $deadface"
* `beq.b .c_07ec8` – added
* `movea.l d0,a0` – added
* `jsr (a0)` – added
* `jsr Switch_screen` – added
* `tst.b B_5c310` – added
* `beq.b .c_07eac` – added

### UseItemDoor_DisInit

* removed "Wait_4_unclick"

### P80_ModInit

* `jsr T_00208` – added

### Init_chest

* `moveq #0,d2` – added

### OpenedChest_DisInit

* removed "Push PA,Lay3_PA"
* removed "Push PA,Lay3_PA"

### RiddleMes

* removed "Wait_4_unclick"

### Update_control_icons

* `movem.l a0/a2,-(a7)` – added
* `movem.l (a7)+,a0/a2` – added

## MAIN/EYE.ASM

59 routines taken, 10 with changes.

### LearnSpell_DisInit

* `move.w #$c,d0` – was "HashMes 11"

### Mouth_clicked

* removed "Wait_4_unclick"

### DialogueCIL_evaluate

* `bpl.b .c_0e57c` – was "bmi.s .Ok6"
* `movea.l Action_ptr,a1` – added
* `moveq #9,d7` – added
* `cmpi.b #$6,(a1)+` – added
* `beq.b .Ok6` – added
* `dbra d7,.c_0e572` – added

### ShowItem_DisExit

* removed "Wait_4_unclick"

### DIA_Give_gold

* removed "Wait_4_unclick"

### DIA_Give_food

* removed "Wait_4_unclick"

### Text_res

* `btst #$1,Mouse_button_state` – added
* `bne.b .c_0ee20` – added

### Food_res

* `bra.w T_0cbee` – was "jmp Divide_food"

### Camp_DisUpd

* `bsr.w Update_quantity_colours` – added

### Camp_ModExit

* `jsr Set_spell_area` – added

## MAIN/INVENT.ASM

56 routines taken, 10 with changes.

### TransFood_DisInit

* `move.w #$60,d0` – was "move.w #Food_icon,d0"
* `lea.l Gold_txt,a0` – was "lea.l Food_txt,a0"
* `movem.l (a7)+,d0-d7/a0-a6` – added

### Go_Inv2

* `move.w #$482,d0` – was "move.w #$0402,d0"

### Inv2CIL_evaluate

* `tst.b Battling` – added
* `beq.b .c_11312` – added
* `bset #$7,$1(a0)` – added
* `bset #$7,$4(a0)` – added
* `bset #$7,$6(a0)` – added
* `bset #$7,$7(a0)` – added
* `bset #$7,$8(a0)` – added
* `move.w $3a(a1),d0` – added
* `andi.w #$e480,d0` – added
* `beq.b .c_11312` – added
* `bset #$7,$3(a0)` – added

### Show_object_name

* removed "cmpi.b #17,Item_type(a0)"
* removed "beq.s .Exit"

### Transparent_DisExit

* removed "Wait_4_unclick"

### ItemW_DisUpd

* `moveq #15,d0` – added
* `jsr IG_Set_ink` – added
* `moveq #2,d0` – added
* `jsr IG_Set_paper` – added
* `moveq #32,d1` – was "moveq.l #" ",d1"

### Continue_transfer_item

* `move.l #T_12b2c,TIVS_Ptr` – was "move.l #Inv2_Do_TI,TIVS_Ptr"

### Transfer_gold

* removed "Wait_4_unclick"
* `st.b B_5b82b` – added
* `lea.l TransGold_Mod,a0` – added
* `bsr.w Push_Module` – added
* `sf.b B_5b82b` – added
* `rts` – added
* `moveq #15,d0` – added
* `jsr IG_Set_ink` – added
* `moveq #2,d0` – added
* `jsr IG_Set_paper` – added
* `moveq #32,d0` – added
* `moveq #112,d1` – added
* `moveq #10,d2` – added
* `moveq #6,d3` – added
* `moveq #1,d6` – added
* `lea.l D_32894,a0` – added
* `jsr Open_window` – added
* `move.w d0,B_5b288` – added
* `movea.l Off_screen,a6` – added
* `moveq #2,d6` – added
* `moveq #16,d7` – added
* `move.w #$30,d0` – added
* `move.w #$a0,d1` – added
* `lea.l D_3afea,a0` – added
* `jsr Blot_unmasked_block` – added
* `move.w #$30,d0` – added
* `move.w #$b0,d1` – added
* `lea.l D_3b0ea,a0` – added
* `jsr Blot_unmasked_block` – added
* `move.w #$80,d0` – added
* `move.w #$b0,d1` – added
* `lea.l D_3ccea,a0` – added
* `jsr Blot_unmasked_block` – added
* `bsr.w ItemW_DisUpd` – added
* `tst.b B_5b82b` – added
* `beq.b .c_12d36` – added
* `move.w #$80,d0` – added
* `move.w #$a0,d1` – added
* `moveq #2,d6` – added
* `moveq #16,d7` – added
* `lea.l D_3d0ea,a0` – added
* `jsr Blot_unmasked_block` – added
* `move.w #$31,d0` – added
* `move.w #$96,d1` – added
* `jsr IG_Set_cursor` – added
* `moveq #14,d0` – added
* `lea.l Code0001Sys,a1` – added
* `jsr Convert_text_line` – added
* `lea.l Line_buffer,a0` – was "Push Module,TransGold_Mod"
* `jsr IG_Print` – was "Push Module,TransGold_Mod"

### Transfer_food

* removed "Wait_4_unclick"
* `st.b B_5b82b` – added
* `sf.b B_5b82b` – added

### Pool_gold

* `move.w #$7fff,d4` – was "move.w #32767,d5"
* `sub.w d3,d4` – was "sub.w d3,d5"
* removed "sub.w d4,d5"
* removed "move.w d5,d4"
* `add.l d4,d1` – added

## MAIN/MAGIC.ASM

29 routines taken, 7 with changes.

### Create_food

* `movea.l (a0),a1` – added
* `move.w $3a(a1),d2` – was "move.w Body_conditions(a0),d1"
* `andi.w #$e000,d2` – was "andi.w #$e000,d1"
* `addq.w #$1,$92(a1)` – was "addq.w #1,Food_rations(a0)"
* `add.l d1,$ec(a1)` – was "add.l d1,Weight_normal(a0)"
* `bsr.w Do_sparkle` – added

### Identify

* `move.w #$19,WText_nr` – was "move.w #21,WText_nr"

### Minimap_DisUpd

* removed "move.w d0,d2"
* removed "move.w d1,d3"
* removed "lsr.w #3,d2"
* removed "lsr.w #3,d3"
* removed "sub.w Minimap_X,d2"
* removed "sub.w Minimap_Y,d3"
* removed "cmpi.w #12,d2"
* removed "bhi.s .Exit"
* removed "cmpi.w #10,d3"
* removed "bhi.s .Exit"
* `cmpi.w #$57,d0` – added
* `bhi.b .Exit` – added
* `cmpi.w #$47,d1` – added
* `bhi.b .Exit` – added

### Minimap_ModInit

* `addq.w #$7,d0` – was "addi.w #7,d0"
* `addq.w #$7,d1` – was "addi.w #7,d1"

### Spellpts1

* `add.w $8a(a0),d0` – was "add.w Power_points_normal(a0),d1"
* `move.w $8c(a0),d1` – was "move.w Power_points_max(a0),d0"
* `add.w $9a(a0),d1` – was "add.w Power_points_max_magic(a0),d0"

### Youth

* `bpl.b .c_1506c` – was "bmi.s .Exit"
* `moveq #15,d1` – added
* `tst.b Magic_object_flag` – added
* `beq.b .Exit` – added
* `movea.l Victim_ptr,a1` – added
* `cmpa.l Current_inventory_chardat_ptr,a1` – added
* `bne.b .Exit` – added
* `moveq #33,d7` – added
* `movea.l Off_screen,a6` – added
* `bsr.w Display_character` – added
* `jsr Switch_screen` – added
* `jsr Copy_screen` – added

### SpSelW_DisUpd

* `jsr Update_status_block` – added

## MAIN/MAP/2DCITY.ASM

14 routines taken, 1 with changes.

### Recalc_mapbuf_coords

* `cmpi.w #$fff6,d0` – was "cmpi.w #-11,d0"
* `cmpi.w #$fff8,d1` – was "cmpi.w #-9,d1"

## MAIN/MAP/2DMAP.ASM

10 routines taken, 3 with changes.

### Movement_check_2D

* `tst.b Current_map_type` – added
* `bne.b .c_02df0` – added
* `cmpi.w #$6,d0` – added
* `bmi.b .c_02dea` – added
* `cmpi.w #$6,d1` – added
* `bmi.b .c_02dea` – added
* `move.w Width_of_map,d2` – added
* `subq.w #$5,d2` – added
* `cmp.w d0,d2` – added
* `bmi.b .c_02dea` – added
* `move.w Height_of_map,d2` – added
* `subq.w #$5,d2` – added
* `cmp.w d1,d2` – added
* `bpl.b .c_02df0` – added
* `moveq #-1,d3` – added
* `bra.w .Exit` – added

### Display_night_circle

* `subq.w #$4,d1` – was "subq.w #2,d1"
* `addq.w #$4,d1` – was ".Up: addq.w #2,d1"
* `exg.l d1,d0` – was ".Again: exg.l d0,d1"
* `exg.l d1,d0` – was "exg.l d0,d1"

### Draw_two_lines

* `and.w d3,(a0)+` – added
* `and.w d3,(a0)+` – added
* `and.w d3,(a0)+` – added
* `and.w d3,-(a1)` – added
* `and.w d3,-(a1)` – added
* `and.w d3,-(a1)` – added

## MAIN/MAP/2DWILD.ASM

25 routines taken, 0 with changes.

## MAIN/MAP/3DCITY.ASM

2 routines taken, 0 with changes.

## MAIN/MAP/3DDUNGEO.ASM

2 routines taken, 0 with changes.

## MAIN/MAP/3DMAP.ASM

17 routines taken, 1 with changes.

### Movement_check_3D

* `cmpi.w #$6,d0` – added
* `bmi.b .c_03952` – added
* `cmpi.w #$6,d1` – added
* `bmi.b .c_03952` – added
* `move.w Width_of_map,d6` – added
* `subq.w #$5,d6` – added
* `cmp.w d0,d6` – added
* `bmi.b .c_03952` – added
* `move.w Height_of_map,d6` – added
* `subq.w #$5,d6` – added
* `cmp.w d1,d6` – added
* `bpl.b .c_03956` – added
* `moveq #-1,d0` – added
* `bra.b .Exit` – added

## MAIN/MAP/MAP.ASM

8 routines taken, 0 with changes.

## MAIN/MAP/SHADOW.ASM

1 routines taken, 0 with changes.

## MAIN/MODCON.ASM

4 routines taken, 2 with changes.

### Init_display

* `move.w #$0,Draw_Cicon` – added
* `jsr My_vsync` – added

### Exit_display

* `move.w #$0,Draw_Cicon` – added
* `jsr My_vsync` – added

## MAIN/MODULES.ASM

1 routines taken, 0 with changes.

## MAIN/PERSONS.ASM

9 routines taken, 1 with changes.

### Check_line_of_sight

* `exg.l d3,d2` – was "exg.l d2,d3"
* `exg.l d5,d4` – was "exg.l d4,d5"

## MAIN/PLACES.ASM

91 routines taken, 19 with changes.

### Transfer_gold_PLACES

* removed "Wait_4_unclick"

### Increase_level

* `subq.w #$1,d0` – added
* `addq.w #$1,d0` – added

### Guild_Member_left

* `move.l -$4(a0,d0.w),d0` – was "movea.l -4(a0,d0.w),a0"
* `beq.b .Exit` – added
* `movea.l d0,a0` – added
* `andi.w #$e406,d0` – was "andi.w #$e506,d0"

### Inc_skill

* `or.w (a0)+,d0` – added
* `or.w (a0)+,d0` – added
* `or.w (a0)+,d0` – added

### Reprint_skill

* `lea.l $ae(a1),a2` – was "lea.l Skill_1_normal_magic(a1),a2"
* `lea.l Skill_txt,a0` – was "lea.l Skill_txt,a3"
* `movea.l a0,a3` – was "moveq.l #"0",d1"
* `moveq #48,d1` – added
* removed "lea.l Skill_txt,a0"

### SellMItem_Return

* removed "Wait_4_unclick"

### BuyMItem_Return

* removed "Wait_4_unclick"

### BuyReq_ModExit

* removed "Wait_4_unclick"

### TMI_MOBJC_DisInit

* `subq.w #$1,d0` – was "lea.l Sold_slots-1,a2"
* `movea.l Itemslots_ptr,a2` – was "lea.l Sold_data-40,a3"
* `movea.l Itemdata_ptr,a3` – added

### MerchFOOD_DisInit

* `move.b #$20,(a3)+` – was "move.b #" ",(a3)+"
* removed "movea.l RText_ptr,a0"
* removed "move.w Nr_of_chars,d0"
* removed "move.w Lines_in_text,d1"
* removed "bra.s .Entry2"
* `bsr.w T_0707a` – was ".Loop2: jsr IG_Print"
* removed "jsr IG_Carriage_return"
* removed "lea.l 1(a0,d0.w),a0"
* removed ".Entry2: dbra d1,.Loop2"

### MFOOD_Transfer_food

* removed "Wait_4_unclick"

### BuyFood_Return

* removed "Wait_4_unclick"

### MerchHORSE_DisInit

* `bsr.w T_0dcde` – added
* `move.w d0,d1` – added
* `mulu.w d1,d0` – was "mulu.w Nr_members,d0"

### Healer_ModInit

* `bra.w T_0ab48` – was "jmp Places_ModInit"

### RemCurseYes

* removed "Wait_4_unclick"

### RemCurse_DisInit

* `bsr.w T_0d4e0` – added

### Lore_item

* removed "Wait_4_unclick"
* `move.w #$19,d0` – was "PlusMes 24"

### Sage_Member_left

* `andi.w #$e406,d1` – was "andi.w #$e506,d1"

### Inn_DisInit

* `bsr.w T_0dcde` – added
* `move.w d0,d1` – added
* `mulu.w d1,d0` – was "mulu.w Nr_members,d0"

## MAIN/STATUS.ASM

1 routines taken, 0 with changes.

## MAIN/TEST.ASM

7 routines taken, 1 with changes.

### Member_left

* `move.l -$4(a0,d0.w),d0` – was "movea.l -4(a0,d0.w),a0"
* `beq.b .Exit` – added
* `movea.l d0,a0` – added
* `andi.w #$e486,d0` – was "andi.w #$e506,d0"

## MAIN/TIME.ASM

7 routines taken, 2 with changes.

### Every_step

* `tst.w B_5c33e` – added
* `beq.b .c_06618` – added
* `subq.w #$1,B_5c33e` – added
* `bne.b .c_06618` – added
* `cmpi.w #$5,Travel_mode` – added
* `bpl.b .c_06618` – added
* `st.b D_1e1fc` – added

### Every_year

* removed "clr.w Active_member"
* `bsr.w T_006fe` – was "jsr Exit_display"
* removed "move.l a0,-(sp)"
* removed "Push Module,ActSel_Mod"
* removed "Push Module,ActSel_Mod"
* removed "movea.l (sp)+,a0"

## MAIN/WORDS.ASM

18 routines taken, 6 with changes.

### Convert_text_line

* removed "tst.w d6"
* removed "bpl.s .Entry2"
* removed "illegal"
* `move.b #$20,(a2)+` – was "move.b #" ",(a2)+"

### Prepare_scrolling

* `exg.l d6,d4` – was ".Loop: exg.l d4,d6"
* `exg.l d6,d4` – was "exg.l d4,d6"
* `exg.l a1,a0` – was "exg.l a0,a1"
* `exg.l a1,a0` – was "exg.l a0,a1"

### Refresh_text_window

* `cmp.w $6(a5),d3` – added
* `bmi.b .c_0741a` – added
* `bsr.w Erase_text_window` – added
* `bra.w .Exit` – added

### Prepare_text_block

* `move.l #$bb8,d0` – was "move.l #Max_textblock_size,d0"
* `exg.l a3,a1` – was "exg.l a1,a3"
* `bsr.w .Carriage_return` – added
* `lea.l Line_buffer,a2` – added
* removed "jsr .Carriage_return"
* `cmpi.b #$20,-$1(a2)` – was "cmpi.b #" ",-1(a2)"
* `move.b #$20,(a2)+` – was "move.b #" ",(a2)+"
* `cmpi.b #$20,-(a2)` – was ".Seek: cmpi.b #" ",-(a2)"
* `cmpi.b #$20,-$1(a2)` – was "cmpi.b #" ",-1(a2)"

### Init_RText

* `move.l #$1f4,d0` – was "move.l #Max_textblock_size,d0"

### Add_encoded_2_RText

* `move.l #$bb8,d0` – was "move.l #Max_textblock_size,d0"
* `exg.l a2,a1` – was "exg.l a1,a2"
* `cmpi.b #$20,-$1(a2)` – was ".Punct: cmpi.b #" ",-1(a2)"
* `move.b #$20,(a2)+` – was "move.b #" ",(a2)+"

## MAIN/WSELW.ASM

11 routines taken, 0 with changes.

## NUCLEUS/COLOFADE.ASM

4 routines taken, 0 with changes.

## NUCLEUS/DIAGNOST.ASM

5 routines taken, 0 with changes.

## NUCLEUS/GFXROUTS.ASM

2 routines taken, 0 with changes.

## NUCLEUS/HBI.ASM

4 routines taken, 0 with changes.

## NUCLEUS/INTROUTS.ASM

3 routines taken, 0 with changes.

## NUCLEUS/KBDROUTS.ASM

8 routines taken, 0 with changes.

## NUCLEUS/MEMORY.ASM

6 routines taken, 2 with changes.

### Reallocate_memory

* `ori.l #$80000000,d0` – added
* `move.l #$bf00ffff,d1` – was "move.l #$3f00ffff,d1"

### Connect_memory

* `move.l #$80000000,$8(a0)` – was "move.w #$8000,8(a0)"

## NUCLEUS/NUMERIC.ASM

1 routines taken, 0 with changes.

## NUCLEUS/SCREEN.ASM

4 routines taken, 0 with changes.

## NUCLEUS/TEXTPUT.ASM

1 routines taken, 1 with changes.

### IG_Print

* `cmpi.b #$7e,d0` – was ".Skip4: cmpi.b #"~",d0"

