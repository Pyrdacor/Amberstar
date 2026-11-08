; NUCLEUS/TEXTPUT.ASM (original module, merged with the disassembly of the shipped program)

IG_Backspace:
	move.l	d0,-(a7)
	move.w	B_76734,d0
	subq.w	#$6,d0
	cmp.w	PArea,d0
	bmi.b	.l_1d8b2
	move.w	d0,B_76734
.l_1d8b2:
	move.l	(a7)+,d0
	rts
T_1d8b6:
	move.w	PArea,B_76734
	move.w	D_5571c,Print_Y
	rts
IG_Carriage_return:
	movem.l	d0/a0,-(a7)
	lea.l	PArea,a0
	move.w	(a0),B_76734
	move.w	Print_Y,d0
	addq.w	#$7,d0
	cmp.w	$6(a0),d0
	bmi.b	.l_1d8ee
	move.w	$4(a0),d0
.l_1d8ee:
	move.w	d0,Print_Y
	movem.l	(a7)+,d0/a0
	rts
IG_Set_ink:
	move.l	d0,-(a7)
	cmpi.w	#$10,d0
	bmi.b	.l_1d910
	lea.l	D_55b26,a1
	jsr	DI_Error
	bra.b	.l_1d918
.l_1d910:
	lsl.w	#$3,d0
	move.w	d0,IG_Ink
.l_1d918:
	move.l	(a7)+,d0
	rts
IG_Set_paper:
	move.l	d0,-(a7)
	tst.w	d0
	bpl.b	.l_1d934
	move.w	d0,IG_Paper
	move.l	#IG_Pchar_TRANS,Pchar_ptr
	bra.b	.l_1d95a
.l_1d934:
	cmpi.w	#$10,d0
	bmi.b	.l_1d948
	lea.l	D_55b4a,a1
	jsr	DI_Error
	bra.b	.l_1d95a
.l_1d948:
	lsl.w	#$3,d0
	move.w	d0,IG_Paper
	move.l	#IG_Pchar_OPAQUE,Pchar_ptr
.l_1d95a:
	move.l	(a7)+,d0
	rts
IG_Set_cursor:
	move.w	d0,B_76734
	move.w	d1,Print_Y
	rts
; ---- IG_Print (original source: NUCLEUS/TEXTPUT.ASM)
IG_Print:
	movem.l	d0/a0/a1,-(sp)
.Again:
	moveq.l	#0,d0
	move.b	(a0)+,d0
	beq.s	.Exit
	cmpi.b	#13,d0
	bne.s	.Skip1
	jsr	IG_Carriage_return
	bra.s	.Again
.Skip1:
	cmpi.b	#1,d0
	bne.s	.Skip2
	move.b	(a0)+,d0
	ext.w	d0
	jsr	IG_Set_ink
	bra.s	.Again
.Skip2:
	cmpi.b	#2,d0
	bne.s	.Skip3
	move.b	(a0)+,d0
	ext.w	d0
	jsr	IG_Set_paper
	bra.s	.Again
.Skip3:
	cmpi.b	#14,d0
	bne.s	.Skip4
	jsr	IG_Backspace
	bra.s	.Again
.Skip4:
	cmpi.b	#$7e,d0	; CHANGE: was ".Skip4: cmpi.b #"~",d0"
	bne.s	.Skip5
	not.b	Rune_flag
	bra.s	.Again
.Skip5:
	movea.l	Pchar_ptr,a1
	jsr	(a1)
	bra.s	.Again
.Exit:
	movem.l	(sp)+,d0/a0/a1
	rts	
IG_Pchar_TRANS:
	movem.l	d0-d7/a0-a2,-(a7)
	lea.l	D_55700,a0
	tst.b	Rune_flag
	beq.b	.l_1d9ec
	lea.l	D_557e0,a0
.l_1d9ec:
	andi.w	#$ff,d0
	move.b	(a0,d0.w),d0
	bmi.w	.l_1db2e
	lea.l	Little_font,a0
	ext.w	d0
	adda.w	d0,a0
	lsl.w	#$2,d0
	adda.w	d0,a0
	move.w	B_76734,d0
	move.w	Print_Y,d1
	jsr	Coord_convert
	lea.l	(a6,d2.w),a1
	move.w	d3,d6
	lea.l	Colour_table,a2
	adda.w	IG_Ink,a2
	moveq	#0,d0
	moveq	#0,d1
	moveq	#0,d2
	moveq	#0,d3
	moveq	#0,d5
	move.b	(a0)+,d5
	lsl.w	#$8,d5
	move.w	d5,d0
	move.w	d5,d1
	move.w	d5,d2
	move.w	d5,d3
	and.w	(a2)+,d0
	and.w	(a2)+,d1
	and.w	(a2)+,d2
	and.w	(a2)+,d3
	subq.l	#$8,a2
	ror.l	d6,d0
	ror.l	d6,d1
	ror.l	d6,d2
	ror.l	d6,d3
	ror.l	d6,d5
	move.l	d5,d4
	not.l	d4
	and.w	d4,(a1)
	or.w	d0,(a1)+
	and.w	d4,(a1)
	or.w	d1,(a1)+
	and.w	d4,(a1)
	or.w	d2,(a1)+
	and.w	d4,(a1)
	or.w	d3,(a1)+
	swap	d0
	swap	d1
	swap	d2
	swap	d3
	swap	d4
	and.w	d4,(a1)
	or.w	d0,(a1)+
	and.w	d4,(a1)
	or.w	d1,(a1)+
	and.w	d4,(a1)
	or.w	d2,(a1)+
	and.w	d4,(a1)
	or.w	d3,(a1)+
	lea.l	$90(a1),a1
	moveq	#3,d7
.l_1da88:
	moveq	#0,d0
	moveq	#0,d1
	moveq	#0,d2
	moveq	#0,d3
	moveq	#0,d5
	move.b	(a0)+,d5
	lsl.w	#$8,d5
	move.w	d5,d0
	move.w	d5,d1
	move.w	d5,d2
	move.w	d5,d3
	and.w	(a2)+,d0
	and.w	(a2)+,d1
	and.w	(a2)+,d2
	and.w	(a2)+,d3
	subq.l	#$8,a2
	ror.l	d6,d0
	ror.l	d6,d1
	ror.l	d6,d2
	ror.l	d6,d3
	moveq	#0,d4
	move.b	-$2(a0),d4
	lsl.w	#$7,d4
	or.w	d5,d4
	not.l	d4
	ror.l	d6,d4
	and.w	d4,(a1)
	or.w	d0,(a1)+
	and.w	d4,(a1)
	or.w	d1,(a1)+
	and.w	d4,(a1)
	or.w	d2,(a1)+
	and.w	d4,(a1)
	or.w	d3,(a1)+
	swap	d0
	swap	d1
	swap	d2
	swap	d3
	swap	d4
	and.w	d4,(a1)
	or.w	d0,(a1)+
	and.w	d4,(a1)
	or.w	d1,(a1)+
	and.w	d4,(a1)
	or.w	d2,(a1)+
	and.w	d4,(a1)
	or.w	d3,(a1)+
	swap	d4
	lea.l	$90(a1),a1
	dbra	d7,.l_1da88
	moveq	#0,d4
	move.b	-$1(a0),d4
	lsl.w	#$7,d4
	not.l	d4
	ror.l	d6,d4
	and.w	d4,(a1)+
	and.w	d4,(a1)+
	and.w	d4,(a1)+
	and.w	d4,(a1)+
	swap	d4
	and.w	d4,(a1)+
	and.w	d4,(a1)+
	and.w	d4,(a1)+
	and.w	d4,(a1)+
	move.w	B_76734,d0
	addq.w	#$6,d0
	cmp.w	D_5571a,d0
	bmi.b	.l_1db28
	jsr	IG_Carriage_return
	bra.b	.l_1db2e
.l_1db28:
	move.w	d0,B_76734
.l_1db2e:
	movem.l	(a7)+,d0-d7/a0-a2
	rts
IG_Pchar_OPAQUE:
	movem.l	d0-d7/a0-a2,-(a7)
	andi.w	#$ff,d0
	move.w	d0,d6
	move.w	B_76734,d0
	move.w	Print_Y,d1
	jsr	Coord_convert
	lea.l	(a6,d2.w),a0
	move.l	#$ffff03ff,d0
	ror.l	d3,d0
	move.l	d0,d1
	swap	d1
	moveq	#5,d7
.l_1db62:
	and.w	d0,(a0)+
	and.w	d0,(a0)+
	and.w	d0,(a0)+
	and.w	d0,(a0)+
	and.w	d1,(a0)+
	and.w	d1,(a0)+
	and.w	d1,(a0)+
	and.w	d1,(a0)+
	lea.l	$90(a0),a0
	dbra	d7,.l_1db62
	lea.l	Colour_table,a0
	move.w	IG_Paper,d0
	adda.w	d0,a0
	move.l	(a0)+,d0
	move.l	(a0)+,d1
	lea.l	Char_buffer,a0
	moveq	#5,d7
.l_1db94:
	move.l	d0,(a0)+
	move.l	d1,(a0)+
	dbra	d7,.l_1db94
	lea.l	D_55700,a0
	tst.b	Rune_flag
	beq.b	.l_1dbb0
	lea.l	D_557e0,a0
.l_1dbb0:
	move.b	(a0,d6.w),d0
	bmi.w	.l_1dc8e
	lea.l	Little_font,a0
	ext.w	d0
	adda.w	d0,a0
	lsl.w	#$2,d0
	adda.w	d0,a0
	lea.l	Colour_table,a1
	adda.w	IG_Ink,a1
	lea.l	Char_buffer,a2
	moveq	#4,d7
.l_1dbda:
	move.b	(a0)+,d0
	lsl.w	#$8,d0
	move.w	d0,d1
	swap	d0
	move.w	d1,d0
	move.l	d0,d1
	not.l	d0
	move.l	d0,d2
	ror.l	#$1,d2
	and.l	d2,$8(a2)
	and.l	d2,$c(a2)
	move.l	d0,d2
	move.l	d1,d3
	or.l	(a1),d0
	and.l	(a1),d1
	or.l	$4(a1),d2
	and.l	$4(a1),d3
	move.l	(a2),d4
	and.l	d0,d4
	or.l	d1,d4
	move.l	d4,(a2)+
	move.l	(a2),d4
	and.l	d2,d4
	or.l	d3,d4
	move.l	d4,(a2)+
	dbra	d7,.l_1dbda
	lea.l	Char_buffer,a0
	move.w	B_76734,d0
	move.w	Print_Y,d1
	jsr	Coord_convert
	lea.l	(a6,d2.w),a1
	move.w	d3,d6
	moveq	#5,d7
.l_1dc38:
	moveq	#0,d0
	moveq	#0,d1
	moveq	#0,d2
	moveq	#0,d3
	move.w	(a0)+,d0
	move.w	(a0)+,d1
	move.w	(a0)+,d2
	move.w	(a0)+,d3
	ror.l	d6,d0
	ror.l	d6,d1
	ror.l	d6,d2
	ror.l	d6,d3
	or.w	d0,(a1)+
	or.w	d1,(a1)+
	or.w	d2,(a1)+
	or.w	d3,(a1)+
	swap	d0
	swap	d1
	swap	d2
	swap	d3
	or.w	d0,(a1)+
	or.w	d1,(a1)+
	or.w	d2,(a1)+
	or.w	d3,(a1)+
	lea.l	$90(a1),a1
	dbra	d7,.l_1dc38
	move.w	B_76734,d0
	addq.w	#$6,d0
	cmp.w	D_5571a,d0
	bmi.b	.l_1dc88
	jsr	IG_Carriage_return
	bra.b	.l_1dc8e
.l_1dc88:
	dc.b	$33,$c0
	dc.l	B_76734
.l_1dc8e:
	movem.l	(a7)+,d0-d7/a0-a2
	rts
