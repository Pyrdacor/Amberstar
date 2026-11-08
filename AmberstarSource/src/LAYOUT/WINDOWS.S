; LAYOUT/WINDOWS.ASM (original module, merged with the disassembly of the shipped program)

Open_window:
	movem.l	d1-d7/a0-a2/a6,-(a7)
	jsr	Mouse_off
	move.w	d2,d4
	mulu.w	d3,d4
	lsl.l	#$7,d4
	addi.l	#$14,d4
	move.w	d0,-(a7)
	move.l	d4,d0
	jsr	Allocate_memory
	lea.l	(a1),a2
	move.w	(a7)+,d0
	move.w	d0,$0(a2)
	move.w	d1,$2(a2)
	move.w	d2,$4(a2)
	move.w	d3,$6(a2)
	move.l	a0,$10(a2)
	moveq	#16,d4
	add.w	d0,d4
	move.w	d4,$8(a2)
	moveq	#-2,d5
	add.w	d2,d5
	lsl.w	#$4,d5
	add.w	d5,d4
	subq.w	#$1,d4
	move.w	d4,$a(a2)
	moveq	#16,d4
	add.w	d1,d4
	move.w	d4,$c(a2)
	moveq	#-2,d5
	add.w	d3,d5
	lsl.w	#$4,d5
	add.w	d5,d4
	subq.w	#$1,d4
	move.w	d4,$e(a2)
	tst.w	d6
	bne.b	T_1a634
	moveq	#3,d6
	lea.l	D_33432,a1
	bra.b	T_1a63c
T_1a634:
	moveq	#2,d6
	lea.l	D_33c32,a1
T_1a63c:
	move.w	d6,-(a7)
	move.w	d2,d6
	move.w	d3,d7
	lsl.w	#$4,d7
	subq.w	#$8,d7
	lea.l	$14(a2),a0
	movea.l	Screen_base,a6
	jsr	Get2_block
	move.w	(a7)+,d6
	tst.l	(a1)
	jsr	Copy_screen
	tst.l	(a1)
	movea.l	a1,a0
	movea.l	Off_screen,a6
	subq.w	#$4,d2
	subq.w	#$4,d3
	move.w	d0,d4
	move.w	d1,d5
	jsr	Put_masked_block
	addi.w	#$10,d1
	lea.l	$80(a0),a0
	jsr	Put_masked_block
	addi.w	#$10,d1
	lea.l	$80(a0),a0
	bsr.w	Draw_vertical_border
	jsr	Put_masked_block
	addi.w	#$10,d1
	lea.l	$80(a0),a0
	jsr	Put_masked_block
	addi.w	#$10,d0
	exg.l	d5,d1
	lea.l	$80(a0),a0
	jsr	Put_masked_block
	exg.l	d5,d1
	lea.l	$80(a0),a0
	jsr	Put_masked_block
	addi.w	#$10,d0
	exg.l	d5,d1
	lea.l	$80(a0),a0
	bsr.w	Draw_horizontal_border
	move.w	d4,d0
	addi.w	#$20,d0
	exg.l	d5,d1
	bsr.w	Draw_horizontal_border
	exg.l	d5,d1
	jsr	Put_masked_block
	exg.l	d5,d1
	lea.l	$80(a0),a0
	jsr	Put_masked_block
	addi.w	#$10,d0
	exg.l	d5,d1
	lea.l	$80(a0),a0
	jsr	Put_masked_block
	addi.w	#$10,d1
	lea.l	$80(a0),a0
	jsr	Put_masked_block
	addi.w	#$10,d1
	lea.l	$80(a0),a0
	bsr.w	Draw_vertical_border
	jsr	Put_masked_block
	addi.w	#$10,d1
	lea.l	$80(a0),a0
	jsr	Put_masked_block
	move.w	$0(a2),d0
	move.w	$2(a2),d1
	addi.w	#$10,d0
	addi.w	#$10,d1
	addq.w	#$2,d2
	addq.w	#$2,d3
	lsl.w	#$4,d2
	lsl.w	#$4,d3
	add.w	d0,d2
	add.w	d1,d3
	subq.w	#$1,d2
	subq.w	#$1,d3
	jsr	Draw_box
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	$8(a2),a0
	jsr	Push_MA
	move.l	$10(a2),d0
	beq.b	T_1a78a
	movea.l	d0,a0
	moveq	#16,d0
	moveq	#16,d1
	add.w	$0(a2),d0
	add.w	$2(a2),d1
	jsr	Translate_object_branch
	jsr	Push_Root
T_1a78a:
	lea.l	Window_list,a0
	moveq	#1,d7
T_1a792:
	tst.l	(a0)+
	dbeq	d7,T_1a792
	tst.w	d7
	bpl.b	T_1a7aa
	lea.l	D_34432,a1
	jsr	DI_Error
	bra.b	T_1a7b6
T_1a7aa:
	move.l	a2,-(a0)
	suba.l	#Window_list,a0
	move.l	a0,d0
	lsr.w	#$2,d0
T_1a7b6:
	jsr	Mouse_on
	movem.l	(a7)+,d1-d7/a0-a2/a6
	rts
; ---- Draw_horizontal_border (original source: LAYOUT/WINDOWS.ASM)
Draw_horizontal_border:
	move.l	d2,-(sp)
	bra.s	.Entry
.Loop:
	jsr	Put_masked_block
	addi.w	#16,d0
.Entry:
	dbra	d2,.Loop
	lea.l	128(a0),a0
	move.l	(sp)+,d2
	rts	
; ---- Draw_vertical_border (original source: LAYOUT/WINDOWS.ASM)
Draw_vertical_border:
	move.l	d3,-(sp)
	bra.s	.Entry
.Loop:
	jsr	Put_masked_block
	addi.w	#16,d1
.Entry:
	dbra	d3,.Loop
	lea.l	128(a0),a0
	move.l	(sp)+,d3
	rts	
Close_window:
	movem.l	d0-d1/d6-d7/a0-a1/a6,-(a7)
	jsr	Mouse_off
	lea.l	Window_list,a0
	lsl.w	#$2,d0
	adda.w	d0,a0
	tst.l	(a0)
	bne.b	T_1a81c
	lea.l	D_34467,a1
	jsr	DI_Error
	bra.b	T_1a882
T_1a81c:
	movea.l	(a0),a1
	clr.l	(a0)
	move.w	$0(a1),d0
	move.w	$2(a1),d1
	move.w	$4(a1),d6
	move.w	$6(a1),d7
	lsl.w	#$4,d7
	subq.w	#$8,d7
	lea.l	$14(a1),a0
	movea.l	Off_screen,a6
	jsr	Blot_unmasked_block
	jsr	Switch_screen
	jsr	Copy_screen
	jsr	Pop_MA
	move.l	$10(a1),d0
	beq.b	T_1a87a
	jsr	Pop_Root
	movea.l	d0,a0
	moveq	#16,d0
	moveq	#16,d1
	add.w	$0(a1),d0
	add.w	$2(a1),d1
	neg.w	d0
	neg.w	d1
	jsr	Translate_object_branch
T_1a87a:
	lea.l	(a1),a0
	jsr	Free_memory
T_1a882:
	jsr	Mouse_on
	movem.l	(a7)+,d0-d1/d6-d7/a0-a1/a6
	rts
; Entry of the COSO music player by Jochen Hippel: d0 = 0 init, 1 play module a0.
Coso_player:
	bra.w	T_1a8ba
	bra.w	T_1a8c8
T_1a896:
	bra.w	T_1aaac
	bra.w	T_1a8ae
	bra.w	T_1a8a2
T_1a8a2:
	pea.l	(a0)
	lea.l	T_1b536(pc),a0
	move.b	d0,(a0)
	movea.l	(a7)+,a0
	rts
T_1a8ae:
	pea.l	(a0)
	lea.l	T_1b42c(pc),a0
	move.w	d0,(a0)+
	movea.l	(a7)+,a0
	rts
T_1a8ba:
	movem.l	d0-d7/a0-a5,-(a7)
	move.w	d1,d2
	bsr.b	T_1a8f0
	movem.l	(a7)+,d0-d7/a0-a5
	rts
T_1a8c8:
	movem.l	d0-d7/a0-a5,-(a7)
	lea.l	T_1b63a(pc),a0
	bsr.b	T_1a920
	movea.l	T_1b526(pc),a1
	add.w	d0,d0
	add.w	d0,d0
	adda.w	d0,a1
	lea.l	T_1b52c(pc),a5
	move.w	(a1)+,(a5)
	moveq	#0,d0
	move.w	(a1)+,d0
	bsr.w	T_1ae96
	movem.l	(a7)+,d0-d7/a0-a5
	rts
T_1a8f0:
	bsr.b	T_1a920
	tst.w	d0
	beq.b	T_1a910
	subq.w	#$1,d0
	movea.l	T_1b522(pc),a1
	mulu.w	#$6,d0
	adda.w	d0,a1
	move.w	(a1)+,d0
	move.w	(a1)+,d1
	lea.l	T_1b438(pc),a5
	move.w	(a1),(a5)
	bra.w	T_1ad8a
T_1a910:
	andi.b	#$f0,$fffffa1d.w
	lea.l	T_1b43a(pc),a0
	st.b	(a0)
	bra.w	T_1aaac
T_1a920:
	lea.l	T_1b537(pc),a1
	sf.b	(a1)
	cmpi.l	#$4d4d4d45,$20(a0)
	bne.b	T_1a934
	move.b	#$1,(a1)
T_1a934:
	lea.l	T_1b52e(pc),a5
	move.l	a0,(a5)
	movea.l	$4(a0),a1
	adda.l	a0,a1
	lea.l	T_1b514(pc),a5
	move.l	a1,(a5)
	movea.l	$8(a0),a1
	adda.l	a0,a1
	lea.l	T_1b518(pc),a5
	move.l	a1,(a5)
	movea.l	$c(a0),a1
	adda.l	a0,a1
	lea.l	T_1b510(pc),a5
	move.l	a1,(a5)
	movea.l	$10(a0),a1
	adda.l	a0,a1
	lea.l	T_1b51c(pc),a5
	move.l	a1,(a5)
	movea.l	$14(a0),a1
	adda.l	a0,a1
	lea.l	T_1b522(pc),a5
	move.l	a1,(a5)+
	movea.l	$18(a0),a1
	adda.l	a0,a1
	move.l	a1,(a5)+
	movea.l	$1c(a0),a1
	adda.l	a0,a1
	lea.l	T_1b532(pc),a5
	move.l	a1,(a5)+
	lea.l	T_1b42a(pc),a5
	st.b	(a5)
	lea.l	T_1b52a(pc),a5
	move.w	#$2,(a5)
	rts
T_1a99a:
	rts
T_1a99c:
	lea.l	T_1b538(pc),a0
	move.b	d0,(a0)
	movea.l	T_1b532(pc),a0
	cmpi.l	#$4d415243,$f8(a0)
	bne.b	T_1a99a
	cmpi.l	#$48492020,$f4(a0)
	beq.b	T_1a99a
	move.l	#$48492020,$f4(a0)
	tst.b	d0
	beq.b	T_1aa0c
	lea.l	T_1aa9a(pc),a1
	tst.l	(a1)
	bne.b	T_1aa0c
	move.w	sr,-(a7)
	move.w	#$2700,sr
	move.l	$110.w,(a1)+
	move.b	$fffffa09.w,(a1)+
	move.b	$fffffa0d.w,(a1)+
	move.b	$fffffa15.w,(a1)+
	move.b	$fffffa17.w,(a1)+
	move.b	$fffffa1d.w,(a1)+
	andi.b	#$f0,$fffffa1d.w
	bset	#$4,$fffffa09.w
	bset	#$4,$fffffa0d.w
	bset	#$4,$fffffa15.w
	bclr	#$3,$fffffa17.w
	move.w	(a7)+,sr
T_1aa0c:
	lea.l	$100(a0),a1
	movea.l	$fc(a0),a2
	adda.l	a0,a2
	tst.b	d0
	bne.b	T_1aa32
	moveq	#0,d7
	move.w	#$30,d7
T_1aa20:
	cmpa.l	a1,a2
	beq.b	T_1aa6e
	move.b	(a1),d2
	ext.w	d2
	muls.w	d7,d2
	divs.w	#$3f,d2
	move.b	d2,(a1)+
	bra.b	T_1aa20
T_1aa32:
	cmp.b	#$1,d0
	beq.b	T_1aa70
T_1aa38:
	eori.b	#$80,(a1)+
	cmpa.l	a2,a1
	blt.b	T_1aa38
	movea.w	#$8800,a0
	move.b	#$7,(a0)
	move.b	(a0),d0
	ori.b	#$c0,d0
	move.b	d0,$2(a0)
	move.b	#$e,(a0)
	move.b	(a0),d0
	ori.b	#$20,d0
	move.b	d0,$2(a0)
	lea.l	T_1aaa6(pc),a0
T_1aa64:
	move.l	a0,$110.w
	move.b	#$66,$fffffa25.w
T_1aa6e:
	rts
T_1aa70:
	move.b	(a1),d0
	eori.b	#$80,d0
	lsr.w	#$4,d0
	andi.w	#$f,d0
	move.b	T_1aa8a(pc,d0.w),(a1)+
	cmpa.l	a2,a1
	blt.b	T_1aa70
	lea.l	T_1aaa6(pc),a0
	bra.b	T_1aa64
T_1aa8a:
	dc.b	$00,$07,$09,$0a,$0b,$0c,$0c,$0d,$0d,$0d,$0e,$0e,$0e,$0f,$0f,$0f
T_1aa9a:
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
T_1aaa6:
	dc.b	$11,$de,$88,$32,$4e,$73
T_1aaac:
	lea.l	T_1b3ee(pc),a5
	lea.l	T_1b436(pc),a4
	tst.b	$4(a4)
	beq.b	T_1aafa
	tst.b	$5(a4)
	bne.b	T_1aaf8
	st.b	$5(a4)
	moveq	#0,d0
	move.b	d0,$12(a5)
	move.b	d0,$16(a5)
	move.b	d0,$22(a5)
	move.b	d0,$26(a5)
	move.b	d0,$2a(a5)
	move.b	T_1b536(pc),d4
	bne.b	T_1aaf8
	move.w	sr,-(a7)
	move.w	#$2700,sr
	movem.l	$10(a5),d0-d6
	movem.l	d0-d6,$ffff8830.w
	bsr.w	T_1b3c6
	move.w	(a7)+,sr
T_1aaf8:
	rts
T_1aafa:
	lea.l	T_1b42e(pc),a4
	lea.l	T_1b43c(pc),a0
	bsr.w	T_1af2e
	move.w	d0,-(a7)
	move.b	(a7)+,$6(a5)
	move.b	d0,$2(a5)
	move.b	d1,$22(a5)
	lea.l	T_1b470(pc),a0
	bsr.w	T_1af2e
	move.w	d0,-(a7)
	move.b	(a7)+,$e(a5)
	move.b	d0,$a(a5)
	move.b	d1,$26(a5)
	lea.l	T_1b4a4(pc),a0
	bsr.w	T_1af2e
	move.w	d0,-(a7)
	move.b	(a7)+,$16(a5)
	move.b	d0,$12(a5)
	move.b	d1,$2a(a5)
	move.w	$4(a4),d0
	beq.b	T_1ab84
	move.w	d0,-(a7)
	lea.l	T_1b4d8(pc),a0
	bsr.w	T_1af2e
	movea.l	$4(a0),a1
	adda.w	$16(a0),a1
	cmpi.b	#$e1,(a1)
	bne.b	T_1ab62
	clr.w	$4(a4)
T_1ab62:
	move.w	(a7)+,d7
	lea.l	T_1b41a(pc),a1
	add.w	d7,d7
	add.w	d7,d7
	adda.w	d7,a1
	moveq	#0,d6
	move.b	(a1)+,d6
	move.w	d0,-(a7)
	move.b	d0,(a5,d6.w)
	move.b	(a1)+,d6
	move.b	(a7)+,(a5,d6.w)
	move.b	(a1)+,d6
	move.b	d1,(a5,d6.w)
T_1ab84:
	move.w	sr,-(a7)
	move.w	#$2700,sr
	move.b	#$7,$ffff8830.w
	move.b	$ffff8830.w,d6
	andi.w	#$c0,d6
	bsr.w	T_1b3c6
	move.w	(a7)+,sr
	move.b	(a4)+,d7
	or.b	d6,d7
	move.b	d7,$1e(a5)
	move.b	(a4)+,$1a(a5)
	move.b	T_1b536(pc),d0
	bne.b	T_1ac10
	move.b	T_1b538(pc),d0
	bne.b	T_1abc2
	btst	#$0,$ffff8901.w
	bne.b	T_1abcc
	bra.w	T_1ac06
T_1abc2:
	move.b	$fffffa1d.w,d0
	andi.w	#$f,d0
	beq.b	T_1ac06
T_1abcc:
	movem.l	(a5)+,d0-d7/a0-a1
	clr.w	d4
	clr.w	d5
	bclr	#$a,d7
	bset	#$d,d7
	move.w	sr,-(a7)
	move.w	#$2700,sr
	movem.l	d0-d7/a0-a1,$ffff8840.w
	moveq	#10,d0
	move.b	T_1b538(pc),d1
	cmp.b	#$2,d1
	bne.b	T_1abfe
	clr.w	$2(a5)
	move.l	(a5)+,$ffff8840.w
	addq.w	#$5,d0
T_1abfe:
	move.b	d0,$ffff8840.w
	move.w	(a7)+,sr
	bra.b	T_1ac10
T_1ac06:
	movem.l	(a5),d0-d7/a0-a2
	movem.l	d0-d7/a0-a2,$ffff8840.w
T_1ac10:
	lea.l	T_1b436(pc),a5
	subq.w	#$1,(a5)+
	bne.b	T_1ac38
	move.w	(a5),-(a5)
	moveq	#0,d5
	moveq	#0,d4
	lea.l	T_1b43c(pc),a0
	bsr.w	T_1ac3a
	st.b	d4
	lea.l	T_1b470(pc),a0
	bsr.w	T_1ac3a
	lea.l	T_1b4a4(pc),a0
	bsr.w	T_1ac3a
T_1ac38:
	rts
T_1ac3a:
	subq.b	#$1,$1a(a0)
	bpl.b	T_1ac38
	move.b	$1b(a0),$1a(a0)
T_1ac46:
	movea.l	$c(a0),a1
T_1ac4a:
	move.b	(a1)+,d0
	cmp.b	#$ff,d0
	bne.w	T_1acd4
	movea.l	$0(a0),a2
	adda.w	$14(a0),a2
	tst.b	d4
	bne.b	T_1ac7c
	subq.w	#$1,$1c(a0)
	bpl.b	T_1ac7c
	move.w	T_1b50e(pc),$1c(a0)
	move.w	d5,$14(a0)
	move.w	d5,$48(a0)
	move.w	d5,$7c(a0)
	movea.l	$0(a0),a2
T_1ac7c:
	moveq	#0,d1
	move.b	(a2),d1
	move.b	$1(a2),$21(a0)
	move.b	$2(a2),$20(a0)
	move.b	$3(a2),d0
	move.b	d0,d2
	andi.w	#$f0,d2
	cmp.w	#$f0,d2
	bne.b	T_1aca8
	move.b	d0,d2
	andi.b	#$f,d2
	move.b	d2,$30(a0)
	bra.b	T_1acb8
T_1aca8:
	cmp.b	#$e0,d2
	bne.b	T_1acb8
	move.b	d0,d2
	andi.w	#$f,d2
	move.w	d2,$2(a5)
T_1acb8:
	add.w	d1,d1
	movea.l	T_1b510(pc),a3
	movea.w	(a3,d1.w),a3
	adda.l	T_1b52e(pc),a3
	move.l	a3,$c(a0)
	addi.w	#$c,$14(a0)
	bra.w	T_1ac46
T_1acd4:
	cmp.b	#$fe,d0
	bne.b	T_1ace6
	move.b	(a1),$1b(a0)
	move.b	(a1)+,$1a(a0)
	bra.w	T_1ac4a
T_1ace6:
	cmp.b	#$fd,d0
	bne.b	T_1acfa
	move.b	(a1),$1b(a0)
	move.b	(a1)+,$1a(a0)
	move.l	a1,$c(a0)
	rts
T_1acfa:
	move.b	d0,$1e(a0)
	move.b	(a1)+,d1
	move.b	d1,$1f(a0)
	andi.w	#$e0,d1
	beq.b	T_1ad0e
	move.b	(a1)+,$2c(a0)
T_1ad0e:
	move.l	a1,$c(a0)
	move.l	d5,$10(a0)
	tst.b	d0
	bmi.b	T_1ad88
	move.b	$1f(a0),d1
	move.b	d1,d0
	andi.w	#$1f,d1
	add.b	$20(a0),d1
	movea.l	T_1b518(pc),a2
	add.w	d1,d1
	movea.w	(a2,d1.w),a2
	adda.l	T_1b52e(pc),a2
	move.w	d5,$16(a0)
	move.b	(a2),$23(a0)
	move.b	(a2)+,$22(a0)
	moveq	#0,d1
	move.b	(a2)+,d1
	move.b	(a2)+,$27(a0)
	move.b	#$40,$2b(a0)
	move.b	(a2),$28(a0)
	move.b	(a2)+,$29(a0)
	move.b	(a2)+,$2a(a0)
	move.l	a2,$4(a0)
	andi.b	#$40,d0
	beq.b	T_1ad6a
	move.b	$2c(a0),d1
T_1ad6a:
	movea.l	T_1b514(pc),a2
	add.w	d1,d1
	movea.w	(a2,d1.w),a2
	adda.l	T_1b52e(pc),a2
	move.l	a2,$8(a0)
	move.w	d5,$18(a0)
	move.b	d5,$25(a0)
	move.b	d5,$24(a0)
T_1ad88:
	rts
T_1ad8a:
	movem.l	d0-d1,-(a7)
	move.w	d2,d0
	bsr.w	T_1a99c
	movem.l	(a7)+,d0-d1
	andi.b	#$f0,$fffffa1d.w
	move.l	d0,d7
	move.l	d1,d6
	sub.l	d0,d1
	addq.l	#$1,d6
	mulu.w	#$c,d7
	mulu.w	#$c,d6
	lea.l	T_1b50e(pc),a0
	move.w	d1,(a0)
	moveq	#2,d0
	lea.l	T_1b43c(pc),a0
	lea.l	T_1b3e2(pc),a1
	lea.l	T_1b3ea(pc),a2
T_1adc2:
	move.l	a1,$8(a0)
	clr.w	$18(a0)
	move.l	a1,$4(a0)
	clr.w	$16(a0)
	sf.b	$1e(a0)
	sf.b	$1f(a0)
	sf.b	$26(a0)
	sf.b	$2f(a0)
	move.b	#$1,$23(a0)
	move.b	#$1,$22(a0)
	sf.b	$24(a0)
	sf.b	$25(a0)
	sf.b	$27(a0)
	sf.b	$28(a0)
	sf.b	$29(a0)
	sf.b	$2a(a0)
	sf.b	$2c(a0)
	sf.b	$2d(a0)
	move.b	(a2),d3
	andi.w	#$f,d3
	add.w	d3,d3
	add.w	d3,d3
	move.b	(a2)+,$2e(a0)
	movea.l	T_1b51c(pc),a3
	adda.l	d7,a3
	adda.w	d3,a3
	move.l	a3,$0(a0)
	move.w	#$c,$14(a0)
	move.w	T_1b50e(pc),$1c(a0)
	moveq	#0,d1
	move.b	(a3)+,d1
	add.w	d1,d1
	movea.l	T_1b510(pc),a4
	movea.w	(a4,d1.w),a4
	adda.l	T_1b52e(pc),a4
	move.l	a4,$c(a0)
	clr.w	$1a(a0)
	move.b	#$2,$32(a0)
	move.b	(a3)+,$21(a0)
	sf.b	$33(a0)
	move.b	(a3)+,$20(a0)
	sf.b	$31(a0)
	sf.b	$30(a0)
	move.b	(a3)+,d1
	move.b	d1,d2
	andi.w	#$f0,d1
	cmp.w	#$f0,d1
	bne.b	T_1ae7c
	sub.b	d1,d2
	move.b	d2,$30(a0)
T_1ae7c:
	clr.l	$10(a0)
	lea.l	$34(a0),a0
	dbra	d0,T_1adc2
	lea.l	T_1b436(pc),a0
	move.w	#$1,(a0)
	clr.w	$4(a0)
	rts
T_1ae96:
	move.w	T_1b52c(pc),d2
	move.w	T_1b52a(pc),d1
	tst.w	d2
	beq.w	T_1af2c
	lea.l	T_1b4d8(pc),a0
	lea.l	T_1b42e(pc),a5
	move.b	d2,$1e(a0)
	move.b	d1,$2e(a0)
	sf.b	$21(a0)
	moveq	#0,d5
	andi.w	#$ff,d0
	movea.l	T_1b518(pc),a2
	add.w	d0,d0
	movea.w	(a2,d0.w),a2
	adda.l	T_1b52e(pc),a2
	move.w	d5,$16(a0)
	move.b	(a2),$23(a0)
	move.b	(a2)+,$22(a0)
	move.b	(a2)+,d0
	andi.w	#$ff,d0
	move.b	(a2)+,$27(a0)
	move.b	#$40,$2b(a0)
	move.b	(a2),$28(a0)
	move.b	(a2)+,$29(a0)
	move.b	(a2)+,$2a(a0)
	move.l	a2,$4(a0)
	movea.l	T_1b514(pc),a2
	add.w	d0,d0
	movea.w	(a2,d0.w),a2
	adda.l	T_1b52e(pc),a2
	move.l	a2,$8(a0)
	move.w	d5,$18(a0)
	sf.b	$24(a0)
	sf.b	$33(a0)
	sf.b	$25(a0)
	clr.l	$10(a0)
	sf.b	$30(a0)
	sf.b	$2c(a0)
	addq.w	#$1,d1
	move.w	d1,$4(a5)
T_1af2c:
	rts
T_1af2e:
	moveq	#0,d7
	move.b	d7,$2d(a0)
	tst.b	$25(a0)
	beq.b	T_1af42
	subq.b	#$1,$25(a0)
	bra.w	T_1b13a
T_1af42:
	movea.l	$8(a0),a1
	adda.w	$18(a0),a1
	move.b	(a1)+,d0
	moveq	#0,d1
	move.b	d0,d1
	subi.w	#$e0,d1
	bmi.w	T_1b132
	add.w	d1,d1
	move.w	T_1af62(pc,d1.w),d1
	jmp	T_1af62(pc,d1.w)
T_1af62:
	dc.b	$00,$fe,$01,$10,$01,$1a,$01,$2c,$01,$3c,$01,$4c,$01,$5a,$01,$68
	dc.b	$01,$88,$01,$94,$01,$be,$00,$f2,$00,$1c,$00,$c0,$70,$00,$10,$19
	dc.b	$12,$19,$14,$19,$24,$7a,$05,$aa,$0c,$aa,$4d,$41,$52,$43,$00,$f8
	dc.b	$66,$00,$00,$86,$d0,$40,$d0,$40,$d0,$40,$36,$72,$00,$00,$d7,$ca
	dc.b	$16,$3a,$05,$94,$67,$36,$2c,$4b,$40,$e7,$46,$fc,$27,$00,$34,$7c
	dc.b	$88,$00,$20,$3c,$04,$00,$05,$00,$01,$ca,$00,$00,$14,$bc,$00,$07
	dc.b	$10,$12,$08,$c0,$00,$05,$08,$80,$00,$02,$15,$40,$00,$02,$61,$00
	dc.b	$03,$f4,$46,$df,$00,$38,$00,$01,$fa,$1d,$60,$3c,$22,$0b,$74,$00
	dc.b	$34,$32,$00,$08,$d4,$8a,$04,$82,$00,$00,$00,$77,$02,$01,$00,$fe
	dc.b	$02,$02,$00,$fe,$34,$7c,$89,$00,$42,$52,$03,$8a,$00,$05,$05,$8a
	dc.b	$00,$11,$48,$41,$48,$42,$35,$41,$00,$02,$35,$42,$00,$0e,$35,$7c
	dc.b	$00,$80,$00,$20,$34,$bc,$00,$01,$58,$68,$00,$18,$60,$00,$ff,$2a
	dc.b	$10,$3a,$05,$14,$67,$24,$45,$fa,$fa,$70,$4a,$92,$67,$1c,$02,$38
	dc.b	$00,$f0,$fa,$1d,$40,$e7,$46,$fc,$27,$00,$11,$fc,$00,$0a,$88,$10
	dc.b	$51,$f8,$88,$12,$61,$00,$03,$7e,$46,$df,$52,$68,$00,$18,$60,$00
	dc.b	$fe,$f8,$11,$59,$00,$33,$54,$68,$00,$18,$60,$00,$fe,$ec,$70,$00
	dc.b	$10,$19,$31,$40,$00,$18,$22,$68,$00,$08,$d3,$c0,$60,$00,$fe,$da
	dc.b	$11,$69,$ff,$fe,$00,$26,$60,$00,$00,$c0,$31,$47,$00,$16,$11,$7c
	dc.b	$00,$01,$00,$22,$52,$68,$00,$18,$60,$00,$fe,$be,$11,$59,$00,$27
	dc.b	$11,$59,$00,$28,$56,$68,$00,$18,$60,$00,$fe,$ae,$11,$47,$00,$32
	dc.b	$11,$59,$00,$2d,$54,$68,$00,$18,$60,$00,$fe,$9e,$11,$7c,$00,$01
	dc.b	$00,$32,$52,$68,$00,$18,$60,$00,$fe,$90,$11,$7c,$00,$02,$00,$32
	dc.b	$52,$68,$00,$18,$60,$00,$fe,$82,$12,$3c,$00,$00,$12,$19,$22,$7a
	dc.b	$04,$46,$d2,$41,$32,$72,$10,$00,$d3,$fa,$04,$52,$21,$49,$00,$08
	dc.b	$31,$47,$00,$18,$60,$00,$fe,$62,$11,$59,$00,$25,$54,$68,$00,$18
	dc.b	$60,$00,$fe,$40,$36,$7c,$88,$70,$40,$e7,$46,$fc,$27,$00,$16,$bc
	dc.b	$00,$0b,$17,$59,$00,$02,$20,$3c,$0c,$00,$0d,$0a,$01,$cb,$00,$08
	dc.b	$61,$00,$02,$b2,$46,$df,$54,$68,$00,$18,$60,$00,$fe,$2c,$11,$7c
	dc.b	$00,$20,$00,$1f,$11,$59,$00,$2c,$54,$68,$00,$18,$60,$00,$fe,$1a
T_1b132:
	move.b	d0,$26(a0)
	addq.w	#$1,$18(a0)
T_1b13a:
	tst.b	$24(a0)
	beq.b	T_1b146
	subq.b	#$1,$24(a0)
	bra.b	T_1b1ae
T_1b146:
	subq.b	#$1,$22(a0)
	bne.b	T_1b1ae
	move.b	$23(a0),$22(a0)
	movea.l	$4(a0),a1
	adda.w	$16(a0),a1
T_1b15a:
	moveq	#0,d1
	move.b	(a1)+,d0
	move.b	d0,d1
	subi.w	#$e0,d1
	bmi.b	T_1b1a6
	add.w	d1,d1
	move.w	T_1b170(pc,d1.w),d1
	jmp	T_1b180+2(pc,d1.w)
T_1b170:
	ori.b	#$12,d0
	ori.b	#$0,d0
	ori.b	#$0,d0
	ori.b	#$0,d0
T_1b180:
	dc.w	$001a,$7200	; ori.b #$0, (a2)+
	move.b	(a1)+,d1
	subq.w	#$5,d1
	move.w	d1,$16(a0)
	movea.l	$4(a0),a1
	adda.w	d1,a1
	bra.b	T_1b15a
	move.b	-$2(a1),$2f(a0)
	bra.b	T_1b1ae
	addq.w	#$2,$16(a0)
	move.b	(a1),$24(a0)
	bra.b	T_1b13a
T_1b1a6:
	move.b	d0,$2f(a0)
	addq.w	#$1,$16(a0)
T_1b1ae:
	move.b	$26(a0),d0
	bmi.b	T_1b1bc
	add.b	$1e(a0),d0
	add.b	$21(a0),d0
T_1b1bc:
	andi.w	#$7f,d0
	lea.l	T_1b53a(pc),a1
	add.w	d0,d0
	move.w	d0,d1
	move.w	(a1,d0.w),d0
	move.b	$2e(a0),d3
	move.b	$32(a0),d2
	bne.b	T_1b1de
	bclr	d3,(a4)
	addq.w	#$3,d3
	bclr	d3,(a4)
	bra.b	T_1b20c
T_1b1de:
	cmp.b	#$1,d2
	bne.b	T_1b206
	bset	d3,(a4)
	addq.w	#$3,d3
	bclr	d3,(a4)
	move.b	$1e(a0),$2d(a0)
	move.b	$26(a0),d4
	bpl.b	T_1b200
	andi.b	#$7f,d4
	move.b	d4,$2d(a0)
	bra.b	T_1b20c
T_1b200:
	add.b	d4,$2d(a0)
	bra.b	T_1b20c
T_1b206:
	bclr	d3,(a4)
	addq.w	#$3,d3
	bset	d3,(a4)
T_1b20c:
	tst.b	$2d(a0)
	beq.b	T_1b220
	move.b	$2d(a0),d3
	not.b	d3
	andi.b	#$1f,d3
	move.b	d3,$1(a4)
T_1b220:
	move.b	T_1b537(pc),d2
	beq.w	T_1b31c
	tst.b	$2a(a0)
	beq.b	T_1b234
	subq.b	#$1,$2a(a0)
	bra.b	T_1b280
T_1b234:
	moveq	#0,d1
	moveq	#0,d2
	moveq	#0,d3
	move.b	$29(a0),d1
	move.b	$28(a0),d2
	move.w	d2,d5
	add.w	d5,d5
	move.b	$27(a0),d3
	move.b	$2b(a0),d4
	btst	#$5,d4
	beq.b	T_1b260
	sub.w	d3,d1
	bpl.b	T_1b26c
	moveq	#0,d1
	bchg	#$5,d4
	bra.b	T_1b26c
T_1b260:
	add.w	d3,d1
	cmp.w	d5,d1
	ble.b	T_1b26c
	move.w	d5,d1
	bchg	#$5,d4
T_1b26c:
	move.b	d1,$29(a0)
	move.b	d4,$2b(a0)
	sub.w	d2,d1
	ext.l	d1
	muls.w	d0,d1
	asr.l	#$8,d1
	asr.l	#$2,d1
	add.w	d1,d0
T_1b280:
	btst	#$5,$1f(a0)
	beq.b	T_1b2a4
	moveq	#0,d1
	move.b	$2c(a0),d1
	ext.w	d1
	ext.l	d1
	move.l	$10(a0),d2
	add.l	d1,d2
	move.l	d2,$10(a0)
	muls.w	d0,d2
	asr.l	#$8,d2
	asr.w	#$2,d2
	sub.w	d2,d0
T_1b2a4:
	move.b	$2f(a0),d1
	sub.b	$30(a0),d1
	sub.w	T_1b42c(pc),d1
	sub.b	$31(a0),d1
	bpl.b	T_1b2b8
	moveq	#0,d1
T_1b2b8:
	move.b	$33(a0),d7
	beq.b	T_1b31a
	movea.w	#$8830,a3
	move.w	d0,d2
	btst	#$7,d7
	beq.b	T_1b2e0
	move.w	sr,-(a7)
	move.w	#$2700,sr
	move.l	#$c000d0a,d4
	movep.l	d4,$8(a3)
	bsr.w	T_1b3c6
	move.w	(a7)+,sr
T_1b2e0:
	btst	#$1,d7
	beq.b	T_1b2e8
	sub.w	d0,d0
T_1b2e8:
	btst	#$3,d7
	beq.b	T_1b2f4
	move.w	d2,d7
	lsr.w	#$3,d7
	bra.b	T_1b300
T_1b2f4:
	btst	#$2,d7
	bne.b	T_1b2fc
	lsr.w	#$1,d7
T_1b2fc:
	move.w	d2,d7
	lsr.w	#$4,d7
T_1b300:
	move.w	sr,-(a7)
	move.w	#$2700,sr
	move.b	#$b,(a3)
	move.b	d7,$a(a3)
	move.b	T_1b538(pc),d3
	beq.b	T_1b318
	bsr.w	T_1b3c6
T_1b318:
	move.w	(a7)+,sr
T_1b31a:
	rts
T_1b31c:
	tst.b	$2a(a0)
	beq.b	T_1b328
	subq.b	#$1,$2a(a0)
	bra.b	T_1b38e
T_1b328:
	move.b	d1,d5
	move.b	$2b(a0),d6
	move.b	$28(a0),d4
	bmi.b	T_1b338
	add.b	d4,d4
	bra.b	T_1b33c
T_1b338:
	andi.b	#$7f,d4
T_1b33c:
	move.b	$29(a0),d1
	tst.b	d6
	bpl.b	T_1b348
	btst	d7,d6
	bne.b	T_1b36e
T_1b348:
	btst	#$5,d6
	bne.b	T_1b35c
	sub.b	$27(a0),d1
	bcc.b	T_1b36a
	bset	#$5,d6
	moveq	#0,d1
	bra.b	T_1b36a
T_1b35c:
	add.b	$27(a0),d1
	cmp.b	d4,d1
	bcs.b	T_1b36a
	bclr	#$5,d6
	move.b	d4,d1
T_1b36a:
	move.b	d1,$29(a0)
T_1b36e:
	lsr.b	#$1,d4
	sub.b	d4,d1
	bcc.b	T_1b378
	subi.w	#$100,d1
T_1b378:
	addi.b	#$a0,d5
	bcs.b	T_1b386
T_1b37e:
	add.w	d1,d1
	addi.b	#$18,d5
	bcc.b	T_1b37e
T_1b386:
	add.w	d1,d0
	bchg	d7,d6
	move.b	d6,$2b(a0)
T_1b38e:
	btst	#$5,$1f(a0)
	beq.b	T_1b3b0
	moveq	#0,d1
	move.b	$2c(a0),d1
	ext.w	d1
	swap	d1
	asr.l	#$4,d1
	move.l	$10(a0),d2
	add.l	d1,d2
	move.l	d2,$10(a0)
	swap	d2
	sub.w	d2,d0
T_1b3b0:
	move.b	$2f(a0),d1
	sub.b	$30(a0),d1
	sub.w	T_1b42c(pc),d1
	sub.b	$31(a0),d1
	bpl.b	T_1b3c4
	moveq	#0,d1
T_1b3c4:
	rts
T_1b3c6:
	move.w	d0,-(a7)
	move.l	d1,-(a7)
	moveq	#10,d1
	move.b	T_1b538(pc),d0
	cmp.b	#$2,d0
	bne.b	T_1b3d8
	addq.w	#$5,d1
T_1b3d8:
	move.b	d1,$ffff8800.w
	move.l	(a7)+,d1
	move.w	(a7)+,d0
	rts
T_1b3e2:
	dc.b	$01,$00,$00,$00,$00,$00,$00,$e1
T_1b3ea:
	dc.b	$00,$01,$02,$00
T_1b3ee:
	dc.b	$00,$00,$00,$00,$01,$00,$00,$00,$02,$00,$00,$00,$03,$00,$00,$00
	dc.b	$04,$00,$00,$00,$05,$00,$00,$00,$06,$00,$00,$00,$07,$00,$ff,$00
	dc.b	$08,$00,$00,$00,$09,$00,$00,$00,$0a,$00,$00,$00
T_1b41a:
	dc.b	$00,$00,$00,$00,$02,$06,$22,$00,$0a,$0e,$26,$00,$12,$16,$2a,$00
T_1b42a:
	dc.b	$00,$00
T_1b42c:
	dc.b	$00,$00
T_1b42e:
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00
T_1b436:
	dc.b	$00,$04
T_1b438:
	dc.b	$00,$04
T_1b43a:
	dc.b	$ff,$00
T_1b43c:
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00
T_1b470:
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00
T_1b4a4:
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00
T_1b4d8:
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$40
T_1b50e:
	dc.b	$00,$00
T_1b510:
	dc.b	$00,$00,$00,$00
T_1b514:
	dc.b	$00,$00,$00,$00
T_1b518:
	dc.b	$00,$00,$00,$00
T_1b51c:
	dc.b	$00,$00,$00,$00,$00,$00
T_1b522:
	dc.b	$00,$00,$00,$00
T_1b526:
	dc.b	$00,$00,$00,$00
T_1b52a:
	dc.b	$00,$00
T_1b52c:
	dc.b	$00,$00
T_1b52e:
	dc.b	$00,$00,$00,$00
T_1b532:
	dc.b	$00,$00,$00,$00
T_1b536:
	dc.b	$00
T_1b537:
	dc.b	$00
T_1b538:
	dc.b	$ff,$00
T_1b53a:
	dc.b	$0e,$ee,$0e,$17,$0d,$4d,$0c,$8e,$0b,$d9,$0b,$2f,$0a,$8e,$09,$f7
	dc.b	$09,$67,$08,$e0,$08,$61,$07,$e8,$07,$77,$07,$0b,$06,$a6,$06,$47
	dc.b	$05,$ec,$05,$97,$05,$47,$04,$fb,$04,$b3,$04,$70,$04,$30,$03,$f4
	dc.b	$03,$bb,$03,$85,$03,$53,$03,$23,$02,$f6,$02,$cb,$02,$a3,$02,$7d
	dc.b	$02,$59,$02,$38,$02,$18,$01,$fa,$01,$dd,$01,$c2,$01,$a9,$01,$91
	dc.b	$01,$7b,$01,$65,$01,$51,$01,$3e,$01,$2c,$01,$1c,$01,$0c,$00,$fd
	dc.b	$00,$ee,$00,$e1,$00,$d4,$00,$c8,$00,$bd,$00,$b2,$00,$a8,$00,$9f
	dc.b	$00,$96,$00,$8e,$00,$86,$00,$7e,$00,$77,$00,$70,$00,$6a,$00,$64
	dc.b	$00,$5e,$00,$59,$00,$54,$00,$4f,$00,$4b,$00,$47,$00,$43,$00,$3f
	dc.b	$00,$3b,$00,$38,$00,$35,$00,$32,$00,$2f,$00,$2c,$00,$2a,$00,$27
	dc.b	$00,$25,$00,$23,$00,$21,$00,$1f,$00,$1d,$00,$1c,$00,$1a,$00,$19
	dc.b	$00,$17,$00,$16,$00,$15,$00,$13,$00,$12,$00,$11,$00,$10,$00,$0f
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
T_1b63a:
	dc.b	$00,$00,$00,$00
T_1b63e:
	movem.l	d0-d7/a0-a6,-(a7)
	move.w	sr,-(a7)
	ori.w	#$700,sr
	ori.b	#$20,$fffffa09.w
	move.w	(a7)+,sr
	move.w	#$f,d0
	jsr	Push_Mptr
	move.w	#$19,-(a7)
	trap	#$1
	addq.l	#$2,a7
	cmpi.w	#$2,d0
	spl.b	B_60123
	bpl.b	T_1b688
	cmpi.w	#$2,$4a6.w
	seq.b	B_60124
	move.w	#$0,-(a7)
	move.w	#$e,-(a7)
	trap	#$1
	addq.l	#$4,a7
	bra.b	T_1b6a8
T_1b688:
	move.l	#D_5496d,-(a7)
	move.w	#$3b,-(a7)
	trap	#$1
	addq.l	#$6,a7
	tst.l	d0
	bpl.b	T_1b6a8
	lea.l	D_54982,a1
	jsr	DI_Error
	bra.b	T_1b6ca
T_1b6a8:
	move.w	#$2f,-(a7)
	trap	#$1
	addq.l	#$2,a7
	move.l	d0,B_6012a
	move.w	sr,-(a7)
	ori.w	#$700,sr
	andi.b	#$df,$fffffa09.w
	move.w	(a7)+,sr
	jsr	Pop_Mptr
T_1b6ca:
	movem.l	(a7)+,d0-d7/a0-a6
	rts
T_1b6d0:
	cmpi.w	#$fff3,d0
	bne.b	T_1b6de
	jsr	T_1a170
	bra.b	T_1b6e4
T_1b6de:
	jsr	T_1a10e
T_1b6e4:
	rts
T_1b6e6:
	movem.l	d0-d7/a0-a6,-(a7)
	tst.b	B_60123
	bne.w	T_1b782
	moveq	#0,d0
	move.b	(a0),d0
	lea.l	D_5494f,a0
	moveq	#0,d7
	move.b	-$1(a0,d0.w),d7
T_1b704:
	move.w	#$8,-(a7)
	move.l	#D_54965,-(a7)
	move.w	#$4e,-(a7)
	trap	#$1
	addq.l	#$8,a7
	tst.l	d0
	bmi.b	T_1b72c
	movea.l	B_6012a,a0
	move.b	$24(a0),d0
	subi.b	#$41,d0
	cmp.b	d0,d7
	beq.b	T_1b782
T_1b72c:
	tst.b	B_60124
	bne.b	T_1b73e
T_1b734:
	move.w	d7,d0
	jsr	T_1a02e
	bra.b	T_1b704
T_1b73e:
	move.b	B_60122,d0
	eori.b	#$1,d0
	move.b	d0,B_60122
	ext.w	d0
	move.w	d0,-(a7)
	move.w	#$e,-(a7)
	trap	#$1
	addq.l	#$4,a7
	move.w	#$8,-(a7)
	move.l	#D_54965,-(a7)
	move.w	#$4e,-(a7)
	trap	#$1
	addq.l	#$8,a7
	tst.l	d0
	bmi.b	T_1b734
	movea.l	B_6012a,a0
	move.b	$24(a0),d0
	subi.b	#$41,d0
	cmp.b	d0,d7
	bne.b	T_1b734
T_1b782:
	movem.l	(a7)+,d0-d7/a0-a6
	rts
T_1b788:
	movem.l	d0-d7/a1-a6,-(a7)
	moveq	#0,d6
	movea.l	a0,a5
	move.b	(a0)+,d0
	beq.b	T_1b7a6
	moveq	#0,d1
	jsr	Reallocate_memory
	cmpa.l	#$0,a0
	bne.w	T_1b864
T_1b7a6:
	move.w	sr,-(a7)
	ori.w	#$700,sr
	ori.b	#$20,$fffffa09.w
	move.w	(a7)+,sr
	move.w	#$f,d0
	jsr	Push_Mptr
	movea.l	a5,a0
	bsr.w	T_1b6e6
	movea.l	a5,a0
	addq.l	#$1,a0
	move.w	#$0,-(a7)
	move.l	a0,-(a7)
	move.w	#$4e,-(a7)
	trap	#$1
	addq.l	#$8,a7
	tst.l	d0
	bpl.b	T_1b7e2
	bsr.w	T_1b6d0
	bra.w	T_1b86a
T_1b7e2:
	movea.l	B_6012a,a0
	move.l	$1a(a0),d7
	move.b	(a5),d0
	move.l	d7,d1
	moveq	#0,d2
	jsr	File_allocate
	movea.l	a1,a4
	movea.l	a5,a0
	addq.l	#$1,a0
	move.w	#$0,-(a7)
	move.l	a0,-(a7)
	move.w	#$3d,-(a7)
	trap	#$1
	addq.l	#$8,a7
	tst.l	d0
	bpl.b	T_1b816
	bsr.w	T_1b6d0
	bra.b	T_1b86a
T_1b816:
	move.w	d0,d6
	movea.l	a4,a0
	move.l	a0,-(a7)
	move.l	d7,-(a7)
	move.w	d6,-(a7)
	move.w	#$3f,-(a7)
	trap	#$1
	lea.l	$c(a7),a7
	tst.l	d0
	bpl.b	T_1b834
	bsr.w	T_1b6d0
	bra.b	T_1b86a
T_1b834:
	move.l	d0,B_60126
	move.w	d6,-(a7)
	move.w	#$3e,-(a7)
	trap	#$1
	addq.l	#$4,a7
	tst.l	d0
	bpl.b	T_1b84e
	bsr.w	T_1b6d0
	bra.b	T_1b86a
T_1b84e:
	jsr	Pop_Mptr
	move.w	sr,-(a7)
	ori.w	#$700,sr
	andi.b	#$df,$fffffa09.w
	move.w	(a7)+,sr
	movea.l	a4,a0
T_1b864:
	movem.l	(a7)+,d0-d7/a1-a6
	rts
T_1b86a:
	tst.w	d6
	beq.b	T_1b878
	move.w	d6,-(a7)
	move.w	#$3e,-(a7)
	trap	#$1
	addq.l	#$4,a7
T_1b878:
	jsr	Pop_Mptr
	move.w	sr,-(a7)
	ori.w	#$700,sr
	andi.b	#$df,$fffffa09.w
	move.w	(a7)+,sr
	movem.l	(a7)+,d0-d7/a1-a6
	bra.w	T_1b788
