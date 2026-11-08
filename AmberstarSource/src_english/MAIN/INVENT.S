; MAIN/INVENT.ASM (original module, merged with the disassembly of the shipped program)

	section	text

; ---- Inv1_DisUpd (original source: MAIN/INVENT.ASM)
Inv1_DisUpd:
	jsr	Update_status_block
	rts	
T_10b56:
	btst	#$1,Mouse_button_state
	bne.b	T_10b56
	bsr.w	Pop_Module
	bra.w	Init_display
Inv1_ModInit:
	lea.l	D_2e7ae,a0
	jsr	Push_PA
	lea.l	D_2e7a6,a0
	jsr	Push_MA
	movea.l	Current_inventory_chardat_ptr,a0
	lea.l	$22(a0),a1
	lea.l	Inv_data(a0),a0
	move.l	a0,Itemdata_ptr
	move.l	a1,Itemslots_ptr
	tst.b	B_587f8
	beq.b	.l_10baa
	sf.b	B_587f8
	bra.b	.l_10bae
.l_10baa:
	bsr.w	Inv1_DisInit
.l_10bae:
	rts
Inv1_ModExit:
	jsr	Pop_MA
	jsr	Pop_PA
	bsr.w	Inv1_DisExit
	tst.b	Battling
	beq.b	.l_10bcc
	bsr.w	T_16b64
.l_10bcc:
	rts
Inv1_DisInit:
	movea.l	Off_screen,a6
	moveq	#6,d0
	jsr	Show_layout
	moveq	#34,d7
	movea.l	Current_inventory_chardat_ptr,a1
	bsr.w	Display_character
	move.w	#$16,d0
	move.w	#$73,d1
	move.w	#$48,d2
	jsr	IG_Set_cursor
	lea.l	Skills_name,a0
	jsr	Print_centered_string
	move.w	#$16,d2
	move.w	#$7a,d3
	moveq	#0,d6
	moveq	#2,d7
	lea.l	D_48488,a2
	lea.l	$6(a1),a4
	lea.l	$b0(a1),a5
.l_10c20:
	move.w	d2,d0
	move.w	d3,d1
	jsr	IG_Set_cursor
	move.w	d6,d0
	add.w	d0,d0
	move.w	(a2,d0.w),d0
	bsr.w	Get_word
	lea.l	Line_buffer,a0
	clr.b	$3(a0)
	jsr	IG_Print
	move.w	#$1e,d0
	add.w	d2,d0
	move.w	d3,d1
	jsr	IG_Set_cursor
	lea.l	Skill_txt,a3
	moveq	#48,d1
	moveq	#0,d0
	move.b	(a4)+,d0
	add.w	(a5)+,d0
	bsr.w	RConvert_number
	addq.l	#$2,a3
	moveq	#0,d0
	move.b	$9(a4),d0
	bsr.w	RConvert_number
	lea.l	Skill_txt,a0
	jsr	IG_Print
	addq.w	#$7,d3
	addq.w	#$1,d6
	cmpi.w	#$a,d6
	bmi.b	.l_10c20
	move.w	#$16,d0
	move.w	#$32,d1
	move.w	#$48,d2
	lea.l	D_2da9b,a0
	jsr	Print_centered_string
	lea.l	D_47370,a2
	move.w	#$16,d2
	move.w	#$39,d3
	moveq	#0,d6
	moveq	#3,d7
	lea.l	$48(a1),a4
	lea.l	$9c(a1),a5
.l_10cba:
	move.w	d2,d0
	move.w	d3,d1
	jsr	IG_Set_cursor
	move.w	d6,d0
	add.w	d0,d0
	move.w	(a2,d0.w),d0
	bsr.w	Get_word
	lea.l	Line_buffer,a0
	clr.b	$3(a0)
	jsr	IG_Print
	move.w	#$1e,d0
	add.w	d2,d0
	move.w	d3,d1
	jsr	IG_Set_cursor
	lea.l	Attr_txt,a3
	moveq	#48,d1
	move.w	(a4)+,d0
	add.w	(a5)+,d0
	bsr.w	RConvert_number
	addq.l	#$1,a3
	move.w	$12(a4),d0
	bsr.w	RConvert_number
	lea.l	Attr_txt,a0
	jsr	IG_Print
	addq.w	#$7,d3
	addq.w	#$1,d6
	cmpi.w	#$8,d6
	bmi.b	.l_10cba
	move.w	#$6a,d0
	move.w	#$32,d1
	jsr	IG_Set_cursor
	lea.l	D_2dab0,a0
	jsr	IG_Print
	lea.l	Misc_dat,a2
	move.w	#$39,d1
	move.w	#$6a,d2
	move.b	$37(a1),d6
	moveq	#0,d7
.l_10d4c:
	move.w	d2,d0
	jsr	IG_Set_cursor
	btst	d7,d6
	beq.b	.l_10d6c
	move.w	(a2),d0
	bsr.w	Get_word
	lea.l	Line_buffer,a0
	jsr	IG_Print
	addq.w	#$7,d1
.l_10d6c:
	addq.l	#$2,a2
	addq.w	#$1,d7
	cmpi.b	#$8,d7
	bmi.b	.l_10d4c
	move.w	#$6a,d0
	move.w	#$73,d1
	jsr	IG_Set_cursor
	lea.l	D_2dabe,a0
	jsr	IG_Print
	move.w	#$6a,d2
	move.w	#$7c,d3
	lea.l	Status_icn,a0
	lea.l	D_2dc52,a2
	move.b	$3a(a1),d6
	move.b	#$e0,d7
	and.b	d6,d7
	beq.b	.l_10dbc
	move.w	d2,d0
	move.w	d3,d1
	jsr	Blit_masked_block
	bra.b	.l_10e36
.l_10dbc:
	lea.l	$480(a0),a0
	moveq	#0,d7
.l_10dc2:
	btst	d7,d6
	beq.b	.l_10dd4
	move.w	d2,d0
	move.w	d3,d1
	add.w	(a2)+,d0
	add.w	(a2)+,d1
	jsr	Blit_masked_block
.l_10dd4:
	lea.l	$80(a0),a0
	addq.w	#$1,d7
	cmpi.w	#$6,d7
	bmi.b	.l_10dc2
	move.w	#$9a,d0
	move.w	#$73,d1
	jsr	IG_Set_cursor
	lea.l	D_2dac7,a0
	jsr	IG_Print
	move.w	#$9a,d2
	move.w	#$7c,d3
	move.b	$3b(a1),d6
	moveq	#0,d7
	lea.l	Status_icn,a0
	lea.l	D_2dc52,a2
	lea.l	$700(a0),a0
.l_10e18:
	btst	d7,d6
	beq.b	.l_10e2a
	move.w	d2,d0
	move.w	d3,d1
	add.w	(a2)+,d0
	add.w	(a2)+,d1
	jsr	Blit_masked_block
.l_10e2a:
	lea.l	$80(a0),a0
	addq.w	#$1,d7
	cmpi.w	#$6,d7
	bmi.b	.l_10e18
.l_10e36:
	move.l	#D_2d9e4,Control_list_ptr
	jsr	Show_control_icons
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	Control_area,a0
	jsr	Set_layout_data
	tst.b	Fade_block
	beq.b	.l_10e6e
	sf.b	Fade_block
	bra.b	.l_10ea0
.l_10e6e:
	lea.l	D_3035c,a1
	lea.l	Subfade1,a2
.l_10e7a:
	lea.l	Hbl_Inv1_list,a0
	jsr	Update_HBL
	jsr	My_vsync
	jsr	My_vsync
	lea.l	Inv1_below,a0
	jsr	Fade_pal
	bne.b	.l_10e7a
.l_10ea0:
	lea.l	Hbl_Inv1_list,a0
	jsr	Update_HBL
	rts
; ---- Inv1_DisExit (original source: MAIN/INVENT.ASM)
; CHANGE: removed "movem.l a0-a2,-(sp)"
Inv1_DisExit:
	lea.l	Void,a1
	lea.l	Subfade1,a2
.Again:
	lea.l	Hbl_Inv1_list,a0
	jsr	Update_HBL
	jsr	My_vsync
	jsr	My_vsync
	lea.l	Inv1_below,a0
	jsr	Fade_pal
	bne.s	.Again
	lea.l	Hbl_Inv1_list,a0
	jsr	Update_HBL
; CHANGE: removed "movem.l (sp)+,a0-a2"
.Exit:
	rts	
; ---- Get_word (original source: MAIN/INVENT.ASM)
Get_word:
	move.l	d0,-(sp)
	jsr	Find_word
	lea.l	Line_buffer,a3
	moveq.l	#0,d0
	move.b	(a0)+,d0
	subq.w	#1,d0
	bra.s	.Entry
.Loop:
	move.b	(a0)+,(a3)+
.Entry:
	dbra	d0,.Loop
	clr.b	(a3)
	move.l	(sp)+,d0
	rts	
T_10f10:
	btst	#$1,Mouse_button_state
	bne.b	T_10f10
; ---- Go_Inv2 (original source: MAIN/INVENT.ASM)
Go_Inv2:
	movea.l	Current_inventory_chardat_ptr,a0
	move.w	#$482,d0	; CHANGE: was "move.w #$0402,d0"
	and.w	Body_conditions(a0),d0
	bne.s	.Exit
	bsr.w	Exit_display
	lea.l	Inv2_Mod,a0
	bsr.w	Push_Module
.Exit:
	rts	
T_10f3a:
	btst	#$1,Mouse_button_state
	bne.b	T_10f3a
	bsr.w	Pop_Module
	bra.w	T_10b56
T_10f4c:
	btst	#$1,Mouse_button_state
	bne.b	T_10f4c
	bsr.w	Pop_Module
	bra.w	Init_display
Inv2_DisUpd:
	jsr	Update_status_block
	lea.l	D_2da12,a0
	lea.l	Inv2CIL_evaluate,a1
	bsr.w	Update_control_icons
	bsr.w	Update_quantity_colours
	rts
T_10f7a:
	lea.l	D_2e7ae,a0
	jsr	Push_PA
	lea.l	D_2e7a6,a0
	jsr	Push_MA
	bra.w	Inv2_DisInit
T_10f96:
	clr.w	B_5891c
	jsr	Pop_MA
	jsr	Pop_PA
	bra.w	Inv2_DisExit
Inv2_DisInit:
	move.w	#$10,Mesmin_X
	move.w	#$32,Mesmin_Y
	move.w	#$b0,Mesmin_Wd
	move.l	#Code0001Sys,Textfile_ptr
	move.l	#D_2dd6e,PlusMes_info
	movea.l	Off_screen,a6
	moveq	#2,d0
	jsr	Show_layout
	movea.l	Current_inventory_chardat_ptr,a0
	lea.l	$22(a0),a1
	lea.l	Inv_data(a0),a0
	move.l	a0,Itemdata_ptr
	move.l	a1,Itemslots_ptr
	movea.l	Current_inventory_chardat_ptr,a1
	moveq	#33,d7
	bsr.w	Display_character
	lea.l	$22(a1),a2
	lea.l	$132(a1),a4
	moveq	#1,d1
	moveq	#20,d7
	cmpi.b	#$e,$4(a1)
	bmi.b	.l_11030
	lea.l	$9(a2),a2
	lea.l	$168(a4),a4
	addi.w	#$9,d1
	subi.w	#$9,d7
.l_11030:
	tst.b	(a2)+
	beq.b	.l_1103a
	move.b	(a4),d0
	bsr.w	INV2_Show_object
.l_1103a:
	addq.l	#$1,d1
	lea.l	$28(a4),a4
	dbra	d7,.l_11030
	lea.l	$25(a1),a2
	tst.b	(a2)
	beq.b	.l_11060
	lea.l	$1aa(a1),a3
	cmpi.b	#$2,$4(a3)
	bne.b	.l_11060
	moveq	#0,d0
	moveq	#6,d1
	bsr.w	INV2_Show_object
.l_11060:
	move.w	#$10,d0
	move.w	#$b2,d1
	move.w	#$50,d2
	lea.l	D_2dad0,a0
	jsr	Print_centered_string
	lea.l	D_2da12,a0
	bsr.w	Inv2CIL_evaluate
	move.l	a0,Control_list_ptr
	jsr	Show_control_icons
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	D_2f778,a0
	jsr	Set_layout_data
	tst.b	Fade_block
	beq.b	.l_110b6
	sf.b	Fade_block
	bra.b	.l_110e8
.l_110b6:
	lea.l	D_2da40,a1
	lea.l	Subfade1,a2
.l_110c2:
	lea.l	Hbl_Inv2_list,a0
	jsr	Update_HBL
	jsr	My_vsync
	jsr	My_vsync
	lea.l	Inv2_below,a0
	jsr	Hbl_fade
	bne.b	.l_110c2
.l_110e8:
	lea.l	Hbl_Inv2_list,a0
	jsr	Update_HBL
	rts
; ---- Inv2_DisExit (original source: MAIN/INVENT.ASM)
Inv2_DisExit:
	lea.l	Void,a1
	lea.l	Subfade1,a2
.Again:
	lea.l	Hbl_Inv2_list,a0
	jsr	Update_HBL
	jsr	My_vsync
	jsr	My_vsync
	lea.l	Inv2_below,a0
	jsr	Hbl_fade
	bne.s	.Again
	lea.l	Hbl_Inv2_list,a0
	jsr	Update_HBL
	rts	
; ---- INV2_Show_object (original source: MAIN/INVENT.ASM)
INV2_Show_object:
	movem.l	d0-d2/a0,-(sp)
	move.b	d0,d2
	lea.l	Object_pos_list-4,a0
	add.w	d1,d1
	add.w	d1,d1
	move.w	0(a0,d1.w),d0
	move.w	2(a0,d1.w),d1
	lea.l	Layout_icn+9856,a0
	jsr	Put_unmasked_block
	lea.l	Objects_icn,a0
	ext.w	d2
	lsl.w	#7,d2
	adda.w	d2,a0
	jsr	Put_masked_block
	movem.l	(sp)+,d0-d2/a0
	rts	
; ---- INV2_Erase_object (original source: MAIN/INVENT.ASM)
INV2_Erase_object:
	movem.l	d0-d2/a0,-(sp)
	ext.w	d0
	move.w	d0,d2
	lea.l	Object_pos_list-4,a0
	add.w	d0,d0
	add.w	d0,d0
	move.w	2(a0,d0.w),d1
	move.w	0(a0,d0.w),d0
	lea.l	Erase_icon,a0
	move.b	-1(a0,d2.w),d2
	lea.l	Layout_icn-128,a0
	ext.w	d2
	lsl.w	#7,d2
	adda.w	d2,a0
	jsr	Put_unmasked_block
	movem.l	(sp)+,d0-d2/a0
	rts	
; ---- Display_quantities (original source: MAIN/INVENT.ASM)
Display_quantities:
	lea.l	Quant_init_string,a0
	jsr	IG_Print
	lea.l	Line_buffer,a0
	movea.l	Current_inventory_chardat_ptr,a1
	lea.l	Inventory_1_place_counter(a1),a2
	movea.l	Off_screen,a6
	tst.b	Quant_block
	bne.s	.No_quant
	lea.l	Object_pos_list+36,a4
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
	lea.l	(a0),a3
	moveq.l	#" ",d1
	bsr.w	RConvert_number
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
	lea.l	Inventory_1_place_counter(a1),a2
	lea.l	Inv_data+9*40(a1),a3
	moveq.l	#10,d1
	moveq.l	#12-1,d6
.Loop2:
	cmpi.b	#1,(a2)+
	bls.s	.Next2
	move.b	(a3),d0
	bsr.w	INV2_Show_object
.Next2:
	addq.w	#1,d1
	lea.l	40(a3),a3
	dbra	d6,.Loop2
	rts	
T_11244:
	movea.l	Current_inventory_chardat_ptr,a0
	move.l	Weight_normal(a0),d2
	divu.w	#$3e8,d2
	ext.l	d2
	moveq	#0,d3
	move.w	Attr_1_normal(a0),d3
	add.w	Attr_1_normal_magic(a0),d3
	lea.l	D_2dbef,a0
	cmp.l	d2,d3
	bpl.b	.l_1128c
	lea.l	D_2da84,a1
	move.w	Curse_index,d0
	addq.w	#$1,d0
	move.b	(a1,d0.w),d1
	bpl.b	.l_11280
	moveq	#0,d0
	move.b	(a1),d1
.l_11280:
	move.w	d0,Curse_index
	move.b	d1,$1(a0)
	bra.b	.l_11292
.l_1128c:
	move.b	#$f,$1(a0)
.l_11292:
	moveq	#48,d1
	moveq	#3,d7
	movea.l	Off_screen,a6
	move.l	d2,d0
	lea.l	$4(a0),a3
	bsr.w	RConvert_number
	move.l	d3,d0
	lea.l	$b(a0),a3
	bsr.w	RConvert_number
	move.w	#$10,d0
	move.w	#$ba,d1
	move.w	#$50,d2
	jsr	Print_centered_string
	rts
; ---- Inv2CIL_evaluate (original source: MAIN/INVENT.ASM)
Inv2CIL_evaluate:
	movem.l	d0/d7/a1/a2,-(sp)
	lea.l	(a0),a2
	moveq.l	#9-1,d7
.Loop0:
	bclr	#7,(a2)+
	dbra	d7,.Loop0
	movea.l	Current_inventory_chardat_ptr,a1
	tst.b	Battling	; CHANGE: added
	beq.b	.c_11310	; CHANGE: added
	bset	#$7,$1(a0)	; CHANGE: added
	bset	#$7,$4(a0)	; CHANGE: added
	bset	#$7,$6(a0)	; CHANGE: added
	bset	#$7,$7(a0)	; CHANGE: added
	bset	#$7,$8(a0)	; CHANGE: added
	move.w	$3a(a1),d0	; CHANGE: added
	andi.w	#$e480,d0	; CHANGE: added
	beq.b	.c_11310	; CHANGE: added
	bset	#$7,$3(a0)	; CHANGE: added
.c_11310:
	cmpi.b	#9,Character_class(a1)
	bmi.s	.No_special
	bset	#7,3(a0)
	bset	#7,4(a0)
	bset	#7,5(a0)
	bset	#7,7(a0)
.No_special:
	lea.l	Inventory_1_place_counter(a1),a2
	move.b	(a2)+,d0
	moveq.l	#11-1,d7
.Loop1:
	or.b	(a2)+,d0
	dbra	d7,.Loop1
	tst.b	d0
	bne.s	.Check_gold
	bset	#7,1(a0)
	bset	#7,6(a0)
	lea.l	Neck_place_counter(a1),a2
	move.b	(a2)+,d0
	moveq.l	#8-1,d7
.Loop2:
	or.b	(a2)+,d0
	dbra	d7,.Loop2
	tst.b	d0
	bne.s	.Check_gold
	bset	#7,3(a0)
	bset	#7,5(a0)
.Check_gold:
	tst.w	Gold_coins(a1)
	bne.s	.Check_weight
	bset	#7,7(a0)
.Check_weight:
	move.w	Attr_1_normal(a1),d0
	add.w	Attr_1_normal_magic(a1),d0
	mulu.w	#1000,d0
	cmp.l	Weight_normal(a1),d0
	bls.s	.No_way
	move.w	#$e000,d0
	and.w	Body_conditions(a1),d0
	beq.s	.Check_food
.No_way:
	bset	#7,4(a0)
.Check_food:
	tst.w	Food_rations(a1)
	bne.s	.Exit
	bset	#7,8(a0)
.Exit:
	movem.l	(sp)+,d0/d7/a1/a2
	rts	
; ---- Update_CIL (original source: MAIN/INVENT.ASM)
Update_CIL:
	tst.b	CIL_update
	beq.s	.Exit
	movea.l	Off_screen,a6
	jsr	Show_control_icons
	subq.b	#1,CIL_update
.Exit:
	rts	
; ---- Display_character (original source: MAIN/INVENT.ASM)
Display_character:
	movem.l	d0/d1/d6/d7/a0/a2/a3,-(sp)
	moveq.l	#2,d0
	jsr	IG_Set_paper
	moveq.l	#0,d0
	lea.l	Portrait+6(a1),a0
	move.w	#208,d0
	move.w	#49,d1
	moveq.l	#2,d6
	jsr	Blot_unmasked_block
	moveq.l	#1,d0
	jsr	IG_Set_ink
	move.w	#208,d0
	move.w	#84,d1
	move.w	#96,d2
	lea.l	Char_name(a1),a0
	jsr	Print_centered_string
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
	add.w	Attr_9_normal_magic(a1),d0
	add.w	Time_data_year,d0	; CHANGE: added
	moveq.l	#3,d7
	lea.l	(a0),a3
	bsr.w	LConvert_number
	jsr	IG_Print
	move.w	#208+34,d0
	move.w	#49+28,d1
	jsr	IG_Set_cursor
	lea.l	XP_txt,a0
	move.l	Experience_points(a1),d0
	moveq.l	#6,d7
	lea.l	3(a0),a3
	bsr.w	LConvert_number
	jsr	IG_Print
	move.w	#208+6,d0
	move.w	#85+35,d1
	moveq.l	#1,d6
	moveq.l	#10,d7
	lea.l	Swordshield,a0
	jsr	Blot_unmasked_block
	addi.w	#48,d0
	lea.l	80(a0),a0
	jsr	Blot_unmasked_block
	bsr.w	Update_character_info
	movem.l	(sp)+,d0/d1/d6/d7/a0/a2/a3
	rts	
; ---- Update_character_info (original source: MAIN/INVENT.ASM)
Update_character_info:
	movem.l	d0/d1/d7/a0/a1/a3/a6,-(sp)
	movea.l	Current_inventory_chardat_ptr,a1
	movea.l	Off_screen,a6
	moveq.l	#15,d0
	jsr	IG_Set_ink
	moveq.l	#2,d0
	jsr	IG_Set_paper
	move.w	#208+12,d0
	move.w	#85+7,d1
	jsr	IG_Set_cursor
	moveq.l	#"0",d1
	moveq.l	#3,d7
	move.w	Life_points_normal(a1),d0
	lea.l	LP_txt+5,a3
	bsr.w	RConvert_number
	move.w	Life_points_max(a1),d0
	add.w	Life_points_max_magic(a1),d0
	lea.l	LP_txt+9,a3
	bsr.w	RConvert_number
	lea.l	LP_txt,a0
	jsr	IG_Print
	move.w	#208+12,d0
	move.w	#85+14,d1
	jsr	IG_Set_cursor
	move.w	Power_points_max(a1),d0
	add.w	Power_points_max_magic(a1),d0
	beq.s	.No_magic
	moveq.l	#"0",d1
	lea.l	PP_txt+9,a3
	bsr.w	RConvert_number
	move.w	Power_points_normal(a1),d0
	lea.l	PP_txt+5,a3
	bsr.w	RConvert_number
	lea.l	PP_txt,a0
	jsr	IG_Print
	move.w	#208+12,d0
	move.w	#85+21,d1
	jsr	IG_Set_cursor
	move.w	Nr_spell_learn_points(a1),d0
	moveq.l	#"0",d1
	lea.l	SLP_txt+5,a3
	bsr.w	RConvert_number
	lea.l	SLP_txt,a0
	jsr	IG_Print
.No_magic:
	move.w	#208+6,d0
	move.w	#85+28,d1
	jsr	IG_Set_cursor
	moveq.l	#"0",d1
	lea.l	Goldfood_txt,a0
	move.w	Gold_coins(a1),d0
	moveq.l	#5,d7
	lea.l	2(a0),a3
	bsr.w	RConvert_number
	move.w	Food_rations(a1),d0
	moveq.l	#4,d7
	lea.l	10(a0),a3
	bsr.w	RConvert_number
	jsr	IG_Print
	move.w	#208+18,d0
	move.w	#85+35+2,d1
	jsr	IG_Set_cursor
	moveq.l	#3,d7
	lea.l	ProtDam_txt,a0
	moveq.l	#0,d0
	move.b	Damage(a1),d0
	add.w	Damage_magic(a1),d0
	moveq.l	#"0",d1
	lea.l	1(a0),a3
	bsr.w	RConvert_number
	jsr	IG_Print
	move.w	#208+18+48,d0
	move.w	#85+35+2,d1
	jsr	IG_Set_cursor
	moveq.l	#0,d0
	move.b	Protection(a1),d0
	add.w	Protection_magic(a1),d0
	moveq.l	#"0",d1
	lea.l	1(a0),a3
	bsr.w	RConvert_number
	jsr	IG_Print
	movem.l	(sp)+,d0/d1/d7/a0/a1/a3/a6
	rts	
; ---- RConvert_number (original source: MAIN/INVENT.ASM)
RConvert_number:
	movem.l	d0/d7/a0,-(sp)
	ext.l	d0
	jsr	Dec_convert
	addq.l	#1,a0
	bra.s	.Entry
.Loop:
	move.b	(a0)+,d0
	cmpi.b	#" ",d0
	bne.s	.Skip
	move.b	d1,d0
.Skip:
	move.b	d0,(a3)+
.Entry:
	dbra	d7,.Loop
	movem.l	(sp)+,d0/d7/a0
	rts	
; ---- LConvert_number (original source: MAIN/INVENT.ASM)
LConvert_number:
	movem.l	d7/a0,-(sp)
	ext.l	d0
	jsr	Dec_convert
	cmpi.b	#"-",(a0)+
	bne.s	.Seek
	move.b	#"-",(a3)+
.Seek:
	subq.w	#1,d7
	cmpi.b	#" ",(a0)+
	beq.s	.Seek
	subq.l	#1,a0
.Loop:
	move.b	(a0)+,(a3)+
	dbra	d7,.Loop
	clr.b	(a3)
	movem.l	(sp)+,d7/a0
	rts	
; ---- Inv1_Mright (original source: MAIN/INVENT.ASM)
Inv1_Mright:
	movem.l	d0/a0,-(sp)
	andi.l	#$0000ff00,d0
	beq.s	.Exit
	lsr.w	#6,d0
	lea.l	Chard_ptrs-4,a0
	adda.w	d0,a0
	tst.l	(a0)
	beq.s	.Exit
	movea.l	(a0),a0
	cmpa.l	Current_inventory_chardat_ptr,a0
	beq.s	.Exit
	move.l	a0,Current_inventory_chardat_ptr
	lea.l	Neck_place_counter(a0),a1
	lea.l	Inv_data(a0),a0
	move.l	a0,Itemdata_ptr
	move.l	a1,Itemslots_ptr
	st	Fade_block
	bsr.w	Init_display
.Exit:
	movem.l	(sp)+,d0/a0
	rts	
; ---- Inv2_Mright (original source: MAIN/INVENT.ASM)
Inv2_Mright:
	movem.l	d0/a0,-(sp)
	andi.l	#$0000ff00,d0
	beq.s	.Exit
	lsr.w	#6,d0
	lea.l	Chard_ptrs-4,a0
	adda.w	d0,a0
	tst.l	(a0)
	beq.s	.Exit
	movea.l	(a0),a0
	cmpa.l	Current_inventory_chardat_ptr,a0
	beq.s	.Exit
	move.w	#$0402,d0
	and.w	Body_conditions(a0),d0
	bne.s	.Exit
	move.l	a0,Current_inventory_chardat_ptr
	lea.l	Neck_place_counter(a0),a1
	lea.l	Inv_data(a0),a0
	move.l	a0,Itemdata_ptr
	move.l	a1,Itemslots_ptr
	st	Fade_block
	bsr.w	Init_display
.Exit:
	movem.l	(sp)+,d0/a0
	rts	
; ---- Show_object_name (original source: MAIN/INVENT.ASM)
Show_object_name:
	tst.b	d0
	beq.s	.Exit
	move.w	#$ff00,d1
	and.w	d0,d1
	cmpi.w	#$0300,d1
	bmi.s	.Body
	addi.b	#9,d0
.Body:
	movea.l	Current_inventory_chardat_ptr,a0
	lea.l	Neck_place_counter-1(a0),a3
	ext.w	d0
	tst.b	0(a3,d0.w)
	beq.s	.Exit
	lea.l	Inv_data-40(a0),a0
	mulu.w	#40,d0
	adda.w	d0,a0
; CHANGE: removed "cmpi.b #17,Item_type(a0)"
; CHANGE: removed "beq.s .Exit"
	move.w	Name_word_nr(a0),d0
	cmp.w	Object_name_nr,d0
	beq.s	.Exit
	move.w	d0,Object_name_nr
	move.b	#2,Print_objname_flag
.Exit:
	rts	
; ---- Erase_object_name (original source: MAIN/INVENT.ASM)
Erase_object_name:
	tst.b	d0
	beq.s	.Skip
	move.l	#$00ffff00,d1
	and.l	d0,d1
	cmpi.l	#$00020200,d1
	beq.s	.Exit
	cmpi.l	#$00020300,d1
	beq.s	.Exit
.Skip:
	move.b	#2,Erase_objname_flag
.Exit:
	rts	
T_11812:
	tst.b	Print_objname_flag
	beq.b	.l_11866
	lea.l	.l_11868(pc),a0
	jsr	IG_Print
	move.w	Object_name_nr,d0
	beq.b	.l_11866
	bsr.w	Get_word
	move.w	#$10,d0
	move.w	#$3a,d1
	move.w	#$bf,d2
	move.w	#$40,d3
	move.w	#$2,d6
	movea.l	Off_screen,a6
	jsr	Draw_box
	move.w	#$b0,d2
	lea.l	Line_buffer,a0
	jsr	Print_centered_string
	subq.b	#$1,Print_objname_flag
.l_11866:
	rts
.l_11868:
	dc.b	$01,$0f,$02,$ff,$00,$00
T_1186e:
	tst.b	Erase_objname_flag
	beq.b	.l_118a2
	move.w	#$10,d0
	move.w	#$3a,d1
	move.w	#$bf,d2
	move.w	#$40,d3
	move.w	#$2,d6
	movea.l	Off_screen,a6
	jsr	Draw_box
	subq.b	#$1,Erase_objname_flag
	clr.w	Object_name_nr
.l_118a2:
	rts
T_118a4:
	btst	#$1,Mouse_button_state
	bne.b	T_118a4
	lea.l	DropItem_Mod,a0
	bsr.w	Push_Module
	rts
; ---- TransferItem_DisInit (original source: MAIN/INVENT.ASM)
DropItem_DisInit:
TransferItem_DisInit:
	lea.l	Backpack_area,a0
	jsr	Push_MA
	movea.l	Off_screen,a6
	move.w	#$0,d0	; CHANGE: was "MesMin 4"
	jsr	Minus_message
	jsr	Switch_screen
	jsr	Copy_screen
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	rts	
; ---- Transparent_DisExit (original source: MAIN/INVENT.ASM)
Transparent_DisExit:
	movea.l	Off_screen,a6
	jsr	Erase_message_minus
	jsr	Switch_screen
	jsr	Copy_screen
	jsr	Pop_MA
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	rts	
; ---- Exit_DropItem (original source: MAIN/INVENT.ASM)
Exit_DropItem:
	bsr.w	Pop_Module
	rts	
; ---- Do_DropItem (original source: MAIN/INVENT.ASM)
Do_DropItem:
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	tst.b	d0
	beq.s	Exit_DropItem
	ext.w	d0
	addi.w	#9,d0
	move.b	d0,Object_slot_number
	movea.l	Current_inventory_chardat_ptr,a0
	lea.l	Neck_place_counter-1(a0),a1
	adda.w	d0,a1
	tst.b	(a1)
	beq.s	Exit_DropItem
	lea.l	Inv_data-40(a0),a2
	mulu.w	#40,d0
	adda.w	d0,a2
	btst	#1,Item_stat_bits(a2)
	bne.s	.Droppable
	move.w	#1,d0
	jsr	Plus_message
	bsr.w	Pop_Module
	bra.s	.Exit
.Droppable:
	btst	#2,Item_stat_bits(a2)
	beq.s	.Single
	cmpi.b	#1,(a1)
	bhi.s	.Multiple
.Single:
	move.l	#Code0001Sys,Textfile_ptr
	move.w	#22,ReqText_nr
	move.l	#Do_Drop1Item,ReqDo_ptr
	lea.l	Req_Mod,a0
	bsr.w	Push_Module
	bra.s	.Exit
.Multiple:
	moveq.l	#0,d0
	move.b	(a1),d0
	move.l	d0,Original_number
	clr.l	ItemW_nr
	lea.l	DropMItem_Mod,a0
	bsr.w	Push_Module
.Exit:
	rts	
; ---- Do_Drop1Item (original source: MAIN/INVENT.ASM)
Do_Drop1Item:
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	movea.l	Current_inventory_chardat_ptr,a0
	lea.l	Neck_place_counter-1(a0),a1
	lea.l	Inv_data-40(a0),a2
	move.b	Object_slot_number,d0
	ext.w	d0
	adda.w	d0,a1
	mulu.w	#40,d0
	adda.w	d0,a2
	clr.b	(a1)
	moveq.l	#0,d0
	move.w	Weight(a2),d0
	sub.l	d0,Weight_normal(a0)
	movea.l	Off_screen,a6
	move.b	Object_slot_number,d0
	bsr.w	INV2_Erase_object
	move.w	#16,d0
	move.w	#58,d1
	move.w	#16+176-1,d2
	move.w	#58+7-1,d3
	move.w	#2,d6
	jsr	Draw_box
	jsr	Switch_screen
	jsr	Copy_screen
	bra.w	Pop_Module
; ---- TransMItem_DisInit (original source: MAIN/INVENT.ASM)
DropMItem_DisInit:
TransMItem_DisInit:
	movem.l	d0-d7/a0-a6,-(sp)
	move.w	#First_add,Adding
	moveq.l	#15,d0
	jsr	IG_Set_ink
	moveq.l	#2,d0
	jsr	IG_Set_paper
	bsr.w	ItemW_DisInit
	move.b	Object_slot_number,d0
	ext.w	d0
	movea.l	Current_inventory_chardat_ptr,a1
	lea.l	Neck_place_counter-1(a1),a2
	lea.l	Inv_data-40(a1),a3
	adda.w	d0,a2
	moveq.l	#40,d1
	mulu.w	d0,d1
	adda.w	d1,a3
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
	moveq	#15,d0	; CHANGE: was "moveq.l #14,d0"
	lea.l	Code0001Sys,a1
	jsr	Convert_text_line
	lea.l	Line_buffer,a0
	jsr	IG_Print
	jsr	Switch_screen
	jsr	Copy_screen
	movem.l	(sp)+,d0-d7/a0-a6
	rts	
; ---- DropMItem_Return (original source: MAIN/INVENT.ASM)
DropMItem_Return:
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	move.l	#Code0001Sys,Textfile_ptr
	move.w	#22,ReqText_nr
	move.l	#Do_DropMItem,ReqDo_ptr
	lea.l	Req_Mod,a0
	bra.w	Push_Module
Do_DropMItem:
	btst	#$1,Mouse_button_state
	bne.b	Do_DropMItem
	movea.l	Current_inventory_chardat_ptr,a0
	lea.l	$21(a0),a1
	lea.l	$10a(a0),a2
	move.b	Object_slot_number,d0
	ext.w	d0
	adda.w	d0,a1
	mulu.w	#$28,d0
	adda.w	d0,a2
	movea.l	Off_screen,a6
	moveq	#0,d1
	move.b	(a1),d1
	move.l	ItemW_nr,d2
	sub.w	d2,d1
	move.b	d1,(a1)
	bne.b	.l_11b72
	move.b	Object_slot_number,d0
	bsr.w	INV2_Erase_object
	move.w	#$10,d0
	move.w	#$3a,d1
	move.w	#$bf,d2
	move.w	#$40,d3
	move.w	#$2,d6
	jsr	Draw_box
	jsr	Switch_screen
	jsr	Copy_screen
	bra.b	.l_11baa
.l_11b72:
	dc.b	$0c,$11,$00,$01,$66,$32,$10,$12,$12,$39
	dc.l	Object_slot_number
	dc.b	$61,$00,$f5,$b4,$30,$3c,$00,$10,$32,$3c,$00,$3a,$34,$3c,$00,$bf
	dc.b	$36,$3c,$00,$40,$3c,$3c,$00,$02,$4e,$b9
	dc.l	Draw_box
	dc.b	$4e,$b9
	dc.l	Switch_screen
	dc.b	$4e,$b9
	dc.l	Copy_screen
.l_11baa:
	move.l	ItemW_nr,d0
	mulu.w	$22(a2),d0
	sub.l	d0,Weight_normal(a0)
	bra.w	Pop_Module
; ---- ItemW_DisUpd (original source: MAIN/INVENT.ASM)
ItemW_DisUpd:
	movem.l	d0-d7/a0-a6,-(sp)
	movea.l	Off_screen,a6
	moveq	#15,d0	; CHANGE: added
	jsr	IG_Set_ink	; CHANGE: added
	moveq	#2,d0	; CHANGE: added
	jsr	IG_Set_paper	; CHANGE: added
	move.w	#89,d0
	move.w	#141,d1
	move.w	#89+30,d2
	move.w	#141+7,d3
	moveq.l	#2,d6
	jsr	Draw_box
	jsr	IG_Set_cursor
	move.l	ItemW_nr,d0
	moveq	#32,d1	; CHANGE: was "moveq.l #" ",d1"
	moveq.l	#5,d7
	lea.l	Line_buffer,a0
	lea.l	(a0),a3
	bsr.w	RConvert_number
	clr.b	(a3)
	jsr	IG_Print
	movem.l	(sp)+,d0-d7/a0-a6
	rts	
; ---- ItemW_DisInit (original source: MAIN/INVENT.ASM)
ItemW_DisInit:
	movem.l	d0-d3/d6/d7/a0/a6,-(sp)
	moveq.l	#32,d0
	moveq.l	#80+32,d1
	moveq.l	#10,d2
	moveq.l	#6,d3
	moveq.l	#1,d6
	lea.l	ItemW_L1,a0
	jsr	Open_window
	move.w	d0,B_58256	; CHANGE: was "move.w d0,Window_handle"
	movea.l	Off_screen,a6
	moveq.l	#2,d6
	moveq.l	#16,d7
	move.w	#48,d0
	move.w	#128+32,d1
	lea.l	Control_icn+256,a0
	jsr	Blot_unmasked_block
	move.w	#48,d0
	move.w	#96+48+32,d1
	lea.l	Control_icn+512,a0
	jsr	Blot_unmasked_block
	move.w	#128,d0
	move.w	#144+32,d1
	lea.l	Control_icn+7680,a0
	jsr	Blot_unmasked_block
	bsr.w	ItemW_DisUpd
	movem.l	(sp)+,d0-d3/d6/d7/a0/a6
	rts	
; ---- ItemW_DisExit (original source: MAIN/INVENT.ASM)
ItemW_DisExit:
	move.w	B_58256,d0	; CHANGE: was "move.w Window_handle,d0"
	jsr	Close_window
	jsr	Copy_screen
	movea.l	Off_screen,a6
	jsr	Erase_message_minus
	jsr	Switch_screen
	jsr	Copy_screen
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	rts	
; ---- Clear_adding (original source: MAIN/INVENT.ASM)
Clear_adding:
	move.w	#First_add,Adding
	rts	
; ---- Inc_adding (original source: MAIN/INVENT.ASM)
Inc_adding:
	move.w	Adding,d1
	addq.w	#8,d1
	bmi.s	.Exit
	move.w	d1,Adding
.Exit:
	rts	
; ---- ItemW_1Up (original source: MAIN/INVENT.ASM)
ItemW_1Up:
	move.l	ItemW_nr,d0
	cmp.l	Original_number,d0
	bpl.s	.Exit
	addq.l	#1,d0
	move.l	d0,ItemW_nr
.Exit:
	rts	
; ---- ItemW_1Down (original source: MAIN/INVENT.ASM)
ItemW_1Down:
	move.l	ItemW_nr,d0
	tst.l	d0
	beq.s	.Exit
	subq.l	#1,d0
	move.l	d0,ItemW_nr
.Exit:
	rts	
; ---- ItemW_Up (original source: MAIN/INVENT.ASM)
ItemW_Up:
	move.l	ItemW_nr,d0
	cmp.l	Original_number,d0
	bpl.s	.Exit
	moveq.l	#0,d1
	move.b	Adding,d1
	add.l	d1,d0
	cmp.l	Original_number,d0
	bmi.s	.Skip
	move.w	#First_add,Adding
	move.l	Original_number,d0
.Skip:
	bsr.w	Inc_adding
	move.l	d0,ItemW_nr
.Exit:
	rts	
; ---- ItemW_Down (original source: MAIN/INVENT.ASM)
ItemW_Down:
	move.l	ItemW_nr,d0
	tst.l	d0
	beq.s	.Exit
	moveq.l	#0,d1
	move.b	Adding,d1
	sub.l	d1,d0
	bpl.s	.Skip
	move.w	#First_add,Adding
	moveq.l	#0,d0
.Skip:
	bsr.w	Inc_adding
	move.l	d0,ItemW_nr
.Exit:
	rts	
T_11d6c:
	btst	#$1,Mouse_button_state
	bne.b	T_11d6c
	lea.l	UseItem_Mod,a0
	bsr.w	Push_Module
	rts
; ---- UseItem_DisInit (original source: MAIN/INVENT.ASM)
UseItem_DisInit:
	lea.l	D_2dd3e,a0	; CHANGE: was "Push MA,UseItem_area"
	jsr	Push_MA
	moveq.l	#2,d0
	movea.l	Off_screen,a6
	move.w	#2,d0
	jsr	Minus_message
	jsr	Switch_screen
	jsr	Copy_screen
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	rts	
; ---- Use_backpack_item (original source: MAIN/INVENT.ASM)
Use_backpack_item:
	tst.b	d0
	beq.s	.Exit
	ext.w	d0
	addi.w	#9,d0
	bra.s	UseItem_entry
.Exit:
	bra.w	Pop_Module
; ---- Use_body_item (original source: MAIN/INVENT.ASM)
Use_body_item:
	tst.b	d0
	beq.s	.Exit
	ext.w	d0
	bra.s	UseItem_entry
.Exit:
	bra.w	Pop_Module
UseItem_entry:
	btst	#$1,Mouse_button_state
	bne.b	UseItem_entry
	move.b	d0,Object_slot_number
	movea.l	Current_inventory_chardat_ptr,a0
	lea.l	$21(a0),a1
	adda.w	d0,a1
	tst.b	(a1)
	beq.w	T_11ffc
	lea.l	$10a(a0),a2
	mulu.w	#$28,d0
	adda.w	d0,a2
	move.w	Map_Xcoord,d0
	move.w	Map_Ycoord,d1
	jsr	Find_event
	beq.b	.l_11e5c
	cmpi.b	#$13,(a5)
	bne.b	.l_11e5c
	move.w	$6(a5),d0
	cmp.w	$24(a2),d0
	bne.b	.l_11e5c
	jsr	T_09aac
	btst	#$3,$18(a2)
	beq.b	.l_11e52
	subq.b	#$1,(a1)
	moveq	#0,d0
	move.w	$22(a2),d0
	sub.l	d0,Weight_normal(a0)
	move.b	Object_slot_number,d0
	cmpi.b	#$a,d0
	bpl.b	.l_11e4e
	bsr.w	Remove_boni
.l_11e4e:
	bsr.w	Destroy_used_item
.l_11e52:
	bsr.w	Pop_Module
	bsr.w	T_10f3a
	rts
.l_11e5c:
	tst.b	$e(a2)
	beq.w	T_11f0e
	move.b	Character_class(a0),d1
	move.w	$1e(a2),d2
	btst	d1,d2
	bne.b	.l_11e7e
	move.w	#$9,d0
	jsr	Plus_message
	bra.w	T_11ffc
.l_11e7e:
	lea.l	D_484a4,a3
	move.b	$c(a2),d0
	ext.w	d0
	mulu.w	#$78,d0
	adda.w	d0,a3
	move.b	$d(a2),d0
	ext.w	d0
	add.w	d0,d0
	add.w	d0,d0
	adda.w	d0,a3
	move.b	(a3),d0
	move.w	Spell_area_type,d1
	btst	d1,d0
	bne.b	Use_item_in_combat
	movea.l	Textfile_ptr,a1
	move.w	#$0,WText_nr
	move.l	#Code0007Sys,Textfile_ptr
	lea.l	TxtW_Mod,a0
	bsr.w	Push_Module
	move.l	a1,Textfile_ptr
	rts
; The spell of an item must work in battles. The inventory is closed and the spell becomes the action of the owner.
Use_item_in_combat:
	tst.b	Battling
	beq.b	.l_11ee2
	bsr.w	Pop_Module
	bsr.w	T_10f3a
.l_11ee2:
	moveq	#0,d0
	move.b	$c(a2),d0
	move.w	d0,Selected_class
	move.b	$d(a2),d0
	move.w	d0,Selected_spell
	st.b	Magic_object_flag
	bsr.w	Do_magic
	move.l	#Code0001Sys,Textfile_ptr
	rts
T_11f0e:
	cmpi.b	#$d,$1(a2)
	bne.b	.l_11f5a
	move.w	Special_item_flags,d0
	move.b	$15(a2),d1
	subq.b	#$1,d1
	btst	d1,d0
	beq.b	.l_11f34
	move.w	#$17,d0
	jsr	Plus_message
	bra.w	Pop_Module
.l_11f34:
	bset	d1,d0
	move.w	d0,Special_item_flags
	clr.b	(a1)
	moveq	#0,d0
	move.w	$22(a2),d0
	sub.l	d0,Weight_normal(a0)
	bsr.w	Destroy_used_item
	move.w	#$12,d0
	jsr	Plus_message
	bra.w	Pop_Module
.l_11f5a:
	cmpi.b	#$7,$1(a2)
	bne.b	.l_11fbe
	lea.l	D_2f25c,a0
	moveq	#0,d0
	move.b	$15(a2),d0
	jsr	Load_subfile
	move.l	a0,Codetxt_ptr
	move.b	$1d(a2),d0
	move.w	d0,WText_nr
	move.l	a0,Textfile_ptr
	lea.l	TxtW_Mod,a0
	move.l	#.l_11f9e,$28(a0)
	bsr.w	Push_Module
	rts
.l_11f9e:
	clr.l	D_2746e
	move.l	#Code0001Sys,Textfile_ptr
	movea.l	Codetxt_ptr,a0
	jsr	Free_memory
	bra.w	Pop_Module
.l_11fbe:
	cmpi.b	#$12,$1(a2)
	bne.b	T_11ffc
	tst.w	Travel_mode
	bne.b	T_11ffc
	cmpi.b	#$1,Current_map_type
	beq.b	.l_11fe4
	move.w	#$10,d0
	jsr	Plus_message
	bra.b	T_11ffc
.l_11fe4:
	moveq	#4,d0
	jsr	Set_new_travel_mode
	bsr.w	Pop_Module
	bsr.w	Pop_Module
	bsr.w	Pop_Module
	bra.w	Init_display
T_11ffc:
	bra.w	Pop_Module
; ---- Destroy_used_item (original source: MAIN/INVENT.ASM)
Destroy_used_item:
	movem.l	d0-d3/a3,-(sp)
	lea.l	Object_pos_list-4,a3
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
	lea.l	Erase_icon,a3
	move.b	-1(a3,d3.w),d3
	ext.w	d3
	bsr.w	Show_item_destruction
	movem.l	(sp)+,d0-d3/a3
	rts	
; Removes a charge of a magic item or the item itself.
Remove_used_magic_item:
	movem.l	d0-d1/a0-a2/a5-a6,-(a7)
	movea.l	B_5880e,a0
	lea.l	$21(a0),a1
	lea.l	$10a(a0),a2
	move.w	B_5880c,d0
	adda.w	d0,a1
	mulu.w	#$28,d0
	adda.w	d0,a2
	btst	#$2,$18(a2)
	bne.b	.l_12078
	cmpi.b	#$ff,$e(a2)
	beq.w	.l_12122
	subq.b	#$1,$e(a2)
	bne.b	.l_120ec
.l_12078:
	moveq	#0,d0
	move.w	$22(a2),d0
	sub.l	d0,$ec(a0)
	subq.b	#$1,(a1)
	cmpi.w	#$a,B_5880c
	bpl.b	.l_120ec
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
	btst	#$0,$18(a2)
	bne.b	.l_120e8
	bsr.w	Negative_boni
	bra.b	.l_120ec
.l_120e8:
	bsr.w	Positive_boni
.l_120ec:
	tst.b	Battling
	bne.b	.l_12122
	move.w	B_5880c,d0
	moveq	#0,d2
	move.b	(a2),d2
	bsr.w	Show_item_sparkle
	tst.b	(a1)
	bne.b	.l_12122
	move.w	B_5880c,d0
	movea.l	Off_screen,a6
	bsr.w	INV2_Erase_object
	jsr	Switch_screen
	jsr	Copy_screen
.l_12122:
	movem.l	(a7)+,d0-d1/a0-a2/a5-a6
	rts
; The item sparkles in its slot (8 frames of 3 vertical blanks).
Show_item_sparkle:
	movem.l	d0-d2/d7/a0-a4/a6,-(a7)
	lea.l	D_2dc66,a1
	add.w	d0,d0
	add.w	d0,d0
	move.w	$2(a1,d0.w),d1
	move.w	(a1,d0.w),d0
	lea.l	Objects_icn,a1
	ext.w	d2
	lsl.w	#$7,d2
	adda.w	d2,a1
	lea.l	D_46e08,a3
	lea.l	D_363e0,a4
	moveq	#7,d7
.l_12158:
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
	dbra	d7,.l_12158
	movea.l	Off_screen,a6
	movea.l	a4,a0
	jsr	Put_unmasked_block
	movea.l	a1,a0
	jsr	Put_masked_block
	jsr	Switch_screen
	jsr	Copy_screen
	movem.l	(a7)+,d0-d2/d7/a0-a4/a6
	rts
T_121be:
	btst	#$1,Mouse_button_state
	bne.b	T_121be
	move.w	#$0,Draw_Cicon
	jsr	My_vsync
; ---- Pool_gold_INV2 (original source: MAIN/INVENT.ASM)
Pool_gold_INV2:
	movea.l	Current_inventory_chardat_ptr,a0
	move.w	Gold_coins(a0),d0
	move.l	Weight_normal(a0),d1
	move.w	Attr_1_normal(a0),d2
	add.w	Attr_1_normal_magic(a0),d2
	mulu.w	#1000,d2
	bsr.w	Pool_gold
	add.w	d0,Gold_coins(a0)
	mulu.w	#Gold_weight,d0
	add.l	d0,Weight_normal(a0)
	rts	
; ---- View_item (original source: MAIN/INVENT.ASM)
View_item:
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	lea.l	ViewItem_Mod,a0
	bra.w	Push_Module
; ---- ViewItem_DisInit (original source: MAIN/INVENT.ASM)
ViewItem_DisInit:
	move.w	#16,Mesmin_X
	move.w	#49+1,Mesmin_Y
	move.w	#176,Mesmin_Wd
	move.l	#Code0001Sys,Textfile_ptr
	lea.l	D_2dd3e,a0	; CHANGE: was "Push MA,UseItem_area"
	jsr	Push_MA
	moveq.l	#3,d0
	movea.l	Off_screen,a6
	move.w	#3,d0
	jsr	Minus_message
	jsr	Switch_screen
	jsr	Copy_screen
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	rts	
; ---- Exit_view_item (original source: MAIN/INVENT.ASM)
Exit_view_item:
	bra.w	Pop_Module
; ---- Do_view_backpack_item (original source: MAIN/INVENT.ASM)
Do_view_backpack_item:
	tst.b	d0
	beq.s	Exit_view_item
	ext.w	d0
	addi.w	#9,d0
	bra.s	View_item_entry
; ---- Do_view_body_item (original source: MAIN/INVENT.ASM)
Do_view_body_item:
	tst.b	d0
	beq.s	Exit_view_item
	ext.w	d0
; ---- View_item_entry (original source: MAIN/INVENT.ASM)
View_item_entry:
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	movea.l	Current_inventory_chardat_ptr,a0
	lea.l	Neck_place_counter-1(a0),a0
	adda.w	d0,a0
	tst.b	(a0)
	beq.s	Exit_view_item
	move.b	d0,Object_slot_number
	lea.l	ItemView1_Mod,a0
	bsr.w	Push_Module
	rts	
; ---- ItemViewW1_DisInit (original source: MAIN/INVENT.ASM)
; CHANGE: removed "moveq.l #15,d0"
; CHANGE: removed "jsr IG_Set_ink"
; CHANGE: removed "moveq.l #2,d0"
; CHANGE: removed "jsr IG_Set_paper"
ItemViewW1_DisInit:
	moveq.l	#16,d0
	moveq.l	#112,d1
	moveq.l	#18,d2
	moveq.l	#6,d3
	moveq.l	#2,d4
	moveq.l	#1,d6
	lea.l	ItemView1_L1,a0
	jsr	Open_window
	move.w	d0,B_58256	; CHANGE: was "move.w d0,Window_handle"
	movea.l	Itemdata_ptr,a1
	move.b	Object_slot_number,d0
	ext.w	d0
	subq.w	#1,d0
	mulu.w	#40,d0
	adda.w	d0,a1
	movea.l	Off_screen,a6
	btst	#0,Item_stat_bits(a1)
	sne	Cursed
	move.w	#32,d0
	move.w	#128,d1
	lea.l	Layout_icn+9856,a0
	jsr	Put_unmasked_block
	lea.l	Objects_icn,a0
	move.b	(a1),d2
	ext.w	d2
	lsl.w	#7,d2
	adda.w	d2,a0
	jsr	Put_masked_block	; CHANGE: added
	moveq	#15,d0	; CHANGE: added
	jsr	IG_Set_ink	; CHANGE: added
	moveq	#2,d0	; CHANGE: added
	jsr	IG_Set_paper	; CHANGE: was "jsr Put_masked_block"
	move.w	#32+19,d0
	move.w	#129,d1
	jsr	IG_Set_cursor
	move.w	Name_word_nr(a1),d0
	bsr.w	Get_word
	lea.l	Line_buffer,a0
	jsr	IG_Print
	move.w	#32+19,d0
	move.w	#129+8,d1
	jsr	IG_Set_cursor
	lea.l	Misc_dat+Item_type_names,a0
	moveq.l	#0,d0
	move.b	Item_type(a1),d0
	add.w	d0,d0
	move.w	0(a0,d0.w),d0
	bsr.w	Get_word
	lea.l	Line_buffer,a0
	jsr	IG_Print
	move.w	#32+145,d0
	move.w	#129,d1
	jsr	IG_Set_cursor
	lea.l	Classes_txt,a0
	jsr	IG_Print
	lea.l	Class_dat+Class_names,a2
	lea.l	Classname_pos_list,a4
	moveq.l	#1,d2
	move.w	Class_use(a1),d3
	moveq.l	#8-1,d7
.Loop:
	btst	d2,d3
	beq.s	.Next
	move.w	(a4)+,d0
	move.w	(a4)+,d1
	jsr	IG_Set_cursor
	move.w	d2,d0
	add.w	d0,d0
	move.w	0(a2,d0.w),d0
	bsr.w	Get_word
	lea.l	Line_buffer,a0
	jsr	IG_Print
.Next:
	addq.w	#1,d2
	dbra	d7,.Loop
	move.w	#32+145,d0
	move.w	#129+38,d1
	jsr	IG_Set_cursor
	lea.l	Sex_use_txt,a0
	jsr	IG_Print
	lea.l	Sex_use_strings,a0
	moveq.l	#0,d0
	move.b	Sex_use(a1),d0
	lsl.w	#2,d0
	movea.l	0(a0,d0.w),a0
	jsr	IG_Print
	lea.l	Control_icn+2816,a0
	move.w	#32+224,d0
	move.w	#128+48,d1
	moveq.l	#2,d6
	moveq.l	#16,d7
	jsr	Blot_unmasked_block
	btst	#7,Item_stat_bits(a1)
	sne	Xtra_window
	bne.s	.Yes
	cmpi.w	#6,Travel_mode
	seq	Xtra_window
	beq.s	.Yes
	lea.l	Chequered,a0
	jsr	Blot_masked_block
.Yes:
	move.w	#32,d0
	move.w	#128+19,d1
	jsr	IG_Set_cursor
	lea.l	Weight2_txt,a0
	jsr	IG_Print
	lea.l	Line_buffer,a0
	moveq.l	#0,d0
	move.w	Weight(a1),d0
	moveq.l	#5,d7
	movea.l	a0,a3
	bsr.w	LConvert_number
	jsr	IG_Print
	lea.l	Gram_txt,a0
	jsr	IG_Print
	move.w	#32,d0
	move.w	#128+30,d1
	jsr	IG_Set_cursor
	lea.l	Hands_txt,a0
	jsr	IG_Print
	lea.l	Line_buffer,a0
	moveq.l	#0,d0
	move.b	Hand_use(a1),d0
	moveq.l	#1,d7
	movea.l	a0,a3
	bsr.w	LConvert_number
	jsr	IG_Print
	move.w	#32,d0
	move.w	#128+38,d1
	jsr	IG_Set_cursor
	lea.l	Fingers_txt,a0
	jsr	IG_Print
	lea.l	Line_buffer,a0
	moveq.l	#0,d0
	move.b	Ring_use(a1),d0
	movea.l	a0,a3
	bsr.w	LConvert_number
	jsr	IG_Print
	move.w	#32,d0
	move.w	#128+46,d1
	jsr	IG_Set_cursor
	lea.l	Damage_txt,a0
	jsr	IG_Print
	lea.l	Line_buffer,a0
	moveq.l	#0,d0
	move.b	Damage_pts(a1),d0
	tst.b	Cursed
	beq.s	.NoC1
	neg.w	d0
.NoC1:
	moveq.l	#3,d7
	movea.l	a0,a3
	bsr.w	LConvert_number
	jsr	IG_Print
	move.w	#32,d0
	move.w	#128+54,d1
	jsr	IG_Set_cursor
	lea.l	Protection_txt,a0
	jsr	IG_Print
	lea.l	Line_buffer,a0
	moveq.l	#0,d0
	move.b	Protection_pts(a1),d0
	tst.b	Cursed
	beq.s	.NoC2
	neg.w	d0
.NoC2:
	moveq.l	#3,d7
	movea.l	a0,a3
	bsr.w	LConvert_number
	jsr	IG_Print
	jsr	Switch_screen
	jsr	Copy_screen
	rts	
; ---- Open_ExtraW (original source: MAIN/INVENT.ASM)
Open_ExtraW:
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	tst.b	Xtra_window
	beq.s	.Exit
	lea.l	ItemView2_Mod,a0
	bsr.w	Push_Module
.Exit:
	rts	
ItemViewW2_DisInit:
	moveq	#15,d0
	jsr	IG_Set_ink
	moveq	#2,d0
	jsr	IG_Set_paper
	moveq	#32,d0
	moveq	#48,d1
	moveq	#12,d2
	moveq	#6,d3
	moveq	#2,d4
	moveq	#1,d6
	suba.l	a0,a0
	jsr	Open_window
	move.w	d0,View2_handle
	movea.l	Itemdata_ptr,a1
	move.b	Object_slot_number,d0
	ext.w	d0
	subq.w	#$1,d0
	mulu.w	#$28,d0
	adda.w	d0,a1
	movea.l	Off_screen,a6
	move.w	#$30,d0
	move.w	#$40,d1
	jsr	IG_Set_cursor
	lea.l	LPMax_txt,a0
	jsr	IG_Print
	lea.l	Line_buffer,a0
	moveq	#0,d0
	move.b	$6(a1),d0
	tst.b	Cursed
	beq.b	.l_12612
	neg.w	d0
.l_12612:
	moveq	#2,d7
	movea.l	a0,a3
	bsr.w	LConvert_number
	jsr	IG_Print
	move.w	#$80,d0
	move.w	#$40,d1
	jsr	IG_Set_cursor
	lea.l	PPMax_txt,a0
	jsr	IG_Print
	lea.l	Line_buffer,a0
	moveq	#0,d0
	move.b	$7(a1),d0
	tst.b	Cursed
	beq.b	.l_12650
	neg.w	d0
.l_12650:
	moveq	#2,d7
	movea.l	a0,a3
	bsr.w	LConvert_number
	jsr	IG_Print
	move.w	#$30,d0
	move.w	#$47,d1
	jsr	IG_Set_cursor
	lea.l	MBW_txt,a0
	jsr	IG_Print
	lea.l	Line_buffer,a0
	moveq	#0,d0
	move.b	$13(a1),d0
	moveq	#2,d7
	movea.l	a0,a3
	bsr.w	LConvert_number
	jsr	IG_Print
	move.w	#$80,d0
	move.w	#$47,d1
	jsr	IG_Set_cursor
	lea.l	MBA_txt,a0
	jsr	IG_Print
	lea.l	Line_buffer,a0
	moveq	#0,d0
	move.b	$14(a1),d0
	moveq	#2,d7
	movea.l	a0,a3
	bsr.w	LConvert_number
	jsr	IG_Print
	move.w	#$30,d0
	move.w	#$4e,d1
	jsr	IG_Set_cursor
	lea.l	Attr2_txt,a0
	jsr	IG_Print
	tst.b	$8(a1)
	beq.b	.l_12746
	move.w	#$30,d0
	move.w	#$55,d1
	jsr	IG_Set_cursor
	lea.l	D_47370,a2
	moveq	#0,d0
	move.b	$8(a1),d0
	add.w	d0,d0
	move.w	-$2(a2,d0.w),d0
	bsr.w	Get_word
	lea.l	Line_buffer,a0
	jsr	IG_Print
	lea.l	Tween_txt,a0
	jsr	IG_Print
	lea.l	Line_buffer,a0
	moveq	#0,d0
	move.b	$9(a1),d0
	tst.b	Cursed
	beq.b	.l_12738
	neg.w	d0
.l_12738:
	moveq	#2,d7
	movea.l	a0,a3
	bsr.w	LConvert_number
	jsr	IG_Print
.l_12746:
	move.w	#$30,d0
	move.w	#$5c,d1
	jsr	IG_Set_cursor
	lea.l	Skill2_txt,a0
	jsr	IG_Print
	tst.b	$a(a1)
	beq.b	.l_127c6
	move.w	#$30,d0
	move.w	#$63,d1
	jsr	IG_Set_cursor
	lea.l	D_48488,a2
	moveq	#0,d0
	move.b	$a(a1),d0
	add.w	d0,d0
	move.w	-$2(a2,d0.w),d0
	bsr.w	Get_word
	lea.l	Line_buffer,a0
	jsr	IG_Print
	lea.l	Tween_txt,a0
	jsr	IG_Print
	lea.l	Line_buffer,a0
	moveq	#0,d0
	move.b	$b(a1),d0
	tst.b	Cursed
	beq.b	.l_127b8
	neg.w	d0
.l_127b8:
	moveq	#2,d7
	movea.l	a0,a3
	bsr.w	LConvert_number
	jsr	IG_Print
.l_127c6:
	tst.b	$e(a1)
	bne.b	.l_127ea
	move.w	#$30,d0
	move.w	#$6a,d1
	jsr	IG_Set_cursor
	lea.l	Magic_txt,a0
	jsr	IG_Print
	bra.w	.l_128ac
.l_127ea:
	move.w	#$30,d0
	move.w	#$6a,d1
	jsr	IG_Set_cursor
	moveq	#1,d0
	jsr	IG_Set_ink
	lea.l	D_48868,a2
	moveq	#0,d0
	move.b	$c(a1),d0
	add.w	d0,d0
	move.w	-$2(a2,d0.w),d0
	bsr.w	Get_word
	lea.l	Line_buffer,a0
	jsr	IG_Print
	moveq	#15,d0
	jsr	IG_Set_ink
	move.w	#$30,d0
	move.w	#$71,d1
	jsr	IG_Set_cursor
	lea.l	D_48876,a2
	move.b	$c(a1),d0
	subq.w	#$1,d0
	mulu.w	#$3c,d0
	adda.w	d0,a2
	moveq	#0,d0
	move.b	$d(a1),d0
	add.w	d0,d0
	move.w	-$2(a2,d0.w),d0
	bsr.w	Get_word
	lea.l	Line_buffer,a0
	jsr	IG_Print
	lea.l	Tween2_txt,a0
	jsr	IG_Print
	lea.l	Line_buffer,a0
	moveq	#0,d0
	move.b	$e(a1),d0
	cmpi.b	#$ff,d0
	bne.b	.l_12892
	lea.l	Infinite_charges_txt,a0
	jsr	IG_Print
	bra.b	.l_128a0
.l_12892:
	moveq	#3,d7
	movea.l	a0,a3
	bsr.w	LConvert_number
	jsr	IG_Print
.l_128a0:
	lea.l	Tween3_txt,a0
	jsr	IG_Print
.l_128ac:
	jsr	Switch_screen
	jsr	Copy_screen
	rts
; ---- ItemViewW2_DisExit (original source: MAIN/INVENT.ASM)
ItemViewW2_DisExit:
	move.l	d0,-(sp)
	move.w	View2_handle,d0
	jsr	Close_window
	move.l	(sp)+,d0
	rts	
Accursed_blink:
	tst.b	Cursed
	beq.b	.l_12924
	lea.l	D_2db92,a0
	subq.w	#$1,Curse_count
	bne.b	.l_1290c
	move.w	#$4,Curse_count
	lea.l	D_2da84,a1
	move.w	Curse_index,d0
	addq.w	#$1,d0
	move.b	(a1,d0.w),d1
	bpl.b	.l_12902
	moveq	#0,d0
	move.b	(a1),d1
.l_12902:
	move.w	d0,Curse_index
	move.b	d1,$1(a0)
.l_1290c:
	movea.l	Off_screen,a6
	move.w	#$30,d0
	move.w	#$79,d1
	move.w	#$a0,d2
	jsr	Print_centered_string
.l_12924:
	rts
T_12926:
	bsr.w	Pop_Module
	bra.w	Pop_Module
T_1292e:
	move.l	d0,-(a7)
	move.w	B_58256,d0
	jsr	Close_window
	move.l	(a7)+,d0
	rts
T_12940:
	btst	#$1,Mouse_button_state
	bne.b	T_12940
	lea.l	TransferItem_Mod,a0
	bra.w	Push_Module
T_12954:
	lea.l	Backpack_area,a0
	jsr	Push_MA
	movea.l	Off_screen,a6
	move.w	#$4,d0
	jsr	Minus_message
	jsr	Switch_screen
	jsr	Copy_screen
.l_1297c:
	btst	#$1,Mouse_button_state
	bne.b	.l_1297c
	rts
; ---- Exit_TransferItem (original source: MAIN/INVENT.ASM)
Exit_TransferItem:
	bsr.w	Pop_Module
	rts	
; ---- Do_TransferItem (original source: MAIN/INVENT.ASM)
Do_TransferItem:
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	tst.b	d0
	beq.s	Exit_TransferItem
	ext.w	d0
	addi.w	#9,d0
	movea.l	Current_inventory_chardat_ptr,a0
	lea.l	Neck_place_counter-1(a0),a1
	adda.w	d0,a1
	tst.b	(a1)
	beq.s	Exit_TransferItem
	lea.l	Inv_data-40(a0),a2
	moveq.l	#40,d1
	mulu.w	d0,d1
	adda.w	d1,a2
	move.b	d0,Object_slot_number
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
	bra.w	Continue_transfer_item
.Multiple:
	moveq.l	#0,d0
	move.b	(a1),d0
	move.l	d0,Original_number
	clr.l	ItemW_nr
	lea.l	TransMItem_Mod,a0
	bsr.w	Push_Module
	rts	
T_129fe:
	movem.l	d0-d7/a0-a6,-(a7)
	move.w	#$60,Adding
	moveq	#15,d0
	jsr	IG_Set_ink
	moveq	#2,d0
	jsr	IG_Set_paper
	bsr.w	ItemW_DisInit
	move.b	Object_slot_number,d0
	ext.w	d0
	movea.l	Current_inventory_chardat_ptr,a1
	lea.l	$21(a1),a2
	lea.l	$10a(a1),a3
	adda.w	d0,a2
	moveq	#40,d1
	mulu.w	d0,d1
	adda.w	d1,a3
	movea.l	Off_screen,a6
	move.b	(a3),d0
	moveq	#0,d1
	bsr.w	INV2_Show_object
	move.w	#$43,d0
	move.w	#$82,d1
	jsr	IG_Set_cursor
	move.w	$26(a3),d0
	bsr.w	Get_word
	lea.l	Line_buffer,a0
	jsr	IG_Print
	move.w	#$31,d0
	move.w	#$96,d1
	jsr	IG_Set_cursor
	moveq	#14,d0
	lea.l	Code0001Sys,a1
	jsr	Convert_text_line
	lea.l	Line_buffer,a0
	jsr	IG_Print
	jsr	Switch_screen
	jsr	Copy_screen
	movem.l	(a7)+,d0-d7/a0-a6
	rts
; ---- TransMItem_Return (original source: MAIN/INVENT.ASM)
TransMItem_Return:
	movea.l	Current_inventory_chardat_ptr,a0
	lea.l	Inv_data-40(a0),a0
	move.b	Object_slot_number,d0
	ext.w	d0
	mulu.w	#40,d0
	adda.w	d0,a0
	move.l	ItemW_nr,d2
	bne.s	.Not_zero
	bra.w	Pop_Module
.Not_zero:
	move.w	d2,d0
	mulu.w	Weight(a0),d0
	move.w	Item_ID(a0),d1
; ---- Continue_transfer_item (original source: MAIN/INVENT.ASM)
Continue_transfer_item:
	movea.l	Current_inventory_chardat_ptr,a0
	bsr.w	Scan_4_transfer_victims
	bne.s	.Go
	move.w	#5,d0
	jsr	Plus_message
	bra.w	Pop_Module
.Go:
	bsr.w	Show_transfer_victims
	move.b	Object_slot_number,d0
	ext.w	d0
	mulu.w	#40,d0
	movea.l	Current_inventory_chardat_ptr,a0
	lea.l	Inv_data-40(a0),a0
	move.b	0(a0,d0.w),TIVS_Icon_nr
	move.l	#T_12b2a,TIVS_Ptr	; CHANGE: was "move.l #Inv2_Do_TI,TIVS_Ptr"
	lea.l	TIVS1_Mod,a0
	move.w	#24,Mouse_ptr(a0)
	bra.w	Push_Module
T_12b2a:
	btst	#$1,Mouse_button_state
	bne.b	T_12b2a
; ---- Inv2_Do_TI (original source: MAIN/INVENT.ASM)
Inv2_Do_TI:
	movea.l	Current_inventory_chardat_ptr,a1
	lea.l	Neck_place_counter-1(a1),a2
	lea.l	Inv_data-40(a1),a3
	moveq.l	#0,d0
	move.b	Object_slot_number,d0
	adda.w	d0,a2
	mulu.w	#40,d0
	adda.w	d0,a3
	moveq.l	#1,d1
	btst	#2,Item_stat_bits(a3)
	beq.s	.Continue
	cmpi.b	#1,(a2)
	bhi.s	.Multiple
	move.l	d1,ItemW_nr
.Multiple:
	lea.l	Inventory_1_place_counter(a0),a4
	lea.l	Inv_data+360(a0),a5
	move.w	Item_ID(a3),d0
	move.l	ItemW_nr,d1
	moveq.l	#12-1,d7
.Loop1:
	tst.b	(a4)
	beq.s	.Next1
	cmp.w	Item_ID(a5),d0
	bne.s	.Next1
	cmpi.b	#99,(a4)
	bmi.s	.Found1
.Next1:
	addq.l	#1,a4
	lea.l	40(a5),a5
	dbra	d7,.Loop1
	bra.s	.Continue
.Found1:
	moveq.l	#0,d0
	move.b	(a4),d0
	add.w	d1,d0
	cmpi.w	#99,d0
	bls.s	.Do_it
	moveq.l	#99,d2
	sub.b	(a4),d2
	sub.l	d2,ItemW_nr
	move.b	#99,(a4)
	sub.b	d2,(a2)
	mulu.w	Weight(a3),d2
	add.l	d2,Weight_normal(a0)
	sub.l	d2,Weight_normal(a1)
	bra.s	.Multiple
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
	move.b	d1,d2
	mulu.w	Weight(a3),d2
	add.l	d2,Weight_normal(a0)
	sub.l	d2,Weight_normal(a1)
	add.b	d1,(a4)
	moveq.l	#20-1,d7
.Loop3:
	move.w	(a3)+,(a5)+
	dbra	d7,.Loop3
	lea.l	-40(a3),a3
	movea.l	Off_screen,a6
	sub.b	d1,(a2)
	bne.s	.Skip
	move.b	Object_slot_number,d0
	bsr.w	INV2_Erase_object
	jsr	Switch_screen
	jsr	Copy_screen
	bra.s	.Exit
.Skip:
	cmpi.b	#1,(a2)
	bne.s	.Exit
	move.b	(a3),d0
	move.b	Object_slot_number,d1
	bsr.w	INV2_Show_object
	jsr	Switch_screen
	jsr	Copy_screen
.Exit:
	bra.w	Pop_Module
T_12c3e:
	btst	#$1,Mouse_button_state
	bne.b	T_12c3e
; ---- Transfer_gold (original source: MAIN/INVENT.ASM)
Transfer_gold:
	movea.l	Off_screen,a6
	move.w	#6,d0
	jsr	Minus_message
	jsr	Switch_screen
	jsr	Copy_screen
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	movea.l	Current_inventory_chardat_ptr,a0
	moveq.l	#0,d0
	move.w	Gold_coins(a0),d0
	move.l	d0,Original_number
	clr.l	ItemW_nr
	st.b	B_587f9	; CHANGE: added
	lea.l	TransGold_Mod,a0	; CHANGE: added
	bsr.w	Push_Module	; CHANGE: added
	sf.b	B_587f9	; CHANGE: added
	rts	; CHANGE: added
	moveq	#15,d0	; CHANGE: added
	jsr	IG_Set_ink	; CHANGE: added
	moveq	#2,d0	; CHANGE: added
	jsr	IG_Set_paper	; CHANGE: added
	moveq	#32,d0	; CHANGE: added
	moveq	#112,d1	; CHANGE: added
	moveq	#10,d2	; CHANGE: added
	moveq	#6,d3	; CHANGE: added
	moveq	#1,d6	; CHANGE: added
	lea.l	D_2f90a,a0	; CHANGE: added
	jsr	Open_window	; CHANGE: added
	move.w	d0,B_58256	; CHANGE: added
	movea.l	Off_screen,a6	; CHANGE: added
	moveq	#2,d6	; CHANGE: added
	moveq	#16,d7	; CHANGE: added
	move.w	#$30,d0	; CHANGE: added
	move.w	#$a0,d1	; CHANGE: added
	lea.l	D_38060,a0	; CHANGE: added
	jsr	Blot_unmasked_block	; CHANGE: added
	move.w	#$30,d0	; CHANGE: added
	move.w	#$b0,d1	; CHANGE: added
	lea.l	D_38160,a0	; CHANGE: added
	jsr	Blot_unmasked_block	; CHANGE: added
	move.w	#$80,d0	; CHANGE: added
	move.w	#$b0,d1	; CHANGE: added
	lea.l	D_39d60,a0	; CHANGE: added
	jsr	Blot_unmasked_block	; CHANGE: added
	bsr.w	ItemW_DisUpd	; CHANGE: added
	tst.b	B_587f9	; CHANGE: added
	beq.b	.c_12d34	; CHANGE: added
	move.w	#$80,d0	; CHANGE: added
	move.w	#$a0,d1	; CHANGE: added
	moveq	#2,d6	; CHANGE: added
	moveq	#16,d7	; CHANGE: added
	lea.l	D_3a160,a0	; CHANGE: added
	jsr	Blot_unmasked_block	; CHANGE: added
.c_12d34:
	move.w	#$31,d0	; CHANGE: added
	move.w	#$96,d1	; CHANGE: added
	jsr	IG_Set_cursor	; CHANGE: added
	moveq	#14,d0	; CHANGE: added
	lea.l	Code0001Sys,a1	; CHANGE: added
	jsr	Convert_text_line	; CHANGE: added
	lea.l	Line_buffer,a0	; CHANGE: was "Push Module,TransGold_Mod"
	jsr	IG_Print	; CHANGE: was "Push Module,TransGold_Mod"
	rts	
T_12d5e:
	move.w	#$60,Adding
	bsr.w	T_12c9e
	movea.l	Off_screen,a6
	move.w	#$60,d0
	moveq	#0,d1
	bsr.w	INV2_Show_object
	move.w	#$43,d0
	move.w	#$82,d1
	jsr	IG_Set_cursor
	lea.l	Gold_txt,a0
	jsr	IG_Print
	jsr	Switch_screen
	jsr	Copy_screen
	rts
T_12da2:
	btst	#$1,Mouse_button_state
	bne.b	T_12da2
	bsr.w	Pop_Module
	move.l	ItemW_nr,d0
	beq.b	.l_12df4
	move.w	d0,d1
	mulu.w	#$a,d0
	movea.l	Current_inventory_chardat_ptr,a0
	bsr.w	Scan_4_gold_victims
	bne.b	.l_12dd6
	move.w	#$5,d0
	jsr	Plus_message
	bra.b	.l_12df4
.l_12dd6:
	bsr.w	Show_transfer_victims
	move.l	#.l_12df6,TIVS_Ptr
	lea.l	TIVS1_Mod,a0
	move.w	#$19,$2c(a0)
	bsr.w	Push_Module
.l_12df4:
	rts
.l_12df6:
	btst	#$1,Mouse_button_state
	bne.b	.l_12df6
; ---- Do_TransferGold (original source: MAIN/INVENT.ASM)
Do_TransferFood:
Do_TransferGold:
	movea.l	Current_inventory_chardat_ptr,a1
	move.l	ItemW_nr,d0
	add.w	d0,Gold_coins(a0)
	sub.w	d0,Gold_coins(a1)
	mulu.w	#Gold_weight,d0
	add.l	d0,Weight_normal(a0)
	sub.l	d0,Weight_normal(a1)
	rts	
Equip_item:
	btst	#$1,Mouse_button_state
	bne.b	Equip_item
	tst.l	ItemW_nr
	beq.b	.l_12e5a
	move.l	#Code0001Sys,Textfile_ptr
	move.w	#$18,ReqText_nr
	move.l	#.l_12e5c,ReqDo_ptr
	lea.l	Req_Mod,a0
	bsr.w	Push_Module
.l_12e5a:
	rts
.l_12e5c:
	movea.l	Current_inventory_chardat_ptr,a1
	move.l	ItemW_nr,d0
	sub.w	d0,Gold_coins(a1)
	mulu.w	#$a,d0
	sub.l	d0,Weight_normal(a1)
	bra.w	Pop_Module
T_12e78:
	btst	#$1,Mouse_button_state
	bne.b	T_12e78
; ---- Transfer_food (original source: MAIN/INVENT.ASM)
Transfer_food:
	movea.l	Off_screen,a6
	move.w	#7,d0
	jsr	Minus_message
	jsr	Switch_screen
	jsr	Copy_screen
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	movea.l	Current_inventory_chardat_ptr,a0
	moveq.l	#0,d0
	move.w	Food_rations(a0),d0
	move.l	d0,Original_number
	clr.l	ItemW_nr
	st.b	B_587f9	; CHANGE: added
	lea.l	TransFood_Mod,a0
	bsr.w	Push_Module
	sf.b	B_587f9	; CHANGE: added
	rts	
T_12ed8:
	move.w	#$60,Adding
	bsr.w	T_12c9e
	movea.l	Off_screen,a6
	move.w	#$6d,d0
	moveq	#0,d1
	bsr.w	INV2_Show_object
	move.w	#$43,d0
	move.w	#$82,d1
	jsr	IG_Set_cursor
	lea.l	Food_txt,a0
	jsr	IG_Print
	jsr	Switch_screen
	jsr	Copy_screen
	rts
T_12f1c:
	btst	#$1,Mouse_button_state
	bne.b	T_12f1c
	bsr.w	Pop_Module
	move.l	ItemW_nr,d0
	beq.w	.l_12fca
	movea.l	Current_inventory_chardat_ptr,a0
	mulu.w	#$fa,d0
	lea.l	Chard_ptrs,a1
	lea.l	Char_status_icons,a4
	moveq	#0,d6
	moveq	#1,d7
.l_12f4e:
	tst.l	(a1)
	beq.b	.l_12f84
	cmpa.l	(a1),a0
	bne.b	.l_12f5a
	move.w	d7,d5
	bra.b	.l_12f84
.l_12f5a:
	movea.l	(a1),a2
	move.w	Attr_1_normal(a2),d1
	add.w	Attr_1_normal_magic(a2),d1
	mulu.w	#$3e8,d1
	sub.l	Weight_normal(a2),d1
	cmp.l	d0,d1
	bmi.b	.l_12f84
	move.w	Food_rations(a2),d1
	add.w	d0,d1
	bvs.b	.l_12f84
	move.w	#$e402,d1
	and.w	Body_conditions(a2),d1
	bne.b	.l_12f84
	bset	d7,d6
.l_12f84:
	addq.l	#$4,a1
	addq.w	#$1,d7
	cmpi.w	#$7,d7
	bmi.b	.l_12f4e
	bmi.b	.l_12f4e
	move.w	d5,Transferring
	move.w	d6,Transfer_victims
	tst.w	d6
	bne.b	.l_12fac
	move.w	#$5,d0
	jsr	Plus_message
	bra.b	.l_12fca
.l_12fac:
	bsr.w	Show_transfer_victims
	move.l	#.l_12fcc,TIVS_Ptr
	lea.l	TIVS1_Mod,a0
	move.w	#$1a,$2c(a0)
	bsr.w	Push_Module
.l_12fca:
	rts
.l_12fcc:
	btst	#$1,Mouse_button_state
	bne.b	.l_12fcc
	movea.l	Current_inventory_chardat_ptr,a1
	move.l	ItemW_nr,d0
	add.w	d0,$92(a0)
	sub.w	d0,Food_rations(a1)
	mulu.w	#$fa,d0
	add.l	d0,$ec(a0)
	sub.l	d0,Weight_normal(a1)
	rts
T_12ff8:
	btst	#$1,Mouse_button_state
	bne.b	T_12ff8
	tst.l	ItemW_nr
	beq.b	.l_13030
	move.l	#Code0001Sys,Textfile_ptr
	move.w	#$19,ReqText_nr
	move.l	#.l_13032,ReqDo_ptr
	lea.l	Req_Mod,a0
	bsr.w	Push_Module
.l_13030:
	rts
.l_13032:
	movea.l	Current_inventory_chardat_ptr,a1
	move.l	ItemW_nr,d0
	sub.w	d0,Food_rations(a1)
	mulu.w	#$fa,d0
	sub.l	d0,Weight_normal(a1)
	bra.w	Pop_Module
T_1304e:
	btst	#$1,Mouse_button_state
	bne.b	T_1304e
	tst.b	d0
	beq.w	.l_13216
	ext.w	d0
	addi.w	#$9,d0
	movea.l	Current_inventory_chardat_ptr,a0
	lea.l	$21(a0),a1
	adda.w	d0,a1
	tst.b	(a1)
	beq.w	.l_13216
	lea.l	$10a(a0),a2
	moveq	#40,d1
	mulu.w	d0,d1
	adda.w	d1,a2
	movea.l	Off_screen,a6
	tst.b	Battling
	beq.b	.l_13098
	btst	#$4,$18(a2)
	beq.w	.l_13216
.l_13098:
	move.b	$12(a2),d1
	beq.b	.l_130b0
	cmpi.b	#$7,d1
	beq.b	.l_130be
	lea.l	$21(a0),a3
	ext.w	d1
	tst.b	(a3,d1.w)
	beq.b	.l_130be
.l_130b0:
	move.w	#$8,d0
	jsr	Plus_message
	bra.w	.l_13216
.l_130be:
	move.b	Character_class(a0),d1
	move.w	$1e(a2),d2
	btst	d1,d2
	bne.b	.l_130d8
	move.w	#$9,d0
	jsr	Plus_message
	bra.w	.l_13216
.l_130d8:
	move.b	$3(a2),d1
	beq.b	.l_130f4
	subq.b	#$1,d1
	cmp.b	Character_sex(a0),d1
	beq.b	.l_130f4
	move.w	#$a,d0
	jsr	Plus_message
	bra.w	.l_13216
.l_130f4:
	move.b	$4(a2),d1
	beq.b	.l_13112
	moveq	#2,d2
	sub.b	Hands_occupied(a0),d2
	cmp.b	d1,d2
	bpl.b	.l_13112
	move.w	#$b,d0
	jsr	Plus_message
	bra.w	.l_13216
.l_13112:
	move.b	$5(a2),d1
	beq.b	.l_13130
	moveq	#2,d2
	sub.b	Ringfingers_occupied(a0),d2
	cmp.b	d1,d2
	bpl.b	.l_13130
	move.w	#$c,d0
	jsr	Plus_message
	bra.w	.l_13216
.l_13130:
	lea.l	$21(a0),a3
	move.b	$12(a2),d1
	cmpi.b	#$7,d1
	bne.b	.l_13146
	tst.b	$7(a3)
	beq.b	.l_13146
	addq.b	#$2,d1
.l_13146:
	ext.w	d1
	adda.w	d1,a3
	lea.l	$10a(a0),a4
	moveq	#40,d2
	mulu.w	d1,d2
	adda.w	d2,a4
	move.b	$4(a2),d2
	add.b	d2,Hands_occupied(a0)
	move.b	$5(a2),d2
	add.b	d2,Ringfingers_occupied(a0)
	move.b	$13(a2),d2
	add.b	d2,Magic_bonus_weapon(a0)
	move.b	$14(a2),d2
	add.b	d2,Magic_bonus_armour(a0)
	lea.l	$ae(a0),a5
	move.b	$19(a2),d2
	ext.w	d2
	add.w	d2,d2
	adda.w	d2,a5
	move.b	$1b(a2),d2
	ext.w	d2
	sub.w	d2,(a5)
	lea.l	$ae(a0),a5
	move.b	$1a(a2),d2
	ext.w	d2
	add.w	d2,d2
	adda.w	d2,a5
	move.b	$1c(a2),d2
	ext.w	d2
	sub.w	d2,(a5)
	btst	#$0,$18(a2)
	bne.b	.l_131ae
	bsr.w	Positive_boni
	bra.b	.l_131b2
.l_131ae:
	bsr.w	Negative_boni
.l_131b2:
	move.b	#$1,(a3)
	moveq	#19,d7
.l_131b8:
	move.w	(a2)+,(a4)+
	dbra	d7,.l_131b8
	lea.l	-$28(a2),a2
	lea.l	-$28(a4),a4
	cmpi.b	#$2,$4(a2)
	bne.b	.l_131e4
	cmpi.w	#$4,d1
	bne.b	.l_131e4
	movem.l	d0-d1,-(a7)
	moveq	#0,d0
	moveq	#6,d1
	bsr.w	INV2_Show_object
	movem.l	(a7)+,d0-d1
.l_131e4:
	subq.b	#$1,(a1)
	bne.b	.l_131ee
	bsr.w	INV2_Erase_object
	bra.b	.l_13204
.l_131ee:
	cmpi.b	#$1,(a1)
	bne.b	.l_13204
	movem.w	d0-d1,-(a7)
	move.b	d0,d1
	move.b	(a2),d0
	bsr.w	INV2_Show_object
	movem.w	(a7)+,d0-d1
.l_13204:
	move.b	(a4),d0
	bsr.w	INV2_Show_object
	jsr	Switch_screen
	jsr	Copy_screen
.l_13216:
	rts
; ---- Unequip_item (original source: MAIN/INVENT.ASM)
Unequip_item:
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	tst.b	d0
	beq.w	.Exit
	ext.w	d0
	movea.l	Current_inventory_chardat_ptr,a0
	lea.l	Neck_place_counter-1(a0),a1
	adda.w	d0,a1
	tst.b	(a1)
	beq.w	.Exit
	lea.l	Inv_data-40(a0),a2
	moveq.l	#40,d1
	mulu.w	d0,d1
	adda.w	d1,a2
	movea.l	Off_screen,a6
; CHANGE: removed "cmpi.b #17,Item_type(a2)"
; CHANGE: removed "beq .Exit"
	tst.b	Battling
	beq.s	.Battle_OK
	btst	#4,Item_stat_bits(a2)
	beq.w	.Exit	; CHANGE: was "bne .Exit"
.Battle_OK:
	btst	#0,Item_stat_bits(a2)
	beq.s	.Not_cursed
	move.w	#17,d0
	jsr	Plus_message
	bra.w	.Exit
.Not_cursed:
	btst	#2,Item_stat_bits(a2)
	beq.s	.Single
.Multiple:
	lea.l	Inventory_1_place_counter(a0),a3
	lea.l	Inv_data+360(a0),a4
	moveq.l	#10,d1
	move.w	Item_ID(a2),d2
	moveq.l	#12-1,d7
.Loop1:
	tst.b	(a3)
	beq.s	.Next1
	cmp.w	Item_ID(a4),d2
	bne.s	.Next1
	cmpi.b	#99,(a3)
	bmi.s	.Continue
.Next1:
	addq.w	#1,d1
	addq.l	#1,a3
	lea.l	40(a4),a4
	dbra	d7,.Loop1
.Single:
	lea.l	Inventory_1_place_counter(a0),a3
	lea.l	Inv_data+360(a0),a4
	moveq.l	#10,d1
	moveq.l	#12-1,d7
.Loop2:
	tst.b	(a3)
	beq.s	.Continue
	addq.w	#1,d1
	addq.l	#1,a3
	lea.l	40(a4),a4
	dbra	d7,.Loop2
	move.w	#13,d0
	jsr	Plus_message
	bra.w	.Exit
.Continue:
	move.b	Hand_use(a2),d2
	sub.b	d2,Hands_occupied(a0)
	move.b	Ring_use(a2),d2
	sub.b	d2,Ringfingers_occupied(a0)
	move.b	Weapon_magic_bonus(a2),d2
	sub.b	d2,Magic_bonus_weapon(a0)
	move.b	Armour_magic_bonus(a2),d2
	sub.b	d2,Magic_bonus_armour(a0)
	lea.l	Skill_1_normal_magic-2(a0),a5
	move.b	Item_skill_1(a2),d2
	ext.w	d2
	add.w	d2,d2
	adda.w	d2,a5
	move.b	Malus_1(a2),d2
	ext.w	d2
	add.w	d2,(a5)
	lea.l	Skill_1_normal_magic-2(a0),a5
	move.b	Item_skill_2(a2),d2
	ext.w	d2
	add.w	d2,d2
	adda.w	d2,a5
	move.b	Malus_2(a2),d2
	ext.w	d2
	add.w	d2,(a5)
	btst	#0,Item_stat_bits(a2)
	bne.s	.Cursed
	bsr.w	Negative_boni
	bra.s	.Well
.Cursed:
	bsr.w	Positive_boni
.Well:
	clr.b	(a1)
	addq.b	#1,(a3)
	moveq.l	#20-1,d7
.Loop3:
	move.w	(a2)+,(a4)+
	dbra	d7,.Loop3
	lea.l	-40(a2),a2
	lea.l	-40(a4),a4
	cmpi.b	#2,Hand_use(a2)
	bne.s	.Go_on
	cmpi.w	#4,d0
	bne.s	.Go_on
	move.l	d0,-(sp)
	moveq.l	#6,d0
	bsr.w	INV2_Erase_object
	move.l	(sp)+,d0
.Go_on:
	bsr.w	INV2_Erase_object
	move.b	(a4),d0
	bsr.w	INV2_Show_object
	jsr	Switch_screen
	jsr	Copy_screen
.Exit:
	rts	
; ---- Positive_boni (original source: MAIN/INVENT.ASM)
Positive_boni:
	move.b	LP_max(a2),d2
	ext.w	d2
	add.w	d2,Life_points_max_magic(a0)
	move.b	SP_max(a2),d2
	ext.w	d2
	add.w	d2,Power_points_max_magic(a0)
	lea.l	Attr_1_normal_magic-2(a0),a5
	move.b	Attribute(a2),d2
	ext.w	d2
	add.w	d2,d2
	adda.w	d2,a5
	move.b	Attribute_normal(a2),d2
	ext.w	d2
	add.w	d2,(a5)
	lea.l	Skill_1_normal_magic-2(a0),a5
	move.b	Skill(a2),d2
	ext.w	d2
	add.w	d2,d2
	adda.w	d2,a5
	move.b	Skill_normal(a2),d2
	ext.w	d2
	add.w	d2,(a5)
	move.b	Protection_pts(a2),d2
	ext.w	d2
	add.w	d2,Protection_magic(a0)
	move.b	Damage_pts(a2),d2
	ext.w	d2
	add.w	d2,Damage_magic(a0)
	rts	
; ---- Negative_boni (original source: MAIN/INVENT.ASM)
Negative_boni:
	move.b	LP_max(a2),d2
	ext.w	d2
	sub.w	d2,Life_points_max_magic(a0)
	move.b	SP_max(a2),d2
	ext.w	d2
	sub.w	d2,Power_points_max_magic(a0)
	lea.l	Attr_1_normal_magic-2(a0),a5
	move.b	Attribute(a2),d2
	ext.w	d2
	add.w	d2,d2
	adda.w	d2,a5
	move.b	Attribute_normal(a2),d2
	ext.w	d2
	sub.w	d2,(a5)
	lea.l	Skill_1_normal_magic-2(a0),a5
	move.b	Skill(a2),d2
	ext.w	d2
	add.w	d2,d2
	adda.w	d2,a5
	move.b	Skill_normal(a2),d2
	ext.w	d2
	sub.w	d2,(a5)
	move.b	Protection_pts(a2),d2
	ext.w	d2
	sub.w	d2,Protection_magic(a0)
	move.b	Damage_pts(a2),d2
	ext.w	d2
	sub.w	d2,Damage_magic(a0)
	rts	
; ---- Update_quantity_colours (original source: MAIN/INVENT.ASM)
Update_quantity_colours:
	subq.b	#1,Quant_count
	bne.s	.Exit
	move.b	#4,Quant_count
	lea.l	Quant_cycles,a0
	move.w	Quant_index,d0
	addq.w	#1,d0
	move.b	0(a0,d0.w),d1
	bpl.s	.Not_end
	moveq.l	#0,d0
	move.b	(a0),d1
.Not_end:
	move.w	d0,Quant_index
	cmpi.b	#4,d1
	seq	Quant_block
	move.b	d1,Quant_init_string+1
.Exit:
	rts	
; ---- TIVS_ModInit (original source: MAIN/INVENT.ASM)
TIVS_ModInit:
	lea.l	Main_root,a0
	jsr	Push_MA
	movea.l	Module_sp,a0
	cmpi.w	#24,Mouse_ptr(a0)
	bne.s	.Skip
	move.b	TIVS_Icon_nr,d0
	bsr.w	Build_object_mptr
.Skip:
	movea.l	Off_screen,a6
	move.w	#19,d0
	jsr	Minus_message
	jsr	Switch_screen
	jsr	Copy_screen
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	rts	
; ---- TIVS_DisUpd (original source: MAIN/INVENT.ASM)
TIVS_DisUpd:
	jsr	Update_status_block
	bsr.w	Update_quantity_colours
	rts	
; ---- TIVS_ModExit (original source: MAIN/INVENT.ASM)
TIVS_ModExit:
	st	AutoIcon_flag
	jsr	DoAutoIcon
	movea.l	Off_screen,a6
	jsr	Erase_message_minus
	jsr	Switch_screen
	jsr	Copy_screen
	jsr	Pop_MA
	rts	
; ---- TIVS_Action (original source: MAIN/INVENT.ASM)
TIVS_Action:
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	move.w	Transfer_victims,d1
	lsr.w	#8,d0
	btst	d0,d1
	beq.s	.Exit
	lea.l	Chard_ptrs,a0
	add.w	d0,d0
	add.w	d0,d0
	movea.l	-4(a0,d0.w),a0
	movea.l	TIVS_Ptr,a1
	jsr	(a1)
.Exit:
	bra.w	Pop_Module
; ---- Scan_4_transfer_victims (original source: MAIN/INVENT.ASM)
Scan_4_transfer_victims:
	movem.l	d2/d3/d5-d7/a0-a4,-(sp)
	lea.l	Chard_ptrs,a1
	lea.l	Char_status_icons,a4
	moveq.l	#0,d5
	moveq.l	#0,d6
	moveq.l	#1,d7
.Loop1:
	tst.l	(a1)
	beq.s	.Next
	cmpa.l	(a1),a0
	bne.s	.Do_it
	move.w	d7,d5
	bra.s	.Next
.Do_it:
	movea.l	(a1),a2
	move.w	Attr_1_normal(a2),d2
	add.w	Attr_1_normal_magic(a2),d2
	mulu.w	#1000,d2
	sub.l	Weight_normal(a2),d2
	cmp.l	d0,d2
	bmi.s	.Next
	lea.l	Inventory_1_place_counter(a2),a3
	lea.l	Inv_data+360(a2),a4
	moveq.l	#12-1,d2
.Loop2:
	tst.b	(a3)+
	beq.s	.Next2
	cmp.w	Item_ID(a4),d1
	bne.s	.Next2
	cmpi.b	#99,-1(a3)
	bls.s	.Continue
.Next2:
	lea.l	40(a4),a4
	dbra	d2,.Loop2
	lea.l	Inventory_1_place_counter(a2),a3
	moveq.l	#12-1,d2
.Loop3:
	tst.b	(a3)+
	beq.s	.Continue
	dbra	d2,.Loop3
	bra.s	.Next
.Continue:
	cmpi.b	#9,Character_race(a2)
	bpl.s	.Next
	move.w	#$e402,d2
	and.w	Body_conditions(a2),d2
	bne.s	.Next
	bset	d7,d6
.Next:
	addq.l	#4,a1
	addq.w	#1,d7
	cmpi.w	#6+1,d7
	bmi.s	.Loop1
	move.w	d5,Transferring
	move.w	d6,Transfer_victims
	tst.w	d6
	movem.l	(sp)+,d2/d3/d5-d7/a0-a4
	rts	
; ---- Scan_4_gold_victims (original source: MAIN/INVENT.ASM)
Scan_4_gold_victims:
	movem.l	d2/d5-d7/a0-a2,-(sp)
	lea.l	Chard_ptrs,a1
	moveq.l	#0,d6
	moveq.l	#1,d7
.Loop:
	tst.l	(a1)
	beq.s	.Next
	cmpa.l	(a1),a0
	bne.s	.Do_it
	move.w	d7,d5
	bra.s	.Next
.Do_it:
	movea.l	(a1),a2
	move.w	Attr_1_normal(a2),d2
	add.w	Attr_1_normal_magic(a2),d2
	mulu.w	#1000,d2
	sub.l	Weight_normal(a2),d2
	cmp.l	d0,d2
	bmi.s	.Next
	move.w	Gold_coins(a2),d2
	add.w	d1,d2
	bvs.s	.Next
	cmpi.b	#9,Character_race(a2)
	bpl.s	.Next
	move.w	#$e402,d2
	and.w	Body_conditions(a2),d2
	bne.s	.Next
	bset	d7,d6
.Next:
	addq.l	#4,a1
	addq.w	#1,d7
	cmpi.w	#6+1,d7
	bmi.s	.Loop
	move.w	d5,Transferring
	move.w	d6,Transfer_victims
	tst.w	d6
	movem.l	(sp)+,d2/d5-d7/a0-a2
	rts	
; ---- Show_transfer_victims (original source: MAIN/INVENT.ASM)
Show_transfer_victims:
	movem.l	d0/d1/d7/a0,-(sp)
	sf	AutoIcon_flag
	lea.l	Char_status_icons,a0
	move.w	Transferring,d0
	move.w	Transfer_victims,d1
	moveq.l	#1,d7
.Loop:
	cmp.w	d0,d7
	beq.s	.No
	btst	d7,d1
	bne.s	.Yes
.No:
	move.b	#8,(a0)+
	bra.s	.Next
.Yes:
	move.b	#9,(a0)+
.Next:
	addq.w	#1,d7
	cmpi.w	#6+1,d7
	bmi.s	.Loop
	movem.l	(sp)+,d0/d1/d7/a0
	rts	
; ---- Build_object_mptr (original source: MAIN/INVENT.ASM)
Build_object_mptr:
	movem.l	d0/d7/a0/a1,-(sp)
	lea.l	Objects_icn,a0
	andi.w	#$00ff,d0
	lsl.w	#7,d0
	adda.w	d0,a0
	lea.l	UDMPTR+4,a1
	moveq.l	#16-1,d7
.Loop:
	move.w	(a0)+,d0
	or.w	(a0)+,d0
	or.w	(a0)+,d0
	or.w	(a0)+,d0
	move.w	d0,(a1)+
	not.w	d0
	move.w	d0,32-2(a1)
	dbra	d7,.Loop
	movem.l	(sp)+,d0/d7/a0/a1
	rts	
; ---- Pool_gold (original source: MAIN/INVENT.ASM)
Pool_gold:
	movem.l	d1-d5/d7/a0-a2,-(sp)
	lea.l	Chard_ptrs,a1
	move.w	d0,d3
	moveq.l	#0,d0
	moveq.l	#6-1,d7
.Loop:
	tst.l	(a1)
	beq.s	.Next
	cmpa.l	(a1),a0
	beq.s	.Next
	movea.l	(a1),a2
	move.w	#$0402,d5
	and.w	Body_conditions(a2),d5
	bne.s	.Next
	move.w	Gold_coins(a2),d4
	move.w	d4,d5
	add.w	d3,d5
	bvc.s	.Not_too_much
	move.w	#$7fff,d4	; CHANGE: was "move.w #32767,d5"
	sub.w	d3,d4	; CHANGE: was "sub.w d3,d5"
; CHANGE: removed "sub.w d4,d5"
; CHANGE: removed "move.w d5,d4"
	moveq.l	#0,d7
.Not_too_much:
	moveq.l	#Gold_weight,d5
	mulu.w	d4,d5
	add.l	d1,d5
	cmp.l	d2,d5
	bls.s	.Not_too_heavy
	move.l	d2,d5
	sub.l	d1,d5
	divu.w	#Gold_weight,d5
	move.w	d5,d4
	moveq.l	#0,d7
.Not_too_heavy:
	sub.w	d4,Gold_coins(a2)
	add.w	d4,d0
	mulu.w	#Gold_weight,d4
	sub.l	d4,Weight_normal(a2)
	add.l	d4,d1	; CHANGE: added
.Next:
	addq.l	#4,a1
	dbra	d7,.Loop
	movem.l	(sp)+,d1-d5/d7/a0-a2
	rts	
; ---- Remove_boni (original source: MAIN/INVENT.ASM)
Remove_boni:
	movem.l	d0/d2/a0-a2/a5,-(sp)
	lea.l	Neck_place_counter(a0),a1
	lea.l	Inv_data(a0),a2
	ext.w	d0
	subq.w	#1,d0
	adda.w	d0,a1
	mulu.w	#40,d0
	adda.w	d0,a2
	move.b	Hand_use(a2),d2
	sub.b	d2,Hands_occupied(a0)
	move.b	Ring_use(a2),d2
	sub.b	d2,Ringfingers_occupied(a0)
	move.b	Weapon_magic_bonus(a2),d2
	sub.b	d2,Magic_bonus_weapon(a0)
	move.b	Armour_magic_bonus(a2),d2
	sub.b	d2,Magic_bonus_armour(a0)
	lea.l	Skill_1_normal_magic-2(a0),a5
	move.b	Item_skill_1(a2),d2
	ext.w	d2
	add.w	d2,d2
	adda.w	d2,a5
	move.b	Malus_1(a2),d2
	ext.w	d2
	add.w	d2,(a5)
	lea.l	Skill_1_normal_magic-2(a0),a5
	move.b	Item_skill_2(a2),d2
	ext.w	d2
	add.w	d2,d2
	adda.w	d2,a5
	move.b	Malus_2(a2),d2
	ext.w	d2
	add.w	d2,(a5)
	btst	#0,Item_stat_bits(a2)
	bne.s	.Cursed
	bsr.w	Negative_boni
	bra.s	.Exit
.Cursed:
	bsr.w	Positive_boni
.Exit:
	movem.l	(sp)+,d0/d2/a0-a2/a5
	rts	
T_13772:
	btst	#$1,Mouse_button_state
	bne.b	T_13772
	sf.b	Magic_object_flag
	movea.l	Current_active_char_data,a0
	move.b	Spell_class_counter(a0),d0
	moveq	#0,d1
	moveq	#1,d2
	moveq	#6,d7
.l_13792:
	btst	d2,d0
	beq.b	.l_1379e
	move.w	d2,Selected_class
	addq.w	#$1,d1
.l_1379e:
	addq.w	#$1,d2
	dbra	d7,.l_13792
	move.w	d1,B_58816
	lea.l	$d0(a0),a0
	move.w	Selected_class,d0
	add.w	d0,d0
	add.w	d0,d0
	tst.l	-$4(a0,d0.w)
	beq.b	.l_137da
	cmpi.w	#$1,d1
	bne.b	.l_137d0
	lea.l	SpSelW_Mod,a0
	bsr.w	Push_Module
	bra.b	.l_137da
.l_137d0:
	lea.l	SCSelW_Mod,a0
	bsr.w	Push_Module
.l_137da:
	rts

	section	data

Skills_name:
	dc.b	$01,$08,$53,$4b,$49,$4c,$4c,$53,$01,$0f,$00
D_2da9b:
	dc.b	$01,$08,$41,$54,$54,$52,$49,$42,$55,$54,$45,$53,$01,$0f,$00
Age_txt:
	dc.b	$41,$47,$45,$3a,$20,$00
D_2dab0:
	dc.b	$01,$08,$4c,$41,$4e,$47,$55,$41,$47,$45,$53,$01,$0f,$00
D_2dabe:
	dc.b	$01,$08,$42,$4f,$44,$59,$01,$0f,$00
D_2dac7:
	dc.b	$01,$08,$4d,$49,$4e,$44,$01,$0f,$00
D_2dad0:
	dc.b	$01,$0f,$02,$02,$57,$45,$49,$47,$48,$54,$00
Gold_txt:
	dc.b	$47,$4f,$4c,$44,$00
Food_txt:
	dc.b	$52,$41,$54,$49,$4f,$4e,$53,$00
Goldfood_txt:
	dc.b	$47,$3a,$30,$31,$32,$33,$34,$20,$52,$3a,$30,$31,$32,$33,$00
Male_name:
	dc.b	$4d,$41,$4c,$45,$00
Female_name:
	dc.b	$46,$45,$4d,$41,$4c,$45,$00
D_2db03:
	dc.b	$4d,$41,$4c,$45,$00
D_2db08:
	dc.b	$46,$45,$4d,$41,$4c,$45,$00
D_2db0f:
	dc.b	$42,$4f,$54,$48,$00
Sex_use_txt:
	dc.b	$01,$01,$47,$45,$4e,$44,$45,$52,$3a,$01,$0f,$00
Hands_txt:
	dc.b	$48,$41,$4e,$44,$53,$20,$20,$20,$3a,$20,$00
Fingers_txt:
	dc.b	$46,$49,$4e,$47,$45,$52,$53,$20,$3a,$20,$00
Classes_txt:
	dc.b	$01,$01,$2d,$2d,$2d,$2d,$20,$43,$4c,$41,$53,$53,$45,$53,$20,$2d
	dc.b	$2d,$2d,$2d,$01,$0f,$00
Damage_txt:
	dc.b	$44,$41,$4d,$41,$47,$45,$20,$20,$3a,$20,$00
Protection_txt:
	dc.b	$53,$48,$49,$45,$4c,$44,$20,$20,$3a,$20,$00
Weight2_txt:
	dc.b	$01,$01,$57,$45,$49,$47,$48,$54,$20,$3a,$20,$01,$0f,$00
Attr2_txt:
	dc.b	$01,$01,$41,$54,$54,$52,$49,$42,$55,$54,$45,$01,$0f,$00
Skill2_txt:
	dc.b	$01,$01,$53,$4b,$49,$4c,$4c,$01,$0f,$00
Magic_txt:
	dc.b	$01,$01,$4d,$41,$47,$49,$43,$01,$0f,$00
D_2db92:
	dc.b	$01,$09,$43,$55,$52,$53,$45,$44,$01,$0f,$00
D_2db9d:
	dc.b	$01,$0f,$02,$ff,$44,$49,$41,$4c,$4f,$47,$55,$45,$00
XP_txt:
	dc.b	$45,$50,$3a,$20,$20,$20,$20,$20,$20,$20,$20,$20,$00
LP_txt:
	dc.b	$4c,$50,$20,$3a,$20
D_2dbbc:
	dc.b	$20,$20,$20,$2f
D_2dbc0:
	dc.b	$20,$20,$20,$00
PP_txt:
	dc.b	$53,$50,$20,$3a,$20
D_2dbc9:
	dc.b	$20,$20,$20,$2f
D_2dbcd:
	dc.b	$20,$20,$20,$00
SLP_txt:
	dc.b	$53,$4c,$50,$3a,$20
D_2dbd6:
	dc.b	$20,$20,$20,$00
ProtDam_txt:
	dc.b	$3a,$20,$20,$20,$00
Skill_txt:
	dc.b	$20,$20,$25,$2f,$20,$20,$25,$00
Attr_txt:
	dc.b	$20,$20,$20,$2f,$20,$20,$20,$00
D_2dbef:
	dc.b	$01,$00,$02,$02,$20,$20,$20,$20,$4b,$47,$2f,$20,$20,$20,$20,$4b
	dc.b	$47,$00
Gram_txt:
	dc.b	$20,$47,$52,$00
LPMax_txt:
	dc.b	$4c,$50,$2d,$4d,$41,$58,$3a,$00
PPMax_txt:
	dc.b	$50,$50,$2d,$4d,$41,$58,$3a,$00
MBW_txt:
	dc.b	$20,$4d,$2d,$42,$2d,$57,$3a,$00
MBA_txt:
	dc.b	$20,$4d,$2d,$42,$2d,$41,$3a,$00
Tween_txt:
	dc.b	$20,$3a,$20,$00
Tween2_txt:
	dc.b	$20,$28,$00
Infinite_charges_txt:
	dc.b	$2a,$2a,$2a,$00
Tween3_txt:
	dc.b	$29,$00
Classname_pos_list:
	dc.b	$00,$b1,$00,$88,$00,$b1,$00,$8f,$00,$b1,$00,$96,$00,$b1,$00,$9d
	dc.b	$00,$e7,$00,$88,$00,$e7,$00,$8f,$00,$e7,$00,$96,$00,$e7,$00,$9d
D_2dc52:
	dc.b	$00,$00,$00,$00,$00,$12,$00,$0c,$00,$00,$00,$18,$00,$12,$00,$24
	dc.b	$00,$00,$00,$30
D_2dc66:
	dc.b	$00,$30,$00,$80
Object_pos_list:
	dc.b	$00,$10,$00,$51,$00,$30,$00,$51,$00,$50,$00,$51,$00,$10,$00,$71
	dc.b	$00,$30,$00,$71,$00,$50,$00,$71,$00,$10,$00,$91,$00,$30,$00,$91
	dc.b	$00,$50,$00,$91
D_2dc8e:
	dc.b	$00,$70,$00,$51,$00,$90,$00,$51,$00,$b0,$00,$51,$00,$70,$00,$71
	dc.b	$00,$90,$00,$71,$00,$b0,$00,$71,$00,$70,$00,$91,$00,$90,$00,$91
	dc.b	$00,$b0,$00,$91,$00,$70,$00,$b1,$00,$90,$00,$b1,$00,$b0,$00,$b1
	dc.b	$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
	dc.b	$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
	dc.b	$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
	dc.b	$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
	dc.b	$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
	dc.b	$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
	dc.b	$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
	dc.b	$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
D_2dd3e:
	dc.b	$00,$10,$00,$bf,$00,$51,$00,$c0
Sex_use_strings:
	dc.l	D_2db0f
	dc.l	D_2db03
	dc.l	D_2db08
Quant_index:
	dc.b	$00,$00
Quant_init_string:
	dc.b	$01
D_2dd55:
	dc.b	$00,$02,$ff,$00
Quant_block:
	dc.b	$00
Quant_count:
	dc.b	$01
Quant_cycles:
	dc.b	$0f,$0f,$0f,$0f,$0f,$0f,$0f,$02,$03,$04,$04,$04,$04,$04,$04,$04
	dc.b	$03,$02,$ff
D_2dd6e:
	dc.b	$00,$10,$00,$bf,$00,$31,$00,$40,$00,$10,$00,$32,$00,$b0,$00,$0e
	dc.b	$00,$0f,$00,$02
Curse_count:
	dc.b	$00,$01
D_2dd84:
	dc.b	$00,$1c,$00,$1a,$00,$16,$00,$00,$00,$00,$00,$00,$00,$14
D_2dd92:
	dc.b	$00,$20,$00,$50,$00,$c0,$00,$46,$00,$0f,$00,$02
SCSelW_PA:
	dc.b	$00,$20,$00,$50,$00,$80,$00,$31,$00,$0f,$00,$02
D_2ddaa:
	dc.b	$00,$30,$00,$38,$00,$a0,$00,$70,$00,$0f,$00,$03,$00,$30,$00,$34
	dc.b	$00,$30,$00,$3b,$00,$30,$00,$42,$00,$30,$00,$49,$00,$30,$00,$50
	dc.b	$00,$30,$00,$57,$00,$30,$00,$5e,$00,$30,$00,$65,$00,$30,$00,$6c
	dc.b	$00,$30,$00,$73,$00,$30,$00,$7a,$00,$30,$00,$81,$00,$30,$00,$88
	dc.b	$00,$30,$00,$8f,$00,$30,$00,$96,$00,$b0,$00,$34,$00,$b0,$00,$3b
	dc.b	$00,$b0,$00,$42,$00,$b0,$00,$49,$00,$b0,$00,$50,$00,$b0,$00,$57
	dc.b	$00,$b0,$00,$5e,$00,$b0,$00,$65,$00,$b0,$00,$6c,$00,$b0,$00,$73
	dc.b	$00,$b0,$00,$7a,$00,$b0,$00,$81,$00,$b0,$00,$88,$00,$b0,$00,$8f
	dc.b	$00,$b0,$00,$96
Load_area:
	dc.b	$00,$00,$01,$3f,$00,$01,$00,$23
RemCurse_MA:
UseItem_area:
	dc.b	$00,$10,$00,$5f,$00,$51,$00,$a0
Minimap_CIL:
	dc.b	$2e,$01,$2d,$04,$1e,$03,$30,$02,$2f,$00
	dc.l	Minimap_upleft
	dc.l	Minimap_up
	dc.l	Minimap_upright
	dc.l	Minimap_left
	dc.l	Minimap_exit
	dc.l	Minimap_right
	dc.l	Minimap_downleft
	dc.l	Minimap_down
	dc.l	Minimap_downright
D_2de6c:
	dc.b	$00,$60,$00,$b1,$00,$10,$00,$71,$00,$60,$00,$31,$00,$b0,$00,$71
D_2de7c:
	dc.l	D_2dec8
	dc.l	D_2ded2
	dc.l	D_2dedc
	dc.l	D_2dee7
	dc.l	D_2def3
	dc.l	D_2df03
	dc.l	D_2df10
	dc.l	D_2df1e
	dc.l	D_2df2d
	dc.l	D_2df36
	dc.l	D_2df45
	dc.l	D_2df53
	dc.l	D_2df5d
	dc.l	D_2df6c
	dc.l	D_2df7b
	dc.l	D_2df86
	dc.l	D_2df95
	dc.l	D_2df9d
	dc.l	D_2dfab
D_2dec8:
	dc.b	$43,$49,$54,$59,$20,$57,$41,$4c,$4b,$00
D_2ded2:
	dc.b	$48,$49,$47,$48,$20,$53,$45,$41,$53,$00
D_2dedc:
	dc.b	$48,$4f,$52,$53,$45,$20,$53,$4f,$4e,$47,$00
D_2dee7:
	dc.b	$46,$4c,$59,$49,$4e,$47,$20,$48,$49,$47,$48,$00
D_2def3:
	dc.b	$54,$52,$41,$56,$45,$4c,$4c,$45,$52,$53,$20,$54,$55,$4e,$45,$00
D_2df03:
	dc.b	$49,$52,$49,$53,$48,$20,$53,$50,$52,$49,$4e,$47,$00
D_2df10:
	dc.b	$47,$57,$45,$4e,$27,$53,$20,$4c,$41,$4d,$45,$4e,$54,$00
D_2df1e:
	dc.b	$45,$52,$49,$4b,$27,$53,$20,$52,$45,$56,$45,$4e,$47,$45,$00
D_2df2d:
	dc.b	$46,$41,$4e,$46,$41,$52,$45,$53,$00
D_2df36:
	dc.b	$4f,$44,$45,$20,$54,$4f,$20,$53,$43,$48,$4e,$49,$53,$4d,$00
D_2df45:
	dc.b	$4d,$49,$53,$54,$59,$20,$4f,$52,$43,$20,$48,$4f,$50,$00
D_2df53:
	dc.b	$44,$52,$45,$41,$4d,$43,$41,$56,$45,$00
D_2df5d:
	dc.b	$4d,$59,$53,$54,$49,$43,$20,$4d,$4f,$4d,$45,$4e,$54,$53,$00
D_2df6c:
	dc.b	$4c,$55,$52,$4b,$49,$4e,$47,$20,$48,$4f,$52,$52,$4f,$52,$00
D_2df7b:
	dc.b	$42,$41,$52,$44,$20,$44,$41,$4e,$43,$45,$00
D_2df86:
	dc.b	$4d,$49,$4e,$4f,$52,$20,$51,$55,$41,$52,$52,$45,$4c,$53,$00
D_2df95:
	dc.b	$4c,$55,$4c,$4c,$41,$42,$59,$00
D_2df9d:
	dc.b	$46,$55,$4e,$4b,$59,$20,$44,$55,$4e,$47,$45,$4f,$4e,$00
D_2dfab:
	dc.b	$48,$41,$53,$54,$41,$20,$4c,$41,$20,$56,$49,$53,$54,$41,$00
D_2dfba:
	dc.b	$00,$10,$00,$bf,$00,$a1,$00,$c0
D_2dfc2:
	dc.b	$00,$10,$00,$b1,$00,$b0,$00,$10,$00,$0f,$00,$02
D_2dfce:
	dc.b	$42,$38,$3b,$26,$44,$45,$24,$25,$0c,$00
	dc.l	T_16da0
	dc.b	$00,$00,$00,$00
	dc.l	Monster_actions
	dc.l	T_16c2e
	dc.l	T_15d2c
	dc.l	T_15d4c
	dc.l	T_16dde
	dc.l	T_16ed8
	dc.l	T_16f14
D_2dffc:
	dc.b	$00,$00,$05,$00,$04,$44,$03,$32,$01,$22,$05,$52,$05,$31,$04,$20
	dc.b	$03,$10,$01,$50,$00,$31,$02,$00
D_2e014:
	dc.b	$00,$00
D_2e016:
	dc.b	$00,$00,$00,$00,$06,$66,$05,$66,$04,$56,$03,$45,$01,$42,$04,$66
	dc.b	$03,$55,$04,$67,$03,$66,$06,$40,$03,$55,$02,$44,$01,$33,$01,$34
	dc.b	$00,$23,$04,$55,$05,$66,$04,$56,$01,$42,$01,$34,$00,$23,$04,$55
	dc.b	$05,$55,$06,$41,$00,$00,$02,$21,$03,$21,$00,$00,$03,$35,$02,$23
	dc.b	$01,$13,$01,$34,$00,$12,$04,$55,$05,$55,$02,$34,$00,$00,$01,$21
	dc.b	$05,$56,$00,$00,$01,$34,$00,$23,$04,$55
D_2e070:
	dc.b	$00,$d0,$01,$2f,$00,$31,$00,$80,$02,$00
	dc.l	Control_area
	dc.b	$00,$00,$00,$00
D_2e082:
	dc.b	$ff,$00,$00,$00,$07,$50,$03,$33,$02,$22,$01,$11,$07,$42,$06,$31
	dc.b	$02,$00,$05,$66,$03,$45,$07,$54,$06,$43,$05,$32,$04,$21,$03,$10
	dc.b	$07,$65,$24,$00
D_2e0a6:
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00
D_2e0c8:
	dc.b	$00,$02
	dc.l	D_2e0d2
	dc.l	D_2e282
D_2e0d2:
	dc.b	$00,$00,$00,$00,$01,$00,$00,$00,$00,$00,$ff,$00,$ff,$ff,$00,$ff
	dc.b	$00,$00,$00,$00,$00,$00,$01,$00,$01,$00,$00,$00,$fe,$00,$fe,$fe
	dc.b	$00,$fe,$00,$00,$00,$00,$00,$00,$02,$00,$02,$00,$00,$01,$fd,$00
	dc.b	$fd,$fe,$00,$fd,$01,$00,$00,$00,$01,$01,$03,$01,$03,$ff,$01,$00
	dc.b	$fc,$01,$fc,$fd,$01,$fc,$02,$01,$00,$00,$01,$02,$04,$01,$04,$ff
	dc.b	$01,$00,$fb,$01,$fb,$fd,$01,$fc,$03,$01,$00,$00,$01,$03,$04,$01
	dc.b	$05,$fe,$01,$00,$fa,$01,$fa,$fe,$01,$fc,$04,$01,$00,$00,$02,$04
	dc.b	$05,$02,$06,$fd,$02,$ff,$f9,$02,$f9,$fe,$02,$fc,$06,$02,$00,$00
	dc.b	$02,$06,$05,$02,$06,$fb,$02,$fe,$f8,$02,$f8,$ff,$02,$fd,$07,$02
	dc.b	$00,$00,$02,$07,$04,$02,$06,$fa,$02,$fc,$f7,$02,$f7,$00,$02,$fd
	dc.b	$08,$02,$00,$00,$03,$09,$04,$03,$06,$f8,$03,$fb,$f7,$03,$f6,$01
	dc.b	$03,$fe,$09,$03,$00,$00,$03,$00,$0b,$03,$0a,$03,$03,$06,$f7,$03
	dc.b	$f9,$f7,$03,$f5,$03,$03,$00,$00,$04,$01,$0b,$04,$0b,$02,$04,$05
	dc.b	$f5,$04,$f7,$f7,$04,$f5,$05,$04,$00,$00,$04,$03,$0c,$04,$0c,$00
	dc.b	$04,$04,$f3,$04,$f5,$f7,$04,$f5,$06,$04,$00,$00,$04,$05,$0d,$04
	dc.b	$0d,$ff,$04,$03,$f2,$04,$f4,$f8,$04,$f5,$08,$04,$00,$00,$05,$07
	dc.b	$0d,$05,$0e,$fd,$05,$01,$f1,$05,$f2,$f9,$05,$f5,$0a,$05,$00,$00
	dc.b	$05,$09,$0c,$05,$0f,$fb,$05,$ff,$f0,$05,$f0,$fb,$05,$f6,$0c,$05
	dc.b	$00,$00,$05,$0a,$0b,$05,$0e,$f9,$05,$fd,$f0,$05,$f0,$fd,$05,$f8
	dc.b	$0e,$05,$00,$00,$05,$0a,$08,$05,$0b,$f8,$05,$fc,$f2,$05,$f2,$ff
	dc.b	$05,$fa,$0d,$05,$00,$00,$04,$0a,$06,$04,$09,$f8,$04,$fb,$f4,$04
	dc.b	$f4,$00,$04,$fd,$0b,$04,$00,$00,$03,$09,$04,$03,$06,$f8,$03,$fb
	dc.b	$f7,$03,$f6,$01,$03,$fe,$09,$03,$00,$00,$02,$00,$08,$02,$07,$02
	dc.b	$02,$04,$f9,$02,$fb,$f9,$02,$f8,$02,$02,$00,$00,$02,$00,$05,$02
	dc.b	$05,$01,$02,$02,$fa,$02,$fb,$fb,$02,$fa,$02,$02,$00,$00,$01,$00
	dc.b	$03,$01,$03,$00,$01,$01,$fc,$01,$fc,$fd,$01,$fc,$02,$01,$00,$00
	dc.b	$00,$00,$01,$00,$01,$ff,$00,$00,$fe,$00,$fe,$fe,$00,$fe,$01,$00
D_2e282:
	dc.b	$00,$01,$00,$00,$ff,$00,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$00,$00
	dc.b	$ff,$00,$00,$01,$00,$01,$fe,$00,$fe,$ff,$00,$ff,$00,$00,$ff,$ff
	dc.b	$00,$00,$ff,$00,$01,$02,$00,$01,$fd,$00,$fd,$ff,$00,$ff,$01,$00
	dc.b	$ff,$fe,$00,$01,$ff,$00,$02,$03,$01,$01,$fc,$01,$fc,$00,$01,$fe
	dc.b	$01,$01,$ff,$fe,$01,$01,$00,$01,$03,$03,$01,$01,$fb,$01,$fb,$01
	dc.b	$01,$fe,$01,$01,$ff,$fd,$01,$02,$00,$01,$05,$03,$01,$00,$fa,$01
	dc.b	$fa,$02,$01,$fd,$01,$01,$00,$fd,$01,$02,$01,$01,$06,$02,$02,$fe
	dc.b	$f9,$02,$fa,$04,$02,$fc,$01,$02,$00,$fc,$02,$02,$02,$02,$07,$00
	dc.b	$02,$fc,$f8,$02,$fb,$06,$02,$fc,$00,$02,$01,$fc,$02,$02,$03,$02
	dc.b	$08,$ff,$02,$fa,$f8,$02,$fc,$08,$02,$fb,$ff,$02,$02,$fc,$02,$01
	dc.b	$04,$02,$09,$fc,$03,$f8,$f9,$03,$fd,$09,$03,$fb,$fe,$03,$03,$fc
	dc.b	$03,$01,$04,$03,$00,$0b,$03,$09,$fa,$03,$f6,$fa,$03,$ff,$05,$03
	dc.b	$fb,$fd,$03,$04,$fd,$03,$02,$0b,$04,$08,$f7,$04,$f4,$fc,$04,$fe
	dc.b	$05,$04,$fb,$fb,$04,$05,$fe,$04,$05,$0b,$04,$07,$f5,$04,$f3,$fe
	dc.b	$04,$fd,$05,$04,$fc,$fa,$04,$06,$ff,$04,$08,$0b,$04,$05,$f3,$04
	dc.b	$f2,$01,$04,$fb,$05,$04,$fd,$f9,$04,$06,$00,$04,$0b,$0a,$05,$03
	dc.b	$f1,$05,$f1,$04,$05,$fa,$05,$05,$fe,$f8,$05,$07,$02,$05,$0d,$07
	dc.b	$05,$00,$f0,$05,$f2,$08,$05,$f9,$03,$05,$00,$f8,$05,$06,$04,$05
	dc.b	$0f,$04,$05,$fc,$f0,$05,$f4,$0a,$05,$f8,$02,$05,$01,$f8,$05,$05
	dc.b	$05,$05,$0d,$01,$05,$fa,$f3,$05,$f7,$0b,$05,$f9,$00,$05,$02,$f9
	dc.b	$05,$04,$05,$05,$0b,$fe,$04,$f8,$f6,$04,$fb,$0a,$04,$fa,$ff,$04
	dc.b	$03,$fb,$04,$02,$05,$04,$09,$fc,$03,$f8,$f9,$03,$fd,$09,$03,$fb
	dc.b	$fe,$03,$03,$fc,$03,$01,$04,$03,$00,$08,$02,$06,$fb,$02,$f9,$fc
	dc.b	$02,$ff,$04,$02,$fc,$fd,$02,$03,$fe,$02,$01,$05,$02,$04,$fb,$02
	dc.b	$fa,$fe,$02,$ff,$02,$02,$fd,$fd,$02,$02,$ff,$02,$01,$03,$01,$02
	dc.b	$fc,$01,$fc,$ff,$01,$ff,$01,$01,$fe,$fe,$01,$01,$ff,$01,$01,$01
	dc.b	$00,$00,$fe,$00,$fe,$00,$00,$ff,$00,$00,$ff,$ff,$00,$00,$00,$00
D_2e432:
	dc.b	$20,$00
D_2e434:
	dc.b	$20,$3a,$20,$00
D_2e438:
	dc.b	$3a,$0d
; Black spells: 6 bytes per spell (minimum, maximum, animation) behind an unused entry with the immunity bits of the elements.
Spell_damage_table:
	dc.b	$00,$00
D_2e43c:
	dc.b	$00,$02,$01,$03,$00,$01,$00,$02,$00,$0c,$00,$02,$00,$04,$00,$07
	dc.b	$00,$04,$00,$08,$00,$02,$00,$08,$00,$10,$00,$0f,$00,$10,$00,$20
	dc.b	$00,$08,$00,$02,$00,$04,$00,$09,$00,$04,$00,$08,$00,$05,$00,$08
	dc.b	$00,$10,$00,$01,$00,$10,$00,$20,$00,$05,$00,$20,$00,$40,$00,$01
	dc.b	$00,$04,$00,$08,$00,$06,$00,$08,$00,$10,$00,$02,$00,$10,$00,$20
	dc.b	$00,$06,$00,$20,$00,$40,$00,$07,$00,$40,$00,$80,$00,$09,$00,$08
	dc.b	$00,$10,$00,$04,$00,$10,$00,$20,$00,$08,$00,$20,$00,$40,$00,$0e
	dc.b	$00,$40,$00,$80,$00,$03,$00,$80,$01,$00,$00,$04
D_2e4b8:
	dc.b	$0d,$00
D_2e4ba:
	dc.b	$21,$23,$1e,$01,$12,$32,$02,$14,$33,$00
	dc.l	Transfer_item_MOBJC
	dc.l	T_08f2c
	dc.l	T_19c5c
	dc.l	T_19d68
	dc.l	T_19dda
	dc.l	T_19dac
	dc.l	T_19d8a
	dc.l	T_19ecc
	dc.l	T_19eac
D_2e4e8:
	dc.b	$78,$20,$00,$00
D_2e4ec:
	dc.b	$00,$00,$02,$23,$03,$33,$02,$22,$01,$11,$06,$43,$05,$32,$04,$21
	dc.b	$03,$10,$07,$63,$06,$52,$05,$41,$04,$31,$03,$20,$02,$10,$07,$77
D_2e50c:
	dc.l	D_2e523
D_2e510:
	dc.b	$4b,$61,$72,$73,$74,$65,$6e,$20,$69,$73,$74,$20,$64,$6f,$6f,$66
	dc.b	$20,$21,$00
D_2e523:
	dc.b	$73,$63,$68,$6e,$69,$73,$6d,$00,$00
D_2e52c:
	dc.l	D_2e569
	dc.l	D_2e58a
	dc.l	D_2e5cd
	dc.l	D_2e616
	dc.l	D_2e645
	dc.l	D_2e69e
	dc.l	D_2e6cf
	dc.l	D_2e72f
D_2e54c:
	dc.b	$0d,$0d,$50,$72,$65,$73,$73,$20,$61,$6e,$79,$20,$6b,$65,$79,$20
	dc.b	$74,$6f,$20,$63,$6f,$6e,$74,$69,$6e,$75,$65,$2e,$00
D_2e569:
	dc.b	$59,$6f,$75,$20,$41,$4c,$4d,$4f,$53,$54,$20,$66,$6f,$75,$6e,$64
	dc.b	$20,$74,$68,$65,$20,$70,$61,$73,$73,$77,$6f,$72,$64,$2e,$2e,$2e
	dc.b	$00
D_2e58a:
	dc.b	$44,$6f,$20,$79,$6f,$75,$20,$72,$65,$61,$6c,$6c,$79,$20,$74,$68
	dc.b	$69,$6e,$6b,$20,$65,$6e,$74,$65,$72,$69,$6e,$67,$20,$27,$53,$43
	dc.b	$48,$4e,$49,$53,$4d,$27,$20,$74,$77,$69,$63,$65,$0d,$77,$69,$6c
	dc.b	$6c,$20,$62,$72,$69,$6e,$67,$20,$61,$6e,$79,$74,$68,$69,$6e,$67
	dc.b	$20,$3f,$00
D_2e5cd:
	dc.b	$4c,$6f,$6f,$6b,$2c,$20,$6e,$6f,$74,$68,$69,$6e,$67,$20,$77,$69
	dc.b	$6c,$6c,$20,$68,$61,$70,$70,$65,$6e,$2c,$20,$6e,$6f,$20,$6d,$61
	dc.b	$74,$74,$65,$72,$20,$48,$4f,$57,$20,$6d,$61,$6e,$79,$20,$74,$69
	dc.b	$6d,$65,$73,$20,$79,$6f,$75,$0d,$65,$6e,$74,$65,$72,$20,$27,$53
	dc.b	$43,$48,$4e,$49,$53,$4d,$27,$2e,$00
D_2e616:
	dc.b	$48,$6f,$77,$20,$6d,$61,$6e,$79,$20,$74,$65,$78,$74,$73,$20,$64
	dc.b	$6f,$20,$79,$6f,$75,$20,$74,$68,$69,$6e,$6b,$20,$49,$27,$76,$65
	dc.b	$20,$67,$6f,$74,$20,$69,$6e,$20,$68,$65,$72,$65,$20,$3f,$00
D_2e645:
	dc.b	$41,$6c,$72,$69,$67,$68,$74,$2c,$20,$79,$6f,$75,$20,$77,$69,$6e
	dc.b	$2e,$20,$49,$66,$20,$79,$6f,$75,$20,$65,$6e,$74,$65,$72,$20,$27
	dc.b	$53,$43,$48,$4e,$49,$53,$4d,$27,$20,$6f,$6e,$65,$0d,$6d,$6f,$72
	dc.b	$65,$20,$74,$69,$6d,$65,$2c,$20,$74,$68,$65,$20,$63,$68,$65,$61
	dc.b	$74,$6d,$6f,$64,$65,$20,$77,$69,$6c,$6c,$20,$62,$65,$20,$61,$63
	dc.b	$74,$69,$76,$61,$74,$65,$64,$2e,$00
D_2e69e:
	dc.b	$46,$6f,$6f,$6c,$65,$64,$20,$79,$6f,$75,$21,$0d,$0d,$28,$49,$20
	dc.b	$61,$64,$6d,$69,$74,$20,$74,$68,$69,$73,$20,$77,$61,$73,$20,$61
	dc.b	$20,$76,$65,$72,$79,$20,$62,$61,$64,$20,$6a,$6f,$6b,$65,$2e,$29
	dc.b	$00
D_2e6cf:
	dc.b	$59,$6f,$75,$20,$61,$72,$65,$20,$6f,$62,$76,$69,$6f,$75,$73,$6c
	dc.b	$79,$20,$64,$65,$72,$61,$6e,$67,$65,$64,$2e,$20,$50,$6c,$65,$61
	dc.b	$73,$65,$20,$73,$74,$6f,$70,$20,$65,$6e,$74,$65,$72,$69,$6e,$67
	dc.b	$0d,$27,$53,$43,$48,$4e,$49,$53,$4d,$27,$20,$6f,$72,$20,$49,$27
	dc.b	$6c,$6c,$20,$6b,$69,$6c,$6c,$20,$61,$6c,$6c,$20,$79,$6f,$75,$72
	dc.b	$20,$70,$61,$72,$74,$79,$20,$6d,$65,$6d,$62,$65,$72,$73,$2e,$00
D_2e72f:
	dc.b	$54,$68,$61,$74,$27,$73,$20,$69,$74,$21,$20,$4e,$6f,$20,$6d,$6f
	dc.b	$72,$65,$20,$27,$53,$43,$48,$4e,$49,$53,$4d,$27,$73,$20,$21,$21
	dc.b	$21,$00,$00
; Pointers to the music modules of the songs 1-19 (several songs use the same module).
Song_table:
	dc.l	D_4aa1c
	dc.l	D_4b02e
	dc.l	D_4b5ca
	dc.l	D_4baa2
	dc.l	D_4c0d8
	dc.l	D_4ce44
	dc.l	D_4c698
	dc.l	D_4ce44
	dc.l	D_4d45e
	dc.l	D_4dc06
	dc.l	D_4e6bc
	dc.l	D_4eca8
	dc.l	D_4f12c
	dc.l	D_4f52c
	dc.l	D_4dc06
	dc.l	D_4faee
	dc.l	D_507da
	dc.l	D_50d70
	dc.l	D_51322
Dir_offset:
	dc.b	$00,$ff,$01,$00,$00,$01,$ff,$00
D_2e7a6:
	dc.b	$00,$00,$01,$3f,$00,$00,$00,$c7
D_2e7ae:
	dc.b	$00,$00,$00,$00,$01,$3f,$00,$c7,$00,$0f,$00,$00
PlacesExit_MA:
	dc.b	$00,$40,$00,$df,$00,$4c,$00,$7b
D_2e7c2:
	dc.b	$00,$40,$00,$4c,$00,$a0,$00,$30,$00,$0f,$00,$02
Temp_number:
	dc.b	$01,$09,$02,$ff,$20,$20,$00,$00
ET_Enter_modification_1:
	dc.b	$5b,$20,$45,$6e,$74,$65,$72,$5f,$6d,$6f,$64,$69,$66,$69,$63,$61
	dc.b	$74,$69,$6f,$6e,$20,$5d,$20,$3a,$20,$54,$6f,$6f,$20,$6d,$75,$63
	dc.b	$68,$20,$6d,$6f,$64,$69,$66,$69,$63,$61,$74,$69,$6f,$6e,$73,$20
	dc.b	$21,$21,$21,$0d,$00
D_2e80b:
	dc.b	$5b,$20,$53,$65,$74,$5f,$6e,$65,$77,$5f,$74,$72,$61,$76,$65,$6c
	dc.b	$5f,$6d,$6f,$64,$65,$20,$5d,$20,$3a,$20,$49,$6e,$70,$75,$74,$20
	dc.b	$6f,$75,$74,$20,$6f,$66,$20,$72,$61,$6e,$67,$65,$20,$21,$21,$21
	dc.b	$0d,$00
D_2e83d:
	dc.b	$5b,$20,$53,$65,$74,$5f,$6d,$75,$73,$69,$63,$20,$5d,$20,$3a,$20
	dc.b	$53,$6f,$6e,$67,$20,$6e,$75,$6d,$62,$65,$72,$20,$74,$6f,$6f,$20
	dc.b	$68,$69,$67,$68,$20,$21,$21,$21,$0d,$00
D_2e867:
	dc.b	$5b,$20,$41,$4d,$42,$45,$52,$53,$54,$41,$52,$20,$53,$54,$41,$54
	dc.b	$55,$53,$20,$53,$43,$52,$45,$45,$4e,$20,$5d,$0d,$00
D_2e884:
	dc.b	$20,$20,$4d,$61,$70,$20,$6e,$75,$6d,$62,$65,$72,$20,$3a,$20,$00
D_2e894:
	dc.b	$58,$20,$63,$6f,$6f,$72,$64,$69,$6e,$61,$74,$65,$20,$3a,$20,$00
D_2e8a4:
	dc.b	$59,$20,$63,$6f,$6f,$72,$64,$69,$6e,$61,$74,$65,$20,$3a,$20,$00
D_2e8b4:
	dc.b	$56,$69,$65,$77,$20,$64,$69,$72,$65,$63,$74,$69,$6f,$6e,$20,$3a
	dc.b	$20,$00
D_2e8c6:
	dc.b	$20,$20,$20,$54,$72,$61,$76,$65,$6c,$20,$6d,$6f,$64,$65,$20,$3a
	dc.b	$20,$00
D_2e8d8:
	dc.b	$57,$6f,$72,$6c,$64,$20,$58,$20,$3a,$20,$00
D_2e8e3:
	dc.b	$57,$6f,$72,$6c,$64,$20,$59,$20,$3a,$20,$00
D_2e8ee:
	dc.b	$20,$20,$59,$65,$61,$72,$20,$3a,$20,$00
D_2e8f8:
	dc.b	$20,$4d,$6f,$6e,$74,$68,$20,$3a,$20,$00
D_2e902:
	dc.b	$20,$20,$20,$44,$61,$79,$20,$3a,$20,$00
D_2e90c:
	dc.b	$20,$20,$48,$6f,$75,$72,$20,$3a,$20,$00
D_2e916:
	dc.b	$4d,$69,$6e,$75,$74,$65,$20,$3a,$20,$00
D_2e920:
	dc.b	$20,$46,$72,$61,$6d,$65,$20,$3a,$20,$00
D_2e92a:
	dc.b	$4e,$75,$6d,$62,$65,$72,$20,$6f,$66,$20,$6d,$65,$6d,$62,$65,$72
	dc.b	$73,$20,$69,$6e,$20,$70,$61,$72,$74,$79,$20,$3a,$20,$00
D_2e948:
	dc.b	$5b,$20,$50,$72,$65,$73,$73,$20,$61,$6e,$79,$20,$6b,$65,$79,$20
	dc.b	$74,$6f,$20,$65,$78,$69,$74,$20,$5d,$0d,$00
D_2e963:
	dc.b	$5b,$20,$56,$49,$45,$57,$20,$46,$52,$45,$45,$20,$4d,$45,$4d,$4f
	dc.b	$52,$59,$20,$5d,$0d,$00
D_2e979:
	dc.b	$20,$20,$20,$20,$20,$20,$20,$20,$53,$69,$7a,$65,$20,$6f,$66,$20
	dc.b	$66,$72,$65,$65,$20,$6d,$65,$6d,$6f,$72,$79,$20,$3a,$20,$00
D_2e998:
	dc.b	$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
	dc.b	$4d,$65,$6d,$6f,$72,$79,$20,$75,$73,$65,$64,$20,$3a,$20,$00
D_2e9b7:
	dc.b	$20,$20,$20,$20,$20,$20,$20,$53,$69,$7a,$65,$20,$6f,$66,$20,$54
	dc.b	$45,$58,$54,$20,$73,$65,$67,$6d,$65,$6e,$74,$20,$3a,$20,$00
D_2e9d6:
	dc.b	$20,$20,$20,$20,$20,$20,$20,$53,$69,$7a,$65,$20,$6f,$66,$20,$44
	dc.b	$41,$54,$41,$20,$73,$65,$67,$6d,$65,$6e,$74,$20,$3a,$20,$00
D_2e9f5:
	dc.b	$20,$20,$20,$20,$20,$20,$20,$53,$69,$7a,$65,$20,$6f,$66,$20,$20
	dc.b	$42,$53,$53,$20,$73,$65,$67,$6d,$65,$6e,$74,$20,$3a,$20,$00
D_2ea14:
	dc.b	$20,$20,$20,$20,$20,$20,$54,$6f,$74,$61,$6c,$20,$73,$69,$7a,$65
	dc.b	$20,$6f,$66,$20,$70,$72,$6f,$67,$72,$61,$6d,$20,$3a,$20,$00
D_2ea33:
	dc.b	$54,$6f,$74,$61,$6c,$20,$61,$6d,$6f,$75,$6e,$74,$20,$6f,$66,$20
	dc.b	$6d,$65,$6d,$6f,$72,$79,$20,$75,$73,$65,$64,$20,$3a,$20,$00
D_2ea52:
	dc.b	$5b,$20,$50,$72,$65,$73,$73,$20,$61,$6e,$79,$20,$6b,$65,$79,$20
	dc.b	$74,$6f,$20,$65,$78,$69,$74,$20,$5d,$0d,$00
D_2ea6d:
	dc.b	$5b,$20,$56,$49,$45,$57,$20,$4d,$4f,$44,$49,$46,$49,$43,$41,$54
	dc.b	$49,$4f,$4e,$20,$49,$4e,$46,$4f,$20,$5d,$0d,$00
D_2ea89:
	dc.b	$4e,$75,$6d,$62,$65,$72,$20,$6f,$66,$20,$6d,$6f,$64,$69,$66,$69
	dc.b	$63,$61,$74,$69,$6f,$6e,$73,$20,$3a,$20,$00
D_2eaa4:
	dc.b	$3e,$20,$00
D_2eaa7:
	dc.b	$2c,$00
D_2eaa9:
	dc.b	$2c,$00
D_2eaab:
	dc.b	$2c,$00
D_2eaad:
	dc.b	$5b,$20,$50,$72,$65,$73,$73,$20,$61,$6e,$79,$20,$6b,$65,$79,$20
	dc.b	$74,$6f,$20,$65,$78,$69,$74,$20,$5d,$0d,$00
D_2eac8:
	dc.b	$5b,$20,$56,$49,$45,$57,$20,$4d,$4f,$44,$55,$4c,$45,$20,$53,$54
	dc.b	$41,$43,$4b,$20,$5d,$0d,$00
D_2eadf:
	dc.b	$5b,$20,$50,$72,$65,$73,$73,$20,$61,$6e,$79,$20,$6b,$65,$79,$20
	dc.b	$74,$6f,$20,$65,$78,$69,$74,$20,$5d,$0d,$00
D_2eafa:
	dc.b	$5b,$20,$49,$4e,$43,$52,$45,$41,$53,$45,$20,$45,$58,$50,$45,$52
	dc.b	$49,$45,$4e,$43,$45,$20,$50,$4f,$49,$4e,$54,$53,$20,$5d,$0d,$00
D_2eb1a:
	dc.b	$43,$75,$72,$72,$65,$6e,$74,$20,$65,$78,$70,$65,$72,$69,$65,$6e
	dc.b	$63,$65,$20,$70,$6f,$69,$6e,$74,$73,$20,$3a,$20,$00
D_2eb37:
	dc.b	$45,$6e,$74,$65,$72,$20,$65,$78,$74,$72,$61,$20,$61,$6d,$6f,$75
	dc.b	$6e,$74,$20,$3a,$20,$00
D_2eb4d:
	dc.b	$5b,$20,$43,$48,$41,$4e,$47,$45,$20,$4d,$41,$50,$20,$5d,$0d,$00
D_2eb5d:
	dc.b	$45,$6e,$74,$65,$72,$20,$6e,$65,$77,$20,$6d,$61,$70,$20,$3a,$20
	dc.b	$00
D_2eb6e:
	dc.b	$5b,$20,$53,$41,$56,$45,$20,$4e,$45,$4f,$20,$50,$49,$43,$54,$55
	dc.b	$52,$45,$20,$5d,$0d,$00
D_2eb84:
	dc.b	$45,$6e,$74,$65,$72,$20,$34,$2d,$64,$69,$67,$69,$74,$20,$69,$64
	dc.b	$65,$6e,$74,$69,$66,$69,$65,$72,$20,$28,$27,$41,$4d,$42,$52,$3f
	dc.b	$3f,$3f,$3f,$2e,$4e,$45,$4f,$27,$29,$20,$3a,$20,$00
D_2ebb1:
	dc.b	$43,$72,$65,$61,$74,$69,$6e,$67,$20,$70,$69,$63,$74,$75,$72,$65
	dc.b	$2e,$2e,$2e,$0d,$00
D_2ebc6:
	dc.b	$50,$69,$63,$74,$75,$72,$65,$20,$68,$61,$73,$20,$62,$65,$65,$6e
	dc.b	$20,$73,$61,$76,$65,$64,$2e,$0d,$00
D_2ebdf:
	dc.b	$43,$72,$65,$61,$74,$69,$6e,$67,$20,$72,$61,$73,$74,$65,$72,$20
	dc.b	$66,$69,$6c,$65,$2e,$2e,$2e,$0d,$00
D_2ebf8:
	dc.b	$52,$61,$73,$74,$65,$72,$2d,$66,$69,$6c,$65,$20,$68,$61,$73,$20
	dc.b	$62,$65,$65,$6e,$20,$73,$61,$76,$65,$64,$2e,$0d,$00
D_2ec15:
	dc.b	$5b,$20,$50,$72,$65,$73,$73,$20,$61,$6e,$79,$20,$6b,$65,$79,$20
	dc.b	$74,$6f,$20,$65,$78,$69,$74,$20,$5d,$0d,$00
D_2ec30:
	dc.b	$5b,$20,$57,$65,$69,$67,$68,$74,$20,$63,$68,$65,$63,$6b,$20,$5d
	dc.b	$0d,$00
D_2ec42:
	dc.b	$4d,$65,$6d,$62,$65,$72,$20,$3a,$20,$0d,$00
D_2ec4d:
	dc.b	$63,$61,$72,$72,$69,$65,$73,$20,$61,$20,$66,$61,$6c,$73,$65,$20
	dc.b	$77,$65,$69,$67,$68,$74,$20,$3a,$0d,$00
D_2ec67:
	dc.b	$20,$20,$20,$20,$53,$74,$6f,$72,$65,$64,$20,$77,$65,$69,$67,$68
	dc.b	$74,$20,$3a,$20,$00
D_2ec7c:
	dc.b	$43,$61,$6c,$63,$75,$6c,$61,$74,$65,$64,$20,$77,$65,$69,$67,$68
	dc.b	$74,$20,$3a,$20,$00
D_2ec91:
	dc.b	$5b,$20,$50,$72,$65,$73,$73,$20,$61,$6e,$79,$20,$6b,$65,$79,$20
	dc.b	$74,$6f,$20,$65,$78,$69,$74,$20,$5d,$0d,$00
D_2ecac:
	dc.b	$5b,$20,$49,$4e,$43,$52,$45,$41,$53,$45,$20,$47,$4f,$4c,$44,$20
	dc.b	$43,$4f,$49,$4e,$53,$20,$5d,$0d,$00
D_2ecc5:
	dc.b	$43,$75,$72,$72,$65,$6e,$74,$20,$67,$6f,$6c,$64,$20,$63,$6f,$69
	dc.b	$6e,$73,$20,$3a,$20,$00
D_2ecdb:
	dc.b	$45,$6e,$74,$65,$72,$20,$65,$78,$74,$72,$61,$20,$61,$6d,$6f,$75
	dc.b	$6e,$74,$20,$3a,$20,$00
D_2ecf1:
	dc.b	$5b,$20,$56,$49,$45,$57,$20,$45,$56,$45,$4e,$54,$20,$44,$41,$54
	dc.b	$41,$20,$5d,$0d,$00
D_2ed06:
	dc.b	$44,$61,$74,$61,$20,$31,$20,$3a,$20,$00
D_2ed10:
	dc.b	$44,$61,$74,$61,$20,$32,$20,$3a,$20,$00
D_2ed1a:
	dc.b	$44,$61,$74,$61,$20,$33,$20,$3a,$20,$00
D_2ed24:
	dc.b	$44,$61,$74,$61,$20,$34,$20,$3a,$20,$00
D_2ed2e:
	dc.b	$44,$61,$74,$61,$20,$35,$20,$3a,$20,$00
D_2ed38:
	dc.b	$44,$61,$74,$61,$20,$36,$20,$3a,$20,$00
D_2ed42:
	dc.b	$44,$61,$74,$61,$20,$37,$20,$3a,$20,$00
D_2ed4c:
	dc.b	$44,$61,$74,$61,$20,$38,$20,$3a,$20,$00
D_2ed56:
	dc.b	$5b,$20,$50,$72,$65,$73,$73,$20,$61,$6e,$79,$20,$6b,$65,$79,$20
	dc.b	$74,$6f,$20,$65,$78,$69,$74,$20,$5d,$0d,$00
D_2ed71:
	dc.b	$41,$63,$74,$69,$76,$65,$20,$6d,$65,$6d,$62,$65,$72,$20,$3a,$20
	dc.b	$00
D_2ed82:
	dc.b	$4d,$65,$6d,$6f,$72,$79,$20,$69,$73,$20,$6e,$6f,$74,$20,$4f,$4b
	dc.b	$20,$21,$0d,$00
D_2ed96:
	dc.b	$44,$69,$66,$66,$65,$72,$65,$6e,$63,$65,$20,$3a,$20,$00
D_2eda4:
	dc.b	$4d,$65,$6d,$6f,$72,$79,$20,$69,$73,$20,$4f,$4b,$2e,$0d,$00
ET_Prepare_3D_map_1:
	dc.b	$5b,$20,$50,$72,$65,$70,$61,$72,$65,$5f,$33,$44,$5f,$6d,$61,$70
	dc.b	$20,$5d,$20,$3a,$20,$45,$72,$72,$6f,$72,$20,$69,$6e,$20,$4c,$41
	dc.b	$42,$5f,$44,$41,$54,$41,$20,$21,$21,$21,$0d,$00
ET_Show_layout_1:
	dc.b	$5b,$20,$53,$68,$6f,$77,$5f,$6c,$61,$79,$6f,$75,$74,$20,$5d,$20
	dc.b	$3a,$20,$49,$6c,$6c,$65,$67,$61,$6c,$20,$69,$6e,$70,$75,$74,$20
	dc.b	$21,$21,$21,$0d,$00
D_2ee04:
	dc.b	$5b,$20,$46,$69,$6e,$64,$5f,$77,$6f,$72,$64,$20,$5d,$20,$3a,$20
	dc.b	$57,$6f,$72,$64,$20,$6e,$75,$6d,$62,$65,$72,$20,$74,$6f,$6f,$20
	dc.b	$68,$69,$67,$68,$20,$21,$21,$21,$0d,$00
D_2ee2e:
	dc.b	$5b,$20,$46,$69,$6e,$64,$5f,$77,$6f,$72,$64,$20,$5d,$20,$3a,$20
	dc.b	$49,$6c,$6c,$65,$67,$61,$6c,$20,$77,$6f,$72,$64,$20,$6c,$65,$6e
	dc.b	$67,$74,$68,$20,$21,$21,$21,$0d,$00
ET_Calc_textblock_address_1:
	dc.b	$5b,$20,$43,$61,$6c,$63,$5f,$74,$65,$78,$74,$62,$6c,$6f,$63,$6b
	dc.b	$5f,$61,$64,$64,$72,$65,$73,$73,$20,$5d,$20,$3a,$20,$49,$6c,$6c
	dc.b	$65,$67,$61,$6c,$20,$74,$65,$78,$74,$62,$6c,$6f,$63,$6b,$20,$6e
	dc.b	$75,$6d,$62,$65,$72,$20,$21,$21,$21,$0d,$00
ET_Push_PA_1:
	dc.b	$5b,$20,$50,$75,$73,$68,$5f,$50,$41,$20,$5d,$20,$3a,$20,$50,$41
	dc.b	$20,$53,$74,$61,$63,$6b,$20,$6f,$76,$65,$72,$66,$6c,$6f,$77,$20
	dc.b	$21,$21,$21,$0d,$00
ET_Pop_PA_1:
	dc.b	$5b,$20,$50,$6f,$70,$5f,$50,$41,$20,$5d,$20,$3a,$20,$50,$41,$20
	dc.b	$53,$74,$61,$63,$6b,$20,$75,$6e,$64,$65,$72,$66,$6c,$6f,$77,$20
	dc.b	$21,$21,$21,$0d,$00
D_2eedc:
	dc.b	$5b,$20,$48,$61,$6e,$64,$6c,$65,$5f,$65,$76,$65,$6e,$74,$20,$5d
	dc.b	$20,$3a,$20,$49,$6c,$6c,$65,$67,$61,$6c,$20,$65,$76,$65,$6e,$74
	dc.b	$20,$6e,$75,$6d,$62,$65,$72,$20,$21,$21,$21,$0d,$00
D_2ef09:
	dc.b	$5b,$20,$50,$6c,$61,$63,$65,$73,$20,$5d,$20,$3a,$20,$49,$6c,$6c
	dc.b	$65,$67,$61,$6c,$20,$70,$6c,$61,$63,$65,$20,$74,$79,$70,$65,$20
	dc.b	$21,$21,$21,$0d,$00
ET_Create_transport_1:
	dc.b	$5b,$20,$43,$72,$65,$61,$74,$65,$5f,$74,$72,$61,$6e,$73,$70,$6f
	dc.b	$72,$74,$20,$5d,$20,$3a,$20,$4e,$6f,$20,$73,$6c,$6f,$74,$20,$66
	dc.b	$72,$65,$65,$20,$21,$21,$21,$0d,$00
ET_Item_res_1:
	dc.b	$5b,$20,$49,$74,$65,$6d,$5f,$72,$65,$73,$20,$5d,$20,$3a,$20,$4c
	dc.b	$6f,$67,$69,$63,$61,$6c,$20,$65,$72,$72,$6f,$72,$20,$21,$20,$43
	dc.b	$6f,$6e,$74,$61,$63,$74,$20,$74,$68,$65,$20,$67,$61,$6d,$65,$20
	dc.b	$64,$65,$73,$69,$67,$6e,$65,$72,$20,$21,$0d,$00
D_2ef93:
	dc.b	$5b,$20,$43,$68,$61,$6e,$67,$65,$5f,$74,$72,$61,$76,$65,$6c,$5f
	dc.b	$6d,$6f,$64,$65,$20,$5d,$20,$3a,$20,$4e,$6f,$20,$73,$6c,$6f,$74
	dc.b	$20,$66,$72,$65,$65,$20,$21,$21,$21,$0d,$00
D_2efbe:
	dc.b	$5b,$20,$50,$75,$73,$68,$5f,$4d,$6f,$64,$75,$6c,$65,$20,$5d,$20
	dc.b	$3a,$20,$4d,$6f,$64,$75,$6c,$65,$20,$73,$74,$61,$63,$6b,$20,$6f
	dc.b	$76,$65,$72,$66,$6c,$6f,$77,$20,$21,$21,$21,$0d,$00
D_2efeb:
	dc.b	$5b,$20,$50,$6f,$70,$5f,$4d,$6f,$64,$75,$6c,$65,$20,$5d,$20,$3a
	dc.b	$20,$4d,$6f,$64,$75,$6c,$65,$20,$73,$74,$61,$63,$6b,$20,$75,$6e
	dc.b	$64,$65,$72,$66,$6c,$6f,$77,$20,$21,$21,$21,$0d,$00
D_2f018:
	dc.b	$4f,$72,$64,$65,$72,$2d,$6d,$69,$73,$6d,$61,$74,$63,$68,$20,$2d
	dc.b	$3e,$20,$43,$61,$6e,$27,$74,$20,$70,$75,$74,$20,$6d,$6f,$72,$65
	dc.b	$20,$74,$68,$61,$6e,$20,$6f,$6e,$65,$20,$67,$75,$79,$20,$6f,$6e
	dc.b	$20,$74,$68,$65,$20,$73,$61,$6d,$65,$20,$70,$6c,$61,$63,$65,$20
	dc.b	$21,$0d,$00
D_2f05b:
	dc.b	$5b,$67,$65,$74,$5f,$6d,$6f,$6e,$61,$6e,$7a,$5d,$20,$2d,$3e,$20
	dc.b	$63,$61,$6e,$27,$74,$20,$66,$69,$6e,$64,$20,$6d,$6f,$6e,$73,$74
	dc.b	$65,$72,$74,$79,$70,$65,$0d,$00
D_2f083:
	dc.b	$5b,$20,$67,$65,$74,$5f,$6d,$6f,$6e,$63,$68,$61,$72,$20,$5d,$20
	dc.b	$2d,$3e,$20,$4d,$6f,$6e,$73,$74,$65,$72,$20,$6e,$6f,$74,$20,$69
	dc.b	$6e,$20,$4d,$65,$6d,$6f,$72,$79,$20,$21,$0d,$00
D_2f0af:
	dc.b	$43,$6f,$6d,$62,$61,$74,$20,$2d,$3e,$20,$4d,$6f,$76,$65,$2d,$64
	dc.b	$65,$73,$74,$69,$6e,$61,$74,$69,$6f,$6e,$20,$6e,$6f,$74,$20,$65
	dc.b	$6d,$70,$74,$79,$20,$21,$0d,$00
D_2f0d7:
	dc.b	$28,$41,$74,$74,$61,$63,$6b,$73,$20,$70,$65,$72,$20,$72,$6f,$75
	dc.b	$6e,$64,$29,$20,$63,$61,$6e,$27,$74,$20,$62,$65,$20,$7a,$65,$72
	dc.b	$6f,$20,$21,$21,$0d,$00
D_2f0fd:
	dc.b	$4f,$62,$6a,$65,$63,$74,$20,$6e,$6f,$74,$20,$66,$6f,$75,$6e,$64
	dc.b	$20,$69,$6e,$20,$69,$6e,$74,$65,$72,$6e,$61,$6c,$20,$6c,$69,$73
	dc.b	$74,$20,$21,$0d,$00
D_2f122:
	dc.b	$41,$20,$67,$61,$72,$62,$61,$67,$65,$20,$63,$6f,$6c,$6c,$65,$63
	dc.b	$74,$69,$6f,$6e,$20,$69,$73,$20,$72,$65,$71,$75,$69,$72,$65,$64
	dc.b	$2e,$0d,$00
D_2f145:
	dc.b	$54,$68,$65,$20,$70,$72,$6f,$67,$72,$61,$6d,$20,$77,$69,$6c,$6c
	dc.b	$20,$72,$65,$2d,$6c,$6f,$61,$64,$20,$73,$6f,$6d,$65,$20,$64,$61
	dc.b	$74,$61,$2e,$0d,$00
D_2f16a:
	dc.b	$57,$65,$20,$61,$70,$6f,$6c,$6f,$67,$69,$7a,$65,$20,$66,$6f,$72
	dc.b	$20,$74,$68,$65,$20,$69,$6e,$63,$6f,$6e,$76,$65,$6e,$69,$65,$6e
	dc.b	$63,$65,$2e,$0d,$00
D_2f18f:
	dc.b	$50,$72,$65,$73,$73,$20,$61,$6e,$79,$20,$6b,$65,$79,$20,$74,$6f
	dc.b	$20,$63,$6f,$6e,$74,$69,$6e,$75,$65,$2e,$0d,$00,$00
Icondata_filename:
	dc.b	$02,$49,$43,$4f,$4e,$5f,$44,$41,$54,$2e,$41,$4d,$42,$00
Labdata_filename:
	dc.b	$05,$4c,$41,$42,$5f,$44,$41,$54,$41,$2e,$41,$4d,$42,$00
Labblock_filename:
	dc.b	$06,$4c,$41,$42,$42,$4c,$4f,$43,$4b,$2e,$41,$4d,$42,$00
Backgrnd_filename:
	dc.b	$07,$42,$41,$43,$4b,$47,$52,$4e,$44,$2e,$41,$4d,$42,$00
Colpall_filename:
	dc.b	$08,$43,$4f,$4c,$5f,$50,$41,$4c,$4c,$2e,$41,$4d,$42,$00
D_2f1f2:
	dc.b	$04,$4d,$41,$50,$5f,$44,$41,$54,$41,$2e,$41,$4d,$42,$00
Maptext_filename:
	dc.b	$0a,$4d,$41,$50,$54,$45,$58,$54,$2e,$41,$4d,$42,$00
Pics80_filename:
	dc.b	$09,$50,$49,$43,$53,$38,$30,$2e,$41,$4d,$42,$00
Chestdata_filename:
	dc.b	$0b,$43,$48,$45,$53,$54,$44,$41,$54,$2e,$41,$4d,$42,$00
D_2f227:
	dc.b	$15,$50,$55,$5a,$5a,$4c,$45,$2e,$49,$43,$4e,$00
D_2f233:
	dc.b	$16,$50,$55,$5a,$5a,$4c,$45,$2e,$54,$58,$54,$00,$00
D_2f240:
	dc.b	$0d,$57,$41,$52,$45,$53,$44,$41,$54,$2e,$41,$4d,$42,$00
Automap_filename:
	dc.b	$11,$41,$55,$54,$4f,$4d,$41,$50,$2e,$41,$4d,$42,$00,$00
D_2f25c:
	dc.b	$12,$43,$4f,$44,$45,$54,$58,$54,$2e,$41,$4d,$42,$00,$00
Partydata_filename:
	dc.b	$01,$50,$41,$52,$54,$59,$44,$41,$54,$2e,$53,$41,$56,$00
Chard_filename:
	dc.b	$03,$43,$48,$41,$52,$44,$41,$54,$41,$2e,$41,$4d,$42,$00
Lay1_c1:
	dc.b	$00,$10,$00,$bf,$00,$31,$00,$c0,$02,$00
	dc.l	Control_area
	dc.b	$00,$00,$00,$00
Lay5_c1:
	dc.b	$00,$20,$00,$af,$00,$31,$00,$c0,$02,$00
	dc.l	Control_area
	dc.b	$00,$00,$00,$00
D_2f2aa:
	dc.b	$00,$00,$00,$1f,$00,$20,$00,$2f,$01,$00
	dc.l	D_2f2bc
	dc.b	$00,$00,$00,$00
D_2f2bc:
	dc.b	$00,$20,$00,$3f,$00,$20,$00,$2f,$02,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00
Lay3_L2:
	dc.b	$00,$10,$00,$bf,$00,$91,$00,$c0,$02,$00
	dc.l	Control_area
	dc.l	D_2f2e0
D_2f2e0:
	dc.b	$00,$10,$00,$1f,$00,$91,$00,$a0,$01,$00
	dc.l	D_2f2ee
D_2f2ee:
	dc.b	$00,$30,$00,$3f,$00,$91,$00,$a0,$02,$00
	dc.l	D_2f2fc
D_2f2fc:
	dc.b	$00,$50,$00,$5f,$00,$91,$00,$a0,$03,$00
	dc.l	D_2f30a
D_2f30a:
	dc.b	$00,$70,$00,$7f,$00,$91,$00,$a0,$04,$00
	dc.l	D_2f318
D_2f318:
	dc.b	$00,$90,$00,$9f,$00,$91,$00,$a0,$05,$00
	dc.l	D_2f326
D_2f326:
	dc.b	$00,$b0,$00,$bf,$00,$91,$00,$a0,$06,$00
	dc.l	D_2f334
D_2f334:
	dc.b	$00,$10,$00,$1f,$00,$b1,$00,$c0,$07,$00
	dc.l	D_2f342
D_2f342:
	dc.b	$00,$30,$00,$3f,$00,$b1,$00,$c0,$08,$00
	dc.l	D_2f350
D_2f350:
	dc.b	$00,$50,$00,$5f,$00,$b1,$00,$c0,$09,$00
	dc.l	D_2f35e
D_2f35e:
	dc.b	$00,$70,$00,$7f,$00,$b1,$00,$c0,$0a,$00
	dc.l	D_2f36c
D_2f36c:
	dc.b	$00,$90,$00,$9f,$00,$b1,$00,$c0,$0b,$00
	dc.l	D_2f37a
D_2f37a:
	dc.b	$00,$b0,$00,$bf,$00,$b1,$00,$c0,$0c,$00,$00,$00,$00,$00
D_2f388:
	dc.b	$00,$00,$00,$7f,$00,$00,$00,$6f,$01,$00
	dc.l	D_2f39a
	dc.l	D_2f3e2
D_2f39a:
	dc.b	$00,$00,$00,$1f,$00,$70,$00,$7f,$02,$00
	dc.l	D_2f3ac
	dc.b	$00,$00,$00,$00
D_2f3ac:
	dc.b	$00,$20,$00,$3f,$00,$70,$00,$7f,$03,$00
	dc.l	D_2f3be
	dc.b	$00,$00,$00,$00
D_2f3be:
	dc.b	$00,$40,$00,$5f,$00,$70,$00,$7f,$04,$00
	dc.l	D_2f3d0
	dc.b	$00,$00,$00,$00
D_2f3d0:
	dc.b	$00,$60,$00,$7f,$00,$70,$00,$7f,$05,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00
D_2f3e2:
	dc.b	$00,$00,$00,$7f,$00,$00,$00,$06,$01,$00
	dc.l	D_2f3f4
	dc.b	$00,$00,$00,$00
D_2f3f4:
	dc.b	$00,$00,$00,$7f,$00,$07,$00,$0d,$02,$00
	dc.l	D_2f406
	dc.b	$00,$00,$00,$00
D_2f406:
	dc.b	$00,$00,$00,$7f,$00,$0e,$00,$14,$03,$00
	dc.l	D_2f418
	dc.b	$00,$00,$00,$00
D_2f418:
	dc.b	$00,$00,$00,$7f,$00,$15,$00,$1b,$04,$00
	dc.l	D_2f42a
	dc.b	$00,$00,$00,$00
D_2f42a:
	dc.b	$00,$00,$00,$7f,$00,$1c,$00,$22,$05,$00
	dc.l	D_2f43c
	dc.b	$00,$00,$00,$00
D_2f43c:
	dc.b	$00,$00,$00,$7f,$00,$23,$00,$29,$06,$00
	dc.l	D_2f44e
	dc.b	$00,$00,$00,$00
D_2f44e:
	dc.b	$00,$00,$00,$7f,$00,$2a,$00,$30,$07,$00
	dc.l	D_2f460
	dc.b	$00,$00,$00,$00
D_2f460:
	dc.b	$00,$00,$00,$7f,$00,$31,$00,$37,$08,$00
	dc.l	D_2f472
	dc.b	$00,$00,$00,$00
D_2f472:
	dc.b	$00,$00,$00,$7f,$00,$38,$00,$3e,$09,$00
	dc.l	D_2f484
	dc.b	$00,$00,$00,$00
D_2f484:
	dc.b	$00,$00,$00,$7f,$00,$3f,$00,$45,$0a,$00
	dc.l	D_2f496
	dc.b	$00,$00,$00,$00
D_2f496:
	dc.b	$00,$00,$00,$7f,$00,$46,$00,$4c,$0b,$00
	dc.l	D_2f4a8
	dc.b	$00,$00,$00,$00
D_2f4a8:
	dc.b	$00,$00,$00,$7f,$00,$4d,$00,$53,$0c,$00
	dc.l	D_2f4ba
	dc.b	$00,$00,$00,$00
D_2f4ba:
	dc.b	$00,$00,$00,$7f,$00,$54,$00,$5a,$0d,$00
	dc.l	D_2f4cc
	dc.b	$00,$00,$00,$00
D_2f4cc:
	dc.b	$00,$00,$00,$7f,$00,$5b,$00,$61,$0e,$00
	dc.l	D_2f4de
	dc.b	$00,$00,$00,$00
D_2f4de:
	dc.b	$00,$00,$00,$7f,$00,$62,$00,$68,$0f,$00
	dc.l	D_2f4f0
	dc.b	$00,$00,$00,$00
D_2f4f0:
	dc.b	$00,$00,$00,$7f,$00,$69,$00,$6f,$10,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00
SkillW_L1:
	dc.b	$00,$00,$00,$7f,$00,$08,$00,$4d,$01,$00
	dc.l	D_2f514
	dc.l	D_2f526
D_2f514:
	dc.b	$00,$00,$00,$1f,$00,$50,$00,$5f,$02,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00
D_2f526:
	dc.b	$00,$00,$00,$7f,$00,$08,$00,$0e,$01,$00
	dc.l	D_2f538
	dc.b	$00,$00,$00,$00
D_2f538:
	dc.b	$00,$00,$00,$7f,$00,$0f,$00,$15,$02,$00
	dc.l	D_2f54a
	dc.b	$00,$00,$00,$00
D_2f54a:
	dc.b	$00,$00,$00,$7f,$00,$16,$00,$1c,$03,$00
	dc.l	D_2f55c
	dc.b	$00,$00,$00,$00
D_2f55c:
	dc.b	$00,$00,$00,$7f,$00,$1d,$00,$23,$04,$00
	dc.l	D_2f56e
	dc.b	$00,$00,$00,$00
D_2f56e:
	dc.b	$00,$00,$00,$7f,$00,$24,$00,$2a,$05,$00
	dc.l	D_2f580
	dc.b	$00,$00,$00,$00
D_2f580:
	dc.b	$00,$00,$00,$7f,$00,$2b,$00,$31,$06,$00
	dc.l	D_2f592
	dc.b	$00,$00,$00,$00
D_2f592:
	dc.b	$00,$00,$00,$7f,$00,$32,$00,$38,$07,$00
	dc.l	D_2f5a4
	dc.b	$00,$00,$00,$00
D_2f5a4:
	dc.b	$00,$00,$00,$7f,$00,$39,$00,$3f,$08,$00
	dc.l	D_2f5b6
	dc.b	$00,$00,$00,$00
D_2f5b6:
	dc.b	$00,$00,$00,$7f,$00,$40,$00,$46,$09,$00
	dc.l	D_2f5c8
	dc.b	$00,$00,$00,$00
D_2f5c8:
	dc.b	$00,$00,$00,$7f,$00,$47,$00,$4d,$0a,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00
SellReq_L2:
	dc.b	$00,$f0,$01,$0f,$00,$51,$00,$61,$01,$00
	dc.l	D_2f5ec
	dc.b	$00,$00,$00,$00
D_2f5ec:
	dc.b	$01,$10,$01,$2f,$00,$51,$00,$61,$02,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00
D_2f5fe:
	dc.b	$00,$10,$00,$8f,$00,$31,$00,$b2,$01,$00
	dc.l	D_2f610
	dc.l	D_2f634
D_2f610:
	dc.b	$00,$80,$00,$9f,$00,$b0,$00,$bf,$02,$00
	dc.l	D_2f622
	dc.b	$00,$00,$00,$00
D_2f622:
	dc.b	$00,$a0,$00,$bf,$00,$b0,$00,$bf,$03,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00
D_2f634:
	dc.b	$00,$10,$00,$2f,$00,$31,$00,$52,$01,$00
	dc.l	D_2f646
	dc.b	$00,$00,$00,$00
D_2f646:
	dc.b	$00,$70,$00,$8f,$00,$49,$00,$6a,$02,$00
	dc.l	D_2f658
	dc.b	$00,$00,$00,$00
D_2f658:
	dc.b	$00,$10,$00,$2f,$00,$61,$00,$82,$03,$00
	dc.l	D_2f66a
	dc.b	$00,$00,$00,$00
D_2f66a:
	dc.b	$00,$70,$00,$8f,$00,$79,$00,$9a,$04,$00
	dc.l	D_2f67c
	dc.b	$00,$00,$00,$00
D_2f67c:
	dc.b	$00,$10,$00,$2f,$00,$91,$00,$b2,$05,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00
D_2f68e:
	dc.b	$00,$10,$01,$1f,$00,$31,$00,$80,$02,$00
	dc.l	Control_area
	dc.l	D_2f6a0
D_2f6a0:
	dc.b	$00,$10,$00,$2f,$00,$31,$00,$50,$01,$00
	dc.l	D_2f6b2
	dc.b	$00,$00,$00,$00
D_2f6b2:
	dc.b	$00,$40,$00,$5f,$00,$31,$00,$50,$02,$00
	dc.l	D_2f6c4
	dc.b	$00,$00,$00,$00
D_2f6c4:
	dc.b	$00,$70,$00,$8f,$00,$31,$00,$50,$03,$00
	dc.l	D_2f6d6
	dc.b	$00,$00,$00,$00
D_2f6d6:
	dc.b	$00,$a0,$00,$bf,$00,$31,$00,$50,$04,$00
	dc.l	D_2f6e8
	dc.b	$00,$00,$00,$00
D_2f6e8:
	dc.b	$00,$d0,$00,$ef,$00,$31,$00,$50,$05,$00
	dc.l	D_2f6fa
	dc.b	$00,$00,$00,$00
D_2f6fa:
	dc.b	$01,$00,$01,$1f,$00,$31,$00,$50,$06,$00
	dc.l	D_2f70c
	dc.b	$00,$00,$00,$00
D_2f70c:
	dc.b	$00,$10,$00,$2f,$00,$61,$00,$80,$07,$00
	dc.l	D_2f71e
	dc.b	$00,$00,$00,$00
D_2f71e:
	dc.b	$00,$40,$00,$5f,$00,$61,$00,$80,$08,$00
	dc.l	D_2f730
	dc.b	$00,$00,$00,$00
D_2f730:
	dc.b	$00,$70,$00,$8f,$00,$61,$00,$80,$09,$00
	dc.l	D_2f742
	dc.b	$00,$00,$00,$00
D_2f742:
	dc.b	$00,$a0,$00,$bf,$00,$61,$00,$80,$0a,$00
	dc.l	D_2f754
	dc.b	$00,$00,$00,$00
D_2f754:
	dc.b	$00,$d0,$00,$ef,$00,$61,$00,$80,$0b,$00
	dc.l	D_2f766
	dc.b	$00,$00,$00,$00
D_2f766:
	dc.b	$01,$00,$01,$1f,$00,$61,$00,$80,$0c,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00
D_2f778:
	dc.b	$00,$10,$00,$5f,$00,$51,$00,$a0,$02,$00
	dc.l	Backpack_area
	dc.l	D_2f79c
Backpack_area:
	dc.b	$00,$70,$00,$bf,$00,$51,$00,$c0,$03,$00
	dc.l	Control_area
	dc.l	D_2f81a
D_2f79c:
	dc.b	$00,$10,$00,$1f,$00,$51,$00,$60,$01,$00
	dc.l	D_2f7aa
D_2f7aa:
	dc.b	$00,$30,$00,$3f,$00,$51,$00,$60,$02,$00
	dc.l	D_2f7b8
D_2f7b8:
	dc.b	$00,$50,$00,$5f,$00,$51,$00,$60,$03,$00
	dc.l	D_2f7c6
D_2f7c6:
	dc.b	$00,$10,$00,$1f,$00,$71,$00,$80,$04,$00
	dc.l	D_2f7d4
D_2f7d4:
	dc.b	$00,$30,$00,$3f,$00,$71,$00,$80,$05,$00
	dc.l	D_2f7e2
D_2f7e2:
	dc.b	$00,$50,$00,$5f,$00,$71,$00,$80,$06,$00
	dc.l	D_2f7f0
D_2f7f0:
	dc.b	$00,$10,$00,$1f,$00,$91,$00,$a0,$07,$00
	dc.l	D_2f7fe
D_2f7fe:
	dc.b	$00,$30,$00,$3f,$00,$91,$00,$a0,$08,$00
	dc.l	D_2f80c
D_2f80c:
	dc.b	$00,$50,$00,$5f,$00,$91,$00,$a0,$09,$00,$00,$00,$00,$00
D_2f81a:
	dc.b	$00,$70,$00,$7f,$00,$51,$00,$60,$01,$00
	dc.l	D_2f828
D_2f828:
	dc.b	$00,$90,$00,$9f,$00,$51,$00,$60,$02,$00
	dc.l	D_2f836
D_2f836:
	dc.b	$00,$b0,$00,$bf,$00,$51,$00,$60,$03,$00
	dc.l	D_2f844
D_2f844:
	dc.b	$00,$70,$00,$7f,$00,$71,$00,$80,$04,$00
	dc.l	D_2f852
D_2f852:
	dc.b	$00,$90,$00,$9f,$00,$71,$00,$80,$05,$00
	dc.l	D_2f860
D_2f860:
	dc.b	$00,$b0,$00,$bf,$00,$71,$00,$80,$06,$00
	dc.l	D_2f86e
D_2f86e:
	dc.b	$00,$70,$00,$7f,$00,$91,$00,$a0,$07,$00
	dc.l	D_2f87c
D_2f87c:
	dc.b	$00,$90,$00,$9f,$00,$91,$00,$a0,$08,$00
	dc.l	D_2f88a
D_2f88a:
	dc.b	$00,$b0,$00,$bf,$00,$91,$00,$a0,$09,$00
	dc.l	D_2f898
D_2f898:
	dc.b	$00,$70,$00,$7f,$00,$b1,$00,$c0,$0a,$00
	dc.l	D_2f8a6
D_2f8a6:
	dc.b	$00,$90,$00,$9f,$00,$b1,$00,$c0,$0b,$00
	dc.l	D_2f8b4
D_2f8b4:
	dc.b	$00,$b0,$00,$bf,$00,$b1,$00,$c0,$0c,$00,$00,$00,$00,$00
ItemW_L1:
	dc.b	$00,$00,$00,$8f,$00,$00,$00,$3f,$01,$00,$00,$00,$00,$00
	dc.l	D_2f8d4
D_2f8d4:
	dc.b	$00,$00,$00,$1f,$00,$20,$00,$2f,$01,$00
	dc.l	D_2f8e6
	dc.b	$00,$00,$00,$00
D_2f8e6:
	dc.b	$00,$00,$00,$1f,$00,$30,$00,$3f,$02,$00
	dc.l	D_2f8f8
	dc.b	$00,$00,$00,$00
D_2f8f8:
	dc.b	$00,$50,$00,$6f,$00,$30,$00,$3f,$03,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00
D_2f90a:
	dc.b	$00,$00,$00,$8f,$00,$00,$00,$3f,$01,$00,$00,$00,$00,$00
	dc.l	D_2f91c
D_2f91c:
	dc.b	$00,$00,$00,$1f,$00,$20,$00,$2f,$01,$00
	dc.l	D_2f92e
	dc.b	$00,$00,$00,$00
D_2f92e:
	dc.b	$00,$00,$00,$1f,$00,$30,$00,$3f,$02,$00
	dc.l	D_2f940
	dc.b	$00,$00,$00,$00
D_2f940:
	dc.b	$00,$50,$00,$6f,$00,$30,$00,$3f,$03,$00
	dc.l	D_2f952
	dc.b	$00,$00,$00,$00
D_2f952:
	dc.b	$00,$50,$00,$6f,$00,$20,$00,$2f,$04,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00
ItemView1_L1:
	dc.b	$00,$e0,$00,$ff,$00,$30,$00,$3f,$01,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00
D_2f976:
	dc.b	$00,$00,$00,$bf,$00,$05,$00,$54,$01,$00,$00,$00,$00,$00
	dc.l	D_2f988
D_2f988:
	dc.b	$00,$00,$00,$5f,$00,$05,$00,$0b,$01,$00
	dc.l	D_2f99a
	dc.b	$00,$00,$00,$00
D_2f99a:
	dc.b	$00,$00,$00,$5f,$00,$0c,$00,$12,$02,$00
	dc.l	D_2f9ac
	dc.b	$00,$00,$00,$00
D_2f9ac:
	dc.b	$00,$00,$00,$5f,$00,$13,$00,$19,$03,$00
	dc.l	D_2f9be
	dc.b	$00,$00,$00,$00
D_2f9be:
	dc.b	$00,$00,$00,$5f,$00,$1a,$00,$20,$04,$00
	dc.l	D_2f9d0
	dc.b	$00,$00,$00,$00
D_2f9d0:
	dc.b	$00,$00,$00,$5f,$00,$21,$00,$27,$05,$00
	dc.l	D_2f9e2
	dc.b	$00,$00,$00,$00
D_2f9e2:
	dc.b	$00,$00,$00,$5f,$00,$28,$00,$2e,$06,$00
	dc.l	D_2f9f4
	dc.b	$00,$00,$00,$00
D_2f9f4:
	dc.b	$00,$00,$00,$5f,$00,$2f,$00,$35,$07,$00
	dc.l	D_2fa06
	dc.b	$00,$00,$00,$00
D_2fa06:
	dc.b	$00,$00,$00,$5f,$00,$36,$00,$3c,$08,$00
	dc.l	D_2fa18
	dc.b	$00,$00,$00,$00
D_2fa18:
	dc.b	$00,$00,$00,$5f,$00,$3d,$00,$43,$09,$00
	dc.l	D_2fa2a
	dc.b	$00,$00,$00,$00
D_2fa2a:
	dc.b	$00,$00,$00,$5f,$00,$44,$00,$4a,$0a,$00
	dc.l	D_2fa3c
	dc.b	$00,$00,$00,$00
D_2fa3c:
	dc.b	$00,$60,$00,$bf,$00,$05,$00,$0b,$0b,$00
	dc.l	D_2fa4e
	dc.b	$00,$00,$00,$00
D_2fa4e:
	dc.b	$00,$60,$00,$bf,$00,$0c,$00,$12,$0c,$00
	dc.l	D_2fa60
	dc.b	$00,$00,$00,$00
D_2fa60:
	dc.b	$00,$60,$00,$bf,$00,$13,$00,$19,$0d,$00
	dc.l	D_2fa72
	dc.b	$00,$00,$00,$00
D_2fa72:
	dc.b	$00,$60,$00,$bf,$00,$1a,$00,$20,$0e,$00
	dc.l	D_2fa84
	dc.b	$00,$00,$00,$00
D_2fa84:
	dc.b	$00,$60,$00,$bf,$00,$21,$00,$27,$0f,$00
	dc.l	D_2fa96
	dc.b	$00,$00,$00,$00
D_2fa96:
	dc.b	$00,$60,$00,$bf,$00,$28,$00,$2e,$10,$00
	dc.l	D_2faa8
	dc.b	$00,$00,$00,$00
D_2faa8:
	dc.b	$00,$60,$00,$bf,$00,$2f,$00,$35,$11,$00
	dc.l	D_2faba
	dc.b	$00,$00,$00,$00
D_2faba:
	dc.b	$00,$60,$00,$bf,$00,$36,$00,$3c,$12,$00
	dc.l	D_2facc
	dc.b	$00,$00,$00,$00
D_2facc:
	dc.b	$00,$60,$00,$bf,$00,$3d,$00,$43,$13,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00
SCSelW_L1:
	dc.b	$00,$00,$00,$7f,$00,$00,$00,$30,$01,$00,$00,$00,$00,$00
	dc.l	D_2faf0
D_2faf0:
	dc.b	$00,$00,$00,$7f,$00,$00,$00,$06,$01,$00
	dc.l	D_2fb02
	dc.b	$00,$00,$00,$00
D_2fb02:
	dc.b	$00,$00,$00,$7f,$00,$07,$00,$0d,$02,$00
	dc.l	D_2fb14
	dc.b	$00,$00,$00,$00
D_2fb14:
	dc.b	$00,$00,$00,$7f,$00,$0e,$00,$14,$03,$00
	dc.l	D_2fb26
	dc.b	$00,$00,$00,$00
D_2fb26:
	dc.b	$00,$00,$00,$7f,$00,$15,$00,$1b,$04,$00
	dc.l	D_2fb38
	dc.b	$00,$00,$00,$00
D_2fb38:
	dc.b	$00,$00,$00,$7f,$00,$1c,$00,$22,$05,$00
	dc.l	D_2fb4a
	dc.b	$00,$00,$00,$00
D_2fb4a:
	dc.b	$00,$00,$00,$7f,$00,$23,$00,$29,$06,$00
	dc.l	D_2fb5c
	dc.b	$00,$00,$00,$00
D_2fb5c:
	dc.b	$00,$00,$00,$7f,$00,$2a,$00,$30,$07,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00
D_2fb6e:
	dc.b	$00,$00,$00,$7f,$00,$00,$00,$6f,$01,$00
	dc.l	D_2fb80
	dc.l	D_2fbb6
D_2fb80:
	dc.b	$00,$00,$00,$1f,$00,$70,$00,$7f,$02,$00
	dc.l	D_2fb92
	dc.b	$00,$00,$00,$00
D_2fb92:
	dc.b	$00,$20,$00,$3f,$00,$70,$00,$7f,$03,$00
	dc.l	D_2fba4
	dc.b	$00,$00,$00,$00
D_2fba4:
	dc.b	$00,$80,$00,$9f,$00,$70,$00,$7f,$04,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00
D_2fbb6:
	dc.b	$00,$00,$00,$7f,$00,$00,$00,$06,$01,$00
	dc.l	D_2fbc8
	dc.b	$00,$00,$00,$00
D_2fbc8:
	dc.b	$00,$00,$00,$7f,$00,$07,$00,$0d,$02,$00
	dc.l	D_2fbda
	dc.b	$00,$00,$00,$00
D_2fbda:
	dc.b	$00,$00,$00,$7f,$00,$0e,$00,$14,$03,$00
	dc.l	D_2fbec
	dc.b	$00,$00,$00,$00
D_2fbec:
	dc.b	$00,$00,$00,$7f,$00,$15,$00,$1b,$04,$00
	dc.l	D_2fbfe
	dc.b	$00,$00,$00,$00
D_2fbfe:
	dc.b	$00,$00,$00,$7f,$00,$1c,$00,$22,$05,$00
	dc.l	D_2fc10
	dc.b	$00,$00,$00,$00
D_2fc10:
	dc.b	$00,$00,$00,$7f,$00,$23,$00,$29,$06,$00
	dc.l	D_2fc22
	dc.b	$00,$00,$00,$00
D_2fc22:
	dc.b	$00,$00,$00,$7f,$00,$2a,$00,$30,$07,$00
	dc.l	D_2fc34
	dc.b	$00,$00,$00,$00
D_2fc34:
	dc.b	$00,$00,$00,$7f,$00,$31,$00,$37,$08,$00
	dc.l	D_2fc46
	dc.b	$00,$00,$00,$00
D_2fc46:
	dc.b	$00,$00,$00,$7f,$00,$38,$00,$3e,$09,$00
	dc.l	D_2fc58
	dc.b	$00,$00,$00,$00
D_2fc58:
	dc.b	$00,$00,$00,$7f,$00,$3f,$00,$45,$0a,$00
	dc.l	D_2fc6a
	dc.b	$00,$00,$00,$00
D_2fc6a:
	dc.b	$00,$00,$00,$7f,$00,$46,$00,$4c,$0b,$00
	dc.l	D_2fc7c
	dc.b	$00,$00,$00,$00
D_2fc7c:
	dc.b	$00,$00,$00,$7f,$00,$4d,$00,$53,$0c,$00
	dc.l	D_2fc8e
	dc.b	$00,$00,$00,$00
D_2fc8e:
	dc.b	$00,$00,$00,$7f,$00,$54,$00,$5a,$0d,$00
	dc.l	D_2fca0
	dc.b	$00,$00,$00,$00
D_2fca0:
	dc.b	$00,$00,$00,$7f,$00,$5b,$00,$61,$0e,$00
	dc.l	D_2fcb2
	dc.b	$00,$00,$00,$00
D_2fcb2:
	dc.b	$00,$00,$00,$7f,$00,$62,$00,$68,$0f,$00
	dc.l	D_2fcc4
	dc.b	$00,$00,$00,$00
D_2fcc4:
	dc.b	$00,$00,$00,$7f,$00,$69,$00,$6f,$10,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00
D_2fcd6:
	dc.b	$00,$70,$00,$8f,$00,$20,$00,$2f,$01,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00
D_2fce8:
	dc.b	$00,$00,$01,$3f,$00,$00,$00,$23,$01,$00,$00,$00,$00,$00
	dc.l	D_2fd1e
Main_root:
	dc.b	$00,$00,$01,$3f,$00,$00,$00,$23,$01,$00
	dc.l	D_2fd0c
	dc.l	D_2fd1e
D_2fd0c:
	dc.b	$00,$00,$01,$3f,$00,$25,$00,$c7,$02,$00,$00,$00,$00,$00
Layout_data_ptr:
	dc.b	$00,$00,$00,$00
D_2fd1e:
	dc.b	$00,$10,$00,$2f,$00,$01,$00,$23,$01,$00
	dc.l	D_2fd30
	dc.b	$00,$00,$00,$00
D_2fd30:
	dc.b	$00,$40,$00,$5f,$00,$01,$00,$23,$02,$00
	dc.l	D_2fd42
	dc.b	$00,$00,$00,$00
D_2fd42:
	dc.b	$00,$70,$00,$8f,$00,$01,$00,$23,$03,$00
	dc.l	D_2fd54
	dc.b	$00,$00,$00,$00
D_2fd54:
	dc.b	$00,$a0,$00,$bf,$00,$01,$00,$23,$04,$00
	dc.l	D_2fd66
	dc.b	$00,$00,$00,$00
D_2fd66:
	dc.b	$00,$d0,$00,$ef,$00,$01,$00,$23,$05,$00
	dc.l	D_2fd78
	dc.b	$00,$00,$00,$00
D_2fd78:
	dc.b	$01,$00,$01,$1f,$00,$01,$00,$23,$06,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00
Control_area:
	dc.b	$00,$d0,$01,$2f,$00,$91,$00,$c0,$01,$00,$00,$00,$00,$00
	dc.l	D_2fd9c
D_2fd9c:
	dc.b	$00,$d0,$00,$ef,$00,$91,$00,$a0,$01,$00
	dc.l	D_2fdaa
D_2fdaa:
	dc.b	$00,$f0,$01,$0f,$00,$91,$00,$a0,$02,$00
	dc.l	D_2fdb8
D_2fdb8:
	dc.b	$01,$10,$01,$2f,$00,$91,$00,$a0,$03,$00
	dc.l	D_2fdc6
D_2fdc6:
	dc.b	$00,$d0,$00,$ef,$00,$a1,$00,$b0,$04,$00
	dc.l	D_2fdd4
D_2fdd4:
	dc.b	$00,$f0,$01,$0f,$00,$a1,$00,$b0,$05,$00
	dc.l	D_2fde2
D_2fde2:
	dc.b	$01,$10,$01,$2f,$00,$a1,$00,$b0,$06,$00
	dc.l	D_2fdf0
D_2fdf0:
	dc.b	$00,$d0,$00,$ef,$00,$b1,$00,$c0,$07,$00
	dc.l	D_2fdfe
D_2fdfe:
	dc.b	$00,$f0,$01,$0f,$00,$b1,$00,$c0,$08,$00
	dc.l	D_2fe0c
D_2fe0c:
	dc.b	$01,$10,$01,$2f,$00,$b1,$00,$c0,$09,$00,$00,$00,$00,$00
D_2fe1a:
	dc.b	$00,$f0,$01,$0f,$00,$b0,$00,$bf,$01,$00
	dc.l	D_2fe2c
	dc.b	$00,$00,$00,$00
D_2fe2c:
	dc.b	$01,$10,$01,$2f,$00,$b0,$00,$bf,$02,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00
PlacesExit_L1:
	dc.b	$00,$10,$00,$2f,$00,$20,$00,$2f,$01,$00
	dc.l	D_2fe50
	dc.b	$00,$00,$00,$00
D_2fe50:
	dc.b	$00,$30,$00,$4f,$00,$20,$00,$2f,$02,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00
Hbl_2D_map:
	dc.b	$ff,$00,$00,$00,$07,$50,$03,$33,$02,$22,$01,$11,$07,$42,$06,$31
	dc.b	$02,$00,$05,$66,$03,$45,$07,$54,$06,$43,$05,$32,$04,$21,$03,$10
	dc.b	$07,$65,$24,$00
Below_pal_2D:
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00
Hbl_D3_map:
	dc.b	$ff,$00,$00,$00,$07,$50,$03,$33,$02,$22,$01,$11,$07,$42,$06,$31
	dc.b	$02,$00,$05,$66,$03,$45,$07,$54,$06,$43,$05,$32,$04,$21,$03,$10
	dc.b	$07,$65,$24,$00
Below_pal_D3:
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00
Hbl_C3_map:
	dc.b	$ff,$00,$00,$00,$07,$50,$03,$33,$02,$22,$01,$11,$07,$42,$06,$31
	dc.b	$02,$00,$05,$66,$03,$45,$07,$54,$06,$43,$05,$32,$04,$21,$03,$10
	dc.b	$07,$65
Below_pal_C3:
	dc.b	$24,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00
Sky_pal_C3:
	dc.b	$30,$ff,$00,$0b
D_2ff36:
	dc.b	$00,$00,$31,$ff,$00,$0b,$00,$00,$32,$ff,$00,$0b,$00,$00,$33,$ff
	dc.b	$00,$0b,$00,$00,$34,$ff,$00,$0b,$00,$00,$35,$ff,$00,$0b,$00,$00
	dc.b	$36,$ff,$00,$0b,$00,$00,$37,$ff,$00,$0b,$00,$00,$38,$ff,$00,$0b
	dc.b	$00,$00,$39,$ff,$00,$0b,$00,$00,$3a,$ff,$00,$0b,$00,$00,$3b,$ff
	dc.b	$00,$0b,$00,$00,$3c,$ff,$00,$0b,$00,$00,$3d,$ff,$00,$0b,$00,$00
	dc.b	$3e,$ff,$00,$0b,$00,$00,$3f,$ff,$00,$0b,$00,$00,$40,$ff,$00,$0b
	dc.b	$00,$00,$41,$ff,$00,$0b,$00,$00,$42,$ff,$00,$0b,$00,$00,$43,$ff
	dc.b	$00,$0b,$00,$00,$44,$ff,$00,$0b,$00,$00,$45,$ff,$00,$0b,$00,$00
	dc.b	$46,$ff,$00,$0b,$00,$00,$47,$ff,$00,$0b,$00,$00,$48,$ff,$00,$0b
	dc.b	$00,$00,$49,$ff,$00,$0b,$00,$00,$4a,$ff,$00,$0b,$00,$00,$4b,$ff
	dc.b	$00,$0b,$00,$00,$4c,$ff,$00,$0b,$00,$00,$4d,$ff,$00,$0b,$00,$00
	dc.b	$4e,$ff,$00,$0b,$00,$00,$4f,$ff,$00,$0b,$00,$00,$50,$ff,$00,$0b
	dc.b	$00,$00,$51,$ff,$00,$0b,$00,$00,$52,$ff,$00,$0b,$00,$00,$53,$ff
	dc.b	$00,$0b,$00,$00,$54,$ff,$00,$0b,$00,$00,$55,$ff,$00,$0b,$00,$00
	dc.b	$56,$ff,$00,$0b,$00,$00,$57,$ff,$00,$0b,$00,$00,$58,$ff,$00,$0b
	dc.b	$00,$00,$59,$ff,$00,$0b,$00,$00,$5a,$ff,$00,$0b,$00,$00,$5b,$ff
	dc.b	$00,$0b,$00,$00,$5c,$ff,$00,$0b,$00,$00,$5d,$ff,$00,$0b,$00,$00
	dc.b	$5e,$ff,$00,$0b,$00,$00,$5f,$ff,$00,$0b,$00,$00,$60,$ff,$00,$0b
	dc.b	$00,$00,$61,$ff,$00,$0b,$00,$00,$62,$ff,$00,$0b,$00,$00,$63,$ff
	dc.b	$00,$0b,$00,$00,$64,$ff,$00,$0b,$00,$00,$65,$ff,$00,$0b,$00,$00
	dc.b	$66,$ff,$00,$0b,$00,$00,$67,$ff,$00,$0b,$00,$00,$68,$ff,$00,$0b
	dc.b	$00,$00,$69,$ff,$00,$0b,$00,$00,$6a,$ff,$00,$0b,$00,$00,$6b,$ff
	dc.b	$00,$0b,$00,$00,$6c,$ff,$00,$0b,$00,$00,$6d,$ff,$00,$0b,$00,$00
	dc.b	$6e,$ff,$00,$0b,$00,$00,$6f,$ff,$00,$0b,$00,$00,$70,$ff,$00,$0b
	dc.b	$00,$00,$71,$ff,$00,$0b,$00,$00,$72,$ff,$00,$0b,$00,$00,$73,$ff
	dc.b	$00,$0b,$00,$00,$74,$ff,$00,$0b,$00,$00,$75,$ff,$00,$0b,$00,$00
	dc.b	$76,$ff,$00,$0b,$00,$00,$77,$ff,$00,$0b,$00,$00,$78,$ff,$00,$0b
	dc.b	$00,$00,$79,$ff,$00,$0b,$00,$00,$7a,$ff,$00,$0b,$00,$00,$7b,$ff
	dc.b	$00,$0b,$00,$00,$7c,$ff,$00,$0b,$00,$00,$7d,$ff,$00,$0b,$00,$00
	dc.b	$7e,$ff,$00,$0b,$00,$00,$7f,$ff,$00,$0b,$00,$00,$80,$ff,$00,$0b
	dc.b	$00,$00,$81,$ff,$00,$0b,$00,$00,$82,$ff,$00,$0b,$00,$00,$84,$ff
	dc.b	$00,$0b,$00,$00,$00,$00
Hbl_pic80_list:
	dc.b	$ff,$00,$00,$00,$07,$50,$03,$33,$02,$22,$01,$11,$07,$42,$06,$31
	dc.b	$02,$00,$05,$66,$03,$45,$07,$54,$06,$43,$05,$32,$04,$21,$03,$10
	dc.b	$07,$65,$24,$00
Pic80_below:
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00
Hbl_Lay3_list:
	dc.b	$ff,$00,$00,$00,$07,$50,$03,$33,$02,$22,$01,$11,$07,$42,$06,$31
	dc.b	$02,$00,$05,$66,$03,$45,$07,$54,$06,$43,$05,$32,$04,$21,$03,$10
	dc.b	$07,$65
Lay3_below:
	dc.b	$24,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$80,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00
Hbl_Lay9_list:
	dc.b	$ff,$00,$00,$00,$07,$50,$03,$33,$02,$22,$01,$11,$07,$42,$06,$31
	dc.b	$02,$00,$05,$66,$03,$45,$07,$54,$06,$43,$05,$32,$04,$21,$03,$10
	dc.b	$07,$65,$24,$00
Lay9_below:
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00
D_30220:
	dc.b	$ff,$00,$00,$00,$07,$50,$03,$33,$02,$22,$01,$11,$07,$42,$06,$31
	dc.b	$02,$00,$05,$66,$03,$45,$07,$54,$06,$43,$05,$32,$04,$21,$03,$10
	dc.b	$07,$65,$24,$00
D_30244:
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00
Hbl_Lay8_list:
	dc.b	$ff,$00,$00,$00,$07,$50,$03,$33,$02,$22,$01,$11,$07,$42,$06,$31
	dc.b	$02,$00,$05,$66,$03,$45,$07,$54,$06,$43,$05,$32,$04,$21,$03,$10
	dc.b	$07,$65
Lay8_below:
	dc.b	$24,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$71,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00
Hbl_Lay11_list:
	dc.b	$ff,$00,$00,$00,$07,$50,$03,$33,$02,$22,$01,$11,$07,$42,$06,$31
	dc.b	$02,$00,$05,$66,$03,$45,$07,$54,$06,$43,$05,$32,$04,$21,$03,$10
	dc.b	$07,$65,$24,$00
Lay11_below:
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00
Hbl_Lay6_list:
	dc.b	$ff,$00,$00,$00,$07,$50,$03,$33,$02,$22,$01,$11,$07,$42,$06,$31
	dc.b	$02,$00,$05,$66,$03,$45,$07,$54,$06,$43,$05,$32,$04,$21,$03,$10
	dc.b	$07,$65,$24,$00
Lay6_below:
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00
Hbl_Inv1_list:
	dc.b	$ff,$00
D_3035c:
	dc.b	$00,$00,$07,$50,$03,$33,$02,$22,$01,$11,$07,$42,$06,$31,$02,$00
	dc.b	$05,$66,$03,$45,$07,$54,$06,$43,$05,$32,$04,$21,$03,$10,$07,$65
	dc.b	$24,$00
Inv1_below:
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00
Hbl_Inv2_list:
	dc.b	$ff,$00,$00,$00,$07,$50,$03,$33,$02,$22,$01,$11,$07,$42,$06,$31
	dc.b	$02,$00,$05,$66,$03,$45,$07,$54,$06,$43,$05,$32,$04,$21,$03,$10
	dc.b	$07,$65
Inv2_below:
	dc.b	$24,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$51,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00
D_30408:
	dc.b	$ff,$00,$00,$00,$07,$50,$03,$33,$02,$22,$01,$11,$07,$42,$06,$31
	dc.b	$02,$00,$05,$66,$03,$45,$07,$54,$06,$43,$05,$32,$04,$21,$03,$10
	dc.b	$07,$65,$24,$00
D_3042c:
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00

	section	bss

Current_inventory_chardat_ptr:
	ds.b	4
Object_name_nr:
	ds.b	2
TIVS_Icon_nr:
	ds.b	4
TIVS_Ptr:
	ds.b	4
CIL_buffer:
	ds.b	9
Print_objname_flag:
	ds.b	1
Erase_objname_flag:
	ds.b	1
Fade_block:
	ds.b	1
CIL_update:
	ds.b	2
Object_slot_number:
	ds.b	1
Battling:
	ds.b	1
Xtra_window:
	ds.b	1
Cursed:
	ds.b	1
B_587f8:
	ds.b	1
B_587f9:
	ds.b	1
ItemW_nr:
	ds.b	4
Original_number:
	ds.b	4
Adding:
	ds.b	2
Transferring:
	ds.b	2
Transfer_victims:
	ds.b	2
View2_handle:
	ds.b	2
Curse_index:
	ds.b	2
B_5880c:
	ds.b	2
B_5880e:
	ds.b	4
B_58812:
	ds.b	4
B_58816:
	ds.b	2
SCSelW_handle:
	ds.b	2
