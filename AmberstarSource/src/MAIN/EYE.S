; MAIN/EYE.ASM (original module, merged with the disassembly of the shipped program)

	section	text

; ---- Eye_spy (original source: MAIN/EYE.ASM)
Eye_spy:
	movem.l	d0/a0/a5,-(sp)
	cmpi.b	#2,Current_map_type
	bpl.s	.3D_map
	bsr.w	Make_area_EYE
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	lea.l	Eye2D_Mod,a0
	movea.l	Module_sp,a1
	move.l	(a1),(a0)
	bsr.w	Push_Module
	bra.s	.Exit
.3D_map:
	lea.l	Dir_offset,a0
	move.w	View_direction,d2
	add.w	d2,d2
	move.b	0(a0,d2.w),d0
	ext.w	d0
	add.w	Map_Xcoord,d0
	move.b	1(a0,d2.w),d1
	ext.w	d1
	add.w	Map_Ycoord,d1
	bsr.w	Handle_visible_events
.Exit:
	movem.l	(sp)+,d0/a0/a5
	rts	
; ---- Eye_clicked (original source: MAIN/EYE.ASM)
Eye_clicked:
	move.w	Mouse_X,d0
	move.w	Mouse_Y,d1
	subi.w	#16,d0
	subi.w	#49,d1
	lsr.w	#4,d0
	lsr.w	#4,d1
	sub.w	Mapbuf_X,d0
	sub.w	Mapbuf_Y,d1
	add.w	Map_Xcoord,d0
	add.w	Map_Ycoord,d1
	bsr.w	Eye_exit
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	bra.w	Handle_visible_events
; ---- Eye_exit (original source: MAIN/EYE.ASM)
Eye_exit:
	bsr.w	Pop_Module
	jsr	Pop_MA
	rts	
; ---- Make_area_MOUTH (original source: MAIN/EYE.ASM)
Make_area_EYE:
Make_area_MOUTH:
	lea.l	Made_area,a0
	move.w	Mapbuf_X,d0
	subq.w	#1,d0
	lsl.w	#4,d0
	addi.w	#$17,d0	; CHANGE: was "addi.w #7,d0"
	move.w	d0,(a0)+	; CHANGE: added
	addi.w	#$21,d0	; CHANGE: added
	move.w	d0,(a0)+	; CHANGE: added
	move.w	Mapbuf_Y,d0	; CHANGE: added
	subq.w	#$1,d0	; CHANGE: added
	lsl.w	#$4,d0	; CHANGE: added
	addi.w	#$38,d0	; CHANGE: added
	move.w	d0,(a0)+	; CHANGE: added
	addi.w	#$21,d0	; CHANGE: added
	move.w	d0,(a0)+	; CHANGE: added
	subq.l	#$8,a0	; CHANGE: added
	jsr	Push_MA	; CHANGE: added
	rts	; CHANGE: added
	lea.l	Made_area,a0	; CHANGE: added
	move.w	Mapbuf_X,d0	; CHANGE: added
	subq.w	#$1,d0	; CHANGE: added
	lsl.w	#$4,d0	; CHANGE: added
	addq.w	#$7,d0	; CHANGE: added
	move.w	d0,d1
	cmpi.w	#16,d0
	bpl.s	.Left_Ok
	move.w	#16+7,d0
.Left_Ok:
	move.w	d0,(a0)+
	addi.w	#80-15,d1
	cmpi.w	#16+176,d1
	bmi.s	.Right_Ok
	move.w	#16+176-8,d1
.Right_Ok:
	move.w	d1,(a0)+
	move.w	Mapbuf_Y,d0
	subq.w	#1,d0
	lsl.w	#4,d0
	addi.w	#49-9,d0
	move.w	d0,d1
	cmpi.w	#49,d0
	bpl.s	.Top_Ok
	move.w	#49+7,d0
.Top_Ok:
	move.w	d0,(a0)+
	addi.w	#80-15,d1
	cmpi.w	#49+144,d1
	bmi.s	.Bottom_Ok
	move.w	#49+144-8,d1
.Bottom_Ok:
	move.w	d1,(a0)+
	subq.l	#8,a0
	jsr	Push_MA
	rts	
Handle_visible_events:
	movem.l	d0-d3/a0/a5,-(a7)
	move.w	d0,d2
	move.w	d1,d3
	bsr.w	Find_event
	beq.b	.l_0dede
	moveq	#0,d0
	move.b	(a5),d0
	cmpi.w	#$3,d0
	bne.b	.l_0de82
	st.b	Eye_flag
	bsr.w	Handle_event
	sf.b	Eye_flag
	bra.b	.l_0defc
.l_0de82:
	cmpi.w	#$4,d0
	bne.b	.l_0de94
	jsr	T_01ff6
	bsr.w	Handle_event
	bra.b	.l_0defc
.l_0de94:
	cmpi.w	#$e,d0
	bne.b	.l_0dea0
	bsr.w	Handle_event
	bra.b	.l_0defc
.l_0dea0:
	lea.l	D_292c6,a0
	move.b	-$1(a0,d0.w),d1
	bmi.b	.l_0dede
	movea.l	Current_active_char_data,a0
	moveq	#0,d0
	move.b	Skill_8(a0),d0
	add.w	Skill_8_normal_magic(a0),d0
	bsr.w	Probe
	bmi.b	.l_0dede
	move.w	d1,WText_nr
	move.l	#Code0003Sys,Textfile_ptr
	lea.l	TxtW_Mod,a0
	bsr.w	Push_Module
	bra.b	.l_0defc
.l_0dede:
	cmp.w	Map_Xcoord,d2
	bne.b	.l_0defc
	cmp.w	Map_Ycoord,d3
	bne.b	.l_0defc
	move.w	Active_member,d0
	lsl.w	#$8,d0
	jsr	T_004ce
.l_0defc:
	movem.l	(a7)+,d0-d3/a0/a5
	rts
T_0df02:
	movem.l	d0-d1/a0,-(a7)
	cmpi.b	#$2,Current_map_type
	bpl.b	.l_0df32
	bsr.w	T_0ddf2
.l_0df14:
	btst	#$1,Mouse_button_state
	bne.b	.l_0df14
	lea.l	Mouth2D_Mod,a0
	movea.l	Module_sp,a1
	move.l	(a1),(a0)
	bsr.w	Push_Module
	bra.b	.l_0df42
.l_0df32:
	move.w	Map_Xcoord,d0
	move.w	Map_Ycoord,d1
	bsr.w	Talk
.l_0df42:
	movem.l	(a7)+,d0-d1/a0
	rts
; ---- Mouth_clicked (original source: MAIN/EYE.ASM)
Mouth_clicked:
	move.w	Mouse_X,d0
	move.w	Mouse_Y,d1
	subi.w	#16,d0
	subi.w	#49,d1
	lsr.w	#4,d0
	lsr.w	#4,d1
	sub.w	Mapbuf_X,d0
	sub.w	Mapbuf_Y,d1
	add.w	Map_Xcoord,d0
	add.w	Map_Ycoord,d1
	bsr.w	Eye_exit
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	bra.w	Talk
; ---- Talk (original source: MAIN/EYE.ASM)
Talk:
	movem.l	d2/d6/d7/a0/a1,-(sp)
	lea.l	VChar_data,a0
	move.l	CD_value,d6
	moveq.l	#0,d7
.Loop:
	tst.w	(a0)
	beq.w	.Next
	btst	d7,d6
	bne.w	.Next
	cmp.w	VChar_X(a0),d0
	bne.w	.Next
	cmp.w	VChar_Y(a0),d1
	bne.w	.Next
	tst.b	Current_map_type
	bne.s	.Go_on
	lea.l	Overlay_buf,a1
	move.w	d0,d2
	sub.w	Map_Xcoord,d2
	add.w	Mapbuf_X,d2
	addq.w	#1,d2
	adda.w	d2,a1
	move.w	d1,d2
	sub.w	Map_Ycoord,d2
	add.w	Mapbuf_Y,d2
	addq.w	#1,d2
	muls.w	#13,d2
	adda.w	d2,a1
	cmpi.b	#SleepingIcon,(a1)
	bne.s	.Go_on
	move.w	#10,WText_nr
	move.l	#Code0006Sys,Textfile_ptr
	lea.l	TxtW_Mod,a0
	bsr.w	Push_Module
	bra.w	.Exit
.Go_on:
	move.b	VChar_stats(a0),d2
	btst	#0,d2
	bne.w	.Exit
	btst	#4,d2
	bne.s	.Short
	movea.l	Current_active_char_data,a1
	move.w	VChar_nr(a0),d0
	move.w	d0,Dialogue_char_nr
	lea.l	Chard_filename,a0
	jsr	Load_subfile
	move.l	a0,Dialogue_chard_ptr
	move.w	d7,Dialogue_VChar_index
	move.b	Learned_languages(a0),d0
	and.b	Learned_languages(a1),d0
	bne.s	.Capito
	jsr	Free_memory
	move.w	#1,WText_nr
	move.l	#Code0006Sys,Textfile_ptr
	lea.l	TxtW_Mod,a0
	bsr.w	Push_Module
	bra.s	.Exit
.Capito:
	bsr.w	Exit_display
	lea.l	Dialogue_Mod,a0
	bsr.w	Push_Module
	bra.s	.Exit
.Short:
	move.w	(a0),WText_nr
	move.l	Maptext_ptr,Textfile_ptr
	lea.l	TxtW_Mod,a0
	bsr.w	Push_Module
	bra.s	.Exit
.Next:
	lea.l	VData_length(a0),a0
	addq.w	#1,d7
	cmpi.w	#Max_chars,d7
	bmi.w	.Loop
	cmp.w	Map_Xcoord,d0
	bne.s	.Exit
	cmp.w	Map_Ycoord,d1
	bne.s	.Exit
	move.l	#Code0008Sys,Textfile_ptr
	move.w	#9,WText_nr
	lea.l	TxtW_Mod,a0
	bsr.w	Push_Module
.Exit:
	movem.l	(sp)+,d2/d6/d7/a0/a1
	rts	
; ---- Dialogue_ModInit (original source: MAIN/EYE.ASM)
Dialogue_ModInit:
	sf	Joined
	bsr.w	Set_interaction_ptrs
	movea.l	Dialogue_chard_ptr,a0
	lea.l	Character_text_start(a0),a0
	move.l	a0,Dialogue_text_ptr
	lea.l	Sold_slots,a0
	clr.l	(a0)+
	clr.l	(a0)+
	clr.l	(a0)
	bra.w	Dialogue_DisInit
; ---- Set_interaction_ptrs (original source: MAIN/EYE.ASM)
Set_interaction_ptrs:
	movem.l	d0/d7/a0/a1,-(sp)
	movea.l	Dialogue_chard_ptr,a0
	moveq.l	#0,d7
	moveq.l	#0,d0
	move.b	Dialogue_quest(a0),d0
	beq.s	.First
	lea.l	Quest,a1
	move.w	d0,d1
	andi.w	#7,d1
	lsr.w	#3,d0
	btst	d1,0(a1,d0.w)
	beq.s	.First
	moveq.l	#1,d7
.First:
	lea.l	Action(a0),a1
	move.w	d7,d0
	mulu.w	#10,d0
	adda.w	d0,a1
	move.l	a1,Action_ptr
	lea.l	Act_dat(a0),a1
	adda.w	d0,a1
	adda.w	d0,a1
	move.l	a1,Act_dat_ptr
	lea.l	Result(a0),a1
	move.w	d7,d0
	mulu.w	#50,d0
	adda.w	d0,a1
	move.l	a1,Result_ptr
	lea.l	Res_dat1(a0),a1
	adda.w	d0,a1
	move.l	a1,Res_dat1_ptr
	lea.l	Res_dat2(a0),a1
	adda.w	d0,a1
	move.l	a1,Res_dat2_ptr
	lea.l	Res_dat3(a0),a1
	adda.w	d0,a1
	adda.w	d0,a1
	move.l	a1,Res_dat3_ptr
	movem.l	(sp)+,d0/d7/a0/a1
	rts	
; ---- Dialogue_ModExit (original source: MAIN/EYE.ASM)
Dialogue_ModExit:
	tst.b	Joined
	bne.s	.Skip
	movea.l	Dialogue_chard_ptr,a0
	jsr	Free_memory
.Skip:
	bra.w	Dialogue_DisExit
; ---- Dialogue_DisInit (original source: MAIN/EYE.ASM)
Dialogue_DisInit:
	move.w	#16,Mesmin_X
	move.w	#63,Mesmin_Y
	move.w	#176,Mesmin_Wd
	move.l	#Code0006Sys,Textfile_ptr
	move.l	#Lay8_PlusMes,PlusMes_info
	move.l	#Sold_data,Itemdata_ptr
	move.l	#Sold_slots,Itemslots_ptr
	movea.l	Off_screen,a6
	moveq.l	#8,d0
	bsr.w	Show_layout
	move.w	#$10,d0	; CHANGE: was "moveq.l #15,d0"
	move.w	#$27,d1	; CHANGE: added
	move.w	#$b0,d2	; CHANGE: added
	lea.l	D_30b29,a0	; CHANGE: added
	bsr.w	Print_centered_string	; CHANGE: was "jsr IG_Set_ink"
	moveq.l	#2,d0
	jsr	IG_Set_paper
	moveq.l	#0,d0
	movea.l	Dialogue_chard_ptr,a1
	lea.l	Portrait+6(a1),a0
	move.w	#208,d0
	move.w	#49,d1
	moveq.l	#2,d6
	moveq.l	#34,d7
	jsr	Blot_unmasked_block
	moveq.l	#1,d0
	jsr	IG_Set_ink
	move.w	#208,d0
	move.w	#84,d1
	move.w	#96,d2
	lea.l	Char_name(a1),a0
	bsr.w	Print_centered_string
	moveq.l	#15,d0
	jsr	IG_Set_ink
	move.w	#208+34,d0
	move.w	#49+7,d1
	jsr	IG_Set_cursor
	move.b	Character_sex(a1),d0
	beq.s	.Male
	lea.l	Female_name,a0
	bra.s	.Cont
.Male:
	lea.l	Male_name,a0
.Cont:
	jsr	IG_Print
	cmpi.b	#9,Character_race(a1)
	bpl.s	.No_class
	move.w	#208+34,d0
	move.w	#49,d1
	jsr	IG_Set_cursor
	lea.l	Race_dat+Race_names,a2
	moveq.l	#0,d0
	move.b	Character_race(a1),d0
	add.w	d0,d0
	move.w	0(a2,d0.w),d0
	bsr.w	Get_word
	lea.l	Line_buffer,a0
	jsr	IG_Print
	tst.b	Character_class(a1)
	beq.s	.No_class
	move.w	#208+34,d0
	move.w	#49+21,d1
	jsr	IG_Set_cursor
	lea.l	Class_dat+Class_names,a2
	moveq.l	#0,d0
	move.b	Character_class(a1),d0
	add.w	d0,d0
	move.w	0(a2,d0.w),d0
	bsr.w	Get_word
	move.b	#$20,(a3)+	; CHANGE: was "move.b #" ",(a3)+"
	moveq.l	#0,d0
	move.b	Level_nr(a1),d0
	moveq.l	#2,d7
	bsr.w	LConvert_number
	lea.l	Line_buffer,a0
	jsr	IG_Print
.No_class:
	move.w	#208+34,d0
	move.w	#49+14,d1
	jsr	IG_Set_cursor
	lea.l	Age_txt,a0
	jsr	IG_Print
	lea.l	Line_buffer,a0
	move.w	Attr_9_normal(a1),d0
	add.w	$ac(a1),d0	; CHANGE: added
	add.w	Time_data_year,d0	; CHANGE: added
	moveq.l	#3,d7
	movea.l	a0,a3
	bsr.w	LConvert_number
	jsr	IG_Print
	move.w	#208,d0
	move.w	#113,d1
	lea.l	Layout_icn+9856,a0
	jsr	Put_unmasked_block
	lea.l	Objects_icn+12288,a0
	jsr	Put_masked_block
	addi.w	#48,d0
	lea.l	Layout_icn+9856,a0
	jsr	Put_unmasked_block
	lea.l	Objects_icn+13952,a0
	jsr	Put_masked_block
	movea.l	Off_screen,a6
	bsr.w	Show_objects_LAY3
	lea.l	Dialogue_CIL,a0
	bsr.w	DialogueCIL_evaluate
	move.l	a0,Control_list_ptr
	bsr.w	Show_control_icons
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	Lay3_L2,a0
	jsr	Set_layout_data
	lea.l	Lay8_target,a1
	lea.l	Subfade1,a2
.Again_L1:
	lea.l	Hbl_Lay8_list,a0
	jsr	Update_HBL
	jsr	My_vsync
	jsr	My_vsync
	lea.l	Lay8_below,a0
	jsr	Hbl_fade
	bne.s	.Again_L1
	lea.l	Hbl_Lay8_list,a0
	jsr	Update_HBL
	rts	
; ---- Dialogue_DisExit (original source: MAIN/EYE.ASM)
Dialogue_DisExit:
	lea.l	Void,a1
	lea.l	Subfade1,a2
.Again:
	lea.l	Hbl_Lay8_list,a0
	jsr	Update_HBL
	jsr	My_vsync
	jsr	My_vsync
	lea.l	Lay8_below,a0
	jsr	Hbl_fade
	bne.s	.Again
	lea.l	Hbl_Lay8_list,a0
	jsr	Update_HBL
	rts	
; ---- Dialogue_DisUpd (original source: MAIN/EYE.ASM)
Dialogue_DisUpd:
	bsr.w	Update_status_block
	lea.l	Dialogue_CIL,a0
	lea.l	DialogueCIL_evaluate,a1
	bsr.w	Update_control_icons
	movea.l	Current_active_char_data,a1
	movea.l	Off_screen,a6
	moveq.l	#15,d0
	jsr	IG_Set_ink
	moveq.l	#2,d0
	jsr	IG_Set_paper
	move.w	Gold_coins(a1),d0
	moveq.l	#"0",d1
	moveq.l	#5,d7
	lea.l	GoldDis_text,a0
	movea.l	a0,a3
	bsr.w	RConvert_number
	move.w	#224,d0
	move.w	#113+5,d1
	move.w	#32,d2
	bsr.w	Print_centered_string
	move.w	Food_rations(a1),d0
	moveq.l	#"0",d1
	moveq.l	#4,d7
	lea.l	GoldDis_text+1,a0
	movea.l	a0,a3
	bsr.w	RConvert_number
	move.w	#272,d0
	move.w	#113+5,d1
	move.w	#32,d2
	bsr.w	Print_centered_string
	rts	
; ---- DialogueCIL_evaluate (original source: MAIN/EYE.ASM)
DialogueCIL_evaluate:
	movem.l	d0/d7/a1/a2,-(sp)
	movea.l	a0,a2
	moveq.l	#9-1,d7
.Loop0:
	bclr	#7,(a2)+
	dbra	d7,.Loop0
	lea.l	Sold_slots,a1
	move.b	(a1)+,d0
	moveq.l	#11-1,d7
.Loop1:
	and.b	(a1)+,d0
	dbra	d7,.Loop1
	tst.b	d0
	beq.s	.Ok1
	bset	#7,2(a0)
	bset	#7,3(a0)
	bset	#7,4(a0)
	bset	#7,5(a0)
	bset	#7,6(a0)
	bset	#7,7(a0)
	bset	#7,8(a0)
	bra.w	.Ok6
.Ok1:
	lea.l	Sold_slots,a1
	move.b	(a1)+,d0
	moveq.l	#11-1,d7
.Loop2:
	or.b	(a1)+,d0
	dbra	d7,.Loop2
	tst.b	d0
	beq.s	.All_MT
	bset	#7,2(a0)
	bra.s	.Ok2
.All_MT:
	bset	#7,(a0)
	bset	#7,1(a0)
.Ok2:
	movea.l	Current_active_char_data,a1
	lea.l	Inventory_1_place_counter(a1),a2
	move.b	(a2)+,d0
	moveq.l	#11-1,d7
.Loop3:
	or.b	(a2)+,d0
	dbra	d7,.Loop3
	tst.b	d0
	bne.s	.Ok3
	bset	#7,3(a0)
	bset	#7,6(a0)
.Ok3:
	tst.w	Gold_coins(a1)
	bne.s	.Ok4
	bset	#7,7(a0)
.Ok4:
	tst.w	Food_rations(a1)
	bne.s	.Ok5
	bset	#7,8(a0)
.Ok5:
	cmpi.w	#6,Nr_members
	bpl.b	.c_0e57c	; CHANGE: was "bmi.s .Ok6"
	movea.l	Action_ptr,a1	; CHANGE: added
	moveq	#9,d7	; CHANGE: added
.c_0e572:
	cmpi.b	#$6,(a1)+	; CHANGE: added
	beq.b	.Ok6	; CHANGE: added
	dbra	d7,.c_0e572	; CHANGE: added
.c_0e57c:
	bset	#7,5(a0)
.Ok6:
	tst.b	Joined
	beq.s	.Ok7
	bset	#7,3(a0)
	bset	#7,4(a0)
	bset	#7,5(a0)
	bset	#7,6(a0)
	bset	#7,7(a0)
	bset	#7,8(a0)
.Ok7:
	movem.l	(sp)+,d0/d7/a1/a2
	rts	
; ---- DIA_Drop_item (original source: MAIN/EYE.ASM)
DIA_Drop_item:
	lea.l	DIADropItem_Mod,a0
	bra.w	Push_Module
; ---- TIDIA_DisInit (original source: MAIN/EYE.ASM)
DIADropItem_DisInit:
TIDIA_DisInit:
	lea.l	Lay3_L2,a0
	jsr	Push_MA
	movea.l	Off_screen,a6
	move.l	#Code0001Sys,Textfile_ptr
	move.w	#$0,d0	; CHANGE: was "MesMin 4"
	bsr.w	Minus_message
	jsr	Switch_screen
	jsr	Copy_screen
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	rts	
; ---- Do_DIADropItem (original source: MAIN/EYE.ASM)
Do_DIADropItem:
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	tst.b	d0
	beq.s	.Exit
	move.b	d0,Object_slot_number
	lea.l	Sold_slots,a1
	ext.w	d0
	subq.w	#1,d0
	adda.w	d0,a1
	tst.b	(a1)
	beq.s	.Exit
	lea.l	Sold_data,a2
	mulu.w	#40,d0
	adda.w	d0,a2
	btst	#1,Item_stat_bits(a2)
	bne.s	.Droppable
	move.w	#1,d0
	bsr.w	Plus_message
	move.l	#Code0006Sys,Textfile_ptr
	bra.w	Pop_Module
.Droppable:
	move.l	#Code0001Sys,Textfile_ptr
	move.w	#22,ReqText_nr
	move.l	#Really_drop_item,ReqDo_ptr
	lea.l	Req_Mod,a0
	bsr.w	Push_Module
.Exit:
	rts	
; ---- Really_drop_item (original source: MAIN/EYE.ASM)
Really_drop_item:
	move.b	Object_slot_number,d0
	ext.w	d0
	subq.w	#1,d0
	lea.l	Sold_slots,a1
	adda.w	d0,a1
	lea.l	Sold_data,a2
	mulu.w	#40,d0
	adda.w	d0,a2
	clr.b	(a1)
	movea.l	Current_active_char_data,a1
	moveq.l	#0,d0
	move.w	Weight(a2),d0
	sub.l	d0,Weight_normal(a1)
	movea.l	Off_screen,a6
	bsr.w	Show_objects_LAY3
	move.w	#16,d0
	move.w	#72,d1
	move.w	#16+176-1,d2
	move.w	#72+6,d3
	move.w	#2,d6
	jsr	Draw_box
	jsr	Switch_screen
	jsr	Copy_screen
	move.l	#Code0006Sys,Textfile_ptr
	bra.w	Pop_Module
; ---- DIA_Exit (original source: MAIN/EYE.ASM)
DIA_Exit:
	bsr.w	Pop_Module
	bra.w	Init_display
; ---- DIA_Ask_word (original source: MAIN/EYE.ASM)
DIA_Ask_word:
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	lea.l	WSelW_Mod,a0
	move.l	#DIA_Check_answer,Return_ptr(a0)
	bsr.w	Push_Module
	rts	
DIA_Check_answer:
	btst	#$1,Mouse_button_state
	bne.b	DIA_Check_answer
	tst.b	No_word_entered
	bne.b	.l_0e75c
	movea.l	Action_ptr,a0
	movea.l	Act_dat_ptr,a1
	moveq	#0,d0
	move.w	Found_word,d1
	moveq	#9,d7
	cmpi.b	#$1,(a0)+
	bne.b	.l_0e74c
	cmp.w	(a1),d1
	bne.b	.l_0e74c
	moveq	#7,d2
	and.w	d1,d2
	lsr.w	#$3,d1
	lea.l	WD,a0
	bset	d2,(a0,d1.w)
	bsr.w	Do_results
	bra.b	.l_0e75c
.l_0e74c:
	dc.b	$52,$80,$54,$89,$51,$cf,$ff,$da,$30,$3c,$00,$03,$61,$00,$8a,$00
.l_0e75c:
	rts
T_0e75e:
	btst	#$1,Mouse_button_state
	bne.b	T_0e75e
	lea.l	ShowItem_Mod,a0
	bra.w	Push_Module
; ---- ShowItem_DisInit (original source: MAIN/EYE.ASM)
GiveItem_DisInit:
ShowItem_DisInit:
	lea.l	Lay8_PA,a0
	bsr.w	Push_PA
	lea.l	L3_objects_area,a0
	jsr	Push_MA
	movea.l	Current_active_char_data,a0
	lea.l	Inventory_1_place_counter(a0),a1
	lea.l	Inv_data+360(a0),a0
	move.l	a0,Itemdata_ptr
	move.l	a1,Itemslots_ptr
	movea.l	Off_screen,a6
	move.w	#4,d0
	bsr.w	Hash_message
	bsr.w	Show_objects_LAY3
	jsr	Switch_screen
	jsr	Copy_screen
	rts	
; ---- ShowItem_DisExit (original source: MAIN/EYE.ASM)
ShowItem_DisExit:
	move.l	#Sold_data,Itemdata_ptr
	move.l	#Sold_slots,Itemslots_ptr
	movea.l	Off_screen,a6
	bsr.w	Show_objects_LAY3
	bsr.w	Erase_text_window
	jsr	Switch_screen
	jsr	Copy_screen
	jsr	Pop_MA
	bsr.w	Pop_PA
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	rts	
; ---- ShowItem_DisUpd (original source: MAIN/EYE.ASM)
ShowItem_DisUpd:
	bsr.w	Update_status_block
	bsr.w	Update_quantity_colours
	rts	
; ---- ShowItem_objselect (original source: MAIN/EYE.ASM)
ShowItem_objselect:
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	tst.b	d0
	beq.s	.Exit
	move.b	d0,Object_slot_number
	ext.w	d0
	subq.w	#1,d0
	movea.l	Itemslots_ptr,a1
	movea.l	Itemdata_ptr,a2
	adda.w	d0,a1
	mulu.w	#40,d0
	adda.w	d0,a2
	tst.b	(a1)
	beq.s	.Exit
	move.w	Item_ID(a2),d1
	movea.l	Action_ptr,a0
	movea.l	Act_dat_ptr,a1
	moveq.l	#0,d0
	moveq.l	#10-1,d7
.Loop:
	cmpi.b	#2,(a0)+
	bne.s	.Next
	cmp.w	(a1),d1
	bne.s	.Next
	bsr.w	Do_results
	bra.s	.Exit
.Next:
	addq.l	#1,d0
	addq.l	#2,a1
	dbra	d7,.Loop
	move.w	#5,d0
	bsr.w	Plus_message
.Exit:
	bra.w	Pop_Module
; ---- DIA_Give_gold (original source: MAIN/EYE.ASM)
DIA_Give_gold:
	movea.l	Off_screen,a6
	move.l	#Code0001Sys,Textfile_ptr
	move.w	#6,d0
	bsr.w	Minus_message
	jsr	Switch_screen
	jsr	Copy_screen
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	movea.l	Current_active_char_data,a0
	moveq.l	#0,d0
	move.w	Gold_coins(a0),d0
	move.l	d0,Original_number
	clr.l	ItemW_nr
	lea.l	DIATransGold_Mod,a0
	bsr.w	Push_Module
	rts	
; ---- DIATG_Return (original source: MAIN/EYE.ASM)
DIATF_Return:
DIATG_Return:
	move.l	ItemW_nr,d1
	beq.s	.Exit
	movea.l	Action_ptr,a0
	movea.l	Act_dat_ptr,a1
	moveq.l	#0,d0
	moveq.l	#10-1,d7
.Loop:
	cmpi.b	#4,(a0)+
	bne.s	.Next
	cmp.w	(a1),d1
	bmi.s	.No_way
	movea.l	Current_active_char_data,a0
	sub.w	d1,Gold_coins(a0)
	mulu.w	#Gold_weight,d1
	sub.l	d1,Weight_normal(a0)
	bsr.w	Do_results
	bra.s	.Exit
.Next:
	addq.l	#1,d0
	addq.l	#2,a1
	dbra	d7,.Loop
.No_way:
	move.l	#Code0006Sys,Textfile_ptr
	move.w	#7,d0
	bsr.w	Plus_message
.Exit:
	move.l	#Code0006Sys,Textfile_ptr
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	rts	
; ---- DIA_Transfer_item (original source: MAIN/EYE.ASM)
DIA_Transfer_item:
	lea.l	TIDIA_Mod,a0
	bra.w	Push_Module
T_0e93e:
	lea.l	Lay3_L2,a0
	jsr	Push_MA
	movea.l	Off_screen,a6
	move.l	#Code0001Sys,Textfile_ptr
	move.w	#$4,d0
	bsr.w	Minus_message
	jsr	Switch_screen
	jsr	Copy_screen
.l_0e96e:
	btst	#$1,Mouse_button_state
	bne.b	.l_0e96e
	rts
; ---- Do_TIDIA (original source: MAIN/EYE.ASM)
Do_TIDIA:
	tst.b	d0
	bne.s	.A_slot
.Exit:
	bra.w	Pop_Module
.A_slot:
	ext.w	d0
	lea.l	Sold_slots-1,a1
	adda.w	d0,a1
	tst.b	(a1)
	beq.s	.Exit
	lea.l	Sold_data,a2
	moveq.l	#40,d1
	mulu.w	d0,d1
	lea.l	-40(a2,d1.w),a2
	move.b	d0,Object_slot_number
	moveq.l	#0,d0
	move.w	Weight(a2),d0
	btst	#2,Item_stat_bits(a2)
	beq.s	.Single_L1
	move.w	Item_ID(a2),d1
	bra.s	.Continue_L1
.Single_L1:
	moveq.l	#-1,d1
.Continue_L1:
	suba.l	a0,a0
	bsr.w	Scan_4_transfer_victims
	bne.s	.Go_L1
	move.w	#5,d0
	bsr.w	Plus_message
	bsr.w	Pop_Module
	bra.s	.Exit_L1
.Go_L1:
	bsr.w	Show_transfer_victims
	move.b	(a2),TIVS_Icon_nr
	move.l	#DIA_Do_TI,TIVS_Ptr
	lea.l	TIVS2_Mod,a0
	move.w	#24,Mouse_ptr(a0)
	bsr.w	Push_Module
.Exit_L1:
	rts	
; ---- DIA_Do_TI (original source: MAIN/EYE.ASM)
DIA_Do_TI:
	lea.l	Sold_slots,a2
	lea.l	Sold_data,a3
	moveq.l	#0,d0
	move.b	Object_slot_number,d0
	subq.w	#1,d0
	adda.w	d0,a2
	mulu.w	#40,d0
	adda.w	d0,a3
	btst	#2,Item_stat_bits(a3)
	beq.s	.Continue
	lea.l	Inventory_1_place_counter(a0),a4
	lea.l	Inv_data+360(a0),a5
	move.w	Item_ID(a3),d0
	moveq.l	#12-1,d7
.Loop1:
	tst.b	(a4)
	beq.s	.Next1
	cmp.w	Item_ID(a5),d0
	bne.s	.Next1
	cmpi.b	#99,(a4)
	bmi.s	.Do_it
.Next1:
	addq.l	#1,a4
	lea.l	40(a5),a5
	dbra	d7,.Loop1
.Continue:
	lea.l	Inventory_1_place_counter(a0),a4
	lea.l	Inv_data+360(a0),a5
	moveq.l	#12-1,d7
.Loop2:
	tst.b	(a4)
	beq.s	.Do_it
	addq.l	#1,a4
	lea.l	40(a5),a5
	dbra	d7,.Loop2
	bra.s	.Exit
.Do_it:
	moveq.l	#0,d2
	move.w	Weight(a3),d2
	add.l	d2,Weight_normal(a0)
	addq.b	#1,(a4)
	moveq.l	#20-1,d7
.Loop3:
	move.w	(a3)+,(a5)+
	dbra	d7,.Loop3
	lea.l	-40(a3),a3
	clr.b	(a2)
	movea.l	Off_screen,a6
	lea.l	Door_object_pos_list-4,a0
	moveq.l	#0,d0
	move.b	Object_slot_number,d0
	add.w	d0,d0
	add.w	d0,d0
	adda.w	d0,a0
	move.w	(a0)+,d0
	move.w	(a0)+,d1
	lea.l	Layout_icn+9856,a0
	jsr	Put_unmasked_block
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	Sold_slots,a0
	tst.l	(a0)+
	bne.s	.Exit
	tst.l	(a0)+
	bne.s	.Exit
	tst.l	(a0)+
	bne.s	.Exit
	bsr.w	Pop_Module
	move.l	#Code0006Sys,Textfile_ptr
.Exit:
	rts	
; ---- DIA_Give_item (original source: MAIN/EYE.ASM)
DIA_Give_item:
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	lea.l	GiveItem_Mod,a0
	bra.w	Push_Module
T_0eae4:
	lea.l	Lay8_PA,a0
	bsr.w	Push_PA
	lea.l	L3_objects_area,a0
	jsr	Push_MA
	movea.l	Current_active_char_data,a0
	lea.l	$2b(a0),a1
	lea.l	$29a(a0),a0
	move.l	a0,Itemdata_ptr
	move.l	a1,Itemslots_ptr
	movea.l	Off_screen,a6
	move.w	#$6,d0
	bsr.w	Hash_message
	bsr.w	Show_objects_LAY3
	jsr	Switch_screen
	jsr	Copy_screen
	rts
T_0eb34:
	btst	#$1,Mouse_button_state
	bne.b	T_0eb34
	tst.b	d0
	beq.w	.l_0ebc2
	move.b	d0,Object_slot_number
	ext.w	d0
	subq.w	#$1,d0
	movea.l	Itemslots_ptr,a3
	movea.l	Itemdata_ptr,a4
	adda.w	d0,a3
	mulu.w	#$28,d0
	adda.w	d0,a4
	tst.b	(a3)
	beq.b	.l_0ebc2
	move.w	$24(a4),d1
	movea.l	Action_ptr,a0
	movea.l	Act_dat_ptr,a1
	moveq	#0,d0
	moveq	#9,d7
.l_0eb7a:
	cmpi.b	#$3,(a0)+
	bne.b	.l_0ebb2
	cmp.w	(a1),d1
	bne.b	.l_0ebb2
	movea.l	Current_active_char_data,a0
	subq.b	#$1,(a3)
	move.w	$22(a4),d2
	ext.l	d2
	sub.l	d2,Weight_normal(a0)
	movea.l	Off_screen,a6
	bsr.w	Show_objects_LAY3
	jsr	Switch_screen
	jsr	Copy_screen
	bsr.w	Do_results
	bra.b	.l_0ebc2
.l_0ebb2:
	addq.l	#$1,d0
	addq.l	#$2,a1
	dbra	d7,.l_0eb7a
	move.w	#$5,d0
	bsr.w	Plus_message
.l_0ebc2:
	bra.w	Pop_Module
; ---- DIA_Give_food (original source: MAIN/EYE.ASM)
DIA_Give_food:
	movea.l	Off_screen,a6
	move.l	#Code0001Sys,Textfile_ptr
	move.w	#7,d0
	bsr.w	Minus_message
	jsr	Switch_screen
	jsr	Copy_screen
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	movea.l	Current_active_char_data,a0
	moveq.l	#0,d0
	move.w	Food_rations(a0),d0
	move.l	d0,Original_number
	clr.l	ItemW_nr
	lea.l	DIATransFood_Mod,a0
	bsr.w	Push_Module
	rts	
T_0ec18:
	move.l	ItemW_nr,d1
	beq.b	.l_0ec6c
	movea.l	Action_ptr,a0
	movea.l	Act_dat_ptr,a1
	moveq	#0,d0
	moveq	#9,d7
.l_0ec30:
	cmpi.b	#$5,(a0)+
	bne.b	.l_0ec52
	cmp.w	(a1),d1
	bmi.b	.l_0ec5a
	movea.l	Current_active_char_data,a0
	sub.w	d1,Food_rations(a0)
	mulu.w	#$fa,d1
	sub.l	d1,Weight_normal(a0)
	bsr.w	Do_results
	bra.b	.l_0ec6c
.l_0ec52:
	addq.l	#$1,d0
	addq.l	#$2,a1
	dbra	d7,.l_0ec30
.l_0ec5a:
	move.l	#Code0006Sys,Textfile_ptr
	move.w	#$8,d0
	bsr.w	Plus_message
.l_0ec6c:
	move.l	#Code0006Sys,Textfile_ptr
.l_0ec76:
	btst	#$1,Mouse_button_state
	bne.b	.l_0ec76
	rts
T_0ec82:
	btst	#$1,Mouse_button_state
	bne.b	T_0ec82
	move.w	#$0,Draw_Cicon
	jsr	My_vsync
	movea.l	Dialogue_chard_ptr,a0
	moveq	#0,d0
	move.b	Join_percentage_chance(a0),d0
	beq.b	.l_0ecb4
	cmpi.w	#$64,d0
	beq.b	.l_0ecbe
	bsr.w	Probe
	bpl.b	.l_0ecbe
.l_0ecb4:
	move.w	#$9,d0
	bsr.w	Plus_message
	rts
.l_0ecbe:
	lea.l	Chard_ptrs,a1
	moveq	#0,d0
	moveq	#5,d7
.l_0ecc8:
	tst.l	(a1)
	beq.b	.l_0ecd8
	addq.l	#$4,a1
	addq.w	#$1,d0
	dbra	d7,.l_0ecc8
	bra.w	.l_0ed82
.l_0ecd8:
	move.l	a0,(a1)
	move.w	Map_nr,d7
	subq.w	#$1,d7
	mulu.w	#$18,d7
	add.w	Dialogue_VChar_index,d7
	addq.w	#$1,d7
	move.w	d7,Person_save_bit_pos(a0)
	move.w	d0,-(a7)
	lea.l	Member_1_nr,a0
	add.w	d0,d0
	move.w	Dialogue_char_nr,(a0,d0.w)
	move.l	CD_value,d0
	move.w	Dialogue_VChar_index,d1
	bset	d1,d0
	move.l	d0,CD_value
	lea.l	CD,a0
	move.w	d7,d0
	lsr.w	#$3,d0
	adda.w	d0,a0
	andi.w	#$7,d7
	bset	d7,(a0)
	addq.w	#$1,Nr_members
	lea.l	B_5eed0,a0
	moveq	#0,d0
	moveq	#5,d7
.l_0ed3a:
	move.b	(a0)+,d1
	bset	d1,d0
	dbra	d7,.l_0ed3a
	moveq	#11,d7
.l_0ed44:
	btst	d7,d0
	beq.b	.l_0ed4c
	dbra	d7,.l_0ed44
.l_0ed4c:
	lea.l	B_5eed0,a0
	move.w	(a7)+,d0
	move.b	d7,(a0,d0.w)
	st.b	Joined
	movea.l	Action_ptr,a0
	movea.l	Act_dat_ptr,a1
	moveq	#0,d0
	moveq	#9,d7
.l_0ed6e:
	cmpi.b	#$6,(a0)+
	bne.b	.l_0ed7a
	bsr.w	Do_results
	bra.b	.l_0ed82
.l_0ed7a:
	addq.l	#$1,d0
	addq.l	#$2,a1
	dbra	d7,.l_0ed6e
.l_0ed82:
	rts
; ---- Do_results (original source: MAIN/EYE.ASM)
Do_results:
	movem.l	d0/d7/a0-a4,-(sp)
	movea.l	Result_ptr,a0
	movea.l	Res_dat1_ptr,a1
	movea.l	Res_dat2_ptr,a2
	movea.l	Res_dat3_ptr,a3
	mulu.w	#5,d0
	adda.w	d0,a0
	adda.w	d0,a1
	adda.w	d0,a2
	adda.w	d0,a3
	adda.w	d0,a3
	moveq.l	#0,d0
	moveq.l	#5-1,d7
.Loop:
	move.b	(a0)+,d0
	beq.s	.Exit
	add.w	d0,d0
	add.w	d0,d0
	movea.l	Results-4(pc,d0.w),a4
	movem.l	d0-d7/a0-a6,-(sp)
	jsr	(a4)
	movem.l	(sp)+,d0-d7/a0-a6
	addq.l	#1,a1
	addq.l	#1,a2
	addq.l	#2,a3
	dbra	d7,.Loop
.Exit:
	movem.l	(sp)+,d0/d7/a0-a4
	rts	
Results:
	dc.l	Text_res,Word_res,Item_res,Gold_res,Food_res
	dc.l	Quest_res,Data_res
; ---- Text_res (original source: MAIN/EYE.ASM)
Text_res:
	lea.l	Lay8_PlusMes,a0
	jsr	Push_MA
	lea.l	Lay8_PA,a0
	bsr.w	Push_PA
	move.w	(a3),d0
	movea.l	Dialogue_text_ptr,a1
	bsr.w	Mr_Blue_Sky
	bsr.w	Pop_PA
	jsr	Pop_MA
.c_0ee20:
	btst	#$1,Mouse_button_state	; CHANGE: added
	bne.b	.c_0ee20	; CHANGE: added
	rts	
; ---- Word_res (original source: MAIN/EYE.ASM)
Word_res:
	move.w	(a3),d0
	move.w	d0,d1
	andi.w	#7,d1
	lsr.w	#3,d0
	lea.l	WD,a0
	bset	d1,0(a0,d0.w)
	rts	
; ---- Item_res (original source: MAIN/EYE.ASM)
Item_res:
	movea.l	Dialogue_chard_ptr,a0
	lea.l	Inv_data-40(a0),a0
	move.w	(a3),d0
	mulu.w	#40,d0
	adda.w	d0,a0
	lea.l	Sold_slots,a1
	moveq.l	#0,d1
	moveq.l	#12-1,d7
.Loop1:
	tst.b	0(a1,d1.w)
	beq.s	.Found
	addq.l	#1,d1
	dbra	d7,.Loop1
	lea.l	ET_Item_res_1,a1	; ERROR "[ Item_res ] : Logical error ! Contact the game designer !"
	jsr	DI_Error
	bra.s	.Exit
.Found:
	move.b	#1,0(a1,d1.w)
	lea.l	Sold_data,a1
	mulu.w	#40,d1
	adda.w	d1,a1
	moveq.l	#10-1,d7
.Loop2:
	move.l	(a0)+,(a1)+
	dbra	d7,.Loop2
	movea.l	Off_screen,a6
	bsr.w	Show_objects_LAY3
	jsr	Switch_screen
	jsr	Copy_screen
.Exit:
	rts	
; ---- Gold_res (original source: MAIN/EYE.ASM)
Gold_res:
	move.w	(a3),d0
	bra.w	Divide_gold
; ---- Food_res (original source: MAIN/EYE.ASM)
Food_res:
	move.w	(a3),d0
	bra.w	T_0cbee	; CHANGE: was "jmp Divide_food"
; ---- Quest_res (original source: MAIN/EYE.ASM)
Quest_res:
	move.w	(a3),d0
	move.w	d0,d1
	andi.w	#7,d1
	lsr.w	#3,d0
	lea.l	Quest,a0
	bset	d1,0(a0,d0.w)
	bsr.w	Set_interaction_ptrs
	rts	
Data_res:
	movea.l	Current_active_char_data,a0
	moveq	#0,d0
	move.b	(a1),d0
	adda.w	d0,a0
	moveq	#0,d1
	move.b	(a2),d1
	add.w	d1,d1
	add.w	d1,d1
T_0eee4:
	movea.l	T_0eee4+2(pc,d1.w),a4
	jmp	(a4)
	dc.l	.l_0eefe
	dc.l	.l_0ef42
	dc.l	.l_0ef7a
	dc.l	.l_0ef80
	dc.l	.l_0ef86
.l_0eefe:
	move.w	(a3),d1
	ext.l	d1
	cmpi.w	#$46,d0
	bpl.b	.l_0ef1c
	moveq	#0,d0
	move.b	(a0),d0
	add.w	d1,d0
	cmpi.w	#$100,d0
	bmi.b	.l_0ef18
	move.w	#$ff,d0
.l_0ef18:
	move.b	d0,(a0)
	bra.b	.l_0ef40
.l_0ef1c:
	cmpi.w	#$cc,d0
	bpl.b	.l_0ef32
	moveq	#0,d0
	move.w	(a0),d0
	add.w	d1,d0
	bvc.b	.l_0ef2e
	move.w	#$7fff,d0
.l_0ef2e:
	move.w	d0,(a0)
	bra.b	.l_0ef40
.l_0ef32:
	dc.b	$20,$10,$d0,$81,$68,$06,$20,$3c,$7f,$ff,$ff,$ff,$20,$80
.l_0ef40:
	rts
.l_0ef42:
	move.w	(a3),d1
	ext.l	d1
	cmpi.w	#$46,d0
	bpl.b	.l_0ef5a
	moveq	#0,d0
	move.b	(a0),d0
	sub.b	d1,d0
	bpl.b	.l_0ef56
	moveq	#0,d0
.l_0ef56:
	move.b	d0,(a0)
	bra.b	.l_0ef78
.l_0ef5a:
	cmpi.w	#$cc,d0
	bpl.b	.l_0ef6e
	moveq	#0,d0
	move.w	(a0),d0
	sub.w	d1,d0
	bpl.b	.l_0ef6a
	moveq	#0,d0
.l_0ef6a:
	move.w	d0,(a0)
	bra.b	.l_0ef78
.l_0ef6e:
	dc.b	$20,$10,$90,$81,$6a,$02,$70,$00,$20,$80
.l_0ef78:
	rts
.l_0ef7a:
	move.w	(a3),d1
	bclr	d1,(a0)
	rts
.l_0ef80:
	move.w	(a3),d1
	bset	d1,(a0)
	rts
.l_0ef86:
	move.w	(a3),d1
	bchg	d1,(a0)
	rts
T_0ef8c:
	tst.b	Print_objname_flag
	beq.b	.l_0efde
	lea.l	.l_0efe0(pc),a0
	jsr	IG_Print
	move.w	Object_name_nr,d0
	beq.b	.l_0efde
	bsr.w	Get_word
	move.w	#$10,d0
	move.w	#$48,d1
	move.w	#$bf,d2
	move.w	#$4e,d3
	move.w	#$2,d6
	movea.l	Off_screen,a6
	jsr	Draw_box
	move.w	#$b0,d2
	lea.l	Line_buffer,a0
	bsr.w	Print_centered_string
	subq.b	#$1,Print_objname_flag
.l_0efde:
	rts
.l_0efe0:
	dc.b	$01,$0f,$02,$ff,$00,$00
T_0efe6:
	tst.b	Erase_objname_flag
	beq.b	.l_0f01a
	move.w	#$10,d0
	move.w	#$48,d1
	move.w	#$bf,d2
	move.w	#$4e,d3
	move.w	#$2,d6
	movea.l	Off_screen,a6
	jsr	Draw_box
	subq.b	#$1,Erase_objname_flag
	clr.w	Object_name_nr
.l_0f01a:
	rts
Change_travelmode:
	movem.l	d0-d1/a0,-(a7)
	tst.w	Travel_mode
	beq.w	.l_0f0c8
	cmpi.w	#$4,Travel_mode
	beq.w	.l_0f0ba
	cmpi.w	#$5,Travel_mode
	bne.b	.l_0f064
	moveq	#0,d0
	jsr	Set_new_travel_mode
	jsr	W2_DisUpd
	jsr	Switch_screen
	lea.l	D_304ae,a0
	bsr.w	Push_Module
	bsr.w	Event_handler
	bra.b	.l_0f0de
.l_0f064:
	cmpi.w	#$6,Travel_mode
	beq.b	.l_0f0ba
	lea.l	Trans_T,a0
	moveq	#29,d1
.l_0f076:
	tst.b	(a0,d1.w)
	bne.b	.l_0f0a8
	move.w	Travel_mode,d0
	move.b	d0,(a0,d1.w)
	move.w	Map_Xcoord,d0
	move.b	d0,$1e(a0,d1.w)
	move.w	Map_Ycoord,d0
	move.b	d0,$3c(a0,d1.w)
	lea.l	$5a(a0,d1.w),a0
	move.w	Map_nr,(a0,d1.w)
	bra.b	.l_0f0ba
.l_0f0a8:
	subq.w	#$1,d1
	bpl.b	.l_0f076
	lea.l	D_31f1d,a1
	jsr	DI_Error
	bra.b	.l_0f0de
.l_0f0ba:
	moveq	#0,d0
	jsr	Set_new_travel_mode
	bsr.w	Event_handler
	bra.b	.l_0f0de
.l_0f0c8:
	jsr	Seek_transport
	lea.l	Trans_T,a0
	clr.b	(a0,d1.w)
	jsr	Set_new_travel_mode
.l_0f0de:
	btst	#$1,Mouse_button_state
	bne.b	.l_0f0de
	movem.l	(a7)+,d0-d1/a0
	rts
; ---- Automapper (original source: MAIN/EYE.ASM)
Automapper:
	bsr.w	Exit_display
	lea.l	Automap_Mod,a0
	bsr.w	Push_Module
	rts	
; ---- Automap_DisUpd (original source: MAIN/EYE.ASM)
Automap_DisUpd:
	jsr	Update_status_block
	movea.l	Off_screen,a6
	move.w	Width_of_map,d5
	movea.l	Automapicon_ptr,a0
	move.w	Automap_Y,d0
	subq.w	#1,d0
	mulu.w	d5,d0
	add.w	Automap_X,d0
	subq.w	#1,d0
	adda.w	d0,a0
	moveq.l	#0,d1
	moveq.l	#0,d2
	move.w	Automap_height,d7
	subq.w	#1,d7
.Loop1:
	movea.l	a0,a1
	moveq.l	#0,d0
	move.w	Automap_width,d6
	subq.w	#1,d6
.Loop2:
	move.b	(a1)+,d2
	bsr.w	Display_automap_icon
	addq.w	#1,d0
	dbra	d6,.Loop2
	addq.w	#1,d1
	adda.w	d5,a0
	dbra	d7,.Loop1
	rts	
Automap_ModInit:
	lea.l	Automap_CIL,a0
	moveq	#8,d7
.l_0f160:
	bclr	#$7,(a0)+
	dbra	d7,.l_0f160
	lea.l	-$9(a0),a0
	move.w	#$6,Automap_X
	move.w	#$6,Automap_Y
	move.w	#$16,Automap_width
	move.w	#$12,Automap_height
	move.w	Width_of_map,d0
	subi.w	#$a,d0
	cmpi.w	#$16,d0
	bpl.b	.l_0f1c6
	move.w	d0,Automap_width
	bset	#$7,(a0)
	bset	#$7,$2(a0)
	bset	#$7,$3(a0)
	bset	#$7,$5(a0)
	bset	#$7,$6(a0)
	bset	#$7,$8(a0)
	bra.b	.l_0f1f2
.l_0f1c6:
	move.w	Map_Xcoord,d0
	subi.w	#$a,d0
	cmpi.w	#$6,d0
	bmi.b	.l_0f1f2
	moveq	#27,d1
	add.w	d0,d1
	cmp.w	Width_of_map,d1
	bmi.b	.l_0f1ec
	move.w	Width_of_map,d0
	subi.w	#$1a,d0
.l_0f1ec:
	move.w	d0,Automap_X
.l_0f1f2:
	move.w	Height_of_map,d0
	subi.w	#$a,d0
	cmpi.w	#$12,d0
	bpl.b	.l_0f22e
	move.w	d0,Automap_height
	bset	#$7,$0(a0)
	bset	#$7,$1(a0)
	bset	#$7,$2(a0)
	bset	#$7,$6(a0)
	bset	#$7,$7(a0)
	bset	#$7,$8(a0)
	bra.b	.l_0f258
.l_0f22e:
	move.w	Map_Ycoord,d0
	subq.w	#$8,d0
	cmpi.w	#$6,d0
	bmi.b	.l_0f258
	moveq	#23,d1
	add.w	d0,d1
	cmp.w	Height_of_map,d1
	bmi.b	.l_0f252
	move.w	Height_of_map,d0
	subi.w	#$16,d0
.l_0f252:
	move.w	d0,Automap_Y
.l_0f258:
	move.w	Size_of_map,d0
	ext.l	d0
	jsr	Allocate_memory
	move.l	a1,Automapicon_ptr
	movea.l	Automap_ptr,a0
	movea.l	Map_pointer,a2
	movea.l	Iconstats_ptr,a3
	movea.l	Mapd_ptr,a4
	lea.l	$1e(a4),a4
	moveq	#0,d4
	moveq	#0,d5
	move.w	Size_of_map,d6
	move.w	d6,d7
	subq.w	#$1,d7
T_0f296:
	moveq	#0,d0
	btst	d4,(a0,d5.w)
	beq.b	T_0f2f4
	moveq	#0,d0
	move.b	(a2,d6.w),d0
	beq.b	T_0f2ce
	mulu.w	#$a,d0
	move.b	(a4,d0.w),d0
	ext.w	d0
	move.b	T_0f2b8+1(pc,d0.w),d0
	bmi.b	T_0f2ce
	ext.w	d0
T_0f2b8:
	bra.b	T_0f2f4
	dc.b	$04,$03,$ff,$05,$ff,$08,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$06,$ff,$ff
	dc.b	$ff,$07,$ff,$03
T_0f2ce:
	moveq	#0,d0
	move.b	(a2),d0
	beq.b	T_0f2f4
	subq.w	#$1,d0
	add.w	d0,d0
	add.w	d0,d0
	move.l	(a3,d0.w),d0
	btst	#$5,d0
	beq.b	.l_0f2e8
	bchg	#$7,d0
.l_0f2e8:
	btst	#$7,d0
	bne.b	.l_0f2f2
	moveq	#2,d0
	bra.b	T_0f2f4
.l_0f2f2:
	moveq	#1,d0
T_0f2f4:
	move.b	d0,(a1)
	addq.w	#$1,d4
	cmpi.w	#$8,d4
	bmi.b	.l_0f302
	moveq	#0,d4
	addq.w	#$1,d5
.l_0f302:
	addq.l	#$1,a1
	addq.l	#$1,a2
	dbra	d7,T_0f296
	movea.l	Automapicon_ptr,a0
	move.w	Map_Ycoord,d0
	subq.w	#$1,d0
	mulu.w	Width_of_map,d0
	add.w	Map_Xcoord,d0
	subq.w	#$1,d0
	btst	#$0,B_5c36b
	beq.b	.l_0f33a
	moveq	#10,d1
	add.w	View_direction,d1
	bra.b	.l_0f33c
.l_0f33a:
	moveq	#9,d1
.l_0f33c:
	move.b	d1,(a0,d0.w)
	move.w	d1,Party_automap_icon
	bra.w	Init_display
; ---- Automap_ModExit (original source: MAIN/EYE.ASM)
Automap_ModExit:
	movea.l	Automapicon_ptr,a0
	jsr	Free_memory
	bra.w	Automap_DisExit
; ---- Automap_DisInit (original source: MAIN/EYE.ASM)
Automap_DisInit:
	movea.l	Off_screen,a6
	moveq.l	#11,d0
	jsr	Show_layout
	movea.l	Mapd_ptr,a5
	jsr	Print_headline
	move.w	#208,d0
	move.w	#49,d1
	moveq.l	#8-1,d5
	moveq.l	#1,d6
	moveq.l	#8,d7
	lea.l	Automap_icn+64,a0
.Loop:
	jsr	Blot_unmasked_block
	addi.w	#9,d1
	lea.l	64(a0),a0
	dbra	d5,.Loop
	lea.l	Automap_icn,a0
	move.w	Party_automap_icon,d2
	lsl.w	#6,d2
	adda.w	d2,a0
	jsr	Blot_unmasked_block
	move.w	#208+8,d0
	move.w	#49,d1
	move.w	#208+15,d2
	move.w	#49+80,d3
	moveq.l	#2,d6
	jsr	Draw_box
	move.w	#208+14,d0
	move.w	#49+1,d1
	move.w	#12,d2
	moveq.l	#9-1,d7
	lea.l	Line_buffer,a0
	lea.l	Code0006Sys,a1
.Loop_L1:
	jsr	IG_Set_cursor
	exg.l	d2,d0	; CHANGE: was "exg.l d0,d2"
	jsr	Convert_text_line
	exg.l	d2,d0	; CHANGE: was "exg.l d0,d2"
	jsr	IG_Print
	addi.w	#9,d1
	addq.w	#1,d2
	dbra	d7,.Loop_L1
	moveq.l	#15,d0
	jsr	IG_Set_ink
	moveq.l	#-1,d0
	jsr	IG_Set_paper
	moveq.l	#11,d0
	jsr	Convert_text_line
	move.w	#208,d0
	move.w	#39,d1
	move.w	#96,d2
	lea.l	Line_buffer,a0
	jsr	Print_centered_string
	move.l	#Automap_CIL,Control_list_ptr
	jsr	Show_control_icons
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	Control_area,a0
	jsr	Set_layout_data
	lea.l	Lay11_target,a1
	lea.l	Subfade1,a2
.Again_L2:
	lea.l	Hbl_Lay11_list,a0
	jsr	Update_HBL
	jsr	My_vsync
	jsr	My_vsync
	lea.l	Lay11_below,a0
	jsr	Fade_pal
	bne.s	.Again_L2
	lea.l	Hbl_Lay11_list,a0
	jsr	Update_HBL
	rts	
; ---- Automap_DisExit (original source: MAIN/EYE.ASM)
Automap_DisExit:
	lea.l	Void,a1
	lea.l	Subfade1,a2
.Again:
	lea.l	Hbl_Lay11_list,a0
	jsr	Update_HBL
	jsr	My_vsync
	jsr	My_vsync
	lea.l	Lay11_below,a0
	jsr	Fade_pal
	bne.s	.Again
	lea.l	Hbl_Lay11_list,a0
	jsr	Update_HBL
	rts	
; ---- Automap_exit (original source: MAIN/EYE.ASM)
Automap_exit:
	bsr.w	Pop_Module
	bra.w	Init_display
; ---- Automap_up (original source: MAIN/EYE.ASM)
Automap_up:
	move.w	Automap_Y,d0
	subq.w	#1,d0
	cmpi.w	#6,d0
	bmi.s	.Exit
	move.w	d0,Automap_Y
.Exit:
	rts	
; ---- Automap_left (original source: MAIN/EYE.ASM)
Automap_left:
	move.w	Automap_X,d0
	subq.w	#1,d0
	cmpi.w	#6,d0
	bmi.s	.Exit
	move.w	d0,Automap_X
.Exit:
	rts	
; ---- Automap_right (original source: MAIN/EYE.ASM)
Automap_right:
	move.w	Automap_X,d0
	addq.w	#1,d0
	move.w	Width_of_map,d1
	subi.w	#25,d1
	cmp.w	d1,d0
	bpl.s	.Exit
	move.w	d0,Automap_X
.Exit:
	rts	
; ---- Automap_down (original source: MAIN/EYE.ASM)
Automap_down:
	move.w	Automap_Y,d0
	addq.w	#1,d0
	move.w	Height_of_map,d1
	subi.w	#21,d1
	cmp.w	d1,d0
	bpl.s	.Exit
	move.w	d0,Automap_Y
.Exit:
	rts	
; ---- Automap_upleft (original source: MAIN/EYE.ASM)
Automap_upleft:
	bsr.w	Automap_up
	bra.w	Automap_left
; ---- Automap_upright (original source: MAIN/EYE.ASM)
Automap_upright:
	bsr.w	Automap_up
	bra.w	Automap_right
; ---- Automap_downleft (original source: MAIN/EYE.ASM)
Automap_downleft:
	bsr.w	Automap_down
	bra.w	Automap_left
; ---- Automap_downright (original source: MAIN/EYE.ASM)
Automap_downright:
	bsr.w	Automap_down
	bra.w	Automap_right
; ---- Display_automap_icon (original source: MAIN/EYE.ASM)
Display_automap_icon:
	movem.l	d0-d3/d7/a0/a1,-(sp)
	lea.l	Automap_icn,a0
	lsl.w	#6,d2
	adda.w	d2,a0
	lsl.w	#3,d0
	addi.w	#16,d0
	lsl.w	#3,d1
	addi.w	#49,d1
	jsr	Coord_convert
	lea.l	0(a6,d2.w),a1
	tst.w	d3
	bne.s	.Right
	move.l	#$00ff00ff,d2
	moveq.l	#8-1,d7
.Loop1:
	move.l	(a0)+,d0
	move.l	(a0)+,d1
	and.l	d2,(a1)
	or.l	d0,(a1)
	and.l	d2,4(a1)
	or.l	d1,4(a1)
	lea.l	160(a1),a1
	dbra	d7,.Loop1
	bra.s	.Exit
.Right:
	move.l	#$ff00ff00,d2
	moveq.l	#8-1,d7
.Loop2:
	move.l	(a0)+,d0
	move.l	(a0)+,d1
	ror.l	d3,d0
	ror.l	d3,d1
	and.l	d2,(a1)
	or.l	d0,(a1)
	and.l	d2,4(a1)
	or.l	d1,4(a1)
	lea.l	160(a1),a1
	dbra	d7,.Loop2
.Exit:
	movem.l	(sp)+,d0-d3/d7/a0/a1
	rts	
; ---- Init_automap (original source: MAIN/EYE.ASM)
Init_automap:
	movem.l	d0/a0,-(sp)
	lea.l	Automap_filename,a0
	move.w	Map_nr,d0
	jsr	Load_subfile
	move.l	a0,Automap_ptr
	movem.l	(sp)+,d0/a0
	rts	
Exit_automap:
	move.l	a0,-(a7)
	bsr.w	T_0f616
	movea.l	Automap_ptr,a0
	jsr	Free_memory
	movea.l	(a7)+,a0
	rts
T_0f616:
	movem.l	d0/a0-a1,-(a7)
	lea.l	Automap_filename,a0
	movea.l	Automap_ptr,a1
	move.w	Map_nr,d0
	jsr	Save_subfile
	movem.l	(a7)+,d0/a0-a1
	rts
; ---- Update_automap (original source: MAIN/EYE.ASM)
Update_automap:
	movem.l	d0-d3/d7/a0/a1,-(sp)
	tst.b	Stygian
	bne.s	.Exit
	move.w	Map_Xcoord,d2
	move.w	Map_Ycoord,d3
	subq.w	#1,d2
	subq.w	#1,d3
	movea.l	Automap_ptr,a0
	lea.l	Cut_table,a1
	moveq.l	#9-1,d7
.Loop:
	move.b	(a1)+,d0
	ext.w	d0
	add.w	d2,d0
	move.b	(a1)+,d1
	ext.w	d1
	add.w	d3,d1
	bsr.w	Set_automap_bit
	dbra	d7,.Loop
.Exit:
	movem.l	(sp)+,d0-d3/d7/a0/a1
	rts	
; ---- Set_automap_bit (original source: MAIN/EYE.ASM)
Set_automap_bit:
	movem.l	d0/d1,-(sp)
	mulu.w	Width_of_map,d1
	add.w	d0,d1
	moveq.l	#7,d0
	and.w	d1,d0
	lsr.w	#3,d1
	bset	d0,0(a0,d1.w)
	movem.l	(sp)+,d0/d1
	rts	
; ---- Options_menu (original source: MAIN/EYE.ASM)
Options_menu:
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	bsr.w	Exit_display
	lea.l	Options_Mod,a0
	bra.w	Push_Module
; ---- Options_DisUpd (original source: MAIN/EYE.ASM)
Options_DisUpd:
	jsr	Update_status_block
	lea.l	Options_CIL,a0
	lea.l	OptionsCIL_evaluate,a1
	bsr.w	Update_control_icons
	rts	
; ---- Options_DisInit (original source: MAIN/EYE.ASM)
Options_DisInit:
	movea.l	Off_screen,a6
	moveq.l	#6,d0
	jsr	Show_layout
	lea.l	Options_CIL,a0
	bsr.w	OptionsCIL_evaluate
	move.l	a0,Control_list_ptr
	jsr	Show_control_icons
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	Control_area,a0
	jsr	Set_layout_data
	lea.l	Lay6_target,a1
	lea.l	Subfade1,a2
.Again:
	lea.l	Hbl_Lay6_list,a0
	jsr	Update_HBL
	jsr	My_vsync
	jsr	My_vsync
	lea.l	Lay6_below,a0
	jsr	Fade_pal
	bne.s	.Again
	lea.l	Hbl_Lay6_list,a0
	jsr	Update_HBL
	rts	
T_0f744:
	lea.l	Void,a1
	lea.l	Subfade1,a2
.l_0f750:
	lea.l	Hbl_Lay6_list,a0
	jsr	Update_HBL
	jsr	My_vsync
	jsr	My_vsync
	lea.l	Lay6_below,a0
	jsr	Fade_pal
	bne.b	.l_0f750
	lea.l	Hbl_Lay6_list,a0
	jsr	Update_HBL
	rts
; ---- OptionsCIL_evaluate (original source: MAIN/EYE.ASM)
OptionsCIL_evaluate:
	tst.w	Music_block
	beq.s	.On
	bclr	#7,3(a0)
	bset	#7,4(a0)
	bra.s	.Exit
.On:
	bset	#7,3(a0)
	bclr	#7,4(a0)
.Exit:
	rts	
; ---- Exit_options (original source: MAIN/EYE.ASM)
Exit_options:
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	bsr.w	Pop_Module
	bra.w	Init_display
; ---- Music_on (original source: MAIN/EYE.ASM)
Music_on:
	clr.w	Music_block
	rts	
; ---- Music_off (original source: MAIN/EYE.ASM)
Music_off:
	move.w	#$ffff,Music_block	; CHANGE: was "move.w #-1,Music_block"
	move.l	#$700ff00,$ffff8800.w	; CHANGE: added
	rts	
; ---- Quit_game (original source: MAIN/EYE.ASM)
Quit_game:
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	move.l	#Code0008Sys,Textfile_ptr
	move.w	#8,ReqText_nr
	move.l	#T_0f804,ReqDo_ptr	; CHANGE: was "move.l #Exit_all,ReqDo_ptr"
	lea.l	Req_Mod,a0
	bra.w	Push_Module
T_0f804:
	bsr.w	Exit_display
	cmpi.b	#$2,Current_map_type
	bmi.b	.l_0f81c
	jsr	T_0025a
	bsr.w	T_0f616
.l_0f81c:
	jmp	Exit_all
T_0f822:
	btst	#$1,Mouse_button_state
	bne.b	T_0f822
	clr.w	SaveGame_bitlist
	lea.l	B_600e6,a0
	moveq	#4,d7
.l_0f83a:
	tst.l	(a0)+
	bne.b	.l_0f86a
	dbra	d7,.l_0f83a
	move.l	#Code0004Sys,Textfile_ptr
	move.w	#$18,ReqText_nr
	move.l	#T_0f9c6,ReqDo_ptr
	lea.l	Req_Mod,a0
	bsr.w	Push_Module
	bra.b	.l_0f874
.l_0f86a:
	lea.l	SaveGame_Mod,a0
	bsr.w	Push_Module
.l_0f874:
	rts
SaveGame_ModInit:
	move.l	#Lay6_PlusMes,PlusMes_info
	move.l	#Code0005Sys,Textfile_ptr
	lea.l	D_293b0,a0
	jsr	Push_MA
	moveq	#-1,d0
	jsr	IG_Set_paper
	lea.l	B_600e6,a1
	lea.l	Portrait_pos_list,a2
	movea.l	Off_screen,a6
	moveq	#2,d5
	moveq	#2,d6
	moveq	#34,d7
.l_0f8b6:
	tst.l	(a1)
	beq.b	.l_0f8f6
	movea.l	(a1),a3
	move.w	(a2),d0
	move.w	$2(a2),d1
	lea.l	$6b0(a3),a0
	jsr	Blot_unmasked_block
	move.w	$4(a2),d0
	move.w	$6(a2),d1
	jsr	IG_Set_cursor
	moveq	#9,d0
	cmp.w	Active_member,d5
	bne.b	.l_0f8e6
	moveq	#8,d0
.l_0f8e6:
	jsr	IG_Set_ink
	lea.l	$f0(a3),a0
	jsr	IG_Print
.l_0f8f6:
	addq.l	#$4,a1
	addq.l	#$8,a2
	addq.w	#$1,d5
	cmpi.w	#$7,d5
	bmi.b	.l_0f8b6
	move.w	#$80,d0
	move.w	#$b0,d1
	moveq	#2,d6
	moveq	#16,d7
	lea.l	D_3e9ea,a0
	jsr	Blot_unmasked_block
	move.w	#$a0,d0
	move.w	#$b0,d1
	moveq	#2,d6
	moveq	#16,d7
	lea.l	D_3ccea,a0
	jsr	Blot_unmasked_block
	move.w	#$14,d0
	jsr	Hash_message
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	D_32588,a0
	jsr	Push_Root
	rts
; ---- SaveGame_ModExit (original source: MAIN/EYE.ASM)
SaveGame_ModExit:
	movea.l	Off_screen,a6
	lea.l	Lay6_PA,a0
	jsr	Push_PA
	jsr	Erase_text_window
	jsr	Pop_PA
	move.w	#16,d0
	move.w	#49,d1
	move.w	#191,d2
	move.w	#191,d3
	moveq.l	#2,d6
	jsr	Draw_box
	jsr	Switch_screen
	jsr	Copy_screen
	jsr	Pop_Root
	jsr	Pop_MA
	rts	
; ---- Exit_SaveGame (original source: MAIN/EYE.ASM)
Exit_SaveGame:
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	bsr.w	Pop_Module
	bra.w	Init_display
T_0f9b8:
	btst	#$1,Mouse_button_state
	bne.b	T_0f9b8
	bsr.w	Pop_Module
T_0f9c6:
	cmpi.b	#$2,Current_map_type
	bne.b	.l_0f9d4
	bsr.w	T_0f616
.l_0f9d4:
	lea.l	Chard_filename,a0
	lea.l	Chard_ptrs,a2
	lea.l	Member_1_nr,a3
	moveq	#5,d7
.l_0f9e8:
	tst.l	(a2)
	beq.b	.l_0f9f6
	move.w	(a3),d0
	movea.l	(a2),a1
	jsr	Save_subfile
.l_0f9f6:
	addq.l	#$4,a2
	addq.l	#$2,a3
	dbra	d7,.l_0f9e8
	lea.l	B_600e6,a1
	lea.l	B_5c380,a2
	lea.l	B_5bef3,a3
	move.w	SaveGame_bitlist,d0
	moveq	#1,d7
.l_0fa18:
	btst	d7,d0
	beq.b	.l_0fa50
	movea.l	(a1),a0
	move.w	$c4(a0),d2
	lea.l	CD,a0
	move.w	d2,d3
	lsr.w	#$3,d2
	andi.w	#$7,d3
	bclr	d3,(a0,d2.w)
	movea.l	(a1),a0
	jsr	Kill_memory
	clr.l	(a1)
	clr.w	(a2)
	clr.b	(a3)
	clr.b	$6(a3)
	clr.b	$c(a3)
	subq.w	#$1,Nr_members
.l_0fa50:
	addq.l	#$4,a1
	addq.l	#$2,a2
	addq.l	#$1,a3
	addq.w	#$1,d7
	cmpi.w	#$7,d7
	bmi.b	.l_0fa18
	jsr	Update_status_block
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	B_5d421,a0
	move.w	Map_nr,d0
	add.w	d0,d0
	add.w	Map_nr,d0
	adda.w	d0,a0
	moveq	#1,d0
	and.b	$3(a0),d0
	lsl.w	#$8,d0
	move.b	$2(a0),d0
	swap	d0
	move.b	$1(a0),d0
	lsl.w	#$8,d0
	move.b	(a0),d0
	lsr.l	#$1,d0
	move.l	d0,CD_value
	moveq	#0,d0
	move.w	Nr_of_modifications,d0
	mulu.w	#$6,d0
	addi.l	#$2b7e,d0
	move.l	d0,B_5b514
	jsr	Allocate_memory
	move.l	a1,-(a7)
	move.l	#$59415921,(a1)+
	move.w	#$4a48,(a1)+
	lea.l	Month,a0
	moveq	#0,d0
	moveq	#23,d7
.l_0fad8:
	move.w	(a0)+,d0
	move.b	d0,(a1)+
	dbra	d7,.l_0fad8
	move.w	#$15ad,d7
.l_0fae4:
	move.w	(a0)+,(a1)+
	dbra	d7,.l_0fae4
	movea.l	Modifications_ptr,a0
	move.w	Nr_of_modifications,d7
	bra.b	T_0fafc
T_0faf8:
	move.l	(a0)+,(a1)+
	move.w	(a0)+,(a1)+
T_0fafc:
	dbra	d7,T_0faf8
	clr.w	(a1)+
	jsr	Random
	move.l	B_5b514,d7
	movea.l	(a7)+,a0
	addq.l	#$4,a0
	subq.l	#$4,d7
	jsr	T_00ef0
	move.l	d7,d0
	movea.l	a0,a1
	addq.l	#$4,d0
	subq.l	#$4,a1
	lea.l	Partydata_filename,a0
	jsr	Save_file
	movea.l	a1,a0
	jsr	Free_memory
	rts
T_0fb38:
	btst	#$1,Mouse_button_state
	bne.b	T_0fb38
	lsr.w	#$8,d0
	tst.w	d0
	beq.w	.l_0fcc0
	move.w	Active_member,d1
	subq.w	#$1,d1
	cmp.w	d0,d1
	bne.b	.l_0fb64
	move.w	#$19,d0
	jsr	Plus_message
	bra.w	.l_0fcc0
.l_0fb64:
	lea.l	Chard_ptrs,a0
	move.w	d0,d1
	add.w	d1,d1
	add.w	d1,d1
	tst.l	(a0,d1.w)
	beq.w	.l_0fcc0
	movea.l	(a0,d1.w),a2
	move.w	Body_conditions(a2),d1
	move.w	#$e000,d2
	and.w	d1,d2
	beq.b	.l_0fb96
	move.w	#$15,d0
	jsr	Plus_message
	bra.w	.l_0fcc0
.l_0fb96:
	btst	#$1,d1
	beq.w	.l_0fc2a
	lea.l	Lay6_PlusMes,a0
	jsr	Push_MA
	addq.l	#$8,a0
	jsr	Push_PA
	jsr	Init_RText
	lea.l	$f0(a2),a0
	jsr	Add_ASCII_2_RText
	lea.l	Space,a0
	jsr	Add_ASCII_2_RText
	move.w	#$16,d0
	lea.l	Code0005Sys,a1
	jsr	Add_encoded_2_RText
	jsr	T_0707a
	jsr	Switch_screen
	jsr	Copy_screen
	jsr	Exit_RText
	jsr	Wait_4_user
	movea.l	Off_screen,a6
	jsr	Erase_text_window
	jsr	Switch_screen
	jsr	Copy_screen
	jsr	Pop_PA
	jsr	Pop_MA
	clr.b	Mouse_click_state
	bra.w	.l_0fcc0
.l_0fc2a:
	btst	#$a,d1
	beq.b	.l_0fc3e
	move.w	#$17,d0
	jsr	Plus_message
	bra.w	.l_0fcc0
.l_0fc3e:
	lea.l	Portrait_pos_list,a1
	move.w	d0,d1
	subq.w	#$1,d1
	lsl.w	#$3,d1
	adda.w	d1,a1
	movea.l	Off_screen,a6
	move.w	SaveGame_bitlist,d1
	bchg	d0,d1
	move.w	d1,SaveGame_bitlist
	btst	d0,d1
	bne.b	.l_0fc84
	move.w	(a1)+,d0
	move.w	(a1)+,d1
	moveq	#2,d6
	moveq	#34,d7
	lea.l	$6b0(a2),a0
	jsr	Blot_unmasked_block
	jsr	Switch_screen
	jsr	Copy_screen
	bra.b	.l_0fcc0
.l_0fc84:
	move.w	(a1)+,d0
	move.w	(a1)+,d1
	moveq	#2,d6
	moveq	#16,d7
	lea.l	Chequered,a0
	jsr	Blot_masked_block
	addi.w	#$10,d1
	lea.l	Chequered,a0
	jsr	Blot_masked_block
	addi.w	#$10,d1
	moveq	#2,d7
	jsr	Blot_masked_block
	jsr	Switch_screen
	jsr	Copy_screen
.l_0fcc0:
	rts
T_0fcc2:
	btst	#$1,Mouse_button_state
	bne.b	T_0fcc2
	move.l	#Code0004Sys,Textfile_ptr
	move.w	#$19,ReqText_nr
	move.l	#.l_0fcf2,ReqDo_ptr
	lea.l	Req_Mod,a0
	bra.w	Push_Module
.l_0fcf2:
	bsr.w	Exit_display
	bsr.w	Pop_Module
	bsr.w	Pop_Module
Camp:
	jmp	T_00e04
T_0fd04:
	btst	#$1,Mouse_button_state
	bne.b	T_0fd04
	bsr.w	Exit_display
	lea.l	Camp_Mod,a0
	bra.w	Push_Module
; ---- Camp_DisUpd (original source: MAIN/EYE.ASM)
Camp_DisUpd:
	jsr	Update_status_block
	lea.l	Camp_CIL,a0
	lea.l	CampCIL_evaluate,a1
	bsr.w	Update_control_icons
	bsr.w	Update_quantity_colours	; CHANGE: added
	rts	
Camp_ModInit:
	jsr	T_0025a
	moveq	#17,d0
	jsr	Play_song
	sf.b	Slept
	moveq	#1,d0
	lea.l	D_2902e,a0
	bsr.w	Load_80x80_picture
	jsr	T_00208
	bra.w	Camp_DisInit
; ---- Camp_ModExit (original source: MAIN/EYE.ASM)
Camp_ModExit:
	movea.l	Pic80_ptr,a0
	jsr	Free_memory
	jsr	Set_map_music	; CHANGE: added
	bra.w	Fadeout_lay3
; ---- Camp_DisInit (original source: MAIN/EYE.ASM)
Camp_DisInit:
	move.w	#3,Spell_area_type
	move.l	#Lay3_PlusMes,PlusMes_info
	move.l	#Code0005Sys,Textfile_ptr
	movea.l	Off_screen,a6
	moveq.l	#3,d0
	jsr	Show_layout
	bsr.w	Display_80x80_picture
	lea.l	Camp_CIL,a0
	bsr.w	CampCIL_evaluate
	move.l	a0,Control_list_ptr
	jsr	Show_control_icons
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	Lay3_L2,a0
	jsr	Set_layout_data
	bra.w	Fadein_lay3
; ---- CampCIL_evaluate (original source: MAIN/EYE.ASM)
CampCIL_evaluate:
	bclr	#7,6(a0)
	bclr	#7,(a0)
	bclr	#7,3(a0)
	tst.b	Slept
	beq.s	.Ok
	bset	#7,6(a0)
.Ok:
	movea.l	Current_active_char_data,a1
	tst.b	Spell_class_counter(a1)
	bne.s	.Exit
	bset	#7,(a0)
	bset	#7,3(a0)
.Exit:
	rts	
; ---- Exit_camp (original source: MAIN/EYE.ASM)
Exit_camp:
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	tst.b	Inn_flag
	beq.s	.Exit
	movea.l	Placedat_ptr,a0
	move.w	2(a0),Map_Xcoord
	move.w	4(a0),Map_Ycoord
	move.w	6(a0),View_direction
	cmpi.b	#0,Current_map_type
	bne.s	.Exit
	jsr	Recalc_mapbuf_coords
	sf	Inn_flag
.Exit:
	bsr.w	Pop_Module
	bra.w	Init_display
; ---- Learn_spell (original source: MAIN/EYE.ASM)
Learn_spell:
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	lea.l	LearnSpell_Mod,a0
	bra.w	Push_Module
T_0fe70:
	lea.l	L3_objects_area,a0
	jsr	Push_MA
	movea.l	Current_active_char_data,a0
	lea.l	$2b(a0),a1
	lea.l	$29a(a0),a0
	move.l	a0,Itemdata_ptr
	move.l	a1,Itemslots_ptr
	movea.l	Off_screen,a6
	move.l	#Code0005Sys,Textfile_ptr
	move.w	#$b,d0
	jsr	Hash_message
	bsr.w	Show_objects_LAY3
	jsr	Switch_screen
	jsr	Copy_screen
	rts
; ---- LearnSpell_DisExit (original source: MAIN/EYE.ASM)
LearnSpell_DisExit:
	move.l	#Void,Itemslots_ptr
	lea.l	Lay3_PA,a0
	jsr	Push_PA
	movea.l	Off_screen,a6
	bsr.w	Show_objects_LAY3
	jsr	Erase_text_window
	jsr	Switch_screen
	jsr	Copy_screen
	jsr	Pop_PA
	jsr	Pop_MA
	rts	
T_0ff02:
	btst	#$1,Mouse_button_state
	bne.b	T_0ff02
	tst.b	d0
	beq.w	.l_10064
	move.b	d0,Object_slot_number
	ext.w	d0
	subq.w	#$1,d0
	movea.l	Itemslots_ptr,a0
	movea.l	Itemdata_ptr,a1
	adda.w	d0,a0
	mulu.w	#$28,d0
	adda.w	d0,a1
	tst.b	(a0)
	beq.w	.l_10064
	cmpi.b	#$8,$1(a1)
	beq.b	.l_0ff4c
	move.w	#$c,d0
	jsr	Plus_message
	bra.w	.l_10064
.l_0ff4c:
	movea.l	Current_active_char_data,a2
	move.b	$c(a1),d0
	btst	d0,Spell_class_counter(a2)
	bne.b	.l_0ff6a
	move.w	#$d,d0
	jsr	Plus_message
	bra.w	.l_10064
.l_0ff6a:
	lea.l	$d0(a2),a3
	move.b	$c(a1),d0
	ext.w	d0
	subq.w	#$1,d0
	add.w	d0,d0
	add.w	d0,d0
	adda.w	d0,a3
	move.b	$d(a1),d0
	move.l	(a3),d1
	btst	d0,d1
	bne.w	.l_10064
	lea.l	D_4b4aa,a3
	move.b	$c(a1),d0
	ext.w	d0
	subq.w	#$1,d0
	mulu.w	#$78,d0
	adda.w	d0,a3
	move.b	$d(a1),d0
	ext.w	d0
	subq.w	#$1,d0
	add.w	d0,d0
	add.w	d0,d0
	adda.w	d0,a3
	moveq	#0,d0
	move.b	$2(a3),d0
	cmp.w	Nr_spell_learn_points(a2),d0
	bls.b	.l_0ffc4
	move.w	#$18,d0
	jsr	Plus_message
	bra.w	.l_10064
.l_0ffc4:
	moveq	#0,d0
	move.b	Skill_9(a2),d0
	add.w	Skill_9_normal_magic(a2),d0
	jsr	Probe
	bpl.b	.l_0ffe2
	move.w	#$f,d0
	jsr	Plus_message
	bra.b	.l_10012
.l_0ffe2:
	moveq	#0,d0
	move.b	$2(a3),d0
	sub.w	d0,Nr_spell_learn_points(a2)
	lea.l	$d0(a2),a3
	move.b	$c(a1),d0
	ext.w	d0
	subq.w	#$1,d0
	add.w	d0,d0
	add.w	d0,d0
	adda.w	d0,a3
	move.b	$d(a1),d0
	move.l	(a3),d1
	bset	d0,d1
	move.l	d1,(a3)
	move.w	#$e,d0
	jsr	Plus_message
.l_10012:
	subq.b	#$1,(a0)
	moveq	#0,d0
	move.w	$22(a1),d0
	sub.l	d0,Weight_normal(a2)
	lea.l	D_28f40,a4
	move.b	Object_slot_number,d0
	ext.w	d0
	add.w	d0,d0
	add.w	d0,d0
	move.w	$2(a4,d0.w),d1
	move.w	(a4,d0.w),d0
	moveq	#0,d2
	move.b	(a1),d2
	moveq	#78,d3
	bsr.w	Show_item_destruction
	movea.l	Off_screen,a6
	move.w	#$b,d0
	jsr	Hash_message
	bsr.w	Show_objects_LAY3
	jsr	Switch_screen
	jsr	Copy_screen
	rts
.l_10064:
	bra.w	Pop_Module
T_10068:
	btst	#$1,Mouse_button_state
	bne.b	T_10068
	move.l	#Code0005Sys,Textfile_ptr
	st.b	Slept
	move.w	#$10,d0
	jsr	Plus_message
	lea.l	Lay3_PA,a0
	jsr	Push_PA
	lea.l	Lay3_PlusMes,a0
	jsr	Push_MA
	movea.l	Mapd_ptr,a0
	moveq	#0,d6
	move.b	$ac2(a0),d6
	moveq	#0,d7
	move.b	$ac1(a0),d7
	lsl.w	#$3,d7
	divu.w	d6,d7
	subq.w	#$1,d7
.l_100bc:
	jsr	Update_time
	dbra	d7,.l_100bc
	cmpi.b	#$2,Current_map_type
	bpl.b	.l_100e0
	jsr	M2_time_evaluate
	move.w	New_radius,Current_radius
.l_100e0:
	tst.b	Inn_flag
	bne.w	.l_10298
	lea.l	Chard_ptrs,a0
	moveq	#1,d7
.l_100f2:
	tst.l	(a0)
	beq.b	.l_10148
	movea.l	(a0),a1
	move.w	#$e400,d0
	and.w	Body_conditions(a1),d0
	bne.b	.l_10148
	btst	#$4,Body_conditions(a1)
	beq.b	.l_10148
	addq.w	#$1,Birth_year(a1)
	move.w	Attr_9_normal(a1),d0
	addq.w	#$1,d0
	move.w	d0,Attr_9_normal(a1)
	add.w	Attr_9_normal_magic(a1),d0
	add.w	Time_data_year,d0
	move.w	Attr_9_max(a1),d1
	cmp.w	d0,d1
	bpl.b	.l_10148
	ori.w	#$2000,Body_conditions(a1)
	cmp.w	Active_member,d7
	bne.b	.l_10148
	clr.w	Active_member
	bsr.w	Exit_display
	jsr	Check_party_alive
.l_10148:
	addq.l	#$4,a0
	addq.w	#$1,d7
	cmpi.w	#$7,d7
	bmi.b	.l_100f2
	moveq	#4,d7
	lea.l	Code0005Sys,a1
	lea.l	Chard_ptrs,a2
	moveq	#5,d6
.l_10162:
	tst.l	(a2)
	beq.w	.l_1028e
	movea.l	(a2),a4
	move.w	$3a(a4),d0
	andi.w	#$e400,d0
	bne.w	.l_1028e
	jsr	Init_RText
	lea.l	$f0(a4),a0
	jsr	Add_ASCII_2_RText
	lea.l	Space,a0
	jsr	Add_ASCII_2_RText
	tst.w	$92(a4)
	bne.b	.l_101a4
	moveq	#17,d0
	jsr	Add_encoded_2_RText
	bra.w	.l_10266
.l_101a4:
	moveq	#18,d0
	jsr	Add_encoded_2_RText
	moveq	#0,d0
	move.w	$88(a4),d0
	add.w	$98(a4),d0
	cmp.w	$86(a4),d0
	bpl.b	.l_101c4
	moveq	#0,d0
	move.w	$86(a4),d2
	bra.b	.l_101e0
.l_101c4:
	move.w	d0,d1
	divu.w	#$a,d0
	bne.b	.l_101ce
	moveq	#1,d0
.l_101ce:
	move.w	d0,d2
	add.w	$86(a4),d2
	cmp.w	d2,d1
	bpl.b	.l_101e0
	move.w	d1,d2
	move.w	d1,d0
	sub.w	$86(a4),d0
.l_101e0:
	move.w	d2,$86(a4)
	lea.l	Number_buffer,a0
	movea.l	a0,a3
	bsr.w	LConvert_number
	moveq	#0,d0
	move.w	$8c(a4),d0
	add.w	$9a(a4),d0
	cmp.w	$8a(a4),d0
	bpl.b	.l_10208
	moveq	#0,d0
	move.w	$8a(a4),d2
	bra.b	.l_10220
.l_10208:
	move.w	d0,d1
	divu.w	#$a,d0
	move.w	d0,d2
	add.w	$8a(a4),d2
	cmp.w	d2,d1
	bpl.b	.l_10220
	move.w	d1,d2
	move.w	d1,d0
	sub.w	$8a(a4),d0
.l_10220:
	move.w	d2,$8a(a4)
	move.b	#$4c,(a3)+
	move.b	#$50,(a3)+
	move.b	#$2c,(a3)+
	move.b	#$20,(a3)+
	bsr.w	LConvert_number
	move.b	#$50,(a3)+
	move.b	#$50,(a3)+
	move.b	#$20,(a3)+
	clr.b	(a3)
	lea.l	Number_buffer,a0
	jsr	Add_ASCII_2_RText
	moveq	#19,d0
	jsr	Add_encoded_2_RText
	subq.w	#$1,$92(a4)
	subi.l	#$fa,$ec(a4)
.l_10266:
	jsr	T_0707a
	jsr	Switch_screen
	jsr	Copy_screen
	jsr	Exit_RText
.l_1027e:
	btst	#$1,Mouse_button_state
	bne.b	.l_1027e
	jsr	Wait_4_user
.l_1028e:
	addq.l	#$4,a2
	dbra	d6,.l_10162
	bra.w	.l_1037c
.l_10298:
	moveq	#4,d7
	lea.l	Code0005Sys,a1
	lea.l	Chard_ptrs,a2
	moveq	#5,d6
.l_102a8:
	tst.l	(a2)
	beq.w	.l_10376
	movea.l	(a2),a4
	move.w	$3a(a4),d0
	andi.w	#$e400,d0
	bne.w	.l_10376
	jsr	Init_RText
	lea.l	$f0(a4),a0
	jsr	Add_ASCII_2_RText
	lea.l	Space,a0
	jsr	Add_ASCII_2_RText
	moveq	#18,d0
	jsr	Add_encoded_2_RText
	moveq	#0,d0
	move.w	$88(a4),d0
	add.w	$98(a4),d0
	sub.w	$86(a4),d0
	bpl.b	.l_102f2
	moveq	#0,d0
.l_102f2:
	add.w	d0,$86(a4)
	lea.l	Number_buffer,a0
	movea.l	a0,a3
	bsr.w	LConvert_number
	moveq	#0,d0
	move.w	$8c(a4),d0
	add.w	$9a(a4),d0
	sub.w	$8a(a4),d0
	bpl.b	.l_10314
	moveq	#0,d0
.l_10314:
	add.w	d0,$8a(a4)
	move.b	#$4c,(a3)+
	move.b	#$50,(a3)+
	move.b	#$2c,(a3)+
	move.b	#$20,(a3)+
	bsr.w	LConvert_number
	move.b	#$50,(a3)+
	move.b	#$50,(a3)+
	move.b	#$20,(a3)+
	clr.b	(a3)
	lea.l	Number_buffer,a0
	jsr	Add_ASCII_2_RText
	moveq	#19,d0
	jsr	Add_encoded_2_RText
	jsr	T_0707a
	jsr	Switch_screen
	jsr	Copy_screen
	jsr	Exit_RText
.l_10366:
	btst	#$1,Mouse_button_state
	bne.b	.l_10366
	jsr	Wait_4_user
.l_10376:
	addq.l	#$4,a2
	dbra	d6,.l_102a8
.l_1037c:
	lea.l	Spell_1_data,a0
	clr.l	(a0)+
	clr.l	(a0)+
	clr.l	(a0)
	lea.l	Spell_1_duration,a0
	clr.l	(a0)+
	clr.l	(a0)+
	clr.l	(a0)
	movea.l	Off_screen,a6
	jsr	Erase_text_window
	jsr	Switch_screen
	jsr	Copy_screen
	jsr	Pop_MA
	jsr	Pop_PA
.l_103b8:
	btst	#$1,Mouse_button_state
	bne.b	.l_103b8
	rts
; ---- Ear_action (original source: MAIN/EYE.ASM)
Ear_action:
	move.l	#Code0005Sys,Textfile_ptr
	movea.l	Current_active_char_data,a0
	moveq.l	#0,d0
	move.b	Skill_4(a0),d0
	add.w	Skill_4_normal_magic(a0),d0
	jsr	Probe
	bmi.s	.None
	ext.l	d0
	divu.w	#20,d0
	move.w	d0,Hearing
	lea.l	Spiral_lengths,a0
	moveq.l	#0,d7
.Loop1:
	add.w	(a0)+,d7
	dbra	d0,.Loop1
	subq.w	#1,d7
	move.w	Width_of_map,d2
	sub.w	Map_Xcoord,d2
	move.w	Map_Xcoord,d3
	neg.w	d3
	addq.w	#1,d3
	move.w	Height_of_map,d4
	sub.w	Map_Ycoord,d4
	move.w	Map_Ycoord,d5
	neg.w	d5
	addq.w	#1,d5
	lea.l	Spiral_table,a0
.Loop2:
	move.b	(a0),d0
	cmp.b	d2,d0
	bgt.s	.Next2
	cmp.b	d3,d0
	blt.s	.Next2
	move.b	1(a0),d1
	cmp.b	d4,d1
	bgt.s	.Next2
	cmp.b	d5,d1
	blt.s	.Next2
	bsr.w	Try_2_hear
	bpl.s	.Exit
.Next2:
	addq.l	#2,a0
	dbra	d7,.Loop2
.None:
	move.w	#0,WText_nr
	lea.l	TxtW_Mod,a0
	bsr.w	Push_Module
.Exit:
	rts	
; ---- Try_2_hear (original source: MAIN/EYE.ASM)
Try_2_hear:
	movem.l	d6/d7/a0,-(sp)
	ext.w	d0
	add.w	Map_Xcoord,d0
	ext.w	d1
	add.w	Map_Ycoord,d1
	lea.l	VChar_data,a0
	move.l	CD_value,d6
	moveq.l	#0,d7
.Loop:
	tst.w	(a0)
	beq.s	.Next
	btst	d7,d6
	bne.s	.Next
	cmp.w	VChar_X(a0),d0
	bne.s	.Next
	cmp.w	VChar_Y(a0),d1
	bne.s	.Next
	bsr.w	Heard_it
	moveq.l	#0,d7
	bra.s	.Exit
.Next:
	lea.l	VData_length(a0),a0
	addq.w	#1,d7
	cmpi.w	#Max_chars,d7
	bmi.s	.Loop
	moveq.l	#-1,d7
.Exit:
	movem.l	(sp)+,d6/d7/a0
	rts	
; ---- Heard_it (original source: MAIN/EYE.ASM)
Heard_it:
	movem.l	d0/d1/d7/a0/a1/a3,-(sp)
	sub.w	Map_Xcoord,d0
	sub.w	Map_Ycoord,d1
	ext.l	d0
	beq.s	.Zero1
	swap.w	d0
	bmi.s	.Zero1
	moveq.l	#1,d0
.Zero1:
	ext.l	d1
	beq.s	.Zero2
	swap.w	d1
	bmi.s	.Zero2
	moveq.l	#1,d1
.Zero2:
	addq.w	#1,d0
	addq.w	#1,d1
	mulu.w	#3,d1
	add.w	d1,d0
	lea.l	Hear_table,a0
	move.b	0(a0,d0.w),d0
	ext.w	d0
	move.w	d0,Hear_direction
	lea.l	Code0005Sys,a1
	lea.l	TxtW_PA,a0
	jsr	Push_PA
	jsr	Init_RText
	move.w	#1,d0
	jsr	Add_encoded_2_RText
	lea.l	Hearing_txt,a0
	movea.l	a0,a3
	move.w	Hearing,d0
	addq.w	#1,d0
	mulu.w	#5,d0
	moveq.l	#2,d7
	bsr.w	LConvert_number
	move.b	#" ",(a3)+
	clr.b	(a3)
	jsr	Add_ASCII_2_RText
	move.w	#2,d0
	jsr	Add_encoded_2_RText
	move.w	Hear_direction,d0
	jsr	Add_encoded_2_RText
	jsr	Pop_PA
	lea.l	HearTxtW_Mod,a0
	bsr.w	Push_Module
	movem.l	(sp)+,d0/d1/d7/a0/a1/a3
	rts	
T_10570:
	move.w	Lines_in_text,d0
	mulu.w	#$7,d0
	moveq	#15,d3
	add.w	d0,d3
	andi.w	#$fff0,d3
	lsr.w	#$4,d3
	cmpi.w	#$2,d3
	bpl.b	.l_1058c
	moveq	#2,d3
.l_1058c:
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
	move.w	d0,B_5b288
	lsr.w	#$1,d4
	add.w	d4,d1
	addi.w	#$10,d1
	move.w	d1,D_28eee
	subq.w	#$2,d3
	lsl.w	#$4,d3
	move.w	d3,D_28ef2
	lea.l	TxtW_PA,a0
	jsr	Push_PA
	jsr	T_0707a
	jsr	Switch_screen
	jsr	Copy_screen
	jsr	Exit_RText
	rts
T_105e8:
	btst	#$1,Mouse_button_state
	bne.b	T_105e8
	bsr.w	Exit_display
	lea.l	D_2fcb6,a0
	bra.w	Push_Module
T_10600:
	lea.l	B_5b51a,a0
	clr.l	(a0)+
	clr.l	(a0)+
	clr.l	(a0)
	subq.l	#$8,a0
	lea.l	Chard_ptrs,a1
	lea.l	B_5eed0,a2
	moveq	#1,d7
.l_1061c:
	tst.l	(a1)
	beq.b	.l_10628
	move.b	(a2),d0
	ext.w	d0
	move.b	d7,(a0,d0.w)
.l_10628:
	addq.l	#$4,a1
	addq.l	#$1,a2
	addq.w	#$1,d7
	cmpi.w	#$7,d7
	bmi.b	.l_1061c
	bra.w	T_10658
T_10638:
	lea.l	B_5b526,a0
	lea.l	B_5eed0,a1
	moveq	#11,d7
.l_10646:
	move.b	-(a0),d0
	beq.b	.l_10650
	ext.w	d0
	move.b	d7,-$1(a1,d0.w)
.l_10650:
	dbra	d7,.l_10646
	bra.w	T_0f744
T_10658:
	movea.l	Off_screen,a6
	moveq	#10,d0
	jsr	Show_layout
	bsr.w	T_106f0
	move.l	#D_294f6,PlusMes_info
	move.l	#Code0008Sys,Textfile_ptr
	move.w	#$12,d0
	jsr	Hash_message
	move.l	#D_2940e,Control_list_ptr
	jsr	Show_control_icons
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	D_32618,a0
	jsr	Set_layout_data
	lea.l	Lay6_target,a1
	lea.l	Subfade1,a2
.l_106bc:
	lea.l	Hbl_Lay6_list,a0
	jsr	Update_HBL
	jsr	My_vsync
	jsr	My_vsync
	lea.l	Lay6_below,a0
	jsr	Fade_pal
	bne.b	.l_106bc
	lea.l	Hbl_Lay6_list,a0
	jsr	Update_HBL
	rts
T_106f0:
	movem.l	d0-d3/d5-d7/a0-a3/a6,-(a7)
	movea.l	Off_screen,a6
	move.w	#$10,d0
	move.w	#$31,d1
	move.w	#$12f,d2
	move.w	#$80,d3
	moveq	#2,d6
	jsr	Draw_box
	lea.l	Chard_ptrs,a1
	lea.l	D_294c6,a2
	lea.l	B_5b51a,a3
	moveq	#11,d5
	moveq	#32,d7
.l_10728:
	move.w	(a2)+,d0
	move.w	(a2)+,d1
	move.b	(a3)+,d2
	beq.b	.l_10748
	ext.w	d2
	add.w	d2,d2
	add.w	d2,d2
	movea.l	-$4(a1,d2.w),a0
	lea.l	$6b0(a0),a0
	moveq	#2,d6
	jsr	Blot_unmasked_block
	bra.b	.l_1075c
.l_10748:
	move.w	d0,d2
	move.w	d1,d3
	addi.w	#$1f,d2
	addi.w	#$1f,d3
	moveq	#3,d6
	jsr	Draw_box
.l_1075c:
	dbra	d5,.l_10728
	movem.l	(a7)+,d0-d3/d5-d7/a0-a3/a6
	rts
T_10766:
	btst	#$1,Mouse_button_state
	bne.b	T_10766
	bsr.w	Pop_Module
	bra.w	Init_display
T_10778:
	btst	#$1,Mouse_button_state
	bne.b	T_10778
	tst.b	d0
	beq.b	.l_107ac
	lea.l	B_5b519,a0
	ext.w	d0
	adda.w	d0,a0
	tst.b	(a0)
	beq.b	.l_107ac
	move.b	d0,B_5b526
	move.w	#$0,B_5b518
	lea.l	D_2feda,a0
	bsr.w	Push_Module
.l_107ac:
	rts
T_107ae:
	movea.l	Off_screen,a6
	lea.l	D_294c2,a0
	move.b	B_5b526,d0
	ext.w	d0
	add.w	d0,d0
	add.w	d0,d0
	adda.w	d0,a0
	move.w	(a0)+,d0
	move.w	(a0)+,d1
	move.w	B_5b518,d2
	addq.w	#$1,d2
	andi.w	#$1f,d2
	move.w	d2,B_5b518
	btst	#$4,d2
	bne.b	.l_107fa
	move.w	d0,d2
	move.w	d1,d3
	addi.w	#$1f,d2
	addi.w	#$1f,d3
	moveq	#1,d6
	jsr	Draw_box
	bra.b	.l_1082a
.l_107fa:
	lea.l	B_5b519,a0
	move.b	B_5b526,d2
	ext.w	d2
	move.b	(a0,d2.w),d2
	lea.l	Codetxt_ptr,a0
	ext.w	d2
	add.w	d2,d2
	add.w	d2,d2
	movea.l	(a0,d2.w),a0
	lea.l	$6b0(a0),a0
	moveq	#2,d6
	moveq	#32,d7
	jsr	Blot_unmasked_block
.l_1082a:
	rts
T_1082c:
	btst	#$1,Mouse_button_state
	bne.b	T_1082c
	tst.b	d0
	beq.b	.l_1088e
	cmp.b	B_5b526,d0
	bne.b	.l_10846
	bra.w	T_10890
.l_10846:
	lea.l	B_5b519,a0
	ext.w	d0
	adda.w	d0,a0
	lea.l	B_5b519,a1
	move.b	B_5b526,d0
	ext.w	d0
	adda.w	d0,a1
	tst.b	(a0)
	bne.b	.l_1086a
	move.b	(a1),(a0)
	clr.b	(a1)
	bra.b	.l_10870
.l_1086a:
	move.b	(a1),d0
	move.b	(a0),(a1)
	move.b	d0,(a0)
.l_10870:
	bsr.w	T_106f0
	jsr	Switch_screen
	jsr	Copy_screen
.l_10880:
	btst	#$1,Mouse_button_state
	bne.b	.l_10880
	bsr.w	Pop_Module
.l_1088e:
	rts
T_10890:
	movea.l	Off_screen,a6
	lea.l	D_294c2,a0
	move.b	B_5b526,d2
	ext.w	d2
	move.w	d2,d0
	add.w	d0,d0
	add.w	d0,d0
	adda.w	d0,a0
	move.w	(a0)+,d0
	move.w	(a0)+,d1
	lea.l	B_5b519,a0
	move.b	(a0,d2.w),d2
	lea.l	Codetxt_ptr,a0
	ext.w	d2
	add.w	d2,d2
	add.w	d2,d2
	movea.l	(a0,d2.w),a0
	lea.l	$6b0(a0),a0
	moveq	#2,d6
	moveq	#32,d7
	jsr	Blot_unmasked_block
	jsr	Switch_screen
	jsr	Copy_screen
	bra.w	Pop_Module

	section	data

Automap_CIL:
	dc.b	$2e,$01,$2d,$04,$1e,$03,$30,$02,$2f,$00
	dc.l	Automap_upleft
	dc.l	Automap_up
	dc.l	Automap_upright
	dc.l	Automap_left
	dc.l	Automap_exit
	dc.l	Automap_right
	dc.l	Automap_downleft
	dc.l	Automap_down
	dc.l	Automap_downright
Lay8_target:
	dc.b	$00,$00,$00,$00,$07,$50,$03,$33,$02,$22,$01,$11,$07,$42,$06,$31
	dc.b	$02,$00,$05,$66,$03,$45,$07,$54,$06,$43,$05,$32,$04,$21,$03,$10
	dc.b	$07,$65,$00,$00,$00,$00,$06,$51,$03,$33,$02,$22,$01,$11,$05,$31
	dc.b	$04,$21,$01,$24,$02,$36,$06,$10,$03,$10,$05,$41,$03,$40,$04,$51
	dc.b	$04,$44,$07,$65
Lay11_target:
	dc.b	$00,$00,$05,$00,$03,$33,$02,$22,$01,$11,$04,$44,$05,$55,$02,$10
	dc.b	$03,$20,$04,$31,$05,$42,$00,$12,$01,$23,$03,$51,$02,$30,$06,$66
Cut_table:
	dc.b	$ff,$ff,$ff,$00,$ff,$01,$00,$ff,$00,$00,$00,$01,$01,$ff,$01,$00
	dc.b	$01,$01
Dialogue_CIL:
	dc.b	$21,$22,$1e,$23,$11,$43,$3d,$3f,$3e,$00
	dc.l	DIA_Transfer_item
	dc.l	DIA_Drop_item
	dc.l	DIA_Exit
	dc.l	T_0e75e
	dc.l	DIA_Ask_word
	dc.l	T_0ec82
	dc.l	DIA_Give_item
	dc.l	DIA_Give_gold
	dc.l	DIA_Give_food
D_293b0:
	dc.b	$00,$10,$00,$bf,$00,$31,$00,$bf
Lay6_PlusMes:
	dc.b	$00,$d0,$01,$2f,$00,$31,$00,$80
Lay6_PA:
	dc.b	$00,$d0,$00,$31,$00,$60,$00,$50,$00,$0f,$00,$02
Lay8_PlusMes:
	dc.b	$00,$10,$00,$bf,$00,$31,$00,$80
Lay8_PA:
	dc.b	$00,$10,$00,$31,$00,$b0,$00,$4d,$00,$0f,$00,$02
Options_CIL:
	dc.b	$41,$38,$1e,$19,$1a,$38,$17,$18,$38,$00
	dc.l	Quit_game
	dc.b	$00,$00,$00,$00
	dc.l	Exit_options
	dc.l	Music_on
	dc.l	Music_off
	dc.b	$00,$00,$00,$00
	dc.l	T_0f822
	dc.l	T_0fcc2
	dc.b	$00,$00,$00,$00
D_2940e:
	dc.b	$38,$38,$1e,$38,$38,$38,$38,$38,$38,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00
	dc.l	T_10766
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00
Lay6_target:
	dc.b	$00,$00,$07,$50,$03,$33,$02,$22,$01,$11,$07,$42,$06,$31,$02,$00
	dc.b	$05,$66,$03,$45,$07,$54,$06,$43,$05,$32,$04,$21,$03,$10,$07,$65
Camp_CIL:
	dc.b	$0c,$38,$1e,$3a,$38,$38,$07,$38,$38,$00
	dc.l	T_13774
	dc.b	$00,$00,$00,$00
	dc.l	Exit_camp
	dc.l	Learn_spell
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00
	dc.l	T_10068
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00
Spiral_lengths:
	dc.b	$00,$08,$00,$10,$00,$18,$00,$20,$00,$28
Hear_table:
	dc.b	$0a,$03,$04,$09,$00,$05,$08,$07,$06,$00
Portrait_pos_list:
	dc.b	$00,$10,$00,$31,$00,$10,$00,$55,$00,$70,$00,$49,$00,$6a,$00,$6d
	dc.b	$00,$10,$00,$61,$00,$10,$00,$85,$00,$70,$00,$79,$00,$6a,$00,$9d
	dc.b	$00,$10,$00,$91
D_294c2:
	dc.b	$00,$10,$00,$b5
D_294c6:
	dc.b	$00,$10,$00,$31,$00,$40,$00,$31,$00,$70,$00,$31,$00,$a0,$00,$31
	dc.b	$00,$d0,$00,$31,$01,$00,$00,$31,$00,$10,$00,$61,$00,$40,$00,$61
	dc.b	$00,$70,$00,$61,$00,$a0,$00,$61,$00,$d0,$00,$61,$01,$00,$00,$61
D_294f6:
	dc.b	$00,$10,$00,$bf,$00,$91,$00,$c0,$00,$10,$00,$91,$00,$b0,$00,$30
	dc.b	$00,$0f,$00,$02

	section	bss

Eye_flag:
	ds.b	1
Joined:
	ds.b	1
Inn_flag:
	ds.b	1
Slept:
	ds.b	1
Made_area:
	ds.b	8
Automap_ptr:
	ds.b	4
Automapicon_ptr:
	ds.b	4
Automap_X:
	ds.b	2
Automap_Y:
	ds.b	2
Automap_width:
	ds.b	2
Automap_height:
	ds.b	2
Party_automap_icon:
	ds.b	2
Dialogue_chard_ptr:
	ds.b	4
Dialogue_char_nr:
	ds.b	2
Dialogue_VChar_index:
	ds.b	2
Action_ptr:
	ds.b	4
Act_dat_ptr:
	ds.b	4
Result_ptr:
	ds.b	4
Res_dat1_ptr:
	ds.b	4
Res_dat2_ptr:
	ds.b	4
Res_dat3_ptr:
	ds.b	4
Dialogue_text_ptr:
	ds.b	4
Hearing:
	ds.b	2
Hear_direction:
	ds.b	2
Hearing_txt:
	ds.b	6
SaveGame_bitlist:
	ds.b	2
B_5b514:
	ds.b	4
B_5b518:
	ds.b	1
B_5b519:
	ds.b	1
B_5b51a:
	ds.b	12
B_5b526:
	ds.b	2
