; MAIN/INVENT.ASM (original module, merged with the disassembly of the shipped program)

	section	text

; ---- Inv1_DisUpd (original source: MAIN/INVENT.ASM)
Inv1_DisUpd:
	jsr	Update_status_block
	rts	
T_10b58:
	btst	#$1,Mouse_button_state
	bne.b	T_10b58
	bsr.w	Pop_Module
	bra.w	Init_display
Inv1_ModInit:
	lea.l	D_31738,a0
	jsr	Push_PA
	lea.l	D_31730,a0
	jsr	Push_MA
	movea.l	Current_inventory_chardat_ptr,a0
	lea.l	$22(a0),a1
	lea.l	$132(a0),a0
	move.l	a0,Itemdata_ptr
	move.l	a1,Itemslots_ptr
	tst.b	B_5b82a
	beq.b	.l_10bac
	sf.b	B_5b82a
	bra.b	.l_10bb0
.l_10bac:
	bsr.w	Inv1_DisInit
.l_10bb0:
	rts
Inv1_ModExit:
	jsr	Pop_MA
	jsr	Pop_PA
	bsr.w	Inv1_DisExit
	tst.b	Battling
	beq.b	.l_10bce
	bsr.w	T_16b66
.l_10bce:
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
	lea.l	D_4b412,a2
	lea.l	$6(a1),a4
	lea.l	$b0(a1),a5
.l_10c22:
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
	bmi.b	.l_10c22
	move.w	#$16,d0
	move.w	#$32,d1
	move.w	#$48,d2
	lea.l	D_30a0e,a0
	jsr	Print_centered_string
	lea.l	D_4a2fa,a2
	move.w	#$16,d2
	move.w	#$39,d3
	moveq	#0,d6
	moveq	#3,d7
	lea.l	$48(a1),a4
	lea.l	$9c(a1),a5
.l_10cbc:
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
	bmi.b	.l_10cbc
	move.w	#$6a,d0
	move.w	#$32,d1
	jsr	IG_Set_cursor
	lea.l	D_30a24,a0
	jsr	IG_Print
	lea.l	Misc_dat,a2
	move.w	#$39,d1
	move.w	#$6a,d2
	move.b	$37(a1),d6
	moveq	#0,d7
.l_10d4e:
	move.w	d2,d0
	jsr	IG_Set_cursor
	btst	d7,d6
	beq.b	.l_10d6e
	move.w	(a2),d0
	bsr.w	Get_word
	lea.l	Line_buffer,a0
	jsr	IG_Print
	addq.w	#$7,d1
.l_10d6e:
	addq.l	#$2,a2
	addq.w	#$1,d7
	cmpi.b	#$8,d7
	bmi.b	.l_10d4e
	move.w	#$6a,d0
	move.w	#$73,d1
	jsr	IG_Set_cursor
	lea.l	D_30a31,a0
	jsr	IG_Print
	move.w	#$6a,d2
	move.w	#$7c,d3
	lea.l	Status_icn,a0
	lea.l	D_30bdc,a2
	move.b	$3a(a1),d6
	move.b	#$e0,d7
	and.b	d6,d7
	beq.b	.l_10dbe
	move.w	d2,d0
	move.w	d3,d1
	jsr	Blit_masked_block
	bra.b	.l_10e38
.l_10dbe:
	lea.l	$480(a0),a0
	moveq	#0,d7
.l_10dc4:
	btst	d7,d6
	beq.b	.l_10dd6
	move.w	d2,d0
	move.w	d3,d1
	add.w	(a2)+,d0
	add.w	(a2)+,d1
	jsr	Blit_masked_block
.l_10dd6:
	lea.l	$80(a0),a0
	addq.w	#$1,d7
	cmpi.w	#$6,d7
	bmi.b	.l_10dc4
	move.w	#$9a,d0
	move.w	#$73,d1
	jsr	IG_Set_cursor
	lea.l	D_30a3c,a0
	jsr	IG_Print
	move.w	#$9a,d2
	move.w	#$7c,d3
	move.b	$3b(a1),d6
	moveq	#0,d7
	lea.l	Status_icn,a0
	lea.l	D_30bdc,a2
	lea.l	$700(a0),a0
.l_10e1a:
	btst	d7,d6
	beq.b	.l_10e2c
	move.w	d2,d0
	move.w	d3,d1
	add.w	(a2)+,d0
	add.w	(a2)+,d1
	jsr	Blit_masked_block
.l_10e2c:
	lea.l	$80(a0),a0
	addq.w	#$1,d7
	cmpi.w	#$6,d7
	bmi.b	.l_10e1a
.l_10e38:
	move.l	#D_30952,Control_list_ptr
	jsr	Show_control_icons
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	Control_area,a0
	jsr	Set_layout_data
	tst.b	Fade_block
	beq.b	.l_10e70
	sf.b	Fade_block
	bra.b	.l_10ea2
.l_10e70:
	lea.l	D_332e6,a1
	lea.l	Subfade1,a2
.l_10e7c:
	lea.l	Hbl_Inv1_list,a0
	jsr	Update_HBL
	jsr	My_vsync
	jsr	My_vsync
	lea.l	Inv1_below,a0
	jsr	Fade_pal
	bne.b	.l_10e7c
.l_10ea2:
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
T_10f12:
	btst	#$1,Mouse_button_state
	bne.b	T_10f12
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
T_10f3c:
	btst	#$1,Mouse_button_state
	bne.b	T_10f3c
	bsr.w	Pop_Module
	bra.w	T_10b58
T_10f4e:
	btst	#$1,Mouse_button_state
	bne.b	T_10f4e
	bsr.w	Pop_Module
	bra.w	Init_display
Inv2_DisUpd:
	jsr	Update_status_block
	lea.l	D_30980,a0
	lea.l	Inv2CIL_evaluate,a1
	bsr.w	Update_control_icons
	bsr.w	Update_quantity_colours
	rts
T_10f7c:
	lea.l	D_31738,a0
	jsr	Push_PA
	lea.l	D_31730,a0
	jsr	Push_MA
	bra.w	Inv2_DisInit
T_10f98:
	clr.w	B_5b94e
	jsr	Pop_MA
	jsr	Pop_PA
	bra.w	Inv2_DisExit
Inv2_DisInit:
	move.w	#$10,Mesmin_X
	move.w	#$32,Mesmin_Y
	move.w	#$b0,Mesmin_Wd
	move.l	#Code0001Sys,Textfile_ptr
	move.l	#D_30cf8,PlusMes_info
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
	bmi.b	.l_11032
	lea.l	$9(a2),a2
	lea.l	$168(a4),a4
	addi.w	#$9,d1
	subi.w	#$9,d7
.l_11032:
	tst.b	(a2)+
	beq.b	.l_1103c
	move.b	(a4),d0
	bsr.w	INV2_Show_object
.l_1103c:
	addq.l	#$1,d1
	lea.l	$28(a4),a4
	dbra	d7,.l_11032
	lea.l	$25(a1),a2
	tst.b	(a2)
	beq.b	.l_11062
	lea.l	$1aa(a1),a3
	cmpi.b	#$2,$4(a3)
	bne.b	.l_11062
	moveq	#0,d0
	moveq	#6,d1
	bsr.w	INV2_Show_object
.l_11062:
	move.w	#$10,d0
	move.w	#$b2,d1
	move.w	#$50,d2
	lea.l	D_30a46,a0
	jsr	Print_centered_string
	lea.l	D_30980,a0
	bsr.w	Inv2CIL_evaluate
	move.l	a0,Control_list_ptr
	jsr	Show_control_icons
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	D_32702,a0
	jsr	Set_layout_data
	tst.b	Fade_block
	beq.b	.l_110b8
	sf.b	Fade_block
	bra.b	.l_110ea
.l_110b8:
	lea.l	D_309ae,a1
	lea.l	Subfade1,a2
.l_110c4:
	lea.l	Hbl_Inv2_list,a0
	jsr	Update_HBL
	jsr	My_vsync
	jsr	My_vsync
	lea.l	Inv2_below,a0
	jsr	Hbl_fade
	bne.b	.l_110c4
.l_110ea:
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
T_11246:
	movea.l	Current_inventory_chardat_ptr,a0
	move.l	$ec(a0),d2
	divu.w	#$3e8,d2
	ext.l	d2
	moveq	#0,d3
	move.w	$48(a0),d3
	add.w	$9c(a0),d3
	lea.l	D_30b79,a0
	cmp.l	d2,d3
	bpl.b	.l_1128e
	lea.l	D_309f2,a1
	move.w	Curse_index,d0
	addq.w	#$1,d0
	move.b	(a1,d0.w),d1
	bpl.b	.l_11282
	moveq	#0,d0
	move.b	(a1),d1
.l_11282:
	move.w	d0,Curse_index
	move.b	d1,$1(a0)
	bra.b	.l_11294
.l_1128e:
	move.b	#$f,$1(a0)
.l_11294:
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
	beq.b	.c_11312	; CHANGE: added
	bset	#$7,$1(a0)	; CHANGE: added
	bset	#$7,$4(a0)	; CHANGE: added
	bset	#$7,$6(a0)	; CHANGE: added
	bset	#$7,$7(a0)	; CHANGE: added
	bset	#$7,$8(a0)	; CHANGE: added
	move.w	$3a(a1),d0	; CHANGE: added
	andi.w	#$e480,d0	; CHANGE: added
	beq.b	.c_11312	; CHANGE: added
	bset	#$7,$3(a0)	; CHANGE: added
.c_11312:
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
	beq.b	.l_1142e
	lea.l	Female_name,a0
	bra.b	.l_11434
.l_1142e:
	lea.l	Male_name,a0
.l_11434:
	jsr	IG_Print
	cmpi.b	#$9,$4(a1)
	bpl.b	.l_114b8
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
	beq.b	.l_114b8
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
.l_114b8:
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
	lea.l	D_30b34,a0
	move.l	$cc(a1),d0
	moveq	#6,d7
	lea.l	$3(a0),a3
	bsr.w	LConvert_number
	jsr	IG_Print
	move.w	#$d6,d0
	move.w	#$78,d1
	moveq	#1,d6
	moveq	#10,d7
	lea.l	D_44e1a,a0
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
T_11814:
	tst.b	Print_objname_flag
	beq.b	.l_11868
	lea.l	.l_1186a(pc),a0
	jsr	IG_Print
	move.w	Object_name_nr,d0
	beq.b	.l_11868
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
.l_11868:
	rts
.l_1186a:
	dc.b	$01,$0f,$02,$ff,$00,$00
T_11870:
	tst.b	Erase_objname_flag
	beq.b	.l_118a4
	move.w	#$10,d0
	move.w	#$3a,d1
	move.w	#$bf,d2
	move.w	#$40,d3
	move.w	#$2,d6
	movea.l	Off_screen,a6
	jsr	Draw_box
	subq.b	#$1,Erase_objname_flag
	clr.w	Object_name_nr
.l_118a4:
	rts
T_118a6:
	btst	#$1,Mouse_button_state
	bne.b	T_118a6
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
	move.l	#.l_11b04,ReqDo_ptr
	lea.l	Req_Mod,a0
	bra.w	Push_Module
.l_11b04:
	btst	#$1,Mouse_button_state
	bne.b	.l_11b04
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
	bne.b	.l_11b74
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
	bra.b	.l_11bac
.l_11b74:
	dc.b	$0c,$11,$00,$01,$66,$32,$10,$12,$12,$39
	dc.l	Object_slot_number
	dc.b	$61,$00,$f5,$b4,$30,$3c,$00,$10,$32,$3c,$00,$3a,$34,$3c,$00,$bf
	dc.b	$36,$3c,$00,$40,$3c,$3c,$00,$02,$4e,$b9
	dc.l	Draw_box
	dc.b	$4e,$b9
	dc.l	Switch_screen
	dc.b	$4e,$b9
	dc.l	Copy_screen
.l_11bac:
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
	move.w	d0,B_5b288
	movea.l	Off_screen,a6
	moveq	#2,d6
	moveq	#16,d7
	move.w	#$30,d0
	move.w	#$a0,d1
	lea.l	D_3afea,a0
	jsr	Blot_unmasked_block
	move.w	#$30,d0
	move.w	#$b0,d1
	lea.l	D_3b0ea,a0
	jsr	Blot_unmasked_block
	move.w	#$80,d0
	move.w	#$b0,d1
	lea.l	D_3ccea,a0
	jsr	Blot_unmasked_block
	bsr.w	ItemW_DisUpd
	movem.l	(a7)+,d0-d3/d6-d7/a0/a6
	rts
ItemW_DisExit:
	move.w	B_5b288,d0
	jsr	Close_window
	jsr	Copy_screen
	movea.l	Off_screen,a6
	jsr	Erase_message_minus
	jsr	Switch_screen
	jsr	Copy_screen
.l_11cb4:
	btst	#$1,Mouse_button_state
	bne.b	.l_11cb4
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
T_11d6e:
	btst	#$1,Mouse_button_state
	bne.b	T_11d6e
	lea.l	UseItem_Mod,a0
	bsr.w	Push_Module
	rts
UseItem_DisInit:
	lea.l	D_30cc8,a0
	jsr	Push_MA
	moveq	#2,d0
	movea.l	Off_screen,a6
	move.w	#$2,d0
	jsr	Minus_message
	jsr	Switch_screen
	jsr	Copy_screen
.l_11dae:
	btst	#$1,Mouse_button_state
	bne.b	.l_11dae
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
	beq.w	T_11ffe
	lea.l	$10a(a0),a2
	mulu.w	#$28,d0
	adda.w	d0,a2
	move.w	Map_Xcoord,d0
	move.w	Map_Ycoord,d1
	jsr	Find_event
	beq.b	.l_11e5e
	cmpi.b	#$13,(a5)
	bne.b	.l_11e5e
	move.w	$6(a5),d0
	cmp.w	$24(a2),d0
	bne.b	.l_11e5e
	jsr	T_09aac
	btst	#$3,$18(a2)
	beq.b	.l_11e54
	subq.b	#$1,(a1)
	moveq	#0,d0
	move.w	$22(a2),d0
	sub.l	d0,$ec(a0)
	move.b	Object_slot_number,d0
	cmpi.b	#$a,d0
	bpl.b	.l_11e50
	bsr.w	Remove_boni
.l_11e50:
	bsr.w	Destroy_used_item
.l_11e54:
	bsr.w	Pop_Module
	bsr.w	T_10f3c
	rts
.l_11e5e:
	tst.b	$e(a2)
	beq.w	T_11f10
	move.b	$5(a0),d1
	move.w	$1e(a2),d2
	btst	d1,d2
	bne.b	.l_11e80
	move.w	#$9,d0
	jsr	Plus_message
	bra.w	T_11ffe
.l_11e80:
	lea.l	D_4b42e,a3
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
	beq.b	.l_11ee4
	bsr.w	Pop_Module
	bsr.w	T_10f3c
.l_11ee4:
	moveq	#0,d0
	move.b	$c(a2),d0
	move.w	d0,Selected_class
	move.b	$d(a2),d0
	move.w	d0,Selected_spell
	st.b	Magic_object_flag
	bsr.w	Do_magic
	move.l	#Code0001Sys,Textfile_ptr
	rts
T_11f10:
	cmpi.b	#$d,$1(a2)
	bne.b	.l_11f5c
	move.w	Special_item_flags,d0
	move.b	$15(a2),d1
	subq.b	#$1,d1
	btst	d1,d0
	beq.b	.l_11f36
	move.w	#$17,d0
	jsr	Plus_message
	bra.w	Pop_Module
.l_11f36:
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
.l_11f5c:
	cmpi.b	#$7,$1(a2)
	bne.b	.l_11fc0
	lea.l	D_321e6,a0
	moveq	#0,d0
	move.b	$15(a2),d0
	jsr	Load_subfile
	move.l	a0,Codetxt_ptr
	move.b	$1d(a2),d0
	move.w	d0,WText_nr
	move.l	a0,Textfile_ptr
	lea.l	TxtW_Mod,a0
	move.l	#.l_11fa0,$28(a0)
	bsr.w	Push_Module
	rts
.l_11fa0:
	clr.l	D_2a3dc
	move.l	#Code0001Sys,Textfile_ptr
	movea.l	Codetxt_ptr,a0
	jsr	Free_memory
	bra.w	Pop_Module
.l_11fc0:
	cmpi.b	#$12,$1(a2)
	bne.b	T_11ffe
	tst.w	Travel_mode
	bne.b	T_11ffe
	cmpi.b	#$1,Current_map_type
	beq.b	.l_11fe6
	move.w	#$10,d0
	jsr	Plus_message
	bra.b	T_11ffe
.l_11fe6:
	moveq	#4,d0
	jsr	Set_new_travel_mode
	bsr.w	Pop_Module
	bsr.w	Pop_Module
	bsr.w	Pop_Module
	bra.w	Init_display
T_11ffe:
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
	movea.l	B_5b840,a0
	lea.l	$21(a0),a1
	lea.l	$10a(a0),a2
	move.w	B_5b83e,d0
	adda.w	d0,a1
	mulu.w	#$28,d0
	adda.w	d0,a2
	btst	#$2,$18(a2)
	bne.b	.l_1207a
	cmpi.b	#$ff,$e(a2)
	beq.w	.l_12124
	subq.b	#$1,$e(a2)
	bne.b	.l_120ee
.l_1207a:
	moveq	#0,d0
	move.w	$22(a2),d0
	sub.l	d0,$ec(a0)
	subq.b	#$1,(a1)
	cmpi.w	#$a,B_5b83e
	bpl.b	.l_120ee
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
	bne.b	.l_120ea
	bsr.w	Negative_boni
	bra.b	.l_120ee
.l_120ea:
	bsr.w	Positive_boni
.l_120ee:
	tst.b	Battling
	bne.b	.l_12124
	move.w	B_5b83e,d0
	moveq	#0,d2
	move.b	(a2),d2
	bsr.w	Show_item_sparkle
	tst.b	(a1)
	bne.b	.l_12124
	move.w	B_5b83e,d0
	movea.l	Off_screen,a6
	bsr.w	INV2_Erase_object
	jsr	Switch_screen
	jsr	Copy_screen
.l_12124:
	movem.l	(a7)+,d0-d1/a0-a2/a5-a6
	rts
; The item sparkles in its slot (8 frames of 3 vertical blanks).
Show_item_sparkle:
	movem.l	d0-d2/d7/a0-a4/a6,-(a7)
	lea.l	D_30bf0,a1
	add.w	d0,d0
	add.w	d0,d0
	move.w	$2(a1,d0.w),d1
	move.w	(a1,d0.w),d0
	lea.l	Objects_icn,a1
	ext.w	d2
	lsl.w	#$7,d2
	adda.w	d2,a1
	lea.l	D_49d92,a3
	lea.l	D_3936a,a4
	moveq	#7,d7
.l_1215a:
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
	dbra	d7,.l_1215a
	movea.l	Off_screen,a6
	movea.l	a4,a0
	jsr	Put_unmasked_block
	movea.l	a1,a0
	jsr	Put_masked_block
	jsr	Switch_screen
	jsr	Copy_screen
	movem.l	(a7)+,d0-d2/d7/a0-a4/a6
	rts
T_121c0:
	btst	#$1,Mouse_button_state
	bne.b	T_121c0
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
	lea.l	D_30cc8,a0
	jsr	Push_MA
	moveq	#3,d0
	movea.l	Off_screen,a6
	move.w	#$3,d0
	jsr	Minus_message
	jsr	Switch_screen
	jsr	Copy_screen
.l_12264:
	btst	#$1,Mouse_button_state
	bne.b	.l_12264
	rts
; ---- Exit_view_item (original source: MAIN/INVENT.ASM)
Exit_view_item:
	bra.w	Pop_Module
T_12274:
	tst.b	d0
	beq.b	Exit_view_item
	ext.w	d0
	addi.w	#$9,d0
	bra.b	T_12286
T_12280:
	tst.b	d0
	beq.b	Exit_view_item
	ext.w	d0
T_12286:
	btst	#$1,Mouse_button_state
	bne.b	T_12286
	movea.l	Current_inventory_chardat_ptr,a0
	lea.l	$21(a0),a0
	adda.w	d0,a0
	tst.b	(a0)
	beq.b	Exit_view_item
	move.b	d0,Object_slot_number
	lea.l	D_2b0ce,a0
	bsr.w	Push_Module
	rts
T_122b2:
	moveq	#16,d0
	moveq	#112,d1
	moveq	#18,d2
	moveq	#6,d3
	moveq	#2,d4
	moveq	#1,d6
	lea.l	D_328ee,a0
	jsr	Open_window
	move.w	d0,B_5b288
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
	lea.l	D_3936a,a0
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
	lea.l	D_4b46c,a0
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
	lea.l	D_30abb,a0
	jsr	IG_Print
	lea.l	D_4b3fc,a2
	lea.l	D_30bbc,a4
	moveq	#1,d2
	move.w	$1e(a1),d3
	moveq	#7,d7
.l_123b0:
	btst	d2,d3
	beq.b	.l_123d6
	move.w	(a4)+,d0
	move.w	(a4)+,d1
	jsr	IG_Set_cursor
	move.w	d2,d0
	add.w	d0,d0
	move.w	(a2,d0.w),d0
	bsr.w	Get_word
	lea.l	Line_buffer,a0
	jsr	IG_Print
.l_123d6:
	addq.w	#$1,d2
	dbra	d7,.l_123b0
	move.w	#$b1,d0
	move.w	#$a7,d1
	jsr	IG_Set_cursor
	lea.l	D_30a95,a0
	jsr	IG_Print
	lea.l	D_30cd0,a0
	moveq	#0,d0
	move.b	$3(a1),d0
	lsl.w	#$2,d0
	movea.l	(a0,d0.w),a0
	jsr	IG_Print
	lea.l	D_3b9ea,a0
	move.w	#$100,d0
	move.w	#$b0,d1
	moveq	#2,d6
	moveq	#16,d7
	jsr	Blot_unmasked_block
	btst	#$7,$18(a1)
	sne.b	Xtra_window
	bne.b	.l_12450
	cmpi.w	#$6,Travel_mode
	seq.b	Xtra_window
	beq.b	.l_12450
	lea.l	Chequered,a0
	jsr	Blot_masked_block
.l_12450:
	move.w	#$20,d0
	move.w	#$93,d1
	jsr	IG_Set_cursor
	lea.l	D_30ae7,a0
	jsr	IG_Print
	lea.l	Line_buffer,a0
	moveq	#0,d0
	move.w	$22(a1),d0
	moveq	#5,d7
	movea.l	a0,a3
	bsr.w	LConvert_number
	jsr	IG_Print
	lea.l	D_30b8b,a0
	jsr	IG_Print
	move.w	#$20,d0
	move.w	#$9e,d1
	jsr	IG_Set_cursor
	lea.l	D_30aa5,a0
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
	lea.l	D_30ab0,a0
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
	lea.l	D_30ad1,a0
	jsr	IG_Print
	lea.l	Line_buffer,a0
	moveq	#0,d0
	move.b	$11(a1),d0
	tst.b	Cursed
	beq.b	.l_12526
	neg.w	d0
.l_12526:
	moveq	#3,d7
	movea.l	a0,a3
	bsr.w	LConvert_number
	jsr	IG_Print
	move.w	#$20,d0
	move.w	#$b6,d1
	jsr	IG_Set_cursor
	lea.l	D_30adc,a0
	jsr	IG_Print
	lea.l	Line_buffer,a0
	moveq	#0,d0
	move.b	$10(a1),d0
	tst.b	Cursed
	beq.b	.l_12564
	neg.w	d0
.l_12564:
	moveq	#3,d7
	movea.l	a0,a3
	bsr.w	LConvert_number
	jsr	IG_Print
	jsr	Switch_screen
	jsr	Copy_screen
	rts
T_12580:
	btst	#$1,Mouse_button_state
	bne.b	T_12580
	tst.b	Xtra_window
	beq.b	.l_1259c
	lea.l	ItemView2_Mod,a0
	bsr.w	Push_Module
.l_1259c:
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
	lea.l	D_30b8f,a0
	jsr	IG_Print
	lea.l	Line_buffer,a0
	moveq	#0,d0
	move.b	$6(a1),d0
	tst.b	Cursed
	beq.b	.l_12614
	neg.w	d0
.l_12614:
	moveq	#2,d7
	movea.l	a0,a3
	bsr.w	LConvert_number
	jsr	IG_Print
	move.w	#$80,d0
	move.w	#$40,d1
	jsr	IG_Set_cursor
	lea.l	D_30b97,a0
	jsr	IG_Print
	lea.l	Line_buffer,a0
	moveq	#0,d0
	move.b	$7(a1),d0
	tst.b	Cursed
	beq.b	.l_12652
	neg.w	d0
.l_12652:
	moveq	#2,d7
	movea.l	a0,a3
	bsr.w	LConvert_number
	jsr	IG_Print
	move.w	#$30,d0
	move.w	#$47,d1
	jsr	IG_Set_cursor
	lea.l	D_30b9f,a0
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
	lea.l	D_30ba7,a0
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
	lea.l	D_30af6,a0
	jsr	IG_Print
	tst.b	$8(a1)
	beq.b	.l_12748
	move.w	#$30,d0
	move.w	#$55,d1
	jsr	IG_Set_cursor
	lea.l	D_4a2fa,a2
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
	beq.b	.l_1273a
	neg.w	d0
.l_1273a:
	moveq	#2,d7
	movea.l	a0,a3
	bsr.w	LConvert_number
	jsr	IG_Print
.l_12748:
	move.w	#$30,d0
	move.w	#$5c,d1
	jsr	IG_Set_cursor
	lea.l	D_30b03,a0
	jsr	IG_Print
	tst.b	$a(a1)
	beq.b	.l_127c8
	move.w	#$30,d0
	move.w	#$63,d1
	jsr	IG_Set_cursor
	lea.l	D_4b412,a2
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
	beq.b	.l_127ba
	neg.w	d0
.l_127ba:
	moveq	#2,d7
	movea.l	a0,a3
	bsr.w	LConvert_number
	jsr	IG_Print
.l_127c8:
	tst.b	$e(a1)
	bne.b	.l_127ec
	move.w	#$30,d0
	move.w	#$6a,d1
	jsr	IG_Set_cursor
	lea.l	D_30b11,a0
	jsr	IG_Print
	bra.w	.l_128ae
.l_127ec:
	move.w	#$30,d0
	move.w	#$6a,d1
	jsr	IG_Set_cursor
	moveq	#1,d0
	jsr	IG_Set_ink
	lea.l	D_4b7f2,a2
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
	lea.l	D_4b800,a2
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
	lea.l	D_30bb3,a0
	jsr	IG_Print
	lea.l	Line_buffer,a0
	moveq	#0,d0
	move.b	$e(a1),d0
	cmpi.b	#$ff,d0
	bne.b	.l_12894
	lea.l	D_30bb6,a0
	jsr	IG_Print
	bra.b	.l_128a2
.l_12894:
	moveq	#3,d7
	movea.l	a0,a3
	bsr.w	LConvert_number
	jsr	IG_Print
.l_128a2:
	lea.l	D_30bba,a0
	jsr	IG_Print
.l_128ae:
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
	beq.b	.l_12926
	lea.l	D_30b1b,a0
	subq.w	#$1,Curse_count
	bne.b	.l_1290e
	move.w	#$4,Curse_count
	lea.l	D_309f2,a1
	move.w	Curse_index,d0
	addq.w	#$1,d0
	move.b	(a1,d0.w),d1
	bpl.b	.l_12904
	moveq	#0,d0
	move.b	(a1),d1
.l_12904:
	move.w	d0,Curse_index
	move.b	d1,$1(a0)
.l_1290e:
	movea.l	Off_screen,a6
	move.w	#$30,d0
	move.w	#$79,d1
	move.w	#$a0,d2
	jsr	Print_centered_string
.l_12926:
	rts
T_12928:
	bsr.w	Pop_Module
	bra.w	Pop_Module
T_12930:
	move.l	d0,-(a7)
	move.w	B_5b288,d0
	jsr	Close_window
	move.l	(a7)+,d0
	rts
T_12942:
	btst	#$1,Mouse_button_state
	bne.b	T_12942
	lea.l	TransferItem_Mod,a0
	bra.w	Push_Module
T_12956:
	lea.l	Backpack_area,a0
	jsr	Push_MA
	movea.l	Off_screen,a6
	move.w	#$4,d0
	jsr	Minus_message
	jsr	Switch_screen
	jsr	Copy_screen
.l_1297e:
	btst	#$1,Mouse_button_state
	bne.b	.l_1297e
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
T_12a00:
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
	move.l	#T_12b2c,TIVS_Ptr	; CHANGE: was "move.l #Inv2_Do_TI,TIVS_Ptr"
	lea.l	TIVS1_Mod,a0
	move.w	#24,Mouse_ptr(a0)
	bra.w	Push_Module
T_12b2c:
	btst	#$1,Mouse_button_state
	bne.b	T_12b2c
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
T_12c40:
	btst	#$1,Mouse_button_state
	bne.b	T_12c40
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
	st.b	B_5b82b	; CHANGE: added
	lea.l	TransGold_Mod,a0	; CHANGE: added
	bsr.w	Push_Module	; CHANGE: added
	sf.b	B_5b82b	; CHANGE: added
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
	lea.l	D_32894,a0	; CHANGE: added
	jsr	Open_window	; CHANGE: added
	move.w	d0,B_5b288	; CHANGE: added
	movea.l	Off_screen,a6	; CHANGE: added
	moveq	#2,d6	; CHANGE: added
	moveq	#16,d7	; CHANGE: added
	move.w	#$30,d0	; CHANGE: added
	move.w	#$a0,d1	; CHANGE: added
	lea.l	D_3afea,a0	; CHANGE: added
	jsr	Blot_unmasked_block	; CHANGE: added
	move.w	#$30,d0	; CHANGE: added
	move.w	#$b0,d1	; CHANGE: added
	lea.l	D_3b0ea,a0	; CHANGE: added
	jsr	Blot_unmasked_block	; CHANGE: added
	move.w	#$80,d0	; CHANGE: added
	move.w	#$b0,d1	; CHANGE: added
	lea.l	D_3ccea,a0	; CHANGE: added
	jsr	Blot_unmasked_block	; CHANGE: added
	bsr.w	ItemW_DisUpd	; CHANGE: added
	tst.b	B_5b82b	; CHANGE: added
	beq.b	.c_12d36	; CHANGE: added
	move.w	#$80,d0	; CHANGE: added
	move.w	#$a0,d1	; CHANGE: added
	moveq	#2,d6	; CHANGE: added
	moveq	#16,d7	; CHANGE: added
	lea.l	D_3d0ea,a0	; CHANGE: added
	jsr	Blot_unmasked_block	; CHANGE: added
.c_12d36:
	move.w	#$31,d0	; CHANGE: added
	move.w	#$96,d1	; CHANGE: added
	jsr	IG_Set_cursor	; CHANGE: added
	moveq	#14,d0	; CHANGE: added
	lea.l	Code0001Sys,a1	; CHANGE: added
	jsr	Convert_text_line	; CHANGE: added
	lea.l	Line_buffer,a0	; CHANGE: was "Push Module,TransGold_Mod"
	jsr	IG_Print	; CHANGE: was "Push Module,TransGold_Mod"
	rts	
T_12d60:
	move.w	#$60,Adding
	bsr.w	T_12ca0
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
T_12da4:
	btst	#$1,Mouse_button_state
	bne.b	T_12da4
	bsr.w	Pop_Module
	move.l	ItemW_nr,d0
	beq.b	.l_12df6
	move.w	d0,d1
	mulu.w	#$a,d0
	movea.l	Current_inventory_chardat_ptr,a0
	bsr.w	Scan_4_gold_victims
	bne.b	.l_12dd8
	move.w	#$5,d0
	jsr	Plus_message
	bra.b	.l_12df6
.l_12dd8:
	bsr.w	Show_transfer_victims
	move.l	#.l_12df8,TIVS_Ptr
	lea.l	TIVS1_Mod,a0
	move.w	#$19,$2c(a0)
	bsr.w	Push_Module
.l_12df6:
	rts
.l_12df8:
	btst	#$1,Mouse_button_state
	bne.b	.l_12df8
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
	beq.b	.l_12e5c
	move.l	#Code0001Sys,Textfile_ptr
	move.w	#$18,ReqText_nr
	move.l	#.l_12e5e,ReqDo_ptr
	lea.l	Req_Mod,a0
	bsr.w	Push_Module
.l_12e5c:
	rts
.l_12e5e:
	movea.l	Current_inventory_chardat_ptr,a1
	move.l	ItemW_nr,d0
	sub.w	d0,$90(a1)
	mulu.w	#$a,d0
	sub.l	d0,$ec(a1)
	bra.w	Pop_Module
T_12e7a:
	btst	#$1,Mouse_button_state
	bne.b	T_12e7a
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
	st.b	B_5b82b	; CHANGE: added
	lea.l	TransFood_Mod,a0
	bsr.w	Push_Module
	sf.b	B_5b82b	; CHANGE: added
	rts	
T_12eda:
	move.w	#$60,Adding
	bsr.w	T_12ca0
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
T_12f1e:
	btst	#$1,Mouse_button_state
	bne.b	T_12f1e
	bsr.w	Pop_Module
	move.l	ItemW_nr,d0
	beq.w	.l_12fcc
	movea.l	Current_inventory_chardat_ptr,a0
	mulu.w	#$fa,d0
	lea.l	Chard_ptrs,a1
	lea.l	Char_status_icons,a4
	moveq	#0,d6
	moveq	#1,d7
.l_12f50:
	tst.l	(a1)
	beq.b	.l_12f86
	cmpa.l	(a1),a0
	bne.b	.l_12f5c
	move.w	d7,d5
	bra.b	.l_12f86
.l_12f5c:
	movea.l	(a1),a2
	move.w	$48(a2),d1
	add.w	$9c(a2),d1
	mulu.w	#$3e8,d1
	sub.l	$ec(a2),d1
	cmp.l	d0,d1
	bmi.b	.l_12f86
	move.w	$92(a2),d1
	add.w	d0,d1
	bvs.b	.l_12f86
	move.w	#$e402,d1
	and.w	$3a(a2),d1
	bne.b	.l_12f86
	bset	d7,d6
.l_12f86:
	addq.l	#$4,a1
	addq.w	#$1,d7
	cmpi.w	#$7,d7
	bmi.b	.l_12f50
	bmi.b	.l_12f50
	move.w	d5,Transferring
	move.w	d6,Transfer_victims
	tst.w	d6
	bne.b	.l_12fae
	move.w	#$5,d0
	jsr	Plus_message
	bra.b	.l_12fcc
.l_12fae:
	bsr.w	Show_transfer_victims
	move.l	#.l_12fce,TIVS_Ptr
	lea.l	TIVS1_Mod,a0
	move.w	#$1a,$2c(a0)
	bsr.w	Push_Module
.l_12fcc:
	rts
.l_12fce:
	btst	#$1,Mouse_button_state
	bne.b	.l_12fce
	movea.l	Current_inventory_chardat_ptr,a1
	move.l	ItemW_nr,d0
	add.w	d0,$92(a0)
	sub.w	d0,$92(a1)
	mulu.w	#$fa,d0
	add.l	d0,$ec(a0)
	sub.l	d0,$ec(a1)
	rts
T_12ffa:
	btst	#$1,Mouse_button_state
	bne.b	T_12ffa
	tst.l	ItemW_nr
	beq.b	.l_13032
	move.l	#Code0001Sys,Textfile_ptr
	move.w	#$19,ReqText_nr
	move.l	#.l_13034,ReqDo_ptr
	lea.l	Req_Mod,a0
	bsr.w	Push_Module
.l_13032:
	rts
.l_13034:
	movea.l	Current_inventory_chardat_ptr,a1
	move.l	ItemW_nr,d0
	sub.w	d0,$92(a1)
	mulu.w	#$fa,d0
	sub.l	d0,$ec(a1)
	bra.w	Pop_Module
T_13050:
	btst	#$1,Mouse_button_state
	bne.b	T_13050
	tst.b	d0
	beq.w	.l_13218
	ext.w	d0
	addi.w	#$9,d0
	movea.l	Current_inventory_chardat_ptr,a0
	lea.l	$21(a0),a1
	adda.w	d0,a1
	tst.b	(a1)
	beq.w	.l_13218
	lea.l	$10a(a0),a2
	moveq	#40,d1
	mulu.w	d0,d1
	adda.w	d1,a2
	movea.l	Off_screen,a6
	tst.b	Battling
	beq.b	.l_1309a
	btst	#$4,$18(a2)
	beq.w	.l_13218
.l_1309a:
	move.b	$12(a2),d1
	beq.b	.l_130b2
	cmpi.b	#$7,d1
	beq.b	.l_130c0
	lea.l	$21(a0),a3
	ext.w	d1
	tst.b	(a3,d1.w)
	beq.b	.l_130c0
.l_130b2:
	move.w	#$8,d0
	jsr	Plus_message
	bra.w	.l_13218
.l_130c0:
	move.b	$5(a0),d1
	move.w	$1e(a2),d2
	btst	d1,d2
	bne.b	.l_130da
	move.w	#$9,d0
	jsr	Plus_message
	bra.w	.l_13218
.l_130da:
	move.b	$3(a2),d1
	beq.b	.l_130f6
	subq.b	#$1,d1
	cmp.b	$3(a0),d1
	beq.b	.l_130f6
	move.w	#$a,d0
	jsr	Plus_message
	bra.w	.l_13218
.l_130f6:
	move.b	$4(a2),d1
	beq.b	.l_13114
	moveq	#2,d2
	sub.b	$1c(a0),d2
	cmp.b	d1,d2
	bpl.b	.l_13114
	move.w	#$b,d0
	jsr	Plus_message
	bra.w	.l_13218
.l_13114:
	move.b	$5(a2),d1
	beq.b	.l_13132
	moveq	#2,d2
	sub.b	$1d(a0),d2
	cmp.b	d1,d2
	bpl.b	.l_13132
	move.w	#$c,d0
	jsr	Plus_message
	bra.w	.l_13218
.l_13132:
	lea.l	$21(a0),a3
	move.b	$12(a2),d1
	cmpi.b	#$7,d1
	bne.b	.l_13148
	tst.b	$7(a3)
	beq.b	.l_13148
	addq.b	#$2,d1
.l_13148:
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
	bne.b	.l_131b0
	bsr.w	Positive_boni
	bra.b	.l_131b4
.l_131b0:
	bsr.w	Negative_boni
.l_131b4:
	move.b	#$1,(a3)
	moveq	#19,d7
.l_131ba:
	move.w	(a2)+,(a4)+
	dbra	d7,.l_131ba
	lea.l	-$28(a2),a2
	lea.l	-$28(a4),a4
	cmpi.b	#$2,$4(a2)
	bne.b	.l_131e6
	cmpi.w	#$4,d1
	bne.b	.l_131e6
	movem.l	d0-d1,-(a7)
	moveq	#0,d0
	moveq	#6,d1
	bsr.w	INV2_Show_object
	movem.l	(a7)+,d0-d1
.l_131e6:
	subq.b	#$1,(a1)
	bne.b	.l_131f0
	bsr.w	INV2_Erase_object
	bra.b	.l_13206
.l_131f0:
	cmpi.b	#$1,(a1)
	bne.b	.l_13206
	movem.w	d0-d1,-(a7)
	move.b	d0,d1
	move.b	(a2),d0
	bsr.w	INV2_Show_object
	movem.w	(a7)+,d0-d1
.l_13206:
	move.b	(a4),d0
	bsr.w	INV2_Show_object
	jsr	Switch_screen
	jsr	Copy_screen
.l_13218:
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
	lea.l	D_32c84,a0
	jsr	Push_MA
	movea.l	Module_sp,a0
	cmpi.w	#$18,$2c(a0)
	bne.b	.l_13486
	move.b	TIVS_Icon_nr,d0
	bsr.w	Build_object_mptr
.l_13486:
	movea.l	Off_screen,a6
	move.w	#$13,d0
	jsr	Minus_message
	jsr	Switch_screen
	jsr	Copy_screen
.l_134a2:
	btst	#$1,Mouse_button_state
	bne.b	.l_134a2
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
T_13774:
	btst	#$1,Mouse_button_state
	bne.b	T_13774
	sf.b	Magic_object_flag
	movea.l	Current_active_char_data,a0
	move.b	$1a(a0),d0
	moveq	#0,d1
	moveq	#1,d2
	moveq	#6,d7
.l_13794:
	btst	d2,d0
	beq.b	.l_137a0
	move.w	d2,Selected_class
	addq.w	#$1,d1
.l_137a0:
	addq.w	#$1,d2
	dbra	d7,.l_13794
	move.w	d1,B_5b848
	lea.l	$d0(a0),a0
	move.w	Selected_class,d0
	add.w	d0,d0
	add.w	d0,d0
	tst.l	-$4(a0,d0.w)
	beq.b	.l_137dc
	cmpi.w	#$1,d1
	bne.b	.l_137d2
	lea.l	SpSelW_Mod,a0
	bsr.w	Push_Module
	bra.b	.l_137dc
.l_137d2:
	lea.l	SCSelW_Mod,a0
	bsr.w	Push_Module
.l_137dc:
	rts

	section	data

Skills_name:
	dc.b	$01,$08,$46,$8e,$48,$49,$47,$4b,$45,$49,$54,$45,$4e,$01,$0f,$00
D_30a0e:
	dc.b	$01,$08,$41,$54,$54,$52,$49,$42,$55,$54,$45,$01,$0f,$00
Age_txt:
	dc.b	$41,$4c,$54,$45,$52,$3a,$20,$00
D_30a24:
	dc.b	$01,$08,$53,$50,$52,$41,$43,$48,$45,$4e,$01,$0f,$00
D_30a31:
	dc.b	$01,$08,$4b,$99,$52,$50,$45,$52,$01,$0f,$00
D_30a3c:
	dc.b	$01,$08,$47,$45,$49,$53,$54,$01,$0f,$00
D_30a46:
	dc.b	$01,$0f,$02,$02,$47,$45,$57,$49,$43,$48,$54,$00
Gold_txt:
	dc.b	$47,$4f,$4c,$44,$00
Food_txt:
	dc.b	$52,$41,$54,$49,$4f,$4e,$45,$4e,$00
Goldfood_txt:
	dc.b	$47,$3a,$30,$31,$32,$33,$34,$20,$52,$3a,$30,$31,$32,$33,$00
Male_name:
	dc.b	$4d,$8e,$4e,$4e,$4c,$49,$43,$48,$00
Female_name:
	dc.b	$57,$45,$49,$42,$4c,$49,$43,$48,$00
D_30a81:
	dc.b	$4d,$8e,$4e,$4e,$4c,$2e,$00
D_30a88:
	dc.b	$57,$45,$49,$42,$4c,$2e,$00
D_30a8f:
	dc.b	$42,$45,$49,$44,$45,$00
D_30a95:
	dc.b	$01,$01,$47,$45,$53,$43,$48,$4c,$45,$43,$48,$54,$3a,$01,$0f,$00
D_30aa5:
	dc.b	$48,$8e,$4e,$44,$45,$20,$20,$20,$3a,$20,$00
D_30ab0:
	dc.b	$46,$49,$4e,$47,$45,$52,$20,$20,$3a,$20,$00
D_30abb:
	dc.b	$01,$01,$2d,$2d,$2d,$2d,$20,$4b,$4c,$41,$53,$53,$45,$4e,$20,$2d
	dc.b	$2d,$2d,$2d,$01,$0f,$00
D_30ad1:
	dc.b	$53,$43,$48,$41,$44,$45,$4e,$20,$3a,$20,$00
D_30adc:
	dc.b	$53,$43,$48,$55,$54,$5a,$20,$20,$3a,$20,$00
D_30ae7:
	dc.b	$01,$01,$47,$45,$57,$49,$43,$48,$54,$20,$3a,$20,$01,$0f,$00
D_30af6:
	dc.b	$01,$01,$41,$54,$54,$52,$49,$42,$55,$54,$01,$0f,$00
D_30b03:
	dc.b	$01,$01,$46,$8e,$48,$49,$47,$4b,$45,$49,$54,$01,$0f,$00
D_30b11:
	dc.b	$01,$01,$4d,$41,$47,$49,$45,$01,$0f,$00
D_30b1b:
	dc.b	$01,$09,$56,$45,$52,$46,$4c,$55,$43,$48,$54,$01,$0f,$00
D_30b29:
	dc.b	$01,$0f,$02,$ff,$44,$49,$41,$4c,$4f,$47,$00
D_30b34:
	dc.b	$45,$50,$3a,$20,$20,$20,$20,$20,$20,$20,$20,$20,$00
LP_txt:
	dc.b	$4c,$50,$20,$3a,$20
D_30b46:
	dc.b	$20,$20,$20,$2f
D_30b4a:
	dc.b	$20,$20,$20,$00
PP_txt:
	dc.b	$53,$50,$20,$3a,$20
D_30b53:
	dc.b	$20,$20,$20,$2f
D_30b57:
	dc.b	$20,$20,$20,$00
SLP_txt:
	dc.b	$53,$4c,$50,$3a,$20
D_30b60:
	dc.b	$20,$20,$20,$00
ProtDam_txt:
	dc.b	$3a,$20,$20,$20,$00
Skill_txt:
	dc.b	$20,$20,$25,$2f,$20,$20,$25,$00
Attr_txt:
	dc.b	$20,$20,$20,$2f,$20,$20,$20,$00
D_30b79:
	dc.b	$01,$00,$02,$02,$20,$20,$20,$20,$4b,$47,$2f,$20,$20,$20,$20,$4b
	dc.b	$47,$00
D_30b8b:
	dc.b	$20,$47,$52,$00
D_30b8f:
	dc.b	$4c,$50,$2d,$4d,$41,$58,$3a,$00
D_30b97:
	dc.b	$50,$50,$2d,$4d,$41,$58,$3a,$00
D_30b9f:
	dc.b	$20,$4d,$2d,$42,$2d,$57,$3a,$00
D_30ba7:
	dc.b	$20,$4d,$2d,$42,$2d,$41,$3a,$00
Tween_txt:
	dc.b	$20,$3a,$20,$00
D_30bb3:
	dc.b	$20,$28,$00
D_30bb6:
	dc.b	$2a,$2a,$2a,$00
D_30bba:
	dc.b	$29,$00
D_30bbc:
	dc.b	$00,$b1,$00,$88,$00,$b1,$00,$8f,$00,$b1,$00,$96,$00,$b1,$00,$9d
	dc.b	$00,$e7,$00,$88,$00,$e7,$00,$8f,$00,$e7,$00,$96,$00,$e7,$00,$9d
D_30bdc:
	dc.b	$00,$00,$00,$00,$00,$12,$00,$0c,$00,$00,$00,$18,$00,$12,$00,$24
	dc.b	$00,$00,$00,$30
D_30bf0:
	dc.b	$00,$30,$00,$80
Object_pos_list:
	dc.b	$00,$10,$00,$51,$00,$30,$00,$51,$00,$50,$00,$51,$00,$10,$00,$71
	dc.b	$00,$30,$00,$71,$00,$50,$00,$71,$00,$10,$00,$91,$00,$30,$00,$91
	dc.b	$00,$50,$00,$91
D_30c18:
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
D_30cc8:
	dc.b	$00,$10,$00,$bf,$00,$51,$00,$c0
D_30cd0:
	dc.l	D_30a8f
	dc.l	D_30a81
	dc.l	D_30a88
Quant_index:
	dc.b	$00,$00
Quant_init_string:
	dc.b	$01
D_30cdf:
	dc.b	$00,$02,$ff,$00
Quant_block:
	dc.b	$00
Quant_count:
	dc.b	$01
Quant_cycles:
	dc.b	$0f,$0f,$0f,$0f,$0f,$0f,$0f,$02,$03,$04,$04,$04,$04,$04,$04,$04
	dc.b	$03,$02,$ff
D_30cf8:
	dc.b	$00,$10,$00,$bf,$00,$31,$00,$40,$00,$10,$00,$32,$00,$b0,$00,$0e
	dc.b	$00,$0f,$00,$02
Curse_count:
	dc.b	$00,$01
D_30d0e:
	dc.b	$00,$1c,$00,$1a,$00,$16,$00,$00,$00,$00,$00,$00,$00,$14
D_30d1c:
	dc.b	$00,$20,$00,$50,$00,$c0,$00,$46,$00,$0f,$00,$02
D_30d28:
	dc.b	$00,$20,$00,$50,$00,$80,$00,$31,$00,$0f,$00,$02
D_30d34:
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
D_30df6:
	dc.b	$00,$60,$00,$b1,$00,$10,$00,$71,$00,$60,$00,$31,$00,$b0,$00,$71
D_30e06:
	dc.l	D_30e52
	dc.l	D_30e5c
	dc.l	D_30e66
	dc.l	D_30e71
	dc.l	D_30e7d
	dc.l	D_30e8d
	dc.l	D_30e9a
	dc.l	D_30ea8
	dc.l	D_30eb7
	dc.l	D_30ec0
	dc.l	D_30ecf
	dc.l	D_30edd
	dc.l	D_30ee7
	dc.l	D_30ef6
	dc.l	D_30f05
	dc.l	D_30f10
	dc.l	D_30f1f
	dc.l	D_30f27
	dc.l	D_30f35
D_30e52:
	dc.b	$43,$49,$54,$59,$20,$57,$41,$4c,$4b,$00
D_30e5c:
	dc.b	$48,$49,$47,$48,$20,$53,$45,$41,$53,$00
D_30e66:
	dc.b	$48,$4f,$52,$53,$45,$20,$53,$4f,$4e,$47,$00
D_30e71:
	dc.b	$46,$4c,$59,$49,$4e,$47,$20,$48,$49,$47,$48,$00
D_30e7d:
	dc.b	$54,$52,$41,$56,$45,$4c,$4c,$45,$52,$53,$20,$54,$55,$4e,$45,$00
D_30e8d:
	dc.b	$49,$52,$49,$53,$48,$20,$53,$50,$52,$49,$4e,$47,$00
D_30e9a:
	dc.b	$47,$57,$45,$4e,$27,$53,$20,$4c,$41,$4d,$45,$4e,$54,$00
D_30ea8:
	dc.b	$45,$52,$49,$4b,$27,$53,$20,$52,$45,$56,$45,$4e,$47,$45,$00
D_30eb7:
	dc.b	$46,$41,$4e,$46,$41,$52,$45,$53,$00
D_30ec0:
	dc.b	$4f,$44,$45,$20,$54,$4f,$20,$53,$43,$48,$4e,$49,$53,$4d,$00
D_30ecf:
	dc.b	$4d,$49,$53,$54,$59,$20,$4f,$52,$43,$20,$48,$4f,$50,$00
D_30edd:
	dc.b	$44,$52,$45,$41,$4d,$43,$41,$56,$45,$00
D_30ee7:
	dc.b	$4d,$59,$53,$54,$49,$43,$20,$4d,$4f,$4d,$45,$4e,$54,$53,$00
D_30ef6:
	dc.b	$4c,$55,$52,$4b,$49,$4e,$47,$20,$48,$4f,$52,$52,$4f,$52,$00
D_30f05:
	dc.b	$42,$41,$52,$44,$20,$44,$41,$4e,$43,$45,$00
D_30f10:
	dc.b	$4d,$49,$4e,$4f,$52,$20,$51,$55,$41,$52,$52,$45,$4c,$53,$00
D_30f1f:
	dc.b	$4c,$55,$4c,$4c,$41,$42,$59,$00
D_30f27:
	dc.b	$46,$55,$4e,$4b,$59,$20,$44,$55,$4e,$47,$45,$4f,$4e,$00
D_30f35:
	dc.b	$48,$41,$53,$54,$41,$20,$4c,$41,$20,$56,$49,$53,$54,$41,$00
D_30f44:
	dc.b	$00,$10,$00,$bf,$00,$a1,$00,$c0
D_30f4c:
	dc.b	$00,$10,$00,$b1,$00,$b0,$00,$10,$00,$0f,$00,$02
D_30f58:
	dc.b	$42,$38,$3b,$26,$44,$45,$24,$25,$0c,$00
	dc.l	T_16da2
	dc.b	$00,$00,$00,$00
	dc.l	Monster_actions
	dc.l	T_16c30
	dc.l	T_15d2e
	dc.l	T_15d4e
	dc.l	T_16de0
	dc.l	T_16eda
	dc.l	T_16f16
D_30f86:
	dc.b	$00,$00,$05,$00,$04,$44,$03,$32,$01,$22,$05,$52,$05,$31,$04,$20
	dc.b	$03,$10,$01,$50,$00,$31,$02,$00
D_30f9e:
	dc.b	$00,$00
D_30fa0:
	dc.b	$00,$00,$00,$00,$06,$66,$05,$66,$04,$56,$03,$45,$01,$42,$04,$66
	dc.b	$03,$55,$04,$67,$03,$66,$06,$40,$03,$55,$02,$44,$01,$33,$01,$34
	dc.b	$00,$23,$04,$55,$05,$66,$04,$56,$01,$42,$01,$34,$00,$23,$04,$55
	dc.b	$05,$55,$06,$41,$00,$00,$02,$21,$03,$21,$00,$00,$03,$35,$02,$23
	dc.b	$01,$13,$01,$34,$00,$12,$04,$55,$05,$55,$02,$34,$00,$00,$01,$21
	dc.b	$05,$56,$00,$00,$01,$34,$00,$23,$04,$55
D_30ffa:
	dc.b	$00,$d0,$01,$2f,$00,$31,$00,$80,$02,$00
	dc.l	Control_area
	dc.b	$00,$00,$00,$00
D_3100c:
	dc.b	$ff,$00,$00,$00,$07,$50,$03,$33,$02,$22,$01,$11,$07,$42,$06,$31
	dc.b	$02,$00,$05,$66,$03,$45,$07,$54,$06,$43,$05,$32,$04,$21,$03,$10
	dc.b	$07,$65,$24,$00
D_31030:
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00
D_31052:
	dc.b	$00,$02
	dc.l	D_3105c
	dc.l	D_3120c
D_3105c:
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
D_3120c:
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
D_313bc:
	dc.b	$20,$00
D_313be:
	dc.b	$20,$3a,$20,$00
D_313c2:
	dc.b	$3a,$0d
; Black spells: 6 bytes per spell (minimum, maximum, animation) behind an unused entry with the immunity bits of the elements.
Spell_damage_table:
	dc.b	$00,$00
D_313c6:
	dc.b	$00,$02,$01,$03,$00,$01,$00,$02,$00,$0c,$00,$02,$00,$04,$00,$07
	dc.b	$00,$04,$00,$08,$00,$02,$00,$08,$00,$10,$00,$0f,$00,$10,$00,$20
	dc.b	$00,$08,$00,$02,$00,$04,$00,$09,$00,$04,$00,$08,$00,$05,$00,$08
	dc.b	$00,$10,$00,$01,$00,$10,$00,$20,$00,$05,$00,$20,$00,$40,$00,$01
	dc.b	$00,$04,$00,$08,$00,$06,$00,$08,$00,$10,$00,$02,$00,$10,$00,$20
	dc.b	$00,$06,$00,$20,$00,$40,$00,$07,$00,$40,$00,$80,$00,$09,$00,$08
	dc.b	$00,$10,$00,$04,$00,$10,$00,$20,$00,$08,$00,$20,$00,$40,$00,$0e
	dc.b	$00,$40,$00,$80,$00,$03,$00,$80,$01,$00,$00,$04
D_31442:
	dc.b	$0d,$00
D_31444:
	dc.b	$21,$23,$1e,$01,$12,$32,$02,$14,$33,$00
	dc.l	Transfer_item_MOBJC
	dc.l	T_08f2c
	dc.l	T_19c5e
	dc.l	T_19d6a
	dc.l	T_19ddc
	dc.l	T_19dae
	dc.l	T_19d8c
	dc.l	T_19ece
	dc.l	T_19eae
D_31472:
	dc.b	$78,$20,$00,$00
D_31476:
	dc.b	$00,$00,$02,$23,$03,$33,$02,$22,$01,$11,$06,$43,$05,$32,$04,$21
	dc.b	$03,$10,$07,$63,$06,$52,$05,$41,$04,$31,$03,$20,$02,$10,$07,$77
D_31496:
	dc.l	D_314ad
D_3149a:
	dc.b	$4b,$61,$72,$73,$74,$65,$6e,$20,$69,$73,$74,$20,$64,$6f,$6f,$66
	dc.b	$20,$21,$00
D_314ad:
	dc.b	$73,$63,$68,$6e,$69,$73,$6d,$00,$00
D_314b6:
	dc.l	D_314f3
	dc.l	D_31514
	dc.l	D_31557
	dc.l	D_315a0
	dc.l	D_315cf
	dc.l	D_31628
	dc.l	D_31659
	dc.l	D_316b9
D_314d6:
	dc.b	$0d,$0d,$50,$72,$65,$73,$73,$20,$61,$6e,$79,$20,$6b,$65,$79,$20
	dc.b	$74,$6f,$20,$63,$6f,$6e,$74,$69,$6e,$75,$65,$2e,$00
D_314f3:
	dc.b	$59,$6f,$75,$20,$41,$4c,$4d,$4f,$53,$54,$20,$66,$6f,$75,$6e,$64
	dc.b	$20,$74,$68,$65,$20,$70,$61,$73,$73,$77,$6f,$72,$64,$2e,$2e,$2e
	dc.b	$00
D_31514:
	dc.b	$44,$6f,$20,$79,$6f,$75,$20,$72,$65,$61,$6c,$6c,$79,$20,$74,$68
	dc.b	$69,$6e,$6b,$20,$65,$6e,$74,$65,$72,$69,$6e,$67,$20,$27,$53,$43
	dc.b	$48,$4e,$49,$53,$4d,$27,$20,$74,$77,$69,$63,$65,$0d,$77,$69,$6c
	dc.b	$6c,$20,$62,$72,$69,$6e,$67,$20,$61,$6e,$79,$74,$68,$69,$6e,$67
	dc.b	$20,$3f,$00
D_31557:
	dc.b	$4c,$6f,$6f,$6b,$2c,$20,$6e,$6f,$74,$68,$69,$6e,$67,$20,$77,$69
	dc.b	$6c,$6c,$20,$68,$61,$70,$70,$65,$6e,$2c,$20,$6e,$6f,$20,$6d,$61
	dc.b	$74,$74,$65,$72,$20,$48,$4f,$57,$20,$6d,$61,$6e,$79,$20,$74,$69
	dc.b	$6d,$65,$73,$20,$79,$6f,$75,$0d,$65,$6e,$74,$65,$72,$20,$27,$53
	dc.b	$43,$48,$4e,$49,$53,$4d,$27,$2e,$00
D_315a0:
	dc.b	$48,$6f,$77,$20,$6d,$61,$6e,$79,$20,$74,$65,$78,$74,$73,$20,$64
	dc.b	$6f,$20,$79,$6f,$75,$20,$74,$68,$69,$6e,$6b,$20,$49,$27,$76,$65
	dc.b	$20,$67,$6f,$74,$20,$69,$6e,$20,$68,$65,$72,$65,$20,$3f,$00
D_315cf:
	dc.b	$41,$6c,$72,$69,$67,$68,$74,$2c,$20,$79,$6f,$75,$20,$77,$69,$6e
	dc.b	$2e,$20,$49,$66,$20,$79,$6f,$75,$20,$65,$6e,$74,$65,$72,$20,$27
	dc.b	$53,$43,$48,$4e,$49,$53,$4d,$27,$20,$6f,$6e,$65,$0d,$6d,$6f,$72
	dc.b	$65,$20,$74,$69,$6d,$65,$2c,$20,$74,$68,$65,$20,$63,$68,$65,$61
	dc.b	$74,$6d,$6f,$64,$65,$20,$77,$69,$6c,$6c,$20,$62,$65,$20,$61,$63
	dc.b	$74,$69,$76,$61,$74,$65,$64,$2e,$00
D_31628:
	dc.b	$46,$6f,$6f,$6c,$65,$64,$20,$79,$6f,$75,$21,$0d,$0d,$28,$49,$20
	dc.b	$61,$64,$6d,$69,$74,$20,$74,$68,$69,$73,$20,$77,$61,$73,$20,$61
	dc.b	$20,$76,$65,$72,$79,$20,$62,$61,$64,$20,$6a,$6f,$6b,$65,$2e,$29
	dc.b	$00
D_31659:
	dc.b	$59,$6f,$75,$20,$61,$72,$65,$20,$6f,$62,$76,$69,$6f,$75,$73,$6c
	dc.b	$79,$20,$64,$65,$72,$61,$6e,$67,$65,$64,$2e,$20,$50,$6c,$65,$61
	dc.b	$73,$65,$20,$73,$74,$6f,$70,$20,$65,$6e,$74,$65,$72,$69,$6e,$67
	dc.b	$0d,$27,$53,$43,$48,$4e,$49,$53,$4d,$27,$20,$6f,$72,$20,$49,$27
	dc.b	$6c,$6c,$20,$6b,$69,$6c,$6c,$20,$61,$6c,$6c,$20,$79,$6f,$75,$72
	dc.b	$20,$70,$61,$72,$74,$79,$20,$6d,$65,$6d,$62,$65,$72,$73,$2e,$00
D_316b9:
	dc.b	$54,$68,$61,$74,$27,$73,$20,$69,$74,$21,$20,$4e,$6f,$20,$6d,$6f
	dc.b	$72,$65,$20,$27,$53,$43,$48,$4e,$49,$53,$4d,$27,$73,$20,$21,$21
	dc.b	$21,$00,$00
; Pointers to the music modules of the songs 1-19 (several songs use the same module).
Song_table:
	dc.l	D_4da4e
	dc.l	D_4e060
	dc.l	D_4e5fc
	dc.l	D_4ead4
	dc.l	D_4f10a
	dc.l	D_4fe76
	dc.l	D_4f6ca
	dc.l	D_4fe76
	dc.l	D_50490
	dc.l	D_50c38
	dc.l	D_516ee
	dc.l	D_51cda
	dc.l	D_5215e
	dc.l	D_5255e
	dc.l	D_50c38
	dc.l	D_52b20
	dc.l	D_5380c
	dc.l	D_53da2
	dc.l	D_54354
Dir_offset:
	dc.b	$00,$ff,$01,$00,$00,$01,$ff,$00
D_31730:
	dc.b	$00,$00,$01,$3f,$00,$00,$00,$c7
D_31738:
	dc.b	$00,$00,$00,$00,$01,$3f,$00,$c7,$00,$0f,$00,$00
D_31744:
	dc.b	$00,$40,$00,$df,$00,$4c,$00,$7b
D_3174c:
	dc.b	$00,$40,$00,$4c,$00,$a0,$00,$30,$00,$0f,$00,$02
D_31758:
	dc.b	$01,$09,$02,$ff,$20,$20,$00,$00
D_31760:
	dc.b	$5b,$20,$45,$6e,$74,$65,$72,$5f,$6d,$6f,$64,$69,$66,$69,$63,$61
	dc.b	$74,$69,$6f,$6e,$20,$5d,$20,$3a,$20,$54,$6f,$6f,$20,$6d,$75,$63
	dc.b	$68,$20,$6d,$6f,$64,$69,$66,$69,$63,$61,$74,$69,$6f,$6e,$73,$20
	dc.b	$21,$21,$21,$0d,$00
D_31795:
	dc.b	$5b,$20,$53,$65,$74,$5f,$6e,$65,$77,$5f,$74,$72,$61,$76,$65,$6c
	dc.b	$5f,$6d,$6f,$64,$65,$20,$5d,$20,$3a,$20,$49,$6e,$70,$75,$74,$20
	dc.b	$6f,$75,$74,$20,$6f,$66,$20,$72,$61,$6e,$67,$65,$20,$21,$21,$21
	dc.b	$0d,$00
D_317c7:
	dc.b	$5b,$20,$53,$65,$74,$5f,$6d,$75,$73,$69,$63,$20,$5d,$20,$3a,$20
	dc.b	$53,$6f,$6e,$67,$20,$6e,$75,$6d,$62,$65,$72,$20,$74,$6f,$6f,$20
	dc.b	$68,$69,$67,$68,$20,$21,$21,$21,$0d,$00
D_317f1:
	dc.b	$5b,$20,$41,$4d,$42,$45,$52,$53,$54,$41,$52,$20,$53,$54,$41,$54
	dc.b	$55,$53,$20,$53,$43,$52,$45,$45,$4e,$20,$5d,$0d,$00
D_3180e:
	dc.b	$20,$20,$4d,$61,$70,$20,$6e,$75,$6d,$62,$65,$72,$20,$3a,$20,$00
D_3181e:
	dc.b	$58,$20,$63,$6f,$6f,$72,$64,$69,$6e,$61,$74,$65,$20,$3a,$20,$00
D_3182e:
	dc.b	$59,$20,$63,$6f,$6f,$72,$64,$69,$6e,$61,$74,$65,$20,$3a,$20,$00
D_3183e:
	dc.b	$56,$69,$65,$77,$20,$64,$69,$72,$65,$63,$74,$69,$6f,$6e,$20,$3a
	dc.b	$20,$00
D_31850:
	dc.b	$20,$20,$20,$54,$72,$61,$76,$65,$6c,$20,$6d,$6f,$64,$65,$20,$3a
	dc.b	$20,$00
D_31862:
	dc.b	$57,$6f,$72,$6c,$64,$20,$58,$20,$3a,$20,$00
D_3186d:
	dc.b	$57,$6f,$72,$6c,$64,$20,$59,$20,$3a,$20,$00
D_31878:
	dc.b	$20,$20,$59,$65,$61,$72,$20,$3a,$20,$00
D_31882:
	dc.b	$20,$4d,$6f,$6e,$74,$68,$20,$3a,$20,$00
D_3188c:
	dc.b	$20,$20,$20,$44,$61,$79,$20,$3a,$20,$00
D_31896:
	dc.b	$20,$20,$48,$6f,$75,$72,$20,$3a,$20,$00
D_318a0:
	dc.b	$4d,$69,$6e,$75,$74,$65,$20,$3a,$20,$00
D_318aa:
	dc.b	$20,$46,$72,$61,$6d,$65,$20,$3a,$20,$00
D_318b4:
	dc.b	$4e,$75,$6d,$62,$65,$72,$20,$6f,$66,$20,$6d,$65,$6d,$62,$65,$72
	dc.b	$73,$20,$69,$6e,$20,$70,$61,$72,$74,$79,$20,$3a,$20,$00
D_318d2:
	dc.b	$5b,$20,$50,$72,$65,$73,$73,$20,$61,$6e,$79,$20,$6b,$65,$79,$20
	dc.b	$74,$6f,$20,$65,$78,$69,$74,$20,$5d,$0d,$00
D_318ed:
	dc.b	$5b,$20,$56,$49,$45,$57,$20,$46,$52,$45,$45,$20,$4d,$45,$4d,$4f
	dc.b	$52,$59,$20,$5d,$0d,$00
D_31903:
	dc.b	$20,$20,$20,$20,$20,$20,$20,$20,$53,$69,$7a,$65,$20,$6f,$66,$20
	dc.b	$66,$72,$65,$65,$20,$6d,$65,$6d,$6f,$72,$79,$20,$3a,$20,$00
D_31922:
	dc.b	$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
	dc.b	$4d,$65,$6d,$6f,$72,$79,$20,$75,$73,$65,$64,$20,$3a,$20,$00
D_31941:
	dc.b	$20,$20,$20,$20,$20,$20,$20,$53,$69,$7a,$65,$20,$6f,$66,$20,$54
	dc.b	$45,$58,$54,$20,$73,$65,$67,$6d,$65,$6e,$74,$20,$3a,$20,$00
D_31960:
	dc.b	$20,$20,$20,$20,$20,$20,$20,$53,$69,$7a,$65,$20,$6f,$66,$20,$44
	dc.b	$41,$54,$41,$20,$73,$65,$67,$6d,$65,$6e,$74,$20,$3a,$20,$00
D_3197f:
	dc.b	$20,$20,$20,$20,$20,$20,$20,$53,$69,$7a,$65,$20,$6f,$66,$20,$20
	dc.b	$42,$53,$53,$20,$73,$65,$67,$6d,$65,$6e,$74,$20,$3a,$20,$00
D_3199e:
	dc.b	$20,$20,$20,$20,$20,$20,$54,$6f,$74,$61,$6c,$20,$73,$69,$7a,$65
	dc.b	$20,$6f,$66,$20,$70,$72,$6f,$67,$72,$61,$6d,$20,$3a,$20,$00
D_319bd:
	dc.b	$54,$6f,$74,$61,$6c,$20,$61,$6d,$6f,$75,$6e,$74,$20,$6f,$66,$20
	dc.b	$6d,$65,$6d,$6f,$72,$79,$20,$75,$73,$65,$64,$20,$3a,$20,$00
D_319dc:
	dc.b	$5b,$20,$50,$72,$65,$73,$73,$20,$61,$6e,$79,$20,$6b,$65,$79,$20
	dc.b	$74,$6f,$20,$65,$78,$69,$74,$20,$5d,$0d,$00
D_319f7:
	dc.b	$5b,$20,$56,$49,$45,$57,$20,$4d,$4f,$44,$49,$46,$49,$43,$41,$54
	dc.b	$49,$4f,$4e,$20,$49,$4e,$46,$4f,$20,$5d,$0d,$00
D_31a13:
	dc.b	$4e,$75,$6d,$62,$65,$72,$20,$6f,$66,$20,$6d,$6f,$64,$69,$66,$69
	dc.b	$63,$61,$74,$69,$6f,$6e,$73,$20,$3a,$20,$00
D_31a2e:
	dc.b	$3e,$20,$00
D_31a31:
	dc.b	$2c,$00
D_31a33:
	dc.b	$2c,$00
D_31a35:
	dc.b	$2c,$00
D_31a37:
	dc.b	$5b,$20,$50,$72,$65,$73,$73,$20,$61,$6e,$79,$20,$6b,$65,$79,$20
	dc.b	$74,$6f,$20,$65,$78,$69,$74,$20,$5d,$0d,$00
D_31a52:
	dc.b	$5b,$20,$56,$49,$45,$57,$20,$4d,$4f,$44,$55,$4c,$45,$20,$53,$54
	dc.b	$41,$43,$4b,$20,$5d,$0d,$00
D_31a69:
	dc.b	$5b,$20,$50,$72,$65,$73,$73,$20,$61,$6e,$79,$20,$6b,$65,$79,$20
	dc.b	$74,$6f,$20,$65,$78,$69,$74,$20,$5d,$0d,$00
D_31a84:
	dc.b	$5b,$20,$49,$4e,$43,$52,$45,$41,$53,$45,$20,$45,$58,$50,$45,$52
	dc.b	$49,$45,$4e,$43,$45,$20,$50,$4f,$49,$4e,$54,$53,$20,$5d,$0d,$00
D_31aa4:
	dc.b	$43,$75,$72,$72,$65,$6e,$74,$20,$65,$78,$70,$65,$72,$69,$65,$6e
	dc.b	$63,$65,$20,$70,$6f,$69,$6e,$74,$73,$20,$3a,$20,$00
D_31ac1:
	dc.b	$45,$6e,$74,$65,$72,$20,$65,$78,$74,$72,$61,$20,$61,$6d,$6f,$75
	dc.b	$6e,$74,$20,$3a,$20,$00
D_31ad7:
	dc.b	$5b,$20,$43,$48,$41,$4e,$47,$45,$20,$4d,$41,$50,$20,$5d,$0d,$00
D_31ae7:
	dc.b	$45,$6e,$74,$65,$72,$20,$6e,$65,$77,$20,$6d,$61,$70,$20,$3a,$20
	dc.b	$00
D_31af8:
	dc.b	$5b,$20,$53,$41,$56,$45,$20,$4e,$45,$4f,$20,$50,$49,$43,$54,$55
	dc.b	$52,$45,$20,$5d,$0d,$00
D_31b0e:
	dc.b	$45,$6e,$74,$65,$72,$20,$34,$2d,$64,$69,$67,$69,$74,$20,$69,$64
	dc.b	$65,$6e,$74,$69,$66,$69,$65,$72,$20,$28,$27,$41,$4d,$42,$52,$3f
	dc.b	$3f,$3f,$3f,$2e,$4e,$45,$4f,$27,$29,$20,$3a,$20,$00
D_31b3b:
	dc.b	$43,$72,$65,$61,$74,$69,$6e,$67,$20,$70,$69,$63,$74,$75,$72,$65
	dc.b	$2e,$2e,$2e,$0d,$00
D_31b50:
	dc.b	$50,$69,$63,$74,$75,$72,$65,$20,$68,$61,$73,$20,$62,$65,$65,$6e
	dc.b	$20,$73,$61,$76,$65,$64,$2e,$0d,$00
D_31b69:
	dc.b	$43,$72,$65,$61,$74,$69,$6e,$67,$20,$72,$61,$73,$74,$65,$72,$20
	dc.b	$66,$69,$6c,$65,$2e,$2e,$2e,$0d,$00
D_31b82:
	dc.b	$52,$61,$73,$74,$65,$72,$2d,$66,$69,$6c,$65,$20,$68,$61,$73,$20
	dc.b	$62,$65,$65,$6e,$20,$73,$61,$76,$65,$64,$2e,$0d,$00
D_31b9f:
	dc.b	$5b,$20,$50,$72,$65,$73,$73,$20,$61,$6e,$79,$20,$6b,$65,$79,$20
	dc.b	$74,$6f,$20,$65,$78,$69,$74,$20,$5d,$0d,$00
D_31bba:
	dc.b	$5b,$20,$57,$65,$69,$67,$68,$74,$20,$63,$68,$65,$63,$6b,$20,$5d
	dc.b	$0d,$00
D_31bcc:
	dc.b	$4d,$65,$6d,$62,$65,$72,$20,$3a,$20,$0d,$00
D_31bd7:
	dc.b	$63,$61,$72,$72,$69,$65,$73,$20,$61,$20,$66,$61,$6c,$73,$65,$20
	dc.b	$77,$65,$69,$67,$68,$74,$20,$3a,$0d,$00
D_31bf1:
	dc.b	$20,$20,$20,$20,$53,$74,$6f,$72,$65,$64,$20,$77,$65,$69,$67,$68
	dc.b	$74,$20,$3a,$20,$00
D_31c06:
	dc.b	$43,$61,$6c,$63,$75,$6c,$61,$74,$65,$64,$20,$77,$65,$69,$67,$68
	dc.b	$74,$20,$3a,$20,$00
D_31c1b:
	dc.b	$5b,$20,$50,$72,$65,$73,$73,$20,$61,$6e,$79,$20,$6b,$65,$79,$20
	dc.b	$74,$6f,$20,$65,$78,$69,$74,$20,$5d,$0d,$00
D_31c36:
	dc.b	$5b,$20,$49,$4e,$43,$52,$45,$41,$53,$45,$20,$47,$4f,$4c,$44,$20
	dc.b	$43,$4f,$49,$4e,$53,$20,$5d,$0d,$00
D_31c4f:
	dc.b	$43,$75,$72,$72,$65,$6e,$74,$20,$67,$6f,$6c,$64,$20,$63,$6f,$69
	dc.b	$6e,$73,$20,$3a,$20,$00
D_31c65:
	dc.b	$45,$6e,$74,$65,$72,$20,$65,$78,$74,$72,$61,$20,$61,$6d,$6f,$75
	dc.b	$6e,$74,$20,$3a,$20,$00
D_31c7b:
	dc.b	$5b,$20,$56,$49,$45,$57,$20,$45,$56,$45,$4e,$54,$20,$44,$41,$54
	dc.b	$41,$20,$5d,$0d,$00
D_31c90:
	dc.b	$44,$61,$74,$61,$20,$31,$20,$3a,$20,$00
D_31c9a:
	dc.b	$44,$61,$74,$61,$20,$32,$20,$3a,$20,$00
D_31ca4:
	dc.b	$44,$61,$74,$61,$20,$33,$20,$3a,$20,$00
D_31cae:
	dc.b	$44,$61,$74,$61,$20,$34,$20,$3a,$20,$00
D_31cb8:
	dc.b	$44,$61,$74,$61,$20,$35,$20,$3a,$20,$00
D_31cc2:
	dc.b	$44,$61,$74,$61,$20,$36,$20,$3a,$20,$00
D_31ccc:
	dc.b	$44,$61,$74,$61,$20,$37,$20,$3a,$20,$00
D_31cd6:
	dc.b	$44,$61,$74,$61,$20,$38,$20,$3a,$20,$00
D_31ce0:
	dc.b	$5b,$20,$50,$72,$65,$73,$73,$20,$61,$6e,$79,$20,$6b,$65,$79,$20
	dc.b	$74,$6f,$20,$65,$78,$69,$74,$20,$5d,$0d,$00
D_31cfb:
	dc.b	$41,$63,$74,$69,$76,$65,$20,$6d,$65,$6d,$62,$65,$72,$20,$3a,$20
	dc.b	$00
D_31d0c:
	dc.b	$4d,$65,$6d,$6f,$72,$79,$20,$69,$73,$20,$6e,$6f,$74,$20,$4f,$4b
	dc.b	$20,$21,$0d,$00
D_31d20:
	dc.b	$44,$69,$66,$66,$65,$72,$65,$6e,$63,$65,$20,$3a,$20,$00
D_31d2e:
	dc.b	$4d,$65,$6d,$6f,$72,$79,$20,$69,$73,$20,$4f,$4b,$2e,$0d,$00
D_31d3d:
	dc.b	$5b,$20,$50,$72,$65,$70,$61,$72,$65,$5f,$33,$44,$5f,$6d,$61,$70
	dc.b	$20,$5d,$20,$3a,$20,$45,$72,$72,$6f,$72,$20,$69,$6e,$20,$4c,$41
	dc.b	$42,$5f,$44,$41,$54,$41,$20,$21,$21,$21,$0d,$00
D_31d69:
	dc.b	$5b,$20,$53,$68,$6f,$77,$5f,$6c,$61,$79,$6f,$75,$74,$20,$5d,$20
	dc.b	$3a,$20,$49,$6c,$6c,$65,$67,$61,$6c,$20,$69,$6e,$70,$75,$74,$20
	dc.b	$21,$21,$21,$0d,$00
D_31d8e:
	dc.b	$5b,$20,$46,$69,$6e,$64,$5f,$77,$6f,$72,$64,$20,$5d,$20,$3a,$20
	dc.b	$57,$6f,$72,$64,$20,$6e,$75,$6d,$62,$65,$72,$20,$74,$6f,$6f,$20
	dc.b	$68,$69,$67,$68,$20,$21,$21,$21,$0d,$00
D_31db8:
	dc.b	$5b,$20,$46,$69,$6e,$64,$5f,$77,$6f,$72,$64,$20,$5d,$20,$3a,$20
	dc.b	$49,$6c,$6c,$65,$67,$61,$6c,$20,$77,$6f,$72,$64,$20,$6c,$65,$6e
	dc.b	$67,$74,$68,$20,$21,$21,$21,$0d,$00
D_31de1:
	dc.b	$5b,$20,$43,$61,$6c,$63,$5f,$74,$65,$78,$74,$62,$6c,$6f,$63,$6b
	dc.b	$5f,$61,$64,$64,$72,$65,$73,$73,$20,$5d,$20,$3a,$20,$49,$6c,$6c
	dc.b	$65,$67,$61,$6c,$20,$74,$65,$78,$74,$62,$6c,$6f,$63,$6b,$20,$6e
	dc.b	$75,$6d,$62,$65,$72,$20,$21,$21,$21,$0d,$00
D_31e1c:
	dc.b	$5b,$20,$50,$75,$73,$68,$5f,$50,$41,$20,$5d,$20,$3a,$20,$50,$41
	dc.b	$20,$53,$74,$61,$63,$6b,$20,$6f,$76,$65,$72,$66,$6c,$6f,$77,$20
	dc.b	$21,$21,$21,$0d,$00
D_31e41:
	dc.b	$5b,$20,$50,$6f,$70,$5f,$50,$41,$20,$5d,$20,$3a,$20,$50,$41,$20
	dc.b	$53,$74,$61,$63,$6b,$20,$75,$6e,$64,$65,$72,$66,$6c,$6f,$77,$20
	dc.b	$21,$21,$21,$0d,$00
D_31e66:
	dc.b	$5b,$20,$48,$61,$6e,$64,$6c,$65,$5f,$65,$76,$65,$6e,$74,$20,$5d
	dc.b	$20,$3a,$20,$49,$6c,$6c,$65,$67,$61,$6c,$20,$65,$76,$65,$6e,$74
	dc.b	$20,$6e,$75,$6d,$62,$65,$72,$20,$21,$21,$21,$0d,$00
D_31e93:
	dc.b	$5b,$20,$50,$6c,$61,$63,$65,$73,$20,$5d,$20,$3a,$20,$49,$6c,$6c
	dc.b	$65,$67,$61,$6c,$20,$70,$6c,$61,$63,$65,$20,$74,$79,$70,$65,$20
	dc.b	$21,$21,$21,$0d,$00
D_31eb8:
	dc.b	$5b,$20,$43,$72,$65,$61,$74,$65,$5f,$74,$72,$61,$6e,$73,$70,$6f
	dc.b	$72,$74,$20,$5d,$20,$3a,$20,$4e,$6f,$20,$73,$6c,$6f,$74,$20,$66
	dc.b	$72,$65,$65,$20,$21,$21,$21,$0d,$00
D_31ee1:
	dc.b	$5b,$20,$49,$74,$65,$6d,$5f,$72,$65,$73,$20,$5d,$20,$3a,$20,$4c
	dc.b	$6f,$67,$69,$63,$61,$6c,$20,$65,$72,$72,$6f,$72,$20,$21,$20,$43
	dc.b	$6f,$6e,$74,$61,$63,$74,$20,$74,$68,$65,$20,$67,$61,$6d,$65,$20
	dc.b	$64,$65,$73,$69,$67,$6e,$65,$72,$20,$21,$0d,$00
D_31f1d:
	dc.b	$5b,$20,$43,$68,$61,$6e,$67,$65,$5f,$74,$72,$61,$76,$65,$6c,$5f
	dc.b	$6d,$6f,$64,$65,$20,$5d,$20,$3a,$20,$4e,$6f,$20,$73,$6c,$6f,$74
	dc.b	$20,$66,$72,$65,$65,$20,$21,$21,$21,$0d,$00
D_31f48:
	dc.b	$5b,$20,$50,$75,$73,$68,$5f,$4d,$6f,$64,$75,$6c,$65,$20,$5d,$20
	dc.b	$3a,$20,$4d,$6f,$64,$75,$6c,$65,$20,$73,$74,$61,$63,$6b,$20,$6f
	dc.b	$76,$65,$72,$66,$6c,$6f,$77,$20,$21,$21,$21,$0d,$00
D_31f75:
	dc.b	$5b,$20,$50,$6f,$70,$5f,$4d,$6f,$64,$75,$6c,$65,$20,$5d,$20,$3a
	dc.b	$20,$4d,$6f,$64,$75,$6c,$65,$20,$73,$74,$61,$63,$6b,$20,$75,$6e
	dc.b	$64,$65,$72,$66,$6c,$6f,$77,$20,$21,$21,$21,$0d,$00
D_31fa2:
	dc.b	$4f,$72,$64,$65,$72,$2d,$6d,$69,$73,$6d,$61,$74,$63,$68,$20,$2d
	dc.b	$3e,$20,$43,$61,$6e,$27,$74,$20,$70,$75,$74,$20,$6d,$6f,$72,$65
	dc.b	$20,$74,$68,$61,$6e,$20,$6f,$6e,$65,$20,$67,$75,$79,$20,$6f,$6e
	dc.b	$20,$74,$68,$65,$20,$73,$61,$6d,$65,$20,$70,$6c,$61,$63,$65,$20
	dc.b	$21,$0d,$00
D_31fe5:
	dc.b	$5b,$67,$65,$74,$5f,$6d,$6f,$6e,$61,$6e,$7a,$5d,$20,$2d,$3e,$20
	dc.b	$63,$61,$6e,$27,$74,$20,$66,$69,$6e,$64,$20,$6d,$6f,$6e,$73,$74
	dc.b	$65,$72,$74,$79,$70,$65,$0d,$00
D_3200d:
	dc.b	$5b,$20,$67,$65,$74,$5f,$6d,$6f,$6e,$63,$68,$61,$72,$20,$5d,$20
	dc.b	$2d,$3e,$20,$4d,$6f,$6e,$73,$74,$65,$72,$20,$6e,$6f,$74,$20,$69
	dc.b	$6e,$20,$4d,$65,$6d,$6f,$72,$79,$20,$21,$0d,$00
D_32039:
	dc.b	$43,$6f,$6d,$62,$61,$74,$20,$2d,$3e,$20,$4d,$6f,$76,$65,$2d,$64
	dc.b	$65,$73,$74,$69,$6e,$61,$74,$69,$6f,$6e,$20,$6e,$6f,$74,$20,$65
	dc.b	$6d,$70,$74,$79,$20,$21,$0d,$00
D_32061:
	dc.b	$28,$41,$74,$74,$61,$63,$6b,$73,$20,$70,$65,$72,$20,$72,$6f,$75
	dc.b	$6e,$64,$29,$20,$63,$61,$6e,$27,$74,$20,$62,$65,$20,$7a,$65,$72
	dc.b	$6f,$20,$21,$21,$0d,$00
D_32087:
	dc.b	$4f,$62,$6a,$65,$63,$74,$20,$6e,$6f,$74,$20,$66,$6f,$75,$6e,$64
	dc.b	$20,$69,$6e,$20,$69,$6e,$74,$65,$72,$6e,$61,$6c,$20,$6c,$69,$73
	dc.b	$74,$20,$21,$0d,$00
D_320ac:
	dc.b	$41,$20,$67,$61,$72,$62,$61,$67,$65,$20,$63,$6f,$6c,$6c,$65,$63
	dc.b	$74,$69,$6f,$6e,$20,$69,$73,$20,$72,$65,$71,$75,$69,$72,$65,$64
	dc.b	$2e,$0d,$00
D_320cf:
	dc.b	$54,$68,$65,$20,$70,$72,$6f,$67,$72,$61,$6d,$20,$77,$69,$6c,$6c
	dc.b	$20,$72,$65,$2d,$6c,$6f,$61,$64,$20,$73,$6f,$6d,$65,$20,$64,$61
	dc.b	$74,$61,$2e,$0d,$00
D_320f4:
	dc.b	$57,$65,$20,$61,$70,$6f,$6c,$6f,$67,$69,$7a,$65,$20,$66,$6f,$72
	dc.b	$20,$74,$68,$65,$20,$69,$6e,$63,$6f,$6e,$76,$65,$6e,$69,$65,$6e
	dc.b	$63,$65,$2e,$0d,$00
D_32119:
	dc.b	$50,$72,$65,$73,$73,$20,$61,$6e,$79,$20,$6b,$65,$79,$20,$74,$6f
	dc.b	$20,$63,$6f,$6e,$74,$69,$6e,$75,$65,$2e,$0d,$00,$00
Icondata_filename:
	dc.b	$02,$49,$43,$4f,$4e,$5f,$44,$41,$54,$2e,$41,$4d,$42,$00
D_32144:
	dc.b	$05,$4c,$41,$42,$5f,$44,$41,$54,$41,$2e,$41,$4d,$42,$00
D_32152:
	dc.b	$06,$4c,$41,$42,$42,$4c,$4f,$43,$4b,$2e,$41,$4d,$42,$00
D_32160:
	dc.b	$07,$42,$41,$43,$4b,$47,$52,$4e,$44,$2e,$41,$4d,$42,$00
D_3216e:
	dc.b	$08,$43,$4f,$4c,$5f,$50,$41,$4c,$4c,$2e,$41,$4d,$42,$00
D_3217c:
	dc.b	$04,$4d,$41,$50,$5f,$44,$41,$54,$41,$2e,$41,$4d,$42,$00
Maptext_filename:
	dc.b	$0a,$4d,$41,$50,$54,$45,$58,$54,$2e,$41,$4d,$42,$00
Pics80_filename:
	dc.b	$09,$50,$49,$43,$53,$38,$30,$2e,$41,$4d,$42,$00
D_321a3:
	dc.b	$0b,$43,$48,$45,$53,$54,$44,$41,$54,$2e,$41,$4d,$42,$00
D_321b1:
	dc.b	$15,$50,$55,$5a,$5a,$4c,$45,$2e,$49,$43,$4e,$00
D_321bd:
	dc.b	$16,$50,$55,$5a,$5a,$4c,$45,$2e,$54,$58,$54,$00,$00
D_321ca:
	dc.b	$0d,$57,$41,$52,$45,$53,$44,$41,$54,$2e,$41,$4d,$42,$00
Automap_filename:
	dc.b	$11,$41,$55,$54,$4f,$4d,$41,$50,$2e,$41,$4d,$42,$00,$00
D_321e6:
	dc.b	$12,$43,$4f,$44,$45,$54,$58,$54,$2e,$41,$4d,$42,$00,$00
D_321f4:
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
D_32234:
	dc.b	$00,$00,$00,$1f,$00,$20,$00,$2f,$01,$00
	dc.l	D_32246
	dc.b	$00,$00,$00,$00
D_32246:
	dc.b	$00,$20,$00,$3f,$00,$20,$00,$2f,$02,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00
Lay3_L2:
	dc.b	$00,$10,$00,$bf,$00,$91,$00,$c0,$02,$00
	dc.l	Control_area
	dc.l	D_3226a
D_3226a:
	dc.b	$00,$10,$00,$1f,$00,$91,$00,$a0,$01,$00
	dc.l	D_32278
D_32278:
	dc.b	$00,$30,$00,$3f,$00,$91,$00,$a0,$02,$00
	dc.l	D_32286
D_32286:
	dc.b	$00,$50,$00,$5f,$00,$91,$00,$a0,$03,$00
	dc.l	D_32294
D_32294:
	dc.b	$00,$70,$00,$7f,$00,$91,$00,$a0,$04,$00
	dc.l	D_322a2
D_322a2:
	dc.b	$00,$90,$00,$9f,$00,$91,$00,$a0,$05,$00
	dc.l	D_322b0
D_322b0:
	dc.b	$00,$b0,$00,$bf,$00,$91,$00,$a0,$06,$00
	dc.l	D_322be
D_322be:
	dc.b	$00,$10,$00,$1f,$00,$b1,$00,$c0,$07,$00
	dc.l	D_322cc
D_322cc:
	dc.b	$00,$30,$00,$3f,$00,$b1,$00,$c0,$08,$00
	dc.l	D_322da
D_322da:
	dc.b	$00,$50,$00,$5f,$00,$b1,$00,$c0,$09,$00
	dc.l	D_322e8
D_322e8:
	dc.b	$00,$70,$00,$7f,$00,$b1,$00,$c0,$0a,$00
	dc.l	D_322f6
D_322f6:
	dc.b	$00,$90,$00,$9f,$00,$b1,$00,$c0,$0b,$00
	dc.l	D_32304
D_32304:
	dc.b	$00,$b0,$00,$bf,$00,$b1,$00,$c0,$0c,$00,$00,$00,$00,$00
D_32312:
	dc.b	$00,$00,$00,$7f,$00,$00,$00,$6f,$01,$00
	dc.l	D_32324
	dc.l	D_3236c
D_32324:
	dc.b	$00,$00,$00,$1f,$00,$70,$00,$7f,$02,$00
	dc.l	D_32336
	dc.b	$00,$00,$00,$00
D_32336:
	dc.b	$00,$20,$00,$3f,$00,$70,$00,$7f,$03,$00
	dc.l	D_32348
	dc.b	$00,$00,$00,$00
D_32348:
	dc.b	$00,$40,$00,$5f,$00,$70,$00,$7f,$04,$00
	dc.l	D_3235a
	dc.b	$00,$00,$00,$00
D_3235a:
	dc.b	$00,$60,$00,$7f,$00,$70,$00,$7f,$05,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00
D_3236c:
	dc.b	$00,$00,$00,$7f,$00,$00,$00,$06,$01,$00
	dc.l	D_3237e
	dc.b	$00,$00,$00,$00
D_3237e:
	dc.b	$00,$00,$00,$7f,$00,$07,$00,$0d,$02,$00
	dc.l	D_32390
	dc.b	$00,$00,$00,$00
D_32390:
	dc.b	$00,$00,$00,$7f,$00,$0e,$00,$14,$03,$00
	dc.l	D_323a2
	dc.b	$00,$00,$00,$00
D_323a2:
	dc.b	$00,$00,$00,$7f,$00,$15,$00,$1b,$04,$00
	dc.l	D_323b4
	dc.b	$00,$00,$00,$00
D_323b4:
	dc.b	$00,$00,$00,$7f,$00,$1c,$00,$22,$05,$00
	dc.l	D_323c6
	dc.b	$00,$00,$00,$00
D_323c6:
	dc.b	$00,$00,$00,$7f,$00,$23,$00,$29,$06,$00
	dc.l	D_323d8
	dc.b	$00,$00,$00,$00
D_323d8:
	dc.b	$00,$00,$00,$7f,$00,$2a,$00,$30,$07,$00
	dc.l	D_323ea
	dc.b	$00,$00,$00,$00
D_323ea:
	dc.b	$00,$00,$00,$7f,$00,$31,$00,$37,$08,$00
	dc.l	D_323fc
	dc.b	$00,$00,$00,$00
D_323fc:
	dc.b	$00,$00,$00,$7f,$00,$38,$00,$3e,$09,$00
	dc.l	D_3240e
	dc.b	$00,$00,$00,$00
D_3240e:
	dc.b	$00,$00,$00,$7f,$00,$3f,$00,$45,$0a,$00
	dc.l	D_32420
	dc.b	$00,$00,$00,$00
D_32420:
	dc.b	$00,$00,$00,$7f,$00,$46,$00,$4c,$0b,$00
	dc.l	D_32432
	dc.b	$00,$00,$00,$00
D_32432:
	dc.b	$00,$00,$00,$7f,$00,$4d,$00,$53,$0c,$00
	dc.l	D_32444
	dc.b	$00,$00,$00,$00
D_32444:
	dc.b	$00,$00,$00,$7f,$00,$54,$00,$5a,$0d,$00
	dc.l	D_32456
	dc.b	$00,$00,$00,$00
D_32456:
	dc.b	$00,$00,$00,$7f,$00,$5b,$00,$61,$0e,$00
	dc.l	D_32468
	dc.b	$00,$00,$00,$00
D_32468:
	dc.b	$00,$00,$00,$7f,$00,$62,$00,$68,$0f,$00
	dc.l	D_3247a
	dc.b	$00,$00,$00,$00
D_3247a:
	dc.b	$00,$00,$00,$7f,$00,$69,$00,$6f,$10,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00
D_3248c:
	dc.b	$00,$00,$00,$7f,$00,$08,$00,$4d,$01,$00
	dc.l	D_3249e
	dc.l	D_324b0
D_3249e:
	dc.b	$00,$00,$00,$1f,$00,$50,$00,$5f,$02,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00
D_324b0:
	dc.b	$00,$00,$00,$7f,$00,$08,$00,$0e,$01,$00
	dc.l	D_324c2
	dc.b	$00,$00,$00,$00
D_324c2:
	dc.b	$00,$00,$00,$7f,$00,$0f,$00,$15,$02,$00
	dc.l	D_324d4
	dc.b	$00,$00,$00,$00
D_324d4:
	dc.b	$00,$00,$00,$7f,$00,$16,$00,$1c,$03,$00
	dc.l	D_324e6
	dc.b	$00,$00,$00,$00
D_324e6:
	dc.b	$00,$00,$00,$7f,$00,$1d,$00,$23,$04,$00
	dc.l	D_324f8
	dc.b	$00,$00,$00,$00
D_324f8:
	dc.b	$00,$00,$00,$7f,$00,$24,$00,$2a,$05,$00
	dc.l	D_3250a
	dc.b	$00,$00,$00,$00
D_3250a:
	dc.b	$00,$00,$00,$7f,$00,$2b,$00,$31,$06,$00
	dc.l	D_3251c
	dc.b	$00,$00,$00,$00
D_3251c:
	dc.b	$00,$00,$00,$7f,$00,$32,$00,$38,$07,$00
	dc.l	D_3252e
	dc.b	$00,$00,$00,$00
D_3252e:
	dc.b	$00,$00,$00,$7f,$00,$39,$00,$3f,$08,$00
	dc.l	D_32540
	dc.b	$00,$00,$00,$00
D_32540:
	dc.b	$00,$00,$00,$7f,$00,$40,$00,$46,$09,$00
	dc.l	D_32552
	dc.b	$00,$00,$00,$00
D_32552:
	dc.b	$00,$00,$00,$7f,$00,$47,$00,$4d,$0a,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00
SellReq_L2:
	dc.b	$00,$f0,$01,$0f,$00,$51,$00,$61,$01,$00
	dc.l	D_32576
	dc.b	$00,$00,$00,$00
D_32576:
	dc.b	$01,$10,$01,$2f,$00,$51,$00,$61,$02,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00
D_32588:
	dc.b	$00,$10,$00,$8f,$00,$31,$00,$b2,$01,$00
	dc.l	D_3259a
	dc.l	D_325be
D_3259a:
	dc.b	$00,$80,$00,$9f,$00,$b0,$00,$bf,$02,$00
	dc.l	D_325ac
	dc.b	$00,$00,$00,$00
D_325ac:
	dc.b	$00,$a0,$00,$bf,$00,$b0,$00,$bf,$03,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00
D_325be:
	dc.b	$00,$10,$00,$2f,$00,$31,$00,$52,$01,$00
	dc.l	D_325d0
	dc.b	$00,$00,$00,$00
D_325d0:
	dc.b	$00,$70,$00,$8f,$00,$49,$00,$6a,$02,$00
	dc.l	D_325e2
	dc.b	$00,$00,$00,$00
D_325e2:
	dc.b	$00,$10,$00,$2f,$00,$61,$00,$82,$03,$00
	dc.l	D_325f4
	dc.b	$00,$00,$00,$00
D_325f4:
	dc.b	$00,$70,$00,$8f,$00,$79,$00,$9a,$04,$00
	dc.l	D_32606
	dc.b	$00,$00,$00,$00
D_32606:
	dc.b	$00,$10,$00,$2f,$00,$91,$00,$b2,$05,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00
D_32618:
	dc.b	$00,$10,$01,$1f,$00,$31,$00,$80,$02,$00
	dc.l	Control_area
	dc.l	D_3262a
D_3262a:
	dc.b	$00,$10,$00,$2f,$00,$31,$00,$50,$01,$00
	dc.l	D_3263c
	dc.b	$00,$00,$00,$00
D_3263c:
	dc.b	$00,$40,$00,$5f,$00,$31,$00,$50,$02,$00
	dc.l	D_3264e
	dc.b	$00,$00,$00,$00
D_3264e:
	dc.b	$00,$70,$00,$8f,$00,$31,$00,$50,$03,$00
	dc.l	D_32660
	dc.b	$00,$00,$00,$00
D_32660:
	dc.b	$00,$a0,$00,$bf,$00,$31,$00,$50,$04,$00
	dc.l	D_32672
	dc.b	$00,$00,$00,$00
D_32672:
	dc.b	$00,$d0,$00,$ef,$00,$31,$00,$50,$05,$00
	dc.l	D_32684
	dc.b	$00,$00,$00,$00
D_32684:
	dc.b	$01,$00,$01,$1f,$00,$31,$00,$50,$06,$00
	dc.l	D_32696
	dc.b	$00,$00,$00,$00
D_32696:
	dc.b	$00,$10,$00,$2f,$00,$61,$00,$80,$07,$00
	dc.l	D_326a8
	dc.b	$00,$00,$00,$00
D_326a8:
	dc.b	$00,$40,$00,$5f,$00,$61,$00,$80,$08,$00
	dc.l	D_326ba
	dc.b	$00,$00,$00,$00
D_326ba:
	dc.b	$00,$70,$00,$8f,$00,$61,$00,$80,$09,$00
	dc.l	D_326cc
	dc.b	$00,$00,$00,$00
D_326cc:
	dc.b	$00,$a0,$00,$bf,$00,$61,$00,$80,$0a,$00
	dc.l	D_326de
	dc.b	$00,$00,$00,$00
D_326de:
	dc.b	$00,$d0,$00,$ef,$00,$61,$00,$80,$0b,$00
	dc.l	D_326f0
	dc.b	$00,$00,$00,$00
D_326f0:
	dc.b	$01,$00,$01,$1f,$00,$61,$00,$80,$0c,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00
D_32702:
	dc.b	$00,$10,$00,$5f,$00,$51,$00,$a0,$02,$00
	dc.l	Backpack_area
	dc.l	D_32726
Backpack_area:
	dc.b	$00,$70,$00,$bf,$00,$51,$00,$c0,$03,$00
	dc.l	Control_area
	dc.l	D_327a4
D_32726:
	dc.b	$00,$10,$00,$1f,$00,$51,$00,$60,$01,$00
	dc.l	D_32734
D_32734:
	dc.b	$00,$30,$00,$3f,$00,$51,$00,$60,$02,$00
	dc.l	D_32742
D_32742:
	dc.b	$00,$50,$00,$5f,$00,$51,$00,$60,$03,$00
	dc.l	D_32750
D_32750:
	dc.b	$00,$10,$00,$1f,$00,$71,$00,$80,$04,$00
	dc.l	D_3275e
D_3275e:
	dc.b	$00,$30,$00,$3f,$00,$71,$00,$80,$05,$00
	dc.l	D_3276c
D_3276c:
	dc.b	$00,$50,$00,$5f,$00,$71,$00,$80,$06,$00
	dc.l	D_3277a
D_3277a:
	dc.b	$00,$10,$00,$1f,$00,$91,$00,$a0,$07,$00
	dc.l	D_32788
D_32788:
	dc.b	$00,$30,$00,$3f,$00,$91,$00,$a0,$08,$00
	dc.l	D_32796
D_32796:
	dc.b	$00,$50,$00,$5f,$00,$91,$00,$a0,$09,$00,$00,$00,$00,$00
D_327a4:
	dc.b	$00,$70,$00,$7f,$00,$51,$00,$60,$01,$00
	dc.l	D_327b2
D_327b2:
	dc.b	$00,$90,$00,$9f,$00,$51,$00,$60,$02,$00
	dc.l	D_327c0
D_327c0:
	dc.b	$00,$b0,$00,$bf,$00,$51,$00,$60,$03,$00
	dc.l	D_327ce
D_327ce:
	dc.b	$00,$70,$00,$7f,$00,$71,$00,$80,$04,$00
	dc.l	D_327dc
D_327dc:
	dc.b	$00,$90,$00,$9f,$00,$71,$00,$80,$05,$00
	dc.l	D_327ea
D_327ea:
	dc.b	$00,$b0,$00,$bf,$00,$71,$00,$80,$06,$00
	dc.l	D_327f8
D_327f8:
	dc.b	$00,$70,$00,$7f,$00,$91,$00,$a0,$07,$00
	dc.l	D_32806
D_32806:
	dc.b	$00,$90,$00,$9f,$00,$91,$00,$a0,$08,$00
	dc.l	D_32814
D_32814:
	dc.b	$00,$b0,$00,$bf,$00,$91,$00,$a0,$09,$00
	dc.l	D_32822
D_32822:
	dc.b	$00,$70,$00,$7f,$00,$b1,$00,$c0,$0a,$00
	dc.l	D_32830
D_32830:
	dc.b	$00,$90,$00,$9f,$00,$b1,$00,$c0,$0b,$00
	dc.l	D_3283e
D_3283e:
	dc.b	$00,$b0,$00,$bf,$00,$b1,$00,$c0,$0c,$00,$00,$00,$00,$00
ItemW_L1:
	dc.b	$00,$00,$00,$8f,$00,$00,$00,$3f,$01,$00,$00,$00,$00,$00
	dc.l	D_3285e
D_3285e:
	dc.b	$00,$00,$00,$1f,$00,$20,$00,$2f,$01,$00
	dc.l	D_32870
	dc.b	$00,$00,$00,$00
D_32870:
	dc.b	$00,$00,$00,$1f,$00,$30,$00,$3f,$02,$00
	dc.l	D_32882
	dc.b	$00,$00,$00,$00
D_32882:
	dc.b	$00,$50,$00,$6f,$00,$30,$00,$3f,$03,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00
D_32894:
	dc.b	$00,$00,$00,$8f,$00,$00,$00,$3f,$01,$00,$00,$00,$00,$00
	dc.l	D_328a6
D_328a6:
	dc.b	$00,$00,$00,$1f,$00,$20,$00,$2f,$01,$00
	dc.l	D_328b8
	dc.b	$00,$00,$00,$00
D_328b8:
	dc.b	$00,$00,$00,$1f,$00,$30,$00,$3f,$02,$00
	dc.l	D_328ca
	dc.b	$00,$00,$00,$00
D_328ca:
	dc.b	$00,$50,$00,$6f,$00,$30,$00,$3f,$03,$00
	dc.l	D_328dc
	dc.b	$00,$00,$00,$00
D_328dc:
	dc.b	$00,$50,$00,$6f,$00,$20,$00,$2f,$04,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00
D_328ee:
	dc.b	$00,$e0,$00,$ff,$00,$30,$00,$3f,$01,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00
D_32900:
	dc.b	$00,$00,$00,$bf,$00,$05,$00,$54,$01,$00,$00,$00,$00,$00
	dc.l	D_32912
D_32912:
	dc.b	$00,$00,$00,$5f,$00,$05,$00,$0b,$01,$00
	dc.l	D_32924
	dc.b	$00,$00,$00,$00
D_32924:
	dc.b	$00,$00,$00,$5f,$00,$0c,$00,$12,$02,$00
	dc.l	D_32936
	dc.b	$00,$00,$00,$00
D_32936:
	dc.b	$00,$00,$00,$5f,$00,$13,$00,$19,$03,$00
	dc.l	D_32948
	dc.b	$00,$00,$00,$00
D_32948:
	dc.b	$00,$00,$00,$5f,$00,$1a,$00,$20,$04,$00
	dc.l	D_3295a
	dc.b	$00,$00,$00,$00
D_3295a:
	dc.b	$00,$00,$00,$5f,$00,$21,$00,$27,$05,$00
	dc.l	D_3296c
	dc.b	$00,$00,$00,$00
D_3296c:
	dc.b	$00,$00,$00,$5f,$00,$28,$00,$2e,$06,$00
	dc.l	D_3297e
	dc.b	$00,$00,$00,$00
D_3297e:
	dc.b	$00,$00,$00,$5f,$00,$2f,$00,$35,$07,$00
	dc.l	D_32990
	dc.b	$00,$00,$00,$00
D_32990:
	dc.b	$00,$00,$00,$5f,$00,$36,$00,$3c,$08,$00
	dc.l	D_329a2
	dc.b	$00,$00,$00,$00
D_329a2:
	dc.b	$00,$00,$00,$5f,$00,$3d,$00,$43,$09,$00
	dc.l	D_329b4
	dc.b	$00,$00,$00,$00
D_329b4:
	dc.b	$00,$00,$00,$5f,$00,$44,$00,$4a,$0a,$00
	dc.l	D_329c6
	dc.b	$00,$00,$00,$00
D_329c6:
	dc.b	$00,$60,$00,$bf,$00,$05,$00,$0b,$0b,$00
	dc.l	D_329d8
	dc.b	$00,$00,$00,$00
D_329d8:
	dc.b	$00,$60,$00,$bf,$00,$0c,$00,$12,$0c,$00
	dc.l	D_329ea
	dc.b	$00,$00,$00,$00
D_329ea:
	dc.b	$00,$60,$00,$bf,$00,$13,$00,$19,$0d,$00
	dc.l	D_329fc
	dc.b	$00,$00,$00,$00
D_329fc:
	dc.b	$00,$60,$00,$bf,$00,$1a,$00,$20,$0e,$00
	dc.l	D_32a0e
	dc.b	$00,$00,$00,$00
D_32a0e:
	dc.b	$00,$60,$00,$bf,$00,$21,$00,$27,$0f,$00
	dc.l	D_32a20
	dc.b	$00,$00,$00,$00
D_32a20:
	dc.b	$00,$60,$00,$bf,$00,$28,$00,$2e,$10,$00
	dc.l	D_32a32
	dc.b	$00,$00,$00,$00
D_32a32:
	dc.b	$00,$60,$00,$bf,$00,$2f,$00,$35,$11,$00
	dc.l	D_32a44
	dc.b	$00,$00,$00,$00
D_32a44:
	dc.b	$00,$60,$00,$bf,$00,$36,$00,$3c,$12,$00
	dc.l	D_32a56
	dc.b	$00,$00,$00,$00
D_32a56:
	dc.b	$00,$60,$00,$bf,$00,$3d,$00,$43,$13,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00
D_32a68:
	dc.b	$00,$00,$00,$7f,$00,$00,$00,$30,$01,$00,$00,$00,$00,$00
	dc.l	D_32a7a
D_32a7a:
	dc.b	$00,$00,$00,$7f,$00,$00,$00,$06,$01,$00
	dc.l	D_32a8c
	dc.b	$00,$00,$00,$00
D_32a8c:
	dc.b	$00,$00,$00,$7f,$00,$07,$00,$0d,$02,$00
	dc.l	D_32a9e
	dc.b	$00,$00,$00,$00
D_32a9e:
	dc.b	$00,$00,$00,$7f,$00,$0e,$00,$14,$03,$00
	dc.l	D_32ab0
	dc.b	$00,$00,$00,$00
D_32ab0:
	dc.b	$00,$00,$00,$7f,$00,$15,$00,$1b,$04,$00
	dc.l	D_32ac2
	dc.b	$00,$00,$00,$00
D_32ac2:
	dc.b	$00,$00,$00,$7f,$00,$1c,$00,$22,$05,$00
	dc.l	D_32ad4
	dc.b	$00,$00,$00,$00
D_32ad4:
	dc.b	$00,$00,$00,$7f,$00,$23,$00,$29,$06,$00
	dc.l	D_32ae6
	dc.b	$00,$00,$00,$00
D_32ae6:
	dc.b	$00,$00,$00,$7f,$00,$2a,$00,$30,$07,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00
D_32af8:
	dc.b	$00,$00,$00,$7f,$00,$00,$00,$6f,$01,$00
	dc.l	D_32b0a
	dc.l	D_32b40
D_32b0a:
	dc.b	$00,$00,$00,$1f,$00,$70,$00,$7f,$02,$00
	dc.l	D_32b1c
	dc.b	$00,$00,$00,$00
D_32b1c:
	dc.b	$00,$20,$00,$3f,$00,$70,$00,$7f,$03,$00
	dc.l	D_32b2e
	dc.b	$00,$00,$00,$00
D_32b2e:
	dc.b	$00,$80,$00,$9f,$00,$70,$00,$7f,$04,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00
D_32b40:
	dc.b	$00,$00,$00,$7f,$00,$00,$00,$06,$01,$00
	dc.l	D_32b52
	dc.b	$00,$00,$00,$00
D_32b52:
	dc.b	$00,$00,$00,$7f,$00,$07,$00,$0d,$02,$00
	dc.l	D_32b64
	dc.b	$00,$00,$00,$00
D_32b64:
	dc.b	$00,$00,$00,$7f,$00,$0e,$00,$14,$03,$00
	dc.l	D_32b76
	dc.b	$00,$00,$00,$00
D_32b76:
	dc.b	$00,$00,$00,$7f,$00,$15,$00,$1b,$04,$00
	dc.l	D_32b88
	dc.b	$00,$00,$00,$00
D_32b88:
	dc.b	$00,$00,$00,$7f,$00,$1c,$00,$22,$05,$00
	dc.l	D_32b9a
	dc.b	$00,$00,$00,$00
D_32b9a:
	dc.b	$00,$00,$00,$7f,$00,$23,$00,$29,$06,$00
	dc.l	D_32bac
	dc.b	$00,$00,$00,$00
D_32bac:
	dc.b	$00,$00,$00,$7f,$00,$2a,$00,$30,$07,$00
	dc.l	D_32bbe
	dc.b	$00,$00,$00,$00
D_32bbe:
	dc.b	$00,$00,$00,$7f,$00,$31,$00,$37,$08,$00
	dc.l	D_32bd0
	dc.b	$00,$00,$00,$00
D_32bd0:
	dc.b	$00,$00,$00,$7f,$00,$38,$00,$3e,$09,$00
	dc.l	D_32be2
	dc.b	$00,$00,$00,$00
D_32be2:
	dc.b	$00,$00,$00,$7f,$00,$3f,$00,$45,$0a,$00
	dc.l	D_32bf4
	dc.b	$00,$00,$00,$00
D_32bf4:
	dc.b	$00,$00,$00,$7f,$00,$46,$00,$4c,$0b,$00
	dc.l	D_32c06
	dc.b	$00,$00,$00,$00
D_32c06:
	dc.b	$00,$00,$00,$7f,$00,$4d,$00,$53,$0c,$00
	dc.l	D_32c18
	dc.b	$00,$00,$00,$00
D_32c18:
	dc.b	$00,$00,$00,$7f,$00,$54,$00,$5a,$0d,$00
	dc.l	D_32c2a
	dc.b	$00,$00,$00,$00
D_32c2a:
	dc.b	$00,$00,$00,$7f,$00,$5b,$00,$61,$0e,$00
	dc.l	D_32c3c
	dc.b	$00,$00,$00,$00
D_32c3c:
	dc.b	$00,$00,$00,$7f,$00,$62,$00,$68,$0f,$00
	dc.l	D_32c4e
	dc.b	$00,$00,$00,$00
D_32c4e:
	dc.b	$00,$00,$00,$7f,$00,$69,$00,$6f,$10,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00
D_32c60:
	dc.b	$00,$70,$00,$8f,$00,$20,$00,$2f,$01,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00
D_32c72:
	dc.b	$00,$00,$01,$3f,$00,$00,$00,$23,$01,$00,$00,$00,$00,$00
	dc.l	D_32ca8
D_32c84:
	dc.b	$00,$00,$01,$3f,$00,$00,$00,$23,$01,$00
	dc.l	D_32c96
	dc.l	D_32ca8
D_32c96:
	dc.b	$00,$00,$01,$3f,$00,$25,$00,$c7,$02,$00,$00,$00,$00,$00
Layout_data_ptr:
	dc.b	$00,$00,$00,$00
D_32ca8:
	dc.b	$00,$10,$00,$2f,$00,$01,$00,$23,$01,$00
	dc.l	D_32cba
	dc.b	$00,$00,$00,$00
D_32cba:
	dc.b	$00,$40,$00,$5f,$00,$01,$00,$23,$02,$00
	dc.l	D_32ccc
	dc.b	$00,$00,$00,$00
D_32ccc:
	dc.b	$00,$70,$00,$8f,$00,$01,$00,$23,$03,$00
	dc.l	D_32cde
	dc.b	$00,$00,$00,$00
D_32cde:
	dc.b	$00,$a0,$00,$bf,$00,$01,$00,$23,$04,$00
	dc.l	D_32cf0
	dc.b	$00,$00,$00,$00
D_32cf0:
	dc.b	$00,$d0,$00,$ef,$00,$01,$00,$23,$05,$00
	dc.l	D_32d02
	dc.b	$00,$00,$00,$00
D_32d02:
	dc.b	$01,$00,$01,$1f,$00,$01,$00,$23,$06,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00
Control_area:
	dc.b	$00,$d0,$01,$2f,$00,$91,$00,$c0,$01,$00,$00,$00,$00,$00
	dc.l	D_32d26
D_32d26:
	dc.b	$00,$d0,$00,$ef,$00,$91,$00,$a0,$01,$00
	dc.l	D_32d34
D_32d34:
	dc.b	$00,$f0,$01,$0f,$00,$91,$00,$a0,$02,$00
	dc.l	D_32d42
D_32d42:
	dc.b	$01,$10,$01,$2f,$00,$91,$00,$a0,$03,$00
	dc.l	D_32d50
D_32d50:
	dc.b	$00,$d0,$00,$ef,$00,$a1,$00,$b0,$04,$00
	dc.l	D_32d5e
D_32d5e:
	dc.b	$00,$f0,$01,$0f,$00,$a1,$00,$b0,$05,$00
	dc.l	D_32d6c
D_32d6c:
	dc.b	$01,$10,$01,$2f,$00,$a1,$00,$b0,$06,$00
	dc.l	D_32d7a
D_32d7a:
	dc.b	$00,$d0,$00,$ef,$00,$b1,$00,$c0,$07,$00
	dc.l	D_32d88
D_32d88:
	dc.b	$00,$f0,$01,$0f,$00,$b1,$00,$c0,$08,$00
	dc.l	D_32d96
D_32d96:
	dc.b	$01,$10,$01,$2f,$00,$b1,$00,$c0,$09,$00,$00,$00,$00,$00
D_32da4:
	dc.b	$00,$f0,$01,$0f,$00,$b0,$00,$bf,$01,$00
	dc.l	D_32db6
	dc.b	$00,$00,$00,$00
D_32db6:
	dc.b	$01,$10,$01,$2f,$00,$b0,$00,$bf,$02,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00
D_32dc8:
	dc.b	$00,$10,$00,$2f,$00,$20,$00,$2f,$01,$00
	dc.l	D_32dda
	dc.b	$00,$00,$00,$00
D_32dda:
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
D_32ec0:
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
D_331aa:
	dc.b	$ff,$00,$00,$00,$07,$50,$03,$33,$02,$22,$01,$11,$07,$42,$06,$31
	dc.b	$02,$00,$05,$66,$03,$45,$07,$54,$06,$43,$05,$32,$04,$21,$03,$10
	dc.b	$07,$65,$24,$00
D_331ce:
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
D_332e6:
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
D_33392:
	dc.b	$ff,$00,$00,$00,$07,$50,$03,$33,$02,$22,$01,$11,$07,$42,$06,$31
	dc.b	$02,$00,$05,$66,$03,$45,$07,$54,$06,$43,$05,$32,$04,$21,$03,$10
	dc.b	$07,$65,$24,$00
D_333b6:
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
B_5b82a:
	ds.b	1
B_5b82b:
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
B_5b83e:
	ds.b	2
B_5b840:
	ds.b	4
B_5b844:
	ds.b	4
B_5b848:
	ds.b	2
B_5b84a:
	ds.b	2
