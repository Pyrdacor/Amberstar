; NUCLEUS/INTROUTS.ASM (original module, merged with the disassembly of the shipped program)

	section	text

Restore_computer:
	movem.l	d0-d7/a0,-(a7)
	move.w	sr,-(a7)
	ori.w	#$700,sr
	lea.l	Old_MFP,a0
	move.b	(a0)+,$fffffa07.w
	move.b	(a0)+,$fffffa09.w
	move.b	(a0)+,$fffffa0b.w
	move.b	(a0)+,$fffffa0d.w
	move.b	(a0)+,$fffffa13.w
	move.b	(a0)+,$fffffa15.w
	move.b	(a0)+,$fffffa17.w
	move.b	(a0)+,$fffffa1b.w
	move.b	(a0)+,$fffffa21.w
	move.b	(a0)+,$fffffa1d.w
	move.b	(a0)+,$fffffa25.w
	move.l	T_1cbda,$114.w
	move.l	B_608aa,$110.w
	move.l	T_1cbd0,$118.w
	move.l	T_1cc22,$70.w
	move.w	Old_nvbls,$454.w
	move.l	Old_dump_vec,$502.w
	move.b	Old_conterm,$484.w
	movea.l	KBD_vec,a0
	move.l	Old_mouse_vec,$10(a0)
	move.w	(a7)+,sr
	move.w	#$25,-(a7)
	trap	#$e
	addq.l	#$2,a7
	move.b	Old_rez,$ffff8260.w
	movem.l	B_608b0,d0-d7
	movem.l	d0-d7,$ffff8240.w
	lea.l	$ffff8201.w,a0
	move.w	Old_screen,d0
	movep.w	d0,$0(a0)
	move.l	B_6089a,$404.w
	movem.l	(a7)+,d0-d7/a0
	rts
; The shipped program also sets the vector of timer D for the music (My_timer_D).
Init_computer:
	movem.l	d0-d7/a0,-(a7)
	move.l	#T_1ccae,$404.w
	move.w	sr,-(a7)
	ori.w	#$700,sr
	lea.l	$fffffa00.w,a0
	move.w	#$170,d0
	movep.w	d0,$7(a0)
	movep.w	d0,$13(a0)
	move.b	#$0,$fffffa0b.w
	move.b	#$0,$fffffa0d.w
	move.b	#$48,$fffffa17.w
	move.b	#$0,$fffffa1b.w
	andi.b	#$f0,$fffffa1d.w
	move.l	#My_timer_C,$114.w
	move.l	#My_timer_D,$110.w
	move.l	#My_mkb,$118.w
	move.l	#My_vbi,$70.w
	clr.w	$454.w
	move.l	#Dummy,$502.w
	move.b	#$8,$484.w
	movea.l	KBD_vec,a0
	move.l	#My_mouse,$10(a0)
	move.w	(a7)+,sr
	move.w	#$25,-(a7)
	trap	#$e
	addq.l	#$2,a7
	move.b	#$0,$ffff8260.w
	jsr	Init_screen
	movem.l	(a7)+,d0-d7/a0
; ---- Dummy (original source: NUCLEUS/INTROUTS.ASM)
Dummy:
	rts	
; ---- My_mkb (original source: NUCLEUS/INTROUTS.ASM)
My_mkb:
	move.w	#$2500,sr
; ---- Old_mkb (original source: NUCLEUS/INTROUTS.ASM)
Old_mkb:
	jmp	$fc0000
; ---- My_timer_C (original source: NUCLEUS/INTROUTS.ASM)
My_timer_C:
	move.w	#$2500,sr
; ---- Old_timer_C (original source: NUCLEUS/INTROUTS.ASM)
Old_timer_C:
	jmp	$fc0000
; Timer D interrupt of the music (set by Play_song to 50 Hz): calls Coso_interrupt.
My_timer_D:
	move.w	#$2500,sr
	tst.w	Music_block
	bne.b	.l_1cc06
	andi.b	#$f0,$fffffa1d.w
	movem.l	d0-d7/a0-a6,-(a7)
	moveq	#1,d1
	jsr	Coso_interrupt
	movem.l	(a7)+,d0-d7/a0-a6
	ori.b	#$7,$fffffa1d.w
.l_1cc06:
	bclr	#$4,$fffffa11.w
	rte
My_vbi:
	dc.b	$4e,$b9
	dc.l	HBL_handler
	dc.b	$52,$79
	dc.l	B_608e2
	dc.b	$4e,$b9
	dc.l	VblQ_handler
; ---- Old_vbi (original source: NUCLEUS/INTROUTS.ASM)
Old_vbi:
	jmp	$fc0000
; ---- IFF_pal_convert (original source: NUCLEUS/INTROUTS.ASM)
IFF_pal_convert:
	movem.l	d0/d7/a0/a1,-(sp)
	move.w	(a0)+,d7
	subq.w	#1,d7
.Loop:
	move.w	(a0)+,d0
	lsl.w	#8,d0
	move.b	(a0)+,d0
	lsl.b	#4,d0
	or.b	(a0)+,d0
	move.w	d0,(a1)+
	dbra	d7,.Loop
	movem.l	(sp)+,d0/d7/a0/a1
	rts	
Random:
	movem.l	d1-d5,-(a7)
	move.l	B_60896,d0
	bne.b	.l_1cc5e
	move.l	$466.w,d0
	lsl.l	#$2,d0
	asl.l	#$8,d0
	asl.l	#$8,d0
	or.w	$466.w,d0
.l_1cc5e:
	move.l	#$bb40e62d,d1
	bsr.w	.l_1cc76
	addq.l	#$1,d0
	move.l	d0,B_60896
	movem.l	(a7)+,d1-d5
	rts
.l_1cc76:
	moveq	#0,d2
	tst.l	d0
	bge.b	.l_1cc80
	neg.l	d0
	addq.w	#$1,d2
.l_1cc80:
	tst.l	d1
	bge.b	.l_1cc88
	neg.l	d1
	addq.w	#$1,d2
.l_1cc88:
	move.w	d0,d3
	mulu.w	d1,d3
	move.w	d0,d5
	swap	d0
	move.w	d0,d4
	mulu.w	d1,d4
	swap	d1
	mulu.w	d1,d5
	add.w	d5,d4
	swap	d3
	add.w	d3,d4
	move.w	d4,d3
	swap	d3
	move.l	d3,d0
	btst	#$0,d2
	beq.b	.l_1ccac
	neg.l	d0
.l_1ccac:
	rts
T_1ccae:
	move.l	$4(a7),d0
	swap	d0
	ext.l	d0
	rts
T_1ccb8:
	movem.l	d0-d3/a0-a3,-(a7)
.l_1ccbc:
	move.w	#$b,-(a7)
	trap	#$1
	addq.l	#$2,a7
	tst.l	d0
	beq.b	.l_1ccd2
	move.w	#$7,-(a7)
	trap	#$1
	addq.l	#$2,a7
	bra.b	.l_1ccbc
.l_1ccd2:
	movem.l	(a7)+,d0-d3/a0-a3
	rts

	section	bss

Old_nvbls:
	ds.b	2
Old_dump_vec:
	ds.b	4
Old_conterm:
	ds.b	2
Old_mouse_vec:
	ds.b	4
B_608aa:
	ds.b	4
Old_rez:
	ds.b	2
B_608b0:
	ds.b	32
Old_screen:
	ds.b	2
Old_MFP:
	ds.b	12
KBD_vec:
	ds.b	4
B_608e2:
	ds.b	2
MA_Stack:
	ds.b	64
