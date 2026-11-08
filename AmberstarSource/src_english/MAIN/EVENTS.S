; MAIN/EVENTS.ASM (original module, merged with the disassembly of the shipped program)

; ---- Event_handler (original source: MAIN/EVENTS.ASM)
Event_handler:
	movem.l	d0/d1/a5,-(sp)
	cmpi.w	#5,Travel_mode
	bpl.s	.Exit
	move.w	Map_Xcoord,d0
	move.w	Map_Ycoord,d1
	bsr.w	Find_event
	beq.s	.Exit
	bsr.w	Handle_event
.Exit:
	movem.l	(sp)+,d0/d1/a5
	rts	
; ---- Find_event (original source: MAIN/EVENTS.ASM)
Find_event:
	movem.l	d0/d1/a0,-(sp)
	movea.l	Map_pointer,a0
	subq.w	#1,d1
	mulu.w	Width_of_map,d1
	add.w	d0,d1
	add.w	Size_of_map,d1
	lea.l	-1(a0,d1.w),a0
	cmpi.b	#2,Current_map_type
	bpl.s	.3D_map
	adda.w	Size_of_map,a0
.3D_map:
	moveq.l	#0,d0
	move.b	(a0),d0
	beq.s	.Exit
	subq.w	#1,d0
	move.w	d0,Event_nr
	movea.l	Mapd_ptr,a5
	mulu.w	#10,d0
	lea.l	Event_data(a5,d0.w),a5
	move.l	a5,Event_data_ptr
	moveq.l	#-1,d0
.Exit:
	movem.l	(sp)+,d0/d1/a0
	rts	
Handle_event:
	movem.l	d0-d7/a0-a6,-(a7)
	move.w	#$0,Draw_Cicon
	moveq	#0,d1
	move.b	$5(a5),d1
	beq.b	T_07bce
	move.w	Map_nr,d6
	subq.w	#$1,d6
	move.w	d6,d7
	lsl.w	#$6,d6
	add.w	d7,d6
	add.w	d1,d6
	moveq	#7,d7
	and.w	d6,d7
	lsr.w	#$3,d6
	lea.l	B_59412,a0
	adda.w	d6,a0
	cmpi.b	#$4,(a5)
	beq.b	T_07bc2
	cmpi.b	#$14,(a5)
	bne.b	T_07bbe
	btst	d7,(a0)
	beq.b	T_07bc2
	bsr.w	Do_extra_event
	bra.b	T_07bf0
T_07bbe:
	btst	d7,(a0)
	bne.b	T_07bf0
T_07bc2:
	move.l	a0,EVENT_ptr
	move.w	d7,EVENT_bit
T_07bce:
	moveq	#0,d1
	move.b	(a5),d1
	cmpi.w	#$18,d1
	bmi.b	T_07be6
	lea.l	D_2eedc,a1
	jsr	DI_Error
	bra.b	T_07bf0
T_07be6:
	add.w	d1,d1
	add.w	d1,d1
	movea.l	T_07bf0+2(pc,d1.w),a0
	jsr	(a0)
T_07bf0:
	movem.l	(a7)+,d0-d7/a0-a6
	rts
	dc.l	Map_exit
	dc.l	Door
	dc.l	T_085aa
	dc.l	T_08a34
	dc.l	T_092d4
	dc.l	T_0935a
	dc.l	T_093f2
	dc.l	Spinner
	dc.l	Damage_field
	dc.l	Anti_magic
	dc.l	Lp_regen
	dc.l	Sp_regen
	dc.l	ETrap
	dc.l	Riddle_mouth
	dc.l	Attr_change
	dc.l	T_09a46
	dc.l	T_09b2c
	dc.l	Places
	dc.l	T_09a8e
	dc.l	Door_exit
	dc.l	Travel_exit
	dc.l	T_09c06
	dc.l	T_0a262
; ---- Save_event (original source: MAIN/EVENTS.ASM)
Save_event:
	tst.b	5(a5)
	beq.s	.No_save
	movem.l	d0/a0,-(sp)
	movea.l	EVENT_ptr,a0
	move.w	EVENT_bit,d0
	bset	d0,(a0)
	movem.l	(sp)+,d0/a0
.No_save:
	rts	
T_07c70:
	movem.l	d0-d1,-(a7)
	mulu.w	B_589d8,d0
	divu.w	#$64,d0
	bra.b	T_07c84
; ---- Probe (original source: MAIN/EVENTS.ASM)
Probe:
	movem.l	d0/d1,-(sp)
	cmpi.w	#6,Travel_mode
	bpl.s	.Exit
	tst.w	d0
	bmi.s	.Exit
	cmpi.w	#100,d0
	bpl.s	.Exit
	move.w	d0,d1
	jsr	Random
	lsr.w	#1,d0
	ext.l	d0
	divu.w	#100,d0
	swap.w	d0
	cmp.w	d0,d1
.Exit:
	movem.l	(sp)+,d0/d1
	rts	
Execute_trap:
	movem.l	d0-d2/a0-a2/a5,-(a7)
	ext.w	d0
	beq.w	T_07d7e
	lea.l	T_07da0,a5
	subq.w	#$1,d0
	lsl.w	#$3,d0
	adda.w	d0,a5
	movea.l	(a5),a1
	tst.w	$4(a5)
	bne.b	T_07d38
	lea.l	Chard_ptrs,a2
	moveq	#1,d1
	moveq	#0,d2
T_07cda:
	tst.l	(a2)
	beq.b	T_07cfe
	movea.l	(a2),a0
	move.w	#$e400,d0
	and.w	$3a(a0),d0
	bne.b	T_07cfe
	move.w	$54(a0),d0
	add.w	$a8(a0),d0
	bsr.w	Probe
	bpl.b	T_07cfe
	addq.w	#$1,d2
	move.w	d1,d0
	jsr	(a1)
T_07cfe:
	addq.l	#$4,a2
	addq.w	#$1,d1
	cmpi.w	#$7,d1
	bmi.b	T_07cda
	tst.w	d2
	bne.b	T_07d54
	movea.l	Textfile_ptr,a1
	move.w	#$1,WText_nr
	move.l	#Code0002Sys,Textfile_ptr
	lea.l	TxtW_Mod,a0
	jsr	Push_Module
	move.l	a1,Textfile_ptr
	bra.b	T_07d7e
T_07d38:
	movea.l	Current_active_char_data,a0
	move.w	$54(a0),d0
	add.w	$a8(a0),d0
	bsr.w	Probe
	bpl.b	T_07d7e
	move.w	Active_member,d0
	jsr	(a1)
T_07d54:
	movea.l	Textfile_ptr,a1
	move.w	$6(a5),WText_nr
	move.l	#Code0003Sys,Textfile_ptr
	lea.l	TxtW_Mod,a0
	jsr	Push_Module
	move.l	a1,Textfile_ptr
T_07d7e:
	movem.l	(a7)+,d0-d2/a0-a2/a5
	cmpi.w	#$6,d0
	bne.b	T_07d9e
	move.l	a0,-(a7)
	movea.l	Current_active_char_data,a0
	btst	#$2,$3a(a0)
	beq.b	T_07d9c
	bsr.w	T_006fe
T_07d9c:
	movea.l	(a7)+,a0
T_07d9e:
	rts
T_07da0:
	dc.l	Damage_trap	; ori.b #$d8, d0
	ori.b	#$7,d0
	dc.l	Poison_needle	; ori.b #$f2, d0
	ori.b	#$8,d1
	dc.l	Poison_gas_cloud	; ori.b #$fa, d0
	ori.b	#$9,d0
	dc.l	Blinding_flash	; ori.b #$2, d0
	ori.b	#$a,d0
	dc.l	Paralyzing_gas_cloud	; ori.b #$a, d0
	ori.b	#$b,d0
	dc.l	Stone_gaze	; ori.b #$12, d0
	ori.b	#$c,d1
	dc.l	Disease	; ori.b #$1a, d0
	ori.b	#$d,d1
; ---- Damage_trap (original source: MAIN/EVENTS.ASM)
Damage_trap:
	movem.l	d1/a0,-(a7)	; CHANGE: was "movem.l d1/a5,-(sp)"
	movea.l	Event_data_ptr,a0
	move.b	3(a0),d1
	ext.w	d1
	bsr.w	Do_damage
	movem.l	(sp)+,d1/a0
	rts	
; ---- Poison_needle (original source: MAIN/EVENTS.ASM)
Poison_needle:
	bset	#1,Body_conditions(a0)
	rts	
; ---- Poison_gas_cloud (original source: MAIN/EVENTS.ASM)
Poison_gas_cloud:
	bset	#1,Body_conditions(a0)
	rts	
; ---- Blinding_flash (original source: MAIN/EVENTS.ASM)
Blinding_flash:
	bset	#4,Mind_conditions(a0)
	rts	
; ---- Paralyzing_gas_cloud (original source: MAIN/EVENTS.ASM)
Paralyzing_gas_cloud:
	bset	#0,Body_conditions(a0)
	rts	
; ---- Stone_gaze (original source: MAIN/EVENTS.ASM)
Stone_gaze:
	bset	#2,Body_conditions(a0)
	rts	
; ---- Disease (original source: MAIN/EVENTS.ASM)
Disease:
	bset	#3,Body_conditions(a0)
	rts	
Do_damage:
	movem.l	d2/a0,-(a7)
	lea.l	Codetxt_ptr,a0
	move.w	d0,d2
	add.w	d2,d2
	add.w	d2,d2
	adda.w	d2,a0
	tst.l	(a0)
	beq.b	T_07e82
	movea.l	(a0),a0
	move.w	$86(a0),d2
	sub.w	d1,d2
	bgt.b	T_07e64
	ori.w	#$2000,$3a(a0)
	cmp.w	Active_member,d0
	bne.b	T_07e62
	clr.w	$86(a0)
	tst.b	Battling
	bne.b	T_07e62
	bsr.w	T_006fe
	bra.b	T_07e82
T_07e62:
	moveq	#0,d2
T_07e64:
	move.w	d2,$86(a0)
	move.w	d0,d2
	add.w	d2,d2
	lea.l	Char_damage,a0
	move.w	d1,-$2(a0,d2.w)
	lea.l	B_58ec0,a0
	move.b	#$a,-$1(a0,d0.w)
T_07e82:
	movem.l	(a7)+,d2/a0
	rts
; ---- Event_text (original source: MAIN/EVENTS.ASM)
Event_text:
	cmpi.b	#26,d0
	bpl.s	.Exit
	ext.w	d0
	move.w	d0,WText_nr
	move.l	Maptext_ptr,Textfile_ptr
; CHANGE: removed "move.l (sp)+,.Filth+2"
	lea.l	TxtW_Mod,a0
; CHANGE: removed "move.l #.Dirty,Return_ptr(a0)"
	jsr	Push_Module
.c_07eac:
	move.w	#$0,Draw_Cicon	; CHANGE: was "bra.s .Exit"
.Dirty:
	jsr	Input_handler	; CHANGE: was ".Dirty: clr.l TxtW_Mod+Return_ptr"
	movea.l	Module_sp,a0	; CHANGE: was "movea.l Event_data_ptr,a5"
.Filth:
	move.l	(a0),d0	; CHANGE: was ".Filth: jsr $deadface"
	beq.b	.c_07ec8	; CHANGE: added
	movea.l	d0,a0	; CHANGE: added
	jsr	(a0)	; CHANGE: added
.c_07ec8:
	jsr	Switch_screen	; CHANGE: added
	tst.b	B_592de	; CHANGE: added
	beq.b	.c_07eac	; CHANGE: added
.Exit:
	rts	
; ---- Map_exit (original source: MAIN/EVENTS.ASM)
Map_exit:
	bsr.w	Exit_map
	moveq.l	#0,d0
	move.b	1(a5),d0
	move.w	d0,Map_Xcoord
	move.b	2(a5),d0
	move.w	d0,Map_Ycoord
	move.b	3(a5),d0
	move.w	d0,View_direction
	move.w	6(a5),Map_nr
	bsr.w	Init_map
	rts	
; ---- Travel_exit (original source: MAIN/EVENTS.ASM)
Travel_exit:
	bsr.w	Exit_map
	moveq.l	#0,d0
	move.b	1(a5),d0
	move.w	d0,Map_Xcoord
	move.b	2(a5),d0
	move.w	d0,Map_Ycoord
	move.b	3(a5),d0
	move.w	d0,View_direction
	move.w	6(a5),Map_nr
	moveq.l	#0,d0
	bsr.w	Set_new_travel_mode
	bsr.w	Init_map
	rts	
; ---- Door (original source: MAIN/EVENTS.ASM)
Door:
	move.w	Special_item_flags,d0
	btst	#1,d0
	beq.s	.No_Amber
	tst.b	Doorexit_flag
	beq.s	.No_doorexit
	bsr.w	Do_extra_event
	sf	Doorexit_flag
.No_doorexit:
	rts	
.No_Amber:
	jsr	Exit_display
	sf	Door_opened
	sf	Trap_found
	sf	Trap_disarmed
	lea.l	Door_Mod,a0
	jsr	Push_Module
	jsr	Init_display
	rts	
; ---- Door_DisUpd (original source: MAIN/EVENTS.ASM)
Door_DisUpd:
	bsr.w	Update_status_block
	lea.l	Door_CIL,a0
	lea.l	DoorCIL_evaluate,a1
	bsr.w	Update_control_icons
	tst.b	Door_opened
	beq.s	.Exit
	jsr	Exit_display
	jsr	Pop_Module
	tst.b	Doorexit_flag
	beq.s	.No_doorexit
	bsr.w	Do_extra_event
	sf	Doorexit_flag
	bra.s	.Exit
.No_doorexit:
	jsr	Init_display
.Exit:
	rts	
Door_ModInit:
	bsr.w	T_0025a
	moveq	#13,d0
	lea.l	D_260c0,a0
	bsr.w	Load_80x80_picture
	bsr.w	T_00208
	rts
; ---- Door_ModExit (original source: MAIN/EVENTS.ASM)
Door_ModExit:
	movea.l	Pic80_ptr,a0
	jsr	Free_memory
	rts	
; ---- Door_DisInit (original source: MAIN/EVENTS.ASM)
Door_DisInit:
	move.l	#Lay3_PlusMes,PlusMes_info
	move.l	#Code0002Sys,Textfile_ptr
	movea.l	Off_screen,a6
	moveq.l	#3,d0
	bsr.w	Show_layout
	bsr.w	Display_80x80_picture
	lea.l	Door_CIL,a0
	bsr.w	DoorCIL_evaluate
	move.l	a0,Control_list_ptr
	bsr.w	Show_control_icons
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	Lay3_L2,a0
	bsr.w	Set_layout_data
	lea.l	Lay3_target_hbl,a1
	lea.l	Subfade1,a2
.Again:
	lea.l	Hbl_Lay3_list,a0
	jsr	Update_HBL
	jsr	My_vsync
	jsr	My_vsync
	lea.l	Lay3_below,a0
	jsr	Hbl_fade
	bne.s	.Again
	lea.l	Hbl_Lay3_list,a0
	jsr	Update_HBL
	rts	
T_08084:
	bsr.w	T_01f98
	jsr	Exit_display
	jsr	Pop_Module
	jmp	Init_display
T_0809a:
	btst	#$1,Mouse_button_state
	bne.b	T_0809a
	move.w	#$0,Draw_Cicon
	jsr	My_vsync
	movea.l	Current_active_char_data,a0
	movea.l	Event_data_ptr,a5
	cmpi.b	#$64,$1(a5)
	beq.b	T_080f6
	moveq	#0,d0
	move.b	$c(a0),d0
	add.w	$bc(a0),d0
	move.b	$1(a5),d1
	ext.w	d1
	sub.w	d1,d0
	bsr.w	Probe
	bpl.b	T_08128
	addi.w	#$a,d1
	cmpi.w	#$64,d1
	bmi.b	T_080ea
	moveq	#99,d1
T_080ea:
	move.b	d1,$1(a5)
	tst.b	Trap_disarmed
	beq.b	T_08100
T_080f6:
	move.w	#$19,d0
	bsr.w	Plus_message
	bra.b	T_0813a
T_08100:
	move.b	$2(a5),d0
	beq.b	T_080f6
	move.w	$4c(a0),d0
	add.w	$a0(a0),d0
	bsr.w	Probe
	bpl.b	T_0811e
	move.b	$2(a5),d0
	bsr.w	Execute_trap
	bra.b	T_0813a
T_0811e:
	move.w	#$1,d0
	bsr.w	Plus_message
	bra.b	T_0813a
T_08128:
	bsr.w	Save_event
	st.b	Door_opened
	move.w	#$0,d0
	bsr.w	Plus_message
T_0813a:
	rts
T_0813c:
	btst	#$1,Mouse_button_state
	bne.b	T_0813c
	lea.l	UseItemDoor_Mod,a0
	jmp	Push_Module
; ---- UseItemDoor_DisUpd (original source: MAIN/EVENTS.ASM)
UseItemDoor_DisUpd:
	jsr	Update_quantity_colours
	rts	
; ---- UseItemDoor_DisInit (original source: MAIN/EVENTS.ASM)
UseItemDoor_DisInit:
	movea.l	Current_active_char_data,a0
	lea.l	Inventory_1_place_counter(a0),a1
	lea.l	Inv_data+360(a0),a0
	move.l	a0,Itemdata_ptr
	move.l	a1,Itemslots_ptr
	movea.l	Off_screen,a6
	bsr.w	Show_objects_LAY3
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	L3_objects_area,a0
	jsr	Push_MA
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	rts	
; ---- UseItemDoor_DisExit (original source: MAIN/EVENTS.ASM)
UseItemDoor_DisExit:
	jsr	Pop_MA
	movea.l	Off_screen,a6
	lea.l	Layout_icn+9856,a0
	lea.l	Door_object_pos_list,a1
	moveq.l	#12-1,d7
.Loop:
	move.w	(a1)+,d0
	move.w	(a1)+,d1
	jsr	Put_unmasked_block
	dbra	d7,.Loop
	move.w	#112,d0
	move.w	#73,d1
	move.w	#112+192-1,d2
	move.w	#73+6,d3
	move.w	#2,d6
	movea.l	Off_screen,a6
	jsr	Draw_box
	jsr	Switch_screen
	jsr	Copy_screen
	rts	
; ---- UseItemDoor_objselect (original source: MAIN/EVENTS.ASM)
UseItemDoor_objselect:
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	tst.b	d0
	beq.w	.Exit
	move.b	d0,Object_slot_number
	movea.l	Current_active_char_data,a0
	lea.l	Inventory_1_place_counter-1(a0),a1
	lea.l	Inv_data+320(a0),a2
	ext.w	d0
	adda.w	d0,a1
	mulu.w	#40,d0
	adda.w	d0,a2
	movea.l	Event_data_ptr,a5
	tst.b	(a1)	; CHANGE: added
	beq.w	.Exit	; CHANGE: added
	move.w	Item_ID(a2),d1
	cmp.w	6(a5),d1
	bne.s	.Wrong
	btst	#3,Item_stat_bits(a2)
	beq.s	.Use_more
	tst.b	5(a5)
	beq.s	.Use_more
	subq.b	#1,(a1)
	moveq.l	#0,d0
	move.w	Weight(a2),d0
	sub.l	d0,Weight_normal(a0)
	lea.l	Door_object_pos_list-4,a3
	move.b	Object_slot_number,d0
	ext.w	d0
	add.w	d0,d0
	add.w	d0,d0
	move.w	2(a3,d0.w),d1
	move.w	0(a3,d0.w),d0
	moveq.l	#0,d2
	move.b	(a2),d2
	move.b	Object_slot_number,d3
	ext.w	d3
	lea.l	Erase_icon+9,a3
	move.b	-1(a3,d3.w),d3
	ext.w	d3
	bsr.w	Show_item_destruction
.Use_more:
	bsr.w	Save_event
	st	Door_opened
	move.w	#2,d0
	bsr.w	Plus_message
	jsr	Pop_Module
	bra.s	.Exit
.Wrong:
	cmpi.b	#7,Spell_class(a2)
	bne.s	.Exit
	cmpi.b	#18,Spell_number(a2)
	bne.s	.Exit
	subq.b	#1,(a1)
	moveq.l	#0,d0
	move.w	Weight(a2),d0
	sub.l	d0,Weight_normal(a0)
	cmpi.b	#100,1(a5)
	bmi.s	.Magic_works
	moveq.l	#7,d0
	bra.s	.Skip
.Magic_works:
	moveq.l	#6,d0
	st	Door_opened
	bsr.w	Save_event
.Skip:
	bsr.w	Plus_message
	jsr	Pop_Module
.Exit:
	rts	
; ---- Find_trap_DOOR (original source: MAIN/EVENTS.ASM)
Find_trap_DOOR:
	btst	#1,Mouse_button_state
	bne.s	*-8
	move.w	#$0,Draw_Cicon	; CHANGE: was "Wait_4_unclick"
	jsr	My_vsync	; CHANGE: added
	movea.l	Event_data_ptr,a0
	tst.b	2(a0)
	beq.s	.No_find
	movea.l	Current_active_char_data,a0
	moveq.l	#0,d0
	move.b	Skill_5(a0),d0
	add.w	Skill_5_normal_magic(a0),d0
	bsr.w	Probe
	bpl.s	.Found_it
.No_find:
	moveq.l	#4,d0
	bra.s	.Go_on
.Found_it:
	moveq.l	#3,d0
	st	Trap_found
.Go_on:
	bsr.w	Plus_message
.Exit:
	rts	
T_08332:
	btst	#$1,Mouse_button_state
; ---- Disarm_trap_DOOR (original source: MAIN/EVENTS.ASM)
; CHANGE: removed "Wait_4_unclick"
Disarm_trap_DOOR:
	bne.s	*-8
	move.w	#$0,Draw_Cicon	; CHANGE: was "Wait_4_unclick"
	jsr	My_vsync	; CHANGE: added
	movea.l	Current_active_char_data,a0
	moveq.l	#0,d0
	move.b	Skill_6(a0),d0
	add.w	Skill_6_normal_magic(a0),d0
	bsr.w	Probe
	bpl.s	.Disarmed_it
	move.w	Attr_3_normal(a0),d0
	add.w	Attr_3_normal_magic(a0),d0
	bsr.w	Probe
	bmi.s	.Trapped
	moveq.l	#1,d0
	bra.s	.Go_on
.Trapped:
	movea.l	Event_data_ptr,a0
	move.b	2(a0),d0
	bra.w	Execute_trap
.Disarmed_it:
	moveq.l	#5,d0
	st	Trap_disarmed
.Go_on:
	bsr.w	Plus_message
	rts	
; ---- Show2_object_name (original source: MAIN/EVENTS.ASM)
Show2_object_name:
	tst.b	d0
	beq.s	.Exit
	movea.l	Itemdata_ptr,a0
	movea.l	Itemslots_ptr,a1
	ext.w	d0
	tst.b	-1(a1,d0.w)
	beq.s	.Exit
	mulu.w	#40,d0
	lea.l	-40(a0,d0.w),a0
	cmpi.b	#17,Item_type(a0)
	beq.s	.Exit
	move.w	Name_word_nr(a0),d0
	cmp.w	Object_name_nr,d0
	beq.s	.Exit
	move.w	d0,Object_name_nr
	move.b	#2,Print_objname_flag
.Exit:
	rts	
; ---- Erase2_object_name (original source: MAIN/EVENTS.ASM)
Erase2_object_name:
	tst.b	d0
	beq.s	.Skip
	move.l	#$00ffff00,d1
	and.l	d0,d1
	cmpi.l	#$00020200,d1
	beq.s	.Exit
.Skip:
	move.b	#2,Erase_objname_flag
.Exit:
	rts	
; ---- Upd2_objname_print (original source: MAIN/EVENTS.ASM)
Upd_objname_print:
Upd5_objname_print:
Upd2_objname_print:
	tst.b	Print_objname_flag
	beq.s	.Exit
	lea.l	.Init_string(pc),a0
	jsr	IG_Print
	move.w	Object_name_nr,d0
	beq.s	.Exit
	jsr	Get_word
	move.w	#112,d0
	move.w	#73,d1
	move.w	#112+192-1,d2
	move.w	#73+6,d3
	move.w	#2,d6
	movea.l	Off_screen,a6
	jsr	Draw_box
	move.w	#192,d2
	lea.l	Line_buffer,a0
	bsr.w	Print_centered_string
	subq.b	#1,Print_objname_flag
.Exit:
	rts	
.Init_string:
	dc.b	1,15,2,-1,0
	even	
; ---- Upd_objname_erase (original source: MAIN/INVENT.ASM)
Upd5_objname_erase:
Upd2_objname_erase:
Upd_objname_erase:
	tst.b	Erase_objname_flag
	beq.s	.Exit
	move.w	#$70,d0	; CHANGE: was "move.w #16,d0"
	move.w	#$49,d1	; CHANGE: was "move.w #58,d1"
	move.w	#$12f,d2	; CHANGE: was "move.w #16+176-1,d2"
	move.w	#$4f,d3	; CHANGE: was "move.w #58+7-1,d3"
	move.w	#2,d6
	movea.l	Off_screen,a6
	jsr	Draw_box
	subq.b	#1,Erase_objname_flag
	clr.w	Object_name_nr
.Exit:
	rts	
; ---- DoorCIL_evaluate (original source: MAIN/EVENTS.ASM)
DoorCIL_evaluate:
	movem.l	d0/d7/a2,-(sp)
	movea.l	a0,a2
	moveq.l	#9-1,d7
.Loop1:
	bclr	#7,(a2)+
	dbra	d7,.Loop1
	movea.l	Current_active_char_data,a2
	lea.l	Inventory_1_place_counter(a2),a2
	move.b	(a2)+,d0
	moveq.l	#11-1,d7
.Loop2:
	or.b	(a2)+,d0
	dbra	d7,.Loop2
	tst.b	d0
	bne.s	.Not_empty
	bset	#7,1(a0)
.Not_empty:
	tst.b	Trap_found
	beq.s	.Not_found
	bset	#7,3(a0)
	bra.s	.Continue
.Not_found:
	bset	#7,6(a0)
.Continue:
	tst.b	Trap_disarmed
	beq.s	.Ok
	bset	#7,6(a0)
.Ok:
	movea.l	Current_active_char_data,a1
	btst	#4,Mind_conditions(a1)
	beq.s	.Exit
	bset	#7,3(a0)
	bset	#7,6(a0)
.Exit:
	movem.l	(sp)+,d0/d7/a2
	rts	
; ---- Display2_quantities (original source: MAIN/EVENTS.ASM)
AutoIcon_switch:
Display2_quantities:
	lea.l	Quant_init_string,a0
	jsr	IG_Print
	lea.l	Line_buffer,a0
	movea.l	Itemslots_ptr,a2
	lea.l	Door_object_pos_list,a4
	movea.l	Off_screen,a6
	tst.b	Quant_block
	bne.s	.No_quant
	moveq.l	#0,d0
	moveq.l	#2,d7
	moveq.l	#12-1,d6
.Loop1:
	cmpi.b	#1,(a2)+
	bls.s	.Next1
	move.b	-1(a2),d0
	ext.w	d0
	cmpi.w	#-1,d0
	bne.s	.Finite
	moveq.l	#99,d0
.Finite:
	movea.l	a0,a3
	moveq.l	#" ",d1
	jsr	RConvert_number
	clr.b	(a3)
	moveq.l	#10,d1
	move.w	(a4),d0
	add.w	2(a4),d1
	addq.w	#2,d0
	jsr	IG_Set_cursor
	jsr	IG_Print
.Next1:
	addq.l	#4,a4
	dbra	d6,.Loop1
	rts	
.No_quant:
	movea.l	Itemslots_ptr,a2
	movea.l	Itemdata_ptr,a3
	moveq.l	#12-1,d7
.Loop2:
	cmpi.b	#1,(a2)+
	bls.s	.Next2
	move.w	(a4),d0
	move.w	2(a4),d1
	lea.l	Layout_icn+9856,a0
	jsr	Put_unmasked_block
	lea.l	Objects_icn,a0
	move.b	(a3),d2
	ext.w	d2
	lsl.w	#7,d2
	adda.w	d2,a0
	jsr	Put_masked_block
.Next2:
	lea.l	40(a3),a3
	addq.l	#4,a4
	dbra	d7,.Loop2
	rts	
T_085aa:
	tst.b	Stygian
	beq.b	T_085b8
	bsr.w	Save_event
	bra.b	T_085c8
T_085b8:
	dc.b	$4a,$39
	dc.l	Eye_flag
	dc.b	$67,$0a,$0c,$2d,$00,$01,$00,$03,$66,$1c
T_085c8:
	rts
	tst.b	$3(a5)
	beq.b	T_085c8
	movea.l	Module_sp,a0
	move.l	(a0),d0
	beq.b	T_085e4
	movea.l	d0,a0
	jsr	(a0)
	jsr	Switch_screen
T_085e4:
	moveq	#0,d1
	move.b	$1(a5),d1
	beq.b	T_0860c
	jsr	Exit_display
	moveq	#0,d0
	move.b	$2(a5),d0
	move.w	d0,WText_nr
	lea.l	Pic80_Mod,a0
	jsr	Push_Module
	bra.b	T_0862e
T_0860c:
	dc.b	$70,$00,$10,$2d,$00,$02,$33,$c0
	dc.l	WText_nr
	dc.b	$23,$f9
	dc.l	Maptext_ptr
	dc.l	Textfile_ptr
	dc.b	$41,$f9
	dc.l	TxtW_Mod
	dc.b	$4e,$b9
	dc.l	Push_Module
T_0862e:
	move.w	$6(a5),d0
	beq.b	T_08644
	moveq	#7,d1
	and.w	d0,d1
	lsr.w	#$3,d0
	lea.l	WD,a0
	bset	d1,(a0,d0.w)
T_08644:
	bsr.w	Save_event
	rts
T_0864a:
	jsr	T_0025a
; ---- P80_ModInit (original source: MAIN/EVENTS.ASM)
P80_ModInit:
	lea.l	Pics80_filename,a0
	move.w	d1,d0
	add.w	d1,d0
	jsr	Load_subfile
	move.l	a0,Pic80pal_ptr
	lea.l	Pics80_filename,a0
	subq.w	#1,d0
	jsr	Load_subfile
	move.l	a0,Pic80_ptr
	jsr	T_00208	; CHANGE: added
	bra.w	P80_DisInit
; ---- P80_ModExit (original source: MAIN/EVENTS.ASM)
P80_ModExit:
	movea.l	Pic80pal_ptr,a0
	jsr	Free_memory
	movea.l	Pic80_ptr,a0
	jsr	Free_memory
	bra.w	P80_DisExit
; ---- P80_DisInit (original source: MAIN/EVENTS.ASM)
P80_DisInit:
	lea.l	P80_PA,a0
	bsr.w	Push_PA
	lea.l	P80_area,a0
	jsr	Push_MA
	movea.l	Off_screen,a6
	moveq.l	#7,d0
	bsr.w	Show_layout
	moveq.l	#16,d0
	moveq.l	#49+32,d1
	moveq.l	#5,d6
	moveq.l	#80,d7
	movea.l	Pic80_ptr,a0
	jsr	Blot_unmasked_block
	jsr	Switch_screen
	jsr	Copy_screen
	movea.l	Pic80pal_ptr,a1
	lea.l	Subfade1,a2
.Again:
	lea.l	Hbl_pic80_list,a0
	jsr	Update_HBL
	jsr	My_vsync
	jsr	My_vsync
	jsr	My_vsync
	lea.l	Pic80_below,a0
	jsr	Fade_pal
	bne.s	.Again
	lea.l	Hbl_pic80_list,a0
	jsr	Update_HBL
	movea.l	Maptext_ptr,a1
	move.w	WText_nr,d0
	bsr.w	Mr_Blue_Sky
	jsr	Pop_Module
	jmp	Init_display
; ---- P80_DisExit (original source: MAIN/EVENTS.ASM)
P80_DisExit:
	lea.l	Void,a1
	lea.l	Subfade1,a2
.Again:
	lea.l	Hbl_pic80_list,a0
	jsr	Update_HBL
	jsr	My_vsync
	jsr	My_vsync
	jsr	My_vsync
	lea.l	Pic80_below,a0
	jsr	Fade_pal
	bne.s	.Again
	lea.l	Hbl_pic80_list,a0
	jsr	Update_HBL
	bsr.w	Pop_PA
	jsr	Pop_MA
	rts	
TxtW_ModInit:
	movem.l	d0-d7/a0-a6,-(a7)
	sf.b	B_592de
	lea.l	TxtW_PA,a0
	bsr.w	Push_PA
	move.w	WText_nr,d0
	move.w	Nr_of_chars,d2
	movea.l	Textfile_ptr,a1
	bsr.w	Prepare_text_block
	move.w	Lines_in_text,d0
	mulu.w	#$7,d0
	cmpi.w	#$70,d0
	bhi.w	T_0886c
	moveq	#15,d3
	add.w	d0,d3
	andi.w	#$fff0,d3
	lsr.w	#$4,d3
	cmpi.w	#$2,d3
	bpl.b	T_087e0
	moveq	#2,d3
T_087e0:
	move.w	d3,d4
	lsl.w	#$4,d4
	sub.w	d0,d4
	moveq	#16,d0
	moveq	#52,d1
	moveq	#18,d2
	addq.w	#$2,d3
	moveq	#0,d6
	suba.l	a0,a0
	jsr	Open_window
	move.w	d0,B_58256
	lsr.w	#$1,d4
	add.w	d4,d1
	addi.w	#$10,d1
	move.w	d1,D_25f80
	subq.w	#$2,d3
	lsl.w	#$4,d3
	move.w	d3,D_25f84
	bsr.w	Pop_PA
	lea.l	TxtW_PA,a0
	bsr.w	Push_PA
	movea.l	Text_buffer,a0
	movea.l	Off_screen,a6
	move.w	Nr_of_chars,d0
	move.w	Lines_in_text,d7
	bra.b	T_0884e
T_0883e:
	jsr	IG_Print
	jsr	IG_Carriage_return
	lea.l	$1(a0,d0.w),a0
T_0884e:
	dbra	d7,T_0883e
	jsr	Switch_screen
	jsr	Copy_screen
	movea.l	Text_buffer,a0
	jsr	Free_memory
	bra.b	T_088b4
T_0886c:
	moveq	#16,d0
	moveq	#52,d1
	moveq	#18,d2
	moveq	#9,d3
	moveq	#0,d6
	suba.l	a0,a0
	jsr	Open_window
	move.w	d0,B_58256
	movea.l	Text_buffer,a0
	jsr	Free_memory
	bsr.w	Pop_PA
	lea.l	D_25f8a,a0
	bsr.w	Push_PA
	movea.l	Textfile_ptr,a1
	move.w	WText_nr,d0
	bsr.w	Mr_Blue_Sky
	jsr	Pop_Module
T_088b4:
	movem.l	(a7)+,d0-d7/a0-a6
	rts
TxtW_ModExit:
	movem.l	d0/a0,-(a7)
	st.b	B_592de
	move.w	B_58256,d0
	jsr	Close_window
	bsr.w	Pop_PA
T_088d4:
	btst	#$1,Mouse_button_state
	bne.b	T_088d4
	movem.l	(a7)+,d0/a0
	rts
T_088e4:
	movem.l	d0-d7/a0-a6,-(a7)
	sf.b	B_592de
	lea.l	TxtW_PA,a0
	bsr.w	Push_PA
	move.w	WText_nr,d0
	move.w	Nr_of_chars,d2
	movea.l	Textfile_ptr,a1
	bsr.w	Prepare_text_block
	move.w	Lines_in_text,d0
	mulu.w	#$7,d0
	cmpi.w	#$70,d0
	bhi.w	T_089be
	moveq	#15,d3
	add.w	d0,d3
	andi.w	#$fff0,d3
	lsr.w	#$4,d3
	cmpi.w	#$2,d3
	bpl.b	T_08932
	moveq	#2,d3
T_08932:
	move.w	d3,d4
	lsl.w	#$4,d4
	sub.w	d0,d4
	moveq	#16,d0
	moveq	#52,d1
	moveq	#18,d2
	addq.w	#$2,d3
	moveq	#0,d6
	suba.l	a0,a0
	jsr	Open_window
	move.w	d0,B_58258
	lsr.w	#$1,d4
	add.w	d4,d1
	addi.w	#$10,d1
	move.w	d1,D_25f80
	subq.w	#$2,d3
	lsl.w	#$4,d3
	move.w	d3,D_25f84
	bsr.w	Pop_PA
	lea.l	TxtW_PA,a0
	bsr.w	Push_PA
	movea.l	Text_buffer,a0
	movea.l	Off_screen,a6
	move.w	Nr_of_chars,d0
	move.w	Lines_in_text,d7
	bra.b	T_089a0
T_08990:
	jsr	IG_Print
	jsr	IG_Carriage_return
	lea.l	$1(a0,d0.w),a0
T_089a0:
	dbra	d7,T_08990
	jsr	Switch_screen
	jsr	Copy_screen
	movea.l	Text_buffer,a0
	jsr	Free_memory
	bra.b	T_08a04
T_089be:
	moveq	#16,d0
	moveq	#52,d1
	moveq	#18,d2
	moveq	#9,d3
	moveq	#0,d6
	suba.l	a0,a0
	jsr	Open_window
	move.w	d0,B_58256
	movea.l	Text_buffer,a0
	jsr	Free_memory
	bsr.w	Pop_PA
	lea.l	D_25f8a,a0
	bsr.w	Push_PA
	movea.l	Textfile_ptr,a1
	move.w	WText_nr,d0
	bsr.w	Mr_Blue_Sky
	bsr.w	Pop_Module
T_08a04:
	movem.l	(a7)+,d0-d7/a0-a6
	rts
T_08a0a:
	movem.l	d0/a0,-(a7)
	st.b	B_592de
	move.w	B_58258,d0
	jsr	Close_window
	bsr.w	Pop_PA
T_08a24:
	btst	#$1,Mouse_button_state
	bne.b	T_08a24
	movem.l	(a7)+,d0/a0
	rts
T_08a34:
	tst.b	$4(a5)
	beq.b	T_08a58
	tst.b	B_57c61
	bne.b	T_08a58
	movea.l	Current_active_char_data,a0
	moveq	#0,d0
	move.b	$d(a0),d0
	add.w	$be(a0),d0
	bsr.w	Probe
	bmi.b	T_08ab8
T_08a58:
	movea.l	EVENT_ptr,a0
	move.w	EVENT_bit,d0
	btst	d0,(a0)
	bne.b	T_08a9c
	tst.b	$1(a5)
	beq.b	T_08a9c
	move.w	Special_item_flags,d0
	btst	#$1,d0
	bne.b	T_08a9c
	bsr.w	Exit_display
	sf.b	Door_opened
	sf.b	Trap_found
	sf.b	Trap_disarmed
	lea.l	ClosedChest_Mod,a0
	bsr.w	Push_Module
	bra.b	T_08ab8
T_08a9c:
	dc.b	$61,$00,$00,$2c,$66,$08,$4a,$79
	dc.l	Current_chest_gold
	dc.b	$67,$0e,$61,$00,$7e,$62,$41,$f9
	dc.l	OpenedChest_Mod
	dc.b	$61,$00,$7e,$ba
T_08ab8:
	rts
T_08aba:
	bsr.w	T_01f98
	bsr.w	Exit_display
	bsr.w	Pop_Module
	bra.w	Init_display
; ---- Init_chest (original source: MAIN/EVENTS.ASM)
Init_chest:
	movem.l	d0-d2/d7/a0,-(sp)
	move.w	6(a5),d7
	lea.l	Chest_gold,a0
	move.w	d7,d0
	add.w	d0,d0
	move.w	0(a0,d0.w),Current_chest_gold
	lea.l	Chest,a0
	moveq	#0,d2	; CHANGE: added
	subq.w	#1,d7
	move.w	d7,d0
	lsr.w	#1,d0
	move.w	d0,d1
	add.w	d0,d0
	add.w	d1,d0
	btst	#0,d7
	bne.s	.Odd
	move.b	1(a0,d0.w),d2
	lsl.w	#8,d2
	move.b	0(a0,d0.w),d2
	lsr.w	#1,d2
	bra.s	.Continue
.Odd:
	move.b	2(a0,d0.w),d2
	lsl.w	#8,d2
	move.b	1(a0,d0.w),d2
	lsr.w	#5,d2
	moveq.l	#1,d1
	and.b	3(a0,d0.w),d1
	ror.w	#5,d1
	or.w	d1,d2
.Continue:
	andi.w	#$0fff,d2
	move.w	d2,Current_chest_slots
	movem.l	(sp)+,d0-d2/d7/a0
	rts	
ClosedChest_ModInit:
	jsr	T_0025a
	moveq	#12,d0
	lea.l	D_260c0,a0
	bsr.w	Load_80x80_picture
	jsr	T_00208
	bra.w	Init_display
; ---- ClosedChest_ModExit (original source: MAIN/EVENTS.ASM)
ClosedChest_ModExit:
	movea.l	Pic80_ptr,a0
	jmp	Free_memory
; ---- ClosedChest_DisInit (original source: MAIN/EVENTS.ASM)
ClosedChest_DisInit:
	move.l	#Lay3_PlusMes,PlusMes_info
	move.l	#Code0002Sys,Textfile_ptr
	movea.l	Off_screen,a6
	moveq.l	#3,d0
	bsr.w	Show_layout
	bsr.w	Display_80x80_picture
	lea.l	ClosedChest_CIL,a0
	bsr.w	ClosedChestCIL_evaluate
	move.l	a0,Control_list_ptr
	bsr.w	Show_control_icons
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	Lay3_L2,a0
	jsr	Set_layout_data
	bra.w	Fadein_lay3
; ---- ClosedChest_DisUpd (original source: MAIN/EVENTS.ASM)
ClosedChest_DisUpd:
	bsr.w	Update_status_block
	lea.l	ClosedChest_CIL,a0
	lea.l	ClosedChestCIL_evaluate,a1
	bsr.w	Update_control_icons
	jsr	Update_quantity_colours
	tst.b	Door_opened
	beq.s	.Exit
	st	Fade_block
	bsr.w	Pop_Module
	movea.l	Event_data_ptr,a5
	bsr.w	Init_chest
	lea.l	OpenedChest_Mod,a0
	bsr.w	Push_Module
	sf	Fade_block
.Exit:
	rts	
; ---- Use_item_CHEST (original source: MAIN/EVENTS.ASM)
Use_item_CHEST:
	lea.l	UseItemChest_Mod,a0
	bra.w	Push_Module
; ---- UseItemChest_objselect (original source: MAIN/EVENTS.ASM)
UseItemChest_objselect:
	tst.b	d0
	beq.s	.Exit
	movea.l	Current_active_char_data,a0
	lea.l	Inventory_1_place_counter-1(a0),a1
	lea.l	Inv_data+320(a0),a2
	ext.w	d0
	adda.w	d0,a1
	moveq.l	#40,d1
	mulu.w	d0,d1
	adda.w	d1,a2
	movea.l	Event_data_ptr,a5
	cmpi.b	#7,Spell_class(a2)
	bne.s	.Exit
	cmpi.b	#18,Spell_number(a2)
	bne.s	.Exit
	subq.b	#1,(a1)
	cmpi.b	#100,1(a5)
	bmi.s	.Magic_works
	moveq.l	#7,d0
	bra.s	.Skip
.Magic_works:
	moveq.l	#6,d0
	st	Door_opened
	bsr.w	Save_event
.Skip:
	bsr.w	Plus_message
	bsr.w	Pop_Module
.Exit:
	rts	
; ---- ClosedChestCIL_evaluate (original source: MAIN/EVENTS.ASM)
ClosedChestCIL_evaluate:
	movem.l	d0/d7/a1,-(sp)
	bclr	#7,(a0)
	bclr	#7,1(a0)
	bclr	#7,3(a0)
	bclr	#7,6(a0)
	movea.l	Current_active_char_data,a1
	lea.l	Inventory_1_place_counter(a1),a1
	move.b	(a1)+,d0
	moveq.l	#11-1,d7
.Loop:
	or.b	(a1)+,d0
	dbra	d7,.Loop
	tst.b	d0
	bne.s	.Not_empty
	bset	#7,1(a0)
.Not_empty:
	tst.b	Trap_found
	beq.s	.Not_found
	bset	#7,3(a0)
	bra.s	.Continue
.Not_found:
	bset	#7,6(a0)
.Continue:
	tst.b	Trap_disarmed
	beq.s	.Ok
	bset	#7,6(a0)
.Ok:
	movea.l	Current_active_char_data,a1
	btst	#4,Mind_conditions(a1)
	beq.s	.Exit
	bset	#7,3(a0)
	bset	#7,6(a0)
.Exit:
	movem.l	(sp)+,d0/d7/a1
	rts	
T_08cd2:
	tst.b	Fade_block
	bne.b	OpenedChest_ModInit
	jsr	T_0025a
OpenedChest_ModInit:
	moveq	#21,d0
	lea.l	D_260c0,a0
	bsr.w	Load_80x80_picture
	movea.l	Event_data_ptr,a0
	move.w	$6(a0),d0
	lea.l	D_2f219,a0
	jsr	Load_subfile
	move.l	a0,Chestdata_ptr
	lea.l	Divide_gold_workspace,a1
	move.w	Current_chest_slots,d0
	moveq	#11,d7
T_08d16:
	btst	d7,d0
	sne.b	-(a1)
	dbra	d7,T_08d16
	tst.b	Fade_block
	bne.b	T_08d2c
	jsr	T_00208
T_08d2c:
	bsr.w	OpenedChest_DisInit
	movea.l	Event_data_ptr,a0
	move.w	$8(a0),d0
	cmpi.b	#$1a,d0
	bpl.b	T_08d50
	ext.w	d0
	move.l	Maptext_ptr,Textfile_ptr
	bsr.w	Plus_message
T_08d50:
	rts
; ---- OpenedChest_ModExit (original source: MAIN/EVENTS.ASM)
OpenedChest_ModExit:
	lea.l	Chest_slot_list+12,a0
	moveq.l	#0,d2
	moveq.l	#12-1,d7
.Loop:
	tst.b	-(a0)
	beq.s	.Next
	bset	d7,d2
.Next:
	dbra	d7,.Loop
	movea.l	Event_data_ptr,a0
	move.w	6(a0),d7
	lea.l	Chest_gold,a0
	move.w	d7,d0
	add.w	d0,d0
	move.w	Current_chest_gold,0(a0,d0.w)
	lea.l	Chest,a0
	subq.w	#1,d7
	move.w	d7,d0
	lsr.w	#1,d0
	move.w	d0,d1
	add.w	d0,d0
	add.w	d1,d0
	btst	#0,d7
	bne.s	.Odd
	andi.b	#$01,0(a0,d0.w)
	andi.b	#$e0,1(a0,d0.w)
	lsl.w	#1,d2
	or.b	d2,0(a0,d0.w)
	lsr.w	#8,d2
	or.b	d2,1(a0,d0.w)
	bra.s	.Continue
.Odd:
	andi.b	#$1f,1(a0,d0.w)
	andi.b	#$fe,3(a0,d0.w)
	move.w	#$0800,d1
	and.w	d2,d1
	rol.w	#5,d1
	or.b	d1,3(a0,d0.w)
	lsl.w	#5,d2
	or.b	d2,1(a0,d0.w)
	lsr.w	#8,d2
	move.b	d2,2(a0,d0.w)
.Continue:
	movea.l	Pic80_ptr,a0
	jsr	Free_memory
	movea.l	Chestdata_ptr,a0
	jmp	Free_memory
; ---- OpenedChest_DisInit (original source: MAIN/EVENTS.ASM)
OpenedChest_DisInit:
	move.l	#Lay3_PlusMes,PlusMes_info
; CHANGE: removed "Push PA,Lay3_PA"
; CHANGE: removed "Push PA,Lay3_PA"
	movea.l	Off_screen,a6
	moveq.l	#3,d0
	bsr.w	Show_layout
	move.l	Chestdata_ptr,Itemdata_ptr
	move.l	#Chest_slot_list,Itemslots_ptr
	bsr.w	Show_objects_LAY3
	tst.w	Current_chest_gold
	sne	Gold_in_chest_flag
	beq.s	.No_gold
	moveq.l	#15,d0
	jsr	IG_Set_ink
	moveq.l	#2,d0
	jsr	IG_Set_paper
	move.w	#112,d0
	move.w	#113,d1
	move.w	#64,d2
	lea.l	Gold_txt,a0
	bsr.w	Print_centered_string
.No_gold:
	bsr.w	Display_80x80_picture
	lea.l	OpenedChest_CIL,a0
	bsr.w	OpenedChestCIL_evaluate
	move.l	a0,Control_list_ptr
	bsr.w	Show_control_icons
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	Lay3_L2,a0
	jsr	Set_layout_data
	bsr.w	Fadein_lay3
	rts	
; ---- OpenedChest_DisUpd (original source: MAIN/EVENTS.ASM)
OpenedChest_DisUpd:
	bsr.w	Update_status_block
	lea.l	OpenedChest_CIL,a0
	lea.l	OpenedChestCIL_evaluate,a1
	bsr.w	Update_control_icons
	tst.b	Gold_in_chest_flag
	beq.s	.No_gold
	moveq.l	#15,d0
	jsr	IG_Set_ink
	moveq.l	#2,d0
	jsr	IG_Set_paper
	move.w	Current_chest_gold,d0
	moveq.l	#"0",d1
	moveq.l	#5,d7
	lea.l	GoldDis_text,a0
	movea.l	a0,a3
	jsr	RConvert_number
	move.w	#112,d0
	move.w	#113+8,d1
	move.w	#64,d2
	movea.l	Off_screen,a6
	bsr.w	Print_centered_string
.No_gold:
	rts	
OpenedChestCIL_evaluate:
	bclr	#$7,$4(a0)
	bclr	#$7,$5(a0)
	bclr	#$7,$7(a0)
	bclr	#$7,$8(a0)
	tst.w	Current_chest_gold
	bne.b	T_08f10
	bset	#$7,$7(a0)
	bset	#$7,$8(a0)
T_08f10:
	lea.l	Chest_slot_list,a1
	move.l	(a1)+,d0
	or.l	(a1)+,d0
	or.l	(a1)+,d0
	bne.b	T_08f2a
	bset	#$7,$4(a0)
	bset	#$7,$5(a0)
T_08f2a:
	rts
T_08f2c:
	btst	#$1,Mouse_button_state
	bne.b	T_08f2c
	lea.l	D_2ccb0,a0
	bra.w	Push_Module
T_08f40:
	move.w	#$70,Mesmin_X
	move.w	#$42,Mesmin_Y
	move.w	#$c0,Mesmin_Wd
	move.l	#Code0001Sys,Textfile_ptr
	lea.l	Lay3_L2,a0
	jsr	Push_MA
	movea.l	Off_screen,a6
	move.w	#$3,d0
	bsr.w	Minus_message
	jsr	Switch_screen
	jsr	Copy_screen
	rts
T_08f8a:
	btst	#$1,Mouse_button_state
	bne.b	T_08f8a
	lea.l	TIChest_Mod,a0
	bra.w	Push_Module
T_08f9e:
	move.w	#$70,Mesmin_X
	move.w	#$42,Mesmin_Y
	move.w	#$c0,Mesmin_Wd
	move.l	#Code0001Sys,Textfile_ptr
	lea.l	Lay3_L2,a0
	jsr	Push_MA
	movea.l	Off_screen,a6
	move.w	#$4,d0
	bsr.w	Minus_message
	jsr	Switch_screen
	jsr	Copy_screen
	rts
Do_TIChest:
	tst.b	d0
	bne.b	T_08ff0
T_08fec:
	bra.w	Pop_Module
T_08ff0:
	ext.w	d0
	lea.l	B_58227,a1
	adda.w	d0,a1
	tst.b	(a1)
	beq.b	T_08fec
	movea.l	Chestdata_ptr,a2
	moveq	#40,d1
	mulu.w	d0,d1
	lea.l	-$28(a2,d1.w),a2
	move.b	d0,Object_slot_number
	moveq	#0,d0
	move.w	$22(a2),d0
	btst	#$2,$18(a2)
	beq.b	T_09026
	move.w	$24(a2),d1
	bra.b	T_09028
T_09026:
	moveq	#-1,d1
T_09028:
	suba.l	a0,a0
	jsr	Scan_4_transfer_victims
	bne.b	T_09040
	move.w	#$5,d0
	bsr.w	Plus_message
	bsr.w	Pop_Module
	bra.b	T_09066
T_09040:
	jsr	Show_transfer_victims
	move.b	(a2),TIVS_Icon_nr
	move.l	#T_09068,TIVS_Ptr
	lea.l	TIVS2_Mod,a0
	move.w	#$18,$2c(a0)
	bsr.w	Push_Module
T_09066:
	rts
T_09068:
	lea.l	Chest_slot_list,a2
	movea.l	Chestdata_ptr,a3
	moveq	#0,d0
	move.b	Object_slot_number,d0
	subq.w	#$1,d0
	adda.w	d0,a2
	mulu.w	#$28,d0
	adda.w	d0,a3
	btst	#$2,$18(a3)
	beq.b	T_090b6
	lea.l	$2b(a0),a4
	lea.l	$29a(a0),a5
	move.w	$24(a3),d0
	moveq	#11,d7
T_0909c:
	tst.b	(a4)
	beq.b	T_090ac
	cmp.w	$24(a5),d0
	bne.b	T_090ac
	cmpi.b	#$63,(a4)
	bmi.b	T_090d0
T_090ac:
	addq.l	#$1,a4
	lea.l	$28(a5),a5
	dbra	d7,T_0909c
T_090b6:
	lea.l	$2b(a0),a4
	lea.l	$29a(a0),a5
	moveq	#11,d7
T_090c0:
	tst.b	(a4)
	beq.b	T_090d0
	addq.l	#$1,a4
	lea.l	$28(a5),a5
	dbra	d7,T_090c0
	bra.b	T_09136
T_090d0:
	dc.b	$74,$00,$34,$2b,$00,$22,$d5,$a8,$00,$ec,$52,$14,$7e,$13,$3a,$db
	dc.b	$51,$cf,$ff,$fc,$47,$eb,$ff,$d8,$42,$12,$2c,$79
	dc.l	Off_screen
	dc.b	$41,$f9
	dc.l	D_25fd2
	dc.b	$70,$00,$10,$39
	dc.l	Object_slot_number
	dc.b	$d0,$40,$d0,$40,$d0,$c0,$30,$18,$32,$18,$41,$f9
	dc.l	D_363e0
	dc.b	$4e,$b9
	dc.l	Put_unmasked_block
	dc.b	$4e,$b9
	dc.l	Switch_screen
	dc.b	$4e,$b9
	dc.l	Copy_screen
	dc.b	$41,$f9
	dc.l	Chest_slot_list
	dc.b	$4a,$98,$66,$0c,$4a,$98,$66,$08,$4a,$98,$66,$04,$61,$00,$78,$a0
T_09136:
	rts
T_09138:
	btst	#$1,Mouse_button_state
	bne.b	T_09138
	movem.l	d0/a6,-(a7)
	move.w	#$70,Mesmin_X
	move.w	#$42,Mesmin_Y
	move.w	#$c0,Mesmin_Wd
	move.l	#Code0001Sys,Textfile_ptr
	movea.l	Off_screen,a6
	move.w	#$6,d0
	bsr.w	Minus_message
	jsr	Switch_screen
	jsr	Copy_screen
T_09182:
	btst	#$1,Mouse_button_state
	bne.b	T_09182
	moveq	#0,d0
	move.w	Current_chest_gold,d0
	move.l	d0,Original_number
	clr.l	ItemW_nr
	lea.l	TransGoldCHEST_Mod,a0
	bsr.w	Push_Module
	movem.l	(a7)+,d0/a6
	rts
TransGold_DisInit:
TGCHEST_DisInit:
	movem.l	d0-d7/a0-a6,-(a7)
; ---- TransFood_DisInit (original source: MAIN/INVENT.ASM)
TransFood_DisInit:
	move.w	#First_add,Adding
	moveq.l	#15,d0
	jsr	IG_Set_ink
	moveq.l	#2,d0
	jsr	IG_Set_paper
	jsr	ItemW_DisInit
	movea.l	Off_screen,a6
	move.w	#$60,d0	; CHANGE: was "move.w #Food_icon,d0"
	moveq.l	#0,d1
	bsr.w	INV2_Show_object
	move.w	#49+18,d0
	move.w	#80+18+32,d1
	jsr	IG_Set_cursor
	lea.l	Gold_txt,a0	; CHANGE: was "lea.l Food_txt,a0"
	jsr	IG_Print
	move.w	#32+17,d0
	move.w	#80+38+32,d1
	jsr	IG_Set_cursor
	moveq.l	#14,d0
	lea.l	Code0001Sys,a1
	bsr.w	Convert_text_line
	lea.l	Line_buffer,a0
	jsr	IG_Print
	jsr	Switch_screen
	jsr	Copy_screen
	movem.l	(a7)+,d0-d7/a0-a6	; CHANGE: added
	rts	
; ---- TGPLACES_Return (original source: MAIN/PLACES.ASM)
TGCHEST_Return:
TGPLACES_Return:
	movem.l	d0/d1/a0,-(sp)
	move.l	ItemW_nr,d0
	beq.s	.Exit
	move.w	d0,d1
	mulu.w	#Gold_weight,d0
	suba.l	a0,a0
	jsr	Scan_4_gold_victims
	bne.s	.Go
	move.w	#5,d0
	bsr.w	Plus_message
	bra.s	.Exit
.Go:
	jsr	Show_transfer_victims
	move.l	#Do_TGPLACES,TIVS_Ptr
	lea.l	TIVS2_Mod,a0
	move.w	#25,Mouse_ptr(a0)
	bsr.w	Push_Module
.Exit:
	movem.l	(sp)+,d0/d1/a0
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	rts	
; ---- Do_TGPLACES (original source: MAIN/PLACES.ASM)
Do_TGCHEST:
Do_TGPLACES:
	move.l	d0,-(sp)
	move.l	ItemW_nr,d0
	add.w	d0,Gold_coins(a0)
	sub.w	d0,Current_chest_gold	; CHANGE: was "sub.w d0,Places_gold"
	mulu.w	#Gold_weight,d0
	add.l	d0,Weight_normal(a0)
	move.l	(sp)+,d0
	rts	
; ---- Divide_gold_CHEST (original source: MAIN/EVENTS.ASM)
Divide_gold_CHEST:
	btst	#1,Mouse_button_state
	bne.s	*-8
	move.w	#$0,Draw_Cicon	; CHANGE: was "Wait_4_unclick"
	jsr	My_vsync	; CHANGE: added
	moveq.l	#0,d0
	move.w	Current_chest_gold,d0
	bsr.w	Divide_gold
	move.w	d0,Current_chest_gold
	rts	
T_092d4:
	movea.l	Module_sp,a0
	move.l	(a0),d0
	beq.b	Trap_door
	movea.l	d0,a0
	jsr	(a0)
	jsr	Switch_screen
Trap_door:
	move.b	$4(a5),d0
	bsr.w	Event_text
	tst.b	$3(a5)
	beq.b	T_09358
	lea.l	Chard_ptrs,a0
	moveq	#1,d7
T_092fe:
	tst.l	(a0)
	beq.b	T_09324
	movea.l	(a0),a1
	move.w	#$e400,d2
	and.w	$3a(a1),d2
	bne.b	T_09324
	jsr	Random
	move.w	d0,d1
	mulu.w	$8(a5),d1
	swap	d1
	addq.w	#$1,d1
	move.w	d7,d0
	bsr.w	Do_damage
T_09324:
	addq.l	#$4,a0
	addq.w	#$1,d7
	cmpi.w	#$7,d7
	bmi.b	T_092fe
	bsr.w	Save_event
	bsr.w	Exit_map
	moveq	#0,d0
	move.b	$1(a5),d0
	move.w	d0,Map_Xcoord
	move.b	$2(a5),d0
	move.w	d0,Map_Ycoord
	move.w	$6(a5),Map_nr
	bsr.w	Init_map
T_09358:
	rts
T_0935a:
	move.b	$4(a5),d0
	bsr.w	Event_text
	move.w	$6(a5),d0
	cmp.w	Map_nr,d0
	beq.b	T_093a6
	bsr.w	Exit_map
	moveq	#0,d0
	move.b	$1(a5),d0
	move.w	d0,Map_Xcoord
	move.b	$2(a5),d0
	move.w	d0,Map_Ycoord
	move.b	$3(a5),d0
	cmpi.w	#$4,d0
	beq.b	T_09398
	move.w	d0,View_direction
T_09398:
	move.w	$6(a5),Map_nr
	bsr.w	Init_map
	bra.b	T_093ec
T_093a6:
	dc.b	$70,$00,$10,$2d,$00,$01,$33,$c0
	dc.l	Map_Xcoord
	dc.b	$10,$2d,$00,$02,$33,$c0
	dc.l	Map_Ycoord
	dc.b	$0c,$39,$00,$02
	dc.l	Current_map_type
	dc.b	$6b,$04,$61,$00,$62,$6e,$10,$2d,$00,$03,$0c,$40,$00,$04,$67,$06
	dc.b	$33,$c0
	dc.l	View_direction
	dc.b	$0c,$39,$00,$00
	dc.l	Current_map_type
	dc.b	$66,$04,$61,$00,$b8,$c6,$61,$00,$e7,$0a
T_093ec:
	bsr.w	Save_event
	rts
T_093f2:
	move.w	Special_item_flags,d0
	btst	#$3,d0
	bne.b	T_09400
	rts
T_09400:
	bra.w	T_0935a
; ---- Spinner (original source: MAIN/EVENTS.ASM)
Spinner:
	move.b	4(a5),d0
	bsr.w	Event_text
	move.b	1(a5),d0
	ext.w	d0
	cmpi.w	#4,d0
	bmi.s	.Absolute
.Repeat:
	jsr	Random
	andi.w	#$0003,d0
	cmp.w	View_direction,d0
	beq.s	.Repeat
.Absolute:
	move.w	d0,View_direction
	bsr.w	Save_event
	rts	
; ---- Damage_field (original source: MAIN/EVENTS.ASM)
Damage_field:
	move.b	4(a5),d0
	bsr.w	Event_text
	move.b	2(a5),d2
	lea.l	Chard_ptrs,a0
	moveq.l	#1,d7
.Loop:
	tst.l	(a0)
	beq.s	.Next
	movea.l	(a0),a1
	move.w	#$e000,d3
	and.w	Body_conditions(a1),d3
	bne.s	.Next
	cmpi.b	#2,d2
	beq.s	.Both
	cmp.b	Character_sex(a1),d2
	bne.s	.Next
.Both:
	moveq.l	#0,d1
	move.b	1(a5),d1
	jsr	Random
	mulu.w	d0,d1
	swap.w	d1
	addq.w	#1,d1
	move.w	d7,d0
	bsr.w	Do_damage
.Next:
	addq.l	#4,a0
	addq.w	#1,d7
	cmpi.w	#6+1,d7
	bmi.s	.Loop
	bsr.w	Save_event
	rts	
; ---- Anti_magic (original source: MAIN/EVENTS.ASM)
Anti_magic:
	move.b	4(a5),d0
	bsr.w	Event_text
	move.b	1(a5),d0
	bne.s	.One
	moveq.l	#0,d0
	lea.l	Spell_1_duration,a0
	move.l	d0,(a0)+
	move.l	d0,(a0)+
	move.l	d0,(a0)+
	lea.l	Spell_1_data,a0
	move.l	d0,(a0)+
	move.l	d0,(a0)+
	move.l	d0,(a0)+
	bra.s	.Exit
.One:
	ext.w	d0
	add.w	d0,d0
	lea.l	Spell_1_duration,a0
	clr.w	-2(a0,d0.w)
	lea.l	Spell_1_data,a0
	clr.w	-2(a0,d0.w)
.Exit:
	bsr.w	Save_event
	rts	
; ---- Lp_regen (original source: MAIN/EVENTS.ASM)
Lp_regen:
	move.b	4(a5),d0
	bsr.w	Event_text
	move.b	1(a5),d0
	bne.s	.No
	lea.l	Chard_ptrs,a0
	moveq.l	#6-1,d7
.Loop1:
	tst.l	(a0)
	beq.s	.Next1
	movea.l	(a0),a1
	move.w	#$e000,d1
	and.w	Body_conditions(a1),d1
	bne.s	.Next1
	move.w	Life_points_max(a1),d0
	add.w	Life_points_max_magic(a1),d0
	cmp.w	Life_points_normal(a1),d0
	bmi.s	.Next1
	move.w	d0,Life_points_normal(a1)
.Next1:
	addq.l	#4,a0
	dbra	d7,.Loop1
	bra.s	.Exit
.No:
	lea.l	Chard_ptrs,a0
	ext.w	d0
	moveq.l	#6-1,d7
.Loop2:
	tst.l	(a0)
	beq.s	.Next2
	movea.l	(a0),a1
	move.w	#$e000,d1
	and.w	Body_conditions(a1),d1
	bne.s	.Next2
	move.l	a0,-(sp)
	movea.l	a1,a0
	jsr	Increase_LP
	movea.l	(sp)+,a0
.Next2:
	addq.l	#4,a0
	dbra	d7,.Loop2
.Exit:
	bsr.w	Save_event
	rts	
; ---- Sp_regen (original source: MAIN/EVENTS.ASM)
Sp_regen:
	move.b	4(a5),d0
	bsr.w	Event_text
	move.b	1(a5),d0
	bne.s	.No
	lea.l	Chard_ptrs,a0
	moveq.l	#6-1,d7
.Loop1:
	tst.l	(a0)
	beq.s	.Next1
	movea.l	(a0),a1
	move.w	#$e000,d1
	and.w	Body_conditions(a1),d1
	bne.s	.Next1
	move.w	Power_points_max(a1),d0
	add.w	Power_points_max_magic(a1),d0
	cmp.w	Power_points_normal(a1),d0
	bmi.s	.Next1
	move.w	d0,Power_points_normal(a1)
.Next1:
	addq.l	#4,a0
	dbra	d7,.Loop1
	bra.s	.Exit
.No:
	lea.l	Chard_ptrs,a0
	ext.w	d0
	moveq.l	#6-1,d7
.Loop2:
	tst.l	(a0)
	beq.s	.Next2
	movea.l	(a0),a1
	move.w	#$e000,d1
	and.w	Body_conditions(a1),d1
	bne.s	.Next2
	move.w	Power_points_normal(a1),d1
	move.w	Power_points_max(a1),d2
	add.w	Power_points_max_magic(a1),d2
	cmp.w	d2,d1
	bpl.s	.Next2
	add.w	d0,d1
	cmp.w	d2,d1
	bmi.s	.Ok
	move.w	d2,d1
.Ok:
	move.w	d1,Power_points_normal(a1)
.Next2:
	addq.l	#4,a0
	dbra	d7,.Loop2
.Exit:
	bsr.w	Save_event
	rts	
; ---- Riddle_mouth (original source: MAIN/EVENTS.ASM)
Riddle_mouth:
	bsr.w	Exit_display
	lea.l	RiddleM_Mod,a0
	bsr.w	Push_Module
	bsr.w	Init_display
	rts	
; ---- RiddleM_DisUpd (original source: MAIN/EVENTS.ASM)
RiddleM_DisUpd:
	bsr.w	Update_status_block
	tst.b	Door_opened
	beq.s	.Exit
	movea.l	Event_data_ptr,a5
	bsr.w	Save_event
	bsr.w	Wait_4_user
	bsr.w	Exit_display
	bsr.w	Pop_Module
	bsr.w	Init_display
.Exit:
	rts	
T_09606:
	jsr	T_0025a
RiddleM_ModInit:
	moveq	#17,d0
	lea.l	Palette_buffer,a0
	bsr.w	Load_80x80_picture
	lea.l	D_25fbe,a0
	bsr.w	Push_PA
	sf.b	Door_opened
	jsr	T_00208
	rts
; ---- RiddleM_ModExit (original source: MAIN/EVENTS.ASM)
RiddleM_ModExit:
	bsr.w	Pop_PA
	movea.l	Pic80_ptr,a0
	jsr	Free_memory
	rts	
; ---- RiddleM_DisInit (original source: MAIN/EVENTS.ASM)
RiddleM_DisInit:
	move.l	#Lay9_PlusMes,PlusMes_info
	movea.l	Off_screen,a6
	moveq.l	#9,d0
	bsr.w	Show_layout
	move.w	#224,d0
	moveq.l	#49,d1
	moveq.l	#5,d6
	moveq.l	#80,d7
	movea.l	Pic80_ptr,a0
	jsr	Blot_unmasked_block
	move.l	#RiddleM_CIL,Control_list_ptr
	bsr.w	Show_control_icons
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	Palette_buffer,a1
	lea.l	Subfade1,a2
.Again:
	lea.l	Hbl_Lay9_list,a0
	jsr	Update_HBL
	jsr	My_vsync
	jsr	My_vsync
	lea.l	Lay9_below,a0
	jsr	Fade_pal
	bne.s	.Again
	lea.l	Hbl_Lay9_list,a0
	jsr	Update_HBL
	move.w	#224,d0
	move.w	#49+11,d1
	move.w	#1160,d2
	moveq.l	#4-1,d5
	moveq.l	#5,d6
	moveq.l	#29,d7
	lea.l	RiddleM_graphics,a0
.Loop:
	movea.l	Off_screen,a6
	jsr	Blot_unmasked_block
	jsr	Switch_screen
	moveq.l	#7-1,d3
.Wait:
	jsr	My_vsync
	dbra	d3,.Wait
	adda.w	d2,a0
	dbra	d5,.Loop
	jsr	Copy_screen
	moveq.l	#20-1,d7
.Wait2:
	jsr	My_vsync
	dbra	d7,.Wait2
	bsr.w	Ask_riddleM
	rts	
; ---- RiddleM_DisExit (original source: MAIN/EVENTS.ASM)
RiddleM_DisExit:
	move.w	#224,d0
	move.w	#49+11,d1
	move.w	#1160,d2
	moveq.l	#4-1,d5
	moveq.l	#5,d6
	moveq.l	#29,d7
	lea.l	RiddleM_graphics+3480,a0
.Loop:
	movea.l	Off_screen,a6
	jsr	Blot_unmasked_block
	jsr	Switch_screen
	moveq.l	#7-1,d3
.Wait1:
	jsr	My_vsync
	dbra	d3,.Wait1
	suba.w	d2,a0
	dbra	d5,.Loop
	jsr	Copy_screen
	moveq.l	#20-1,d7
.Wait2:
	jsr	My_vsync
	dbra	d7,.Wait2
	lea.l	Void,a1
	lea.l	Subfade1,a2
.Again:
	lea.l	Hbl_Lay9_list,a0
	jsr	Update_HBL
	jsr	My_vsync
	jsr	My_vsync
	lea.l	Lay9_below,a0
	jsr	Fade_pal
	bne.s	.Again
	lea.l	Hbl_Lay9_list,a0
	jsr	Update_HBL
	rts	
; ---- RiddleM_Exit (original source: MAIN/EVENTS.ASM)
RiddleM_Exit:
	bsr.w	Exit_display
	bsr.w	Pop_Module
	bra.w	Init_display
; ---- Answer_riddleM (original source: MAIN/EVENTS.ASM)
Answer_riddleM:
	lea.l	WSelW_Mod,a0
	move.l	#Check_answer_riddleM,Return_ptr(a0)
	bsr.w	Push_Module
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	rts	
Check_answer_riddleM:
	tst.b	No_word_entered
	bne.w	T_09884
	movea.l	Event_data_ptr,a5
	move.w	Found_word,d0
	cmp.w	$6(a5),d0
	bne.b	T_09854
	moveq	#7,d1
	and.w	d0,d1
	lsr.w	#$3,d0
	lea.l	WD,a0
	bset	d1,(a0,d0.w)
	move.w	$8(a5),d2
	beq.b	T_09826
	moveq	#0,d0
	move.b	$1(a5),d0
	moveq	#0,d1
	move.b	$2(a5),d1
	movea.l	Mapd_ptr,a0
	bsr.w	Do_change_icon
	tst.b	$5(a5)
	beq.b	T_09826
	jsr	Enter_modification
T_09826:
	st.b	Door_opened
	moveq	#0,d0
	move.b	$4(a5),d0
	cmpi.w	#$1a,d0
	beq.b	T_09852
	move.w	d0,PlusMes_nr
	move.l	Maptext_ptr,Textfile_ptr
	lea.l	RiddleMes_Mod,a0
	bsr.w	Push_Module
T_09852:
	bra.b	T_09884
T_09854:
	dc.b	$70,$0b,$43,$f9
	dc.l	Code0002Sys
	dc.b	$33,$c0
	dc.l	PlusMes_nr
	dc.b	$23,$c9
	dc.l	Textfile_ptr
	dc.b	$61,$00,$da,$68,$30,$39
	dc.l	Found_word
	dc.b	$66,$04,$30,$3c,$01,$bb,$32,$80,$41,$f9
	dc.l	RiddleMes_Mod
	dc.b	$61,$00,$70,$ee
T_09884:
	rts
; ---- Ask_riddleM (original source: MAIN/EVENTS.ASM)
Ask_riddleM:
	movea.l	Event_data_ptr,a5
	moveq.l	#0,d0
	move.b	3(a5),d0
	cmpi.w	#26,d0
	beq.s	.Exit
	move.w	d0,PlusMes_nr
	move.l	Maptext_ptr,Textfile_ptr
	lea.l	RiddleMes_Mod,a0
	bsr.w	Push_Module
.Exit:
	rts	
; ---- RiddleMes (original source: MAIN/EVENTS.ASM)
RiddleMes:
	jsr	Mouse_off
	movea.l	PlusMes_info,a0
	jsr	Push_MA
	addq.l	#8,a0
	bsr.w	Push_PA
	movea.l	Off_screen,a6
	bsr.w	Erase_text_window
	move.w	PlusMes_nr,d0
	move.w	Nr_of_chars,d2
	movea.l	Textfile_ptr,a1
	bsr.w	Prepare_text_block
	movea.l	Text_buffer,a0
	move.w	Nr_of_chars,d0
	addq.w	#1,d0
	move.w	Lines_in_text,d7
	subq.w	#1,d7
.Loop1:
	jsr	IG_Print
	jsr	IG_Carriage_return
	adda.w	d0,a0
	dbra	d7,.Loop1
	jsr	Switch_screen
	jsr	Copy_screen
	moveq.l	#2,d7
.Loop2:
	jsr	Random
	andi.w	#$7,d0
	beq.s	.Loop2
	bsr.w	.Move_mouth
	dbra	d7,.Loop2
	jsr	Copy_screen
	jsr	Pop_MA
	bsr.w	Pop_PA
	movea.l	Text_buffer,a0
	jsr	Free_memory
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	jsr	Mouse_on
	bra.w	Pop_Module
.Move_mouth:
	movem.l	d0-d3/d6/d7/a0/a6,-(sp)
	move.w	d0,d3
	move.w	#224,d0
	move.w	#49+41,d1
	moveq.l	#0,d2
	moveq.l	#5,d6
	moveq.l	#15,d7
.Loop3:
	bsr.w	.Show_mouth_frame
	addq.w	#1,d2
	cmp.w	d2,d3
	bpl.s	.Loop3
	subq.w	#2,d2
.Loop4:
	bsr.w	.Show_mouth_frame
	subq.w	#1,d2
	bpl.s	.Loop4
	movem.l	(sp)+,d0-d3/d6/d7/a0/a6
	rts	
.Show_mouth_frame:
	movem.l	d2/a0/a6,-(sp)
	lea.l	RiddleM_graphics+4640,a0
	mulu.w	#600,d2
	adda.w	d2,a0
	movea.l	Off_screen,a6
	jsr	Blot_unmasked_block
	jsr	Switch_screen
	moveq.l	#7-1,d2
.Wait:
	jsr	My_vsync
	dbra	d2,.Wait
	movem.l	(sp)+,d2/a0/a6
	rts	
; ---- Attr_change (original source: MAIN/EVENTS.ASM)
Attr_change:
	move.b	4(a5),d0
	bsr.w	Event_text
	tst.w	6(a5)
	beq.s	.All
	movea.l	Current_active_char_data,a1
	bsr.w	.Change
	bra.s	.Go_on
.All:
	lea.l	Chard_ptrs,a0
	moveq.l	#1,d7
.Loop:
	tst.l	(a0)
	beq.s	.Next
	movea.l	(a0),a1
	move.w	#$e000,d1
	and.w	Body_conditions(a1),d1
	bne.s	.Next
	bsr.w	.Change
.Next:
	addq.l	#4,a0
	addq.w	#1,d7
	cmpi.w	#6+1,d7
	bmi.s	.Loop
.Go_on:
	bsr.w	Save_event
	rts	
.Change:
	lea.l	Attr_1_normal-2(a1),a2
	move.b	1(a5),d0
	ext.w	d0
	add.w	d0,d0
	adda.w	d0,a2
	move.w	8(a5),d1
	tst.b	3(a5)
	beq.s	.Not_random
	jsr	Random
	mulu.w	d0,d1
	swap.w	d1
	addq.w	#1,d1
.Not_random:
	tst.b	2(a5)
	beq.s	.Add
	neg.w	d1
.Add:
	add.w	d1,(a2)
	move.w	d7,d0
	jsr	Do_sparkle
	rts	
T_09a46:
	movea.l	Module_sp,a0
	move.l	(a0),d0
	beq.b	Change_icon
	movea.l	d0,a0
	jsr	(a0)
	jsr	Switch_screen
Change_icon:
	move.b	$4(a5),d0
	bsr.w	Event_text
	moveq	#0,d0
	move.b	$1(a5),d0
	moveq	#0,d1
	move.b	$2(a5),d1
	move.w	$6(a5),d2
	movea.l	Mapd_ptr,a0
	bsr.w	Do_change_icon
	tst.b	$5(a5)
	beq.b	T_09a8c
	jsr	Enter_modification
	bsr.w	Save_event
T_09a8c:
	rts
T_09a8e:
	movea.l	Module_sp,a0
	move.l	(a0),d0
	beq.b	T_09aa2
	movea.l	d0,a0
	jsr	(a0)
	jsr	Switch_screen
T_09aa2:
	move.b	$4(a5),d0
	bsr.w	Event_text
	rts
T_09aac:
	movem.l	d0-d2/a0/a5,-(a7)
Do_event_item:
	movea.l	Event_data_ptr,a5
	moveq	#0,d0
	move.b	$1(a5),d0
	moveq	#0,d1
	move.b	$2(a5),d1
	move.w	$8(a5),d2
	movea.l	Mapd_ptr,a0
	bsr.w	Do_change_icon
	tst.b	$5(a5)
	beq.b	T_09ae0
	jsr	Enter_modification
	bsr.w	Save_event
T_09ae0:
	movem.l	(a7)+,d0-d2/a0/a5
	rts
; ---- Door_exit (original source: MAIN/EVENTS.ASM)
Door_exit:
	st	Doorexit_flag
	bsr.w	Door
	rts	
; ---- Do_extra_event (original source: MAIN/EVENTS.ASM)
Do_extra_event:
	movea.l	Event_data_ptr,a5
	moveq.l	#0,d0
	move.b	4(a5),d0
	movea.l	Mapd_ptr,a5
	mulu.w	#10,d0
	lea.l	Event_data-10(a5,d0.w),a5
	move.l	a5,Event_data_ptr
	bra.w	Handle_event
; ---- ETrap (original source: MAIN/EVENTS.ASM)
ETrap:
	move.b	4(a5),d0
	bsr.w	Event_text
	move.b	1(a5),d0
	bsr.w	Execute_trap
	bsr.w	Save_event
	rts	
T_09b2c:
	move.b	$1(a5),d0
	ext.w	d0
	bsr.w	Probe
	bmi.w	T_09c04
	movea.l	Module_sp,a0
	move.l	(a0),d0
	beq.b	T_09b4e
	movea.l	d0,a0
	jsr	(a0)
	jsr	Switch_screen
T_09b4e:
	move.b	$2(a5),d0
	beq.b	T_09b76
	lea.l	Quest,a1
	ext.w	d0
	move.w	d0,d1
	andi.w	#$7,d1
	lsr.w	#$3,d0
	btst	d1,(a1,d0.w)
	beq.w	T_09c04
	move.b	$3(a5),d0
	bsr.w	Event_text
	bra.b	T_09b7e
T_09b76:
	dc.b	$10,$2d,$00,$04,$61,$00,$e3,$0c
T_09b7e:
	move.w	$6(a5),B_5891a
	sf.b	Party_advantage
	sf.b	Monster_advantage
	move.w	Map_Xcoord,d0
	move.w	Map_Ycoord,d1
	cmpi.b	#$2,Current_map_type
	bpl.b	T_09bba
	bsr.w	Get_2D_icon_status
	tst.l	d1
	beq.b	T_09bbe
	btst	#$5,d1
	bne.b	T_09bbe
	move.l	d1,d0
	bra.b	T_09bbe
T_09bba:
	dc.b	$61,$00,$9d,$3c
T_09bbe:
	moveq	#16,d1
	moveq	#13,d7
T_09bc2:
	btst	d1,d0
	bne.b	T_09bce
	addq.w	#$1,d1
	dbra	d7,T_09bc2
	moveq	#16,d1
T_09bce:
	subi.w	#$f,d1
	move.w	d1,B_58910
	move.w	Active_member,B_57a62
	st.b	Battling
	st.b	B_58e74
	move.w	#$4,Spell_area_type
	bsr.w	Exit_display
	lea.l	Combat_Mod,a0
	bsr.w	Push_Module
T_09c04:
	rts
T_09c06:
	btst	#$1,B_59339
	beq.b	T_09c18
	bsr.w	T_01f98
	bra.w	T_09cb2
T_09c18:
	lea.l	Chard_ptrs,a0
	moveq	#0,d0
	moveq	#5,d7
T_09c22:
	tst.l	(a0)
	beq.b	T_09c4e
	movea.l	(a0),a1
	lea.l	$29a(a1),a2
	lea.l	$2b(a1),a1
	moveq	#11,d6
T_09c32:
	tst.b	(a1)
	beq.b	T_09c44
	cmpi.w	#$6e,$24(a2)
	bne.b	T_09c44
	move.b	(a1),d1
	ext.w	d1
	add.w	d1,d0
T_09c44:
	addq.l	#$1,a1
	lea.l	$28(a2),a2
	dbra	d6,T_09c32
T_09c4e:
	addq.l	#$4,a0
	dbra	d7,T_09c22
	cmpi.w	#$d,d0
	bpl.b	T_09ca4
	move.w	#$13,WText_nr
	move.l	#Code0008Sys,Textfile_ptr
	lea.l	TxtW_Mod,a0
	bsr.w	Push_Module
T_09c76:
	move.w	#$0,Draw_Cicon
	bsr.w	Input_handler
	movea.l	Module_sp,a0
	move.l	(a0),d0
	beq.b	T_09c90
	movea.l	d0,a0
	jsr	(a0)
T_09c90:
	jsr	Switch_screen
	tst.b	B_592de
	beq.b	T_09c76
	bsr.w	T_01f98
	bra.b	T_09cb2
T_09ca4:
	dc.b	$61,$00,$6c,$68,$41,$f9
	dc.l	D_2d5e4
	dc.b	$61,$00,$6c,$c0
T_09cb2:
	rts
T_09cb4:
	jsr	T_0025a
	moveq	#13,d0
	jsr	T_00f12
	lea.l	D_2f227,a0
	jsr	T_1b786
	move.l	a0,B_5d0a0
	lea.l	D_2f233,a0
	jsr	T_1b786
	move.l	a0,B_5d0a4
	jsr	T_00208
	clr.w	B_5821c
	clr.w	B_5821a
	move.w	#$fff,B_58218
	clr.w	B_58216
	lea.l	D_25e86,a0
	bsr.w	Push_PA
	bsr.w	T_09d44
	moveq	#2,d0
	bsr.w	T_0a220
	bra.w	T_09f5e
T_09d1e:
	bsr.w	Pop_PA
	bsr.w	T_09e42
	movea.l	B_5d0a0,a0
	jsr	Free_memory
	movea.l	B_5d0a4,a0
	jsr	Free_memory
	bsr.w	Set_spell_area
	rts
T_09d44:
	move.l	B_5d0a4,Textfile_ptr
	movea.l	Off_screen,a6
	moveq	#1,d0
	bsr.w	Show_layout
	move.w	#$10,d0
	move.w	#$31,d1
	move.w	#$b,d6
	move.w	#$90,d7
	movea.l	B_5d0a0,a0
	jsr	Blot_unmasked_block
	move.w	#$39,d0
	move.w	#$4a,d1
	move.w	#$6,d6
	move.w	#$60,d7
	movea.l	B_5d0a0,a0
	lea.l	$3180(a0),a0
	jsr	T_1c42e
	lea.l	D_25eb6,a1
	movea.l	B_5d0a0,a2
	lea.l	$4380(a2),a2
	move.w	B_58216,d2
	moveq	#2,d6
	moveq	#32,d7
	moveq	#11,d5
T_09db2:
	lsr.w	#$1,d2
	bcc.b	T_09dcc
	move.w	(a1),d0
	addi.w	#$10,d0
	move.w	$2(a1),d1
	addi.w	#$31,d1
	movea.l	a2,a0
	jsr	T_1c42e
T_09dcc:
	addq.l	#$4,a1
	lea.l	$200(a2),a2
	dbra	d5,T_09db2
	lea.l	D_25e38,a0
	bsr.w	T_09f3a
	move.l	a0,Control_list_ptr
	bsr.w	Show_control_icons
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	Control_area,a0
	jsr	Set_layout_data
	lea.l	D_25e66,a1
	lea.l	Subfade1,a2
T_09e0e:
	lea.l	D_30220,a0
	jsr	Update_HBL
	jsr	My_vsync
	jsr	My_vsync
	lea.l	D_30244,a0
	jsr	Fade_pal
	bne.b	T_09e0e
	lea.l	D_30220,a0
	jsr	Update_HBL
	rts
T_09e42:
	lea.l	Void,a1
	lea.l	Subfade1,a2
T_09e4e:
	lea.l	D_30220,a0
	jsr	Update_HBL
	jsr	My_vsync
	jsr	My_vsync
	lea.l	D_30244,a0
	jsr	Fade_pal
	bne.b	T_09e4e
	lea.l	D_30220,a0
	jsr	Update_HBL
	rts
T_09e82:
	lea.l	D_25e38,a0
	lea.l	T_09f3a,a1
	bsr.w	Update_control_icons
	bsr.w	Update_status_block
	movea.l	Off_screen,a6
	move.w	#$e0,d0
	move.w	#$39,d1
	move.w	d0,d2
	move.w	d1,d3
	addi.w	#$3f,d2
	addi.w	#$1f,d3
	moveq	#2,d6
	jsr	Draw_box
	movea.l	B_5d0a0,a1
	lea.l	$4380(a1),a0
	move.w	B_5821a,d2
	lsl.w	#$8,d2
	add.w	d2,d2
	adda.w	d2,a0
	move.w	#$e0,d0
	move.w	#$39,d1
	moveq	#2,d6
	moveq	#32,d7
	jsr	Blot_masked_block
	lea.l	$5b80(a1),a0
	lea.l	D_25eaa,a1
	move.w	B_5821a,d2
	move.b	(a1,d2.w),d2
	ext.w	d2
	subq.w	#$1,d2
	lsl.w	#$8,d2
	add.w	d2,d2
	adda.w	d2,a0
	move.w	#$100,d0
	move.w	#$39,d1
	moveq	#2,d6
	moveq	#32,d7
	jsr	Blot_masked_block
	bsr.w	Erase_text_window
	lea.l	D_25ee6,a0
	move.w	B_5821a,d0
	add.w	d0,d0
	add.w	d0,d0
	movea.l	(a0,d0.w),a0
	move.w	#$d0,d0
	move.w	#$76,d1
	move.w	#$60,d2
	bsr.w	Print_centered_string
	rts
T_09f3a:
	bclr	#$7,$6(a0)
	bclr	#$7,$8(a0)
	cmpi.w	#$b,B_5821c
	bmi.b	T_09f5c
	bset	#$7,$6(a0)
	bset	#$7,$8(a0)
T_09f5c:
	rts
T_09f5e:
	btst	#$1,Mouse_button_state
	bne.b	T_09f5e
	lea.l	D_25e92,a0
	move.w	B_5821c,d0
	move.b	(a0,d0.w),d0
	ext.w	d0
	bra.w	T_0a220
T_09f7e:
	btst	#$1,Mouse_button_state
	bne.b	T_09f7e
	move.w	#$0,Draw_Cicon
	jsr	My_vsync
T_09f96:
	tst.w	B_5821a
	beq.b	T_09fc0
	move.w	B_58218,d0
	move.w	B_5821a,d1
	move.w	d1,d7
	bra.b	T_09fb2
T_09fae:
	btst	d1,d0
	bne.b	T_09fba
T_09fb2:
	subq.w	#$1,d1
	dbra	d7,T_09fae
	bra.b	T_09fc0
T_09fba:
	move.w	d1,B_5821a
T_09fc0:
	rts
T_09fc2:
	btst	#$1,Mouse_button_state
	bne.b	T_09fc2
	move.w	#$0,Draw_Cicon
	jsr	My_vsync
T_09fda:
	cmpi.w	#$b,B_5821a
	beq.b	T_0a008
	move.w	B_58218,d0
	move.w	B_5821a,d1
	moveq	#11,d7
	sub.w	d1,d7
	bra.b	T_09ffa
T_09ff6:
	btst	d1,d0
	bne.b	T_0a002
T_09ffa:
	addq.w	#$1,d1
	dbra	d7,T_09ff6
	bra.b	T_0a008
T_0a002:
	move.w	d1,B_5821a
T_0a008:
	rts
T_0a00a:
	btst	#$1,Mouse_button_state
	bne.b	T_0a00a
	move.w	#$0,Draw_Cicon
	jsr	My_vsync
	lea.l	D_25e9e,a0
	adda.w	B_5821c,a0
	move.b	(a0),d0
	ext.w	d0
	subq.w	#$1,d0
	cmp.w	B_5821a,d0
	beq.b	T_0a05c
	moveq	#1,d0
	bsr.w	T_0a220
	movea.l	Current_active_char_data,a0
	clr.w	$86(a0)
	bset	#$6,$3a(a0)
	jsr	T_006fe
	bra.w	T_0a18e
T_0a05c:
	move.w	B_5821a,d0
	move.w	B_58216,d1
	bset	d0,d1
	move.w	d1,B_58216
	lea.l	D_25eb6,a0
	add.w	d0,d0
	add.w	d0,d0
	move.w	$2(a0,d0.w),d1
	move.w	(a0,d0.w),d0
	movea.l	B_5d0a0,a0
	lea.l	$4380(a0),a0
	move.w	B_5821a,d2
	lsl.w	#$8,d2
	add.w	d2,d2
	adda.w	d2,a0
	addi.w	#$10,d0
	addi.w	#$31,d1
	moveq	#2,d6
	moveq	#32,d7
	movea.l	Off_screen,a6
	jsr	T_1c42e
	jsr	Switch_screen
	jsr	Copy_screen
	moveq	#0,d0
	bsr.w	T_0a220
	lea.l	T_0a190,a1
	move.w	B_5821c,d0
	add.w	d0,d0
	add.w	d0,d0
	movea.l	(a1,d0.w),a1
	movea.l	Current_active_char_data,a0
	jsr	(a1)
	move.w	Active_member,d0
	jsr	Do_sparkle
	move.w	B_5821c,d0
	addq.w	#$1,d0
	cmpi.w	#$c,d0
	bne.b	T_0a160
	lea.l	Chard_ptrs,a0
	moveq	#5,d7
T_0a100:
	tst.l	(a0)
	beq.b	T_0a134
	movea.l	(a0),a1
	lea.l	$2b(a1),a2
	lea.l	$29a(a1),a3
	moveq	#11,d6
T_0a110:
	tst.b	(a2)
	beq.b	T_0a12a
	cmpi.w	#$6e,$24(a3)
	bne.b	T_0a12a
	move.b	(a2),d1
	ext.w	d1
	mulu.w	$22(a3),d1
	sub.l	d1,$ec(a1)
	clr.b	(a2)
T_0a12a:
	addq.l	#$1,a2
	lea.l	$28(a3),a3
	dbra	d6,T_0a110
T_0a134:
	addq.l	#$4,a0
	dbra	d7,T_0a100
	moveq	#6,d0
	jsr	T_00f12
	moveq	#3,d0
	bsr.w	T_0a220
	bset	#$1,B_59339
	jsr	T_01f98
	bsr.w	Pop_Module
	bsr.w	Init_display
	bra.b	T_0a18e
T_0a160:
	move.w	d0,B_5821c
	move.w	B_5821a,d2
	move.w	B_58218,d0
	bclr	d2,d0
	move.w	d0,B_58218
	bsr.w	T_09fda
	cmp.w	B_5821a,d2
	bne.b	T_0a18a
	bsr.w	T_09f96
T_0a18a:
	bsr.w	T_09f5e
T_0a18e:
	rts
T_0a190:
	dc.l	T_0a1c0	; ori.b #$c0, d0
	dc.l	T_0a1c8	; ori.b #$c8, d0
	dc.l	T_0a1d0	; ori.b #$d0, d0
	dc.l	T_0a1d8	; ori.b #$d8, d0
	dc.l	T_0a1e0	; ori.b #$e0, d0
	dc.l	T_0a1e8	; ori.b #$e8, d0
	dc.l	T_0a1f0	; ori.b #$f0, d0
	dc.l	T_0a1f8	; ori.b #$f8, d0
	dc.l	T_0a200	; ori.b #$0, d0
	dc.l	T_0a208	; ori.b #$8, d0
	dc.l	T_0a210	; ori.b #$10, d0
	dc.l	T_0a218	; ori.b #$18, d0
T_0a1c0:
	addi.b	#$a,$f(a0)
	rts
T_0a1c8:
	addi.w	#$a,$56(a0)
	rts
T_0a1d0:
	addi.b	#$a,$e(a0)
	rts
T_0a1d8:
	addi.w	#$a,$88(a0)
	rts
T_0a1e0:
	addi.w	#$a,$8c(a0)
	rts
T_0a1e8:
	addi.w	#$a,$54(a0)
	rts
T_0a1f0:
	addi.w	#$a,$4a(a0)
	rts
T_0a1f8:
	addi.w	#$a,$4e(a0)
	rts
T_0a200:
	addi.w	#$a,$50(a0)
	rts
T_0a208:
	addi.w	#$a,$48(a0)
	rts
T_0a210:
	addi.w	#$a,$4c(a0)
	rts
T_0a218:
	addi.w	#$a,$52(a0)
	rts
T_0a220:
	movem.l	d0-d7/a0-a6,-(a7)
	move.w	d0,WText_nr
	lea.l	TxtW_Mod,a0
	bsr.w	Push_Module
T_0a234:
	move.w	#$0,Draw_Cicon
	bsr.w	Input_handler
	movea.l	Module_sp,a0
	move.l	(a0),d0
	beq.b	T_0a24e
	movea.l	d0,a0
	jsr	(a0)
T_0a24e:
	jsr	Switch_screen
	tst.b	B_592de
	beq.b	T_0a234
	movem.l	(a7)+,d0-d7/a0-a6
	rts
T_0a262:
	movea.l	B_5bea4,a0
	lea.l	$80(a0),a0
	lea.l	Chard_ptrs,a1
	moveq	#5,d7
T_0a274:
	move.l	(a1)+,d0
	bne.b	T_0a27e
	dc.w	$10fc,$ffff	; move.b #$ff, (a0)+
	bra.b	T_0a2a0
T_0a27e:
	movea.l	d0,a2
	cmpi.b	#$3,$4(a2)
	bne.b	T_0a28e
	move.b	#$2,(a0)+
	bra.b	T_0a2a0
T_0a28e:
	cmpi.b	#$2,$4(a2)
	bne.b	T_0a29c
	move.b	#$1,(a0)+
	bra.b	T_0a2a0
T_0a29c:
	dc.b	$10,$fc,$00,$00
T_0a2a0:
	dbra	d7,T_0a274
	move.w	#$2505,B_59312
	bsr.w	Exit_display
	movea.l	Off_screen,a6
	jsr	Clear_screen
	jsr	Switch_screen
	jsr	Copy_screen
	jmp	Exit_all
; ---- Fadein_lay3 (original source: MAIN/EVENTS.ASM)
Fadein_lay3:
	lea.l	Lay3_target_hbl,a1
	bra.s	Fade_lay3
; ---- Fadeout_lay3 (original source: MAIN/EVENTS.ASM)
Fadeout_lay3:
	lea.l	Void,a1
; ---- Fade_lay3 (original source: MAIN/EVENTS.ASM)
Fade_lay3:
	tst.b	Fade_block
	bne.s	.Exit
	lea.l	Subfade1,a2
.Again:
	lea.l	Hbl_Lay3_list,a0
	jsr	Update_HBL
	jsr	My_vsync
	jsr	My_vsync
	lea.l	Lay3_below,a0
	jsr	Hbl_fade
	bne.s	.Again
	lea.l	Hbl_Lay3_list,a0
	jsr	Update_HBL
.Exit:
	rts	
; ---- Update_control_icons (original source: MAIN/EVENTS.ASM)
Update_control_icons:
	movem.l	a0-a2,-(sp)
	movea.l	a0,a2
	lea.l	CIL_buffer,a0
	move.l	(a2),(a0)
	move.l	4(a2),4(a0)
	move.b	8(a2),8(a0)
	movem.l	a0/a2,-(a7)	; CHANGE: added
	jsr	(a1)
	movem.l	(a7)+,a0/a2	; CHANGE: added
	movea.l	a2,a1
	cmpm.l	(a0)+,(a1)+
	bne.s	.Update
	cmpm.l	(a0)+,(a1)+
	bne.s	.Update
	cmpm.b	(a0)+,(a1)+
	beq.s	.Ready
.Update:
	lea.l	CIL_buffer,a0
	move.l	(a0)+,(a2)+
	move.l	(a0)+,(a2)+
	move.b	(a0),(a2)
	move.b	#2,CIL_update
.Ready:
	movem.l	(sp)+,a0-a2
	rts	
; ---- Load_80x80_picture (original source: MAIN/EVENTS.ASM)
Load_80x80_picture:
	movem.l	d0-d7/a0-a2,-(sp)
	movea.l	a0,a2
	lea.l	Pics80_filename,a0
	add.w	d0,d0
	jsr	Load_subfile
	movem.l	(a0),d1-d7/a1
	movem.l	d1-d7/a1,(a2)
	jsr	Free_memory
	lea.l	Pics80_filename,a0
	subq.w	#1,d0
	jsr	Load_subfile
	move.l	a0,Pic80_ptr
	movem.l	(sp)+,d0-d7/a0-a2
	rts	
; ---- Display_80x80_picture (original source: MAIN/EVENTS.ASM)
Display_80x80_picture:
	movem.l	d0/d1/d6/d7/a0,-(sp)
	moveq.l	#16,d0
	moveq.l	#49,d1
	moveq.l	#5,d6
	moveq.l	#80,d7
	movea.l	Pic80_ptr,a0
	jsr	Blot_unmasked_block
	movem.l	(sp)+,d0/d1/d6/d7/a0
	rts	
; ---- Do_change_icon (original source: MAIN/EVENTS.ASM)
Do_change_icon:
	movem.l	d0/d1/a0/a1,-(sp)
	cmpi.b	#1,Current_map_type
	bne.s	.Ok
	lea.l	Map_data(a0),a0
	bra.s	.Go_on
.Ok:
	movea.l	Map_pointer,a0
.Go_on:
	subq.w	#1,d1
	mulu.w	Width_of_map,d1
	add.w	d0,d1
	lea.l	-1(a0,d1.w),a0
	cmpi.b	#2,Current_map_type
	bpl.s	.3D_map
	movea.l	Iconstats_ptr,a1
	move.w	d2,d1
	subq.w	#1,d1
	add.w	d1,d1
	add.w	d1,d1
	move.l	0(a1,d1.w),d1
	btst	#2,d1
	beq.s	.3D_map
	adda.w	Size_of_map,a0
.3D_map:
	move.b	d2,(a0)
	movem.l	(sp)+,d0/d1/a0/a1
	rts	
Do_WordIn:
	movem.l	d0-d3/d6-d7/a0/a6,-(a7)
	jsr	Mouse_off
	move.w	#$30,d0
	move.w	#$50,d1
	moveq	#10,d2
	moveq	#4,d3
	moveq	#1,d6
	suba.l	a0,a0
	jsr	Open_window
	move.w	d0,B_58256
	movea.l	Screen_base,a6
	move.w	#$40,d0
	move.w	#$67,d1
	jsr	IG_Set_cursor
	lea.l	T_0a4bc(pc),a0
	jsr	IG_Print
	lea.l	D_25fca,a0
	addi.w	#$a,d1
	move.w	d0,(a0)
	move.w	d1,$2(a0)
	move.w	#$7e,$4(a0)
	bsr.w	Push_PA
	move.w	d0,d2
	addi.w	#$7e,d2
	move.w	d1,d3
	addq.w	#$6,d3
	subq.w	#$1,d0
	subq.w	#$1,d1
	moveq	#3,d6
	jsr	Draw_box
	move.w	d6,d0
	jsr	IG_Set_paper
	moveq	#19,d0
	bsr.w	Input_string
	move.w	B_58256,d0
	jsr	Close_window
	bsr.w	Pop_PA
	jsr	Mouse_on
	movem.l	(a7)+,d0-d3/d6-d7/a0/a6
	bra.w	Pop_Module
T_0a4bc:
	dc.b	$01,$0f,$02,$02,$45,$4e,$54,$45,$52,$20,$57,$4f,$52,$44,$20,$3a
	dc.b	$00,$00
; ---- Divide_gold (original source: MAIN/EVENTS.ASM)
Divide_food:
Divide_gold:
	movem.l	d1-d3/d6/d7/a0-a2,-(sp)
	ext.l	d0
	beq.w	.Exit
	move.l	d0,d3
	lea.l	Chard_ptrs,a0
	lea.l	Divide_gold_workspace,a1
	moveq.l	#0,d6
	moveq.l	#6-1,d7
.Loop1:
	moveq.l	#0,d0
	tst.l	(a0)
	beq.s	.Next1
	movea.l	(a0),a2
	cmpi.b	#9,Character_race(a2)
	bpl.s	.Next1
	move.w	#$e402,d1
	and.w	Body_conditions(a2),d1
	bne.s	.Next1
	move.w	Attr_1_normal(a2),d0
	add.w	Attr_1_normal_magic(a2),d0
	mulu.w	#1000,d0
	sub.l	Weight_normal(a2),d0
	divu.w	#Gold_weight,d0
	move.w	Gold_coins(a2),d1
	add.w	d0,d1
	bvc.s	.Next1
	move.w	#32767,d0
	sub.w	Gold_coins(a2),d0
.Next1:
	tst.w	d0
	beq.s	.Skip1
	addq.w	#1,d6
.Skip1:
	move.w	d0,(a1)+
	addq.l	#4,a0
	dbra	d7,.Loop1
	move.l	d3,d0
	tst.w	d6
	beq.s	.Exit
.Again:
	lea.l	-24(a0),a0
	lea.l	-12(a1),a1
	moveq.l	#6-1,d7
.Loop2:
	move.w	(a1),d1
	beq.s	.Next2
	movea.l	(a0),a2
	move.l	d0,d2
	divu.w	d6,d2
	tst.w	d2
	bne.s	.Skip2
	move.l	d0,d2
.Skip2:
	cmp.w	d2,d1
	bpl.s	.Enough
	sub.w	d1,(a1)
	bne.s	.Notzero1
	subq.w	#1,d6
.Notzero1:
	sub.w	d1,d0
	add.w	d1,Gold_coins(a2)
	mulu.w	#Gold_weight,d1
	add.l	d1,Weight_normal(a2)
	bra.s	.Next2
.Enough:
	sub.w	d2,(a1)
	bne.s	.Notzero2
	subq.w	#1,d6
.Notzero2:
	sub.w	d2,d0
	add.w	d2,Gold_coins(a2)
	mulu.w	#Gold_weight,d2
	add.l	d2,Weight_normal(a2)
.Next2:
	addq.l	#4,a0
	addq.l	#2,a1
	dbra	d7,.Loop2
	tst.w	d0
	beq.s	.Exit
	tst.w	d6
	bne.s	.Again
.Exit:
	movem.l	(sp)+,d1-d3/d6/d7/a0-a2
	rts	
; ---- Show_objects_LAY3 (original source: MAIN/EVENTS.ASM)
Show_objects_LAY3:
	movem.l	d0-d2/d7/a1-a3,-(sp)
	movea.l	Itemdata_ptr,a1
	lea.l	Door_object_pos_list,a2
	movea.l	Itemslots_ptr,a3
	moveq.l	#12-1,d7
.Loop:
	move.w	(a2)+,d0
	move.w	(a2)+,d1
	lea.l	Layout_icn+9856,a0
	jsr	Put_unmasked_block
	tst.b	(a3)+
	beq.s	.Next
	cmpi.b	#17,Item_type(a1)
	beq.s	.Next
	lea.l	Objects_icn,a0
	move.b	(a1),d2
	ext.w	d2
	lsl.w	#7,d2
	adda.w	d2,a0
	jsr	Put_masked_block
.Next:
	lea.l	40(a1),a1
	dbra	d7,.Loop
	movem.l	(sp)+,d0-d2/d7/a1-a3
	rts	
; ---- Remove_event (original source: MAIN/EVENTS.ASM)
Remove_event:
	movem.l	d1/a0,-(sp)
	lea.l	Map_data(a0),a0
	subq.w	#1,d1
	mulu.w	Width_of_map,d1
	add.w	d0,d1
	lea.l	-1(a0,d1.w),a0
	cmpi.b	#2,Current_map_type
	bpl.s	.3D_map
	adda.w	Size_of_map,a0
.3D_map:
	adda.w	Size_of_map,a0
	clr.b	(a0)
	movem.l	(sp)+,d1/a0
	rts	
