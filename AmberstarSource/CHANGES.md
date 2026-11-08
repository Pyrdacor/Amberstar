# Changes compared to the original source code

This list is generated from the `; CHANGE:` comments of the merged source (`src/`).
It shows how the shipped program (German Atari ST version) differs from the original source in the routines
which are taken from the original source. The original source is an older snapshot, so these are the changes
of the later development (bugfixes and other changes).

* `was "â€¦"` â€“ the instruction of the original source which was replaced by the instruction of the program
* `added` â€“ an instruction of the program which is not in the original source
* `removed "â€¦"` â€“ an instruction of the original source which is not in the program

Some changes may also come from the assembler which built the program (e.g. other encodings of the same
instruction). 576 routines are taken from the original source, 131 of them have changes.

## LAYOUT/LAYOUT.ASM

15 routines taken, 5 with changes.

### Show_updated_status_block

* `sf.b Updated` â€“ was "clr.b Updated"

### Update_status_block

* `clr.l $4(a1)` â€“ added
* `clr.l $8(a1)` â€“ added
* `clr.w $c(a1)` â€“ added
* `bsr.w Erase_status_icon` â€“ added
* `bsr.w Erase_bars` â€“ added

### Erase_portrait

* `lea.l D_40aea,a0` â€“ was "lea.l Void,a0"

### Show_control_icons

* removed "move.w #0,Draw_Cicon"
* removed "move.w #0,Erase_Cicon"

### Do_control_icons

* `jsr My_vsync` â€“ added

## LAYOUT/OBJFIND.ASM

3 routines taken, 0 with changes.

## LAYOUT/WINDOWS.ASM

2 routines taken, 0 with changes.

## MAIN/EVENTS.ASM

73 routines taken, 13 with changes.

### Damage_trap

* `movem.l d1/a0,-(a7)` â€“ was "movem.l d1/a5,-(sp)"

### Event_text

* removed "move.l (sp)+,.Filth+2"
* removed "move.l #.Dirty,Return_ptr(a0)"
* `move.w #$0,Draw_Cicon` â€“ was "bra.s .Exit"
* `jsr Input_handler` â€“ was ".Dirty: clr.l TxtW_Mod+Return_ptr"
* `movea.l Module_sp,a0` â€“ was "movea.l Event_data_ptr,a5"
* `move.l (a0),d0` â€“ was ".Filth: jsr $deadface"
* `beq.b .c_07ec8` â€“ added
* `movea.l d0,a0` â€“ added
* `jsr (a0)` â€“ added
* `jsr Switch_screen` â€“ added
* `tst.b B_5c310` â€“ added
* `beq.b .c_07eac` â€“ added

### UseItemDoor_DisInit

* removed "Wait_4_unclick"

### UseItemDoor_objselect

* removed "Wait_4_unclick"
* `tst.b (a1)` â€“ added
* `beq.w .Exit` â€“ added

### Find_trap_DOOR

* `move.w #$0,Draw_Cicon` â€“ was "Wait_4_unclick"
* `jsr My_vsync` â€“ added

### Disarm_trap_DOOR

* removed "Wait_4_unclick"
* `move.w #$0,Draw_Cicon` â€“ was "Wait_4_unclick"
* `jsr My_vsync` â€“ added

### P80_ModInit

* `jsr T_00208` â€“ added

### Init_chest

* `moveq #0,d2` â€“ added

### OpenedChest_DisInit

* removed "Push PA,Lay3_PA"
* removed "Push PA,Lay3_PA"

### Divide_gold_CHEST

* `move.w #$0,Draw_Cicon` â€“ was "Wait_4_unclick"
* `jsr My_vsync` â€“ added

### Answer_riddleM

* removed "Wait_4_unclick"

### RiddleMes

* removed "Wait_4_unclick"

### Update_control_icons

* `movem.l a0/a2,-(a7)` â€“ added
* `movem.l (a7)+,a0/a2` â€“ added

## MAIN/EYE.ASM

70 routines taken, 21 with changes.

### LearnSpell_DisInit

* `move.w #$c,d0` â€“ was "HashMes 11"

### Eye_spy

* removed "Wait_4_unclick"

### Eye_clicked

* removed "Wait_4_unclick"

### Mouth_clicked

* removed "Wait_4_unclick"

### DialogueCIL_evaluate

* `bpl.b .c_0e57c` â€“ was "bmi.s .Ok6"
* `movea.l Action_ptr,a1` â€“ added
* `moveq #9,d7` â€“ added
* `cmpi.b #$6,(a1)+` â€“ added
* `beq.b .Ok6` â€“ added
* `dbra d7,.c_0e572` â€“ added

### Do_DIADropItem

* removed "Wait_4_unclick"

### ShowItem_DisExit

* removed "Wait_4_unclick"

### ShowItem_objselect

* removed "Wait_4_unclick"

### DIA_Give_gold

* removed "Wait_4_unclick"

### DIA_Give_food

* removed "Wait_4_unclick"

### Text_res

* `btst #$1,Mouse_button_state` â€“ added
* `bne.b .c_0ee20` â€“ added

### Food_res

* `bra.w T_0cbee` â€“ was "jmp Divide_food"

### Options_menu

* removed "Wait_4_unclick"

### Exit_options

* removed "Wait_4_unclick"

### Music_off

* `move.w #$ffff,Music_block` â€“ was "move.w #-1,Music_block"
* `move.l #$700ff00,$ffff8800.w` â€“ added

### Quit_game

* removed "Wait_4_unclick"
* `move.l #T_0f804,ReqDo_ptr` â€“ was "move.l #Exit_all,ReqDo_ptr"

### Exit_SaveGame

* removed "Wait_4_unclick"

### Camp_DisUpd

* `bsr.w Update_quantity_colours` â€“ added

### Camp_ModExit

* `jsr Set_spell_area` â€“ added

### Exit_camp

* removed "Wait_4_unclick"

### Learn_spell

* removed "Wait_4_unclick"

## MAIN/INVENT.ASM

60 routines taken, 17 with changes.

### TransFood_DisInit

* `move.w #$60,d0` â€“ was "move.w #Food_icon,d0"
* `lea.l Gold_txt,a0` â€“ was "lea.l Food_txt,a0"
* `movem.l (a7)+,d0-d7/a0-a6` â€“ added

### Inv1_DisExit

* removed "movem.l a0-a2,-(sp)"
* removed "movem.l (sp)+,a0-a2"

### Go_Inv2

* `move.w #$482,d0` â€“ was "move.w #$0402,d0"

### Inv2CIL_evaluate

* `tst.b Battling` â€“ added
* `beq.b .c_11312` â€“ added
* `bset #$7,$1(a0)` â€“ added
* `bset #$7,$4(a0)` â€“ added
* `bset #$7,$6(a0)` â€“ added
* `bset #$7,$7(a0)` â€“ added
* `bset #$7,$8(a0)` â€“ added
* `move.w $3a(a1),d0` â€“ added
* `andi.w #$e480,d0` â€“ added
* `beq.b .c_11312` â€“ added
* `bset #$7,$3(a0)` â€“ added

### Show_object_name

* removed "cmpi.b #17,Item_type(a0)"
* removed "beq.s .Exit"

### Transparent_DisExit

* removed "Wait_4_unclick"

### Do_DropItem

* removed "Wait_4_unclick"

### Do_Drop1Item

* removed "Wait_4_unclick"

### ItemW_DisUpd

* `moveq #15,d0` â€“ added
* `jsr IG_Set_ink` â€“ added
* `moveq #2,d0` â€“ added
* `jsr IG_Set_paper` â€“ added
* `moveq #32,d1` â€“ was "moveq.l #" ",d1"

### View_item

* removed "Wait_4_unclick"

### Do_TransferItem

* removed "Wait_4_unclick"

### Continue_transfer_item

* `move.l #T_12b2c,TIVS_Ptr` â€“ was "move.l #Inv2_Do_TI,TIVS_Ptr"

### Transfer_gold

* removed "Wait_4_unclick"
* `st.b B_5b82b` â€“ added
* `lea.l TransGold_Mod,a0` â€“ added
* `bsr.w Push_Module` â€“ added
* `sf.b B_5b82b` â€“ added
* `rts` â€“ added
* `moveq #15,d0` â€“ added
* `jsr IG_Set_ink` â€“ added
* `moveq #2,d0` â€“ added
* `jsr IG_Set_paper` â€“ added
* `moveq #32,d0` â€“ added
* `moveq #112,d1` â€“ added
* `moveq #10,d2` â€“ added
* `moveq #6,d3` â€“ added
* `moveq #1,d6` â€“ added
* `lea.l D_32894,a0` â€“ added
* `jsr Open_window` â€“ added
* `move.w d0,B_5b288` â€“ added
* `movea.l Off_screen,a6` â€“ added
* `moveq #2,d6` â€“ added
* `moveq #16,d7` â€“ added
* `move.w #$30,d0` â€“ added
* `move.w #$a0,d1` â€“ added
* `lea.l D_3afea,a0` â€“ added
* `jsr Blot_unmasked_block` â€“ added
* `move.w #$30,d0` â€“ added
* `move.w #$b0,d1` â€“ added
* `lea.l D_3b0ea,a0` â€“ added
* `jsr Blot_unmasked_block` â€“ added
* `move.w #$80,d0` â€“ added
* `move.w #$b0,d1` â€“ added
* `lea.l D_3ccea,a0` â€“ added
* `jsr Blot_unmasked_block` â€“ added
* `bsr.w ItemW_DisUpd` â€“ added
* `tst.b B_5b82b` â€“ added
* `beq.b .c_12d36` â€“ added
* `move.w #$80,d0` â€“ added
* `move.w #$a0,d1` â€“ added
* `moveq #2,d6` â€“ added
* `moveq #16,d7` â€“ added
* `lea.l D_3d0ea,a0` â€“ added
* `jsr Blot_unmasked_block` â€“ added
* `move.w #$31,d0` â€“ added
* `move.w #$96,d1` â€“ added
* `jsr IG_Set_cursor` â€“ added
* `moveq #14,d0` â€“ added
* `lea.l Code0001Sys,a1` â€“ added
* `jsr Convert_text_line` â€“ added
* `lea.l Line_buffer,a0` â€“ was "Push Module,TransGold_Mod"
* `jsr IG_Print` â€“ was "Push Module,TransGold_Mod"

### Transfer_food

* removed "Wait_4_unclick"
* `st.b B_5b82b` â€“ added
* `sf.b B_5b82b` â€“ added

### Unequip_item

* removed "Wait_4_unclick"
* removed "cmpi.b #17,Item_type(a2)"
* removed "beq .Exit"
* `beq.w .Exit` â€“ was "bne .Exit"

### TIVS_Action

* removed "Wait_4_unclick"

### Pool_gold

* `move.w #$7fff,d4` â€“ was "move.w #32767,d5"
* `sub.w d3,d4` â€“ was "sub.w d3,d5"
* removed "sub.w d4,d5"
* removed "move.w d5,d4"
* `add.l d4,d1` â€“ added

## MAIN/MAGIC.ASM

61 routines taken, 19 with changes.

### Heal_diseased

* `moveq #5,d0` â€“ was "moveq.l #7,d0"
* `moveq #9,d1` â€“ was "moveq.l #11,d1"

### Heal_aged

* `moveq #6,d0` â€“ was "moveq.l #8,d0"
* `moveq #8,d1` â€“ was "moveq.l #12,d1"

### Heal_stoned

* `moveq #7,d0` â€“ was "moveq.l #9,d0"
* `moveq #11,d1` â€“ was "moveq.l #10,d1"

### Heal_panic

* `moveq #8,d0` â€“ was "moveq.l #10,d0"
* `moveq #12,d1` â€“ was "moveq.l #3,d1"

### Heal_irritated

* `moveq #9,d0` â€“ was "moveq.l #11,d0"
* `moveq #10,d1` â€“ was "moveq.l #0,d1"

### Create_food

* `movea.l (a0),a1` â€“ added
* `move.w $3a(a1),d2` â€“ was "move.w Body_conditions(a0),d1"
* `andi.w #$e000,d2` â€“ was "andi.w #$e000,d1"
* `addq.w #$1,$92(a1)` â€“ was "addq.w #1,Food_rations(a0)"
* `add.l d1,$ec(a1)` â€“ was "add.l d1,Weight_normal(a0)"
* `bsr.w Do_sparkle` â€“ added

### Identify

* `move.w #$19,WText_nr` â€“ was "move.w #21,WText_nr"

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
* `cmpi.w #$57,d0` â€“ added
* `bhi.b .Exit` â€“ added
* `cmpi.w #$47,d1` â€“ added
* `bhi.b .Exit` â€“ added

### Minimap_ModInit

* `addq.w #$7,d0` â€“ was "addi.w #7,d0"
* `addq.w #$7,d1` â€“ was "addi.w #7,d1"

### Minimap_down

* `subq.w #$8,d1` â€“ was "subi.w #9-1,d1"

### Spellpts1

* `add.w $8a(a0),d0` â€“ was "add.w Power_points_normal(a0),d1"
* `move.w $8c(a0),d1` â€“ was "move.w Power_points_max(a0),d0"
* `add.w $9a(a0),d1` â€“ was "add.w Power_points_max_magic(a0),d0"

### Youth

* `bpl.b .c_1506c` â€“ was "bmi.s .Exit"
* `moveq #15,d1` â€“ added
* `tst.b Magic_object_flag` â€“ added
* `beq.b .Exit` â€“ added
* `movea.l Victim_ptr,a1` â€“ added
* `cmpa.l Current_inventory_chardat_ptr,a1` â€“ added
* `bne.b .Exit` â€“ added
* `moveq #33,d7` â€“ added
* `movea.l Off_screen,a6` â€“ added
* `bsr.w Display_character` â€“ added
* `jsr Switch_screen` â€“ added
* `jsr Copy_screen` â€“ added

### SpSelW_DisUpd

* `jsr Update_status_block` â€“ added

### SpellSelected

* removed "Wait_4_unclick"

### ExitSpellSelect

* removed "Wait_4_unclick"

### SpSel_1Up

* `bra.w T_15860` â€“ was "jmp SpSel_UP"

### SpSel_1Down

* `bra.w T_15884` â€“ was "jmp SpSel_DOWN"

### SpSel_8Up

* `bra.w T_15860` â€“ was "jmp SpSel_UP"

### Victim_clicked

* removed "Wait_4_unclick"

## MAIN/MAP/2DCITY.ASM

15 routines taken, 2 with changes.

### C2_ModInit

* removed "Pop MA"
* `bsr.w T_00208` â€“ was "jsr C2_DisInit"
* `bsr.w C2_DisInit` â€“ was "jsr Event_handler"
* `bsr.w Event_handler` â€“ added

### Recalc_mapbuf_coords

* `cmpi.w #$fff6,d0` â€“ was "cmpi.w #-11,d0"
* `cmpi.w #$fff8,d1` â€“ was "cmpi.w #-9,d1"

## MAIN/MAP/2DMAP.ASM

11 routines taken, 4 with changes.

### Display_sky_icons

* `movem.l d0-d3/d5-d7/a0-a3,-(a7)` â€“ was "movem.l d0-d3/d5-d7/a1-a3,-(sp)"
* `movem.l (a7)+,d0-d3/d5-d7/a0-a3` â€“ was "movem.l (sp)+,d0-d3/d5-d7/a1-a3"

### Movement_check_2D

* `tst.b Current_map_type` â€“ added
* `bne.b .c_02df0` â€“ added
* `cmpi.w #$6,d0` â€“ added
* `bmi.b .c_02dea` â€“ added
* `cmpi.w #$6,d1` â€“ added
* `bmi.b .c_02dea` â€“ added
* `move.w Width_of_map,d2` â€“ added
* `subq.w #$5,d2` â€“ added
* `cmp.w d0,d2` â€“ added
* `bmi.b .c_02dea` â€“ added
* `move.w Height_of_map,d2` â€“ added
* `subq.w #$5,d2` â€“ added
* `cmp.w d1,d2` â€“ added
* `bpl.b .c_02df0` â€“ added
* `moveq #-1,d3` â€“ added
* `bra.w .Exit` â€“ added

### Display_night_circle

* `subq.w #$4,d1` â€“ was "subq.w #2,d1"
* `addq.w #$4,d1` â€“ was ".Up: addq.w #2,d1"
* `exg.l d1,d0` â€“ was ".Again: exg.l d0,d1"
* `exg.l d1,d0` â€“ was "exg.l d0,d1"

### Draw_two_lines

* `and.w d3,(a0)+` â€“ added
* `and.w d3,(a0)+` â€“ added
* `and.w d3,(a0)+` â€“ added
* `and.w d3,-(a1)` â€“ added
* `and.w d3,-(a1)` â€“ added
* `and.w d3,-(a1)` â€“ added

## MAIN/MAP/2DWILD.ASM

25 routines taken, 0 with changes.

## MAIN/MAP/3DCITY.ASM

2 routines taken, 0 with changes.

## MAIN/MAP/3DDUNGEO.ASM

3 routines taken, 1 with changes.

### D3_ModInit

* removed "Pop MA"
* `bsr.w T_00208` â€“ was "jsr D3_DisInit"
* `bsr.w D3_DisInit` â€“ was "jsr Event_handler"
* `bsr.w Event_handler` â€“ added

## MAIN/MAP/3DMAP.ASM

17 routines taken, 2 with changes.

### D3_fullturnright

* `bsr.w T_0373a` â€“ was "jsr D3_turnright"
* `bsr.w T_0373a` â€“ was "jsr D3_turnright"

### Movement_check_3D

* `cmpi.w #$6,d0` â€“ added
* `bmi.b .c_03952` â€“ added
* `cmpi.w #$6,d1` â€“ added
* `bmi.b .c_03952` â€“ added
* `move.w Width_of_map,d6` â€“ added
* `subq.w #$5,d6` â€“ added
* `cmp.w d0,d6` â€“ added
* `bmi.b .c_03952` â€“ added
* `move.w Height_of_map,d6` â€“ added
* `subq.w #$5,d6` â€“ added
* `cmp.w d1,d6` â€“ added
* `bpl.b .c_03956` â€“ added
* `moveq #-1,d0` â€“ added
* `bra.b .Exit` â€“ added

## MAIN/MAP/MAP.ASM

9 routines taken, 0 with changes.

## MAIN/MAP/SHADOW.ASM

1 routines taken, 0 with changes.

## MAIN/MODCON.ASM

4 routines taken, 2 with changes.

### Init_display

* `move.w #$0,Draw_Cicon` â€“ added
* `jsr My_vsync` â€“ added

### Exit_display

* `move.w #$0,Draw_Cicon` â€“ added
* `jsr My_vsync` â€“ added

## MAIN/MODULES.ASM

1 routines taken, 0 with changes.

## MAIN/PERSONS.ASM

9 routines taken, 1 with changes.

### Check_line_of_sight

* `exg.l d3,d2` â€“ was "exg.l d2,d3"
* `exg.l d5,d4` â€“ was "exg.l d4,d5"

## MAIN/PLACES.ASM

100 routines taken, 31 with changes.

### Divide_gold_PLACES

* removed "Wait_4_unclick"

### Transfer_gold_PLACES

* removed "Wait_4_unclick"

### Make_level

* removed "Wait_4_unclick"
* `move.w #$0,Draw_Cicon` â€“ was "Wait_4_unclick"
* `jsr My_vsync` â€“ added

### Increase_level

* `subq.w #$1,d0` â€“ added
* `addq.w #$1,d0` â€“ added

### Guild_Member_left

* `move.l -$4(a0,d0.w),d0` â€“ was "movea.l -4(a0,d0.w),a0"
* `beq.b .Exit` â€“ added
* `movea.l d0,a0` â€“ added
* `andi.w #$e406,d0` â€“ was "andi.w #$e506,d0"

### Inc_skill

* `or.w (a0)+,d0` â€“ added
* `or.w (a0)+,d0` â€“ added
* `or.w (a0)+,d0` â€“ added

### Reprint_skill

* `lea.l $ae(a1),a2` â€“ was "lea.l Skill_1_normal_magic(a1),a2"
* `lea.l Skill_txt,a0` â€“ was "lea.l Skill_txt,a3"
* `movea.l a0,a3` â€“ was "moveq.l #"0",d1"
* `moveq #48,d1` â€“ added
* removed "lea.l Skill_txt,a0"

### View_item_MOBJC

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
* `movea.l Itemslots_ptr,a1` â€“ was "lea.l Sold_slots,a1"
* `movea.l Itemdata_ptr,a2` â€“ was "lea.l Sold_data,a2"

### TMI_MOBJC_DisInit

* `subq.w #$1,d0` â€“ was "lea.l Sold_slots-1,a2"
* `movea.l Itemslots_ptr,a2` â€“ was "lea.l Sold_data-40,a3"
* `movea.l Itemdata_ptr,a3` â€“ added

### TMI_MOBJC_Return

* `movea.l Itemdata_ptr,a0` â€“ was "lea.l Sold_data-40,a0"
* `subq.w #$1,d0` â€“ added

### MOBJC_TI_2

* `movea.l Itemdata_ptr,a0` â€“ was "lea.l Sold_data,a0"
* `subq.w #$1,d0` â€“ added
* `move.b (a0,d0.w),TIVS_Icon_nr` â€“ was "move.b -40(a0,d0.w),TIVS_Icon_nr"

### MerchFOOD_DisInit

* `move.b #$20,(a3)+` â€“ was "move.b #" ",(a3)+"
* removed "movea.l RText_ptr,a0"
* removed "move.w Nr_of_chars,d0"
* removed "move.w Lines_in_text,d1"
* removed "bra.s .Entry2"
* `bsr.w T_0707a` â€“ was ".Loop2: jsr IG_Print"
* removed "jsr IG_Carriage_return"
* removed "lea.l 1(a0,d0.w),a0"
* removed ".Entry2: dbra d1,.Loop2"

### MFOOD_Transfer_food

* removed "Wait_4_unclick"

### BuyFood_Return

* removed "Wait_4_unclick"

### MerchHORSE_DisInit

* `bsr.w T_0dcde` â€“ added
* `move.w d0,d1` â€“ added
* `mulu.w d1,d0` â€“ was "mulu.w Nr_members,d0"

### Healer_ModInit

* `bra.w T_0ab48` â€“ was "jmp Places_ModInit"

### HealCondYes

* removed "Wait_4_unclick"

### RemCurseYes

* removed "Wait_4_unclick"

### RemCurse_DisInit

* `bsr.w T_0d4e0` â€“ added

### Lore_item

* removed "Wait_4_unclick"
* `move.w #$19,d0` â€“ was "PlusMes 24"

### Sage_Member_left

* `andi.w #$e406,d1` â€“ was "andi.w #$e506,d1"

### Inn_DisInit

* `bsr.w T_0dcde` â€“ added
* `move.w d0,d1` â€“ added
* `mulu.w d1,d0` â€“ was "mulu.w Nr_members,d0"

### Guestroom

* removed "Wait_4_unclick"

### GuestroomYes

* removed "Wait_4_unclick"

## MAIN/STATUS.ASM

1 routines taken, 0 with changes.

## MAIN/TEST.ASM

7 routines taken, 1 with changes.

### Member_left

* `move.l -$4(a0,d0.w),d0` â€“ was "movea.l -4(a0,d0.w),a0"
* `beq.b .Exit` â€“ added
* `movea.l d0,a0` â€“ added
* `andi.w #$e486,d0` â€“ was "andi.w #$e506,d0"

## MAIN/TIME.ASM

8 routines taken, 2 with changes.

### Every_step

* `tst.w B_5c33e` â€“ added
* `beq.b .c_06618` â€“ added
* `subq.w #$1,B_5c33e` â€“ added
* `bne.b .c_06618` â€“ added
* `cmpi.w #$5,Travel_mode` â€“ added
* `bpl.b .c_06618` â€“ added
* `st.b D_1e1fc` â€“ added

### Every_year

* removed "clr.w Active_member"
* `bsr.w T_006fe` â€“ was "jsr Exit_display"
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
* `move.b #$20,(a2)+` â€“ was "move.b #" ",(a2)+"

### Prepare_scrolling

* `exg.l d6,d4` â€“ was ".Loop: exg.l d4,d6"
* `exg.l d6,d4` â€“ was "exg.l d4,d6"
* `exg.l a1,a0` â€“ was "exg.l a0,a1"
* `exg.l a1,a0` â€“ was "exg.l a0,a1"

### Refresh_text_window

* `cmp.w $6(a5),d3` â€“ added
* `bmi.b .c_0741a` â€“ added
* `bsr.w Erase_text_window` â€“ added
* `bra.w .Exit` â€“ added

### Prepare_text_block

* `move.l #$bb8,d0` â€“ was "move.l #Max_textblock_size,d0"
* `exg.l a3,a1` â€“ was "exg.l a1,a3"
* `bsr.w .Carriage_return` â€“ added
* `lea.l Line_buffer,a2` â€“ added
* removed "jsr .Carriage_return"
* `cmpi.b #$20,-$1(a2)` â€“ was "cmpi.b #" ",-1(a2)"
* `move.b #$20,(a2)+` â€“ was "move.b #" ",(a2)+"
* `cmpi.b #$20,-(a2)` â€“ was ".Seek: cmpi.b #" ",-(a2)"
* `cmpi.b #$20,-$1(a2)` â€“ was "cmpi.b #" ",-1(a2)"

### Init_RText

* `move.l #$1f4,d0` â€“ was "move.l #Max_textblock_size,d0"

### Add_encoded_2_RText

* `move.l #$bb8,d0` â€“ was "move.l #Max_textblock_size,d0"
* `exg.l a2,a1` â€“ was "exg.l a1,a2"
* `cmpi.b #$20,-$1(a2)` â€“ was ".Punct: cmpi.b #" ",-1(a2)"
* `move.b #$20,(a2)+` â€“ was "move.b #" ",(a2)+"

## MAIN/WSELW.ASM

20 routines taken, 1 with changes.

### ExitWordSelect

* removed "Wait_4_unclick"

## NUCLEUS/COLOFADE.ASM

4 routines taken, 0 with changes.

## NUCLEUS/DIAGNOST.ASM

5 routines taken, 0 with changes.

## NUCLEUS/GFXROUTS.ASM

2 routines taken, 0 with changes.

## NUCLEUS/HBI.ASM

6 routines taken, 0 with changes.

## NUCLEUS/INTROUTS.ASM

4 routines taken, 0 with changes.

## NUCLEUS/KBDROUTS.ASM

8 routines taken, 0 with changes.

## NUCLEUS/MEMORY.ASM

6 routines taken, 2 with changes.

### Reallocate_memory

* `ori.l #$80000000,d0` â€“ added
* `move.l #$bf00ffff,d1` â€“ was "move.l #$3f00ffff,d1"

### Connect_memory

* `move.l #$80000000,$8(a0)` â€“ was "move.w #$8000,8(a0)"

## NUCLEUS/NUMERIC.ASM

1 routines taken, 0 with changes.

## NUCLEUS/SCREEN.ASM

4 routines taken, 0 with changes.

## NUCLEUS/TEXTPUT.ASM

1 routines taken, 1 with changes.

### IG_Print

* `cmpi.b #$7e,d0` â€“ was ".Skip4: cmpi.b #"~",d0"

