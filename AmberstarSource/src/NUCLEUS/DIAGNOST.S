; NUCLEUS/DIAGNOST.ASM (original module, merged with the disassembly of the shipped program)

DI_Error:
	movem.l	d0-d2/a0-a2/a6,-(a7)
	bsr.w	T_1c0ea
	movea.l	Screen_base,a6
	bsr.w	T_1c1ac
	lea.l	D_54b09,a0
	bsr.w	DI_Print
	movea.l	a1,a0
	bsr.w	DI_Print
	lea.l	D_54b31,a0
	bsr.w	DI_Print
	move.w	#$7,-(a7)
	trap	#$1
	addq.l	#$2,a7
	cmpi.b	#$78,d0
	beq.b	T_1c0e0
	movea.l	$4f2.w,a0
	movea.l	$4(a0),a0
	jmp	(a0)
T_1c0e0:
	bsr.w	T_1c160
	movem.l	(a7)+,d0-d2/a0-a2/a6
	rts
T_1c0ea:
	movem.l	d0/a0/a6,-(a7)
	tst.b	B_6046c
	bne.b	T_1c15a
	st.b	B_6046c
	jsr	Mouse_off
	move.l	$ffff8240.w,B_60472
	move.l	$ffff8244.w,B_60476
	move.l	Screen_base,Prev_screen
	jsr	HBL_off
	jsr	My_vsync
	move.b	#$1,$ffff8260.w
	moveq	#0,d0
	move.w	Old_screen,d0
	lsl.l	#$8,d0
	jsr	Set_screen
	movea.l	Screen_base,a6
	jsr	Clear_screen
	move.l	Diag_pal,$ffff8240.w
	move.l	D_54b04,$ffff8244.w
T_1c15a:
	movem.l	(a7)+,d0/a0/a6
	rts
T_1c160:
	move.l	a0,-(a7)
	sf.b	B_6046c
	jsr	My_vsync
	move.b	#$0,$ffff8260.w
	move.l	B_60472,$ffff8240.w
	move.l	B_60476,$ffff8244.w
	move.l	Prev_screen,d0
	jsr	Set_screen
	jsr	HBL_on
	jsr	Mouse_on
	movea.l	(a7)+,a0
	rts
T_1c1a0:
	dc.w	$a000
	move.l	-$16(a0),DI_Font_ptr
	rts
T_1c1ac:
	clr.w	B_6047e
	clr.w	B_60480
	rts
DI_Carriage_return:
	move.l	d0,-(a7)
	clr.w	B_6047e
	move.w	B_60480,d0
	addi.w	#$500,d0
	cmpi.w	#$7d00,d0
	bmi.b	T_1c1e6
	jsr	Wait_4_key
	movea.l	Screen_base,a6
	jsr	Clear_screen
	moveq	#0,d0
T_1c1e6:
	move.w	d0,B_60480
	move.l	(a7)+,d0
	rts
DI_Backspace:
	move.l	d0,-(a7)
	move.w	B_6047e,d0
	btst	#$0,d0
	bne.b	T_1c202
	subq.w	#$3,d0
	bra.b	T_1c204
T_1c202:
	subq.w	#$1,d0
T_1c204:
	tst.w	d0
	bmi.b	T_1c20e
	move.w	d0,B_6047e
T_1c20e:
	move.l	(a7)+,d0
	rts
DI_Input:
	movem.l	d2-d4/d7/a0-a1,-(a7)
	bsr.w	DI_Print
	lea.l	D_54b62,a0
	lea.l	B_6046d,a1
	moveq	#0,d7
	move.b	#$20,$1(a0)
	bsr.w	DI_Print
T_1c232:
	jsr	Wait_4_key
	cmpi.b	#$d,d0
	beq.b	T_1c286
	swap	d0
	cmpi.b	#$e,d0
	beq.b	T_1c26e
	swap	d0
	cmpi.b	#$30,d0
	bmi.b	T_1c232
	cmpi.b	#$39,d0
	bhi.b	T_1c232
	move.b	d0,$1(a0)
	bsr.w	DI_Print
	subi.b	#$30,d0
	addq.l	#$1,d7
	move.b	d0,-$1(a1,d7.w)
	cmpi.b	#$4,d7
	bmi.b	T_1c232
	bra.b	T_1c286
T_1c26e:
	tst.w	d7
	beq.b	T_1c232
	lea.l	D_54b58,a0
	bsr.w	DI_Print
	lea.l	D_54b62,a0
	subq.l	#$1,d7
	bra.b	T_1c232
T_1c286:
	lea.l	D_54b5e,a0
	bsr.w	DI_Print
	moveq	#0,d0
	moveq	#1,d2
	moveq	#10,d3
	subq.l	#$1,d7
	bpl.b	T_1c29e
	moveq	#-1,d0
	bra.b	T_1c2ae
T_1c29e:
	moveq	#0,d4
	move.b	(a1,d7.w),d4
	mulu.w	d2,d4
	add.l	d4,d0
	mulu.w	d3,d2
	dbra	d7,T_1c29e
T_1c2ae:
	movem.l	(a7)+,d2-d4/d7/a0-a1
	rts
; ---- DI_Hexw_print (original source: NUCLEUS/DIAGNOST.ASM)
DI_Hexl_print:
DI_Hexb_print:
DI_Hexw_print:
	movem.l	d7/a0,-(sp)
	moveq	#2,d7	; CHANGE: was "moveq.l #4,d7"
	jsr	Hex_convert
	bsr.w	DI_Print
	movem.l	(sp)+,d7/a0
	rts	
	movem.l	d7/a0,-(a7)
	moveq	#4,d7
	jsr	Hex_convert
	bsr.w	DI_Print
	movem.l	(a7)+,d7/a0
	rts
T_1c2e0:
	movem.l	d7/a0,-(a7)
	moveq	#8,d7
	jsr	Hex_convert
	bsr.w	DI_Print
	movem.l	(a7)+,d7/a0
	rts
; ---- DI_Decb_print (original source: NUCLEUS/DIAGNOST.ASM)
DI_Decb_print:
	movem.l	d7/a0,-(sp)
	ext.w	d0
	ext.l	d0
	moveq.l	#3,d7
	jsr	Dec_convert
	bsr.w	DI_Print
	movem.l	(sp)+,d7/a0
	rts	
; ---- DI_Decw_print (original source: NUCLEUS/DIAGNOST.ASM)
DI_Decw_print:
	movem.l	d7/a0,-(sp)
	ext.l	d0
	moveq.l	#5,d7
	jsr	Dec_convert
	bsr.w	DI_Print
	movem.l	(sp)+,d7/a0
	rts	
; ---- DI_Decl_print (original source: NUCLEUS/DIAGNOST.ASM)
DI_Decl_print:
	movem.l	d7/a0,-(sp)
	moveq.l	#10,d7
	jsr	Dec_convert
	bsr.w	DI_Print
	movem.l	(sp)+,d7/a0
	rts	
; ---- DI_Print (original source: NUCLEUS/DIAGNOST.ASM)
DI_Print:
	movem.l	d0/a0/a1,-(sp)
	movea.l	DI_Font_ptr,a1
.Again:
	moveq.l	#0,d0
	move.b	(a0)+,d0
	beq.s	.Exit
	cmpi.b	#13,d0
	bne.s	.Skip1
	bsr.w	DI_Carriage_return
	bra.s	.Again
.Skip1:
	cmpi.b	#1,d0
	bne.s	.Skip2
	move.w	#-1,Inverse
	bra.s	.Again
.Skip2:
	cmpi.b	#2,d0
	bne.s	.Skip3
	move.w	#0,Inverse
	bra.s	.Again
.Skip3:
	cmpi.b	#3,d0
	bne.s	.Skip4
	move.b	(a0)+,d0
	andi.b	#3,d0
	move.b	d0,Ink
	bra.s	.Again
.Skip4:
	cmpi.b	#$e,d0
	bne.s	.Skip5
	bsr.w	DI_Backspace
	bra.s	.Again
.Skip5:
	bsr.w	DI_Pchar
	bra.s	.Again
.Exit:
	movem.l	(sp)+,d0/a0/a1
	rts	
DI_Pchar:
	movem.l	d0-d2/d7/a1/a6,-(a7)
	adda.w	B_6047e,a6
	adda.w	B_60480,a6
	adda.w	d0,a1
	move.b	Ink,d0
	move.w	Inverse,d2
	btst	#$0,d0
	sne.b	d1
	lsl.w	#$8,d1
	btst	#$1,d0
	sne.b	d1
	moveq	#7,d7
T_1c3d4:
	move.b	(a1),d0
	lsl.w	#$8,d0
	move.b	(a1),d0
	eor.w	d2,d0
	and.w	d1,d0
	movep.w	d0,$0(a6)
	lea.l	$100(a1),a1
	lea.l	$a0(a6),a6
	dbra	d7,T_1c3d4
	move.w	B_6047e,d0
	btst	#$0,d0
	bne.b	T_1c3fe
	addq.w	#$1,d0
	bra.b	T_1c40c
T_1c3fe:
	addq.w	#$3,d0
	cmpi.w	#$a0,d0
	bmi.b	T_1c40c
	bsr.w	DI_Carriage_return
	bra.b	T_1c412
T_1c40c:
	move.w	d0,B_6047e
T_1c412:
	movem.l	(a7)+,d0-d2/d7/a1/a6
	rts
