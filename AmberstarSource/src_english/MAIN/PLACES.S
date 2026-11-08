; MAIN/PLACES.ASM (original module, merged with the disassembly of the shipped program)

	section	text

Places:
	moveq	#0,d0
	move.b	$1(a5),d0
	beq.b	T_0aab6
	move.w	Hour,d1
	cmp.w	d1,d0
	ble.b	T_0aaae
T_0aa80:
	jsr	T_01f98
	moveq	#0,d0
	move.b	$4(a5),d0
	cmpi.w	#$1a,d0
	beq.b	T_0aaf4
	move.w	d0,WText_nr
	move.l	Maptext_ptr,Textfile_ptr
	lea.l	TxtW_Mod,a0
	bsr.w	Push_Module
	bra.b	T_0aaf4
T_0aaae:
	move.b	$2(a5),d0
	cmp.w	d0,d1
	bge.b	T_0aa80
T_0aab6:
	lea.l	D_48a24,a0
	move.w	$6(a5),d0
	mulu.w	#$18,d0
	adda.w	d0,a0
	move.l	a0,Placedat_ptr
	moveq	#0,d0
	move.b	$3(a5),d0
	add.w	d0,d0
	add.w	d0,d0
	move.l	.l_0aaf2(pc,d0.w),d0
	bne.b	.l_0aaea
	lea.l	D_2ef09,a1
	jsr	DI_Error
	bra.b	T_0aaf4
.l_0aaea:
	dc.b	$61,$00,$5e,$22,$20,$40,$61,$00
.l_0aaf2:
	dc.b	$5e,$7e
T_0aaf4:
	rts
	dc.l	Guild_Mod
	dc.l	Guild_Mod
	dc.l	Guild_Mod
	dc.l	Guild_Mod
	dc.l	Guild_Mod
	dc.l	Guild_Mod
	dc.l	Guild_Mod
	dc.l	Guild_Mod
	dc.l	MerchOBJC_Mod
	dc.l	MerchFOOD_Mod
	dc.b	$00,$00,$00,$00
	dc.l	MerchHORSE_Mod
	dc.l	Healer_Mod
	dc.l	Sage_Mod
	dc.l	MerchRAFT_Mod
	dc.l	MerchSHIP_Mod
	dc.l	Inn_Mod
	dc.l	MerchMAGIC_Mod
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00
T_0ab46:
	jsr	T_0025a
Places_ModInit:
	clr.w	Places_gold
	movea.l	Event_data_ptr,a0
	moveq	#0,d0
	move.b	$3(a0),d0
	move.w	d0,Place_nr
	lea.l	T_0ac2c,a0
	move.b	-$1(a0,d0.w),d0
	lea.l	D_260c0,a0
	bsr.w	Load_80x80_picture
	cmpi.w	#$9,Place_nr
	beq.b	.l_0ab8c
	cmpi.w	#$12,Place_nr
	bne.b	.l_0abc6
.l_0ab8c:
	movea.l	Event_data_ptr,a0
	move.w	$8(a0),d0
	lea.l	D_2f240,a0
	jsr	Load_subfile
	move.l	a0,Waredat_ptr
	lea.l	B_5b9e2,a0
	mulu.w	#$c,d0
	adda.w	d0,a0
	move.l	a0,Warecount_ptr
	lea.l	Sold_slots,a0
	clr.l	(a0)+
	clr.l	(a0)+
	clr.l	(a0)
.l_0abc6:
	jsr	T_00208
	bsr.w	Init_display
	move.w	Place_nr,d0
	move.b	T_0ac16+1(pc,d0.w),d0
	ext.w	d0
	bmi.b	T_0ac16
	lea.l	Lay3_PA,a0
	bsr.w	Push_PA
	lea.l	Lay3_PlusMes,a0
	jsr	Push_MA
	lea.l	Code0008Sys,a1
	bsr.w	Mr_Blue_Sky
	jsr	Pop_MA
	bsr.w	Pop_PA
	cmpi.w	#$9,Place_nr
	bpl.b	T_0ac16
	bsr.w	Update_guild_messages
T_0ac16:
	rts
	dc.b	$10,$10,$10,$10,$10,$10,$10,$10,$ff,$ff,$ff,$ff,$ff,$0f,$ff,$ff
	dc.b	$0e,$ff,$ff,$ff
T_0ac2c:
	dc.b	$03,$03,$03,$03,$03,$03,$03,$03,$04,$04,$06,$07,$08,$0a,$0e,$0e
	dc.b	$0f,$17,$00,$00
; ---- Places_ModExit (original source: MAIN/PLACES.ASM)
Places_ModExit:
	movea.l	Pic80_ptr,a0
	jsr	Free_memory
	cmpi.w	#9,Place_nr
	beq.s	.Yes
	cmpi.w	#18,Place_nr
	bne.s	.No
.Yes:
	movea.l	Waredat_ptr,a0
	jmp	Free_memory
.No:
	rts	
; ---- Exit_PLACES (original source: MAIN/PLACES.ASM)
Exit_PLACES:
	tst.w	Places_gold
	bne.s	.No_exit
	cmpi.w	#10,Place_nr
	bne.s	.No1
	tst.w	Places_food
	beq.w	Do_PlacesExit
	bra.s	.No_exit
.No1:
	cmpi.w	#9,Place_nr
	beq.s	.Yes
	cmpi.w	#18,Place_nr
	bne.s	Do_PlacesExit
.Yes:
	lea.l	Sold_slots,a0
	tst.l	(a0)+
	bne.s	.No_exit
	tst.l	(a0)+
	bne.s	.No_exit
	tst.l	(a0)
	beq.s	Do_PlacesExit
.No_exit:
	move.w	Place_nr,d0
	move.b	.Exit_txts-1(pc,d0.w),d0
	ext.w	d0
	move.w	d0,ReqText_nr
	lea.l	Code0002Sys,a0
	cmpi.w	#17,Place_nr
	bne.s	.No2
	lea.l	Code0003Sys,a0
.No2:
	move.l	a0,Textfile_ptr
	move.l	#Do_PlacesExit,ReqDo_ptr
	lea.l	Req_Mod,a0
	bra.w	Push_Module
.Exit_txts:
	dc.b	8,8,8,8,8,8,8,8,17,17,-1,18,21,18,18,18,5,17,-1,-1
	even	
Do_PlacesExit:
	jsr	T_01f98
	bsr.w	Exit_display
	bsr.w	Pop_Module
	cmpi.w	#$11,Place_nr
	bne.b	.l_0ad32
	tst.b	Inn_flag
	beq.b	.l_0ad32
	lea.l	Camp_Mod,a0
	bsr.w	Push_Module
.l_0ad32:
	bra.w	Init_display
; ---- Pool_gold_PLACES (original source: MAIN/PLACES.ASM)
Pool_gold_PLACES:
	suba.l	a0,a0
	move.w	Places_gold,d0
	moveq.l	#0,d1
	moveq.l	#-1,d2
	lsr.l	#1,d2
	jsr	Pool_gold
	add.w	d0,Places_gold
	rts	
; ---- Divide_gold_PLACES (original source: MAIN/PLACES.ASM)
Divide_gold_PLACES:
	moveq.l	#0,d0
	move.w	Places_gold,d0
	bsr.w	Divide_gold
	move.w	d0,Places_gold
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	rts	
; ---- Transfer_gold_PLACES (original source: MAIN/PLACES.ASM)
Transfer_gold_PLACES:
	move.w	#112,Mesmin_X
	move.w	#63,Mesmin_Y
	move.w	#192,Mesmin_Wd
	move.l	#Code0001Sys,Textfile_ptr
	movea.l	Off_screen,a6
	move.w	#6,d0
	bsr.w	Minus_message
	jsr	Switch_screen
	jsr	Copy_screen
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	moveq.l	#0,d0
	move.w	Places_gold,d0
	move.l	d0,Original_number
	clr.l	ItemW_nr
	lea.l	TransGoldPLACES_Mod,a0
	bsr.w	Push_Module
	rts	
T_0add6:
	move.l	ItemW_nr,d0
	beq.b	.l_0ae18
	move.w	d0,d1
	mulu.w	#$a,d0
	suba.l	a0,a0
	jsr	Scan_4_gold_victims
	bne.b	.l_0adf8
	move.w	#$5,d0
	bsr.w	Plus_message
	bra.b	.l_0ae18
.l_0adf8:
	jsr	Show_transfer_victims
	move.l	#.l_0ae24,TIVS_Ptr
	lea.l	TIVS2_Mod,a0
	move.w	#$19,$2c(a0)
	bsr.w	Push_Module
.l_0ae18:
	btst	#$1,Mouse_button_state
	bne.b	.l_0ae18
	rts
.l_0ae24:
	move.l	ItemW_nr,d0
	add.w	d0,$90(a0)
	sub.w	d0,Places_gold
	mulu.w	#$a,d0
	add.l	d0,$ec(a0)
	rts
; ---- Places_CIL_evaluate (original source: MAIN/PLACES.ASM)
Places_CIL_evaluate:
	movem.l	d0/d7/a1/a2,-(sp)
	bclr	#7,6(a0)
	bclr	#7,7(a0)
	bclr	#7,8(a0)
	tst.w	Places_gold
	bne.s	.Ok1
	bset	#7,7(a0)
	bset	#7,8(a0)
.Ok1:
	lea.l	Chard_ptrs,a1
	moveq.l	#6-1,d7
.Loop:
	tst.l	(a1)
	beq.s	.Next
	movea.l	(a1)+,a2
	move.w	#$0402,d0
	and.w	Body_conditions(a2),d0
	bne.s	.Next
	tst.w	Gold_coins(a2)
	bne.s	.Ok2
.Next:
	dbra	d7,.Loop
	bset	#7,6(a0)
.Ok2:
	movem.l	(sp)+,d0/d7/a1/a2
	rts	
; ---- Display_gold (original source: MAIN/PLACES.ASM)
Display_gold:
	movem.l	d0-d2/d7/a0/a3/a6,-(sp)
	moveq.l	#15,d0
	jsr	IG_Set_ink
	moveq.l	#2,d0
	jsr	IG_Set_paper
	move.w	Places_gold,d0
	moveq.l	#"0",d1
	moveq.l	#5,d7
	lea.l	GoldDis_text,a0
	movea.l	a0,a3
	bsr.w	RConvert_number
	move.w	#112,d0
	move.w	#113+8,d1
	move.w	#64,d2
	movea.l	Off_screen,a6
	bsr.w	Print_centered_string
	movem.l	(sp)+,d0-d2/d7/a0/a3/a6
	rts	
; ---- Places_DisInit (original source: MAIN/PLACES.ASM)
Places_DisInit:
	movem.l	d0-d2/a0,-(sp)
	moveq.l	#15,d0
	jsr	IG_Set_ink
	moveq.l	#-1,d0
	jsr	IG_Set_paper
	movea.l	Event_data_ptr,a0
	move.w	6(a0),d0
	subq.w	#1,d0
	mulu.w	#30,d0
	movea.l	Placetext_ptr,a0
	adda.w	d0,a0
	clr.b	29(a0)
	moveq.l	#16,d0
	moveq.l	#39,d1
	move.w	#320,d2
	bsr.w	Print_centered_string
	move.w	#112,d0
	move.w	#113,d1
	move.w	#64,d2
	lea.l	Gold_txt,a0
	bsr.w	Print_centered_string
	movem.l	(sp)+,d0-d2/a0
	rts	
; ---- Guild_DisUpd (original source: MAIN/PLACES.ASM)
Guild_DisUpd:
	bsr.w	Update_status_block
	lea.l	Guild_CIL,a0
	lea.l	GuildCIL_evaluate,a1
	bsr.w	Update_control_icons
	bsr.w	Display_gold
	rts	
Guild_DisInit:
	move.l	#Lay3_PlusMes,PlusMes_info
	movea.l	Off_screen,a6
	moveq	#3,d0
	bsr.w	Show_layout
	bsr.w	Display_80x80_picture
	bsr.w	Places_DisInit
	lea.l	Guild_CIL,a0
	bsr.w	GuildCIL_evaluate
	move.l	a0,Control_list_ptr
	bsr.w	Show_control_icons
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	Lay3_L2,a0
	jsr	Set_layout_data
	bra.w	Fadein_lay3
Update_guild_messages:
	movem.l	d0-d1/d7/a0-a5,-(a7)
	lea.l	Lay3_PA,a0
	bsr.w	Push_PA
	bsr.w	Init_RText
	movea.l	Current_active_char_data,a2
	movea.l	Placedat_ptr,a4
	lea.l	D_4738e,a5
	move.w	Place_nr,d0
	mulu.w	#$18a,d0
	adda.w	d0,a5
	moveq	#0,d0
	move.b	$1b(a2),d0
	add.w	d0,d0
	add.w	d0,d0
	adda.w	d0,a5
	tst.b	$5(a2)
	bne.b	.l_0b036
	move.w	Place_nr,d0
	move.w	$46(a2),d1
	btst	d0,d1
	beq.b	.l_0b036
	move.l	(a5),d0
	cmp.l	$cc(a2),d0
	bgt.b	.l_0b036
	lea.l	Code0003Sys,a1
	move.w	#$13,d0
	bsr.w	Add_encoded_2_RText
	lea.l	Number_buffer,a0
	movea.l	a0,a3
	moveq	#0,d0
	move.w	(a4),d0
	moveq	#4,d7
	bsr.w	LConvert_number
	move.b	#$20,(a3)+
	clr.b	(a3)
	bsr.w	Add_ASCII_2_RText
	lea.l	Gold_txt,a0
	bsr.w	Add_ASCII_2_RText
	lea.l	Return,a0
	bsr.w	Add_ASCII_2_RText
	bsr.w	Add_ASCII_2_RText
.l_0b036:
	move.w	Place_nr,d0
	cmp.b	$5(a2),d0
	bne.b	.l_0b094
	cmpi.b	#$32,$1b(a2)
	bpl.b	.l_0b094
	move.l	(a5),d0
	cmp.l	$cc(a2),d0
	bgt.b	.l_0b094
	lea.l	Code0003Sys,a1
	move.w	#$14,d0
	bsr.w	Add_encoded_2_RText
	lea.l	Number_buffer,a0
	movea.l	a0,a3
	move.w	$2(a4),d0
	moveq	#4,d7
	bsr.w	LConvert_number
	move.b	#$20,(a3)+
	clr.b	(a3)
	bsr.w	Add_ASCII_2_RText
	lea.l	Gold_txt,a0
	bsr.w	Add_ASCII_2_RText
	lea.l	Return,a0
	bsr.w	Add_ASCII_2_RText
	bsr.w	Add_ASCII_2_RText
.l_0b094:
	tst.b	$5(a2)
	bne.b	.l_0b0aa
	move.w	Place_nr,d0
	move.w	$46(a2),d1
	btst	d0,d1
	bne.b	.l_0b0be
	bra.b	.l_0b104
.l_0b0aa:
	move.w	Place_nr,d0
	cmp.b	$5(a2),d0
	bne.b	.l_0b104
	cmpi.b	#$32,$1b(a2)
	bpl.b	.l_0b104
.l_0b0be:
	move.l	(a5),d1
	sub.l	$cc(a2),d1
	ble.b	.l_0b104
	lea.l	$f0(a2),a0
	bsr.w	Add_ASCII_2_RText
	lea.l	Space,a0
	bsr.w	Add_ASCII_2_RText
	lea.l	Code0004Sys,a1
	move.w	#$11,d0
	bsr.w	Add_encoded_2_RText
	lea.l	Number_buffer,a0
	movea.l	a0,a3
	move.l	d1,d0
	moveq	#4,d7
	bsr.w	LConvert_number
	bsr.w	Add_ASCII_2_RText
	lea.l	D_26128,a0
	bsr.w	Add_ASCII_2_RText
.l_0b104:
	bsr.w	T_0707a
	jsr	Switch_screen
	jsr	Copy_screen
	bsr.w	Exit_RText
	bsr.w	Pop_PA
	movem.l	(a7)+,d0-d1/d7/a0-a5
	rts
GuildCIL_evaluate:
	movem.l	d0-d1/a1-a3,-(a7)
	bclr	#$7,$0(a0)
	bclr	#$7,$3(a0)
	movea.l	Current_active_char_data,a1
	movea.l	Placedat_ptr,a2
	lea.l	D_4738e,a3
	move.w	Place_nr,d0
	mulu.w	#$18a,d0
	adda.w	d0,a3
	moveq	#0,d0
	move.b	$1b(a1),d0
	add.w	d0,d0
	add.w	d0,d0
	adda.w	d0,a3
	tst.b	$5(a1)
	bne.b	.l_0b182
	move.w	Places_gold,d0
	cmp.w	(a2),d0
	bmi.b	.l_0b182
	move.w	Place_nr,d0
	move.w	$46(a1),d1
	btst	d0,d1
	beq.b	.l_0b182
	move.l	(a3),d0
	cmp.l	$cc(a1),d0
	ble.b	.l_0b188
.l_0b182:
	bset	#$7,$0(a0)
.l_0b188:
	move.w	Place_nr,d0
	cmp.b	$5(a1),d0
	bne.b	.l_0b1b0
	move.w	Places_gold,d0
	cmp.w	$2(a2),d0
	bmi.b	.l_0b1b0
	cmpi.b	#$32,$1b(a1)
	bpl.b	.l_0b1b0
	move.l	(a3),d0
	cmp.l	$cc(a1),d0
	ble.b	.l_0b1b6
.l_0b1b0:
	bset	#$7,$3(a0)
.l_0b1b6:
	bsr.w	Places_CIL_evaluate
	movem.l	(a7)+,d0-d1/a1-a3
	rts
T_0b1c0:
	btst	#$1,Mouse_button_state
	bne.b	T_0b1c0
	move.w	#$0,Draw_Cicon
	jsr	My_vsync
	movea.l	Placedat_ptr,a0
	move.w	(a0),d0
	sub.w	d0,Places_gold
	movea.l	Current_active_char_data,a0
	move.w	Place_nr,d0
	move.b	d0,$5(a0)
	lea.l	D_47384,a2
	move.w	Place_nr,d0
	mulu.w	#$18a,d0
	adda.w	d0,a2
	lea.l	$10(a0),a1
	moveq	#9,d7
.l_0b20e:
	move.b	(a2)+,(a1)+
	dbra	d7,.l_0b20e
	lea.l	$70(a0),a1
	lea.l	$168(a2),a2
	moveq	#10,d7
.l_0b21e:
	move.w	(a2)+,(a1)+
	dbra	d7,.l_0b21e
	move.b	(a2)+,$1a(a0)
	bsr.w	Increase_level
	rts
T_0b22e:
	btst	#$1,Mouse_button_state
; ---- Make_level (original source: MAIN/PLACES.ASM)
; CHANGE: removed "Wait_4_unclick"
Make_level:
	bne.s	*-8
	move.w	#$0,Draw_Cicon	; CHANGE: was "Wait_4_unclick"
	jsr	My_vsync	; CHANGE: added
	movea.l	Placedat_ptr,a0
	move.w	2(a0),d0
	sub.w	d0,Places_gold
	movea.l	Current_active_char_data,a0
; ---- Increase_level (original source: MAIN/PLACES.ASM)
Increase_level:
	addq.b	#1,Level_nr(a0)
	moveq.l	#0,d0
	move.b	Level_nr(a0),d0
	subq.w	#$1,d0	; CHANGE: added
	move.w	Special_1(a0),d1
	beq.s	.Zero
	divu.w	d1,d0
	addq.w	#$1,d0	; CHANGE: added
	move.b	d0,Attacks_per_round(a0)
.Zero:
	moveq.l	#0,d0
	move.w	Attr_5_normal(a0),d0
	add.w	Attr_5_normal_magic(a0),d0
	divu.w	#10,d0
	add.w	Special_2(a0),d0
	add.w	d0,Life_points_max(a0)
	tst.b	Spell_class_counter(a0)
	beq.s	.No_magic
	moveq.l	#0,d0
	move.w	Attr_2_normal(a0),d0
	add.w	Attr_2_normal_magic(a0),d0
	divu.w	#20,d0
	move.w	d0,d1
	add.w	Special_3(a0),d0
	add.w	d0,Power_points_max(a0)
	add.w	Special_4(a0),d1
	add.w	d1,Nr_spell_learn_points(a0)
.No_magic:
	move.l	#Code0004Sys,Textfile_ptr
	move.w	#18,d0
	bsr.w	Plus_message
	lea.l	SkillW_Mod,a0
	bsr.w	Push_Module
	rts	
; ---- Guild_Member_left (original source: MAIN/PLACES.ASM)
Guild_Member_left:
	andi.l	#$0000ff00,d0
	beq.s	.Exit
	lsr.w	#6,d0
	move.w	d0,d1
	lea.l	Chard_ptrs,a0
	move.l	-$4(a0,d0.w),d0	; CHANGE: was "movea.l -4(a0,d0.w),a0"
	beq.b	.Exit	; CHANGE: added
	movea.l	d0,a0	; CHANGE: added
	move.w	Body_conditions(a0),d0
	andi.w	#$e406,d0	; CHANGE: was "andi.w #$e506,d0"
	bne.s	.Exit
	lsr.w	#2,d1
	move.w	d1,Active_member
	lea.l	Chard_ptrs,a0
	add.w	d1,d1
	add.w	d1,d1
	move.l	-4(a0,d1.w),Current_active_char_data
	bsr.w	Update_guild_messages
.Exit:
	rts	
SkillW_ModInit:
	moveq	#32,d0
	moveq	#37,d1
	moveq	#10,d2
	moveq	#8,d3
	moveq	#2,d4
	moveq	#1,d6
	lea.l	D_2f502,a0
	jsr	Open_window
	move.w	d0,B_58256
	movea.l	Off_screen,a6
	move.w	#$30,d0
	move.w	#$3c,d1
	move.w	d0,d2
	addi.w	#$7f,d2
	move.w	d1,d3
	addi.w	#$46,d3
	moveq	#3,d6
	jsr	Draw_box
	moveq	#2,d6
	moveq	#16,d7
	move.w	#$30,d0
	move.w	#$85,d1
	lea.l	D_39d60,a0
	jsr	Blot_unmasked_block
	moveq	#-1,d0
	jsr	IG_Set_paper
	moveq	#1,d0
	jsr	IG_Set_ink
	move.w	#$30,d0
	move.w	#$35,d1
	move.w	#$80,d2
	jsr	IG_Set_cursor
	lea.l	Skills_name,a0
	bsr.w	Print_centered_string
	moveq	#15,d0
	jsr	IG_Set_ink
	move.w	#$3d,d2
	moveq	#0,d6
	moveq	#2,d7
	movea.l	Current_active_char_data,a1
	lea.l	D_48488,a2
	lea.l	$6(a1),a4
	lea.l	$b0(a1),a5
.l_0b3bc:
	move.w	#$32,d0
	move.w	d2,d1
	jsr	IG_Set_cursor
	move.w	d6,d0
	add.w	d0,d0
	move.w	(a2,d0.w),d0
	bsr.w	Get_word
	lea.l	Line_buffer,a0
	clr.b	$7(a0)
	jsr	IG_Print
	move.w	#$66,d0
	move.w	d2,d1
	jsr	IG_Set_cursor
	lea.l	Skill_txt,a0
	movea.l	a0,a3
	moveq	#48,d1
	moveq	#0,d0
	move.b	(a4)+,d0
	add.w	(a5)+,d0
	bsr.w	RConvert_number
	addq.l	#$2,a3
	moveq	#0,d0
	move.b	$9(a4),d0
	bsr.w	RConvert_number
	jsr	IG_Print
	jsr	IG_Carriage_return
	addq.w	#$7,d2
	addq.w	#$1,d6
	cmpi.w	#$a,d6
	bmi.b	.l_0b3bc
	lea.l	Make_level_offsets,a0
	clr.l	(a0)+
	clr.l	(a0)+
	clr.w	(a0)
	movea.l	Current_active_char_data,a0
	move.w	$78(a0),d0
	bne.b	.l_0b440
	moveq	#10,d0
.l_0b440:
	move.w	d0,Remaining_offset
	lea.l	$6(a0),a0
	lea.l	Possible_level_offsets,a1
	moveq	#0,d0
	moveq	#0,d1
	moveq	#9,d7
.l_0b456:
	move.b	$a(a0),d0
	sub.b	(a0)+,d0
	move.b	d0,(a1)+
	add.w	d0,d1
	dbra	d7,.l_0b456
	cmp.w	Remaining_offset,d1
	bpl.b	.l_0b472
	move.w	d1,Remaining_offset
.l_0b472:
	tst.w	Remaining_offset
	beq.b	.l_0b484
	move.w	-(a1),d0
	or.w	-(a1),d0
	or.w	-(a1),d0
	or.w	-(a1),d0
	or.w	-(a1),d0
.l_0b484:
	seq.b	Exit_on
	beq.b	.l_0b4a4
	move.w	#$30,d0
	move.w	#$85,d1
	moveq	#2,d6
	moveq	#16,d7
	lea.l	Chequered,a0
	jsr	Blot_masked_block
.l_0b4a4:
	jsr	Switch_screen
	jsr	Copy_screen
	rts
SkillW_ModExit:
	move.w	B_58256,d0
	jsr	Close_window
	rts
; ---- SkillW_DisUpd (original source: MAIN/PLACES.ASM)
SkillW_DisUpd:
	moveq.l	#6,d0
	jsr	IG_Set_ink
	moveq.l	#3,d0
	jsr	IG_Set_paper
	move.w	#154,d2
	move.w	#37+24,d3
	moveq.l	#10-1,d6
	moveq.l	#2,d7
	lea.l	Make_level_txt,a0
	lea.l	Make_level_offsets,a1
	movea.l	Off_screen,a6
.Loop:
	move.w	d2,d0
	move.w	d3,d1
	jsr	IG_Set_cursor
	moveq.l	#0,d0
	move.b	(a1)+,d0
	moveq.l	#"0",d1
	movea.l	a0,a3
	bsr.w	RConvert_number
	jsr	IG_Print
	addq.w	#7,d3
	dbra	d6,.Loop
	moveq.l	#15,d0
	jsr	IG_Set_ink
	moveq.l	#2,d0
	jsr	IG_Set_paper
	move.w	#96,d0
	move.w	#137,d1
	jsr	IG_Set_cursor
	move.w	Remaining_offset,d0
	moveq.l	#"0",d1
	lea.l	Bonus_txt,a0
	lea.l	8(a0),a3
	bsr.w	RConvert_number
	jsr	IG_Print
	rts	
; ---- Inc_skill (original source: MAIN/PLACES.ASM)
Inc_skill:
	tst.w	Remaining_offset
	beq.w	.Exit
	lsr.w	#8,d0
	lea.l	Possible_level_offsets-1,a1
	adda.w	d0,a1
	tst.b	(a1)
	beq.s	.Exit
	movea.l	Current_active_char_data,a0
	lea.l	Skill_1-1(a0),a0
	addq.b	#1,0(a0,d0.w)
	bsr.w	Reprint_skill
	lea.l	Make_level_offsets-1,a0
	adda.w	d0,a0
	addq.b	#1,(a0)
	subq.w	#1,Remaining_offset
	subq.b	#1,(a1)
	bne.s	.Ok
	lea.l	Possible_level_offsets,a0
	move.w	(a0)+,d0
	or.w	(a0)+,d0
	or.w	(a0)+,d0	; CHANGE: added
	or.w	(a0)+,d0	; CHANGE: added
	or.w	(a0)+,d0	; CHANGE: added
	beq.s	.Done
.Ok:
	tst.w	Remaining_offset
	bne.s	.Exit
.Done:
	moveq.l	#2,d6
	moveq.l	#16,d7
	move.w	#32+16,d0
	move.w	#37+16+80,d1
	lea.l	Control_icn+7680,a0
	movea.l	Off_screen,a6
	jsr	Blot_unmasked_block
	jsr	Switch_screen
	jsr	Copy_screen
	st	Exit_on
.Exit:
	rts	
; ---- Dec_skill (original source: MAIN/PLACES.ASM)
Dec_skill:
	lea.l	Make_level_offsets-1,a0
	lsr.w	#8,d0
	adda.w	d0,a0
	tst.b	(a0)
	beq.s	.Exit
	movea.l	Current_active_char_data,a1
	lea.l	Skill_1-1(a1),a1
	adda.w	d0,a1
	tst.b	(a1)
	beq.s	.Exit
	subq.b	#1,(a1)
	bsr.w	Reprint_skill
	subq.b	#1,(a0)
	lea.l	Possible_level_offsets-1,a0
	adda.w	d0,a0
	addq.b	#1,(a0)
	tst.w	Remaining_offset
	bne.s	.Skip
	moveq.l	#2,d6
	moveq.l	#16,d7
	move.w	#32+16,d0
	move.w	#37+16+80,d1
	lea.l	Chequered,a0
	movea.l	Off_screen,a6
	jsr	Blot_masked_block
	jsr	Switch_screen
	jsr	Copy_screen
	sf	Exit_on
.Skip:
	addq.w	#1,Remaining_offset
.Exit:
	rts	
; ---- Reprint_skill (original source: MAIN/PLACES.ASM)
Reprint_skill:
	movem.l	d0-d2/d6/d7/a0-a3/a6,-(sp)
	move.w	d0,d2
	movea.l	Off_screen,a6
	moveq.l	#15,d0
	jsr	IG_Set_ink
	moveq.l	#3,d0
	jsr	IG_Set_paper
	move.w	#48+9*6,d0
	move.w	d2,d1
	mulu.w	#7,d1
	addi.w	#61-7,d1
	jsr	IG_Set_cursor
	movea.l	Current_active_char_data,a1
	lea.l	$ae(a1),a2	; CHANGE: was "lea.l Skill_1_normal_magic(a1),a2"
	lea.l	Skill_1-1(a1),a1
	adda.w	d2,a1
	adda.w	d2,a2
	adda.w	d2,a2
	lea.l	Skill_txt,a0	; CHANGE: was "lea.l Skill_txt,a3"
	movea.l	a0,a3	; CHANGE: was "moveq.l #"0",d1"
	moveq	#48,d1	; CHANGE: added
	moveq.l	#2,d7
	moveq.l	#0,d0
	move.b	(a1),d0
	add.w	(a2),d0
	bsr.w	RConvert_number
	addq.l	#2,a3
	moveq.l	#0,d0
	move.b	10(a1),d0
	bsr.w	RConvert_number
; CHANGE: removed "lea.l Skill_txt,a0"
	jsr	IG_Print
	jsr	Switch_screen
	jsr	Copy_screen
	movem.l	(sp)+,d0-d2/d6/d7/a0-a3/a6
	rts	
T_0b6c4:
	tst.b	Exit_on
	beq.w	.l_0b7d2
	bsr.w	Pop_Module
.l_0b6d2:
	btst	#$1,Mouse_button_state
	bne.b	.l_0b6d2
	movea.l	Current_active_char_data,a2
	lea.l	Lay3_PA,a0
	bsr.w	Push_PA
	bsr.w	Init_RText
	lea.l	$f0(a2),a0
	bsr.w	Add_ASCII_2_RText
	lea.l	Space,a0
	bsr.w	Add_ASCII_2_RText
	lea.l	Code0004Sys,a1
	moveq	#19,d0
	bsr.w	Add_encoded_2_RText
	lea.l	Number_buffer,a0
	movea.l	a0,a3
	moveq	#0,d0
	move.b	$1b(a2),d0
	moveq	#2,d7
	bsr.w	LConvert_number
	move.b	#$20,(a3)+
	clr.b	(a3)
	bsr.w	Add_ASCII_2_RText
	moveq	#20,d0
	bsr.w	Add_encoded_2_RText
	lea.l	Return,a0
	bsr.w	Add_ASCII_2_RText
	moveq	#21,d0
	bsr.w	Add_encoded_2_RText
	lea.l	Number_buffer,a0
	movea.l	a0,a3
	move.w	$88(a2),d0
	add.w	$98(a2),d0
	moveq	#3,d7
	bsr.w	LConvert_number
	bsr.w	Add_ASCII_2_RText
	tst.b	$1a(a2)
	beq.b	.l_0b7b2
	lea.l	Return,a0
	bsr.w	Add_ASCII_2_RText
	moveq	#22,d0
	bsr.w	Add_encoded_2_RText
	lea.l	Number_buffer,a0
	movea.l	a0,a3
	move.w	$8c(a2),d0
	add.w	$9a(a2),d0
	moveq	#3,d7
	bsr.w	LConvert_number
	bsr.w	Add_ASCII_2_RText
	lea.l	Return,a0
	bsr.w	Add_ASCII_2_RText
	moveq	#23,d0
	bsr.w	Add_encoded_2_RText
	lea.l	Number_buffer,a0
	movea.l	a0,a3
	move.w	$8e(a2),d0
	moveq	#3,d7
	bsr.w	LConvert_number
	bsr.w	Add_ASCII_2_RText
.l_0b7b2:
	bsr.w	T_0707a
	jsr	Switch_screen
	jsr	Copy_screen
	bsr.w	Wait_4_user
	bsr.w	Exit_RText
	bsr.w	Pop_PA
	bsr.w	Update_guild_messages
.l_0b7d2:
	rts
; ---- MerchOBJC_DisUpd (original source: MAIN/PLACES.ASM)
MerchOBJC_DisUpd:
	bsr.w	Update_status_block
	lea.l	MOBJC_CIL,a0
	lea.l	MOBJCCIL_evaluate,a1
	bsr.w	Update_control_icons
	bsr.w	Display_gold
	bsr.w	Update_quantity_colours
	rts	
; ---- MerchOBJC_DisInit (original source: MAIN/PLACES.ASM)
MerchOBJC_DisInit:
	move.l	#Lay3_PlusMes,PlusMes_info
	move.l	#Code0002Sys,Textfile_ptr
	move.l	#Sold_data,Itemdata_ptr
	move.l	#Sold_slots,Itemslots_ptr
	movea.l	Off_screen,a6
	moveq.l	#3,d0
	bsr.w	Show_layout
	bsr.w	Display_80x80_picture
	bsr.w	Places_DisInit
	lea.l	MOBJC_CIL,a0
	bsr.w	MOBJCCIL_evaluate
	move.l	a0,Control_list_ptr
	bsr.w	Show_control_icons
	bsr.w	Show_objects_LAY3
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	Lay3_L2,a0
	jsr	Set_layout_data
	bra.w	Fadein_lay3
; ---- MOBJCCIL_evaluate (original source: MAIN/PLACES.ASM)
MOBJCCIL_evaluate:
	movem.l	d0/d7/a1,-(sp)
	bclr	#7,(a0)
	bclr	#7,3(a0)
	bclr	#7,4(a0)
	bclr	#7,5(a0)
	movea.l	Warecount_ptr,a1
	move.l	(a1)+,d0
	or.l	(a1)+,d0
	or.l	(a1)+,d0
	bne.s	.Ok
	bset	#7,4(a0)
.Ok:
	movea.l	Current_active_char_data,a1
	lea.l	Inventory_1_place_counter(a1),a1
	move.b	(a1)+,d0
	moveq.l	#11-1,d7
.Loop1:
	or.b	(a1)+,d0
	dbra	d7,.Loop1
	tst.b	d0
	bne.s	.Not_empty1
	bset	#7,3(a0)
.Not_empty1:
	tst.w	Places_gold
	beq.s	.Deac
	movea.l	Warecount_ptr,a1
	move.l	(a1)+,d0
	or.l	(a1)+,d0
	or.l	(a1)+,d0
	beq.s	.Deac
	lea.l	Sold_slots,a1
	move.b	(a1)+,d0
	moveq.l	#11-1,d7
.Loop2:
	and.b	(a1)+,d0
	dbra	d7,.Loop2
	tst.b	d0
	beq.s	.Not_empty2
.Deac:
	bset	#7,(a0)
.Not_empty2:
	lea.l	Sold_slots,a1
	move.l	(a1)+,d0
	or.l	(a1)+,d0
	or.l	(a1)+,d0
	bne.s	.Not_empty3
	bset	#7,5(a0)
.Not_empty3:
	bsr.w	Places_CIL_evaluate
	movem.l	(sp)+,d0/d7/a1
	rts	
; ---- View_item_MOBJC (original source: MAIN/PLACES.ASM)
View_item_MOBJC:
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	lea.l	ViewItemMOBJC_Mod,a0
	bra.w	Push_Module
; ---- ViewItemMOBJC_DisInit (original source: MAIN/PLACES.ASM)
ViewItemMOBJC_DisInit:
	move.l	#Lay3_PlusMes,PlusMes_info
	lea.l	Lay3_PA,a0
	bsr.w	Push_PA
	lea.l	L3_objects_area,a0
	jsr	Push_MA
	move.l	Waredat_ptr,Itemdata_ptr
	move.l	Warecount_ptr,Itemslots_ptr
	movea.l	Off_screen,a6
	movea.l	Textfile_ptr,a0
	move.l	#Code0001Sys,Textfile_ptr
	move.w	#3,d0
	bsr.w	Hash_message
	move.l	a0,Textfile_ptr
	bsr.w	Show_objects_LAY3
	jsr	Switch_screen
	jsr	Copy_screen
	rts	
T_0b978:
	btst	#$1,Mouse_button_state
	bne.b	T_0b978
	tst.b	d0
	beq.b	.l_0b9a6
	ext.w	d0
	movea.l	Itemslots_ptr,a0
	adda.w	d0,a0
	tst.b	-$1(a0)
	beq.b	.l_0b9a6
	move.b	d0,Object_slot_number
	lea.l	D_28160,a0
	bsr.w	Push_Module
.l_0b9a6:
	rts
T_0b9a8:
	btst	#$1,Mouse_button_state
	bne.b	T_0b9a8
	lea.l	SellItem_Mod,a0
	bra.w	Push_Module
SellItem_DisInit:
	move.w	#$70,Mesmin_X
	move.w	#$42,Mesmin_Y
	move.w	#$c0,Mesmin_Wd
	move.l	#Code0002Sys,Textfile_ptr
	move.l	#Lay3_PlusMes,PlusMes_info
	lea.l	Lay3_PA,a0
	bsr.w	Push_PA
; ---- LearnSpell_DisInit (original source: MAIN/EYE.ASM)
LearnSpell_DisInit:
	lea.l	L3_objects_area,a0
	jsr	Push_MA
	movea.l	Current_active_char_data,a0
	lea.l	Inventory_1_place_counter(a0),a1
	lea.l	Inv_data+360(a0),a0
	move.l	a0,Itemdata_ptr
	move.l	a1,Itemslots_ptr
	movea.l	Off_screen,a6
	move.w	#$c,d0	; CHANGE: was "HashMes 11"
	bsr.w	Hash_message
	bsr.w	Show_objects_LAY3
	jsr	Switch_screen
	jsr	Copy_screen
	rts	
; ---- SellItem_DisExit (original source: MAIN/PLACES.ASM)
BuyItem_DisExit:
SellItem_DisExit:
	move.l	#Sold_data,Itemdata_ptr
	move.l	#Sold_slots,Itemslots_ptr
	movea.l	Off_screen,a6
	bsr.w	Show_objects_LAY3
	bsr.w	Erase_text_window
	jsr	Switch_screen
	jsr	Copy_screen
	bsr.w	Pop_PA
	jsr	Pop_MA
	rts	
; ---- SellItem_DisUpd (original source: MAIN/PLACES.ASM)
SellItem_DisUpd:
	bsr.w	Update_status_block
	bsr.w	Update_quantity_colours
	bsr.w	Display_gold
	rts	
; ---- SellItem_objselect (original source: MAIN/PLACES.ASM)
SellItem_objselect:
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
	btst	#1,Item_stat_bits(a2)
	beq.s	.Exit
	cmpi.w	#2,Price(a2)
	bmi.s	.Exit
	btst	#2,Item_stat_bits(a2)
	beq.s	.Single
	cmpi.b	#1,(a1)
	bhi.s	.Multiple
.Single:
	move.l	#1,ItemW_nr
	lea.l	SellReq_Mod,a0
	bsr.w	Push_Module
	rts	
.Multiple:
	moveq.l	#0,d0
	move.b	(a1),d0
	move.l	d0,Original_number
	clr.l	ItemW_nr
	lea.l	SellMItem_Mod,a0
	bsr.w	Push_Module
.Exit:
	rts	
; ---- SellMItem_DisInit (original source: MAIN/PLACES.ASM)
SellMItem_DisInit:
	movem.l	d0/d1/a0-a2/a6,-(sp)
	move.w	#First_add,Adding
	moveq.l	#15,d0
	jsr	IG_Set_ink
	moveq.l	#2,d0
	jsr	IG_Set_paper
	bsr.w	ItemW_DisInit
	movea.l	Itemslots_ptr,a1
	movea.l	Itemdata_ptr,a2
	move.b	Object_slot_number,d0
	ext.w	d0
	subq.w	#1,d0
	adda.w	d0,a1
	mulu.w	#40,d0
	adda.w	d0,a2
	movea.l	Off_screen,a6
	move.b	(a2),d0
	moveq.l	#0,d1
	bsr.w	INV2_Show_object
	move.w	#49+18,d0
	move.w	#80+18+32,d1
	jsr	IG_Set_cursor
	move.w	Name_word_nr(a2),d0
	bsr.w	Get_word
	lea.l	Line_buffer,a0
	jsr	IG_Print
	move.w	#32+17,d0
	move.w	#80+38+32,d1
	jsr	IG_Set_cursor
	moveq.l	#15,d0
	lea.l	Code0002Sys,a1
	bsr.w	Convert_text_line
	lea.l	Line_buffer,a0
	jsr	IG_Print
	jsr	Switch_screen
	jsr	Copy_screen
	movem.l	(sp)+,d0/d1/a0-a2/a6
	rts	
; ---- SellMItem_Return (original source: MAIN/PLACES.ASM)
SellMItem_Return:
	tst.l	ItemW_nr
	bne.s	.Go_on
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	rts	
.Go_on:
	lea.l	SellReq_Mod,a0
	bsr.w	Push_Module
	rts	
; ---- SellReq_ModInit (original source: MAIN/PLACES.ASM)
SellReq_ModInit:
	move.l	ItemW_nr,d6
	movea.l	Itemdata_ptr,a1
	move.b	Object_slot_number,d0
	ext.w	d0
	subq.w	#1,d0
	mulu.w	#40,d0
	adda.w	d0,a1
	movea.l	Off_screen,a6
	lea.l	Lay3_PA,a0
	bsr.w	Push_PA
	bsr.w	Erase_text_window
	move.w	Name_word_nr(a1),d0
	bsr.w	Get_word
	lea.l	Line_buffer,a0
	jsr	IG_Print
	cmpi.w	#1,d6
	beq.s	.Single
	lea.l	Multi_txt,a0
	jsr	IG_Print
	move.w	d6,d0
	moveq.l	#2,d7
	lea.l	Line_buffer,a0
	movea.l	a0,a3
	bsr.w	LConvert_number
	jsr	IG_Print
.Single:
	jsr	IG_Carriage_return
	move.l	a1,-(sp)
	moveq.l	#14,d0
	lea.l	Code0002Sys,a1
	bsr.w	Convert_text_line
	movea.l	(sp)+,a1
	lea	Line_buffer,a0
	jsr	IG_Print
	jsr	IG_Carriage_return
	moveq.l	#0,d1
	move.w	Price(a1),d1
	divu.w	#3,d1
	movea.l	Current_active_char_data,a2
	moveq.l	#0,d2
	move.w	Attr_6_normal(a2),d2
	add.w	Attr_6_normal_magic(a2),d2
	divu.w	#10,d2
	mulu.w	Price(a1),d2
	divu.w	#100,d2
	add.l	d2,d1
	mulu.w	d6,d1
	move.w	d1,Total_price
	move.l	d1,d0
	moveq.l	#5,d7
	lea.l	Line_buffer,a0
	movea.l	a0,a3
	bsr.w	LConvert_number
	move.b	#" ",(a3)+
	clr.b	(a3)
	jsr	IG_Print
	lea.l	Gold_txt,a0
	jsr	IG_Print
	moveq.l	#2,d6
	moveq.l	#16,d7
	move.w	#240,d0
	move.w	#81,d1
	lea.l	Control_icn+6912,a0
	jsr	Blot_unmasked_block
	addi.w	#32,d0
	lea.l	Control_icn+7168,a0
	jsr	Blot_unmasked_block
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	SellReq_L2,a0
	jsr	Set_layout_data
	lea.l	Lay3_PlusMes,a0
	jsr	Push_MA
	rts	
; ---- SellReq_ModExit (original source: MAIN/PLACES.ASM)
BuyTRANSReq_ModExit:
SellReq_ModExit:
	movea.l	Off_screen,a6
	bsr.w	Erase_text_window
	jsr	Switch_screen
	jsr	Copy_screen
	jsr	Pop_MA
	bsr.w	Pop_PA
	lea.l	Lay3_L2,a0
	jsr	Set_layout_data
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	movea.l	Itemslots_ptr,a0
	move.b	(a0)+,d0
	moveq.l	#11-1,d7
.Loop:
	or.b	(a0)+,d0
	dbra	d7,.Loop
	tst.b	d0
	bne.s	.Exit
	bsr.w	Pop_Module
.Exit:
	rts	
; ---- SellYes (original source: MAIN/PLACES.ASM)
SellYes:
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	movea.l	Itemslots_ptr,a0
	movea.l	Itemdata_ptr,a1
	move.b	Object_slot_number,d0
	ext.w	d0
	subq.w	#1,d0
	adda.w	d0,a0
	mulu.w	#40,d0
	adda.w	d0,a1
	movea.l	Current_active_char_data,a2
	move.l	ItemW_nr,d0
	sub.b	d0,(a0)
	mulu.w	Weight(a1),d0
	sub.l	d0,Weight_normal(a2)
	move.w	Total_price,d0
	add.w	d0,Places_gold
	movea.l	Off_screen,a6
	bsr.w	Show_objects_LAY3
	jsr	Switch_screen
	jsr	Copy_screen
	bra.w	Pop_Module
; ---- Buy_item (original source: MAIN/PLACES.ASM)
Buy_item:
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	lea.l	BuyItem_Mod,a0
	bra.w	Push_Module
; ---- BuyItem_DisInit (original source: MAIN/PLACES.ASM)
BuyItem_DisInit:
	move.w	#112,Mesmin_X
	move.w	#66,Mesmin_Y
	move.w	#192,Mesmin_Wd
	move.l	#Code0003Sys,Textfile_ptr
	move.l	#Lay3_PlusMes,PlusMes_info
	lea.l	Lay3_PA,a0
	bsr.w	Push_PA
	lea.l	L3_objects_area,a0
	jsr	Push_MA
	move.l	Waredat_ptr,Itemdata_ptr
	move.l	Warecount_ptr,Itemslots_ptr
	movea.l	Off_screen,a6
	move.w	#21,d0
	bsr.w	Hash_message
	bsr.w	Show_objects_LAY3
	jsr	Switch_screen
	jsr	Copy_screen
	rts	
T_0be3e:
	move.l	#Sold_data,Itemdata_ptr
	move.l	#Sold_slots,Itemslots_ptr
	movea.l	Off_screen,a6
	bsr.w	Show_objects_LAY3
	bsr.w	Erase_text_window
	jsr	Switch_screen
	jsr	Copy_screen
	bsr.w	Pop_PA
	jsr	Pop_MA
	rts
T_0be78:
	btst	#$1,Mouse_button_state
	bne.b	T_0be78
	tst.b	d0
	beq.w	T_0bf1a
	move.b	d0,Object_slot_number
	ext.w	d0
	subq.w	#$1,d0
	movea.l	Itemslots_ptr,a1
	movea.l	Itemdata_ptr,a2
	adda.w	d0,a1
	mulu.w	#$28,d0
	adda.w	d0,a2
	tst.b	(a1)
	beq.b	T_0bf1a
	move.w	Total_price,d1
	cmp.w	Places_gold,d1
	bgt.b	T_0bf1a
	btst	#$2,$18(a2)
	beq.b	T_0bec6
	cmpi.b	#$1,(a1)
	bne.b	T_0bedc
T_0bec6:
	move.l	#$1,ItemW_nr
	lea.l	BuyReq_Mod,a0
	bsr.w	Push_Module
	rts
T_0bedc:
	moveq	#0,d0
	move.b	(a1),d0
	moveq	#0,d1
	move.w	Places_gold,d1
	divu.w	Total_price,d1
	cmpi.w	#$1,d1
	beq.b	T_0bec6
	cmpi.w	#$64,d1
	bmi.b	.l_0befc
	moveq	#99,d1
.l_0befc:
	cmp.w	d1,d0
	bpl.b	.l_0bf02
	move.w	d0,d1
.l_0bf02:
	ext.l	d1
	move.l	d1,Original_number
	clr.l	ItemW_nr
	lea.l	BuyMItem_Mod,a0
	bsr.w	Push_Module
T_0bf1a:
	rts
; ---- BuyMItem_DisInit (original source: MAIN/PLACES.ASM)
BuyMItem_DisInit:
	move.w	#First_add,Adding
	moveq.l	#15,d0
	jsr	IG_Set_ink
	moveq.l	#2,d0
	jsr	IG_Set_paper
	bsr.w	ItemW_DisInit
	movea.l	Itemslots_ptr,a1
	movea.l	Itemdata_ptr,a2
	move.b	Object_slot_number,d0
	ext.w	d0
	subq.w	#1,d0
	adda.w	d0,a1
	mulu.w	#40,d0
	adda.w	d0,a2
	movea.l	Off_screen,a6
	move.b	(a2),d0
	moveq.l	#0,d1
	bsr.w	INV2_Show_object
	move.w	#49+18,d0
	move.w	#80+18+32,d1
	jsr	IG_Set_cursor
	move.w	Name_word_nr(a2),d0
	bsr.w	Get_word
	lea.l	Line_buffer,a0
	jsr	IG_Print
	move.w	#32+17,d0
	move.w	#80+38+32,d1
	jsr	IG_Set_cursor
	moveq.l	#22,d0
	lea.l	Code0003Sys,a1
	bsr.w	Convert_text_line
	lea.l	Line_buffer,a0
	jsr	IG_Print
	jsr	Switch_screen
	jsr	Copy_screen
	rts	
; ---- BuyMItem_Return (original source: MAIN/PLACES.ASM)
BuyMItem_Return:
	tst.l	ItemW_nr
	bne.s	.Go_on
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	bra.w	Pop_Module
.Go_on:
	lea.l	BuyReq_Mod,a0
	bsr.w	Push_Module
.Exit:
	rts	
; ---- BuyReq_ModInit (original source: MAIN/PLACES.ASM)
BuyReq_ModInit:
	movea.l	Off_screen,a6
	lea.l	Lay3_PA,a0
	bsr.w	Push_PA
	bsr.w	Erase_text_window
	movea.l	Itemdata_ptr,a1
	move.b	Object_slot_number,d0
	ext.w	d0
	subq.w	#1,d0
	mulu.w	#40,d0
	adda.w	d0,a1
	move.w	Name_word_nr(a1),d0
	bsr.w	Get_word
	lea.l	Line_buffer,a0
	jsr	IG_Print
	move.l	ItemW_nr,d6
	cmpi.w	#1,d6
	beq.s	.Single
	lea.l	Multi_txt,a0
	jsr	IG_Print
	move.w	d6,d0
	moveq.l	#2,d7
	lea.l	Line_buffer,a0
	movea.l	a0,a3
	bsr.w	LConvert_number
	jsr	IG_Print
.Single:
	jsr	IG_Carriage_return
	moveq.l	#23,d0
	lea.l	Code0003Sys,a1
	bsr.w	Convert_text_line
	lea	Line_buffer,a0
	jsr	IG_Print
	jsr	IG_Carriage_return
	move.w	Total_price,d0
	mulu.w	d6,d0
	moveq.l	#5,d7
	lea.l	Line_buffer,a0
	movea.l	a0,a3
	bsr.w	LConvert_number
	move.b	#" ",(a3)+
	clr.b	(a3)
	jsr	IG_Print
	lea.l	Gold_txt,a0
	jsr	IG_Print
	moveq.l	#2,d6
	moveq.l	#16,d7
	move.w	#240,d0
	move.w	#81,d1
	lea.l	Control_icn+6912,a0
	jsr	Blot_unmasked_block
	addi.w	#32,d0
	lea.l	Control_icn+7168,a0
	jsr	Blot_unmasked_block
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	SellReq_L2,a0
	jsr	Set_layout_data
	lea.l	Lay3_PlusMes,a0
	jsr	Push_MA
	rts	
; ---- BuyReq_ModExit (original source: MAIN/PLACES.ASM)
BuyReq_ModExit:
	movea.l	Off_screen,a6
	bsr.w	Erase_text_window
	jsr	Switch_screen
	jsr	Copy_screen
	jsr	Pop_MA
	bsr.w	Pop_PA
	lea.l	Lay3_L2,a0
	jsr	Set_layout_data
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	movea.l	Warecount_ptr,a0
	tst.l	(a0)+
	bne.s	.Exit
	tst.l	(a0)+
	bne.s	.Exit
	tst.l	(a0)+
	bne.s	.Exit
	bsr.w	Pop_Module
.Exit:
	rts	
T_0c136:
	btst	#$1,Mouse_button_state
	bne.b	T_0c136
	movea.l	Itemslots_ptr,a0
	movea.l	Itemdata_ptr,a1
	move.b	Object_slot_number,d0
	ext.w	d0
	subq.w	#$1,d0
	adda.w	d0,a0
	mulu.w	#$28,d0
	adda.w	d0,a1
	moveq	#1,d1
	btst	#$2,$18(a1)
	beq.b	.l_0c1cc
	cmpi.b	#$1,(a0)
	bhi.b	.l_0c174
	move.l	d1,ItemW_nr
.l_0c174:
	lea.l	Sold_slots,a4
	lea.l	Sold_data,a5
	move.w	$24(a1),d0
	move.l	ItemW_nr,d1
	moveq	#11,d7
.l_0c18c:
	tst.b	(a4)
	beq.b	.l_0c19c
	cmp.w	$24(a5),d0
	bne.b	.l_0c19c
	cmpi.b	#$63,(a4)
	bmi.b	.l_0c1a8
.l_0c19c:
	addq.l	#$1,a4
	lea.l	$28(a5),a5
	dbra	d7,.l_0c18c
	bra.b	.l_0c1cc
.l_0c1a8:
	moveq	#0,d0
	move.b	(a4),d0
	add.w	d1,d0
	cmpi.w	#$63,d0
	bls.b	.l_0c1ea
	moveq	#99,d2
	sub.b	(a4),d2
	sub.l	d2,ItemW_nr
	move.b	#$63,(a4)
	dc.w	$0c10,$ffff	; cmpi.b #$ff, (a0)
	beq.b	.l_0c174
	sub.b	d2,(a0)
	bra.b	.l_0c174
.l_0c1cc:
	lea.l	Sold_slots,a4
	lea.l	Sold_data,a5
	moveq	#11,d7
.l_0c1da:
	tst.b	(a4)
	beq.b	.l_0c1ea
	addq.l	#$1,a4
	lea.l	$28(a5),a5
	dbra	d7,.l_0c1da
	bra.b	.l_0c228
.l_0c1ea:
	add.b	d1,(a4)
	moveq	#19,d7
.l_0c1ee:
	move.w	(a1)+,(a5)+
	dbra	d7,.l_0c1ee
	lea.l	-$28(a1),a1
	dc.w	$0c10,$ffff	; cmpi.b #$ff, (a0)
	beq.b	.l_0c200
	sub.b	d1,(a0)
.l_0c200:
	move.l	ItemW_nr,d0
	mulu.w	Total_price,d0
	sub.w	d0,Places_gold
	movea.l	Off_screen,a6
	bsr.w	Show_objects_LAY3
	jsr	Switch_screen
	jsr	Copy_screen
.l_0c228:
	bra.w	Pop_Module
; ---- Transfer_item_MOBJC (original source: MAIN/PLACES.ASM)
Transfer_item_MOBJC:
	lea.l	TIMOBJC_Mod,a0
	bra.w	Push_Module
; ---- TIMOBJC_DisInit (original source: MAIN/PLACES.ASM)
TIChest_DisInit:
TIMOBJC_DisInit:
	movem.l	d0/a6,-(sp)
	move.w	#112,Mesmin_X
	move.w	#66,Mesmin_Y
	move.w	#192,Mesmin_Wd
	move.l	#Code0001Sys,Textfile_ptr
	lea.l	Lay3_L2,a0
	jsr	Push_MA
	movea.l	Off_screen,a6
	move.w	#4,d0
	bsr.w	Minus_message
	jsr	Switch_screen
	jsr	Copy_screen
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	movem.l	(sp)+,d0/a6
	rts	
; ---- Do_TIMOBJC (original source: MAIN/PLACES.ASM)
Do_TIMOBJC:
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	tst.b	d0
	bne.s	.A_slot
.Exit:
	bra.w	Pop_Module
.A_slot:
	move.b	d0,Object_slot_number
	movea.l	Itemslots_ptr,a1	; CHANGE: was "lea.l Sold_slots,a1"
	movea.l	Itemdata_ptr,a2	; CHANGE: was "lea.l Sold_data,a2"
	ext.w	d0
	subq.w	#1,d0
	adda.w	d0,a1
	mulu.w	#40,d0
	adda.w	d0,a2
	tst.b	(a1)
	beq.s	.Exit
	moveq.l	#-1,d1
	btst	#2,Item_stat_bits(a2)
	beq.s	.Single
	cmpi.b	#1,(a1)
	bhi.s	.Multiple
	move.w	Item_ID(a2),d1
.Single:
	moveq.l	#0,d0
	move.w	Weight(a2),d0
	moveq.l	#1,d2
	bra.w	MOBJC_TI_2
.Multiple:
	moveq.l	#0,d0
	move.b	(a1),d0
	move.l	d0,Original_number
	clr.l	ItemW_nr
	lea.l	TMI_MOBJC_Mod,a0
	bsr.w	Push_Module
	rts	
; ---- TMI_MOBJC_DisInit (original source: MAIN/PLACES.ASM)
TMI_MOBJC_DisInit:
	movem.l	d0-d7/a0-a6,-(sp)
	move.w	#First_add,Adding
	moveq.l	#15,d0
	jsr	IG_Set_ink
	moveq.l	#2,d0
	jsr	IG_Set_paper
	bsr.w	ItemW_DisInit
	move.b	Object_slot_number,d0
	ext.w	d0
	subq.w	#$1,d0	; CHANGE: was "lea.l Sold_slots-1,a2"
	movea.l	Itemslots_ptr,a2	; CHANGE: was "lea.l Sold_data-40,a3"
	movea.l	Itemdata_ptr,a3	; CHANGE: added
	adda.w	d0,a2
	mulu.w	#40,d0
	adda.w	d0,a3
	movea.l	Off_screen,a6
	move.b	(a3),d0
	moveq.l	#0,d1
	bsr.w	INV2_Show_object
	move.w	#49+18,d0
	move.w	#80+18+32,d1
	jsr	IG_Set_cursor
	move.w	Name_word_nr(a3),d0
	bsr.w	Get_word
	lea.l	Line_buffer,a0
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
	movem.l	(sp)+,d0-d7/a0-a6
	rts	
; ---- TMI_MOBJC_Return (original source: MAIN/PLACES.ASM)
TMI_MOBJC_Return:
	movea.l	Itemdata_ptr,a0	; CHANGE: was "lea.l Sold_data-40,a0"
	move.b	Object_slot_number,d0
	ext.w	d0
	subq.w	#$1,d0	; CHANGE: added
	mulu.w	#40,d0
	adda.w	d0,a0
	move.l	ItemW_nr,d0
	bne.s	.Not_zero
	bra.w	Pop_Module
.Not_zero:
	mulu.w	Weight(a0),d0
	move.w	Item_ID(a0),d1
; ---- MOBJC_TI_2 (original source: MAIN/PLACES.ASM)
MOBJC_TI_2:
	suba.l	a0,a0
	bsr.w	Scan_4_transfer_victims
	bne.s	.Go
	move.w	#5,d0
	bsr.w	Plus_message
	bsr.w	Pop_Module
	bra.s	.Exit
.Go:
	bsr.w	Show_transfer_victims
	movea.l	Itemdata_ptr,a0	; CHANGE: was "lea.l Sold_data,a0"
	move.b	Object_slot_number,d0
	ext.w	d0
	subq.w	#$1,d0	; CHANGE: added
	mulu.w	#40,d0
	move.b	(a0,d0.w),TIVS_Icon_nr	; CHANGE: was "move.b -40(a0,d0.w),TIVS_Icon_nr"
	move.l	#MOBJC_TI_3,TIVS_Ptr
	lea.l	TIVS2_Mod,a0
	move.w	#24,Mouse_ptr(a0)
	bsr.w	Push_Module
.Exit:
	rts	
MOBJC_TI_3:
	movea.l	Itemslots_ptr,a2
	movea.l	Itemdata_ptr,a3
	move.b	Object_slot_number,d0
	ext.w	d0
	subq.w	#$1,d0
	adda.w	d0,a2
	mulu.w	#$28,d0
	adda.w	d0,a3
	moveq	#1,d1
	btst	#$2,$18(a3)
	beq.b	.l_0c4ae
	cmpi.b	#$1,(a2)
	bhi.b	.l_0c458
	move.l	d1,ItemW_nr
.l_0c458:
	lea.l	$2b(a0),a4
	lea.l	$29a(a0),a5
	move.w	$24(a3),d0
	move.l	ItemW_nr,d1
	moveq	#11,d7
.l_0c46c:
	tst.b	(a4)
	beq.b	.l_0c47c
	cmp.w	$24(a5),d0
	bne.b	.l_0c47c
	cmpi.b	#$63,(a4)
	bmi.b	.l_0c488
.l_0c47c:
	addq.l	#$1,a4
	lea.l	$28(a5),a5
	dbra	d7,.l_0c46c
	bra.b	.l_0c4ae
.l_0c488:
	moveq	#0,d0
	move.b	(a4),d0
	add.w	d1,d0
	cmpi.w	#$63,d0
	bls.b	.l_0c4ca
	moveq	#99,d2
	sub.b	(a4),d2
	sub.l	d2,ItemW_nr
	move.b	#$63,(a4)
	sub.b	d2,(a2)
	mulu.w	$22(a3),d2
	add.l	d2,$ec(a0)
	bra.b	.l_0c458
.l_0c4ae:
	lea.l	$2b(a0),a4
	lea.l	$29a(a0),a5
	moveq	#11,d7
.l_0c4b8:
	tst.b	(a4)
	beq.b	.l_0c4ca
	addq.l	#$1,a4
	lea.l	$28(a5),a5
	dbra	d7,.l_0c4b8
	bra.w	.l_0c586
.l_0c4ca:
	moveq	#0,d2
	move.b	d1,d2
	mulu.w	$22(a3),d2
	add.l	d2,$ec(a0)
	add.b	d1,(a4)
	moveq	#19,d7
.l_0c4da:
	move.w	(a3)+,(a5)+
	dbra	d7,.l_0c4da
	lea.l	-$28(a3),a3
	sub.b	d1,(a2)
	bne.b	.l_0c520
	lea.l	D_25fd2,a0
	moveq	#0,d0
	move.b	Object_slot_number,d0
	add.w	d0,d0
	add.w	d0,d0
	adda.w	d0,a0
	move.w	(a0)+,d0
	move.w	(a0)+,d1
	lea.l	D_363e0,a0
	movea.l	Off_screen,a6
	jsr	Put_unmasked_block
	jsr	Switch_screen
	jsr	Copy_screen
	bra.b	.l_0c570
.l_0c520:
	dc.b	$0c,$12,$00,$01,$66,$4a,$41,$f9
	dc.l	D_25fd2
	dc.b	$70,$00,$10,$39
	dc.l	Object_slot_number
	dc.b	$d0,$40,$d0,$40,$d0,$c0,$30,$18,$32,$18,$41,$f9
	dc.l	D_363e0
	dc.b	$2c,$79
	dc.l	Off_screen
	dc.b	$4e,$b9
	dc.l	Put_unmasked_block
	dc.b	$41,$f9
	dc.l	Objects_icn
	dc.b	$74,$00,$14,$13,$ef,$4a,$d0,$c2,$4e,$b9
	dc.l	Put_masked_block
	dc.b	$4e,$b9
	dc.l	Switch_screen
	dc.b	$4e,$b9
	dc.l	Copy_screen
.l_0c570:
	dc.b	$20,$79
	dc.l	Itemslots_ptr
	dc.b	$4a,$98,$66,$0c,$4a,$98,$66,$08,$4a,$98,$66,$04,$61,$00,$44,$50
.l_0c586:
	rts
; ---- Show3_object_name (original source: MAIN/PLACES.ASM)
Show3_object_name:
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
	btst	#1,Item_stat_bits(a0)
	beq.s	.No_sell
	moveq.l	#0,d1
	move.w	Price(a0),d1
	cmpi.w	#2,d1
	bpl.s	.Go_on
.No_sell:
	movea.l	Off_screen,a6
	move.w	#13,d0
	bsr.w	Minus_message
	jsr	Switch_screen
	jsr	Copy_screen
.Go_on:
	move.b	#2,Print_objname_flag
.Exit:
	rts	
; ---- Upd4_objname_erase (original source: MAIN/PLACES.ASM)
Upd3_objname_erase:
Upd4_objname_erase:
	tst.b	Erase_objname_flag
	beq.s	.Exit
	movea.l	Off_screen,a6
	bsr.w	Erase_message_minus
	move.w	#112,d0
	move.w	#73,d1
	move.w	#112+192-1,d2
	move.w	#$4f,d3	; CHANGE: was "move.w #73+14,d3"
	move.w	#2,d6
	jsr	Draw_box
	subq.b	#1,Erase_objname_flag
	clr.w	Object_name_nr
.Exit:
	rts	
; ---- Show4_object_name (original source: MAIN/PLACES.ASM)
Show4_object_name:
	tst.b	d0
	beq.w	.Exit
	movea.l	Itemdata_ptr,a0
	movea.l	Itemslots_ptr,a1
	ext.w	d0
	tst.b	-1(a1,d0.w)
	beq.s	.Exit
	mulu.w	#40,d0
	lea.l	-40(a0,d0.w),a0
	move.w	Name_word_nr(a0),d0
	cmp.w	Object_name_nr,d0
	beq.s	.Exit
	move.w	d0,Object_name_nr
	moveq.l	#0,d1
	move.w	Price(a0),d1
	movea.l	Current_active_char_data,a2
	moveq.l	#0,d2
	move.w	Attr_6_normal(a2),d2
	add.w	Attr_6_normal_magic(a2),d2
	divu.w	#10,d2
	mulu.w	Price(a0),d2
	divu.w	#100,d2
	sub.l	d2,d1
	move.w	d1,Total_price
	cmp.w	Places_gold,d1
	bls.s	.Go_on
	movea.l	Off_screen,a6
	move.w	#24,d0
	bsr.w	Minus_message
	jsr	Switch_screen
	jsr	Copy_screen
.Go_on:
	move.b	#2,Print_objname_flag
.Exit:
	rts	
; ---- Upd4_objname_print (original source: MAIN/PLACES.ASM)
Upd4_objname_print:
	tst.b	Print_objname_flag
	beq.s	.Exit
	lea.l	.Init_string(pc),a0
	jsr	IG_Print
	move.w	Object_name_nr,d0
	beq.s	.Exit
	bsr.w	Get_word
	move.w	#112,d0
	move.w	#73,d1
	move.w	#112+192-1,d2
	move.w	#73+14,d3
	move.w	#2,d6
	movea.l	Off_screen,a6
	jsr	Draw_box
	move.w	#192,d2
	lea.l	Line_buffer,a0
	bsr.w	Print_centered_string
	moveq.l	#0,d0
	move.w	Total_price,d0
	moveq.l	#5,d7
	lea.l	Line_buffer,a0
	movea.l	a0,a3
	bsr.w	LConvert_number
	move.w	#112,d0
	move.w	#73+7,d1
	move.w	#192,d2
	bsr.w	Print_centered_string
	subq.b	#1,Print_objname_flag
.Exit:
	rts	
.Init_string:
	dc.b	1,15,2,-1,0
	even	
T_0c73e:
	tst.b	Erase_objname_flag
	beq.b	.l_0c776
	movea.l	Off_screen,a6
	bsr.w	Erase_message_minus
	move.w	#$70,d0
	move.w	#$49,d1
	move.w	#$12f,d2
	move.w	#$57,d3
	move.w	#$2,d6
	jsr	Draw_box
	subq.b	#$1,Erase_objname_flag
	clr.w	Object_name_nr
.l_0c776:
	rts
; ---- MerchFOOD_DisUpd (original source: MAIN/PLACES.ASM)
MerchFOOD_DisUpd:
	bsr.w	Update_status_block
	lea.l	MFOOD_CIL,a0
	lea.l	MFOODCIL_evaluate,a1
	bsr.w	Update_control_icons
	bsr.w	Display_gold
	move.w	Places_food,d0
	moveq.l	#"0",d1
	moveq.l	#4,d7
	lea.l	GoldDis_text+1,a0
	movea.l	a0,a3
	bsr.w	RConvert_number
	move.w	#240,d0
	move.w	#113+8,d1
	move.w	#64,d2
	movea.l	Off_screen,a6
	bsr.w	Print_centered_string
	rts	
; ---- MerchFOOD_DisInit (original source: MAIN/PLACES.ASM)
MerchFOOD_DisInit:
	move.l	#Lay3_PlusMes,PlusMes_info
	movea.l	Off_screen,a6
	moveq.l	#3,d0
	bsr.w	Show_layout
	bsr.w	Display_80x80_picture
	bsr.w	Places_DisInit
	move.w	#240,d0
	move.w	#113,d1
	move.w	#64,d2
	lea.l	Food_txt,a0
	bsr.w	Print_centered_string
	movea.l	Placedat_ptr,a0
	move.w	(a0),Total_price
	lea.l	MFOOD_CIL,a0
	bsr.w	MFOODCIL_evaluate
	move.l	a0,Control_list_ptr
	bsr.w	Show_control_icons
	lea.l	Lay3_PA,a0
	bsr.w	Push_PA
	bsr.w	Init_RText
	moveq.l	#16,d0
	lea.l	Code0004Sys,a1
	bsr.w	Add_encoded_2_RText
	moveq.l	#0,d0
	move.w	Total_price,d0
	moveq.l	#5,d7
	lea.l	Number_buffer,a0
	movea.l	a0,a3
	bsr.w	LConvert_number
	move.b	#$20,(a3)+	; CHANGE: was "move.b #" ",(a3)+"
	clr.b	(a3)
	bsr.w	Add_ASCII_2_RText
	lea.l	Gold_txt,a0
	bsr.w	Add_ASCII_2_RText
; CHANGE: removed "movea.l RText_ptr,a0"
; CHANGE: removed "move.w Nr_of_chars,d0"
; CHANGE: removed "move.w Lines_in_text,d1"
; CHANGE: removed "bra.s .Entry2"
.Loop2:
	bsr.w	T_0707a	; CHANGE: was ".Loop2: jsr IG_Print"
; CHANGE: removed "jsr IG_Carriage_return"
; CHANGE: removed "lea.l 1(a0,d0.w),a0"
; CHANGE: removed ".Entry2: dbra d1,.Loop2"
.Entry2:
	bsr.w	Exit_RText
	bsr.w	Pop_PA
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	Lay3_L2,a0
	jsr	Set_layout_data
	bra.w	Fadein_lay3
; ---- MFOODCIL_evaluate (original source: MAIN/PLACES.ASM)
MFOODCIL_evaluate:
	bclr	#7,3(a0)
	bclr	#7,4(a0)
	bclr	#7,5(a0)
	move.w	Total_price,d0
	cmp.w	Places_gold,d0
	bls.s	.Ok1
	bset	#7,3(a0)
.Ok1:
	tst.w	Places_food
	bne.s	.Ok2
	bset	#7,4(a0)
	bset	#7,5(a0)
.Ok2:
	bsr.w	Places_CIL_evaluate
	rts	
; ---- MFOOD_Transfer_food (original source: MAIN/PLACES.ASM)
MFOOD_Transfer_food:
	move.w	#112,Mesmin_X
	move.w	#63,Mesmin_Y
	move.w	#192,Mesmin_Wd
	move.l	#Code0001Sys,Textfile_ptr
	movea.l	Off_screen,a6
	move.w	#7,d0
	bsr.w	Minus_message
	jsr	Switch_screen
	jsr	Copy_screen
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	moveq.l	#0,d0
	move.w	Places_food,d0
	move.l	d0,Original_number
	clr.l	ItemW_nr
	lea.l	TFMFOOD_Mod,a0
	bsr.w	Push_Module
	rts	
; ---- TFMFOOD_Return (original source: MAIN/PLACES.ASM)
TFMFOOD_Return:
	move.l	ItemW_nr,d0
	beq.w	.Exit
	mulu.w	#Food_weight,d0
	lea.l	Chard_ptrs,a1
	lea.l	Char_status_icons,a4
	moveq.l	#0,d6
	moveq.l	#1,d7
.Loop1:
	tst.l	(a1)
	beq.s	.Next
.Do_it:
	movea.l	(a1),a2
	move.w	Attr_1_normal(a2),d1
	add.w	Attr_1_normal_magic(a2),d1
	mulu.w	#1000,d1
	sub.l	Weight_normal(a2),d1
	cmp.l	d0,d1
	bmi.s	.Next
	move.w	Food_rations(a2),d1
	add.w	d0,d1
	bvs.s	.Next
	move.w	#$e402,d1
	and.w	Body_conditions(a2),d1
	bne.s	.Next
	bset	d7,d6
.Next:
	addq.l	#4,a1
	addq.w	#1,d7
	cmpi.w	#6+1,d7
	bmi.s	.Loop1
	bmi.s	.Loop1
	move.w	d5,Transferring
	move.w	d6,Transfer_victims
	tst.w	d6
	bne.s	.Go
	move.w	#5,d0
	bsr.w	Plus_message
	bsr.w	Pop_Module
	bra.s	.Exit
.Go:
	bsr.w	Show_transfer_victims
	move.l	#Do_TFMFOOD,TIVS_Ptr
	lea.l	TIVS2_Mod,a0
	move.w	#26,Mouse_ptr(a0)
	bsr.w	Push_Module
.Exit:
	rts	
; ---- Do_TFMFOOD (original source: MAIN/PLACES.ASM)
Do_TFMFOOD:
	move.l	ItemW_nr,d0
	add.w	d0,Food_rations(a0)
	sub.w	d0,Places_food
	mulu.w	#Food_weight,d0
	add.l	d0,Weight_normal(a0)
	rts	
T_0c9d4:
	btst	#$1,Mouse_button_state
	bne.b	T_0c9d4
	moveq	#0,d0
	move.w	Places_food,d0
	bsr.w	T_0cbec
	move.w	d0,Places_food
	rts
T_0c9f2:
	btst	#$1,Mouse_button_state
	bne.b	T_0c9f2
	moveq	#0,d1
	move.w	Places_gold,d1
	divu.w	Total_price,d1
	cmpi.w	#$63,d1
	bmi.b	.l_0ca12
	moveq	#99,d1
.l_0ca12:
	ext.l	d1
	move.l	d1,Original_number
	clr.l	ItemW_nr
	lea.l	BuyFood_Mod,a0
	bra.w	Push_Module
; ---- BuyFood_DisInit (original source: MAIN/PLACES.ASM)
BuyFood_DisInit:
	move.w	#112,Mesmin_X
	move.w	#63,Mesmin_Y
	move.w	#192,Mesmin_Wd
	move.l	#Code0002Sys,Textfile_ptr
	move.w	#First_add,Adding
	moveq.l	#15,d0
	jsr	IG_Set_ink
	moveq.l	#2,d0
	jsr	IG_Set_paper
	bsr.w	ItemW_DisInit
	move.w	#Food_icon,d0
	moveq.l	#0,d1
	bsr.w	INV2_Show_object
	move.w	#49+18,d0
	move.w	#80+18+32,d1
	jsr	IG_Set_cursor
	lea.l	Food_txt,a0
	jsr	IG_Print
	move.w	#32+17,d0
	move.w	#80+38+32,d1
	jsr	IG_Set_cursor
	moveq.l	#22,d0
	lea.l	Code0003Sys,a1
	bsr.w	Convert_text_line
	lea.l	Line_buffer,a0
	jsr	IG_Print
	jsr	Switch_screen
	jsr	Copy_screen
	rts	
; ---- BuyFood_Return (original source: MAIN/PLACES.ASM)
BuyFood_Return:
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	tst.l	ItemW_nr
	beq.s	.Exit
	lea.l	BuyFoodReq_Mod,a0
	bsr.w	Push_Module
.Exit:
	rts	
; ---- BuyFoodReq_ModInit (original source: MAIN/PLACES.ASM)
BuyFoodReq_ModInit:
	movea.l	Off_screen,a6
	lea.l	Lay3_PA,a0
	bsr.w	Push_PA
	bsr.w	Erase_text_window
	lea.l	Food_txt,a0
	jsr	IG_Print
	move.l	ItemW_nr,d6
	cmpi.w	#1,d6
	beq.s	.Single
	lea.l	Multi_txt,a0
	jsr	IG_Print
	move.w	d6,d0
	moveq.l	#2,d7
	lea.l	Line_buffer,a0
	movea.l	a0,a3
	bsr.w	LConvert_number
	jsr	IG_Print
.Single:
	jsr	IG_Carriage_return
	moveq.l	#23,d0
	lea.l	Code0003Sys,a1
	bsr.w	Convert_text_line
	lea	Line_buffer,a0
	jsr	IG_Print
	jsr	IG_Carriage_return
	moveq.l	#0,d0
	move.w	Total_price,d0
	mulu.w	d6,d0
	moveq.l	#5,d7
	lea.l	Line_buffer,a0
	movea.l	a0,a3
	bsr.w	LConvert_number
	move.b	#" ",(a3)+
	clr.b	(a3)
	jsr	IG_Print
	lea.l	Gold_txt,a0
	jsr	IG_Print
	moveq.l	#2,d6
	moveq.l	#16,d7
	move.w	#240,d0
	move.w	#81,d1
	lea.l	Control_icn+6912,a0
	jsr	Blot_unmasked_block
	addi.w	#32,d0
	lea.l	Control_icn+7168,a0
	jsr	Blot_unmasked_block
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	SellReq_L2,a0
	jsr	Set_layout_data
	lea.l	Lay3_PlusMes,a0
	jsr	Push_MA
	rts	
; ---- BuyFoodYes (original source: MAIN/PLACES.ASM)
BuyFoodYes:
	move.l	ItemW_nr,d0
	move.l	d0,d1
	mulu.w	Total_price,d1
	sub.w	d1,Places_gold
	add.w	d0,Places_food
	bra.w	Pop_Module
T_0cbec:
	movem.l	d1-d3/d6-d7/a0-a2,-(a7)
	ext.l	d0
	beq.w	.l_0ccb2
	move.l	d0,d3
	lea.l	Chard_ptrs,a0
	lea.l	Divide_gold_workspace,a1
	moveq	#0,d6
	moveq	#5,d7
.l_0cc08:
	moveq	#0,d0
	tst.l	(a0)
	beq.b	.l_0cc46
	movea.l	(a0),a2
	cmpi.b	#$9,$4(a2)
	bpl.b	.l_0cc46
	move.w	#$e402,d1
	and.w	$3a(a2),d1
	bne.b	.l_0cc46
	move.w	$48(a2),d0
	add.w	$9c(a2),d0
	mulu.w	#$3e8,d0
	sub.l	$ec(a2),d0
	divu.w	#$fa,d0
	move.w	$92(a2),d1
	add.w	d0,d1
	bvc.b	.l_0cc46
	move.w	#$7fff,d0
	sub.w	$92(a2),d0
.l_0cc46:
	tst.w	d0
	beq.b	.l_0cc4c
	addq.w	#$1,d6
.l_0cc4c:
	move.w	d0,(a1)+
	addq.l	#$4,a0
	dbra	d7,.l_0cc08
	move.l	d3,d0
	tst.w	d6
	beq.b	.l_0ccb2
.l_0cc5a:
	lea.l	-$18(a0),a0
	lea.l	-$c(a1),a1
	moveq	#5,d7
.l_0cc64:
	move.w	(a1),d1
	beq.b	.l_0cca2
	movea.l	(a0),a2
	move.l	d0,d2
	divu.w	d6,d2
	tst.w	d2
	bne.b	.l_0cc74
	move.l	d0,d2
.l_0cc74:
	cmp.w	d2,d1
	bpl.b	.l_0cc8e
	sub.w	d1,(a1)
	bne.b	.l_0cc7e
	subq.w	#$1,d6
.l_0cc7e:
	sub.w	d1,d0
	add.w	d1,$92(a2)
	mulu.w	#$fa,d1
	add.l	d1,$ec(a2)
	bra.b	.l_0cca2
.l_0cc8e:
	sub.w	d2,(a1)
	bne.b	.l_0cc94
	subq.w	#$1,d6
.l_0cc94:
	sub.w	d2,d0
	add.w	d2,$92(a2)
	mulu.w	#$fa,d2
	add.l	d2,$ec(a2)
.l_0cca2:
	addq.l	#$4,a0
	addq.l	#$2,a1
	dbra	d7,.l_0cc64
	tst.w	d0
	beq.b	.l_0ccb2
	tst.w	d6
	bne.b	.l_0cc5a
.l_0ccb2:
	movem.l	(a7)+,d1-d3/d6-d7/a0-a2
	rts
; ---- MerchHORSE_DisUpd (original source: MAIN/PLACES.ASM)
MerchHORSE_DisUpd:
	bsr.w	Update_status_block
	lea.l	MHORSE_CIL,a0
	lea.l	MHORSECIL_evaluate,a1
	bsr.w	Update_control_icons
	bsr.w	Display_gold
	rts	
; ---- MerchHORSE_DisInit (original source: MAIN/PLACES.ASM)
MerchHORSE_DisInit:
	move.l	#Lay3_PlusMes,PlusMes_info
	movea.l	Off_screen,a6
	moveq.l	#3,d0
	bsr.w	Show_layout
	bsr.w	Display_80x80_picture
	bsr.w	Places_DisInit
	bsr.w	Check_trans_creation
	bsr.w	T_0dcdc	; CHANGE: added
	move.w	d0,d1	; CHANGE: added
	movea.l	Placedat_ptr,a1
	move.w	(a1),d0
	mulu.w	d1,d0	; CHANGE: was "mulu.w Nr_members,d0"
	move.w	d0,Total_price
	lea.l	MHORSE_CIL,a0
	bsr.w	MHORSECIL_evaluate
	move.l	a0,Control_list_ptr
	bsr.w	Show_control_icons
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	Lay3_L2,a0
	jsr	Set_layout_data
	bra.w	Fadein_lay3
; ---- MSHIPCIL_evaluate (original source: MAIN/PLACES.ASM)
MHORSECIL_evaluate:
MRAFTCIL_evaluate:
MSHIPCIL_evaluate:
	movem.l	d0/d7/a1,-(sp)
	bclr	#7,3(a0)
	tst.b	Trans_created
	bne.s	.Deac
	move.w	Places_gold,d0
	cmp.w	Total_price,d0
	bpl.s	.Ok
.Deac:
	bset	#7,3(a0)
.Ok:
	bsr.w	Places_CIL_evaluate
	movem.l	(sp)+,d0/d7/a1
	rts	
; ---- Buy_ship (original source: MAIN/PLACES.ASM)
Buy_horses:
Buy_raft:
Buy_ship:
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	lea.l	BuyHORSEReq_Mod,a0	; CHANGE: was "Push Module,BuySHIPReq_Mod"
	bsr.w	Push_Module
	rts	
; ---- BuyHORSEReq_ModInit (original source: MAIN/PLACES.ASM)
BuyHORSEReq_ModInit:
	move.l	#Code0002Sys,Textfile_ptr
	moveq.l	#19,d0
	bra.w	BuyTRANSReq_ModInit
; ---- BuyHORSEYes (original source: MAIN/PLACES.ASM)
BuyHORSEYes:
	bsr.w	Create_transport
	move.w	Total_price,d0
	sub.w	d0,Places_gold
	move.l	#Lay3_PlusMes,PlusMes_info
	move.l	#Code0002Sys,Textfile_ptr
	move.w	#20,d0
	bsr.w	Plus_message
	bsr.w	Pop_Module
.Exit:
	rts	
MerchRAFT_DisUpd:
	bsr.w	Update_status_block
	lea.l	D_261e6,a0
	lea.l	T_0ce3c,a1
	bsr.w	Update_control_icons
	bsr.w	Display_gold
	rts
MerchSHIP_DisInit:
MerchRAFT_DisInit:
	move.l	#Lay3_PlusMes,PlusMes_info
	movea.l	Off_screen,a6
	moveq	#3,d0
	bsr.w	Show_layout
	bsr.w	Display_80x80_picture
	bsr.w	Places_DisInit
	movea.l	Placedat_ptr,a1
	move.w	(a1),d0
	move.w	d0,Total_price
	bsr.w	Check_trans_creation
	lea.l	D_261e6,a0
	bsr.w	T_0ce3c
	move.l	a0,Control_list_ptr
	bsr.w	Show_control_icons
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	Lay3_L2,a0
	jsr	Set_layout_data
	bra.w	Fadein_lay3
T_0ce3c:
	movem.l	d0/d7/a1,-(a7)
	bclr	#$7,$3(a0)
	tst.b	Trans_created
	bne.b	.l_0ce5c
	move.w	Places_gold,d0
	cmp.w	Total_price,d0
	bpl.b	.l_0ce62
.l_0ce5c:
	bset	#$7,$3(a0)
.l_0ce62:
	bsr.w	Places_CIL_evaluate
	movem.l	(a7)+,d0/d7/a1
	rts
T_0ce6c:
	btst	#$1,Mouse_button_state
	bne.b	T_0ce6c
	lea.l	BuyRAFTReq_Mod,a0
	bsr.w	Push_Module
	rts
; ---- BuyRAFTReq_ModInit (original source: MAIN/PLACES.ASM)
BuyRAFTReq_ModInit:
	move.l	#Code0003Sys,Textfile_ptr
	moveq.l	#1,d0
	bra.w	BuyTRANSReq_ModInit
; ---- BuySHIPYes (original source: MAIN/PLACES.ASM)
BuyRAFTYes:
BuySHIPYes:
	bsr.w	Create_transport
	move.w	Total_price,d0
	sub.w	d0,Places_gold
	move.l	#Lay3_PlusMes,PlusMes_info
	move.l	#Code0003Sys,Textfile_ptr
	move.w	#$2,d0	; CHANGE: was "PlusMes 4"
	bsr.w	Plus_message
	bsr.w	Pop_Module
.Exit:
	rts	
MerchSHIP_DisUpd:
	bsr.w	Update_status_block
	lea.l	D_26214,a0
	lea.l	T_0cf3e,a1
	bsr.w	Update_control_icons
	bsr.w	Display_gold
	rts
T_0cede:
	move.l	#Lay3_PlusMes,PlusMes_info
	movea.l	Off_screen,a6
	moveq	#3,d0
	bsr.w	Show_layout
	bsr.w	Display_80x80_picture
	bsr.w	Places_DisInit
	movea.l	Placedat_ptr,a1
	move.w	(a1),d0
	move.w	d0,Total_price
	bsr.w	Check_trans_creation
	lea.l	D_26214,a0
	bsr.w	T_0cf3e
	move.l	a0,Control_list_ptr
	bsr.w	Show_control_icons
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	Lay3_L2,a0
	jsr	Set_layout_data
	bra.w	Fadein_lay3
T_0cf3e:
	movem.l	d0/d7/a1,-(a7)
	bclr	#$7,$3(a0)
	tst.b	Trans_created
	bne.b	.l_0cf5e
	move.w	Places_gold,d0
	cmp.w	Total_price,d0
	bpl.b	.l_0cf64
.l_0cf5e:
	bset	#$7,$3(a0)
.l_0cf64:
	bsr.w	Places_CIL_evaluate
	movem.l	(a7)+,d0/d7/a1
	rts
T_0cf6e:
	btst	#$1,Mouse_button_state
	bne.b	T_0cf6e
	lea.l	BuySHIPReq_Mod,a0
	bsr.w	Push_Module
	rts
; ---- BuySHIPReq_ModInit (original source: MAIN/PLACES.ASM)
BuySHIPReq_ModInit:
	move.l	#Code0003Sys,Textfile_ptr
	moveq.l	#3,d0
	bra.w	BuyTRANSReq_ModInit
T_0cf94:
	bsr.w	Create_transport
	move.w	Total_price,d0
	sub.w	d0,Places_gold
	move.l	#Lay3_PlusMes,PlusMes_info
	move.l	#Code0003Sys,Textfile_ptr
	move.w	#$4,d0
	bsr.w	Plus_message
	bsr.w	Pop_Module
	rts
Create_transport:
	movem.l	d0/d7/a0-a1,-(a7)
	lea.l	Trans_T,a0
	moveq	#29,d7
.l_0cfd2:
	tst.b	(a0,d7.w)
	beq.b	.l_0cfea
	subq.w	#$1,d7
	bpl.b	.l_0cfd2
	lea.l	D_2ef2e,a1
	jsr	DI_Error
	bra.b	.l_0d018
.l_0cfea:
	movea.l	Placedat_ptr,a1
	move.w	$8(a1),d0
	move.b	d0,(a0,d7.w)
	move.w	$2(a1),d0
	move.b	d0,$1e(a0,d7.w)
	move.w	$4(a1),d0
	move.b	d0,$3c(a0,d7.w)
	lea.l	$5a(a0,d7.w),a0
	move.w	$6(a1),(a0,d7.w)
	st.b	Trans_created
.l_0d018:
	movem.l	(a7)+,d0/d7/a0-a1
	rts
; ---- Check_trans_creation (original source: MAIN/PLACES.ASM)
Check_trans_creation:
	movem.l	d0-d2/d7/a0/a1,-(sp)
	movea.l	Placedat_ptr,a0
	move.w	2(a0),d0
	move.w	4(a0),d1
	move.w	6(a0),d2
	lea.l	Trans_T,a0
	lea.l	90(a0),a1
	moveq.l	#30-1,d7
.Loop1:
	tst.b	(a0)
	beq.s	.Next
	cmp.w	(a1),d2
	bne.s	.Next
	cmp.b	30(a0),d0
	bne.s	.Next
	cmp.b	60(a0),d1
	bne.s	.Next
	st	Trans_created
	bra.s	.Exit
.Next:
	addq.l	#1,a0
	addq.l	#2,a1
	dbra	d7,.Loop1
	sf	Trans_created
.Exit:
	lea.l	Trans_T,a0
	move.b	(a0)+,d0
	moveq.l	#30-2,d7
.Loop2:
	and.b	(a0)+,d0
	dbra	d7,.Loop2
	tst.b	d0
	sne	Trans_created
	movem.l	(sp)+,d0-d2/d7/a0/a1
	rts	
; ---- BuyTRANSReq_ModInit (original source: MAIN/PLACES.ASM)
BuyTRANSReq_ModInit:
	movea.l	Off_screen,a6
	lea.l	Lay3_PlusMes,a0
	jsr	Push_MA
	lea.l	Lay3_PA,a0
	bsr.w	Push_PA
	bsr.w	Erase_text_window
	movea.l	Textfile_ptr,a1
	bsr.w	Convert_text_line
	lea	Line_buffer,a0
	jsr	IG_Print
	jsr	IG_Carriage_return
	move.w	Total_price,d0
	moveq.l	#5,d7
	lea.l	Line_buffer,a0
	movea.l	a0,a3
	bsr.w	LConvert_number
	move.b	#" ",(a3)+
	clr.b	(a3)
	jsr	IG_Print
	lea.l	Gold_txt,a0
	jsr	IG_Print
	moveq.l	#2,d6
	moveq.l	#16,d7
	move.w	#240,d0
	move.w	#81,d1
	lea.l	Control_icn+6912,a0
	jsr	Blot_unmasked_block
	addi.w	#32,d0
	lea.l	Control_icn+7168,a0
	jsr	Blot_unmasked_block
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	SellReq_L2,a0
	jsr	Set_layout_data
	rts	
T_0d132:
	movea.l	Off_screen,a6
	bsr.w	Erase_text_window
	jsr	Switch_screen
	jsr	Copy_screen
	jsr	Pop_MA
	bsr.w	Pop_PA
	lea.l	Lay3_L2,a0
	jsr	Set_layout_data
.l_0d15e:
	btst	#$1,Mouse_button_state
	bne.b	.l_0d15e
	rts
; ---- BuyTRANSReq_DisUpd (original source: MAIN/PLACES.ASM)
BuyTRANSReq_DisUpd:
	bsr.w	Update_status_block
	bsr.w	Display_gold
	rts	
; ---- Healer_DisUpd (original source: MAIN/PLACES.ASM)
Healer_DisUpd:
	bsr.w	Update_status_block
	lea.l	Healer_CIL,a0
	lea.l	HealerCIL_evaluate,a1
	bsr.w	Update_control_icons
	bsr.w	Display_gold
	rts	
; ---- Healer_ModInit (original source: MAIN/PLACES.ASM)
Healer_ModInit:
	move.l	Current_active_char_data,Current_healer_victim
	move.w	Active_member,Healer_victim_nr
	bra.w	T_0ab46	; CHANGE: was "jmp Places_ModInit"
; ---- Healer_DisInit (original source: MAIN/PLACES.ASM)
Healer_DisInit:
	move.l	#Lay3_PlusMes,PlusMes_info
	movea.l	Off_screen,a6
	moveq.l	#3,d0
	bsr.w	Show_layout
	bsr.w	Display_80x80_picture
	bsr.w	Places_DisInit
	bsr.w	Display_BodyMind
	move.l	#Sold_data,Itemdata_ptr
	move.l	#Sold_slots,Itemslots_ptr
	lea.l	Healer_CIL,a0
	bsr.w	HealerCIL_evaluate
	move.l	a0,Control_list_ptr
	bsr.w	Show_control_icons
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	Lay3_L2,a0
	jsr	Set_layout_data
	lea.l	XLay3_target_hbl,a1
	movem.l	Lay3_target_hbl+2,d0-d7
	movem.l	d0-d7,2(a1)
	bra.w	Fade_lay3
; ---- Healer_DisExit (original source: MAIN/PLACES.ASM)
Healer_DisExit:
	move.w	Healer_victim_nr,d5
	move.w	d5,d4
	mulu.w	#48,d4
	movea.l	Current_healer_victim,a4
	movea.l	Off_screen,a6
	bsr.w	Display_portrait
	jsr	Switch_screen
	jsr	Copy_screen
	bra.w	Fadeout_lay3
; ---- HealerCIL_evaluate (original source: MAIN/PLACES.ASM)
HealerCIL_evaluate:
	movem.l	d7/a1/a2,-(sp)
	bclr	#7,3(a0)
	movea.l	Current_healer_victim,a1
	lea.l	Inv_data(a1),a2
	lea.l	Neck_place_counter(a1),a1
	moveq.l	#9-1,d7
.Loop:
	tst.b	(a1)+
	beq.s	.Next
	btst	#0,Item_stat_bits(a2)
	bne.s	.Ok
.Next:
	lea.l	40(a2),a2
	dbra	d7,.Loop
	bset	#7,3(a0)
.Ok:
	bsr.w	Places_CIL_evaluate
	movem.l	(sp)+,d7/a1/a2
	rts	
; ---- Healer_Remove_curse (original source: MAIN/PLACES.ASM)
Healer_Remove_curse:
	movea.l	Current_healer_victim,a1
	lea.l	Inv_data(a1),a2
	lea.l	Neck_place_counter(a1),a1
	lea.l	Cursed_slots,a3
	moveq.l	#0,d0
	clr.l	(a3)+
	clr.l	(a3)+
	clr.b	(a3)
	lea.l	-8(a3),a3
	moveq.l	#9-1,d7
.Loop:
	tst.b	(a1)+
	beq.s	.Next
	btst	#0,Item_stat_bits(a2)
	beq.s	.Next
	st	(a3)
	addq.w	#1,d0
.Next:
	lea.l	40(a2),a2
	addq.l	#1,a3
	dbra	d7,.Loop
	move.w	d0,Nr_cursed_objects
	movea.l	Placedat_ptr,a0
	moveq.l	#0,d1
	move.w	20(a0),d1
	mulu.w	d1,d0
	move.w	d0,Total_price
	cmp.w	Places_gold,d0
	ble.s	.Ok
	move.l	#Lay3_PlusMes,PlusMes_info
	move.l	#Code0002Sys,Textfile_ptr
	move.w	#22,d0
	bsr.w	Plus_message
	bra.s	.Exit
.Ok:
	move.w	d0,Total_price
	lea.l	RemCurseReq_Mod,a0
	bsr.w	Push_Module
.Exit:
	rts	
Heal_condition:
	tst.b	d0
	beq.b	.l_0d392
	move.b	d0,Object_slot_number
	lea.l	Sold_slots,a0
	lea.l	Sold_data,a1
	ext.w	d0
	subq.w	#$1,d0
	adda.w	d0,a0
	mulu.w	#$28,d0
	adda.w	d0,a1
	tst.b	(a0)
	beq.b	.l_0d392
.l_0d33e:
	btst	#$1,Mouse_button_state
	bne.b	.l_0d33e
	movea.l	Placedat_ptr,a0
	moveq	#0,d0
	move.b	$1(a1),d0
	move.b	.l_0d394(pc,d0.w),d0
	move.w	(a0,d0.w),d0
	cmp.w	Places_gold,d0
	ble.b	.l_0d382
	move.l	#Lay3_PlusMes,PlusMes_info
	move.l	#Code0002Sys,Textfile_ptr
	move.w	#$16,d0
	bsr.w	Plus_message
	bra.b	.l_0d392
.l_0d382:
	move.w	d0,Total_price
	lea.l	HealCondReq_Mod,a0
	bsr.w	Push_Module
.l_0d392:
	rts
.l_0d394:
	dc.b	$ff,$0a,$ff,$ff,$0c,$ff,$ff,$ff,$00,$02,$04,$06,$08,$0e,$10,$12
; ---- HealCondReq_ModInit (original source: MAIN/PLACES.ASM)
HealCondReq_ModInit:
	move.l	#Code0002Sys,Textfile_ptr
	moveq.l	#24,d0
	bra.w	BuyTRANSReq_ModInit
; ---- HealCondYes (original source: MAIN/PLACES.ASM)
HealCondYes:
	move.w	Total_price,d0
	sub.w	d0,Places_gold
	lea.l	Sold_data-40,a0
	move.b	Object_slot_number,d0
	ext.w	d0
	mulu.w	#40,d0
	move.b	1(a0,d0.w),d0
	movea.l	Current_healer_victim,a0
	move.w	Body_conditions(a0),d1
	bclr	d0,d1
	move.w	d1,Body_conditions(a0)
	cmpi.w	#13,d0
	bmi.s	.No
	move.w	Healer_victim_nr,d0
	bsr.w	Resurrection
.No:
	movea.l	Off_screen,a6
	bsr.w	Display_BodyMind
	jsr	Switch_screen
	jsr	Copy_screen
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	bra.w	Pop_Module
; ---- RemCurseReq_ModInit (original source: MAIN/PLACES.ASM)
RemCurseReq_ModInit:
	move.l	#Code0002Sys,Textfile_ptr
	moveq.l	#23,d0
	bra.w	BuyTRANSReq_ModInit
; ---- RemCurseYes (original source: MAIN/PLACES.ASM)
RemCurseYes:
	move.w	Total_price,d0
	sub.w	d0,Places_gold
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	bsr.w	Pop_Module
	bsr.w	Exit_display
	lea.l	RemCurse_Mod,a0
	bsr.w	Push_Module
	rts	
; ---- RemCurse_DisInit (original source: MAIN/PLACES.ASM)
RemCurse_DisInit:
	jsr	Mouse_off
	bsr.w	Inv2_DisInit
	moveq.l	#50,d0
	jsr	Delay
	lea.l	Cursed_slots,a0
	movea.l	Current_healer_victim,a1
	lea.l	Neck_place_counter(a1),a2
	lea.l	Inv_data(a1),a3
	moveq.l	#1,d0
	moveq.l	#9-1,d7
.Loop:
	tst.b	(a0)+
	beq.s	.Next
	clr.b	(a2)
	moveq.l	#0,d2
	move.w	Weight(a3),d2
	sub.l	d2,Weight_normal(a1)
	bsr.w	T_0d4de	; CHANGE: added
	move.l	d0,-(sp)
	moveq.l	#0,d2
	moveq.l	#0,d3
	move.b	(a3),d2
	lea.l	Erase_icon,a4
	move.b	-1(a4,d0.w),d3
	lea.l	Object_pos_list-4,a4
	add.w	d0,d0
	add.w	d0,d0
	move.w	2(a4,d0.w),d1
	move.w	0(a4,d0.w),d0
	bsr.w	Show_item_destruction
	move.l	(sp)+,d0
.Next:
	addq.w	#1,d0
	addq.l	#1,a2
	lea.l	40(a3),a3
	dbra	d7,.Loop
	moveq.l	#50,d0
	jsr	Delay
	bsr.w	Pop_Module
	jsr	Mouse_on
	bra.w	Init_display
T_0d4de:
	movem.l	d2/a0/a2/a5,-(a7)
	movea.l	a1,a0
	movea.l	a3,a2
	move.b	$4(a2),d2
	sub.b	d2,$1c(a0)
	move.b	$5(a2),d2
	sub.b	d2,$1d(a0)
	move.b	$13(a2),d2
	sub.b	d2,$20(a0)
	move.b	$14(a2),d2
	sub.b	d2,$21(a0)
	lea.l	$ae(a0),a5
	move.b	$19(a2),d2
	ext.w	d2
	add.w	d2,d2
	adda.w	d2,a5
	move.b	$1b(a2),d2
	ext.w	d2
	add.w	d2,(a5)
	lea.l	$ae(a0),a5
	move.b	$1a(a2),d2
	ext.w	d2
	add.w	d2,d2
	adda.w	d2,a5
	move.b	$1c(a2),d2
	ext.w	d2
	add.w	d2,(a5)
	bsr.w	Positive_boni
	movem.l	(a7)+,d2/a0/a2/a5
	rts
Show_item_destruction:
	movem.l	d0-d2/d7/a0-a4/a6,-(a7)
	lea.l	Objects_icn,a1
	ext.w	d2
	lsl.w	#$7,d2
	adda.w	d2,a1
	lea.l	D_33ce0,a2
	ext.w	d3
	lsl.w	#$7,d3
	adda.w	d3,a2
	lea.l	D_44410,a3
	lea.l	D_363e0,a4
	moveq	#7,d7
.l_0d566:
	movea.l	Off_screen,a6
	movea.l	a4,a0
	jsr	Put_unmasked_block
	movea.l	a1,a0
	jsr	Put_masked_block
	movea.l	a3,a0
	jsr	Put_masked_block
	jsr	Switch_screen
	jsr	My_vsync
	jsr	My_vsync
	jsr	My_vsync
	lea.l	$80(a3),a3
	dbra	d7,.l_0d566
	moveq	#7,d7
.l_0d5a6:
	movea.l	Off_screen,a6
	movea.l	a2,a0
	jsr	Put_unmasked_block
	movea.l	a3,a0
	jsr	Put_masked_block
	jsr	Switch_screen
	jsr	My_vsync
	jsr	My_vsync
	jsr	My_vsync
	lea.l	$80(a3),a3
	dbra	d7,.l_0d5a6
	movea.l	Off_screen,a6
	movea.l	a2,a0
	jsr	Put_unmasked_block
	jsr	Switch_screen
	jsr	Copy_screen
	movem.l	(a7)+,d0-d2/d7/a0-a4/a6
	rts
Display_BodyMind:
	movem.l	d0-d2/d6-d7/a0-a3,-(a7)
	moveq	#0,d1
	movea.l	Current_healer_victim,a0
	move.w	$3a(a0),d6
	lea.l	D_2633e,a0
	lea.l	Sold_slots,a1
	lea.l	Sold_data,a2
	lea.l	D_484c2,a3
	clr.l	(a1)+
	clr.l	(a1)+
	clr.l	(a1)
	lea.l	-$8(a1),a1
	moveq	#12,d7
.l_0d630:
	move.b	(a0),d0
	bmi.b	.l_0d64c
	btst	d0,d6
	beq.b	.l_0d64c
	move.b	#$1,(a1)+
	move.b	$1(a0),(a2)
	move.b	d0,$1(a2)
	move.w	(a3),$26(a2)
	lea.l	$28(a2),a2
.l_0d64c:
	addq.l	#$2,a0
	addq.l	#$2,a3
	dbra	d7,.l_0d630
	lea.l	Sold_data,a1
	lea.l	Door_object_pos_list,a2
	lea.l	Sold_slots,a3
	moveq	#11,d7
.l_0d668:
	move.w	(a2)+,d0
	move.w	(a2)+,d1
	lea.l	D_363e0,a0
	jsr	Put_unmasked_block
	tst.b	(a3)+
	beq.b	.l_0d690
	lea.l	Status_icn,a0
	move.b	(a1),d2
	ext.w	d2
	lsl.w	#$7,d2
	adda.w	d2,a0
	jsr	Put_masked_block
.l_0d690:
	lea.l	$28(a1),a1
	dbra	d7,.l_0d668
	movem.l	(a7)+,d0-d2/d6-d7/a0-a3
	rts
; ---- Healer_Member_left (original source: MAIN/PLACES.ASM)
Healer_Member_left:
	andi.l	#$0000ff00,d0
	beq.s	.Exit
	lsr.w	#8,d0
	cmp.w	Healer_victim_nr,d0
	beq.s	.Exit
	lea.l	Chard_ptrs-4,a0
	move.w	d0,d1
	add.w	d1,d1
	add.w	d1,d1
	adda.w	d1,a0
	tst.l	(a0)
	beq.s	.Exit
	move.w	Healer_victim_nr,d5
	move.w	d0,Healer_victim_nr
	move.w	d5,d4
	mulu.w	#48,d4
	movea.l	Current_healer_victim,a4
	movea.l	Off_screen,a6
	bsr.w	Display_portrait
	move.l	(a0),Current_healer_victim
	movea.l	Off_screen,a6
	bsr.w	Display_BodyMind
	jsr	Switch_screen
	jsr	Copy_screen
.Exit:
	rts	
; ---- Display_Ankh (original source: MAIN/PLACES.ASM)
Display_Ankh:
	move.w	Healer_victim_nr,d0
	mulu.w	#48,d0
	subi.w	#32,d0
	moveq.l	#1,d1
	moveq.l	#2,d6
	moveq.l	#32,d7
	lea.l	Status_icn+3072,a0
	movea.l	Off_screen,a6
	jsr	Blot_masked_block
	rts	
Resurrection:
	movem.l	d0/d4-d5/d7/a0-a2/a6,-(a7)
	lea.l	$f0(a0),a2
	move.w	#$1,$86(a0)
	lea.l	Char_status_icons,a0
	clr.b	-$1(a0,d0.w)
	bsr.w	Force_char_update
	lea.l	Lay3_PA,a0
	bsr.w	Push_PA
	bsr.w	Init_RText
	lea.l	Code0006Sys,a1
	move.w	#$15,d0
	bsr.w	Add_encoded_2_RText
	movea.l	a2,a0
	bsr.w	Add_ASCII_2_RText
	lea.l	D_2e432,a0
	bsr.w	Add_ASCII_2_RText
	move.w	#$16,d0
	bsr.w	Add_encoded_2_RText
	bsr.w	T_0707a
	jsr	Switch_screen
	jsr	Copy_screen
	bsr.w	Exit_RText
	bsr.w	Wait_4_user
	movea.l	Off_screen,a6
	bsr.w	Erase_text_window
	jsr	Switch_screen
	jsr	Copy_screen
	bsr.w	Pop_PA
	movem.l	(a7)+,d0/d4-d5/d7/a0-a2/a6
	rts
; ---- MerchMAGIC_DisUpd (original source: MAIN/PLACES.ASM)
MerchMAGIC_DisUpd:
	bsr.w	Update_status_block
	lea.l	MMAGIC_CIL,a0
	lea.l	MMAGICCIL_evaluate,a1
	bsr.w	Update_control_icons
	bsr.w	Display_gold
	bsr.w	Update_quantity_colours
	rts	
; ---- MerchMAGIC_DisInit (original source: MAIN/PLACES.ASM)
MerchMAGIC_DisInit:
	move.l	#Lay3_PlusMes,PlusMes_info
	move.l	#Code0002Sys,Textfile_ptr
	move.l	#Sold_data,Itemdata_ptr
	move.l	#Sold_slots,Itemslots_ptr
	movea.l	Off_screen,a6
	moveq.l	#3,d0
	bsr.w	Show_layout
	bsr.w	Display_80x80_picture
	bsr.w	Places_DisInit
	lea.l	MMAGIC_CIL,a0
	bsr.w	MMAGICCIL_evaluate
	move.l	a0,Control_list_ptr
	bsr.w	Show_control_icons
	bsr.w	Show_objects_LAY3
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	Lay3_L2,a0
	jsr	Set_layout_data
	bra.w	Fadein_lay3
; ---- MMAGICCIL_evaluate (original source: MAIN/PLACES.ASM)
MMAGICCIL_evaluate:
	movem.l	d0/d7/a1,-(sp)
	bclr	#7,(a0)
	bclr	#7,5(a0)
	tst.w	Places_gold
	beq.s	.Deac
	movea.l	Warecount_ptr,a1
	move.l	(a1)+,d0
	or.l	(a1)+,d0
	or.l	(a1)+,d0
	beq.s	.Deac
	lea.l	Sold_slots,a1
	move.b	(a1)+,d0
	moveq.l	#11-1,d7
.Loop2:
	and.b	(a1)+,d0
	dbra	d7,.Loop2
	tst.b	d0
	beq.s	.Not_empty2
.Deac:
	bset	#7,(a0)
.Not_empty2:
	lea.l	Sold_slots,a1
	move.l	(a1)+,d0
	or.l	(a1)+,d0
	or.l	(a1)+,d0
	bne.s	.Not_empty3
	bset	#7,5(a0)
.Not_empty3:
	bsr.w	Places_CIL_evaluate
	movem.l	(sp)+,d0/d7/a1
	rts	
; ---- Sage_DisUpd (original source: MAIN/PLACES.ASM)
Sage_DisUpd:
	bsr.w	Update_status_block
	lea.l	Sage_CIL,a0
	lea.l	SageCIL_evaluate,a1
	bsr.w	Update_control_icons
	bsr.w	Display_gold
	rts	
; ---- Sage_DisInit (original source: MAIN/PLACES.ASM)
Sage_DisInit:
	move.l	#Lay3_PlusMes,PlusMes_info
	movea.l	Off_screen,a6
	moveq.l	#3,d0
	bsr.w	Show_layout
	bsr.w	Display_80x80_picture
	bsr.w	Places_DisInit
	bsr.w	List_body_items
	move.l	#Sold_data,Itemdata_ptr
	move.l	#Sold_slots,Itemslots_ptr
	bsr.w	Show_objects_LAY3
	sf	Body_backpack
	lea.l	Sage_CIL,a0
	bsr.w	SageCIL_evaluate
	move.l	a0,Control_list_ptr
	bsr.w	Show_control_icons
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	Lay3_L2,a0
	jsr	Set_layout_data
	bra.w	Fadein_lay3
; ---- SageCIL_evaluate (original source: MAIN/PLACES.ASM)
SageCIL_evaluate:
	tst.b	Body_backpack
	beq.s	.Backpack
	bclr	#7,(a0)
	bset	#7,3(a0)
	bra.s	.Exit
.Backpack:
	bset	#7,(a0)
	bclr	#7,3(a0)
.Exit:
	bsr.w	Places_CIL_evaluate
	rts	
; ---- Show_body_items (original source: MAIN/PLACES.ASM)
Show_body_items:
	move.l	#Sold_data,Itemdata_ptr
	move.l	#Sold_slots,Itemslots_ptr
	movea.l	Off_screen,a6
	bsr.w	Show_objects_LAY3
	jsr	Switch_screen
	jsr	Copy_screen
	not.b	Body_backpack
	rts	
; ---- Show_backpack_items (original source: MAIN/PLACES.ASM)
Show_backpack_items:
	movea.l	Current_active_char_data,a0
	lea.l	Inv_data+360(a0),a1
	move.l	a1,Itemdata_ptr
	lea.l	Inventory_1_place_counter(a0),a1
	move.l	a1,Itemslots_ptr
	movea.l	Off_screen,a6
	bsr.w	Show_objects_LAY3
	jsr	Switch_screen
	jsr	Copy_screen
	not.b	Body_backpack
	rts	
; ---- Lore_item (original source: MAIN/PLACES.ASM)
Lore_item:
	tst.b	d0
	beq.w	.Exit
	movea.l	Itemslots_ptr,a0
	ext.w	d0
	tst.b	-1(a0,d0.w)
	beq.w	.Exit
	tst.b	Body_backpack
	beq.s	.Body
	addi.w	#9,d0
.Body:
	move.b	d0,Object_slot_number
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	movea.l	Current_active_char_data,a0
	lea.l	Inv_data-40(a0),a0
	mulu.w	#40,d0
	adda.w	d0,a0
	btst	#7,Item_stat_bits(a0)
	beq.s	.No
	move.l	#Lay3_PlusMes,PlusMes_info
	move.l	#Code0003Sys,Textfile_ptr
	move.w	#$19,d0	; CHANGE: was "PlusMes 24"
	bsr.w	Plus_message
	bra.s	.Exit
.No:
	movea.l	Placedat_ptr,a0
	move.w	(a0),d0
	cmp.w	Places_gold,d0
	ble.s	.Ok
	move.l	#Lay3_PlusMes,PlusMes_info
	move.l	#Code0002Sys,Textfile_ptr
	move.w	#22,d0
	bsr.w	Plus_message
	bra.s	.Exit
.Ok:
	move.w	d0,Total_price
	lea.l	LoreItemReq_Mod,a0
	bsr.w	Push_Module
.Exit:
	rts	
; ---- LoreItemReq_ModInit (original source: MAIN/PLACES.ASM)
LoreItemReq_ModInit:
	move.l	#Code0003Sys,Textfile_ptr
	moveq.l	#0,d0
	bra.w	BuyTRANSReq_ModInit
T_0da6a:
	move.w	Total_price,d0
	sub.w	d0,Places_gold
	movea.l	Current_active_char_data,a0
	lea.l	$132(a0),a0
	move.b	Object_slot_number,d0
	ext.w	d0
	subq.w	#$1,d0
	mulu.w	#$28,d0
	adda.w	d0,a0
	bset	#$7,$18(a0)
.l_0da96:
	btst	#$1,Mouse_button_state
	bne.b	.l_0da96
	movea.l	Current_active_char_data,a0
	lea.l	$22(a0),a1
	lea.l	$132(a0),a0
	move.l	a0,Itemdata_ptr
	move.l	a1,Itemslots_ptr
	lea.l	D_28160,a0
	move.l	#.l_0dace,$28(a0)
	bsr.w	Push_Module
	rts
.l_0dace:
	clr.l	D_28188
	tst.b	Body_backpack
	bne.b	.l_0daf2
	move.l	#Sold_data,Itemdata_ptr
	move.l	#Sold_slots,Itemslots_ptr
	bra.b	.l_0db0c
.l_0daf2:
	dc.b	$20,$79
	dc.l	Current_active_char_data
	dc.b	$43,$e8,$02,$9a,$23,$c9
	dc.l	Itemdata_ptr
	dc.b	$43,$e8,$00,$2b,$23,$c9
	dc.l	Itemslots_ptr
.l_0db0c:
	rts
; ---- List_body_items (original source: MAIN/PLACES.ASM)
List_body_items:
	movem.l	d6/d7/a0-a3,-(sp)
	movea.l	Current_active_char_data,a0
	lea.l	Inv_data(a0),a1
	lea.l	Neck_place_counter(a0),a0
	lea.l	Sold_slots,a2
	lea.l	Sold_data,a3
	clr.l	(a2)+
	clr.l	(a2)+
	clr.l	(a2)
	lea.l	-8(a2),a2
	moveq.l	#9-1,d7
.Loop1:
	tst.b	(a0)+
	beq.s	.Next
	cmpi.b	#17,Item_type(a1)
	beq.s	.Next
	move.b	#1,(a2)+
	moveq.l	#10-1,d6
.Loop2:
	move.l	(a1)+,(a3)+
	dbra	d6,.Loop2
	bra.s	.Skip
.Next:
	lea.l	40(a1),a1
	addq.l	#1,a2
	lea.l	40(a3),a3
.Skip:
	dbra	d7,.Loop1
	movem.l	(sp)+,d6/d7/a0-a3
	rts	
; ---- Sage_Member_left (original source: MAIN/PLACES.ASM)
Sage_Member_left:
	andi.l	#$0000ff00,d0
	beq.s	.Exit
	lsr.w	#8,d0
	cmp.w	Active_member,d0
	beq.s	.Exit
	lea.l	Chard_ptrs-4,a0
	move.w	d0,d1
	add.w	d1,d1
	add.w	d1,d1
	adda.w	d1,a0
	tst.l	(a0)
	beq.s	.Exit
	movea.l	(a0),a1
	move.w	Body_conditions(a1),d1
	andi.w	#$e406,d1	; CHANGE: was "andi.w #$e506,d1"
	bne.s	.Exit
	move.w	d0,Active_member
	move.l	a1,Current_active_char_data
	bsr.w	List_body_items
	tst.b	Body_backpack
	beq.s	.Body
	movea.l	Current_active_char_data,a0
	lea.l	Inv_data+360(a0),a1
	move.l	a1,Itemdata_ptr
	lea.l	Inventory_1_place_counter(a0),a1
	move.l	a1,Itemslots_ptr
.Body:
	movea.l	Off_screen,a6
	bsr.w	Show_objects_LAY3
	jsr	Switch_screen
	jsr	Copy_screen
.Exit:
	rts	
; ---- Inn_DisUpd (original source: MAIN/PLACES.ASM)
Inn_DisUpd:
	bsr.w	Update_status_block
	lea.l	Inn_CIL,a0
	lea.l	InnCIL_evaluate,a1
	bsr.w	Update_control_icons
	bsr.w	Display_gold
	rts	
; ---- Inn_DisInit (original source: MAIN/PLACES.ASM)
Inn_DisInit:
	sf	Room_rented
	move.l	#Lay3_PlusMes,PlusMes_info
	movea.l	Off_screen,a6
	moveq.l	#3,d0
	bsr.w	Show_layout
	bsr.w	Display_80x80_picture
	bsr.w	Places_DisInit
	bsr.w	T_0dcdc	; CHANGE: added
	move.w	d0,d1	; CHANGE: added
	movea.l	Placedat_ptr,a0
	move.w	(a0),d0
	mulu.w	d1,d0	; CHANGE: was "mulu.w Nr_members,d0"
	move.w	d0,Total_price
	lea.l	Inn_CIL,a0
	bsr.w	InnCIL_evaluate
	move.l	a0,Control_list_ptr
	bsr.w	Show_control_icons
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	Lay3_L2,a0
	jsr	Set_layout_data
	bra.w	Fadein_lay3
; ---- InnCIL_evaluate (original source: MAIN/PLACES.ASM)
InnCIL_evaluate:
	bclr	#7,3(a0)
	tst.b	Room_rented
	bne.s	.Deac
	move.w	Total_price,d0
	cmp.w	Places_gold,d0
	ble.s	.Ok
.Deac:
	bset	#7,3(a0)
.Ok:
	bsr.w	Places_CIL_evaluate
	rts	
; ---- Guestroom (original source: MAIN/PLACES.ASM)
Guestroom:
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	lea.l	GuestroomReq_Mod,a0
	bsr.w	Push_Module
	rts	
; ---- GuestroomReq_ModInit (original source: MAIN/PLACES.ASM)
GuestroomReq_ModInit:
	moveq.l	#6,d0
	move.l	#Code0003Sys,Textfile_ptr
	bra.w	BuyTRANSReq_ModInit
; ---- GuestroomYes (original source: MAIN/PLACES.ASM)
GuestroomYes:
	move.w	Total_price,d0
	sub.w	d0,Places_gold
	st	Inn_flag
	st	Room_rented
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	bsr.w	Exit_display
	bra.w	Pop_Module
T_0dcdc:
	movem.l	d7/a0-a1,-(a7)
	lea.l	Chard_ptrs,a0
	moveq	#0,d0
	moveq	#5,d7
.l_0dcea:
	tst.l	(a0)
	beq.b	.l_0dcfa
	movea.l	(a0),a1
	cmpi.b	#$9,$4(a1)
	bpl.b	.l_0dcfa
	addq.w	#$1,d0
.l_0dcfa:
	addq.l	#$4,a0
	dbra	d7,.l_0dcea
	movem.l	(a7)+,d7/a0-a1
	rts

	section	data

GoldDis_text:
	dc.b	$30
D_2610f:
	dc.b	$31,$32,$33,$34,$00
Make_level_txt:
	dc.b	$30,$31,$25,$00
Bonus_txt:
	dc.b	$42,$4f,$4e,$55,$53,$20,$3a,$20,$30,$31,$25,$00
Multi_txt:
	dc.b	$20,$78,$20,$00
D_26128:
	dc.b	$20,$45,$50,$2e,$00,$00
Guild_CIL:
	dc.b	$34,$38,$1e,$35,$38,$38,$1f,$32,$12,$00
	dc.l	T_0b1c0
	dc.b	$00,$00,$00,$00
	dc.l	Exit_PLACES
	dc.l	T_0b22e
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00
	dc.l	Pool_gold_PLACES
	dc.l	Divide_gold_PLACES
	dc.l	Transfer_gold_PLACES
MOBJC_CIL:
	dc.b	$36,$38,$1e,$37,$23,$21,$1f,$32,$12,$00
	dc.l	Buy_item
	dc.b	$00,$00,$00,$00
	dc.l	Exit_PLACES
	dc.l	T_0b9a8
	dc.l	View_item_MOBJC
	dc.l	Transfer_item_MOBJC
	dc.l	Pool_gold_PLACES
	dc.l	Divide_gold_PLACES
	dc.l	Transfer_gold_PLACES
MFOOD_CIL:
	dc.b	$38,$38,$1e,$40,$33,$14,$1f,$32,$12,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00
	dc.l	Exit_PLACES
	dc.l	T_0c9f2
	dc.l	T_0c9d4
	dc.l	MFOOD_Transfer_food
	dc.l	Pool_gold_PLACES
	dc.l	Divide_gold_PLACES
	dc.l	Transfer_gold_PLACES
MHORSE_CIL:
	dc.b	$38,$38,$1e,$05,$38,$38,$1f,$32,$12,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00
	dc.l	Exit_PLACES
	dc.l	Buy_horses
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00
	dc.l	Pool_gold_PLACES
	dc.l	Divide_gold_PLACES
	dc.l	Transfer_gold_PLACES
D_261e6:
	dc.b	$38,$38,$1e,$06,$38,$38,$1f,$32,$12,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00
	dc.l	Exit_PLACES
	dc.l	T_0ce6c
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00
	dc.l	Pool_gold_PLACES
	dc.l	Divide_gold_PLACES
	dc.l	Transfer_gold_PLACES
D_26214:
	dc.b	$38,$38,$1e,$16,$38,$38,$1f,$32,$12,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00
	dc.l	Exit_PLACES
	dc.l	T_0cf6e
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00
	dc.l	Pool_gold_PLACES
	dc.l	Divide_gold_PLACES
	dc.l	Transfer_gold_PLACES
Healer_CIL:
	dc.b	$38,$38,$1e,$0c,$38,$38,$1f,$32,$12,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00
	dc.l	Exit_PLACES
	dc.l	Healer_Remove_curse
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00
	dc.l	Pool_gold_PLACES
	dc.l	Divide_gold_PLACES
	dc.l	Transfer_gold_PLACES
MMAGIC_CIL:
	dc.b	$36,$38,$1e,$38,$23,$21,$1f,$32,$12,$00
	dc.l	Buy_item
	dc.b	$00,$00,$00,$00
	dc.l	Exit_PLACES
	dc.b	$00,$00,$00,$00
	dc.l	View_item_MOBJC
	dc.l	Transfer_item_MOBJC
	dc.l	Pool_gold_PLACES
	dc.l	Divide_gold_PLACES
	dc.l	Transfer_gold_PLACES
Sage_CIL:
	dc.b	$09,$38,$1e,$1d,$38,$38,$1f,$32,$12,$00
	dc.l	Show_body_items
	dc.b	$00,$00,$00,$00
	dc.l	Exit_PLACES
	dc.l	Show_backpack_items
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00
	dc.l	Pool_gold_PLACES
	dc.l	Divide_gold_PLACES
	dc.l	Transfer_gold_PLACES
Inn_CIL:
	dc.b	$38,$38,$1e,$13,$38,$38,$1f,$32,$12,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00
	dc.l	Exit_PLACES
	dc.l	Guestroom
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00
	dc.l	Pool_gold_PLACES
	dc.l	Divide_gold_PLACES
	dc.l	Transfer_gold_PLACES
XLay3_target_hbl:
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$07,$50,$03,$33,$02,$22,$01,$11,$07,$42
	dc.b	$06,$31,$02,$00,$05,$66,$03,$45,$07,$54,$06,$43,$05,$32,$04,$21
	dc.b	$03,$10,$07,$65
D_2633e:
	dc.b	$08,$09,$09,$0a,$0a,$0b,$0b,$0c,$0c,$0d,$0d,$00,$0e,$00,$0f,$00
	dc.b	$ff,$00,$01,$0f,$ff,$00,$ff,$00,$04,$12
D_26358:
	dc.b	$ff,$ff,$ff,$ff,$0e,$ff,$ff,$0f,$10,$11,$11,$11,$12,$ff,$ff,$ff
	dc.b	$ff,$ff,$ff,$ff,$ff,$ff,$ff,$00

	section	bss

Place_nr:
	ds.b	2
Places_gold:
	ds.b	2
Placedat_ptr:
	ds.b	4
Placetext_ptr:
	ds.b	3
B_58273:
	ds.b	1
Make_level_offsets:
	ds.b	9
B_5827d:
	ds.b	1
Possible_level_offsets:
	ds.b	10
Exit_on:
	ds.b	1
Room_rented:
	ds.b	1
Trans_created:
	ds.b	1
Body_backpack:
	ds.b	1
Cursed_slots:
	ds.b	10
Remaining_offset:
	ds.b	2
Warecount_ptr:
	ds.b	4
Sold_data:
	ds.b	479
B_5847b:
	ds.b	1
Sold_slots:
	ds.b	12
Total_price:
	ds.b	2
Places_food:
	ds.b	2
Nr_cursed_objects:
	ds.b	2
Current_healer_victim:
	ds.b	4
Healer_victim_nr:
	ds.b	2
