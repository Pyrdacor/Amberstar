; NUCLEUS/MEMORY.ASM (original module, merged with the disassembly of the shipped program)

; ---- Next_generation (original source: NUCLEUS/MEMORY.ASM)
Next_generation:
	movem.l	d0/d1/a0/a1,-(sp)
	lea.l	Memory_list,a0
	movea.l	Memlist_end,a1
	moveq.l	#$3f,d0
	bra.s	.Entry
.Loop:
	btst.b	#7,8(a0)
	beq.s	.Next
	move.b	d0,d1
	and.b	8(a0),d1
	beq.s	.Next
	moveq.l	#0,d1
	move.b	9(a0),d1
	subq.w	#8,d1
	bmi.s	.Next
	move.b	d1,9(a0)
.Next:
	lea.l	12(a0),a0
.Entry:
	cmpa.l	a1,a0
	bmi.s	.Loop
.Overflow:
	movem.l	(sp)+,d0/d1/a0/a1
	rts	
T_1d27a:
	move.l	a0,-(a7)
	lea.l	Memory_list,a0
	move.l	B_60a36,(a0)+
	move.l	B_60a3e,(a0)+
	move.l	#$80000000,(a0)+
	move.l	a0,Memlist_end
	move.l	B_60a3e,Size_of_free_memory
	movea.l	(a7)+,a0
	rts
Kill_memory:
	movem.l	d0/a1-a2,-(a7)
	lea.l	Memory_list,a1
	movea.l	Memlist_end,a2
	bra.b	T_1d2de
T_1d2ba:
	btst	#$7,$8(a1)
	bne.b	T_1d2da
	cmpa.l	(a1),a0
	bne.b	T_1d2da
	move.l	#$80000000,$8(a1)
	move.l	$4(a1),d0
	add.l	d0,Size_of_free_memory
	bra.b	T_1d2ee
T_1d2da:
	lea.l	$c(a1),a1
T_1d2de:
	cmpa.l	a2,a1
	bmi.b	T_1d2ba
	lea.l	D_55592,a1
	jsr	DI_Error
T_1d2ee:
	movem.l	(a7)+,d0/a1-a2
	rts
Free_memory:
	movem.l	d0/a1-a2,-(a7)
	lea.l	Memory_list,a1
	movea.l	Memlist_end,a2
	bra.b	T_1d328
T_1d306:
	btst	#$7,$8(a1)
	bne.b	T_1d324
	cmpa.l	(a1),a0
	bne.b	T_1d324
	bset	#$7,$8(a1)
	move.l	$4(a1),d0
	add.l	d0,Size_of_free_memory
	bra.b	T_1d338
T_1d324:
	lea.l	$c(a1),a1
T_1d328:
	cmpa.l	a2,a1
	bmi.b	T_1d306
	lea.l	D_555c1,a1
	jsr	DI_Error
T_1d338:
	movem.l	(a7)+,d0/a1-a2
	rts
Shrink_memory:
	movem.l	d0-d1/a0-a2,-(a7)
	addq.l	#$1,d0
	andi.b	#$fe,d0
	lea.l	Memory_list,a1
	movea.l	Memlist_end,a2
	bra.b	T_1d390
T_1d356:
	btst	#$7,$8(a1)
	bne.b	T_1d38c
	cmpa.l	(a1),a0
	bne.b	T_1d38c
	cmp.l	$4(a1),d0
	beq.b	T_1d3a0
	bmi.b	T_1d378
	lea.l	D_555f0,a1
	jsr	DI_Error
	bra.b	T_1d3a0
T_1d378:
	move.l	d0,d1
	movea.l	a1,a0
	bsr.w	T_1d532
	move.l	$10(a0),d0
	add.l	d0,Size_of_free_memory
	bra.b	T_1d3a0
T_1d38c:
	lea.l	$c(a1),a1
T_1d390:
	cmpa.l	a2,a1
	bmi.b	T_1d356
	lea.l	D_55619,a1
	jsr	DI_Error
T_1d3a0:
	movem.l	(a7)+,d0-d1/a0-a2
	rts
; ---- Reallocate_memory (original source: NUCLEUS/MEMORY.ASM)
Reallocate_memory:
	movem.l	d0-d2/a1,-(sp)
	lsl.w	#8,d0
	swap.w	d0
	move.w	d1,d0
	ori.l	#$80000000,d0	; CHANGE: added
	move.l	#$bf00ffff,d1	; CHANGE: was "move.l #$3f00ffff,d1"
	lea.l	Memory_list,a0
	movea.l	Memlist_end,a1
	bra.s	.Entry
.Loop:
	move.l	d1,d2
	and.l	8(a0),d2
	cmp.l	d0,d2
	beq.s	.Found
	lea.l	12(a0),a0
.Entry:
	cmpa.l	a1,a0
	bmi.s	.Loop
	suba.l	a0,a0
	bra.s	.Exit
.Found:
	bclr	#7,8(a0)
	move.l	4(a0),d0
	sub.l	d0,Size_of_free_memory
	ori.b	#7*8,9(a0)
	movea.l	(a0),a0
.Exit:
	movem.l	(sp)+,d0-d2/a1
	rts	
File_allocate:
	movem.l	d0-d3/d7/a0,-(a7)
	addq.l	#$1,d1
	andi.b	#$fe,d1
	cmp.l	Size_of_free_memory,d1
	bls.b	T_1d460
	lea.l	D_5564a,a1
	jsr	DI_Error
	bra.w	T_1d4a6
T_1d420:
	dc.b	$00,$00,$07,$01,$04,$00,$03,$03,$01,$00,$04,$02,$01,$01,$07,$02
	dc.b	$03,$01,$02,$03,$03,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
T_1d460:
	swap	d2
	move.b	d0,d2
	lsl.w	#$8,d2
	ext.w	d0
	move.b	T_1d420(pc,d0.w),d0
	ori.b	#$38,d0
	move.b	d0,d2
	swap	d2
	ext.w	d0
	bsr.w	T_1d510
	cmp.l	$4(a0),d1
	beq.b	T_1d49a
	move.l	d1,d0
	sub.l	$4(a0),d1
	neg.l	d1
	bsr.w	T_1d532
	move.l	#$80000000,$8(a0)
	move.l	d0,d1
	lea.l	$c(a0),a0
T_1d49a:
	move.l	d2,$8(a0)
	sub.l	d1,Size_of_free_memory
	movea.l	(a0),a1
T_1d4a6:
	movem.l	(a7)+,d0-d3/d7/a0
	rts
Allocate_memory:
	movem.l	d0-d1/d7/a0,-(a7)
	move.l	d0,d1
	addq.l	#$1,d1
	andi.b	#$fe,d1
	cmp.l	Size_of_free_memory,d1
	bls.b	T_1d4ce
	lea.l	D_55671,a1
	jsr	DI_Error
	bra.b	T_1d4e8
T_1d4ce:
	bsr.w	T_1d4ee
	cmp.l	$4(a0),d1
	beq.b	T_1d4dc
	bsr.w	T_1d532
T_1d4dc:
	clr.l	$8(a0)
T_1d4e0:
	sub.l	d1,Size_of_free_memory
	movea.l	(a0),a1
T_1d4e8:
	movem.l	(a7)+,d0-d1/d7/a0
	rts
T_1d4ee:
	move.l	d0,-(a7)
	moveq	#0,d0
T_1d4f2:
	bsr.w	Connect_memory
	bsr.w	Find_free_memory
	cmpa.l	#$0,a0
	bne.b	T_1d50c
	addq.b	#$1,d0
	bne.b	T_1d4f2
	jmp	T_1a214
T_1d50c:
	move.l	(a7)+,d0
	rts
T_1d510:
	move.l	d0,-(a7)
	moveq	#0,d0
T_1d514:
	bsr.w	Connect_memory
	bsr.w	T_1d58e
	cmpa.l	#$0,a0
	bne.b	T_1d52e
	addq.b	#$1,d0
	bne.b	T_1d514
	jmp	T_1a214
T_1d52e:
	move.l	(a7)+,d0
	rts
T_1d532:
	lea.l	$c(a0),a0
	bsr.w	Insert_memblock
	move.l	-$c(a0),(a0)
	move.l	-$8(a0),$4(a0)
	move.l	#$80000000,$8(a0)
	add.l	d1,(a0)
	sub.l	d1,$4(a0)
	lea.l	-$c(a0),a0
	move.l	d1,$4(a0)
	rts
; ---- Find_free_memory (original source: NUCLEUS/MEMORY.ASM)
Find_free_memory:
	move.l	a1,-(sp)
	lea.l	Memory_list,a0
	movea.l	Memlist_end,a1
	bra.s	.Entry
.Loop:
	btst	#7,8(a0)
	beq.s	.Next
	cmp.b	9(a0),d0
	bmi.s	.Next
	cmp.l	4(a0),d1
	bls.s	.Exit
.Next:
	lea.l	12(a0),a0
.Entry:
	cmpa.l	a1,a0
	bmi.s	.Loop
	suba.l	a0,a0
.Exit:
	movea.l	(sp)+,a1
	rts	
T_1d58e:
	move.l	a1,-(a7)
	movea.l	Memlist_end,a0
	lea.l	Memory_list,a1
	bra.b	T_1d5b2
T_1d59e:
	btst	#$7,$8(a0)
	beq.b	T_1d5b2
	cmp.b	$9(a0),d0
	bmi.b	T_1d5b2
	cmp.l	$4(a0),d1
	bls.b	T_1d5bc
T_1d5b2:
	lea.l	-$c(a0),a0
	cmpa.l	a0,a1
	bls.b	T_1d59e
	suba.l	a0,a0
T_1d5bc:
	movea.l	(a7)+,a1
	rts
; ---- Connect_memory (original source: NUCLEUS/MEMORY.ASM)
Connect_memory:
	movem.l	d0/d1/a0/a1,-(sp)
	lea.l	Memory_list,a0
	bra.s	.Entry1
.Loop1:
	btst	#7,8(a0)
	beq.s	.Next1
	cmp.b	9(a0),d0
	bmi.s	.Next1
	moveq.l	#-1,d1
	lea.l	12(a0),a1
	bra.s	.Entry2
.Loop2:
	addq.w	#1,d1
	btst	#7,8(a1)
	beq.s	.End2
	cmp.b	9(a1),d0
	bmi.s	.End2
	lea.l	12(a1),a1
.Entry2:
	cmpa.l	Memlist_end,a1
	bmi.s	.Loop2
.End2:
	tst.w	d1
	beq.s	.Next1
	move.l	a1,-(sp)
	move.l	4(a0),d1
	bra.s	.Entry3
.Loop3:
	add.l	4(a1),d1
.Entry3:
	lea.l	-12(a1),a1
	cmpa.l	a0,a1
	bhi.s	.Loop3
.End3:
	move.l	d1,4(a0)
	move.l	#$80000000,$8(a0)	; CHANGE: was "move.w #$8000,8(a0)"
	lea.l	12(a0),a0
	movea.l	(sp)+,a1
	bsr.w	Delete_memblocks
	bra.s	.Entry1
.Next1:
	lea.l	12(a0),a0
.Entry1:
	cmpa.l	Memlist_end,a0
	bmi.s	.Loop1
	movem.l	(sp)+,d0/d1/a0/a1
	rts	
; ---- Insert_memblock (original source: NUCLEUS/MEMORY.ASM)
Insert_memblock:
	movem.l	d0/d1/a1,-(sp)
	movea.l	Memlist_end,a1
	bra.s	.Entry
.Loop:
	move.l	-(a1),12(a1)
	move.l	-(a1),12(a1)
	move.l	-(a1),12(a1)
.Entry:
	cmpa.l	a0,a1
	bpl.s	.Loop
	addi.l	#12,Memlist_end
	movem.l	(sp)+,d0/d1/a1
	rts	
; ---- Delete_memblocks (original source: NUCLEUS/MEMORY.ASM)
Delete_memblocks:
	movem.l	d0/d1/a0-a2,-(sp)
	movea.l	Memlist_end,a2
	move.l	a1,d0
	sub.l	a0,d0
	bls.s	.Exit
	sub.l	d0,Memlist_end
	bra.s	.Entry
.Again:
	move.l	(a1)+,(a0)+
	move.l	(a1)+,(a0)+
	move.l	(a1)+,(a0)+
.Entry:
	cmpa.l	a2,a1
	bmi.s	.Again
.Exit:
	movem.l	(sp)+,d0/d1/a0-a2
	rts	
