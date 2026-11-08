; MAIN/STATUS.ASM (original module, merged with the disassembly of the shipped program)

	section	text

; ---- Status_F0 (original source: MAIN/STATUS.ASM)
Status_F0:
	move.w	Travel_mode,d0
	tst.w	d0
	beq.s	.On
	moveq.l	#0,d0
	bra.s	.Exit
.On:
	moveq.l	#6,d0
.Exit:
	bsr.w	Set_new_travel_mode
	rts	
T_019d6:
	tst.b	D_1dc94
	beq.w	.l_01af8
	st.b	Time_lock
	movem.l	d0-d7/a0-a6,-(a7)
	jsr	ON_Diag_screen
	jsr	DI_Cursor_home
	movea.l	Screen_base,a6
	lea.l	D_31bba,a0
	jsr	DI_Print
	jsr	DI_Carriage_return
	lea.l	Chard_ptrs,a0
	moveq	#5,d7
.l_01a16:
	tst.l	(a0)
	beq.w	.l_01aca
	movea.l	(a0),a1
	lea.l	$22(a1),a2
	lea.l	Inv_data(a1),a3
	moveq	#0,d1
	moveq	#20,d6
.l_01a2a:
	moveq	#0,d0
	move.b	(a2)+,d0
	beq.b	.l_01a36
	mulu.w	$22(a3),d0
	add.l	d0,d1
.l_01a36:
	lea.l	$28(a3),a3
	dbra	d6,.l_01a2a
	moveq	#0,d0
	move.w	Gold_coins(a1),d0
	mulu.w	#$a,d0
	add.l	d0,d1
	moveq	#0,d0
	move.w	Food_rations(a1),d0
	mulu.w	#$fa,d0
	add.l	d0,d1
	move.l	Weight_normal(a1),d0
	cmp.l	d0,d1
	beq.b	.l_01aca
	move.l	a0,-(a7)
	lea.l	D_31bcc,a0
	jsr	DI_Print
	lea.l	Char_name(a1),a0
	jsr	DI_Print
	jsr	DI_Carriage_return
	lea.l	D_31bd7,a0
	jsr	DI_Print
	jsr	DI_Carriage_return
	lea.l	D_31bf1,a0
	jsr	DI_Print
	move.l	d0,d0
	jsr	DI_Decl_print
	jsr	DI_Carriage_return
	lea.l	D_31c06,a0
	jsr	DI_Print
	move.l	d1,d0
	jsr	DI_Decl_print
	jsr	DI_Carriage_return
	jsr	DI_Carriage_return
	movea.l	(a7)+,a0
.l_01aca:
	addq.l	#$4,a0
	dbra	d7,.l_01a16
	jsr	DI_Carriage_return
	lea.l	D_31c1b,a0
	jsr	DI_Print
	jsr	Wait_4_key
	jsr	OFF_Diag_screen
	movem.l	(a7)+,d0-d7/a0-a6
	sf.b	Time_lock
.l_01af8:
	rts
T_01afa:
	tst.b	D_1dc94
	beq.b	.l_01b24
	movea.l	Current_active_char_data,a1
	clr.w	Body_conditions(a1)
	move.w	Life_points_max(a1),d0
	add.w	Life_points_max_magic(a1),d0
	move.w	d0,Life_points_normal(a1)
	move.w	Power_points_max(a1),d0
	add.w	Power_points_max_magic(a1),d0
	move.w	d0,Power_points_normal(a1)
.l_01b24:
	rts
T_01b26:
	tst.b	D_1dc94
	beq.b	.l_01b3a
	lea.l	D_307ce,a0
	jsr	Push_Module
.l_01b3a:
	rts
T_01b3c:
	tst.b	D_1dc94
	beq.b	.l_01b82
	movea.l	Current_active_char_data,a0
	move.b	#$8e,Spell_class_counter(a0)
	move.l	#$ffffffff,Spells_class_1(a0)
	move.l	#$ffffffff,Spells_class_2(a0)
	move.l	#$ffffffff,Spells_class_3(a0)
	move.l	#$ffffffff,Spells_class_7(a0)
	move.w	#$1f4,Power_points_normal(a0)
	move.w	#$1f4,Power_points_max(a0)
	move.b	#$63,Skill_10(a0)
.l_01b82:
	rts
T_01b84:
	tst.b	D_1dc94
	beq.b	.l_01ba0
	move.w	Travel_mode,d0
	addq.w	#$1,d0
	cmpi.w	#$7,d0
	bmi.b	.l_01b9c
	moveq	#0,d0
.l_01b9c:
	bsr.w	Set_new_travel_mode
.l_01ba0:
	rts
T_01ba2:
	tst.b	D_1dc94
	beq.b	.l_01bb0
	jmp	T_1a214
.l_01bb0:
	rts
T_01bb2:
	tst.b	D_1dc94
	beq.w	.l_01c46
	st.b	Time_lock
	movem.l	d0-d7/a0-a6,-(a7)
	jsr	ON_Diag_screen
	jsr	DI_Cursor_home
	movea.l	Screen_base,a6
	lea.l	D_31c36,a0
	jsr	DI_Print
	jsr	DI_Carriage_return
	movea.l	Current_active_char_data,a1
	lea.l	D_31c4f,a0
	jsr	DI_Print
	move.w	Gold_coins(a1),d0
	jsr	DI_Decw_print
	jsr	DI_Carriage_return
.l_01c0c:
	lea.l	D_31c65,a0
	jsr	DI_Input
	tst.l	d0
	bmi.b	.l_01c36
	beq.b	.l_01c0c
	moveq	#0,d1
	move.w	Gold_coins(a1),d1
	add.w	d0,d1
	bvs.b	.l_01c0c
	move.w	d0,d1
	mulu.w	#$a,d1
	add.l	d1,Weight_normal(a1)
	add.w	d0,Gold_coins(a1)
.l_01c36:
	jsr	OFF_Diag_screen
	movem.l	(a7)+,d0-d7/a0-a6
	sf.b	Time_lock
.l_01c46:
	rts
T_01c48:
	tst.b	D_1dc94
	beq.w	.l_01d8c
	st.b	Time_lock
	movem.l	d0-d7/a0-a6,-(a7)
	jsr	ON_Diag_screen
	jsr	DI_Cursor_home
	movea.l	Screen_base,a6
	lea.l	D_31c7b,a0
	jsr	DI_Print
	jsr	DI_Carriage_return
	movea.l	Event_data_ptr,a1
	lea.l	D_31c90,a0
	jsr	DI_Print
	move.b	(a1),d0
	jsr	DI_Decb_print
	jsr	DI_Carriage_return
	lea.l	D_31c9a,a0
	jsr	DI_Print
	move.b	$1(a1),d0
	jsr	DI_Decb_print
	jsr	DI_Carriage_return
	lea.l	D_31ca4,a0
	jsr	DI_Print
	move.b	$2(a1),d0
	jsr	DI_Decb_print
	jsr	DI_Carriage_return
	lea.l	D_31cae,a0
	jsr	DI_Print
	move.b	$3(a1),d0
	jsr	DI_Decb_print
	jsr	DI_Carriage_return
	lea.l	D_31cb8,a0
	jsr	DI_Print
	move.b	$4(a1),d0
	jsr	DI_Decb_print
	jsr	DI_Carriage_return
	lea.l	D_31cc2,a0
	jsr	DI_Print
	move.w	$6(a1),d0
	jsr	DI_Decw_print
	jsr	DI_Carriage_return
	lea.l	D_31ccc,a0
	jsr	DI_Print
	move.w	$8(a1),d0
	jsr	DI_Decw_print
	jsr	DI_Carriage_return
	lea.l	D_31cd6,a0
	jsr	DI_Print
	move.b	$5(a1),d0
	jsr	DI_Decb_print
	jsr	DI_Carriage_return
	jsr	DI_Carriage_return
	lea.l	D_31ce0,a0
	jsr	DI_Print
	jsr	Wait_4_key
	jsr	OFF_Diag_screen
	movem.l	(a7)+,d0-d7/a0-a6
	sf.b	Time_lock
.l_01d8c:
	rts
T_01d8e:
	tst.b	D_1dc94
	beq.b	.l_01de0
	st.b	Time_lock
	movem.l	d0-d7/a0-a6,-(a7)
	jsr	ON_Diag_screen
	jsr	DI_Cursor_home
	movea.l	Screen_base,a6
	lea.l	D_31cfb,a0
	jsr	DI_Print
	move.w	Active_member,d0
	jsr	DI_Decw_print
	jsr	Wait_4_key
	jsr	OFF_Diag_screen
	movem.l	(a7)+,d0-d7/a0-a6
	sf.b	Time_lock
.l_01de0:
	rts
T_01de2:
	st.b	Time_lock
	movem.l	d0-d7/a0-a6,-(a7)
	jsr	ON_Diag_screen
	jsr	DI_Cursor_home
	movea.l	Screen_base,a6
	lea.l	Memory_list,a1
	movea.l	Memlist_end,a2
.l_01e0a:
	btst	#$7,$8(a1)
	bne.b	.l_01e5a
	move.l	$0(a1),d0
	jsr	T_1c2e0
	move.l	$4(a1),d0
	jsr	DI_Decl_print
	lea.l	Memory_types,a3
	moveq	#127,d0
	and.b	$8(a1),d0
	add.w	d0,d0
	add.w	d0,d0
	movea.l	(a3,d0.w),a3
	lea.l	(a3),a0
	jsr	DI_Print
	tst.w	d0
	beq.b	.l_01e54
	move.w	$a(a1),d0
	addq.w	#$1,d0
	move.w	d0,d0
	jsr	DI_Decw_print
.l_01e54:
	jsr	DI_Carriage_return
.l_01e5a:
	lea.l	$c(a1),a1
	cmpa.l	a2,a1
	bmi.b	.l_01e0a
	jsr	Wait_4_key
	lea.l	Memory_list,a1
	movea.l	Memlist_end,a2
	move.l	B_60a3e,d0
.l_01e7a:
	btst	#$7,$8(a1)
	bne.b	.l_01e86
	sub.l	$4(a1),d0
.l_01e86:
	lea.l	$c(a1),a1
	cmpa.l	a2,a1
	bmi.b	.l_01e7a
	sub.l	Size_of_free_memory,d0
	beq.b	.l_01eb8
	lea.l	D_31d0c,a0
	jsr	DI_Print
	lea.l	D_31d20,a0
	jsr	DI_Print
	move.l	d0,d0
	jsr	DI_Decl_print
	bra.b	.l_01ec4
.l_01eb8:
	lea.l	D_31d2e,a0
	jsr	DI_Print
.l_01ec4:
	jsr	Wait_4_key
	jsr	OFF_Diag_screen
	movem.l	(a7)+,d0-d7/a0-a6
	sf.b	Time_lock
	rts

	section	data

Picture_filename:
	dc.b	$00,$41,$4d,$42
D_1dc99:
	dc.b	$52,$6e,$6e,$6e,$6e,$2e,$4e,$45,$4f,$00
Raster_filename:
	dc.b	$00,$41,$4d,$42
D_1dca7:
	dc.b	$52,$6e,$6e,$6e,$6e,$2e,$52,$53,$54,$00
D_1dcb1:
	dc.b	$03,$02,$41,$4d,$42,$45,$52,$53,$54,$41,$52,$03,$01,$20,$48,$45
	dc.b	$4c,$50,$20,$53,$43,$52,$45,$45,$4e,$20,$0d,$03,$02,$20,$5b,$20
	dc.b	$51,$20,$5d,$03,$01,$20,$2d,$20,$53,$74,$61,$74,$75,$73,$20,$73
	dc.b	$63,$72,$65,$65,$6e,$2e,$0d,$03,$02,$20,$5b,$20,$57,$20,$5d,$03
	dc.b	$01,$20,$2d,$20,$56,$69,$65,$77,$20,$61,$6c,$6c,$6f,$63,$61,$74
	dc.b	$65,$64,$20,$6d,$65,$6d,$6f,$72,$79,$2e,$0d,$03,$02,$20,$5b,$20
	dc.b	$45,$20,$5d,$03,$01,$20,$2d,$20,$56,$69,$65,$77,$20,$66,$72,$65
	dc.b	$65,$20,$6d,$65,$6d,$6f,$72,$79,$2e,$0d,$03,$02,$20,$5b,$20,$52
	dc.b	$20,$5d,$03,$01,$20,$2d,$20,$56,$69,$65,$77,$20,$6d,$6f,$64,$69
	dc.b	$66,$69,$63,$61,$74,$69,$6f,$6e,$20,$69,$6e,$66,$6f,$2e,$0d,$03
	dc.b	$02,$20,$5b,$20,$54,$20,$5d,$03,$01,$20,$2d,$20,$56,$69,$65,$77
	dc.b	$20,$6d,$6f,$64,$75,$6c,$65,$20,$73,$74,$61,$63,$6b,$2e,$0d,$03
	dc.b	$02,$20,$5b,$20,$5a,$20,$5d,$03,$01,$20,$2d,$20,$49,$6e,$63,$72
	dc.b	$65,$61,$73,$65,$20,$65,$78,$70,$65,$72,$69,$65,$6e,$63,$65,$20
	dc.b	$70,$6f,$69,$6e,$74,$73,$2e,$0d,$03,$02,$20,$5b,$20,$55,$20,$5d
	dc.b	$03,$01,$20,$2d,$20,$56,$69,$65,$77,$20,$6d,$61,$70,$2e,$0d,$03
	dc.b	$02,$20,$5b,$20,$49,$20,$5d,$03,$01,$20,$2d,$20,$43,$68,$61,$6e
	dc.b	$67,$65,$20,$6d,$61,$70,$2e,$0d,$03,$02,$20,$5b,$20,$4f,$20,$5d
	dc.b	$03,$01,$20,$2d,$20,$53,$61,$76,$65,$20,$4e,$45,$4f,$2d,$70,$69
	dc.b	$63,$74,$75,$72,$65,$2e,$0d,$03,$02,$20,$5b,$20,$50,$20,$5d,$03
	dc.b	$01,$20,$2d,$20,$54,$6f,$67,$67,$6c,$65,$20,$53,$75,$70,$65,$72
	dc.b	$63,$68,$69,$63,$6b,$65,$6e,$20,$6d,$6f,$64,$65,$2e,$0d,$0d,$03
	dc.b	$02,$20,$5b,$20,$41,$20,$5d,$03,$01,$20,$2d,$20,$54,$65,$73,$74
	dc.b	$20,$77,$65,$69,$67,$68,$74,$2e,$0d,$03,$02,$20,$5b,$20,$53,$20
	dc.b	$5d,$03,$01,$20,$2d,$20,$52,$65,$76,$69,$76,$65,$20,$61,$63,$74
	dc.b	$69,$76,$65,$20,$63,$68,$61,$72,$61,$63,$74,$65,$72,$2e,$0d,$03
	dc.b	$02,$20,$5b,$20,$44,$20,$5d,$03,$01,$20,$2d,$20,$53,$65,$6c,$65
	dc.b	$63,$74,$20,$6d,$75,$73,$69,$63,$2e,$0d,$03,$02,$20,$5b,$20,$46
	dc.b	$20,$5d,$03,$01,$20,$2d,$20,$43,$68,$65,$61,$74,$20,$73,$70,$65
	dc.b	$6c,$6c,$73,$2e,$0d,$03,$02,$20,$5b,$20,$47,$20,$5d,$03,$01,$20
	dc.b	$2d,$20,$43,$79,$63,$6c,$65,$20,$74,$68,$72,$6f,$75,$67,$68,$20
	dc.b	$74,$72,$61,$76,$65,$6c,$6d,$6f,$64,$65,$73,$2e,$0d,$03,$02,$20
	dc.b	$5b,$20,$48,$20,$5d,$03,$01,$20,$2d,$20,$54,$65,$73,$74,$20,$67
	dc.b	$61,$72,$62,$61,$67,$65,$20,$63,$6f,$6c,$6c,$65,$63,$74,$69,$6f
	dc.b	$6e,$2e,$0d,$03,$02,$20,$5b,$20,$4a,$20,$5d,$03,$01,$20,$2d,$20
	dc.b	$49,$6e,$63,$72,$65,$61,$73,$65,$20,$67,$6f,$6c,$64,$20,$63,$6f
	dc.b	$69,$6e,$73,$2e,$0d,$03,$02,$20,$5b,$20,$4b,$20,$5d,$03,$01,$20
	dc.b	$2d,$20,$56,$69,$65,$77,$20,$6c,$61,$73,$74,$20,$65,$76,$65,$6e
	dc.b	$74,$27,$73,$20,$64,$61,$74,$61,$2e,$0d,$03,$02,$20,$5b,$20,$4c
	dc.b	$20,$5d,$03,$01,$20,$2d,$20,$57,$68,$61,$74,$65,$76,$65,$72,$2e
	dc.b	$0d,$0d,$03,$02,$50,$72,$65,$73,$73,$20,$61,$6e,$79,$20,$6b,$65
	dc.b	$79,$20,$74,$6f,$20,$72,$65,$73,$75,$6d,$65,$2e,$03,$01,$00
D_1df50:
	dc.b	$5b,$20,$41,$4d,$42,$45,$52,$53,$54,$41,$52,$20,$49,$20,$5d,$0d
	dc.b	$0d,$56,$65,$72,$73,$69,$6f,$6e,$20,$3a,$20,$31,$2e,$39,$34,$20
	dc.b	$44,$20,$28,$38,$2d,$39,$2d,$31,$39,$39,$32,$29,$0d,$0d,$50,$72
	dc.b	$65,$73,$73,$20,$61,$6e,$79,$20,$6b,$65,$79,$20,$74,$6f,$20,$72
	dc.b	$65,$73,$75,$6d,$65,$2e,$00,$00
Memory_types:
	dc.l	Memory_types_Text00
	dc.l	Memory_types_Text01
	dc.l	Memory_types_Text02
	dc.l	Memory_types_Text03
	dc.l	Memory_types_Text04
	dc.l	Memory_types_Text05
	dc.l	Memory_types_Text06
	dc.l	Memory_types_Text07
	dc.l	Memory_types_Text08
	dc.l	Memory_types_Text09
	dc.l	Memory_types_Text10
	dc.l	Memory_types_Text11
	dc.l	Memory_types_Text12
	dc.l	Memory_types_Text13
	dc.l	Memory_types_Text14
	dc.l	Memory_types_Text15
	dc.l	Memory_types_Text16
	dc.l	Memory_types_Text17
	dc.l	Memory_types_Text18
	dc.l	D_1e0d5
	dc.l	D_1e0e4
	dc.l	D_1e0f5
	dc.l	D_1e105
Memory_types_Text00:
	dc.b	$4d,$65,$6d,$6f,$72,$79,$20,$62,$6c,$6f,$63,$6b,$00
Memory_types_Text01:
	dc.b	$50,$61,$72,$74,$79,$20,$64,$61,$74,$61,$00
Memory_types_Text02:
	dc.b	$49,$63,$6f,$6e,$20,$64,$61,$74,$61,$00
Memory_types_Text03:
	dc.b	$43,$68,$61,$72,$61,$63,$74,$65,$72,$20,$64,$61,$74,$61,$00
Memory_types_Text04:
	dc.b	$4d,$61,$70,$20,$64,$61,$74,$61,$00
Memory_types_Text05:
	dc.b	$4c,$61,$62,$20,$64,$61,$74,$61,$00
Memory_types_Text06:
	dc.b	$4c,$61,$62,$20,$62,$6c,$6f,$63,$6b,$00
Memory_types_Text07:
	dc.b	$42,$61,$63,$6b,$67,$72,$6f,$75,$6e,$64,$00
Memory_types_Text08:
	dc.b	$43,$6f,$6c,$6f,$75,$72,$20,$70,$61,$6c,$65,$74,$74,$65,$00
Memory_types_Text09:
	dc.b	$38,$30,$78,$38,$30,$20,$50,$69,$63,$00
Memory_types_Text10:
	dc.b	$4d,$61,$70,$20,$74,$65,$78,$74,$73,$00
Memory_types_Text11:
	dc.b	$43,$68,$65,$73,$74,$20,$64,$61,$74,$61,$00
Memory_types_Text12:
	dc.b	$4d,$6f,$6e,$73,$74,$65,$72,$20,$64,$61,$74,$61,$00
Memory_types_Text13:
	dc.b	$4d,$65,$72,$63,$68,$61,$6e,$74,$20,$64,$61,$74,$61,$00
Memory_types_Text14:
	dc.b	$44,$69,$63,$74,$69,$6f,$6e,$61,$72,$79,$00
Memory_types_Text15:
	dc.b	$43,$6f,$6d,$62,$61,$74,$20,$62,$61,$63,$6b,$67,$72,$6f,$75,$6e
	dc.b	$64,$00
Memory_types_Text16:
	dc.b	$4d,$6f,$6e,$73,$74,$65,$72,$20,$67,$72,$61,$70,$68,$69,$63,$73
	dc.b	$00
Memory_types_Text17:
	dc.b	$41,$75,$74,$6f,$6d,$61,$70,$00
Memory_types_Text18:
	dc.b	$54,$65,$78,$74,$20,$66,$69,$6c,$65,$00
D_1e0d5:
	dc.b	$54,$61,$63,$74,$69,$63,$61,$6c,$20,$69,$63,$6f,$6e,$73,$00
D_1e0e4:
	dc.b	$4d,$61,$67,$69,$63,$20,$61,$6e,$69,$6d,$61,$74,$69,$6f,$6e,$73
	dc.b	$00
D_1e0f5:
	dc.b	$50,$75,$7a,$7a,$6c,$65,$20,$67,$72,$61,$70,$68,$69,$63,$73,$00
D_1e105:
	dc.b	$50,$75,$7a,$7a,$6c,$65,$20,$74,$65,$78,$74,$00,$00

	section	bss

New_map:
	ds.b	2
B_55f72:
	ds.b	1
B_55f73:
	ds.b	1
B_55f74:
	ds.b	1
B_55f75:
	ds.b	1
