; NUCLEUS/GFXROUTS.ASM (original module, merged with the disassembly of the shipped program)

Coord_convert:
	move.l	d0,-(a7)
	move.w	d1,d2
	mulu.w	#$a0,d2
	move.w	d0,d3
	andi.w	#$f,d3
	sub.w	d3,d0
	lsr.w	#$1,d0
	add.w	d0,d2
	move.l	(a7)+,d0
	rts
T_1c42e:
	movem.l	d0-d7/a0-a4,-(a7)
	subq.w	#$1,d6
	subq.w	#$1,d7
	movea.w	d6,a4
	bsr.w	Coord_convert
	lea.l	(a6,d2.w),a1
	andi.w	#$f,d0
T_1c444:
	movea.l	a1,a3
	move.w	a4,d6
T_1c448:
	moveq	#0,d1
	moveq	#0,d2
	moveq	#0,d3
	moveq	#0,d4
	move.w	(a0)+,d1
	move.w	(a0)+,d2
	move.w	(a0)+,d3
	move.w	(a0)+,d4
	ror.l	d0,d1
	ror.l	d0,d2
	ror.l	d0,d3
	ror.l	d0,d4
	move.l	d1,d5
	or.l	d2,d5
	or.l	d3,d5
	or.l	d4,d5
	not.l	d5
	and.w	d5,(a3)
	or.w	d1,(a3)+
	and.w	d5,(a3)
	or.w	d2,(a3)+
	and.w	d5,(a3)
	or.w	d3,(a3)+
	and.w	d5,(a3)
	or.w	d4,(a3)+
	swap	d1
	swap	d2
	swap	d3
	swap	d4
	swap	d5
	and.w	d5,(a3)
	or.w	d1,(a3)+
	and.w	d5,(a3)
	or.w	d2,(a3)+
	and.w	d5,(a3)
	or.w	d3,(a3)+
	and.w	d5,(a3)
	or.w	d4,(a3)+
	subq.l	#$8,a3
	dbra	d6,T_1c448
	lea.l	$a0(a1),a1
	dbra	d7,T_1c444
	movem.l	(a7)+,d0-d7/a0-a4
	rts
Draw_box:
	movem.l	d0-d7/a0-a3,-(a7)
	sub.w	d1,d3
	move.w	d3,d7
	mulu.w	#$a0,d1
	lea.l	(a6,d1.w),a0
	move.w	d2,d1
	moveq	#15,d2
	moveq	#15,d3
	and.w	d0,d2
	and.w	d1,d3
	sub.w	d2,d0
	sub.w	d3,d1
	lea.l	D_51bb4,a1
	add.w	d2,d2
	add.w	d3,d3
	move.w	(a1,d2.w),d2
	move.w	$20(a1,d3.w),d3
	move.w	d2,d4
	not.w	d4
	move.w	d3,d5
	not.w	d5
	lsr.w	#$1,d0
	adda.w	d0,a0
	add.w	d0,d0
	sub.w	d0,d1
	beq.w	T_1c594
	movea.w	#$98,a3
	lsr.w	#$1,d1
	suba.w	d1,a3
	lea.l	T_1c588(pc),a1
	lsr.w	#$1,d1
	suba.w	d1,a1
	lea.l	Box_hl_comms,a2
	lsl.w	#$3,d6
	movem.l	(a2,d6.w),d0-d1
	movem.l	d0-d1,T_1c532
	ori.l	#$2000200,d0
	ori.l	#$2000200,d1
	movem.l	d0-d1,T_1c584
	lea.l	D_51bf4,a2
	movem.l	(a2,d6.w),d0-d1
T_1c532:
	or.w	d2,(a0)+
	or.w	d2,(a0)+
	and.w	d4,(a0)+
	and.w	d4,(a0)+
	jmp	(a1)
	dc.b	$20,$c0,$20,$c1,$20,$c0,$20,$c1,$20,$c0,$20,$c1,$20,$c0,$20,$c1
	dc.b	$20,$c0,$20,$c1,$20,$c0,$20,$c1,$20,$c0,$20,$c1,$20,$c0,$20,$c1
	dc.b	$20,$c0,$20,$c1,$20,$c0,$20,$c1,$20,$c0,$20,$c1,$20,$c0,$20,$c1
	dc.b	$20,$c0,$20,$c1,$20,$c0,$20,$c1,$20,$c0,$20,$c1,$20,$c0,$20,$c1
	dc.b	$20,$c0,$20,$c1,$20,$c0,$20,$c1
T_1c584:
	or.w	d3,(a0)+
	or.w	d3,(a0)+
T_1c588:
	and.w	d5,(a0)+
	and.w	d5,(a0)+
	adda.w	a3,a0
	dbra	d7,T_1c532
	bra.b	T_1c5be
T_1c594:
	lea.l	Box_hl_comms,a2
	lsl.w	#$3,d6
	movem.l	(a2,d6.w),d0-d1
	movem.l	d0-d1,T_1c5ae
	and.w	d3,d2
	or.w	d5,d4
T_1c5ae:
	or.w	d2,(a0)+
	or.w	d2,(a0)+
	and.w	d4,(a0)+
	and.w	d4,(a0)+
	lea.l	$98(a0),a0
	dbra	d7,T_1c5ae
T_1c5be:
	movem.l	(a7)+,d0-d7/a0-a3
	rts
; ---- Duplicate_block (original source: NUCLEUS/GFXROUTS.ASM)
Duplicate_block:
	movem.l	d2-d7/a0/a1,-(sp)
	bsr.w	Coord_convert
	adda.w	d2,a0
	adda.w	d2,a1
	move.w	d6,d5
	lsl.w	#3,d5
	subi.w	#160,d5
	neg.w	d5
	subq.w	#1,d7
	subq.w	#1,d6
.Loop_1:
	move.w	d6,d4
.Loop_2:
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	dbra	d4,.Loop_2
	adda.w	d5,a0
	adda.w	d5,a1
	dbra	d7,.Loop_1
	movem.l	(sp)+,d2-d7/a0/a1
	rts	
; ---- Get2_block (original source: NUCLEUS/GFXROUTS.ASM)
Get2_block:
	movem.l	d2-d7/a0/a1,-(sp)
	jsr	Mouse_off
	bsr.w	Coord_convert
	lea.l	0(a6,d2.w),a1
	move.w	d6,d5
	lsl.w	#3,d5
	subi.w	#160,d5
	neg.w	d5
	subq.w	#1,d7
	subq.w	#1,d6
.Loop_1:
	move.w	d6,d4
.Loop_2:
	move.l	(a1)+,(a0)+
	move.l	(a1)+,(a0)+
	dbra	d4,.Loop_2
	adda.w	d5,a1
	dbra	d7,.Loop_1
	jsr	Mouse_on
	movem.l	(sp)+,d2-d7/a0/a1
	rts	
Blit_unmasked_block:
	movem.l	d0-d5/d7/a0-a1,-(a7)
	bsr.w	Coord_convert
	lea.l	(a6,d2.w),a1
	move.l	#$ffff0000,d5
	ror.l	d3,d5
	moveq	#15,d7
T_1c648:
	moveq	#0,d0
	move.w	(a0)+,d0
	moveq	#0,d1
	move.w	(a0)+,d1
	moveq	#0,d2
	move.w	(a0)+,d2
	moveq	#0,d4
	move.w	(a0)+,d4
	ror.l	d3,d0
	ror.l	d3,d1
	ror.l	d3,d2
	ror.l	d3,d4
	and.w	d5,(a1)
	or.w	d0,(a1)+
	and.w	d5,(a1)
	or.w	d1,(a1)+
	and.w	d5,(a1)
	or.w	d2,(a1)+
	and.w	d5,(a1)
	or.w	d4,(a1)+
	swap	d0
	swap	d1
	swap	d2
	swap	d4
	swap	d5
	and.w	d5,(a1)
	or.w	d0,(a1)+
	and.w	d5,(a1)
	or.w	d1,(a1)+
	and.w	d5,(a1)
	or.w	d2,(a1)+
	and.w	d5,(a1)
	or.w	d4,(a1)+
	swap	d5
	lea.l	$90(a1),a1
	dbra	d7,T_1c648
	movem.l	(a7)+,d0-d5/d7/a0-a1
	rts
Blit_masked_block:
	movem.l	d0-d7/a0-a1,-(a7)
	bsr.w	Coord_convert
	lea.l	(a6,d2.w),a1
	move.l	#$ffff0000,d5
	ror.l	d3,d5
	move.w	d3,d6
	moveq	#15,d7
T_1c6b2:
	moveq	#0,d0
	move.w	(a0)+,d0
	moveq	#0,d1
	move.w	(a0)+,d1
	moveq	#0,d2
	move.w	(a0)+,d2
	moveq	#0,d3
	move.w	(a0)+,d3
	ror.l	d6,d0
	ror.l	d6,d1
	ror.l	d6,d2
	ror.l	d6,d3
	move.l	d0,d4
	or.l	d1,d4
	or.l	d2,d4
	or.l	d3,d4
	not.l	d4
	or.l	d5,d4
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
	dbra	d7,T_1c6b2
	movem.l	(a7)+,d0-d7/a0-a1
	rts
Put_unmasked_block:
	movem.l	d2-d3/d7/a0-a1,-(a7)
	bsr.w	Coord_convert
	lea.l	(a6,d2.w),a1
	moveq	#15,d7
T_1c71c:
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	lea.l	$98(a1),a1
	dbra	d7,T_1c71c
	movem.l	(a7)+,d2-d3/d7/a0-a1
	rts
Blot_unmasked_block:
	movem.l	d2-d7/a0-a1,-(a7)
	bsr.w	Coord_convert
	lea.l	(a6,d2.w),a1
	move.w	d6,d5
	lsl.w	#$3,d5
	subi.w	#$a0,d5
	neg.w	d5
	subq.w	#$1,d7
	subq.w	#$1,d6
T_1c748:
	move.w	d6,d4
T_1c74a:
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	dbra	d4,T_1c74a
	adda.w	d5,a1
	dbra	d7,T_1c748
	movem.l	(a7)+,d2-d7/a0-a1
	rts
Put_masked_block:
	movem.l	d0-d4/d7/a0-a1,-(a7)
	bsr.w	Coord_convert
	lea.l	(a6,d2.w),a1
	moveq	#15,d7
T_1c76c:
	movem.w	(a0)+,d0-d3
	move.w	d0,d4
	or.w	d1,d4
	or.w	d2,d4
	or.w	d3,d4
	not.w	d4
	and.w	d4,(a1)
	or.w	d0,(a1)+
	and.w	d4,(a1)
	or.w	d1,(a1)+
	and.w	d4,(a1)
	or.w	d2,(a1)+
	and.w	d4,(a1)
	or.w	d3,(a1)+
	lea.l	$98(a1),a1
	dbra	d7,T_1c76c
	movem.l	(a7)+,d0-d4/d7/a0-a1
	rts
Blot_masked_block:
	movem.l	d0-d7/a0-a1,-(a7)
	bsr.w	Coord_convert
	lea.l	(a6,d2.w),a1
	move.w	d6,d5
	lsl.w	#$3,d5
	subi.w	#$a0,d5
	neg.w	d5
	subq.w	#$1,d7
	subq.w	#$1,d6
	move.w	d6,-(a7)
T_1c7b4:
	move.w	(a7),d6
T_1c7b6:
	movem.w	(a0)+,d0-d3
	move.w	d0,d4
	or.w	d1,d4
	or.w	d2,d4
	or.w	d3,d4
	not.w	d4
	and.w	d4,(a1)
	or.w	d0,(a1)+
	and.w	d4,(a1)
	or.w	d1,(a1)+
	and.w	d4,(a1)
	or.w	d2,(a1)+
	and.w	d4,(a1)
	or.w	d3,(a1)+
	dbra	d6,T_1c7b6
	adda.w	d5,a1
	dbra	d7,T_1c7b4
	addq.l	#$2,a7
	movem.l	(a7)+,d0-d7/a0-a1
	rts
