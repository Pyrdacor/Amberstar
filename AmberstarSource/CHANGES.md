# Changes compared to the original source code

This list is generated from the `; CHANGE:` comments of the merged source (`merged/AMBRSTAR_GERMAN.S`).
It shows how the shipped program (German Atari ST version) differs from the original source in the routines
which are taken from the original source. The original source is an older snapshot, so these are the changes
of the later development (bugfixes and other changes).

* `was "…"` – the instruction of the original source which was replaced by the instruction of the program
* `added` – an instruction of the program which is not in the original source
* `removed "…"` – an instruction of the original source which is not in the program

Some changes may also come from the assembler which built the program (e.g. other encodings of the same
instruction). 695 routines are taken from the original source, 191 of them have changes.

## LAYOUT/LAYOUT.ASM

17 routines taken, 6 with changes.

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

### Show_status_block

* `moveq #16,d0` – added
* `moveq #1,d1` – added
* `moveq #5,d5` – added
* `moveq #2,d6` – added
* `moveq #34,d7` – added
* `lea.l D_40aea,a0` – added
* `jsr Blot_unmasked_block` – added
* `addi.w #$30,d0` – added
* `dbra d5,.c_06f32` – added

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

83 routines taken, 19 with changes.

### Damage_trap

* `movem.l d1/a0,-(a7)` – was "movem.l d1/a5,-(sp)"

### Do_damage

* `clr.w $86(a0)` – was "clr.w Active_member"
* `tst.b Battling` – added
* `bne.b .No` – added
* `bsr.w Check_party_alive` – was "jsr Exit_display"
* `bra.b .Exit` – was "move.l a0,-(sp)"
* removed "Push Module,ActSel_Mod"
* removed "Push Module,ActSel_Mod"
* removed "movea.l (sp)+,a0"

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

### UseItemDoor_objselect

* removed "Wait_4_unclick"
* `tst.b (a1)` – added
* `beq.w .Exit` – added

### Find_trap_DOOR

* `move.w #$0,Draw_Cicon` – was "Wait_4_unclick"
* `jsr My_vsync` – added

### Disarm_trap_DOOR

* removed "Wait_4_unclick"
* `move.w #$0,Draw_Cicon` – was "Wait_4_unclick"
* `jsr My_vsync` – added

### P80_ModInit

* `jsr T_00208` – added

### TxtW_ModInit

* `sf.b B_5c310` – added
* `move.w d0,B_5b288` – was "move.w d0,Window_handle"
* `move.w d0,B_5b288` – was "move.w d0,Window_handle"

### TxtW_ModExit

* `st.b B_5c310` – added
* `move.w B_5b288,d0` – was "move.w Window_handle,d0"
* removed "Wait_4_unclick"

### Init_chest

* `moveq #0,d2` – added

### OpenedChest_ModInit

* `tst.b Fade_block` – added
* `bne.b .c_08d2c` – added
* `jsr T_00208` – added
* `bsr.w OpenedChest_DisInit` – was "jsr Init_display"

### OpenedChest_DisInit

* removed "Push PA,Lay3_PA"
* removed "Push PA,Lay3_PA"

### Transfer_gold_CHEST

* removed "Wait_4_unclick"
* removed "Wait_4_unclick"

### Divide_gold_CHEST

* `move.w #$0,Draw_Cicon` – was "Wait_4_unclick"
* `jsr My_vsync` – added

### RiddleM_ModInit

* `jsr T_00208` – added

### Answer_riddleM

* removed "Wait_4_unclick"

### RiddleMes

* removed "Wait_4_unclick"

### Update_control_icons

* `movem.l a0/a2,-(a7)` – added
* `movem.l (a7)+,a0/a2` – added

## MAIN/EYE.ASM

78 routines taken, 26 with changes.

### HearTxtW_ModInit

* `move.w d0,B_5c312` – was "move.w d0,Window_handle"
* `bsr.w Pop_PA` – added
* `movea.l Text_buffer,a0` – was "movea.l Off_screen,a6"
* `movea.l Off_screen,a6` – was "movea.l RText_ptr,a0"
* `bra.b .c_008d8` – was "subq.w #1,d7"
* `movea.l Text_buffer,a0` – added
* `jsr Free_memory` – added
* `lea.l D_31730,a0` – added
* `jsr Push_MA` – added
* `lea.l D_32c72,a0` – added
* `jsr Push_Root` – added
* `lea.l Lay6_target,a1` – added
* `lea.l Subfade1,a2` – added
* `lea.l Hbl_Lay6_list,a0` – added
* `jsr Update_HBL` – added
* `jsr My_vsync` – added
* `jsr My_vsync` – added
* `lea.l Lay6_below,a0` – added
* `jsr Fade_pal` – added
* `bne.b .c_00918` – added
* `lea.l Hbl_Lay6_list,a0` – added
* `jsr Update_HBL` – was "jsr Exit_RText"

### LearnSpell_DisInit

* `move.w #$c,d0` – was "HashMes 11"

### Eye_spy

* removed "Wait_4_unclick"

### Eye_clicked

* removed "Wait_4_unclick"

### Mouth_clicked

* removed "Wait_4_unclick"

### Dialogue_DisInit

* `move.w #$10,d0` – was "moveq.l #15,d0"
* `move.w #$27,d1` – added
* `move.w #$b0,d2` – added
* `lea.l D_30b29,a0` – added
* `bsr.w Print_centered_string` – was "jsr IG_Set_ink"
* `move.b #$20,(a3)+` – was "move.b #" ",(a3)+"
* `add.w $ac(a1),d0` – added
* `add.w Time_data_year,d0` – added

### DialogueCIL_evaluate

* `bpl.b .c_0e57c` – was "bmi.s .Ok6"
* `movea.l Action_ptr,a1` – added
* `moveq #9,d7` – added
* `cmpi.b #$6,(a1)+` – added
* `beq.b .Ok6` – added
* `dbra d7,.c_0e572` – added

### Do_DIADropItem

* removed "Wait_4_unclick"

### DIA_Ask_word

* removed "Wait_4_unclick"

### ShowItem_DisExit

* removed "Wait_4_unclick"

### ShowItem_objselect

* removed "Wait_4_unclick"

### DIA_Give_gold

* removed "Wait_4_unclick"

### DIA_Give_item

* removed "Wait_4_unclick"

### DIA_Give_food

* removed "Wait_4_unclick"

### Text_res

* `btst #$1,Mouse_button_state` – added
* `bne.b .c_0ee20` – added

### Food_res

* `bra.w T_0cbee` – was "jmp Divide_food"

### Automap_DisInit

* `exg.l d2,d0` – was "exg.l d0,d2"
* `exg.l d2,d0` – was "exg.l d0,d2"

### Options_menu

* removed "Wait_4_unclick"

### Exit_options

* removed "Wait_4_unclick"

### Music_off

* `move.w #$ffff,Music_block` – was "move.w #-1,Music_block"
* `move.l #$700ff00,$ffff8800.w` – added

### Quit_game

* removed "Wait_4_unclick"
* `move.l #T_0f804,ReqDo_ptr` – was "move.l #Exit_all,ReqDo_ptr"

### Exit_SaveGame

* removed "Wait_4_unclick"

### Camp_DisUpd

* `bsr.w Update_quantity_colours` – added

### Camp_ModExit

* `jsr Set_map_music` – added

### Exit_camp

* removed "Wait_4_unclick"

### Learn_spell

* removed "Wait_4_unclick"

## MAIN/INVENT.ASM

72 routines taken, 27 with changes.

### TransFood_DisInit

* `move.w #$60,d0` – was "move.w #Food_icon,d0"
* `lea.l Gold_txt,a0` – was "lea.l Food_txt,a0"
* `movem.l (a7)+,d0-d7/a0-a6` – added

### Inv1_DisExit

* removed "movem.l a0-a2,-(sp)"
* removed "movem.l (sp)+,a0-a2"

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

### Display_character

* `move.b #$20,(a3)+` – was "move.b #" ",(a3)+"
* `add.w Time_data_year,d0` – added

### Show_object_name

* removed "cmpi.b #17,Item_type(a0)"
* removed "beq.s .Exit"

### Transparent_DisExit

* removed "Wait_4_unclick"

### Do_DropItem

* removed "Wait_4_unclick"

### Do_Drop1Item

* removed "Wait_4_unclick"

### DropMItem_Return

* removed "Wait_4_unclick"

### ItemW_DisUpd

* `moveq #15,d0` – added
* `jsr IG_Set_ink` – added
* `moveq #2,d0` – added
* `jsr IG_Set_paper` – added
* `moveq #32,d1` – was "moveq.l #" ",d1"

### ItemW_DisInit

* `move.w d0,B_5b288` – was "move.w d0,Window_handle"

### ItemW_DisExit

* `move.w B_5b288,d0` – was "move.w Window_handle,d0"
* removed "Wait_4_unclick"

### UseItem_DisInit

* `lea.l D_30cc8,a0` – was "Push MA,UseItem_area"
* removed "Wait_4_unclick"

### View_item

* removed "Wait_4_unclick"

### ViewItem_DisInit

* `lea.l D_30cc8,a0` – was "Push MA,UseItem_area"
* removed "Wait_4_unclick"

### View_item_entry

* removed "Wait_4_unclick"

### ItemViewW1_DisInit

* removed "moveq.l #15,d0"
* removed "jsr IG_Set_ink"
* removed "moveq.l #2,d0"
* removed "jsr IG_Set_paper"
* `move.w d0,B_5b288` – was "move.w d0,Window_handle"
* `jsr Put_masked_block` – added
* `moveq #15,d0` – added
* `jsr IG_Set_ink` – added
* `moveq #2,d0` – added
* `jsr IG_Set_paper` – was "jsr Put_masked_block"

### Open_ExtraW

* removed "Wait_4_unclick"

### Do_TransferItem

* removed "Wait_4_unclick"

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

### Unequip_item

* removed "Wait_4_unclick"
* removed "cmpi.b #17,Item_type(a2)"
* removed "beq .Exit"
* `beq.w .Exit` – was "bne .Exit"

### TIVS_ModInit

* removed "Wait_4_unclick"

### TIVS_Action

* removed "Wait_4_unclick"

### Pool_gold

* `move.w #$7fff,d4` – was "move.w #32767,d5"
* `sub.w d3,d4` – was "sub.w d3,d5"
* removed "sub.w d4,d5"
* removed "move.w d5,d4"
* `add.l d4,d1` – added

## MAIN/MAGIC.ASM

79 routines taken, 22 with changes.

### Heal_diseased

* `moveq #5,d0` – was "moveq.l #7,d0"
* `moveq #9,d1` – was "moveq.l #11,d1"

### Heal_aged

* `moveq #6,d0` – was "moveq.l #8,d0"
* `moveq #8,d1` – was "moveq.l #12,d1"

### Heal_stoned

* `moveq #7,d0` – was "moveq.l #9,d0"
* `moveq #11,d1` – was "moveq.l #10,d1"

### Heal_panic

* `moveq #8,d0` – was "moveq.l #10,d0"
* `moveq #12,d1` – was "moveq.l #3,d1"

### Heal_irritated

* `moveq #9,d0` – was "moveq.l #11,d0"
* `moveq #10,d1` – was "moveq.l #0,d1"

### Create_food

* `movea.l (a0),a1` – added
* `move.w $3a(a1),d2` – was "move.w Body_conditions(a0),d1"
* `andi.w #$e000,d2` – was "andi.w #$e000,d1"
* `addq.w #$1,$92(a1)` – was "addq.w #1,Food_rations(a0)"
* `add.l d1,$ec(a1)` – was "add.l d1,Weight_normal(a0)"
* `bsr.w Do_sparkle` – added

### MagicComp_DisInit

* `move.w d0,B_5b288` – was "move.w d0,Window_handle"

### MagicComp_DisExit

* removed "Wait_4_unclick"
* `move.w B_5b288,d0` – was "move.w Window_handle,d0"

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

### Minimap_down

* `subq.w #$8,d1` – was "subi.w #9-1,d1"

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

### ClassSelected

* removed "Wait_4_unclick"

### SpSelW_DisUpd

* `jsr Update_status_block` – added

### SpellSelected

* removed "Wait_4_unclick"

### ExitSpellSelect

* removed "Wait_4_unclick"

### SpSel_1Up

* `bra.w T_15860` – was "jmp SpSel_UP"

### SpSel_1Down

* `bra.w T_15884` – was "jmp SpSel_DOWN"

### SpSel_8Up

* `bra.w T_15860` – was "jmp SpSel_UP"

### Victim_clicked

* removed "Wait_4_unclick"

## MAIN/MAP/2DCITY.ASM

15 routines taken, 2 with changes.

### C2_ModInit

* removed "Pop MA"
* `bsr.w T_00208` – was "jsr C2_DisInit"
* `bsr.w C2_DisInit` – was "jsr Event_handler"
* `bsr.w Event_handler` – added

### Recalc_mapbuf_coords

* `cmpi.w #$fff6,d0` – was "cmpi.w #-11,d0"
* `cmpi.w #$fff8,d1` – was "cmpi.w #-9,d1"

## MAIN/MAP/2DMAP.ASM

12 routines taken, 4 with changes.

### Display_sky_icons

* `movem.l d0-d3/d5-d7/a0-a3,-(a7)` – was "movem.l d0-d3/d5-d7/a1-a3,-(sp)"
* `movem.l (a7)+,d0-d3/d5-d7/a0-a3` – was "movem.l (sp)+,d0-d3/d5-d7/a1-a3"

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

27 routines taken, 0 with changes.

## MAIN/MAP/3DCITY.ASM

4 routines taken, 2 with changes.

### C3_ModInit

* removed "Pop MA"
* `exg.l a1,a0` – was "exg.l a0,a1"
* `exg.l a1,a0` – was "exg.l a0,a1"
* `bsr.w T_00208` – was "jsr C3_DisInit"
* `bsr.w C3_DisInit` – was "jsr Event_handler"
* `bsr.w Event_handler` – added

### C3_DisUpd

* `move.w #$c1,d1` – was "add.w d7,d1"
* `sub.w d7,d1` – added

## MAIN/MAP/3DDUNGEO.ASM

3 routines taken, 1 with changes.

### D3_ModInit

* removed "Pop MA"
* `bsr.w T_00208` – was "jsr D3_DisInit"
* `bsr.w D3_DisInit` – was "jsr Event_handler"
* `bsr.w Event_handler` – added

## MAIN/MAP/3DMAP.ASM

18 routines taken, 2 with changes.

### D3_fullturnright

* `bsr.w T_0373a` – was "jsr D3_turnright"
* `bsr.w T_0373a` – was "jsr D3_turnright"

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

12 routines taken, 1 with changes.

### Map_CIL_evaluate

* `cmpi.b #$2,Current_map_type` – added
* `bpl.b .c_02584` – added
* `bra.b .Exit` – added
* `bset #$7,$1(a0)` – added
* `bset #$7,$3(a0)` – added
* `bset #$7,$5(a0)` – added
* `bset #$7,$7(a0)` – added

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

12 routines taken, 3 with changes.

### ThreeD_char_handler

* removed "move.w VChar_X(a1),d0"
* removed "move.w VChar_Y(a1),d1"

### Check_line_of_sight

* `exg.l d3,d2` – was "exg.l d2,d3"
* `exg.l d5,d4` – was "exg.l d4,d5"

### CombatYes

* `move.w Active_member,B_5aa94` – added
* `jsr Pop_Module` – was "jsr Exit_display"
* `jsr Exit_display` – added

## MAIN/PLACES.ASM

114 routines taken, 43 with changes.

### Divide_gold_PLACES

* removed "Wait_4_unclick"

### Transfer_gold_PLACES

* removed "Wait_4_unclick"

### GuildCIL_evaluate

* `lea.l D_4a318,a3` – was "lea.l Class_dat+10,a3"
* `cmpi.b #$32,$1b(a1)` – was "cmpi.b #MaxLevel,Level_nr(a1)"

### Join_guild

* `move.w #$0,Draw_Cicon` – was "Wait_4_unclick"
* `jsr My_vsync` – added
* `lea.l D_4a30e,a2` – was "lea.l Class_dat,a2"

### Make_level

* removed "Wait_4_unclick"
* `move.w #$0,Draw_Cicon` – was "Wait_4_unclick"
* `jsr My_vsync` – added

### Increase_level

* `subq.w #$1,d0` – added
* `addq.w #$1,d0` – added

### Guild_Member_left

* `move.l -$4(a0,d0.w),d0` – was "movea.l -4(a0,d0.w),a0"
* `beq.b .Exit` – added
* `movea.l d0,a0` – added
* `andi.w #$e406,d0` – was "andi.w #$e506,d0"

### SkillW_ModInit

* `move.w d0,B_5b288` – was "move.w d0,Window_handle"
* removed "lea.l Control_icn+7680,a0"
* removed "jsr Blot_unmasked_block"
* `lea.l D_3ccea,a0` – was "lea.l Chequered,a0"
* `jsr Blot_unmasked_block` – was "jsr Blot_masked_block"
* `lea.l Skill_txt,a0` – was "lea.l Skill_txt,a3"
* `movea.l a0,a3` – was "moveq.l #"0",d1"
* `moveq #48,d1` – added
* removed "lea.l Skill_txt,a0"
* removed "Update_screen"
* removed "Update_screen"
* removed "move.w #10,Remaining_offset"
* `move.w $78(a0),d0` – added
* `bne.b .c_0b442` – added
* `moveq #10,d0` – added
* `move.w d0,Remaining_offset` – added
* `moveq #0,d0` – added
* `moveq #0,d1` – added
* `add.w d0,d1` – added
* `cmp.w Remaining_offset,d1` – added
* `bpl.b .c_0b474` – added
* `move.w d1,Remaining_offset` – added
* `tst.w Remaining_offset` – added
* `beq.b .c_0b486` – added
* `or.w -(a1),d0` – added
* `or.w -(a1),d0` – added
* `or.w -(a1),d0` – added
* `beq.b .c_0b4a6` – added
* `move.w #$30,d0` – added
* `move.w #$85,d1` – added
* `moveq #2,d6` – added
* `moveq #16,d7` – added
* `lea.l Chequered,a0` – added
* `jsr Blot_masked_block` – added
* `jsr Switch_screen` – added
* `jsr Copy_screen` – added

### SkillW_ModExit

* `move.w B_5b288,d0` – was "move.w Window_handle,d0"

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

### Exit_SkillW

* removed "Wait_4_unclick"
* `move.b #$20,(a3)+` – was "move.b #" ",(a3)+"
* `bsr.w T_0707a` – was ".No_magic: jsr Erase_text_window"
* removed "movea.l RText_ptr,a0"
* removed "move.w Nr_of_chars,d0"
* removed "move.w Lines_in_text,d7"
* removed "bra.s .Entry"
* removed ".Loop: jsr IG_Print"
* removed "jsr IG_Carriage_return"
* removed "lea.l 1(a0,d0.w),a0"
* removed ".Entry: dbra d7,.Loop"
* removed "Update_screen"

### View_item_MOBJC

* removed "Wait_4_unclick"

### ViewItem_objselect

* removed "Wait_4_unclick"

### Sell_item

* removed "Wait_4_unclick"

### SellItem_objselect

* removed "Wait_4_unclick"

### SellMItem_Return

* removed "Wait_4_unclick"

### SellYes

* removed "Wait_4_unclick"

### Buy_item

* removed "Wait_4_unclick"

### BuyMItem_Return

* removed "Wait_4_unclick"

### BuyReq_ModExit

* removed "Wait_4_unclick"

### Do_TIMOBJC

* removed "Wait_4_unclick"
* `movea.l Itemslots_ptr,a1` – was "lea.l Sold_slots,a1"
* `movea.l Itemdata_ptr,a2` – was "lea.l Sold_data,a2"

### TMI_MOBJC_DisInit

* `subq.w #$1,d0` – was "lea.l Sold_slots-1,a2"
* `movea.l Itemslots_ptr,a2` – was "lea.l Sold_data-40,a3"
* `movea.l Itemdata_ptr,a3` – added

### TMI_MOBJC_Return

* `movea.l Itemdata_ptr,a0` – was "lea.l Sold_data-40,a0"
* `subq.w #$1,d0` – added

### MOBJC_TI_2

* `movea.l Itemdata_ptr,a0` – was "lea.l Sold_data,a0"
* `subq.w #$1,d0` – added
* `move.b (a0,d0.w),TIVS_Icon_nr` – was "move.b -40(a0,d0.w),TIVS_Icon_nr"

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

### MerchRAFT_DisUpd

* `lea.l T_0ce3e,a1` – was "lea.l MRAFTCIL_evaluate,a1"

### MerchSHIP_DisUpd

* `lea.l D_29182,a0` – was "lea.l MSHIP_CIL,a0"
* `lea.l T_0cf40,a1` – was "lea.l MSHIPCIL_evaluate,a1"

### Healer_ModInit

* `bra.w T_0ab48` – was "jmp Places_ModInit"

### HealCondYes

* removed "Wait_4_unclick"

### RemCurseYes

* removed "Wait_4_unclick"

### RemCurse_DisInit

* `bsr.w T_0d4e0` – added

### Show_item_destruction

* `jsr My_vsync` – added
* `jsr My_vsync` – added
* `jsr Put_masked_block` – added
* `jsr Switch_screen` – added
* `jsr My_vsync` – was "jsr Put_masked_block"
* `jsr My_vsync` – was "jsr Switch_screen"

### Display_BodyMind

* `moveq #0,d1` – was "move.l #0,d1"

### Lore_item

* removed "Wait_4_unclick"
* `move.w #$19,d0` – was "PlusMes 24"

### LoreItemYes

* `movea.l Current_active_char_data,a0` – was "Wait_4_unclick"
* `lea.l $22(a0),a1` – was "move.l Current_active_char_data,Current_inventory_chardat_ptr"
* `lea.l $132(a0),a0` – added
* `move.l a0,Itemdata_ptr` – added
* `move.l a1,Itemslots_ptr` – added
* `move.l #T_0dad0,$28(a0)` – added

### Sage_Member_left

* `andi.w #$e406,d1` – was "andi.w #$e506,d1"

### Inn_DisInit

* `bsr.w T_0dcde` – added
* `move.w d0,d1` – added
* `mulu.w d1,d0` – was "mulu.w Nr_members,d0"

### Guestroom

* removed "Wait_4_unclick"

### GuestroomYes

* removed "Wait_4_unclick"

## MAIN/STATUS.ASM

1 routines taken, 0 with changes.

## MAIN/TEST.ASM

22 routines taken, 5 with changes.

### Load_party_data

* `cmpi.l #$59415921,(a0)` – added
* `bne.b .c_00342` – added
* `addq.l #$4,a0` – added
* `move.w (a0),d0` – added
* `eori.w #$4a48,d0` – added
* `move.l B_60126,d7` – added
* `subq.l #$4,d7` – added
* `bsr.w T_00ef0` – added
* `addq.l #$2,a0` – added

### Member_left

* `move.l -$4(a0,d0.w),d0` – was "movea.l -4(a0,d0.w),a0"
* `beq.b .Exit` – added
* `movea.l d0,a0` – added
* `andi.w #$e486,d0` – was "andi.w #$e506,d0"

### Display_damage

* `exg.l d0,d2` – was "exg.l d2,d0"
* `exg.l d2,d0` – was "exg.l d0,d2"

### Req_ModInit

* `move.w #$3c,d1` – was "move.w #80,d1"
* `move.w d0,B_5c31a` – was "move.w d0,Window_handle"
* `move.w #$6c,d1` – was "move.w #80+48,d1"

### Req_ModExit

* `move.w B_5c31a,d0` – was "Req_ModExit: move.w Window_handle,d0"
* removed "Wait_4_unclick"

## MAIN/TIME.ASM

8 routines taken, 2 with changes.

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
* `bsr.w Check_party_alive` – was "jsr Exit_display"
* removed "move.l a0,-(sp)"
* removed "Push Module,ActSel_Mod"
* removed "Push Module,ActSel_Mod"
* removed "movea.l (sp)+,a0"

## MAIN/WORDS.ASM

23 routines taken, 8 with changes.

### Find_word

* `cmp.w B_5adfe,d0` – added
* `bmi.b .c_07250` – added
* `lea.l D_31d8e,a1` – added
* `jsr DI_Error` – added
* `bra.b .c_07282` – added
* `tst.b (a0)` – added
* `bne.b .c_07282` – added
* `lea.l D_31db8,a1` – added
* `jsr DI_Error` – added

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

### Mr_Blue_Sky

* removed "addq.w #1,d0"

### Init_RText

* `move.l #$1f4,d0` – was "move.l #Max_textblock_size,d0"

### Add_encoded_2_RText

* `move.l #$bb8,d0` – was "move.l #Max_textblock_size,d0"
* `exg.l a2,a1` – was "exg.l a1,a2"
* `cmpi.b #$20,-$1(a2)` – was ".Punct: cmpi.b #" ",-1(a2)"
* `move.b #$20,(a2)+` – was "move.b #" ",(a2)+"

## MAIN/WSELW.ASM

20 routines taken, 1 with changes.

### ExitWordSelect

* removed "Wait_4_unclick"

## NUCLEUS/COLOFADE.ASM

4 routines taken, 0 with changes.

## NUCLEUS/DIAGNOST.ASM

12 routines taken, 5 with changes.

### DI_Error

* `move.w #$7,-(a7)` – was "cmpi.b #"x",d0"
* `trap #$1` – was "bne.s .Exit"
* `addq.l #$2,a7` – was "illegal"
* `cmpi.b #$78,d0` – added
* `beq.b .Exit` – added
* `movea.l $4f2.w,a0` – added
* `movea.l $4(a0),a0` – added
* `jmp (a0)` – added

### DI_Cursor_home

* `clr.w B_60480` – was "clr.w Print_Y"

### DI_Carriage_return

* `move.w B_60480,d0` – was "move.w Print_Y,d0"
* `jsr Wait_4_key` – added
* `movea.l Screen_base,a6` – added
* `jsr Clear_screen` – added
* `move.w d0,B_60480` – was ".Exit: move.w d0,Print_Y"

### DI_Input

* `lea.l D_54b62,a0` – was "lea.l Output_string,a0"
* `lea.l B_6046d,a1` – was "lea.l Input_buffer,a1"
* `move.b #$20,$1(a0)` – was "move.b #" ",1(a0)"
* `cmpi.b #$30,d0` – was "cmpi.b #"0",d0"
* `cmpi.b #$39,d0` – was "cmpi.b #"9",d0"
* `subi.b #$30,d0` – was "subi.b #"0",d0"
* `lea.l D_54b62,a0` – was "lea.l Output_string,a0"

### DI_Pchar

* `adda.w B_60480,a6` – was "adda.w Print_Y,a6"

## NUCLEUS/GFXROUTS.ASM

2 routines taken, 0 with changes.

## NUCLEUS/HBI.ASM

6 routines taken, 0 with changes.

## NUCLEUS/INTROUTS.ASM

7 routines taken, 0 with changes.

## NUCLEUS/KBDROUTS.ASM

16 routines taken, 3 with changes.

### Mouse_draw_normal

* `move.w (a1),(a2)+` – added
* `and.w d3,(a1)` – added
* `or.w d2,(a1)+` – added
* `move.w (a1),(a2)+` – added
* `and.w d3,(a1)` – added
* `or.w d2,(a1)+` – added
* `move.w (a1),(a2)+` – added
* `and.w d3,(a1)` – added
* `or.w d2,(a1)+` – added
* `move.w (a1),(a2)+` – added
* `and.w d3,(a1)` – added
* `or.w d2,(a1)+` – added
* `move.w (a1),(a2)+` – added
* `and.w d3,(a1)` – added
* `or.w d2,(a1)+` – added
* `move.w (a1),(a2)+` – added
* `and.w d3,(a1)` – added
* `or.w d2,(a1)+` – added

### Mouse_draw_left

* `move.w (a1),(a2)+` – added
* `and.w d3,(a1)` – added
* `or.w d2,(a1)+` – added
* `move.w (a1),(a2)+` – added
* `and.w d3,(a1)` – added
* `or.w d2,(a1)+` – added
* `move.w (a1),(a2)+` – added
* `and.w d3,(a1)` – added
* `or.w d2,(a1)+` – added

### Mouse_draw_right

* `move.w (a1),(a2)+` – added
* `and.w d3,(a1)` – added
* `or.w d2,(a1)+` – added
* `move.w (a1),(a2)+` – added
* `and.w d3,(a1)` – added
* `or.w d2,(a1)+` – added
* `move.w (a1),(a2)+` – added
* `and.w d3,(a1)` – added
* `or.w d2,(a1)+` – added

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

5 routines taken, 0 with changes.

## NUCLEUS/TEXTPUT.ASM

5 routines taken, 5 with changes.

### IG_Backspace

* `move.w B_76734,d0` – was "move.w Print_X,d0"
* `move.w d0,B_76734` – was "move.w d0,Print_X"

### IG_Carriage_return

* `move.w (a0),B_76734` – was "move.w (a0),Print_X"

### IG_Set_cursor

* `move.w d0,B_76734` – was "move.w d0,Print_X"

### IG_Print

* `cmpi.b #$7e,d0` – was ".Skip4: cmpi.b #"~",d0"

### IG_Pchar_TRANS

* `move.w B_76734,d0` – was "move.w Print_X,d0"
* `move.w B_76734,d0` – was "move.w Print_X,d0"
* `move.w d0,B_76734` – was ".Skip: move.w d0,Print_X"

