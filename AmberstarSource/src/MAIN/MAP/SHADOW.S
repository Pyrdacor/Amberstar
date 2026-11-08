; MAIN/MAP/SHADOW.ASM (original module, merged with the disassembly of the shipped program)

; ---- Do_shadow (original source: MAIN/MAP/SHADOW.ASM)
Do_shadow:
	movem.l	d0-d7,-(sp)
	moveq.l	#11,d2
	moveq.l	#-1,d3
	moveq.l	#9,d4
	moveq.l	#-1,d5
	sub.w	Mapbuf_X,d2
	sub.w	Mapbuf_X,d3
	sub.w	Mapbuf_Y,d4
	sub.w	Mapbuf_Y,d5
	ext.w	d0
	ext.w	d1
	move.w	d1,d7
	add.w	Mapbuf_Y,d7
	mulu.w	#13,d7
	add.w	d0,d7
	add.w	Mapbuf_X,d7
	moveq.l	#0,d6
	move.b	14(a2,d7.w),d6
	beq.s	.Underlay
	add.w	d6,d6
	add.w	d6,d6
	move.l	-4(a5,d6.w),d6
	btst	#5,d6
	bne.s	.Underlay
	btst	#1,d6
	beq.s	.Exit
	bra.s	.Ok
.Underlay:
	moveq.l	#0,d6
	move.b	14(a1,d7.w),d6
	add.w	d6,d6
	add.w	d6,d6
	move.l	-4(a5,d6.w),d6
	btst	#1,d6
	beq.s	.Exit
.Ok:
	move.w	d0,d6
	bpl.s	.Pos_1
	neg.w	d6
.Pos_1:
	move.w	d1,d7
	bpl.s	.Pos_2
	neg.w	d7
.Pos_2:
	lea.l	Shadow_table,a4
	mulu.w	#9,d7
	add.w	d6,d7
	add.w	d7,d7
	move.w	-2(a4,d7.w),d7
	lea.l	124(a4,d7.w),a4
	tst.w	d0
	bmi.s	.Quad_12
	tst.w	d1
	bmi.s	.Quad_0
	bsr.w	Quadrant_3
	bra.s	.Exit
.Quad_0:
	bsr.w	Quadrant_0
	bra.s	.Exit
.Quad_12:
	tst.w	d1
	bmi.s	.Quad_1
	bsr.w	Quadrant_2
	bra.s	.Exit
.Quad_1:
	bsr.w	Quadrant_1
.Exit:
	movem.l	(sp)+,d0-d7
	rts	
Quadrant_0:
	tst.w	(a4)
	beq.b	.l_059d0
	move.b	(a4),d0
	cmp.b	d2,d0
	bgt.b	.l_059cc
	cmp.b	d3,d0
	blt.b	.l_059cc
	move.b	$1(a4),d1
	neg.b	d1
	cmp.b	d4,d1
	bgt.b	.l_059cc
	cmp.b	d5,d1
	blt.b	.l_059cc
	ext.w	d0
	ext.w	d1
	add.w	Mapbuf_Y,d1
	mulu.w	#$d,d1
	add.w	d0,d1
	add.w	Mapbuf_X,d1
	move.b	#$1,$e(a1,d1.w)
	move.b	#$0,$e(a2,d1.w)
	move.b	#$0,$e(a3,d1.w)
	move.b	#$0,$e(a6,d1.w)
.l_059cc:
	addq.l	#$2,a4
	bra.b	Quadrant_0
.l_059d0:
	rts
Quadrant_1:
	tst.w	(a4)
	beq.b	.l_05a22
	move.b	(a4),d0
	neg.b	d0
	cmp.b	d2,d0
	bgt.b	.l_05a1e
	cmp.b	d3,d0
	blt.b	.l_05a1e
	move.b	$1(a4),d1
	neg.b	d1
	cmp.b	d4,d1
	bgt.b	.l_05a1e
	cmp.b	d5,d1
	blt.b	.l_05a1e
	ext.w	d0
	ext.w	d1
	add.w	Mapbuf_Y,d1
	mulu.w	#$d,d1
	add.w	d0,d1
	add.w	Mapbuf_X,d1
	move.b	#$1,$e(a1,d1.w)
	move.b	#$0,$e(a2,d1.w)
	move.b	#$0,$e(a3,d1.w)
	move.b	#$0,$e(a6,d1.w)
.l_05a1e:
	addq.l	#$2,a4
	bra.b	Quadrant_1
.l_05a22:
	rts
Quadrant_2:
	tst.w	(a4)
	beq.b	.l_05a72
	move.b	(a4),d0
	neg.b	d0
	cmp.b	d2,d0
	bgt.b	.l_05a6e
	cmp.b	d3,d0
	blt.b	.l_05a6e
	move.b	$1(a4),d1
	cmp.b	d4,d1
	bgt.b	.l_05a6e
	cmp.b	d5,d1
	blt.b	.l_05a6e
	ext.w	d0
	ext.w	d1
	add.w	Mapbuf_Y,d1
	mulu.w	#$d,d1
	add.w	d0,d1
	add.w	Mapbuf_X,d1
	move.b	#$1,$e(a1,d1.w)
	move.b	#$0,$e(a2,d1.w)
	move.b	#$0,$e(a3,d1.w)
	move.b	#$0,$e(a6,d1.w)
.l_05a6e:
	addq.l	#$2,a4
	bra.b	Quadrant_2
.l_05a72:
	rts
Quadrant_3:
	tst.w	(a4)
	beq.b	.l_05ac0
	move.b	(a4),d0
	cmp.b	d2,d0
	bgt.b	.l_05abc
	cmp.b	d3,d0
	blt.b	.l_05abc
	move.b	$1(a4),d1
	cmp.b	d4,d1
	bgt.b	.l_05abc
	cmp.b	d5,d1
	blt.b	.l_05abc
	ext.w	d0
	ext.w	d1
	add.w	Mapbuf_Y,d1
	mulu.w	#$d,d1
	add.w	d0,d1
	add.w	Mapbuf_X,d1
	move.b	#$1,$e(a1,d1.w)
	move.b	#$0,$e(a2,d1.w)
	move.b	#$0,$e(a3,d1.w)
	move.b	#$0,$e(a6,d1.w)
.l_05abc:
	addq.l	#$2,a4
	bra.b	Quadrant_3
.l_05ac0:
	rts
