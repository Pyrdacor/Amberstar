; NUCLEUS/COLOFADE.ASM (original module, merged with the disassembly of the shipped program)

; ---- Fade_pal (original source: NUCLEUS/COLOFADE.ASM)
Fade_pal:
	movem.l	d0/d1/d5-d7/a0/a1,-(sp)
	move.w	#$777,d5
	moveq.l	#0,d6
	moveq.l	#16-1,d7
.Loop:
	move.w	(a0),d0
	move.w	(a1),d1
	and.w	d5,d0
	and.w	d5,d1
	cmp.w	d0,d1
	beq.s	.Next
	jsr	(a2)
	move.w	d0,(a0)
	addq.w	#1,d6
.Next:
	addq.l	#2,a0
	addq.l	#2,a1
	dbra	d7,.Loop
	tst.w	d6
	movem.l	(sp)+,d0/d1/d5-d7/a0/a1
	rts	
; ---- List_fade (original source: NUCLEUS/COLOFADE.ASM)
List_fade:
	movem.l	d0-d3/d5/a0/a1,-(sp)
	moveq.l	#0,d3
	move.w	#$777,d5
.Again:
	tst.w	(a0)
	beq.s	.End
	tst.b	1(a0)
	bne.s	.Single
	addq.l	#2,a0
	bsr.w	Fade_pal
	sne	d2
	sub.b	d2,d3
	lea.l	32(a0),a0
	lea.l	32(a1),a1
	bra.s	.Again
.Single:
	move.w	4(a0),d0
	move.w	(a1)+,d1
	cmp.w	d0,d1
	beq.s	.Equal
	and.w	d5,d0
	and.w	d5,d1
	jsr	(a2)
	sne	d2
	sub.b	d2,d3
	move.w	d0,4(a0)
.Equal:
	addq.l	#6,a0
	bra.s	.Again
.End:
	tst.w	d3
	movem.l	(sp)+,d0-d3/d5/a0/a1
	rts	
; ---- Hbl_outfade (original source: NUCLEUS/COLOFADE.ASM)
Hbl_outfade:
	movem.l	d0-d3/d5/a0/a1,-(sp)
	move.w	(a1),d1
	moveq.l	#0,d3
	move.w	#$777,d5
.Again:
	tst.w	(a0)
	beq.s	.End
	tst.b	1(a0)
	bne.s	.Single
	addq.l	#2,a0
	bsr.w	Fade_pal
	sne	d2
	sub.b	d2,d3
	lea.l	32(a0),a0
	bra.s	.Again
.Single:
	move.w	4(a0),d0
	cmp.w	d0,d1
	beq.s	.Equal
	and.w	d5,d0
	jsr	(a2)
	sne	d2
	sub.b	d2,d3
	move.w	d0,4(a0)
.Equal:
	addq.l	#6,a0
	bra.s	.Again
.End:
	tst.w	d3
	movem.l	(sp)+,d0-d3/d5/a0/a1
	rts	
; ---- Hbl_fade (original source: NUCLEUS/COLOFADE.ASM)
Hbl_fade:
	movem.l	d0-d3/d5/a0/a1,-(sp)
	moveq.l	#0,d3
	move.w	#$777,d5
.Again:
	tst.w	(a0)
	beq.s	.End
	tst.b	1(a0)
	bne.s	.Single
	addq.l	#2,a0
	addq.l	#2,a1
	bsr.w	Fade_pal
	sne	d2
	sub.b	d2,d3
	lea.l	32(a0),a0
	lea.l	32(a1),a1
	bra.s	.Again
.Single:
	move.w	4(a0),d0
	move.w	4(a1),d1
	cmp.w	d0,d1
	beq.s	.Equal
	and.w	d5,d0
	and.w	d5,d1
	jsr	(a2)
	sne	d2
	sub.b	d2,d3
	move.w	d0,4(a0)
.Equal:
	addq.l	#6,a0
	addq.l	#6,a1
	bra.s	.Again
.End:
	tst.w	d3
	movem.l	(sp)+,d0-d3/d5/a0/a1
	rts	
Subfade1:
	movem.l	d2-d3,-(a7)
	move.w	#$700,d2
	move.w	d2,d3
	and.w	d0,d2
	and.w	d1,d3
	cmp.w	d2,d3
	beq.b	.l_1c00c
	bpl.b	.l_1c008
	subi.w	#$100,d0
	bra.b	.l_1c00c
.l_1c008:
	dc.b	$06,$40,$01,$00
.l_1c00c:
	move.w	#$70,d2
	move.w	d2,d3
	and.w	d0,d2
	and.w	d1,d3
	cmp.w	d2,d3
	beq.b	.l_1c026
	bpl.b	.l_1c022
	subi.w	#$10,d0
	bra.b	.l_1c026
.l_1c022:
	dc.b	$06,$40,$00,$10
.l_1c026:
	move.w	#$7,d2
	move.w	d2,d3
	and.w	d0,d2
	and.w	d1,d3
	cmp.w	d2,d3
	beq.b	.l_1c03c
	bpl.b	.l_1c03a
	subq.w	#$1,d0
	bra.b	.l_1c03c
.l_1c03a:
	dc.b	$52,$40
.l_1c03c:
	movem.l	(a7)+,d2-d3
	rts
Subfade2:
	movem.l	d2-d3,-(a7)
	move.w	#$700,d2
	move.w	d2,d3
	and.w	d0,d2
	and.w	d1,d3
	cmp.w	d2,d3
	beq.b	.l_1c062
	bpl.b	.l_1c05c
	subi.w	#$100,d0
	bra.b	.l_1c094
.l_1c05c:
	addi.w	#$100,d0
	bra.b	.l_1c094
.l_1c062:
	move.w	#$70,d2
	move.w	d2,d3
	and.w	d0,d2
	and.w	d1,d3
	cmp.w	d2,d3
	beq.b	.l_1c07e
	bpl.b	.l_1c078
	subi.w	#$10,d0
	bra.b	.l_1c094
.l_1c078:
	addi.w	#$10,d0
	bra.b	.l_1c094
.l_1c07e:
	move.w	#$7,d2
	move.w	d2,d3
	and.w	d0,d2
	and.w	d1,d3
	cmp.w	d2,d3
	beq.b	.l_1c094
	bpl.b	.l_1c092
	subq.w	#$1,d0
	bra.b	.l_1c094
.l_1c092:
	dc.b	$52,$40
.l_1c094:
	movem.l	(a7)+,d2-d3
	rts
