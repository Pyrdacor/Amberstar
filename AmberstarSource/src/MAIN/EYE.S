; MAIN/EYE.ASM (original module, merged with the disassembly of the shipped program)

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
	beq.b	T_0dede
	moveq	#0,d0
	move.b	(a5),d0
	cmpi.w	#$3,d0
	bne.b	T_0de82
	st.b	Eye_flag
	bsr.w	Handle_event
	sf.b	Eye_flag
	bra.b	T_0defc
T_0de82:
	cmpi.w	#$4,d0
	bne.b	T_0de94
	jsr	T_01ff6
	bsr.w	Handle_event
	bra.b	T_0defc
T_0de94:
	cmpi.w	#$e,d0
	bne.b	T_0dea0
	bsr.w	Handle_event
	bra.b	T_0defc
T_0dea0:
	lea.l	D_292c6,a0
	move.b	-$1(a0,d0.w),d1
	bmi.b	T_0dede
	movea.l	Current_active_char_data,a0
	moveq	#0,d0
	move.b	$d(a0),d0
	add.w	$be(a0),d0
	bsr.w	Probe
	bmi.b	T_0dede
	move.w	d1,WText_nr
	move.l	#Code0003Sys,Textfile_ptr
	lea.l	TxtW_Mod,a0
	bsr.w	Push_Module
	bra.b	T_0defc
T_0dede:
	cmp.w	Map_Xcoord,d2
	bne.b	T_0defc
	cmp.w	Map_Ycoord,d3
	bne.b	T_0defc
	move.w	Active_member,d0
	lsl.w	#$8,d0
	jsr	T_004ce
T_0defc:
	movem.l	(a7)+,d0-d3/a0/a5
	rts
T_0df02:
	movem.l	d0-d1/a0,-(a7)
	cmpi.b	#$2,Current_map_type
	bpl.b	T_0df32
	bsr.w	T_0ddf2
T_0df14:
	btst	#$1,Mouse_button_state
	bne.b	T_0df14
	lea.l	Mouth2D_Mod,a0
	movea.l	Module_sp,a1
	move.l	(a1),(a0)
	bsr.w	Push_Module
	bra.b	T_0df42
T_0df32:
	move.w	Map_Xcoord,d0
	move.w	Map_Ycoord,d1
	bsr.w	Talk
T_0df42:
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
Dialogue_DisInit:
	move.w	#$10,Mesmin_X
	move.w	#$3f,Mesmin_Y
	move.w	#$b0,Mesmin_Wd
	move.l	#Code0006Sys,Textfile_ptr
	move.l	#Lay8_PlusMes,PlusMes_info
	move.l	#Sold_data,Itemdata_ptr
	move.l	#Sold_slots,Itemslots_ptr
	movea.l	Off_screen,a6
	moveq	#8,d0
	bsr.w	Show_layout
	move.w	#$10,d0
	move.w	#$27,d1
	move.w	#$b0,d2
	lea.l	D_30b29,a0
	bsr.w	Print_centered_string
	moveq	#2,d0
	jsr	IG_Set_paper
	moveq	#0,d0
	movea.l	Dialogue_chard_ptr,a1
	lea.l	$6b0(a1),a0
	move.w	#$d0,d0
	move.w	#$31,d1
	moveq	#2,d6
	moveq	#34,d7
	jsr	Blot_unmasked_block
	moveq	#1,d0
	jsr	IG_Set_ink
	move.w	#$d0,d0
	move.w	#$54,d1
	move.w	#$60,d2
	lea.l	$f0(a1),a0
	bsr.w	Print_centered_string
	moveq	#15,d0
	jsr	IG_Set_ink
	move.w	#$f2,d0
	move.w	#$38,d1
	jsr	IG_Set_cursor
	move.b	$3(a1),d0
	beq.b	T_0e27a
	lea.l	Female_name,a0
	bra.b	T_0e280
T_0e27a:
	lea.l	Male_name,a0
T_0e280:
	jsr	IG_Print
	cmpi.b	#$9,$4(a1)
	bpl.b	T_0e304
	move.w	#$f2,d0
	move.w	#$31,d1
	jsr	IG_Set_cursor
	lea.l	D_4a2dc,a2
	moveq	#0,d0
	move.b	$4(a1),d0
	add.w	d0,d0
	move.w	(a2,d0.w),d0
	bsr.w	Get_word
	lea.l	Line_buffer,a0
	jsr	IG_Print
	tst.b	$5(a1)
	beq.b	T_0e304
	move.w	#$f2,d0
	move.w	#$46,d1
	jsr	IG_Set_cursor
	lea.l	D_4b3fc,a2
	moveq	#0,d0
	move.b	$5(a1),d0
	add.w	d0,d0
	move.w	(a2,d0.w),d0
	bsr.w	Get_word
	move.b	#$20,(a3)+
	moveq	#0,d0
	move.b	$1b(a1),d0
	moveq	#2,d7
	bsr.w	LConvert_number
	lea.l	Line_buffer,a0
	jsr	IG_Print
T_0e304:
	move.w	#$f2,d0
	move.w	#$3f,d1
	jsr	IG_Set_cursor
	lea.l	Age_txt,a0
	jsr	IG_Print
	lea.l	Line_buffer,a0
	move.w	$58(a1),d0
	add.w	$ac(a1),d0
	add.w	Time_data_year,d0
	moveq	#3,d7
	movea.l	a0,a3
	bsr.w	LConvert_number
	jsr	IG_Print
	move.w	#$d0,d0
	move.w	#$71,d1
	lea.l	D_3936a,a0
	jsr	Put_unmasked_block
	lea.l	D_43d0a,a0
	jsr	Put_masked_block
	addi.w	#$30,d0
	lea.l	D_3936a,a0
	jsr	Put_unmasked_block
	lea.l	D_4438a,a0
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
	lea.l	D_2930c,a1
	lea.l	Subfade1,a2
T_0e3be:
	lea.l	Hbl_Lay8_list,a0
	jsr	Update_HBL
	jsr	My_vsync
	jsr	My_vsync
	lea.l	Lay8_below,a0
	jsr	Hbl_fade
	bne.b	T_0e3be
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
T_0e6e6:
	btst	#$1,Mouse_button_state
	bne.b	T_0e6e6
	lea.l	WSelW_Mod,a0
	move.l	#T_0e704,$28(a0)
	bsr.w	Push_Module
	rts
T_0e704:
	btst	#$1,Mouse_button_state
	bne.b	T_0e704
	tst.b	No_word_entered
	bne.b	T_0e75c
	movea.l	Action_ptr,a0
	movea.l	Act_dat_ptr,a1
	moveq	#0,d0
	move.w	Found_word,d1
	moveq	#9,d7
	cmpi.b	#$1,(a0)+
	bne.b	T_0e74c
	cmp.w	(a1),d1
	bne.b	T_0e74c
	moveq	#7,d2
	and.w	d1,d2
	lsr.w	#$3,d1
	lea.l	WD,a0
	bset	d2,(a0,d1.w)
	bsr.w	Do_results
	bra.b	T_0e75c
T_0e74c:
	dc.b	$52,$80,$54,$89,$51,$cf,$ff,$da,$30,$3c,$00,$03,$61,$00,$8a,$00
T_0e75c:
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
T_0e96e:
	btst	#$1,Mouse_button_state
	bne.b	T_0e96e
	rts
Do_TIDIA:
	tst.b	d0
	bne.b	T_0e982
T_0e97e:
	bra.w	Pop_Module
T_0e982:
	ext.w	d0
	lea.l	B_5b4ad,a1
	adda.w	d0,a1
	tst.b	(a1)
	beq.b	T_0e97e
	lea.l	Sold_data,a2
	moveq	#40,d1
	mulu.w	d0,d1
	lea.l	-$28(a2,d1.w),a2
	move.b	d0,Object_slot_number
	moveq	#0,d0
	move.w	$22(a2),d0
	btst	#$2,$18(a2)
	beq.b	T_0e9b8
	move.w	$24(a2),d1
	bra.b	T_0e9ba
T_0e9b8:
	moveq	#-1,d1
T_0e9ba:
	suba.l	a0,a0
	bsr.w	Scan_4_transfer_victims
	bne.b	T_0e9d0
	move.w	#$5,d0
	bsr.w	Plus_message
	bsr.w	Pop_Module
	bra.b	T_0e9f4
T_0e9d0:
	bsr.w	Show_transfer_victims
	move.b	(a2),TIVS_Icon_nr
	move.l	#T_0e9f6,TIVS_Ptr
	lea.l	TIVS2_Mod,a0
	move.w	#$18,$2c(a0)
	bsr.w	Push_Module
T_0e9f4:
	rts
T_0e9f6:
	lea.l	Sold_slots,a2
	lea.l	Sold_data,a3
	moveq	#0,d0
	move.b	Object_slot_number,d0
	subq.w	#$1,d0
	adda.w	d0,a2
	mulu.w	#$28,d0
	adda.w	d0,a3
	btst	#$2,$18(a3)
	beq.b	T_0ea44
	lea.l	$2b(a0),a4
	lea.l	$29a(a0),a5
	move.w	$24(a3),d0
	moveq	#11,d7
T_0ea2a:
	tst.b	(a4)
	beq.b	T_0ea3a
	cmp.w	$24(a5),d0
	bne.b	T_0ea3a
	cmpi.b	#$63,(a4)
	bmi.b	T_0ea5e
T_0ea3a:
	addq.l	#$1,a4
	lea.l	$28(a5),a5
	dbra	d7,T_0ea2a
T_0ea44:
	lea.l	$2b(a0),a4
	lea.l	$29a(a0),a5
	moveq	#11,d7
T_0ea4e:
	tst.b	(a4)
	beq.b	T_0ea5e
	addq.l	#$1,a4
	lea.l	$28(a5),a5
	dbra	d7,T_0ea4e
	bra.b	T_0eace
T_0ea5e:
	dc.b	$74,$00,$34,$2b,$00,$22,$d5,$a8,$00,$ec,$52,$14,$7e,$13,$3a,$db
	dc.b	$51,$cf,$ff,$fc,$47,$eb,$ff,$d8,$42,$12,$2c,$79
	dc.l	Off_screen
	dc.b	$41,$f9
	dc.l	D_28f40
	dc.b	$70,$00,$10,$39
	dc.l	Object_slot_number
	dc.b	$d0,$40,$d0,$40,$d0,$c0,$30,$18,$32,$18,$41,$f9
	dc.l	D_3936a
	dc.b	$4e,$b9
	dc.l	Put_unmasked_block
	dc.b	$4e,$b9
	dc.l	Switch_screen
	dc.b	$4e,$b9
	dc.l	Copy_screen
	dc.b	$41,$f9
	dc.l	Sold_slots
	dc.b	$4a,$98,$66,$16,$4a,$98,$66,$12,$4a,$98,$66,$0e,$61,$00,$1f,$14
	dc.b	$23,$fc
	dc.l	Code0006Sys
	dc.l	Textfile_ptr
T_0eace:
	rts
T_0ead0:
	btst	#$1,Mouse_button_state
	bne.b	T_0ead0
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
	beq.w	T_0ebc2
	move.b	d0,Object_slot_number
	ext.w	d0
	subq.w	#$1,d0
	movea.l	Itemslots_ptr,a3
	movea.l	Itemdata_ptr,a4
	adda.w	d0,a3
	mulu.w	#$28,d0
	adda.w	d0,a4
	tst.b	(a3)
	beq.b	T_0ebc2
	move.w	$24(a4),d1
	movea.l	Action_ptr,a0
	movea.l	Act_dat_ptr,a1
	moveq	#0,d0
	moveq	#9,d7
T_0eb7a:
	cmpi.b	#$3,(a0)+
	bne.b	T_0ebb2
	cmp.w	(a1),d1
	bne.b	T_0ebb2
	movea.l	Current_active_char_data,a0
	subq.b	#$1,(a3)
	move.w	$22(a4),d2
	ext.l	d2
	sub.l	d2,$ec(a0)
	movea.l	Off_screen,a6
	bsr.w	Show_objects_LAY3
	jsr	Switch_screen
	jsr	Copy_screen
	bsr.w	Do_results
	bra.b	T_0ebc2
T_0ebb2:
	addq.l	#$1,d0
	addq.l	#$2,a1
	dbra	d7,T_0eb7a
	move.w	#$5,d0
	bsr.w	Plus_message
T_0ebc2:
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
	beq.b	T_0ec6c
	movea.l	Action_ptr,a0
	movea.l	Act_dat_ptr,a1
	moveq	#0,d0
	moveq	#9,d7
T_0ec30:
	cmpi.b	#$5,(a0)+
	bne.b	T_0ec52
	cmp.w	(a1),d1
	bmi.b	T_0ec5a
	movea.l	Current_active_char_data,a0
	sub.w	d1,$92(a0)
	mulu.w	#$fa,d1
	sub.l	d1,$ec(a0)
	bsr.w	Do_results
	bra.b	T_0ec6c
T_0ec52:
	addq.l	#$1,d0
	addq.l	#$2,a1
	dbra	d7,T_0ec30
T_0ec5a:
	move.l	#Code0006Sys,Textfile_ptr
	move.w	#$8,d0
	bsr.w	Plus_message
T_0ec6c:
	move.l	#Code0006Sys,Textfile_ptr
T_0ec76:
	btst	#$1,Mouse_button_state
	bne.b	T_0ec76
	rts
T_0ec82:
	btst	#$1,Mouse_button_state
	bne.b	T_0ec82
	move.w	#$0,Draw_Cicon
	jsr	My_vsync
	movea.l	Dialogue_chard_ptr,a0
	moveq	#0,d0
	move.b	$3c(a0),d0
	beq.b	T_0ecb4
	cmpi.w	#$64,d0
	beq.b	T_0ecbe
	bsr.w	Probe
	bpl.b	T_0ecbe
T_0ecb4:
	move.w	#$9,d0
	bsr.w	Plus_message
	rts
T_0ecbe:
	lea.l	Chard_ptrs,a1
	moveq	#0,d0
	moveq	#5,d7
T_0ecc8:
	tst.l	(a1)
	beq.b	T_0ecd8
	addq.l	#$4,a1
	addq.w	#$1,d0
	dbra	d7,T_0ecc8
	bra.w	T_0ed82
T_0ecd8:
	move.l	a0,(a1)
	move.w	Map_nr,d7
	subq.w	#$1,d7
	mulu.w	#$18,d7
	add.w	Dialogue_VChar_index,d7
	addq.w	#$1,d7
	move.w	d7,$c4(a0)
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
T_0ed3a:
	move.b	(a0)+,d1
	bset	d1,d0
	dbra	d7,T_0ed3a
	moveq	#11,d7
T_0ed44:
	btst	d7,d0
	beq.b	T_0ed4c
	dbra	d7,T_0ed44
T_0ed4c:
	lea.l	B_5eed0,a0
	move.w	(a7)+,d0
	move.b	d7,(a0,d0.w)
	st.b	Joined
	movea.l	Action_ptr,a0
	movea.l	Act_dat_ptr,a1
	moveq	#0,d0
	moveq	#9,d7
T_0ed6e:
	cmpi.b	#$6,(a0)+
	bne.b	T_0ed7a
	bsr.w	Do_results
	bra.b	T_0ed82
T_0ed7a:
	addq.l	#$1,d0
	addq.l	#$2,a1
	dbra	d7,T_0ed6e
T_0ed82:
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
Item_res:
	movea.l	Dialogue_chard_ptr,a0
	lea.l	$10a(a0),a0
	move.w	(a3),d0
	mulu.w	#$28,d0
	adda.w	d0,a0
	lea.l	Sold_slots,a1
	moveq	#0,d1
	moveq	#11,d7
T_0ee5e:
	tst.b	(a1,d1.w)
	beq.b	T_0ee78
	addq.l	#$1,d1
	dbra	d7,T_0ee5e
	lea.l	D_31ee1,a1
	jsr	DI_Error
	bra.b	T_0eea8
T_0ee78:
	dc.b	$13,$bc,$00,$01,$10,$00,$43,$f9
	dc.l	Sold_data
	dc.b	$c2,$fc,$00,$28,$d2,$c1,$7e,$09,$22,$d8,$51,$cf,$ff,$fc,$2c,$79
	dc.l	Off_screen
	dc.b	$61,$00,$b7,$02,$4e,$b9
	dc.l	Switch_screen
	dc.b	$4e,$b9
	dc.l	Copy_screen
T_0eea8:
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
	dc.l	T_0eefe
	dc.l	T_0ef42
	dc.l	T_0ef7a
	dc.l	T_0ef80
	dc.l	T_0ef86
T_0eefe:
	move.w	(a3),d1
	ext.l	d1
	cmpi.w	#$46,d0
	bpl.b	T_0ef1c
	moveq	#0,d0
	move.b	(a0),d0
	add.w	d1,d0
	cmpi.w	#$100,d0
	bmi.b	T_0ef18
	move.w	#$ff,d0
T_0ef18:
	move.b	d0,(a0)
	bra.b	T_0ef40
T_0ef1c:
	cmpi.w	#$cc,d0
	bpl.b	T_0ef32
	moveq	#0,d0
	move.w	(a0),d0
	add.w	d1,d0
	bvc.b	T_0ef2e
	move.w	#$7fff,d0
T_0ef2e:
	move.w	d0,(a0)
	bra.b	T_0ef40
T_0ef32:
	dc.b	$20,$10,$d0,$81,$68,$06,$20,$3c,$7f,$ff,$ff,$ff,$20,$80
T_0ef40:
	rts
T_0ef42:
	move.w	(a3),d1
	ext.l	d1
	cmpi.w	#$46,d0
	bpl.b	T_0ef5a
	moveq	#0,d0
	move.b	(a0),d0
	sub.b	d1,d0
	bpl.b	T_0ef56
	moveq	#0,d0
T_0ef56:
	move.b	d0,(a0)
	bra.b	T_0ef78
T_0ef5a:
	cmpi.w	#$cc,d0
	bpl.b	T_0ef6e
	moveq	#0,d0
	move.w	(a0),d0
	sub.w	d1,d0
	bpl.b	T_0ef6a
	moveq	#0,d0
T_0ef6a:
	move.w	d0,(a0)
	bra.b	T_0ef78
T_0ef6e:
	dc.b	$20,$10,$90,$81,$6a,$02,$70,$00,$20,$80
T_0ef78:
	rts
T_0ef7a:
	move.w	(a3),d1
	bclr	d1,(a0)
	rts
T_0ef80:
	move.w	(a3),d1
	bset	d1,(a0)
	rts
T_0ef86:
	move.w	(a3),d1
	bchg	d1,(a0)
	rts
T_0ef8c:
	tst.b	Print_objname_flag
	beq.b	T_0efde
	lea.l	T_0efe0(pc),a0
	jsr	IG_Print
	move.w	Object_name_nr,d0
	beq.b	T_0efde
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
T_0efde:
	rts
T_0efe0:
	dc.b	$01,$0f,$02,$ff,$00,$00
T_0efe6:
	tst.b	Erase_objname_flag
	beq.b	T_0f01a
	move.w	#$10,d0
	move.w	#$48,d1
	move.w	#$bf,d2
	move.w	#$4e,d3
	move.w	#$2,d6
	movea.l	Off_screen,a6
	jsr	Draw_box
	subq.b	#$1,Erase_objname_flag
	clr.w	Object_name_nr
T_0f01a:
	rts
Change_travelmode:
	movem.l	d0-d1/a0,-(a7)
	tst.w	Travel_mode
	beq.w	T_0f0c8
	cmpi.w	#$4,Travel_mode
	beq.w	T_0f0ba
	cmpi.w	#$5,Travel_mode
	bne.b	T_0f064
	moveq	#0,d0
	jsr	Set_new_travel_mode
	jsr	W2_DisUpd
	jsr	Switch_screen
	lea.l	D_304ae,a0
	bsr.w	Push_Module
	bsr.w	Event_handler
	bra.b	T_0f0de
T_0f064:
	cmpi.w	#$6,Travel_mode
	beq.b	T_0f0ba
	lea.l	Trans_T,a0
	moveq	#29,d1
T_0f076:
	tst.b	(a0,d1.w)
	bne.b	T_0f0a8
	move.w	Travel_mode,d0
	move.b	d0,(a0,d1.w)
	move.w	Map_Xcoord,d0
	move.b	d0,$1e(a0,d1.w)
	move.w	Map_Ycoord,d0
	move.b	d0,$3c(a0,d1.w)
	lea.l	$5a(a0,d1.w),a0
	move.w	Map_nr,(a0,d1.w)
	bra.b	T_0f0ba
T_0f0a8:
	subq.w	#$1,d1
	bpl.b	T_0f076
	lea.l	D_31f1d,a1
	jsr	DI_Error
	bra.b	T_0f0de
T_0f0ba:
	moveq	#0,d0
	jsr	Set_new_travel_mode
	bsr.w	Event_handler
	bra.b	T_0f0de
T_0f0c8:
	jsr	Seek_transport
	lea.l	Trans_T,a0
	clr.b	(a0,d1.w)
	jsr	Set_new_travel_mode
T_0f0de:
	btst	#$1,Mouse_button_state
	bne.b	T_0f0de
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
T_0f160:
	bclr	#$7,(a0)+
	dbra	d7,T_0f160
	lea.l	-$9(a0),a0
	move.w	#$6,Automap_X
	move.w	#$6,Automap_Y
	move.w	#$16,Automap_width
	move.w	#$12,Automap_height
	move.w	Width_of_map,d0
	subi.w	#$a,d0
	cmpi.w	#$16,d0
	bpl.b	T_0f1c6
	move.w	d0,Automap_width
	bset	#$7,(a0)
	bset	#$7,$2(a0)
	bset	#$7,$3(a0)
	bset	#$7,$5(a0)
	bset	#$7,$6(a0)
	bset	#$7,$8(a0)
	bra.b	T_0f1f2
T_0f1c6:
	move.w	Map_Xcoord,d0
	subi.w	#$a,d0
	cmpi.w	#$6,d0
	bmi.b	T_0f1f2
	moveq	#27,d1
	add.w	d0,d1
	cmp.w	Width_of_map,d1
	bmi.b	T_0f1ec
	move.w	Width_of_map,d0
	subi.w	#$1a,d0
T_0f1ec:
	move.w	d0,Automap_X
T_0f1f2:
	move.w	Height_of_map,d0
	subi.w	#$a,d0
	cmpi.w	#$12,d0
	bpl.b	T_0f22e
	move.w	d0,Automap_height
	bset	#$7,$0(a0)
	bset	#$7,$1(a0)
	bset	#$7,$2(a0)
	bset	#$7,$6(a0)
	bset	#$7,$7(a0)
	bset	#$7,$8(a0)
	bra.b	T_0f258
T_0f22e:
	move.w	Map_Ycoord,d0
	subq.w	#$8,d0
	cmpi.w	#$6,d0
	bmi.b	T_0f258
	moveq	#23,d1
	add.w	d0,d1
	cmp.w	Height_of_map,d1
	bmi.b	T_0f252
	move.w	Height_of_map,d0
	subi.w	#$16,d0
T_0f252:
	move.w	d0,Automap_Y
T_0f258:
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
	beq.b	T_0f2e8
	bchg	#$7,d0
T_0f2e8:
	btst	#$7,d0
	bne.b	T_0f2f2
	moveq	#2,d0
	bra.b	T_0f2f4
T_0f2f2:
	moveq	#1,d0
T_0f2f4:
	move.b	d0,(a1)
	addq.w	#$1,d4
	cmpi.w	#$8,d4
	bmi.b	T_0f302
	moveq	#0,d4
	addq.w	#$1,d5
T_0f302:
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
	beq.b	T_0f33a
	moveq	#10,d1
	add.w	View_direction,d1
	bra.b	T_0f33c
T_0f33a:
	moveq	#9,d1
T_0f33c:
	move.b	d1,(a0,d0.w)
	move.w	d1,Party_automap_icon
	bra.w	Init_display
; ---- Automap_ModExit (original source: MAIN/EYE.ASM)
Automap_ModExit:
	movea.l	Automapicon_ptr,a0
	jsr	Free_memory
	bra.w	Automap_DisExit
Automap_DisInit:
	movea.l	Off_screen,a6
	moveq	#11,d0
	jsr	Show_layout
	movea.l	Mapd_ptr,a5
	jsr	Print_headline
	move.w	#$d0,d0
	move.w	#$31,d1
	moveq	#7,d5
	moveq	#1,d6
	moveq	#8,d7
	lea.l	D_47bda,a0
T_0f388:
	jsr	Blot_unmasked_block
	addi.w	#$9,d1
	lea.l	$40(a0),a0
	dbra	d5,T_0f388
	lea.l	Automap_icn,a0
	move.w	Party_automap_icon,d2
	lsl.w	#$6,d2
	adda.w	d2,a0
	jsr	Blot_unmasked_block
	move.w	#$d8,d0
	move.w	#$31,d1
	move.w	#$df,d2
	move.w	#$81,d3
	moveq	#2,d6
	jsr	Draw_box
	move.w	#$de,d0
	move.w	#$32,d1
	move.w	#$c,d2
	moveq	#8,d7
	lea.l	Line_buffer,a0
	lea.l	Code0006Sys,a1
T_0f3e2:
	jsr	IG_Set_cursor
	exg.l	d2,d0
	jsr	Convert_text_line
	exg.l	d2,d0
	jsr	IG_Print
	addi.w	#$9,d1
	addq.w	#$1,d2
	dbra	d7,T_0f3e2
	moveq	#15,d0
	jsr	IG_Set_ink
	moveq	#-1,d0
	jsr	IG_Set_paper
	moveq	#11,d0
	jsr	Convert_text_line
	move.w	#$d0,d0
	move.w	#$27,d1
	move.w	#$60,d2
	lea.l	Line_buffer,a0
	jsr	Print_centered_string
	move.l	#Automap_CIL,Control_list_ptr
	jsr	Show_control_icons
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	Control_area,a0
	jsr	Set_layout_data
	lea.l	D_29350,a1
	lea.l	Subfade1,a2
T_0f466:
	lea.l	Hbl_Lay11_list,a0
	jsr	Update_HBL
	jsr	My_vsync
	jsr	My_vsync
	lea.l	Lay11_below,a0
	jsr	Fade_pal
	bne.b	T_0f466
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
T_0f750:
	lea.l	Hbl_Lay6_list,a0
	jsr	Update_HBL
	jsr	My_vsync
	jsr	My_vsync
	lea.l	Lay6_below,a0
	jsr	Fade_pal
	bne.b	T_0f750
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
	bmi.b	T_0f81c
	jsr	T_0025a
	bsr.w	T_0f616
T_0f81c:
	jmp	Exit_all
T_0f822:
	btst	#$1,Mouse_button_state
	bne.b	T_0f822
	clr.w	SaveGame_bitlist
	lea.l	B_600e6,a0
	moveq	#4,d7
T_0f83a:
	tst.l	(a0)+
	bne.b	T_0f86a
	dbra	d7,T_0f83a
	move.l	#Code0004Sys,Textfile_ptr
	move.w	#$18,ReqText_nr
	move.l	#T_0f9c6,ReqDo_ptr
	lea.l	Req_Mod,a0
	bsr.w	Push_Module
	bra.b	T_0f874
T_0f86a:
	lea.l	SaveGame_Mod,a0
	bsr.w	Push_Module
T_0f874:
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
T_0f8b6:
	tst.l	(a1)
	beq.b	T_0f8f6
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
	bne.b	T_0f8e6
	moveq	#8,d0
T_0f8e6:
	jsr	IG_Set_ink
	lea.l	$f0(a3),a0
	jsr	IG_Print
T_0f8f6:
	addq.l	#$4,a1
	addq.l	#$8,a2
	addq.w	#$1,d5
	cmpi.w	#$7,d5
	bmi.b	T_0f8b6
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
	bne.b	T_0f9d4
	bsr.w	T_0f616
T_0f9d4:
	lea.l	Chard_filename,a0
	lea.l	Chard_ptrs,a2
	lea.l	Member_1_nr,a3
	moveq	#5,d7
T_0f9e8:
	tst.l	(a2)
	beq.b	T_0f9f6
	move.w	(a3),d0
	movea.l	(a2),a1
	jsr	Save_subfile
T_0f9f6:
	addq.l	#$4,a2
	addq.l	#$2,a3
	dbra	d7,T_0f9e8
	lea.l	B_600e6,a1
	lea.l	B_5c380,a2
	lea.l	B_5bef3,a3
	move.w	SaveGame_bitlist,d0
	moveq	#1,d7
T_0fa18:
	btst	d7,d0
	beq.b	T_0fa50
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
T_0fa50:
	addq.l	#$4,a1
	addq.l	#$2,a2
	addq.l	#$1,a3
	addq.w	#$1,d7
	cmpi.w	#$7,d7
	bmi.b	T_0fa18
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
T_0fad8:
	move.w	(a0)+,d0
	move.b	d0,(a1)+
	dbra	d7,T_0fad8
	move.w	#$15ad,d7
T_0fae4:
	move.w	(a0)+,(a1)+
	dbra	d7,T_0fae4
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
	lea.l	D_321f4,a0
	jsr	Save_file
	movea.l	a1,a0
	jsr	Free_memory
	rts
T_0fb38:
	btst	#$1,Mouse_button_state
	bne.b	T_0fb38
	lsr.w	#$8,d0
	tst.w	d0
	beq.w	T_0fcc0
	move.w	Active_member,d1
	subq.w	#$1,d1
	cmp.w	d0,d1
	bne.b	T_0fb64
	move.w	#$19,d0
	jsr	Plus_message
	bra.w	T_0fcc0
T_0fb64:
	lea.l	Chard_ptrs,a0
	move.w	d0,d1
	add.w	d1,d1
	add.w	d1,d1
	tst.l	(a0,d1.w)
	beq.w	T_0fcc0
	movea.l	(a0,d1.w),a2
	move.w	$3a(a2),d1
	move.w	#$e000,d2
	and.w	d1,d2
	beq.b	T_0fb96
	move.w	#$15,d0
	jsr	Plus_message
	bra.w	T_0fcc0
T_0fb96:
	btst	#$1,d1
	beq.w	T_0fc2a
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
	bra.w	T_0fcc0
T_0fc2a:
	btst	#$a,d1
	beq.b	T_0fc3e
	move.w	#$17,d0
	jsr	Plus_message
	bra.w	T_0fcc0
T_0fc3e:
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
	bne.b	T_0fc84
	move.w	(a1)+,d0
	move.w	(a1)+,d1
	moveq	#2,d6
	moveq	#34,d7
	lea.l	$6b0(a2),a0
	jsr	Blot_unmasked_block
	jsr	Switch_screen
	jsr	Copy_screen
	bra.b	T_0fcc0
T_0fc84:
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
T_0fcc0:
	rts
T_0fcc2:
	btst	#$1,Mouse_button_state
	bne.b	T_0fcc2
	move.l	#Code0004Sys,Textfile_ptr
	move.w	#$19,ReqText_nr
	move.l	#T_0fcf2,ReqDo_ptr
	lea.l	Req_Mod,a0
	bra.w	Push_Module
T_0fcf2:
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
	beq.w	T_10064
	move.b	d0,Object_slot_number
	ext.w	d0
	subq.w	#$1,d0
	movea.l	Itemslots_ptr,a0
	movea.l	Itemdata_ptr,a1
	adda.w	d0,a0
	mulu.w	#$28,d0
	adda.w	d0,a1
	tst.b	(a0)
	beq.w	T_10064
	cmpi.b	#$8,$1(a1)
	beq.b	T_0ff4c
	move.w	#$c,d0
	jsr	Plus_message
	bra.w	T_10064
T_0ff4c:
	movea.l	Current_active_char_data,a2
	move.b	$c(a1),d0
	btst	d0,$1a(a2)
	bne.b	T_0ff6a
	move.w	#$d,d0
	jsr	Plus_message
	bra.w	T_10064
T_0ff6a:
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
	bne.w	T_10064
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
	cmp.w	$8e(a2),d0
	bls.b	T_0ffc4
	move.w	#$18,d0
	jsr	Plus_message
	bra.w	T_10064
T_0ffc4:
	moveq	#0,d0
	move.b	$e(a2),d0
	add.w	$c0(a2),d0
	jsr	Probe
	bpl.b	T_0ffe2
	move.w	#$f,d0
	jsr	Plus_message
	bra.b	T_10012
T_0ffe2:
	moveq	#0,d0
	move.b	$2(a3),d0
	sub.w	d0,$8e(a2)
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
T_10012:
	subq.b	#$1,(a0)
	moveq	#0,d0
	move.w	$22(a1),d0
	sub.l	d0,$ec(a2)
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
T_10064:
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
T_100bc:
	jsr	Update_time
	dbra	d7,T_100bc
	cmpi.b	#$2,Current_map_type
	bpl.b	T_100e0
	jsr	M2_time_evaluate
	move.w	New_radius,Current_radius
T_100e0:
	tst.b	Inn_flag
	bne.w	T_10298
	lea.l	Chard_ptrs,a0
	moveq	#1,d7
T_100f2:
	tst.l	(a0)
	beq.b	T_10148
	movea.l	(a0),a1
	move.w	#$e400,d0
	and.w	$3a(a1),d0
	bne.b	T_10148
	btst	#$4,$3a(a1)
	beq.b	T_10148
	addq.w	#$1,$ca(a1)
	move.w	$58(a1),d0
	addq.w	#$1,d0
	move.w	d0,$58(a1)
	add.w	$ac(a1),d0
	add.w	Time_data_year,d0
	move.w	$6c(a1),d1
	cmp.w	d0,d1
	bpl.b	T_10148
	ori.w	#$2000,$3a(a1)
	cmp.w	Active_member,d7
	bne.b	T_10148
	clr.w	Active_member
	bsr.w	Exit_display
	jsr	Check_party_alive
T_10148:
	addq.l	#$4,a0
	addq.w	#$1,d7
	cmpi.w	#$7,d7
	bmi.b	T_100f2
	moveq	#4,d7
	lea.l	Code0005Sys,a1
	lea.l	Chard_ptrs,a2
	moveq	#5,d6
T_10162:
	tst.l	(a2)
	beq.w	T_1028e
	movea.l	(a2),a4
	move.w	$3a(a4),d0
	andi.w	#$e400,d0
	bne.w	T_1028e
	jsr	Init_RText
	lea.l	$f0(a4),a0
	jsr	Add_ASCII_2_RText
	lea.l	Space,a0
	jsr	Add_ASCII_2_RText
	tst.w	$92(a4)
	bne.b	T_101a4
	moveq	#17,d0
	jsr	Add_encoded_2_RText
	bra.w	T_10266
T_101a4:
	moveq	#18,d0
	jsr	Add_encoded_2_RText
	moveq	#0,d0
	move.w	$88(a4),d0
	add.w	$98(a4),d0
	cmp.w	$86(a4),d0
	bpl.b	T_101c4
	moveq	#0,d0
	move.w	$86(a4),d2
	bra.b	T_101e0
T_101c4:
	move.w	d0,d1
	divu.w	#$a,d0
	bne.b	T_101ce
	moveq	#1,d0
T_101ce:
	move.w	d0,d2
	add.w	$86(a4),d2
	cmp.w	d2,d1
	bpl.b	T_101e0
	move.w	d1,d2
	move.w	d1,d0
	sub.w	$86(a4),d0
T_101e0:
	move.w	d2,$86(a4)
	lea.l	Number_buffer,a0
	movea.l	a0,a3
	bsr.w	LConvert_number
	moveq	#0,d0
	move.w	$8c(a4),d0
	add.w	$9a(a4),d0
	cmp.w	$8a(a4),d0
	bpl.b	T_10208
	moveq	#0,d0
	move.w	$8a(a4),d2
	bra.b	T_10220
T_10208:
	move.w	d0,d1
	divu.w	#$a,d0
	move.w	d0,d2
	add.w	$8a(a4),d2
	cmp.w	d2,d1
	bpl.b	T_10220
	move.w	d1,d2
	move.w	d1,d0
	sub.w	$8a(a4),d0
T_10220:
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
T_10266:
	jsr	T_0707a
	jsr	Switch_screen
	jsr	Copy_screen
	jsr	Exit_RText
T_1027e:
	btst	#$1,Mouse_button_state
	bne.b	T_1027e
	jsr	Wait_4_user
T_1028e:
	addq.l	#$4,a2
	dbra	d6,T_10162
	bra.w	T_1037c
T_10298:
	moveq	#4,d7
	lea.l	Code0005Sys,a1
	lea.l	Chard_ptrs,a2
	moveq	#5,d6
T_102a8:
	tst.l	(a2)
	beq.w	T_10376
	movea.l	(a2),a4
	move.w	$3a(a4),d0
	andi.w	#$e400,d0
	bne.w	T_10376
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
	bpl.b	T_102f2
	moveq	#0,d0
T_102f2:
	add.w	d0,$86(a4)
	lea.l	Number_buffer,a0
	movea.l	a0,a3
	bsr.w	LConvert_number
	moveq	#0,d0
	move.w	$8c(a4),d0
	add.w	$9a(a4),d0
	sub.w	$8a(a4),d0
	bpl.b	T_10314
	moveq	#0,d0
T_10314:
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
T_10366:
	btst	#$1,Mouse_button_state
	bne.b	T_10366
	jsr	Wait_4_user
T_10376:
	addq.l	#$4,a2
	dbra	d6,T_102a8
T_1037c:
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
T_103b8:
	btst	#$1,Mouse_button_state
	bne.b	T_103b8
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
	bpl.b	T_1058c
	moveq	#2,d3
T_1058c:
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
T_1061c:
	tst.l	(a1)
	beq.b	T_10628
	move.b	(a2),d0
	ext.w	d0
	move.b	d7,(a0,d0.w)
T_10628:
	addq.l	#$4,a1
	addq.l	#$1,a2
	addq.w	#$1,d7
	cmpi.w	#$7,d7
	bmi.b	T_1061c
	bra.w	T_10658
T_10638:
	lea.l	B_5b526,a0
	lea.l	B_5eed0,a1
	moveq	#11,d7
T_10646:
	move.b	-(a0),d0
	beq.b	T_10650
	ext.w	d0
	move.b	d7,-$1(a1,d0.w)
T_10650:
	dbra	d7,T_10646
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
T_106bc:
	lea.l	Hbl_Lay6_list,a0
	jsr	Update_HBL
	jsr	My_vsync
	jsr	My_vsync
	lea.l	Lay6_below,a0
	jsr	Fade_pal
	bne.b	T_106bc
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
T_10728:
	move.w	(a2)+,d0
	move.w	(a2)+,d1
	move.b	(a3)+,d2
	beq.b	T_10748
	ext.w	d2
	add.w	d2,d2
	add.w	d2,d2
	movea.l	-$4(a1,d2.w),a0
	lea.l	$6b0(a0),a0
	moveq	#2,d6
	jsr	Blot_unmasked_block
	bra.b	T_1075c
T_10748:
	move.w	d0,d2
	move.w	d1,d3
	addi.w	#$1f,d2
	addi.w	#$1f,d3
	moveq	#3,d6
	jsr	Draw_box
T_1075c:
	dbra	d5,T_10728
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
	beq.b	T_107ac
	lea.l	B_5b519,a0
	ext.w	d0
	adda.w	d0,a0
	tst.b	(a0)
	beq.b	T_107ac
	move.b	d0,B_5b526
	move.w	#$0,B_5b518
	lea.l	D_2feda,a0
	bsr.w	Push_Module
T_107ac:
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
	bne.b	T_107fa
	move.w	d0,d2
	move.w	d1,d3
	addi.w	#$1f,d2
	addi.w	#$1f,d3
	moveq	#1,d6
	jsr	Draw_box
	bra.b	T_1082a
T_107fa:
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
T_1082a:
	rts
T_1082c:
	btst	#$1,Mouse_button_state
	bne.b	T_1082c
	tst.b	d0
	beq.b	T_1088e
	cmp.b	B_5b526,d0
	bne.b	T_10846
	bra.w	T_10890
T_10846:
	lea.l	B_5b519,a0
	ext.w	d0
	adda.w	d0,a0
	lea.l	B_5b519,a1
	move.b	B_5b526,d0
	ext.w	d0
	adda.w	d0,a1
	tst.b	(a0)
	bne.b	T_1086a
	move.b	(a1),(a0)
	clr.b	(a1)
	bra.b	T_10870
T_1086a:
	move.b	(a1),d0
	move.b	(a0),(a1)
	move.b	d0,(a0)
T_10870:
	bsr.w	T_106f0
	jsr	Switch_screen
	jsr	Copy_screen
T_10880:
	btst	#$1,Mouse_button_state
	bne.b	T_10880
	bsr.w	Pop_Module
T_1088e:
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
