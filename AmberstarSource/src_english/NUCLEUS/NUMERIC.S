; NUCLEUS/NUMERIC.ASM (original module, merged with the disassembly of the shipped program)

; ---- Hex_convert (original source: NUCLEUS/NUMERIC.ASM)
Hex_convert:
	movem.l	d0/d1/d7,-(sp)
	lea.l	Output_string,a0
	move.l	#"    ",(a0)
	move.l	#"    ",4(a0)
	move.l	#"    ",8(a0)
	adda.w	d7,a0
	move.b	#" ",(a0)
	move.b	#" ",1(a0)
	move.b	#0,2(a0)
	subq.w	#1,d7
.Loop:
	moveq.l	#$f,d1
	and.w	d0,d1
	cmpi.w	#$a,d1
	bmi.s	.No_letter
	addi.w	#"A"-10,d1
	bra.s	.Skip
.No_letter:
	addi.w	#"0",d1
.Skip:
	move.b	d1,-(a0)
	ror.l	#4,d0
	dbra	d7,.Loop
	lea.l	Output_string,a0
	movem.l	(sp)+,d0/d1/d7
	rts	
Dec_convert:
	movem.l	d0-d3/d7/a1,-(a7)
	cmpi.w	#$b,d7
	bmi.b	.l_1d708
	lea.l	D_52690,a1
	jsr	DI_Error
	bra.w	.l_1d79c
.l_1d708:
	lea.l	Output_string,a0
	move.l	#$20202020,(a0)
	move.l	#$20202020,$4(a0)
	move.l	#$20202020,$8(a0)
	tst.l	d0
	bpl.b	.l_1d730
	neg.l	d0
	move.b	#$2d,(a0)+
	bra.b	.l_1d734
.l_1d730:
	move.b	#$20,(a0)+
.l_1d734:
	lea.l	D_52690,a1
	move.w	d7,d3
	add.w	d3,d3
	add.w	d3,d3
	suba.w	d3,a1
	cmp.l	-$4(a1),d0
	bmi.b	.l_1d754
	subq.w	#$1,d7
.l_1d74a:
	move.b	#$2a,(a0)+
	dbra	d7,.l_1d74a
	bra.b	.l_1d78a
.l_1d754:
	moveq	#0,d3
	subq.w	#$1,d7
.l_1d758:
	move.l	(a1)+,d1
	move.w	#$30,d2
.l_1d75e:
	cmp.l	d1,d0
	bmi.b	.l_1d768
	sub.l	d1,d0
	addq.w	#$1,d2
	bra.b	.l_1d75e
.l_1d768:
	cmpi.w	#$30,d2
	bne.b	.l_1d778
	tst.w	d3
	bne.b	.l_1d778
	move.b	#$20,(a0)+
	bra.b	.l_1d77c
.l_1d778:
	st.b	d3
	move.b	d2,(a0)+
.l_1d77c:
	dbra	d7,.l_1d758
	tst.w	d3
	bne.b	.l_1d78a
	move.b	#$30,-$1(a0)
.l_1d78a:
	move.b	#$20,(a0)+
	move.b	#$20,(a0)+
	move.b	#$0,(a0)
	lea.l	Output_string,a0
.l_1d79c:
	movem.l	(a7)+,d0-d3/d7/a1
	rts
