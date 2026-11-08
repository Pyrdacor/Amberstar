; NUCLEUS/AMBRFILE.ASM (original module, merged with the disassembly of the shipped program)

Save_file:
	movem.l	d0-d7/a0-a6,-(a7)
	moveq	#0,d6
	move.l	d0,d7
	movea.l	a0,a5
	movea.l	a1,a4
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
	move.w	#$3c,-(a7)
	trap	#$1
	addq.l	#$8,a7
	tst.l	d0
	bpl.b	.l_1b8da
	bsr.w	T_1b6d0
	bra.b	.l_1b938
.l_1b8da:
	move.l	d0,d6
	movea.l	a4,a0
	move.l	a0,-(a7)
	move.l	d7,-(a7)
	move.w	d6,-(a7)
	move.w	#$40,-(a7)
	trap	#$1
	lea.l	$c(a7),a7
	tst.l	d0
	bpl.b	.l_1b8f8
	bsr.w	T_1b6d0
	bra.b	.l_1b938
.l_1b8f8:
	cmp.l	d7,d0
	beq.b	.l_1b90a
	lea.l	D_549b6,a1
	jsr	DI_Error
	bra.b	.l_1b938
.l_1b90a:
	move.w	d6,-(a7)
	move.w	#$3e,-(a7)
	trap	#$1
	addq.l	#$4,a7
	tst.l	d0
	bpl.b	.l_1b91e
	bsr.w	T_1b6d0
	bra.b	.l_1b938
.l_1b91e:
	move.w	sr,-(a7)
	ori.w	#$700,sr
	andi.b	#$df,$fffffa09.w
	move.w	(a7)+,sr
	jsr	Pop_Mptr
	movem.l	(a7)+,d0-d7/a0-a6
	rts
.l_1b938:
	tst.w	d6
	beq.b	.l_1b946
	move.w	d6,-(a7)
	move.w	#$3e,-(a7)
	trap	#$1
	addq.l	#$4,a7
.l_1b946:
	move.w	sr,-(a7)
	ori.w	#$700,sr
	andi.b	#$df,$fffffa09.w
	move.w	(a7)+,sr
	jsr	Pop_Mptr
	movem.l	(a7)+,d0-d7/a0-a6
	bra.w	Save_file
	movem.l	d0-d7/a0-a6,-(a7)
	moveq	#0,d6
	movea.l	a0,a5
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
	move.w	sr,-(a7)
	ori.w	#$700,sr
	andi.b	#$df,$fffffa09.w
	move.w	(a7)+,sr
	jsr	Pop_Mptr
	cmpi.l	#$ffffffdf,d0
	movem.l	(a7)+,d0-d7/a0-a6
	rts
	movem.l	d1-d7/a0-a6,-(a7)
	move.l	d0,d7
	move.w	sr,-(a7)
	ori.w	#$700,sr
	ori.b	#$20,$fffffa09.w
	move.w	(a7)+,sr
	move.w	#$f,d0
	jsr	Push_Mptr
.l_1b9d8:
	lea.l	B_6045c,a5
	move.w	d7,-(a7)
	move.l	a5,-(a7)
	move.w	#$36,-(a7)
	trap	#$1
	addq.l	#$8,a7
	tst.l	d0
	beq.b	.l_1b9f6
	jsr	T_1a10e
	bra.b	.l_1b9d8
.l_1b9f6:
	move.w	sr,-(a7)
	ori.w	#$700,sr
	andi.b	#$df,$fffffa09.w
	move.w	(a7)+,sr
	jsr	Pop_Mptr
	move.l	(a5),d0
	move.l	$8(a5),d1
	move.l	$c(a5),d2
	mulu.w	d2,d0
	mulu.w	d1,d0
	movem.l	(a7)+,d1-d7/a0-a6
	rts
Load_subfile:
	movem.l	d0-d7/a1-a6,-(a7)
	subq.w	#$1,d0
	bpl.b	.l_1ba36
	lea.l	D_549d5,a1
	jsr	DI_Error
	bra.w	T_1bc42
.l_1ba36:
	moveq	#0,d6
	move.w	d0,d5
	movea.l	a0,a5
	move.b	(a0)+,d0
	move.w	d5,d1
	jsr	Reallocate_memory
	cmpa.l	#$0,a0
	bne.w	T_1bc42
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
	move.w	#$3d,-(a7)
	trap	#$1
	addq.l	#$8,a7
	tst.l	d0
	bpl.b	.l_1ba8c
	bsr.w	T_1b6d0
	bra.w	T_1bc48
.l_1ba8c:
	move.w	d0,d6
	move.l	#B_60136,-(a7)
	move.l	#$326,-(a7)
	move.w	d6,-(a7)
	move.w	#$3f,-(a7)
	trap	#$1
	lea.l	$c(a7),a7
	tst.l	d0
	bpl.b	.l_1bab2
	bsr.w	T_1b6d0
	bra.w	T_1bc48
.l_1bab2:
	cmpi.l	#$414d4252,B_60136
	beq.b	.l_1bada
	cmpi.l	#$414d5043,B_60136
	beq.b	.l_1bada
	lea.l	D_549fe,a1
	jsr	DI_Error
	bra.w	T_1bc42
.l_1bada:
	move.w	B_6013a,d4
	cmp.w	d4,d5
	bmi.b	.l_1baf4
	lea.l	D_54a2f,a1
	jsr	DI_Error
	bra.w	T_1bc42
.l_1baf4:
	ext.l	d4
	lsl.l	#$2,d4
	addq.l	#$6,d4
	lea.l	B_6013c,a0
	move.w	d5,d0
	bra.b	T_1bb06
T_1bb04:
	add.l	(a0)+,d4
T_1bb06:
	dbra	d0,T_1bb04
	move.l	(a0),d7
	cmpi.l	#$414d4252,B_60136
	bne.b	.l_1bb6c
	move.b	(a5),d0
	move.l	d7,d1
	move.w	d5,d2
	jsr	File_allocate
	movea.l	a1,a4
	move.w	#$0,-(a7)
	move.w	d6,-(a7)
	move.l	d4,-(a7)
	move.w	#$42,-(a7)
	trap	#$1
	lea.l	$a(a7),a7
	tst.l	d0
	bpl.b	.l_1bb44
	bsr.w	T_1b6d0
	bra.w	T_1bc48
.l_1bb44:
	movea.l	a4,a0
	move.l	a0,-(a7)
	move.l	d7,-(a7)
	move.w	d6,-(a7)
	move.w	#$3f,-(a7)
	trap	#$1
	lea.l	$c(a7),a7
	tst.l	d0
	bpl.b	.l_1bb62
	bsr.w	T_1b6d0
	bra.w	T_1bc48
.l_1bb62:
	move.l	d0,B_60126
	bra.w	.l_1bc18
.l_1bb6c:
	move.w	#$0,-(a7)
	move.w	d6,-(a7)
	move.l	d4,-(a7)
	move.w	#$42,-(a7)
	trap	#$1
	lea.l	$a(a7),a7
	tst.l	d0
	bpl.b	.l_1bb8a
	bsr.w	T_1b6d0
	bra.w	T_1bc48
.l_1bb8a:
	move.l	#B_6012e,-(a7)
	move.l	#$8,-(a7)
	move.w	d6,-(a7)
	move.w	#$3f,-(a7)
	trap	#$1
	lea.l	$c(a7),a7
	tst.l	d0
	bpl.b	.l_1bbae
	bsr.w	T_1b6d0
	bra.w	T_1bc48
.l_1bbae:
	move.b	(a5),d0
	move.l	B_60132,d1
	andi.l	#$ffffff,d1
	addi.l	#$800,d1
	move.w	d5,d2
	jsr	File_allocate
	movea.l	a1,a4
	movea.l	a4,a0
	move.l	B_6012e,(a0)+
	move.l	B_60132,(a0)+
	move.l	d7,d0
	subq.l	#$8,d0
	move.l	a0,-(a7)
	move.l	d0,-(a7)
	move.w	d6,-(a7)
	move.w	#$3f,-(a7)
	trap	#$1
	lea.l	$c(a7),a7
	tst.l	d0
	bpl.b	.l_1bbf8
	bsr.w	T_1b6d0
	bra.b	T_1bc48
.l_1bbf8:
	movea.l	a4,a0
	bsr.w	T_1bde4
	movea.l	a4,a0
	move.l	B_60132,d0
	andi.l	#$ffffff,d0
	move.l	d0,B_60126
	jsr	Shrink_memory
.l_1bc18:
	move.w	d6,-(a7)
	move.w	#$3e,-(a7)
	trap	#$1
	addq.l	#$4,a7
	tst.l	d0
	bpl.b	.l_1bc2c
	bsr.w	T_1b6d0
	bra.b	T_1bc48
.l_1bc2c:
	jsr	Pop_Mptr
	move.w	sr,-(a7)
	ori.w	#$700,sr
	andi.b	#$df,$fffffa09.w
	move.w	(a7)+,sr
	movea.l	a4,a0
T_1bc42:
	movem.l	(a7)+,d0-d7/a1-a6
	rts
T_1bc48:
	tst.w	d6
	beq.b	.l_1bc56
	move.w	d6,-(a7)
	move.w	#$3e,-(a7)
	trap	#$1
	addq.l	#$4,a7
.l_1bc56:
	jsr	Pop_Mptr
	move.w	sr,-(a7)
	ori.w	#$700,sr
	andi.b	#$df,$fffffa09.w
	move.w	(a7)+,sr
	movem.l	(a7)+,d0-d7/a1-a6
	bra.w	Load_subfile
Save_subfile:
	movem.l	d0-d7/a0-a6,-(a7)
	subq.w	#$1,d0
	bpl.b	.l_1bc8a
	lea.l	D_54a55,a1
	jsr	DI_Error
	bra.w	T_1bdb4
.l_1bc8a:
	moveq	#0,d6
	move.w	d0,d5
	movea.l	a0,a5
	movea.l	a1,a4
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
	move.w	#$2,-(a7)
	move.l	a0,-(a7)
	move.w	#$3d,-(a7)
	trap	#$1
	addq.l	#$8,a7
	tst.l	d0
	bpl.b	.l_1bcce
	bsr.w	T_1b6d0
	bra.w	T_1bdba
.l_1bcce:
	move.w	d0,d6
	move.l	#B_60136,-(a7)
	move.l	#$326,-(a7)
	move.w	d6,-(a7)
	move.w	#$3f,-(a7)
	trap	#$1
	lea.l	$c(a7),a7
	tst.l	d0
	bpl.b	.l_1bcf4
	bsr.w	T_1b6d0
	bra.w	T_1bdba
.l_1bcf4:
	cmpi.l	#$414d4252,B_60136
	beq.b	.l_1bd10
	lea.l	D_54a7e,a1
	jsr	DI_Error
	bra.w	T_1bdb4
.l_1bd10:
	move.w	B_6013a,d4
	cmp.w	d4,d5
	bmi.b	.l_1bd2a
	lea.l	D_54ab8,a1
	jsr	DI_Error
	bra.w	T_1bdb4
.l_1bd2a:
	ext.l	d4
	lsl.l	#$2,d4
	addq.l	#$6,d4
	lea.l	B_6013c,a0
	move.w	d5,d0
	bra.b	T_1bd3c
T_1bd3a:
	add.l	(a0)+,d4
T_1bd3c:
	dbra	d0,T_1bd3a
	move.l	(a0),d7
	move.w	#$0,-(a7)
	move.w	d6,-(a7)
	move.l	d4,-(a7)
	move.w	#$42,-(a7)
	trap	#$1
	lea.l	$a(a7),a7
	tst.l	d0
	bpl.b	.l_1bd5e
	bsr.w	T_1b6d0
	bra.b	T_1bdba
.l_1bd5e:
	movea.l	a4,a0
	move.l	a0,-(a7)
	move.l	d7,-(a7)
	move.w	d6,-(a7)
	move.w	#$40,-(a7)
	trap	#$1
	lea.l	$c(a7),a7
	tst.l	d0
	bpl.b	.l_1bd7a
	bsr.w	T_1b6d0
	bra.b	T_1bdba
.l_1bd7a:
	cmp.l	d7,d0
	beq.b	.l_1bd8c
	lea.l	D_54ade,a1
	jsr	DI_Error
	bra.b	T_1bdba
.l_1bd8c:
	move.w	d6,-(a7)
	move.w	#$3e,-(a7)
	trap	#$1
	addq.l	#$4,a7
	tst.l	d0
	bpl.b	.l_1bda0
	bsr.w	T_1b6d0
	bra.b	T_1bdba
.l_1bda0:
	jsr	Pop_Mptr
	move.w	sr,-(a7)
	ori.w	#$700,sr
	andi.b	#$df,$fffffa09.w
	move.w	(a7)+,sr
T_1bdb4:
	movem.l	(a7)+,d0-d7/a0-a6
	rts
T_1bdba:
	tst.w	d6
	beq.b	.l_1bdc8
	move.w	d6,-(a7)
	move.w	#$3e,-(a7)
	trap	#$1
	addq.l	#$4,a7
.l_1bdc8:
	jsr	Pop_Mptr
	move.w	sr,-(a7)
	ori.w	#$700,sr
	andi.b	#$df,$fffffa09.w
	move.w	(a7)+,sr
	movem.l	(a7)+,d0-d7/a0-a6
	bra.w	Save_subfile
T_1bde4:
	movem.l	d0-d7/a0-a6,-(a7)
	move.l	#$800,d0
	bsr.w	.l_1bdf8
	movem.l	(a7)+,d0-d7/a0-a6
	rts
.l_1bdf8:
	lea.l	.l_1be16(pc),a2
	move.l	a0,$2(a2)
	move.l	d0,$e(a2)
	movea.l	a0,a1
	jsr	(a2)
	lea.l	.l_1be16(pc),a2
	movea.l	$2(a2),a0
	move.l	$6(a2),d0
	rts
.l_1be16:
	bra.b	T_1be3c
T_1be18:
	dc.b	$00,$00,$00,$00
T_1be1c:
	dc.b	$00,$00,$00,$00
T_1be20:
	dc.b	$00,$00,$00,$00
T_1be24:
	dc.b	$00,$00,$64,$00
T_1be28:
	dc.b	$00,$00,$00,$00,$08,$00,$3c,$00,$3c,$00,$00,$00,$00,$00,$03,$00
	dc.b	$00,$00,$00,$00
T_1be3c:
	lea.l	T_1be20(pc),a0
	move.l	(a1)+,(a0)
.l_1be42:
	beq.b	.l_1be5c
	moveq	#0,d0
	move.b	(a1),d0
	add.w	d0,d0
	move.w	T_1be28(pc,d0.w),d0
	bsr.b	.l_1be5e
	movea.l	T_1be18(pc),a1
	lea.l	T_1be20(pc),a0
	subq.b	#$1,(a0)
	bra.b	.l_1be42
.l_1be5c:
	rts
.l_1be5e:
	lea.l	T_1be1c(pc),a0
	move.l	(a1),d1
	andi.l	#$ffffff,d1
	move.l	d1,(a0)
	move.l	$4(a1),d2
	addq.l	#$8,d2
	add.l	d0,d2
	movea.l	T_1be18(pc),a0
	adda.l	T_1be24(pc),a0
	adda.l	d1,a0
	adda.l	d2,a1
.l_1be80:
	move.l	-(a1),-(a0)
	move.l	-(a1),-(a0)
	subq.l	#$8,d2
	bpl.b	.l_1be80
	suba.l	d2,a0
	movea.l	T_1be18(pc),a1
	cmpi.b	#$6,(a0)
	bne.w	.l_1bedc
	move.l	(a0)+,d0
	andi.l	#$ffffff,d0
	add.l	a1,d0
	addq.l	#$4,a0
	move.l	#$80,d1
.l_1bea8:
	add.b	d1,d1
	bne.b	.l_1beb0
	move.b	(a0)+,d1
	addx.b	d1,d1
.l_1beb0:
	bcc.b	.l_1beba
	move.b	(a0)+,(a1)+
	cmpa.l	d0,a1
	blt.b	.l_1bea8
	rts
.l_1beba:
	moveq	#0,d3
	move.b	(a0)+,d3
	move.b	d3,d2
	andi.w	#$f,d2
	lsl.w	#$4,d3
	move.b	(a0)+,d3
	movea.l	a1,a2
	suba.l	d3,a2
	move.b	(a2)+,(a1)+
	move.b	(a2)+,(a1)+
.l_1bed0:
	move.b	(a2)+,(a1)+
	dbra	d2,.l_1bed0
	cmpa.l	d0,a1
	blt.b	.l_1bea8
	rts
.l_1bedc:
	rts
