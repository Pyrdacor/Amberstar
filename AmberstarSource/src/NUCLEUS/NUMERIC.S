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
	bmi.b	T_1d70a
	lea.l	D_556c2,a1
	jsr	DI_Error
	bra.w	T_1d79e
T_1d70a:
	lea.l	Output_string,a0
	move.l	#$20202020,(a0)
	move.l	#$20202020,$4(a0)
	move.l	#$20202020,$8(a0)
	tst.l	d0
	bpl.b	T_1d732
	neg.l	d0
	move.b	#$2d,(a0)+
	bra.b	T_1d736
T_1d732:
	move.b	#$20,(a0)+
T_1d736:
	lea.l	D_556c2,a1
	move.w	d7,d3
	add.w	d3,d3
	add.w	d3,d3
	suba.w	d3,a1
	cmp.l	-$4(a1),d0
	bmi.b	T_1d756
	subq.w	#$1,d7
T_1d74c:
	move.b	#$2a,(a0)+
	dbra	d7,T_1d74c
	bra.b	T_1d78c
T_1d756:
	moveq	#0,d3
	subq.w	#$1,d7
T_1d75a:
	move.l	(a1)+,d1
	move.w	#$30,d2
T_1d760:
	cmp.l	d1,d0
	bmi.b	T_1d76a
	sub.l	d1,d0
	addq.w	#$1,d2
	bra.b	T_1d760
T_1d76a:
	cmpi.w	#$30,d2
	bne.b	T_1d77a
	tst.w	d3
	bne.b	T_1d77a
	move.b	#$20,(a0)+
	bra.b	T_1d77e
T_1d77a:
	st.b	d3
	move.b	d2,(a0)+
T_1d77e:
	dbra	d7,T_1d75a
	tst.w	d3
	bne.b	T_1d78c
	move.b	#$30,-$1(a0)
T_1d78c:
	move.b	#$20,(a0)+
	move.b	#$20,(a0)+
	move.b	#$0,(a0)
	lea.l	Output_string,a0
T_1d79e:
	movem.l	(a7)+,d0-d3/d7/a1
	rts
