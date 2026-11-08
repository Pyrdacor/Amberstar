; NUCLEUS/TEXTPUT.ASM (original module, merged with the disassembly of the shipped program)

	section	text

; ---- IG_Backspace (original source: NUCLEUS/TEXTPUT.ASM)
IG_Backspace:
	move.l	d0,-(sp)
	move.w	B_76734,d0	; CHANGE: was "move.w Print_X,d0"
	subq.w	#6,d0
	cmp.w	PArea,d0
	bmi.s	.Exit
	move.w	d0,B_76734	; CHANGE: was "move.w d0,Print_X"
.Exit:
	move.l	(sp)+,d0
	rts	
T_1d8b6:
	move.w	PArea,B_76734
	move.w	D_5571c,Print_Y
	rts
; ---- IG_Carriage_return (original source: NUCLEUS/TEXTPUT.ASM)
IG_Carriage_return:
	movem.l	d0/a0,-(sp)
	lea.l	PArea,a0
	move.w	(a0),B_76734	; CHANGE: was "move.w (a0),Print_X"
	move.w	Print_Y,d0
	addq.w	#7,d0
	cmp.w	6(a0),d0
	bmi.s	.Skip
	move.w	4(a0),d0
.Skip:
	move.w	d0,Print_Y
	movem.l	(sp)+,d0/a0
	rts	
IG_Set_ink:
	move.l	d0,-(a7)
	cmpi.w	#$10,d0
	bmi.b	.l_1d910
	lea.l	D_55b26,a1
	jsr	DI_Error
	bra.b	.l_1d918
.l_1d910:
	lsl.w	#$3,d0
	move.w	d0,IG_Ink
.l_1d918:
	move.l	(a7)+,d0
	rts
IG_Set_paper:
	move.l	d0,-(a7)
	tst.w	d0
	bpl.b	.l_1d934
	move.w	d0,IG_Paper
	move.l	#IG_Pchar_TRANS,Pchar_ptr
	bra.b	.l_1d95a
.l_1d934:
	cmpi.w	#$10,d0
	bmi.b	.l_1d948
	lea.l	D_55b4a,a1
	jsr	DI_Error
	bra.b	.l_1d95a
.l_1d948:
	lsl.w	#$3,d0
	move.w	d0,IG_Paper
	move.l	#IG_Pchar_OPAQUE,Pchar_ptr
.l_1d95a:
	move.l	(a7)+,d0
	rts
; ---- IG_Set_cursor (original source: NUCLEUS/TEXTPUT.ASM)
IG_Set_cursor:
	move.w	d0,B_76734	; CHANGE: was "move.w d0,Print_X"
	move.w	d1,Print_Y
	rts	
; ---- IG_Print (original source: NUCLEUS/TEXTPUT.ASM)
IG_Print:
	movem.l	d0/a0/a1,-(sp)
.Again:
	moveq.l	#0,d0
	move.b	(a0)+,d0
	beq.s	.Exit
	cmpi.b	#13,d0
	bne.s	.Skip1
	jsr	IG_Carriage_return
	bra.s	.Again
.Skip1:
	cmpi.b	#1,d0
	bne.s	.Skip2
	move.b	(a0)+,d0
	ext.w	d0
	jsr	IG_Set_ink
	bra.s	.Again
.Skip2:
	cmpi.b	#2,d0
	bne.s	.Skip3
	move.b	(a0)+,d0
	ext.w	d0
	jsr	IG_Set_paper
	bra.s	.Again
.Skip3:
	cmpi.b	#14,d0
	bne.s	.Skip4
	jsr	IG_Backspace
	bra.s	.Again
.Skip4:
	cmpi.b	#$7e,d0	; CHANGE: was ".Skip4: cmpi.b #"~",d0"
	bne.s	.Skip5
	not.b	Rune_flag
	bra.s	.Again
.Skip5:
	movea.l	Pchar_ptr,a1
	jsr	(a1)
	bra.s	.Again
.Exit:
	movem.l	(sp)+,d0/a0/a1
	rts	
; ---- IG_Pchar_TRANS (original source: NUCLEUS/TEXTPUT.ASM)
IG_Pchar_TRANS:
	movem.l	d0-d7/a0-a2,-(sp)
	lea.l	Text_conversion_tab-32,a0
	tst.b	Rune_flag
	beq.s	.No_runes
	lea.l	Rune_conversion_tab-32,a0
.No_runes:
	andi.w	#$00ff,d0
	move.b	0(a0,d0.w),d0
	bmi.w	.Exit
	lea.l	Little_font,a0
	ext.w	d0
	adda.w	d0,a0
	lsl.w	#2,d0
	adda.w	d0,a0
	move.w	B_76734,d0	; CHANGE: was "move.w Print_X,d0"
	move.w	Print_Y,d1
	jsr	Coord_convert
	lea.l	0(a6,d2.w),a1
	move.w	d3,d6
	lea.l	Colour_table,a2
	adda.w	IG_Ink,a2
	moveq.l	#0,d0
	moveq.l	#0,d1
	moveq.l	#0,d2
	moveq.l	#0,d3
	moveq.l	#0,d5
	move.b	(a0)+,d5
	lsl.w	#8,d5
	move.w	d5,d0
	move.w	d5,d1
	move.w	d5,d2
	move.w	d5,d3
	and.w	(a2)+,d0
	and.w	(a2)+,d1
	and.w	(a2)+,d2
	and.w	(a2)+,d3
	subq.l	#8,a2
	ror.l	d6,d0
	ror.l	d6,d1
	ror.l	d6,d2
	ror.l	d6,d3
	ror.l	d6,d5
	move.l	d5,d4
	not.l	d4
	and.w	d4,(a1)
	or.w	d0,(a1)+
	and.w	d4,(a1)
	or.w	d1,(a1)+
	and.w	d4,(a1)
	or.w	d2,(a1)+
	and.w	d4,(a1)
	or.w	d3,(a1)+
	swap.w	d0
	swap.w	d1
	swap.w	d2
	swap.w	d3
	swap.w	d4
	and.w	d4,(a1)
	or.w	d0,(a1)+
	and.w	d4,(a1)
	or.w	d1,(a1)+
	and.w	d4,(a1)
	or.w	d2,(a1)+
	and.w	d4,(a1)
	or.w	d3,(a1)+
	lea.l	160-16(a1),a1
	moveq.l	#4-1,d7
.Loop:
	moveq.l	#0,d0
	moveq.l	#0,d1
	moveq.l	#0,d2
	moveq.l	#0,d3
	moveq.l	#0,d5
	move.b	(a0)+,d5
	lsl.w	#8,d5
	move.w	d5,d0
	move.w	d5,d1
	move.w	d5,d2
	move.w	d5,d3
	and.w	(a2)+,d0
	and.w	(a2)+,d1
	and.w	(a2)+,d2
	and.w	(a2)+,d3
	subq.l	#8,a2
	ror.l	d6,d0
	ror.l	d6,d1
	ror.l	d6,d2
	ror.l	d6,d3
	moveq.l	#0,d4
	move.b	-2(a0),d4
	lsl.w	#7,d4
	or.w	d5,d4
	not.l	d4
	ror.l	d6,d4
	and.w	d4,(a1)
	or.w	d0,(a1)+
	and.w	d4,(a1)
	or.w	d1,(a1)+
	and.w	d4,(a1)
	or.w	d2,(a1)+
	and.w	d4,(a1)
	or.w	d3,(a1)+
	swap.w	d0
	swap.w	d1
	swap.w	d2
	swap.w	d3
	swap.w	d4
	and.w	d4,(a1)
	or.w	d0,(a1)+
	and.w	d4,(a1)
	or.w	d1,(a1)+
	and.w	d4,(a1)
	or.w	d2,(a1)+
	and.w	d4,(a1)
	or.w	d3,(a1)+
	swap.w	d4
	lea.l	160-16(a1),a1
	dbra	d7,.Loop
	moveq.l	#0,d4
	move.b	-1(a0),d4
	lsl.w	#7,d4
	not.l	d4
	ror.l	d6,d4
	and.w	d4,(a1)+
	and.w	d4,(a1)+
	and.w	d4,(a1)+
	and.w	d4,(a1)+
	swap.w	d4
	and.w	d4,(a1)+
	and.w	d4,(a1)+
	and.w	d4,(a1)+
	and.w	d4,(a1)+
	move.w	B_76734,d0	; CHANGE: was "move.w Print_X,d0"
	addq.w	#6,d0
	cmp.w	PArea+2,d0
	bmi.s	.Skip
	jsr	IG_Carriage_return
	bra.s	.Exit
.Skip:
	move.w	d0,B_76734	; CHANGE: was ".Skip: move.w d0,Print_X"
.Exit:
	movem.l	(sp)+,d0-d7/a0-a2
	rts	
IG_Pchar_OPAQUE:
	movem.l	d0-d7/a0-a2,-(a7)
	andi.w	#$ff,d0
	move.w	d0,d6
	move.w	B_76734,d0
	move.w	Print_Y,d1
	jsr	Coord_convert
	lea.l	(a6,d2.w),a0
	move.l	#$ffff03ff,d0
	ror.l	d3,d0
	move.l	d0,d1
	swap	d1
	moveq	#5,d7
.l_1db62:
	and.w	d0,(a0)+
	and.w	d0,(a0)+
	and.w	d0,(a0)+
	and.w	d0,(a0)+
	and.w	d1,(a0)+
	and.w	d1,(a0)+
	and.w	d1,(a0)+
	and.w	d1,(a0)+
	lea.l	$90(a0),a0
	dbra	d7,.l_1db62
	lea.l	Colour_table,a0
	move.w	IG_Paper,d0
	adda.w	d0,a0
	move.l	(a0)+,d0
	move.l	(a0)+,d1
	lea.l	Char_buffer,a0
	moveq	#5,d7
.l_1db94:
	move.l	d0,(a0)+
	move.l	d1,(a0)+
	dbra	d7,.l_1db94
	lea.l	D_55700,a0
	tst.b	Rune_flag
	beq.b	.l_1dbb0
	lea.l	D_557e0,a0
.l_1dbb0:
	move.b	(a0,d6.w),d0
	bmi.w	.l_1dc8e
	lea.l	Little_font,a0
	ext.w	d0
	adda.w	d0,a0
	lsl.w	#$2,d0
	adda.w	d0,a0
	lea.l	Colour_table,a1
	adda.w	IG_Ink,a1
	lea.l	Char_buffer,a2
	moveq	#4,d7
.l_1dbda:
	move.b	(a0)+,d0
	lsl.w	#$8,d0
	move.w	d0,d1
	swap	d0
	move.w	d1,d0
	move.l	d0,d1
	not.l	d0
	move.l	d0,d2
	ror.l	#$1,d2
	and.l	d2,$8(a2)
	and.l	d2,$c(a2)
	move.l	d0,d2
	move.l	d1,d3
	or.l	(a1),d0
	and.l	(a1),d1
	or.l	$4(a1),d2
	and.l	$4(a1),d3
	move.l	(a2),d4
	and.l	d0,d4
	or.l	d1,d4
	move.l	d4,(a2)+
	move.l	(a2),d4
	and.l	d2,d4
	or.l	d3,d4
	move.l	d4,(a2)+
	dbra	d7,.l_1dbda
	lea.l	Char_buffer,a0
	move.w	B_76734,d0
	move.w	Print_Y,d1
	jsr	Coord_convert
	lea.l	(a6,d2.w),a1
	move.w	d3,d6
	moveq	#5,d7
.l_1dc38:
	moveq	#0,d0
	moveq	#0,d1
	moveq	#0,d2
	moveq	#0,d3
	move.w	(a0)+,d0
	move.w	(a0)+,d1
	move.w	(a0)+,d2
	move.w	(a0)+,d3
	ror.l	d6,d0
	ror.l	d6,d1
	ror.l	d6,d2
	ror.l	d6,d3
	or.w	d0,(a1)+
	or.w	d1,(a1)+
	or.w	d2,(a1)+
	or.w	d3,(a1)+
	swap	d0
	swap	d1
	swap	d2
	swap	d3
	or.w	d0,(a1)+
	or.w	d1,(a1)+
	or.w	d2,(a1)+
	or.w	d3,(a1)+
	lea.l	$90(a1),a1
	dbra	d7,.l_1dc38
	move.w	B_76734,d0
	addq.w	#$6,d0
	cmp.w	D_5571a,d0
	bmi.b	.l_1dc88
	jsr	IG_Carriage_return
	bra.b	.l_1dc8e
.l_1dc88:
	dc.b	$33,$c0
	dc.l	B_76734
.l_1dc8e:
	movem.l	(a7)+,d0-d7/a0-a2
	rts

	section	data

PArea:
	dc.b	$00,$00
D_5571a:
	dc.b	$01,$3b
D_5571c:
	dc.b	$00,$00,$00,$c2
Text_conversion_tab:
	dc.b	$3a,$24,$23,$2c,$ff,$2a,$ff,$22,$28,$29,$26,$2e,$20,$2d,$21,$2b
	dc.b	$30,$31,$32,$33,$34,$35,$36,$37,$38,$39,$1f,$1e,$ff,$2f,$ff,$25
	dc.b	$ff,$00,$01,$02,$03,$04,$05,$06,$07,$08,$09,$0a,$0b,$0c,$0d,$0e
	dc.b	$0f,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$ff,$ff,$ff,$ff,$27
	dc.b	$ff,$00,$01,$02,$03,$04,$05,$06,$07,$08,$09,$0a,$0b,$0c,$0d,$0e
	dc.b	$0f,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$ff,$ff,$ff,$ff,$ff
	dc.b	$ff,$1b,$ff,$ff,$1a,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$1a,$ff
	dc.b	$ff,$ff,$ff,$ff,$1c,$ff,$ff,$ff,$ff,$1c,$1b,$ff,$ff,$ff,$1d,$ff
	dc.b	$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
	dc.b	$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
	dc.b	$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
	dc.b	$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
D_557e0:
	dc.b	$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
	dc.b	$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
Rune_conversion_tab:
	dc.b	$3a,$24,$23,$2c,$ff,$2a,$ff,$22,$28,$29,$26,$2e,$20,$2d,$21,$2b
	dc.b	$30,$31,$32,$33,$34,$35,$36,$37,$38,$39,$1f,$1e,$ff,$2f,$ff,$25
	dc.b	$ff,$3b,$3c,$3d,$3e,$3f,$40,$41,$42,$43,$44,$45,$46,$47,$48,$49
	dc.b	$4a,$4b,$4c,$4d,$4e,$4f,$50,$51,$52,$53,$54,$ff,$ff,$ff,$ff,$27
	dc.b	$ff,$3b,$3c,$3d,$3e,$3f,$40,$41,$42,$43,$44,$45,$46,$47,$48,$49
	dc.b	$4a,$4b,$4c,$4d,$4e,$4f,$50,$51,$52,$53,$54,$ff,$ff,$ff,$ff,$ff
	dc.b	$ff,$56,$ff,$ff,$57,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$57,$ff
	dc.b	$ff,$ff,$ff,$ff,$55,$ff,$ff,$ff,$ff,$55,$56,$ff,$ff,$ff,$58,$ff
	dc.b	$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
	dc.b	$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
	dc.b	$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
	dc.b	$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
	dc.b	$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
	dc.b	$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
Little_font:
	dc.b	$70,$d8,$f8,$d8,$d8,$f0,$d8,$f0,$d8,$f0,$70,$d8,$c0,$d8,$70,$f0
	dc.b	$d8,$d8,$d8,$f0,$f8,$c0,$e0,$c0,$f8,$f8,$c0,$e0,$c0,$c0,$78,$c0
	dc.b	$d8,$d8,$78,$d8,$d8,$f8,$d8,$d8,$f0,$60,$60,$60,$f0,$f8,$18,$18
	dc.b	$18,$f0,$d8,$f0,$e0,$f0,$d8,$c0,$c0,$c0,$c0,$f8,$88,$d8,$f8,$d8
	dc.b	$d8,$98,$d8,$f8,$d8,$c8,$70,$d8,$d8,$d8,$70,$f0,$d8,$f0,$c0,$c0
	dc.b	$70,$d8,$d8,$f0,$78,$f0,$d8,$f0,$d8,$d8,$78,$e0,$70,$38,$f0,$f0
	dc.b	$60,$60,$60,$60,$d8,$d8,$d8,$d8,$78,$d8,$d8,$d8,$70,$20,$d8,$d8
	dc.b	$f8,$d8,$88,$d8,$f8,$70,$f8,$d8,$d8,$d8,$78,$18,$f0,$f8,$38,$70
	dc.b	$e0,$f8,$d8,$70,$d8,$f8,$d8,$d8,$00,$d8,$d8,$78,$d8,$70,$d8,$d8
	dc.b	$70,$70,$d8,$f0,$d8,$f0,$00,$30,$00,$30,$60,$00,$60,$00,$60,$00
	dc.b	$00,$00,$00,$30,$60,$00,$00,$00,$60,$60,$30,$60,$00,$00,$00,$28
	dc.b	$50,$00,$00,$00,$60,$60,$60,$00,$60,$f0,$38,$70,$00,$60,$a8,$70
	dc.b	$f8,$70,$a8,$00,$00,$00,$00,$f8,$18,$30,$30,$30,$18,$c0,$60,$60
	dc.b	$60,$c0,$00,$48,$10,$20,$48,$08,$18,$30,$60,$40,$50,$f8,$50,$f8
	dc.b	$50,$00,$00,$70,$00,$00,$00,$20,$70,$20,$00,$00,$70,$00,$70,$00
	dc.b	$70,$d8,$f8,$d8,$70,$30,$70,$30,$30,$30,$f0,$38,$70,$e0,$f8,$f0
	dc.b	$38,$70,$38,$f0,$c0,$d0,$f8,$30,$30,$f8,$c0,$f0,$18,$f0,$30,$60
	dc.b	$f0,$d8,$70,$f8,$38,$f0,$60,$60,$70,$d8,$70,$d8,$70,$70,$d8,$78
	dc.b	$30,$60,$00,$00,$00,$00,$00,$c0,$e0,$f0,$d8,$d8,$e0,$f0,$d8,$f0
	dc.b	$d8,$c0,$c0,$e0,$f0,$d8,$e0,$d0,$e8,$d0,$c8,$d8,$98,$f8,$c8,$d8
	dc.b	$78,$d8,$78,$38,$18,$c8,$f0,$c8,$f0,$c0,$e0,$f0,$18,$f0,$e0,$e0
	dc.b	$c0,$c0,$c0,$e0,$e8,$d0,$c0,$e8,$d0,$c8,$c8,$f8,$f0,$c0,$70,$28
	dc.b	$70,$a0,$70,$f0,$c8,$d0,$c8,$f0,$88,$d8,$70,$20,$70,$d8,$50,$20
	dc.b	$70,$d8,$f0,$d8,$f0,$e0,$c0,$d8,$20,$20,$70,$d8,$20,$70,$a8,$20
	dc.b	$70,$18,$18,$18,$38,$d8,$e0,$f0,$d8,$c0,$c0,$70,$50,$20,$70,$d8
	dc.b	$38,$78,$d8,$78,$d8,$70,$d8,$70,$20,$70,$20,$60,$a8,$30,$20,$c8
	dc.b	$d8,$f8,$d8,$98,$38,$58,$b8,$58,$98,$20,$70,$70,$a8,$a8,$d8,$70
	dc.b	$d8,$70,$d8,$e0,$f0,$d8,$f8,$d8,$18,$38,$58,$38,$18,$00
Colour_table:
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$fc,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$fc,$00,$00,$00,$00,$00,$fc,$00,$fc,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$fc,$00,$00,$00,$fc,$00,$00,$00,$fc,$00,$00,$00
	dc.b	$00,$00,$fc,$00,$fc,$00,$00,$00,$fc,$00,$fc,$00,$fc,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$fc,$00,$fc,$00,$00,$00,$00,$00,$fc,$00
	dc.b	$00,$00,$fc,$00,$00,$00,$fc,$00,$fc,$00,$fc,$00,$00,$00,$fc,$00
	dc.b	$00,$00,$00,$00,$fc,$00,$fc,$00,$fc,$00,$00,$00,$fc,$00,$fc,$00
	dc.b	$00,$00,$fc,$00,$fc,$00,$fc,$00,$fc,$00,$fc,$00,$fc,$00,$fc,$00
IG_Ink:
	dc.b	$00,$08
IG_Paper:
	dc.b	$00,$00
Pchar_ptr:
	dc.l	IG_Pchar_TRANS
D_55b26:
	dc.b	$5b,$20,$49,$47,$5f,$53,$65,$74,$5f,$69,$6e,$6b,$20,$5d,$20,$3a
	dc.b	$20,$49,$6c,$6c,$65,$67,$61,$6c,$20,$69,$6e,$70,$75,$74,$20,$21
	dc.b	$21,$21,$0d,$00
D_55b4a:
	dc.b	$5b,$20,$49,$47,$5f,$53,$65,$74,$5f,$70,$61,$70,$65,$72,$20,$5d
	dc.b	$20,$3a,$20,$49,$6c,$6c,$65,$67,$61,$6c,$20,$69,$6e,$70,$75,$74
	dc.b	$20,$21,$21,$21,$0d,$00

	section	bss

Char_buffer:
	ds.b	48
Rune_flag:
	ds.b	2
