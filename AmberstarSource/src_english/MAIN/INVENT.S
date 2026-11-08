; MAIN/INVENT.ASM (original module, merged with the disassembly of the shipped program)

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
	lea.l	$132(a0),a0
	move.l	a0,Itemdata_ptr
	move.l	a1,Itemslots_ptr
	tst.b	B_587f8
	beq.b	T_10baa
	sf.b	B_587f8
	bra.b	T_10bae
T_10baa:
	bsr.w	Inv1_DisInit
T_10bae:
	rts
Inv1_ModExit:
	jsr	Pop_MA
	jsr	Pop_PA
	bsr.w	Inv1_DisExit
	tst.b	Battling
	beq.b	T_10bcc
	bsr.w	T_16b64
T_10bcc:
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
T_10c20:
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
	bmi.b	T_10c20
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
T_10cba:
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
	bmi.b	T_10cba
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
T_10d4c:
	move.w	d2,d0
	jsr	IG_Set_cursor
	btst	d7,d6
	beq.b	T_10d6c
	move.w	(a2),d0
	bsr.w	Get_word
	lea.l	Line_buffer,a0
	jsr	IG_Print
	addq.w	#$7,d1
T_10d6c:
	addq.l	#$2,a2
	addq.w	#$1,d7
	cmpi.b	#$8,d7
	bmi.b	T_10d4c
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
	beq.b	T_10dbc
	move.w	d2,d0
	move.w	d3,d1
	jsr	Blit_masked_block
	bra.b	T_10e36
T_10dbc:
	lea.l	$480(a0),a0
	moveq	#0,d7
T_10dc2:
	btst	d7,d6
	beq.b	T_10dd4
	move.w	d2,d0
	move.w	d3,d1
	add.w	(a2)+,d0
	add.w	(a2)+,d1
	jsr	Blit_masked_block
T_10dd4:
	lea.l	$80(a0),a0
	addq.w	#$1,d7
	cmpi.w	#$6,d7
	bmi.b	T_10dc2
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
T_10e18:
	btst	d7,d6
	beq.b	T_10e2a
	move.w	d2,d0
	move.w	d3,d1
	add.w	(a2)+,d0
	add.w	(a2)+,d1
	jsr	Blit_masked_block
T_10e2a:
	lea.l	$80(a0),a0
	addq.w	#$1,d7
	cmpi.w	#$6,d7
	bmi.b	T_10e18
T_10e36:
	move.l	#D_2d9e4,Control_list_ptr
	jsr	Show_control_icons
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	Control_area,a0
	jsr	Set_layout_data
	tst.b	Fade_block
	beq.b	T_10e6e
	sf.b	Fade_block
	bra.b	T_10ea0
T_10e6e:
	lea.l	D_3035c,a1
	lea.l	Subfade1,a2
T_10e7a:
	lea.l	Hbl_Inv1_list,a0
	jsr	Update_HBL
	jsr	My_vsync
	jsr	My_vsync
	lea.l	Inv1_below,a0
	jsr	Fade_pal
	bne.b	T_10e7a
T_10ea0:
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
	lea.l	$132(a0),a0
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
	bmi.b	T_11030
	lea.l	$9(a2),a2
	lea.l	$168(a4),a4
	addi.w	#$9,d1
	subi.w	#$9,d7
T_11030:
	tst.b	(a2)+
	beq.b	T_1103a
	move.b	(a4),d0
	bsr.w	INV2_Show_object
T_1103a:
	addq.l	#$1,d1
	lea.l	$28(a4),a4
	dbra	d7,T_11030
	lea.l	$25(a1),a2
	tst.b	(a2)
	beq.b	T_11060
	lea.l	$1aa(a1),a3
	cmpi.b	#$2,$4(a3)
	bne.b	T_11060
	moveq	#0,d0
	moveq	#6,d1
	bsr.w	INV2_Show_object
T_11060:
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
	beq.b	T_110b6
	sf.b	Fade_block
	bra.b	T_110e8
T_110b6:
	lea.l	D_2da40,a1
	lea.l	Subfade1,a2
T_110c2:
	lea.l	Hbl_Inv2_list,a0
	jsr	Update_HBL
	jsr	My_vsync
	jsr	My_vsync
	lea.l	Inv2_below,a0
	jsr	Hbl_fade
	bne.b	T_110c2
T_110e8:
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
	move.l	$ec(a0),d2
	divu.w	#$3e8,d2
	ext.l	d2
	moveq	#0,d3
	move.w	$48(a0),d3
	add.w	$9c(a0),d3
	lea.l	D_2dbef,a0
	cmp.l	d2,d3
	bpl.b	T_1128c
	lea.l	D_2da84,a1
	move.w	Curse_index,d0
	addq.w	#$1,d0
	move.b	(a1,d0.w),d1
	bpl.b	T_11280
	moveq	#0,d0
	move.b	(a1),d1
T_11280:
	move.w	d0,Curse_index
	move.b	d1,$1(a0)
	bra.b	T_11292
T_1128c:
	move.b	#$f,$1(a0)
T_11292:
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
Display_character:
	movem.l	d0-d1/d6-d7/a0/a2-a3,-(a7)
	moveq	#2,d0
	jsr	IG_Set_paper
	moveq	#0,d0
	lea.l	$6b0(a1),a0
	move.w	#$d0,d0
	move.w	#$31,d1
	moveq	#2,d6
	jsr	Blot_unmasked_block
	moveq	#1,d0
	jsr	IG_Set_ink
	move.w	#$d0,d0
	move.w	#$54,d1
	move.w	#$60,d2
	lea.l	$f0(a1),a0
	jsr	Print_centered_string
	moveq	#15,d0
	jsr	IG_Set_ink
	move.w	#$f2,d0
	move.w	#$38,d1
	jsr	IG_Set_cursor
	move.b	$3(a1),d0
	beq.b	T_1142c
	lea.l	Female_name,a0
	bra.b	T_11432
T_1142c:
	lea.l	Male_name,a0
T_11432:
	jsr	IG_Print
	cmpi.b	#$9,$4(a1)
	bpl.b	T_114b6
	move.w	#$f2,d0
	move.w	#$31,d1
	jsr	IG_Set_cursor
	lea.l	D_47352,a2
	moveq	#0,d0
	move.b	$4(a1),d0
	add.w	d0,d0
	move.w	(a2,d0.w),d0
	bsr.w	Get_word
	lea.l	Line_buffer,a0
	jsr	IG_Print
	tst.b	$5(a1)
	beq.b	T_114b6
	move.w	#$f2,d0
	move.w	#$46,d1
	jsr	IG_Set_cursor
	lea.l	D_48472,a2
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
T_114b6:
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
	lea.l	(a0),a3
	bsr.w	LConvert_number
	jsr	IG_Print
	move.w	#$f2,d0
	move.w	#$4d,d1
	jsr	IG_Set_cursor
	lea.l	D_2dbaa,a0
	move.l	$cc(a1),d0
	moveq	#6,d7
	lea.l	$3(a0),a3
	bsr.w	LConvert_number
	jsr	IG_Print
	move.w	#$d6,d0
	move.w	#$78,d1
	moveq	#1,d6
	moveq	#10,d7
	lea.l	D_41e90,a0
	jsr	Blot_unmasked_block
	addi.w	#$30,d0
	lea.l	$50(a0),a0
	jsr	Blot_unmasked_block
	bsr.w	Update_character_info
	movem.l	(a7)+,d0-d1/d6-d7/a0/a2-a3
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
	beq.b	T_11866
	lea.l	T_11868(pc),a0
	jsr	IG_Print
	move.w	Object_name_nr,d0
	beq.b	T_11866
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
T_11866:
	rts
T_11868:
	dc.b	$01,$0f,$02,$ff,$00,$00
T_1186e:
	tst.b	Erase_objname_flag
	beq.b	T_118a2
	move.w	#$10,d0
	move.w	#$3a,d1
	move.w	#$bf,d2
	move.w	#$40,d3
	move.w	#$2,d6
	movea.l	Off_screen,a6
	jsr	Draw_box
	subq.b	#$1,Erase_objname_flag
	clr.w	Object_name_nr
T_118a2:
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
DropMItem_Return:
	btst	#$1,Mouse_button_state
	bne.b	DropMItem_Return
	move.l	#Code0001Sys,Textfile_ptr
	move.w	#$16,ReqText_nr
	move.l	#T_11b02,ReqDo_ptr
	lea.l	Req_Mod,a0
	bra.w	Push_Module
T_11b02:
	btst	#$1,Mouse_button_state
	bne.b	T_11b02
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
	bne.b	T_11b72
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
	bra.b	T_11baa
T_11b72:
	dc.b	$0c,$11,$00,$01,$66,$32,$10,$12,$12,$39
	dc.l	Object_slot_number
	dc.b	$61,$00,$f5,$b4,$30,$3c,$00,$10,$32,$3c,$00,$3a,$34,$3c,$00,$bf
	dc.b	$36,$3c,$00,$40,$3c,$3c,$00,$02,$4e,$b9
	dc.l	Draw_box
	dc.b	$4e,$b9
	dc.l	Switch_screen
	dc.b	$4e,$b9
	dc.l	Copy_screen
T_11baa:
	move.l	ItemW_nr,d0
	mulu.w	$22(a2),d0
	sub.l	d0,$ec(a0)
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
ItemW_DisInit:
	movem.l	d0-d3/d6-d7/a0/a6,-(a7)
	moveq	#32,d0
	moveq	#112,d1
	moveq	#10,d2
	moveq	#6,d3
	moveq	#1,d6
	lea.l	ItemW_L1,a0
	jsr	Open_window
	move.w	d0,B_58256
	movea.l	Off_screen,a6
	moveq	#2,d6
	moveq	#16,d7
	move.w	#$30,d0
	move.w	#$a0,d1
	lea.l	D_38060,a0
	jsr	Blot_unmasked_block
	move.w	#$30,d0
	move.w	#$b0,d1
	lea.l	D_38160,a0
	jsr	Blot_unmasked_block
	move.w	#$80,d0
	move.w	#$b0,d1
	lea.l	D_39d60,a0
	jsr	Blot_unmasked_block
	bsr.w	ItemW_DisUpd
	movem.l	(a7)+,d0-d3/d6-d7/a0/a6
	rts
ItemW_DisExit:
	move.w	B_58256,d0
	jsr	Close_window
	jsr	Copy_screen
	movea.l	Off_screen,a6
	jsr	Erase_message_minus
	jsr	Switch_screen
	jsr	Copy_screen
T_11cb2:
	btst	#$1,Mouse_button_state
	bne.b	T_11cb2
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
UseItem_DisInit:
	lea.l	D_2dd3e,a0
	jsr	Push_MA
	moveq	#2,d0
	movea.l	Off_screen,a6
	move.w	#$2,d0
	jsr	Minus_message
	jsr	Switch_screen
	jsr	Copy_screen
T_11dac:
	btst	#$1,Mouse_button_state
	bne.b	T_11dac
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
	beq.b	T_11e5c
	cmpi.b	#$13,(a5)
	bne.b	T_11e5c
	move.w	$6(a5),d0
	cmp.w	$24(a2),d0
	bne.b	T_11e5c
	jsr	T_09aac
	btst	#$3,$18(a2)
	beq.b	T_11e52
	subq.b	#$1,(a1)
	moveq	#0,d0
	move.w	$22(a2),d0
	sub.l	d0,$ec(a0)
	move.b	Object_slot_number,d0
	cmpi.b	#$a,d0
	bpl.b	T_11e4e
	bsr.w	Remove_boni
T_11e4e:
	bsr.w	Destroy_used_item
T_11e52:
	bsr.w	Pop_Module
	bsr.w	T_10f3a
	rts
T_11e5c:
	tst.b	$e(a2)
	beq.w	T_11f0e
	move.b	$5(a0),d1
	move.w	$1e(a2),d2
	btst	d1,d2
	bne.b	T_11e7e
	move.w	#$9,d0
	jsr	Plus_message
	bra.w	T_11ffc
T_11e7e:
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
	beq.b	T_11ee2
	bsr.w	Pop_Module
	bsr.w	T_10f3a
T_11ee2:
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
	bne.b	T_11f5a
	move.w	Special_item_flags,d0
	move.b	$15(a2),d1
	subq.b	#$1,d1
	btst	d1,d0
	beq.b	T_11f34
	move.w	#$17,d0
	jsr	Plus_message
	bra.w	Pop_Module
T_11f34:
	bset	d1,d0
	move.w	d0,Special_item_flags
	clr.b	(a1)
	moveq	#0,d0
	move.w	$22(a2),d0
	sub.l	d0,$ec(a0)
	bsr.w	Destroy_used_item
	move.w	#$12,d0
	jsr	Plus_message
	bra.w	Pop_Module
T_11f5a:
	cmpi.b	#$7,$1(a2)
	bne.b	T_11fbe
	lea.l	D_2f25c,a0
	moveq	#0,d0
	move.b	$15(a2),d0
	jsr	Load_subfile
	move.l	a0,Codetxt_ptr
	move.b	$1d(a2),d0
	move.w	d0,WText_nr
	move.l	a0,Textfile_ptr
	lea.l	TxtW_Mod,a0
	move.l	#T_11f9e,$28(a0)
	bsr.w	Push_Module
	rts
T_11f9e:
	clr.l	D_2746e
	move.l	#Code0001Sys,Textfile_ptr
	movea.l	Codetxt_ptr,a0
	jsr	Free_memory
	bra.w	Pop_Module
T_11fbe:
	cmpi.b	#$12,$1(a2)
	bne.b	T_11ffc
	tst.w	Travel_mode
	bne.b	T_11ffc
	cmpi.b	#$1,Current_map_type
	beq.b	T_11fe4
	move.w	#$10,d0
	jsr	Plus_message
	bra.b	T_11ffc
T_11fe4:
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
	bne.b	T_12078
	cmpi.b	#$ff,$e(a2)
	beq.w	T_12122
	subq.b	#$1,$e(a2)
	bne.b	T_120ec
T_12078:
	moveq	#0,d0
	move.w	$22(a2),d0
	sub.l	d0,$ec(a0)
	subq.b	#$1,(a1)
	cmpi.w	#$a,B_5880c
	bpl.b	T_120ec
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
	bne.b	T_120e8
	bsr.w	Negative_boni
	bra.b	T_120ec
T_120e8:
	bsr.w	Positive_boni
T_120ec:
	tst.b	Battling
	bne.b	T_12122
	move.w	B_5880c,d0
	moveq	#0,d2
	move.b	(a2),d2
	bsr.w	Show_item_sparkle
	tst.b	(a1)
	bne.b	T_12122
	move.w	B_5880c,d0
	movea.l	Off_screen,a6
	bsr.w	INV2_Erase_object
	jsr	Switch_screen
	jsr	Copy_screen
T_12122:
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
T_12158:
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
	dbra	d7,T_12158
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
ViewItem_DisInit:
	move.w	#$10,Mesmin_X
	move.w	#$32,Mesmin_Y
	move.w	#$b0,Mesmin_Wd
	move.l	#Code0001Sys,Textfile_ptr
	lea.l	D_2dd3e,a0
	jsr	Push_MA
	moveq	#3,d0
	movea.l	Off_screen,a6
	move.w	#$3,d0
	jsr	Minus_message
	jsr	Switch_screen
	jsr	Copy_screen
T_12262:
	btst	#$1,Mouse_button_state
	bne.b	T_12262
	rts
; ---- Exit_view_item (original source: MAIN/INVENT.ASM)
Exit_view_item:
	bra.w	Pop_Module
T_12272:
	tst.b	d0
	beq.b	Exit_view_item
	ext.w	d0
	addi.w	#$9,d0
	bra.b	T_12284
T_1227e:
	tst.b	d0
	beq.b	Exit_view_item
	ext.w	d0
T_12284:
	btst	#$1,Mouse_button_state
	bne.b	T_12284
	movea.l	Current_inventory_chardat_ptr,a0
	lea.l	$21(a0),a0
	adda.w	d0,a0
	tst.b	(a0)
	beq.b	Exit_view_item
	move.b	d0,Object_slot_number
	lea.l	D_28160,a0
	bsr.w	Push_Module
	rts
T_122b0:
	moveq	#16,d0
	moveq	#112,d1
	moveq	#18,d2
	moveq	#6,d3
	moveq	#2,d4
	moveq	#1,d6
	lea.l	D_2f964,a0
	jsr	Open_window
	move.w	d0,B_58256
	movea.l	Itemdata_ptr,a1
	move.b	Object_slot_number,d0
	ext.w	d0
	subq.w	#$1,d0
	mulu.w	#$28,d0
	adda.w	d0,a1
	movea.l	Off_screen,a6
	btst	#$0,$18(a1)
	sne.b	Cursed
	move.w	#$20,d0
	move.w	#$80,d1
	lea.l	D_363e0,a0
	jsr	Put_unmasked_block
	lea.l	Objects_icn,a0
	move.b	(a1),d2
	ext.w	d2
	lsl.w	#$7,d2
	adda.w	d2,a0
	jsr	Put_masked_block
	moveq	#15,d0
	jsr	IG_Set_ink
	moveq	#2,d0
	jsr	IG_Set_paper
	move.w	#$33,d0
	move.w	#$81,d1
	jsr	IG_Set_cursor
	move.w	$26(a1),d0
	bsr.w	Get_word
	lea.l	Line_buffer,a0
	jsr	IG_Print
	move.w	#$33,d0
	move.w	#$89,d1
	jsr	IG_Set_cursor
	lea.l	D_484e2,a0
	moveq	#0,d0
	move.b	$1(a1),d0
	add.w	d0,d0
	move.w	(a0,d0.w),d0
	bsr.w	Get_word
	lea.l	Line_buffer,a0
	jsr	IG_Print
	move.w	#$b1,d0
	move.w	#$81,d1
	jsr	IG_Set_cursor
	lea.l	D_2db36,a0
	jsr	IG_Print
	lea.l	D_48472,a2
	lea.l	D_2dc32,a4
	moveq	#1,d2
	move.w	$1e(a1),d3
	moveq	#7,d7
T_123ae:
	btst	d2,d3
	beq.b	T_123d4
	move.w	(a4)+,d0
	move.w	(a4)+,d1
	jsr	IG_Set_cursor
	move.w	d2,d0
	add.w	d0,d0
	move.w	(a2,d0.w),d0
	bsr.w	Get_word
	lea.l	Line_buffer,a0
	jsr	IG_Print
T_123d4:
	addq.w	#$1,d2
	dbra	d7,T_123ae
	move.w	#$b1,d0
	move.w	#$a7,d1
	jsr	IG_Set_cursor
	lea.l	D_2db14,a0
	jsr	IG_Print
	lea.l	D_2dd46,a0
	moveq	#0,d0
	move.b	$3(a1),d0
	lsl.w	#$2,d0
	movea.l	(a0,d0.w),a0
	jsr	IG_Print
	lea.l	D_38a60,a0
	move.w	#$100,d0
	move.w	#$b0,d1
	moveq	#2,d6
	moveq	#16,d7
	jsr	Blot_unmasked_block
	btst	#$7,$18(a1)
	sne.b	Xtra_window
	bne.b	T_1244e
	cmpi.w	#$6,Travel_mode
	seq.b	Xtra_window
	beq.b	T_1244e
	lea.l	Chequered,a0
	jsr	Blot_masked_block
T_1244e:
	move.w	#$20,d0
	move.w	#$93,d1
	jsr	IG_Set_cursor
	lea.l	D_2db62,a0
	jsr	IG_Print
	lea.l	Line_buffer,a0
	moveq	#0,d0
	move.w	$22(a1),d0
	moveq	#5,d7
	movea.l	a0,a3
	bsr.w	LConvert_number
	jsr	IG_Print
	lea.l	D_2dc01,a0
	jsr	IG_Print
	move.w	#$20,d0
	move.w	#$9e,d1
	jsr	IG_Set_cursor
	lea.l	D_2db20,a0
	jsr	IG_Print
	lea.l	Line_buffer,a0
	moveq	#0,d0
	move.b	$4(a1),d0
	moveq	#1,d7
	movea.l	a0,a3
	bsr.w	LConvert_number
	jsr	IG_Print
	move.w	#$20,d0
	move.w	#$a6,d1
	jsr	IG_Set_cursor
	lea.l	D_2db2b,a0
	jsr	IG_Print
	lea.l	Line_buffer,a0
	moveq	#0,d0
	move.b	$5(a1),d0
	movea.l	a0,a3
	bsr.w	LConvert_number
	jsr	IG_Print
	move.w	#$20,d0
	move.w	#$ae,d1
	jsr	IG_Set_cursor
	lea.l	D_2db4c,a0
	jsr	IG_Print
	lea.l	Line_buffer,a0
	moveq	#0,d0
	move.b	$11(a1),d0
	tst.b	Cursed
	beq.b	T_12524
	neg.w	d0
T_12524:
	moveq	#3,d7
	movea.l	a0,a3
	bsr.w	LConvert_number
	jsr	IG_Print
	move.w	#$20,d0
	move.w	#$b6,d1
	jsr	IG_Set_cursor
	lea.l	D_2db57,a0
	jsr	IG_Print
	lea.l	Line_buffer,a0
	moveq	#0,d0
	move.b	$10(a1),d0
	tst.b	Cursed
	beq.b	T_12562
	neg.w	d0
T_12562:
	moveq	#3,d7
	movea.l	a0,a3
	bsr.w	LConvert_number
	jsr	IG_Print
	jsr	Switch_screen
	jsr	Copy_screen
	rts
T_1257e:
	btst	#$1,Mouse_button_state
	bne.b	T_1257e
	tst.b	Xtra_window
	beq.b	T_1259a
	lea.l	ItemView2_Mod,a0
	bsr.w	Push_Module
T_1259a:
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
	lea.l	D_2dc05,a0
	jsr	IG_Print
	lea.l	Line_buffer,a0
	moveq	#0,d0
	move.b	$6(a1),d0
	tst.b	Cursed
	beq.b	T_12612
	neg.w	d0
T_12612:
	moveq	#2,d7
	movea.l	a0,a3
	bsr.w	LConvert_number
	jsr	IG_Print
	move.w	#$80,d0
	move.w	#$40,d1
	jsr	IG_Set_cursor
	lea.l	D_2dc0d,a0
	jsr	IG_Print
	lea.l	Line_buffer,a0
	moveq	#0,d0
	move.b	$7(a1),d0
	tst.b	Cursed
	beq.b	T_12650
	neg.w	d0
T_12650:
	moveq	#2,d7
	movea.l	a0,a3
	bsr.w	LConvert_number
	jsr	IG_Print
	move.w	#$30,d0
	move.w	#$47,d1
	jsr	IG_Set_cursor
	lea.l	D_2dc15,a0
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
	lea.l	D_2dc1d,a0
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
	lea.l	D_2db70,a0
	jsr	IG_Print
	tst.b	$8(a1)
	beq.b	T_12746
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
	beq.b	T_12738
	neg.w	d0
T_12738:
	moveq	#2,d7
	movea.l	a0,a3
	bsr.w	LConvert_number
	jsr	IG_Print
T_12746:
	move.w	#$30,d0
	move.w	#$5c,d1
	jsr	IG_Set_cursor
	lea.l	D_2db7e,a0
	jsr	IG_Print
	tst.b	$a(a1)
	beq.b	T_127c6
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
	beq.b	T_127b8
	neg.w	d0
T_127b8:
	moveq	#2,d7
	movea.l	a0,a3
	bsr.w	LConvert_number
	jsr	IG_Print
T_127c6:
	tst.b	$e(a1)
	bne.b	T_127ea
	move.w	#$30,d0
	move.w	#$6a,d1
	jsr	IG_Set_cursor
	lea.l	D_2db88,a0
	jsr	IG_Print
	bra.w	T_128ac
T_127ea:
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
	lea.l	D_2dc29,a0
	jsr	IG_Print
	lea.l	Line_buffer,a0
	moveq	#0,d0
	move.b	$e(a1),d0
	cmpi.b	#$ff,d0
	bne.b	T_12892
	lea.l	D_2dc2c,a0
	jsr	IG_Print
	bra.b	T_128a0
T_12892:
	moveq	#3,d7
	movea.l	a0,a3
	bsr.w	LConvert_number
	jsr	IG_Print
T_128a0:
	lea.l	D_2dc30,a0
	jsr	IG_Print
T_128ac:
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
	beq.b	T_12924
	lea.l	D_2db92,a0
	subq.w	#$1,Curse_count
	bne.b	T_1290c
	move.w	#$4,Curse_count
	lea.l	D_2da84,a1
	move.w	Curse_index,d0
	addq.w	#$1,d0
	move.b	(a1,d0.w),d1
	bpl.b	T_12902
	moveq	#0,d0
	move.b	(a1),d1
T_12902:
	move.w	d0,Curse_index
	move.b	d1,$1(a0)
T_1290c:
	movea.l	Off_screen,a6
	move.w	#$30,d0
	move.w	#$79,d1
	move.w	#$a0,d2
	jsr	Print_centered_string
T_12924:
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
T_1297c:
	btst	#$1,Mouse_button_state
	bne.b	T_1297c
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
	beq.b	T_12df4
	move.w	d0,d1
	mulu.w	#$a,d0
	movea.l	Current_inventory_chardat_ptr,a0
	bsr.w	Scan_4_gold_victims
	bne.b	T_12dd6
	move.w	#$5,d0
	jsr	Plus_message
	bra.b	T_12df4
T_12dd6:
	bsr.w	Show_transfer_victims
	move.l	#T_12df6,TIVS_Ptr
	lea.l	TIVS1_Mod,a0
	move.w	#$19,$2c(a0)
	bsr.w	Push_Module
T_12df4:
	rts
T_12df6:
	btst	#$1,Mouse_button_state
	bne.b	T_12df6
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
	beq.b	T_12e5a
	move.l	#Code0001Sys,Textfile_ptr
	move.w	#$18,ReqText_nr
	move.l	#T_12e5c,ReqDo_ptr
	lea.l	Req_Mod,a0
	bsr.w	Push_Module
T_12e5a:
	rts
T_12e5c:
	movea.l	Current_inventory_chardat_ptr,a1
	move.l	ItemW_nr,d0
	sub.w	d0,$90(a1)
	mulu.w	#$a,d0
	sub.l	d0,$ec(a1)
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
	beq.w	T_12fca
	movea.l	Current_inventory_chardat_ptr,a0
	mulu.w	#$fa,d0
	lea.l	Chard_ptrs,a1
	lea.l	Char_status_icons,a4
	moveq	#0,d6
	moveq	#1,d7
T_12f4e:
	tst.l	(a1)
	beq.b	T_12f84
	cmpa.l	(a1),a0
	bne.b	T_12f5a
	move.w	d7,d5
	bra.b	T_12f84
T_12f5a:
	movea.l	(a1),a2
	move.w	$48(a2),d1
	add.w	$9c(a2),d1
	mulu.w	#$3e8,d1
	sub.l	$ec(a2),d1
	cmp.l	d0,d1
	bmi.b	T_12f84
	move.w	$92(a2),d1
	add.w	d0,d1
	bvs.b	T_12f84
	move.w	#$e402,d1
	and.w	$3a(a2),d1
	bne.b	T_12f84
	bset	d7,d6
T_12f84:
	addq.l	#$4,a1
	addq.w	#$1,d7
	cmpi.w	#$7,d7
	bmi.b	T_12f4e
	bmi.b	T_12f4e
	move.w	d5,Transferring
	move.w	d6,Transfer_victims
	tst.w	d6
	bne.b	T_12fac
	move.w	#$5,d0
	jsr	Plus_message
	bra.b	T_12fca
T_12fac:
	bsr.w	Show_transfer_victims
	move.l	#T_12fcc,TIVS_Ptr
	lea.l	TIVS1_Mod,a0
	move.w	#$1a,$2c(a0)
	bsr.w	Push_Module
T_12fca:
	rts
T_12fcc:
	btst	#$1,Mouse_button_state
	bne.b	T_12fcc
	movea.l	Current_inventory_chardat_ptr,a1
	move.l	ItemW_nr,d0
	add.w	d0,$92(a0)
	sub.w	d0,$92(a1)
	mulu.w	#$fa,d0
	add.l	d0,$ec(a0)
	sub.l	d0,$ec(a1)
	rts
T_12ff8:
	btst	#$1,Mouse_button_state
	bne.b	T_12ff8
	tst.l	ItemW_nr
	beq.b	T_13030
	move.l	#Code0001Sys,Textfile_ptr
	move.w	#$19,ReqText_nr
	move.l	#T_13032,ReqDo_ptr
	lea.l	Req_Mod,a0
	bsr.w	Push_Module
T_13030:
	rts
T_13032:
	movea.l	Current_inventory_chardat_ptr,a1
	move.l	ItemW_nr,d0
	sub.w	d0,$92(a1)
	mulu.w	#$fa,d0
	sub.l	d0,$ec(a1)
	bra.w	Pop_Module
T_1304e:
	btst	#$1,Mouse_button_state
	bne.b	T_1304e
	tst.b	d0
	beq.w	T_13216
	ext.w	d0
	addi.w	#$9,d0
	movea.l	Current_inventory_chardat_ptr,a0
	lea.l	$21(a0),a1
	adda.w	d0,a1
	tst.b	(a1)
	beq.w	T_13216
	lea.l	$10a(a0),a2
	moveq	#40,d1
	mulu.w	d0,d1
	adda.w	d1,a2
	movea.l	Off_screen,a6
	tst.b	Battling
	beq.b	T_13098
	btst	#$4,$18(a2)
	beq.w	T_13216
T_13098:
	move.b	$12(a2),d1
	beq.b	T_130b0
	cmpi.b	#$7,d1
	beq.b	T_130be
	lea.l	$21(a0),a3
	ext.w	d1
	tst.b	(a3,d1.w)
	beq.b	T_130be
T_130b0:
	move.w	#$8,d0
	jsr	Plus_message
	bra.w	T_13216
T_130be:
	move.b	$5(a0),d1
	move.w	$1e(a2),d2
	btst	d1,d2
	bne.b	T_130d8
	move.w	#$9,d0
	jsr	Plus_message
	bra.w	T_13216
T_130d8:
	move.b	$3(a2),d1
	beq.b	T_130f4
	subq.b	#$1,d1
	cmp.b	$3(a0),d1
	beq.b	T_130f4
	move.w	#$a,d0
	jsr	Plus_message
	bra.w	T_13216
T_130f4:
	move.b	$4(a2),d1
	beq.b	T_13112
	moveq	#2,d2
	sub.b	$1c(a0),d2
	cmp.b	d1,d2
	bpl.b	T_13112
	move.w	#$b,d0
	jsr	Plus_message
	bra.w	T_13216
T_13112:
	move.b	$5(a2),d1
	beq.b	T_13130
	moveq	#2,d2
	sub.b	$1d(a0),d2
	cmp.b	d1,d2
	bpl.b	T_13130
	move.w	#$c,d0
	jsr	Plus_message
	bra.w	T_13216
T_13130:
	lea.l	$21(a0),a3
	move.b	$12(a2),d1
	cmpi.b	#$7,d1
	bne.b	T_13146
	tst.b	$7(a3)
	beq.b	T_13146
	addq.b	#$2,d1
T_13146:
	ext.w	d1
	adda.w	d1,a3
	lea.l	$10a(a0),a4
	moveq	#40,d2
	mulu.w	d1,d2
	adda.w	d2,a4
	move.b	$4(a2),d2
	add.b	d2,$1c(a0)
	move.b	$5(a2),d2
	add.b	d2,$1d(a0)
	move.b	$13(a2),d2
	add.b	d2,$20(a0)
	move.b	$14(a2),d2
	add.b	d2,$21(a0)
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
	bne.b	T_131ae
	bsr.w	Positive_boni
	bra.b	T_131b2
T_131ae:
	bsr.w	Negative_boni
T_131b2:
	move.b	#$1,(a3)
	moveq	#19,d7
T_131b8:
	move.w	(a2)+,(a4)+
	dbra	d7,T_131b8
	lea.l	-$28(a2),a2
	lea.l	-$28(a4),a4
	cmpi.b	#$2,$4(a2)
	bne.b	T_131e4
	cmpi.w	#$4,d1
	bne.b	T_131e4
	movem.l	d0-d1,-(a7)
	moveq	#0,d0
	moveq	#6,d1
	bsr.w	INV2_Show_object
	movem.l	(a7)+,d0-d1
T_131e4:
	subq.b	#$1,(a1)
	bne.b	T_131ee
	bsr.w	INV2_Erase_object
	bra.b	T_13204
T_131ee:
	cmpi.b	#$1,(a1)
	bne.b	T_13204
	movem.w	d0-d1,-(a7)
	move.b	d0,d1
	move.b	(a2),d0
	bsr.w	INV2_Show_object
	movem.w	(a7)+,d0-d1
T_13204:
	move.b	(a4),d0
	bsr.w	INV2_Show_object
	jsr	Switch_screen
	jsr	Copy_screen
T_13216:
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
TIVS_ModInit:
	lea.l	D_2fcfa,a0
	jsr	Push_MA
	movea.l	Module_sp,a0
	cmpi.w	#$18,$2c(a0)
	bne.b	T_13484
	move.b	TIVS_Icon_nr,d0
	bsr.w	Build_object_mptr
T_13484:
	movea.l	Off_screen,a6
	move.w	#$13,d0
	jsr	Minus_message
	jsr	Switch_screen
	jsr	Copy_screen
T_134a0:
	btst	#$1,Mouse_button_state
	bne.b	T_134a0
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
	move.b	$1a(a0),d0
	moveq	#0,d1
	moveq	#1,d2
	moveq	#6,d7
T_13792:
	btst	d2,d0
	beq.b	T_1379e
	move.w	d2,Selected_class
	addq.w	#$1,d1
T_1379e:
	addq.w	#$1,d2
	dbra	d7,T_13792
	move.w	d1,B_58816
	lea.l	$d0(a0),a0
	move.w	Selected_class,d0
	add.w	d0,d0
	add.w	d0,d0
	tst.l	-$4(a0,d0.w)
	beq.b	T_137da
	cmpi.w	#$1,d1
	bne.b	T_137d0
	lea.l	SpSelW_Mod,a0
	bsr.w	Push_Module
	bra.b	T_137da
T_137d0:
	lea.l	SCSelW_Mod,a0
	bsr.w	Push_Module
T_137da:
	rts
