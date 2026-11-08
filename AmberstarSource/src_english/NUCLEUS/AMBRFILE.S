; NUCLEUS/AMBRFILE.ASM (original module, merged with the disassembly of the shipped program)

	section	text

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
	bsr.w	T_1b6e4
	movea.l	a5,a0
	addq.l	#$1,a0
	move.w	#$0,-(a7)
	move.l	a0,-(a7)
	move.w	#$3c,-(a7)
	trap	#$1
	addq.l	#$8,a7
	tst.l	d0
	bpl.b	.l_1b8d8
	bsr.w	T_1b6ce
	bra.b	.l_1b936
.l_1b8d8:
	move.l	d0,d6
	movea.l	a4,a0
	move.l	a0,-(a7)
	move.l	d7,-(a7)
	move.w	d6,-(a7)
	move.w	#$40,-(a7)
	trap	#$1
	lea.l	$c(a7),a7
	tst.l	d0
	bpl.b	.l_1b8f6
	bsr.w	T_1b6ce
	bra.b	.l_1b936
.l_1b8f6:
	cmp.l	d7,d0
	beq.b	.l_1b908
	lea.l	D_51984,a1
	jsr	DI_Error
	bra.b	.l_1b936
.l_1b908:
	move.w	d6,-(a7)
	move.w	#$3e,-(a7)
	trap	#$1
	addq.l	#$4,a7
	tst.l	d0
	bpl.b	.l_1b91c
	bsr.w	T_1b6ce
	bra.b	.l_1b936
.l_1b91c:
	move.w	sr,-(a7)
	ori.w	#$700,sr
	andi.b	#$df,$fffffa09.w
	move.w	(a7)+,sr
	jsr	Pop_Mptr
	movem.l	(a7)+,d0-d7/a0-a6
	rts
.l_1b936:
	tst.w	d6
	beq.b	.l_1b944
	move.w	d6,-(a7)
	move.w	#$3e,-(a7)
	trap	#$1
	addq.l	#$4,a7
.l_1b944:
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
	bsr.w	T_1b6e4
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
.l_1b9d6:
	lea.l	B_5d42a,a5
	move.w	d7,-(a7)
	move.l	a5,-(a7)
	move.w	#$36,-(a7)
	trap	#$1
	addq.l	#$8,a7
	tst.l	d0
	beq.b	.l_1b9f4
	jsr	T_1a10c
	bra.b	.l_1b9d6
.l_1b9f4:
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
	bpl.b	.l_1ba34
	lea.l	D_519a3,a1
	jsr	DI_Error
	bra.w	T_1bc40
.l_1ba34:
	moveq	#0,d6
	move.w	d0,d5
	movea.l	a0,a5
	move.b	(a0)+,d0
	move.w	d5,d1
	jsr	Reallocate_memory
	cmpa.l	#$0,a0
	bne.w	T_1bc40
	move.w	sr,-(a7)
	ori.w	#$700,sr
	ori.b	#$20,$fffffa09.w
	move.w	(a7)+,sr
	move.w	#$f,d0
	jsr	Push_Mptr
	movea.l	a5,a0
	bsr.w	T_1b6e4
	movea.l	a5,a0
	addq.l	#$1,a0
	move.w	#$0,-(a7)
	move.l	a0,-(a7)
	move.w	#$3d,-(a7)
	trap	#$1
	addq.l	#$8,a7
	tst.l	d0
	bpl.b	.l_1ba8a
	bsr.w	T_1b6ce
	bra.w	T_1bc46
.l_1ba8a:
	move.w	d0,d6
	move.l	#B_5d104,-(a7)
	move.l	#$326,-(a7)
	move.w	d6,-(a7)
	move.w	#$3f,-(a7)
	trap	#$1
	lea.l	$c(a7),a7
	tst.l	d0
	bpl.b	.l_1bab0
	bsr.w	T_1b6ce
	bra.w	T_1bc46
.l_1bab0:
	cmpi.l	#$414d4252,B_5d104
	beq.b	.l_1bad8
	cmpi.l	#$414d5043,B_5d104
	beq.b	.l_1bad8
	lea.l	D_519cc,a1
	jsr	DI_Error
	bra.w	T_1bc40
.l_1bad8:
	move.w	B_5d108,d4
	cmp.w	d4,d5
	bmi.b	.l_1baf2
	lea.l	D_519fd,a1
	jsr	DI_Error
	bra.w	T_1bc40
.l_1baf2:
	ext.l	d4
	lsl.l	#$2,d4
	addq.l	#$6,d4
	lea.l	B_5d10a,a0
	move.w	d5,d0
	bra.b	T_1bb04
T_1bb02:
	add.l	(a0)+,d4
T_1bb04:
	dbra	d0,T_1bb02
	move.l	(a0),d7
	cmpi.l	#$414d4252,B_5d104
	bne.b	.l_1bb6a
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
	bpl.b	.l_1bb42
	bsr.w	T_1b6ce
	bra.w	T_1bc46
.l_1bb42:
	movea.l	a4,a0
	move.l	a0,-(a7)
	move.l	d7,-(a7)
	move.w	d6,-(a7)
	move.w	#$3f,-(a7)
	trap	#$1
	lea.l	$c(a7),a7
	tst.l	d0
	bpl.b	.l_1bb60
	bsr.w	T_1b6ce
	bra.w	T_1bc46
.l_1bb60:
	move.l	d0,B_5d0f4
	bra.w	.l_1bc16
.l_1bb6a:
	move.w	#$0,-(a7)
	move.w	d6,-(a7)
	move.l	d4,-(a7)
	move.w	#$42,-(a7)
	trap	#$1
	lea.l	$a(a7),a7
	tst.l	d0
	bpl.b	.l_1bb88
	bsr.w	T_1b6ce
	bra.w	T_1bc46
.l_1bb88:
	move.l	#B_5d0fc,-(a7)
	move.l	#$8,-(a7)
	move.w	d6,-(a7)
	move.w	#$3f,-(a7)
	trap	#$1
	lea.l	$c(a7),a7
	tst.l	d0
	bpl.b	.l_1bbac
	bsr.w	T_1b6ce
	bra.w	T_1bc46
.l_1bbac:
	move.b	(a5),d0
	move.l	B_5d100,d1
	andi.l	#$ffffff,d1
	addi.l	#$800,d1
	move.w	d5,d2
	jsr	File_allocate
	movea.l	a1,a4
	movea.l	a4,a0
	move.l	B_5d0fc,(a0)+
	move.l	B_5d100,(a0)+
	move.l	d7,d0
	subq.l	#$8,d0
	move.l	a0,-(a7)
	move.l	d0,-(a7)
	move.w	d6,-(a7)
	move.w	#$3f,-(a7)
	trap	#$1
	lea.l	$c(a7),a7
	tst.l	d0
	bpl.b	.l_1bbf6
	bsr.w	T_1b6ce
	bra.b	T_1bc46
.l_1bbf6:
	movea.l	a4,a0
	bsr.w	T_1bde2
	movea.l	a4,a0
	move.l	B_5d100,d0
	andi.l	#$ffffff,d0
	move.l	d0,B_5d0f4
	jsr	Shrink_memory
.l_1bc16:
	move.w	d6,-(a7)
	move.w	#$3e,-(a7)
	trap	#$1
	addq.l	#$4,a7
	tst.l	d0
	bpl.b	.l_1bc2a
	bsr.w	T_1b6ce
	bra.b	T_1bc46
.l_1bc2a:
	jsr	Pop_Mptr
	move.w	sr,-(a7)
	ori.w	#$700,sr
	andi.b	#$df,$fffffa09.w
	move.w	(a7)+,sr
	movea.l	a4,a0
T_1bc40:
	movem.l	(a7)+,d0-d7/a1-a6
	rts
T_1bc46:
	tst.w	d6
	beq.b	.l_1bc54
	move.w	d6,-(a7)
	move.w	#$3e,-(a7)
	trap	#$1
	addq.l	#$4,a7
.l_1bc54:
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
	bpl.b	.l_1bc88
	lea.l	D_51a23,a1
	jsr	DI_Error
	bra.w	T_1bdb2
.l_1bc88:
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
	bsr.w	T_1b6e4
	movea.l	a5,a0
	addq.l	#$1,a0
	move.w	#$2,-(a7)
	move.l	a0,-(a7)
	move.w	#$3d,-(a7)
	trap	#$1
	addq.l	#$8,a7
	tst.l	d0
	bpl.b	.l_1bccc
	bsr.w	T_1b6ce
	bra.w	T_1bdb8
.l_1bccc:
	move.w	d0,d6
	move.l	#B_5d104,-(a7)
	move.l	#$326,-(a7)
	move.w	d6,-(a7)
	move.w	#$3f,-(a7)
	trap	#$1
	lea.l	$c(a7),a7
	tst.l	d0
	bpl.b	.l_1bcf2
	bsr.w	T_1b6ce
	bra.w	T_1bdb8
.l_1bcf2:
	cmpi.l	#$414d4252,B_5d104
	beq.b	.l_1bd0e
	lea.l	D_51a4c,a1
	jsr	DI_Error
	bra.w	T_1bdb2
.l_1bd0e:
	move.w	B_5d108,d4
	cmp.w	d4,d5
	bmi.b	.l_1bd28
	lea.l	D_51a86,a1
	jsr	DI_Error
	bra.w	T_1bdb2
.l_1bd28:
	ext.l	d4
	lsl.l	#$2,d4
	addq.l	#$6,d4
	lea.l	B_5d10a,a0
	move.w	d5,d0
	bra.b	T_1bd3a
T_1bd38:
	add.l	(a0)+,d4
T_1bd3a:
	dbra	d0,T_1bd38
	move.l	(a0),d7
	move.w	#$0,-(a7)
	move.w	d6,-(a7)
	move.l	d4,-(a7)
	move.w	#$42,-(a7)
	trap	#$1
	lea.l	$a(a7),a7
	tst.l	d0
	bpl.b	.l_1bd5c
	bsr.w	T_1b6ce
	bra.b	T_1bdb8
.l_1bd5c:
	movea.l	a4,a0
	move.l	a0,-(a7)
	move.l	d7,-(a7)
	move.w	d6,-(a7)
	move.w	#$40,-(a7)
	trap	#$1
	lea.l	$c(a7),a7
	tst.l	d0
	bpl.b	.l_1bd78
	bsr.w	T_1b6ce
	bra.b	T_1bdb8
.l_1bd78:
	cmp.l	d7,d0
	beq.b	.l_1bd8a
	lea.l	D_51aac,a1
	jsr	DI_Error
	bra.b	T_1bdb8
.l_1bd8a:
	move.w	d6,-(a7)
	move.w	#$3e,-(a7)
	trap	#$1
	addq.l	#$4,a7
	tst.l	d0
	bpl.b	.l_1bd9e
	bsr.w	T_1b6ce
	bra.b	T_1bdb8
.l_1bd9e:
	jsr	Pop_Mptr
	move.w	sr,-(a7)
	ori.w	#$700,sr
	andi.b	#$df,$fffffa09.w
	move.w	(a7)+,sr
T_1bdb2:
	movem.l	(a7)+,d0-d7/a0-a6
	rts
T_1bdb8:
	tst.w	d6
	beq.b	.l_1bdc6
	move.w	d6,-(a7)
	move.w	#$3e,-(a7)
	trap	#$1
	addq.l	#$4,a7
.l_1bdc6:
	jsr	Pop_Mptr
	move.w	sr,-(a7)
	ori.w	#$700,sr
	andi.b	#$df,$fffffa09.w
	move.w	(a7)+,sr
	movem.l	(a7)+,d0-d7/a0-a6
	bra.w	Save_subfile
T_1bde2:
	movem.l	d0-d7/a0-a6,-(a7)
	move.l	#$800,d0
	bsr.w	.l_1bdf6
	movem.l	(a7)+,d0-d7/a0-a6
	rts
.l_1bdf6:
	lea.l	.l_1be14(pc),a2
	move.l	a0,$2(a2)
	move.l	d0,$e(a2)
	movea.l	a0,a1
	jsr	(a2)
	lea.l	.l_1be14(pc),a2
	movea.l	$2(a2),a0
	move.l	$6(a2),d0
	rts
.l_1be14:
	bra.b	T_1be3a
T_1be16:
	dc.b	$00,$00,$00,$00
T_1be1a:
	dc.b	$00,$00,$00,$00
T_1be1e:
	dc.b	$00,$00,$00,$00
T_1be22:
	dc.b	$00,$00,$64,$00
T_1be26:
	dc.b	$00,$00,$00,$00,$08,$00,$3c,$00,$3c,$00,$00,$00,$00,$00,$03,$00
	dc.b	$00,$00,$00,$00
T_1be3a:
	lea.l	T_1be1e(pc),a0
	move.l	(a1)+,(a0)
.l_1be40:
	beq.b	.l_1be5a
	moveq	#0,d0
	move.b	(a1),d0
	add.w	d0,d0
	move.w	T_1be26(pc,d0.w),d0
	bsr.b	.l_1be5c
	movea.l	T_1be16(pc),a1
	lea.l	T_1be1e(pc),a0
	subq.b	#$1,(a0)
	bra.b	.l_1be40
.l_1be5a:
	rts
.l_1be5c:
	lea.l	T_1be1a(pc),a0
	move.l	(a1),d1
	andi.l	#$ffffff,d1
	move.l	d1,(a0)
	move.l	$4(a1),d2
	addq.l	#$8,d2
	add.l	d0,d2
	movea.l	T_1be16(pc),a0
	adda.l	T_1be22(pc),a0
	adda.l	d1,a0
	adda.l	d2,a1
.l_1be7e:
	move.l	-(a1),-(a0)
	move.l	-(a1),-(a0)
	subq.l	#$8,d2
	bpl.b	.l_1be7e
	suba.l	d2,a0
	movea.l	T_1be16(pc),a1
	cmpi.b	#$6,(a0)
	bne.w	.l_1beda
	move.l	(a0)+,d0
	andi.l	#$ffffff,d0
	add.l	a1,d0
	addq.l	#$4,a0
	move.l	#$80,d1
.l_1bea6:
	add.b	d1,d1
	bne.b	.l_1beae
	move.b	(a0)+,d1
	addx.b	d1,d1
.l_1beae:
	bcc.b	.l_1beb8
	move.b	(a0)+,(a1)+
	cmpa.l	d0,a1
	blt.b	.l_1bea6
	rts
.l_1beb8:
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
.l_1bece:
	move.b	(a2)+,(a1)+
	dbra	d2,.l_1bece
	cmpa.l	d0,a1
	blt.b	.l_1bea6
	rts
.l_1beda:
	rts
