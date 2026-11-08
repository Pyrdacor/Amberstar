; MAIN/STATUS.ASM (original module, merged with the disassembly of the shipped program)

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
	tst.b	D_1dc92
	beq.w	T_01af8
	st.b	Time_lock
	movem.l	d0-d7/a0-a6,-(a7)
	jsr	T_1c0e8
	jsr	T_1c1aa
	movea.l	Screen_base,a6
	lea.l	D_2ec30,a0
	jsr	DI_Print
	jsr	DI_Carriage_return
	lea.l	Chard_ptrs,a0
	moveq	#5,d7
T_01a16:
	tst.l	(a0)
	beq.w	T_01aca
	movea.l	(a0),a1
	lea.l	$22(a1),a2
	lea.l	$132(a1),a3
	moveq	#0,d1
	moveq	#20,d6
T_01a2a:
	moveq	#0,d0
	move.b	(a2)+,d0
	beq.b	T_01a36
	mulu.w	$22(a3),d0
	add.l	d0,d1
T_01a36:
	lea.l	$28(a3),a3
	dbra	d6,T_01a2a
	moveq	#0,d0
	move.w	$90(a1),d0
	mulu.w	#$a,d0
	add.l	d0,d1
	moveq	#0,d0
	move.w	$92(a1),d0
	mulu.w	#$fa,d0
	add.l	d0,d1
	move.l	$ec(a1),d0
	cmp.l	d0,d1
	beq.b	T_01aca
	move.l	a0,-(a7)
	lea.l	D_2ec42,a0
	jsr	DI_Print
	lea.l	$f0(a1),a0
	jsr	DI_Print
	jsr	DI_Carriage_return
	lea.l	D_2ec4d,a0
	jsr	DI_Print
	jsr	DI_Carriage_return
	lea.l	D_2ec67,a0
	jsr	DI_Print
	move.l	d0,d0
	jsr	DI_Decl_print
	jsr	DI_Carriage_return
	lea.l	D_2ec7c,a0
	jsr	DI_Print
	move.l	d1,d0
	jsr	DI_Decl_print
	jsr	DI_Carriage_return
	jsr	DI_Carriage_return
	movea.l	(a7)+,a0
T_01aca:
	addq.l	#$4,a0
	dbra	d7,T_01a16
	jsr	DI_Carriage_return
	lea.l	D_2ec91,a0
	jsr	DI_Print
	jsr	Wait_4_key
	jsr	T_1c15e
	movem.l	(a7)+,d0-d7/a0-a6
	sf.b	Time_lock
T_01af8:
	rts
T_01afa:
	tst.b	D_1dc92
	beq.b	T_01b24
	movea.l	Current_active_char_data,a1
	clr.w	$3a(a1)
	move.w	$88(a1),d0
	add.w	$98(a1),d0
	move.w	d0,$86(a1)
	move.w	$8c(a1),d0
	add.w	$9a(a1),d0
	move.w	d0,$8a(a1)
T_01b24:
	rts
T_01b26:
	tst.b	D_1dc92
	beq.b	T_01b3a
	lea.l	D_2d860,a0
	jsr	Push_Module
T_01b3a:
	rts
T_01b3c:
	tst.b	D_1dc92
	beq.b	T_01b82
	movea.l	Current_active_char_data,a0
	move.b	#$8e,$1a(a0)
	move.l	#$ffffffff,$d0(a0)
	move.l	#$ffffffff,$d4(a0)
	move.l	#$ffffffff,$d8(a0)
	move.l	#$ffffffff,$e8(a0)
	move.w	#$1f4,$8a(a0)
	move.w	#$1f4,$8c(a0)
	move.b	#$63,$f(a0)
T_01b82:
	rts
T_01b84:
	tst.b	D_1dc92
	beq.b	T_01ba0
	move.w	Travel_mode,d0
	addq.w	#$1,d0
	cmpi.w	#$7,d0
	bmi.b	T_01b9c
	moveq	#0,d0
T_01b9c:
	bsr.w	Set_new_travel_mode
T_01ba0:
	rts
T_01ba2:
	tst.b	D_1dc92
	beq.b	T_01bb0
	jmp	T_1a212
T_01bb0:
	rts
T_01bb2:
	tst.b	D_1dc92
	beq.w	T_01c46
	st.b	Time_lock
	movem.l	d0-d7/a0-a6,-(a7)
	jsr	T_1c0e8
	jsr	T_1c1aa
	movea.l	Screen_base,a6
	lea.l	D_2ecac,a0
	jsr	DI_Print
	jsr	DI_Carriage_return
	movea.l	Current_active_char_data,a1
	lea.l	D_2ecc5,a0
	jsr	DI_Print
	move.w	$90(a1),d0
	jsr	DI_Decw_print
	jsr	DI_Carriage_return
T_01c0c:
	lea.l	D_2ecdb,a0
	jsr	DI_Input
	tst.l	d0
	bmi.b	T_01c36
	beq.b	T_01c0c
	moveq	#0,d1
	move.w	$90(a1),d1
	add.w	d0,d1
	bvs.b	T_01c0c
	move.w	d0,d1
	mulu.w	#$a,d1
	add.l	d1,$ec(a1)
	add.w	d0,$90(a1)
T_01c36:
	jsr	T_1c15e
	movem.l	(a7)+,d0-d7/a0-a6
	sf.b	Time_lock
T_01c46:
	rts
T_01c48:
	tst.b	D_1dc92
	beq.w	T_01d8c
	st.b	Time_lock
	movem.l	d0-d7/a0-a6,-(a7)
	jsr	T_1c0e8
	jsr	T_1c1aa
	movea.l	Screen_base,a6
	lea.l	D_2ecf1,a0
	jsr	DI_Print
	jsr	DI_Carriage_return
	movea.l	Event_data_ptr,a1
	lea.l	D_2ed06,a0
	jsr	DI_Print
	move.b	(a1),d0
	jsr	DI_Decb_print
	jsr	DI_Carriage_return
	lea.l	D_2ed10,a0
	jsr	DI_Print
	move.b	$1(a1),d0
	jsr	DI_Decb_print
	jsr	DI_Carriage_return
	lea.l	D_2ed1a,a0
	jsr	DI_Print
	move.b	$2(a1),d0
	jsr	DI_Decb_print
	jsr	DI_Carriage_return
	lea.l	D_2ed24,a0
	jsr	DI_Print
	move.b	$3(a1),d0
	jsr	DI_Decb_print
	jsr	DI_Carriage_return
	lea.l	D_2ed2e,a0
	jsr	DI_Print
	move.b	$4(a1),d0
	jsr	DI_Decb_print
	jsr	DI_Carriage_return
	lea.l	D_2ed38,a0
	jsr	DI_Print
	move.w	$6(a1),d0
	jsr	DI_Decw_print
	jsr	DI_Carriage_return
	lea.l	D_2ed42,a0
	jsr	DI_Print
	move.w	$8(a1),d0
	jsr	DI_Decw_print
	jsr	DI_Carriage_return
	lea.l	D_2ed4c,a0
	jsr	DI_Print
	move.b	$5(a1),d0
	jsr	DI_Decb_print
	jsr	DI_Carriage_return
	jsr	DI_Carriage_return
	lea.l	D_2ed56,a0
	jsr	DI_Print
	jsr	Wait_4_key
	jsr	T_1c15e
	movem.l	(a7)+,d0-d7/a0-a6
	sf.b	Time_lock
T_01d8c:
	rts
T_01d8e:
	tst.b	D_1dc92
	beq.b	T_01de0
	st.b	Time_lock
	movem.l	d0-d7/a0-a6,-(a7)
	jsr	T_1c0e8
	jsr	T_1c1aa
	movea.l	Screen_base,a6
	lea.l	D_2ed71,a0
	jsr	DI_Print
	move.w	Active_member,d0
	jsr	DI_Decw_print
	jsr	Wait_4_key
	jsr	T_1c15e
	movem.l	(a7)+,d0-d7/a0-a6
	sf.b	Time_lock
T_01de0:
	rts
T_01de2:
	st.b	Time_lock
	movem.l	d0-d7/a0-a6,-(a7)
	jsr	T_1c0e8
	jsr	T_1c1aa
	movea.l	Screen_base,a6
	lea.l	Memory_list,a1
	movea.l	Memlist_end,a2
T_01e0a:
	btst	#$7,$8(a1)
	bne.b	T_01e5a
	move.l	$0(a1),d0
	jsr	T_1c2de
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
	beq.b	T_01e54
	move.w	$a(a1),d0
	addq.w	#$1,d0
	move.w	d0,d0
	jsr	DI_Decw_print
T_01e54:
	jsr	DI_Carriage_return
T_01e5a:
	lea.l	$c(a1),a1
	cmpa.l	a2,a1
	bmi.b	T_01e0a
	jsr	Wait_4_key
	lea.l	Memory_list,a1
	movea.l	Memlist_end,a2
	move.l	B_5da0c,d0
T_01e7a:
	btst	#$7,$8(a1)
	bne.b	T_01e86
	sub.l	$4(a1),d0
T_01e86:
	lea.l	$c(a1),a1
	cmpa.l	a2,a1
	bmi.b	T_01e7a
	sub.l	Size_of_free_memory,d0
	beq.b	T_01eb8
	lea.l	D_2ed82,a0
	jsr	DI_Print
	lea.l	D_2ed96,a0
	jsr	DI_Print
	move.l	d0,d0
	jsr	DI_Decl_print
	bra.b	T_01ec4
T_01eb8:
	lea.l	D_2eda4,a0
	jsr	DI_Print
T_01ec4:
	jsr	Wait_4_key
	jsr	T_1c15e
	movem.l	(a7)+,d0-d7/a0-a6
	sf.b	Time_lock
	rts
