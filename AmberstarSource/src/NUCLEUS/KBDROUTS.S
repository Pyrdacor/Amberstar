; NUCLEUS/KBDROUTS.ASM (original module, merged with the disassembly of the shipped program)

	section	text

Push_MA:
	movem.l	d0-d2/a0-a1,-(a7)
	bsr.w	Mouse_off
	movea.l	MA_sp,a1
	addq.l	#$4,a1
	move.l	Mouse_X,(a1)+
	cmpa.l	#Last_key,a1
	bmi.b	.l_1cd04
	lea.l	D_5542c,a1
	jsr	DI_Error
	bra.b	.l_1cd10
.l_1cd04:
	move.l	a0,(a1)
	move.l	a1,MA_sp
	bsr.w	T_1cd1a
.l_1cd10:
	bsr.w	Mouse_on
	movem.l	(a7)+,d0-d2/a0-a1
	rts
T_1cd1a:
	movem.l	d0-d1/a1,-(a7)
	movea.l	MA_sp,a1
	movea.l	(a1),a1
	move.w	Mouse_X,d0
	move.w	d0,d1
	sub.w	(a1),d1
	bpl.b	.l_1cd3a
	move.w	(a1),Mouse_X
	bra.b	.l_1cd48
.l_1cd3a:
	sub.w	$2(a1),d0
	blt.b	.l_1cd48
	move.w	$2(a1),Mouse_X
.l_1cd48:
	move.w	Mouse_Y,d0
	move.w	d0,d1
	sub.w	$4(a1),d1
	bpl.b	.l_1cd60
	move.w	$4(a1),Mouse_Y
	bra.b	.l_1cd6e
.l_1cd60:
	sub.w	$6(a1),d0
	blt.b	.l_1cd6e
	move.w	$6(a1),Mouse_Y
.l_1cd6e:
	movem.l	(a7)+,d0-d1/a1
	rts
Pop_MA:
	movem.l	d0-d2/a0-a1,-(a7)
	bsr.w	Mouse_off
	movea.l	MA_sp,a1
	cmpa.l	#B_608e4,a1
	bhi.b	.l_1cd98
	lea.l	D_55451,a1
	jsr	DI_Error
	bra.b	.l_1cdaa
.l_1cd98:
	move.l	-(a1),Mouse_X
	subq.l	#$4,a1
	move.l	a1,MA_sp
	bsr.w	T_1cd1a
.l_1cdaa:
	bsr.w	Mouse_on
	movem.l	(a7)+,d0-d2/a0-a1
	rts
Push_Mptr:
	movem.l	d0/a0-a1,-(a7)
	bsr.w	Mouse_off
	cmpi.w	#$1b,d0
	bmi.b	.l_1cdd0
	lea.l	D_55476,a1
	jsr	DI_Error
	bra.b	.l_1ce02
.l_1cdd0:
	lea.l	Mouse_base,a0
	mulu.w	#$44,d0
	adda.w	d0,a0
	movea.l	Mptr_sp,a1
	addq.l	#$4,a1
	cmpa.l	#Mouse_flag,a1
	bmi.b	.l_1cdfa
	lea.l	D_55499,a1
	jsr	DI_Error
	bra.b	.l_1ce02
.l_1cdfa:
	move.l	a0,(a1)
	move.l	a1,Mptr_sp
.l_1ce02:
	bsr.w	Mouse_on
	movem.l	(a7)+,d0/a0-a1
	rts
Pop_Mptr:
	move.l	a1,-(a7)
	bsr.w	Mouse_off
	movea.l	Mptr_sp,a1
	cmpa.l	#D_54cb6,a1
	bhi.b	.l_1ce2e
	lea.l	D_554bc,a1
	jsr	DI_Error
	bra.b	.l_1ce36
.l_1ce2e:
	subq.l	#$4,a1
	move.l	a1,Mptr_sp
.l_1ce36:
	bsr.w	Mouse_on
	movea.l	(a7)+,a1
	rts
Change_Mptr:
	movem.l	d0/a0-a1,-(a7)
	cmpi.w	#$1b,d0
	bmi.b	.l_1ce56
	lea.l	D_554df,a1
	jsr	DI_Error
	bra.b	.l_1ce6a
.l_1ce56:
	lea.l	Mouse_base,a0
	mulu.w	#$44,d0
	adda.w	d0,a0
	movea.l	Mptr_sp,a1
	move.l	a0,(a1)
.l_1ce6a:
	movem.l	(a7)+,d0/a0-a1
	rts
T_1ce70:
	movem.l	d1-d3/a0-a2,-(a7)
	move.w	#$b,-(a7)
	trap	#$1
	addq.l	#$2,a7
	tst.w	d0
	bne.b	.l_1ceaa
	movea.l	$4f2.w,a0
	cmpi.w	#$102,$2(a0)
	bmi.b	.l_1ce96
	movea.l	$24(a0),a0
	move.b	$1e(a0),d1
	bra.b	.l_1ce9a
.l_1ce96:
	move.b	$e39.w,d1
.l_1ce9a:
	cmp.b	B_60925,d1
	bne.b	.l_1ced2
	move.l	Last_key,d0
	bra.b	.l_1ced2
.l_1ceaa:
	move.w	#$7,-(a7)
	trap	#$1
	addq.l	#$2,a7
	move.l	d0,d3
.l_1ceb4:
	move.w	#$b,-(a7)
	trap	#$1
	addq.l	#$2,a7
	tst.w	d0
	beq.b	.l_1ceca
	move.w	#$7,-(a7)
	trap	#$1
	addq.l	#$2,a7
	bra.b	.l_1ceb4
.l_1ceca:
	move.l	d3,d0
	move.l	d0,Last_key
.l_1ced2:
	movem.l	(a7)+,d1-d3/a0-a2
	rts
Wait_4_key:
	movem.l	d1-d2/a0-a2,-(a7)
	move.w	#$7,-(a7)
	trap	#$1
	addq.l	#$2,a7
	movem.l	(a7)+,d1-d2/a0-a2
	rts
T_1ceea:
	move.l	#D_54caa,B_608e4
	bsr.w	Draw_mouse
	rts
T_1cefa:
	movea.l	MA_sp,a1
	movea.l	(a1),a1
	moveq	#3,d0
	and.b	(a0),d0
	move.b	Mouse_button_state,d1
	move.b	d1,d2
	not.b	d1
	and.b	d0,d1
	or.b	d1,Mouse_click_state
	move.b	d0,Mouse_button_state
	not.b	d0
	and.b	d2,d0
	or.b	d0,Mouse_unclick_state
	move.w	Mouse_X,d1
	move.b	$1(a0),d0
	ext.w	d0
	add.w	d0,d1
	move.w	d1,d2
	sub.w	(a1),d2
	bpl.b	.l_1cf40
	move.w	(a1),d1
	bra.b	.l_1cf4e
.l_1cf40:
	move.w	d1,d2
	sub.w	$2(a1),d2
	blt.b	.l_1cf4e
	move.w	$2(a1),d1
	bra.b	.l_1cf54
.l_1cf4e:
	move.w	d1,Mouse_X
.l_1cf54:
	move.w	Mouse_Y,d1
	move.b	$2(a0),d0
	ext.w	d0
	add.w	d0,d1
	move.w	d1,d2
	sub.w	$4(a1),d2
	bpl.b	.l_1cf70
	move.w	$4(a1),d1
	bra.b	.l_1cf7c
.l_1cf70:
	dc.b	$34,$01,$94,$69,$00,$06,$6d,$04,$32,$29,$00,$06
.l_1cf7c:
	move.w	d1,Mouse_Y
	rts
; ---- Mouse_on (original source: NUCLEUS/KBDROUTS.ASM)
Mouse_on:
	tst.b	Mouse_flag
	beq.s	.Exit
	cmpi.b	#1,Mouse_flag
	bne.s	.Skip
	bsr.w	DrawM_entry
.Skip:
	subq.b	#1,Mouse_flag
.Exit:
	rts	
; ---- Mouse_off (original source: NUCLEUS/KBDROUTS.ASM)
Mouse_off:
	addq.b	#1,Mouse_flag
	cmpi.b	#1,Mouse_flag
	bne.s	.Exit
	bsr.w	EraseM_entry
.Exit:
	rts	
; ---- Erase_mouse (original source: NUCLEUS/KBDROUTS.ASM)
Erase_mouse:
	tst.b	Mouse_flag
	bne.s	Exit_EraseM
; ---- EraseM_entry (original source: NUCLEUS/KBDROUTS.ASM)
EraseM_entry:
	movem.l	d0-d3/d7/a0-a3/a6,-(sp)
	movea.l	Erase_rout,a1
	lea.l	Mouse_back_buffer,a2
	movea.l	Erase_adr,a3
	move.w	Erase_height,d7
	jsr	(a1)
	movem.l	(sp)+,d0-d3/d7/a0-a3/a6
; ---- Exit_EraseM (original source: NUCLEUS/KBDROUTS.ASM)
Exit_EraseM:
	rts	
; ---- Draw_mouse (original source: NUCLEUS/KBDROUTS.ASM)
Draw_mouse:
	tst.b	Mouse_flag
	bne.s	Exit_DrawM
; ---- DrawM_entry (original source: NUCLEUS/KBDROUTS.ASM)
DrawM_entry:
	movem.l	d0-d3/d7/a0-a2/a6,-(sp)
	movea.l	On_screen,a6
	movea.l	Mptr_sp,a0
	movea.l	(a0),a0
	move.w	Mouse_X,d0
	move.w	Mouse_Y,d1
	sub.w	(a0)+,d0
	sub.w	(a0)+,d1
	lea.l	Mouse_draw_normal,a1
	tst.w	d0
	bpl.s	.No_left
	lea.l	Mouse_draw_left,a1
	bra.s	.Continue
.No_left:
	cmpi.w	#320-15,d0
	bmi.s	.Continue
	lea.l	Mouse_draw_right,a1
.Continue:
	moveq.l	#16-1,d7
	tst.w	d1
	bpl.s	.No_up
	add.w	d1,d7
	add.w	d1,d1
	suba.w	d1,a0
	moveq.l	#0,d1
	bra.s	.Continue2
.No_up:
	cmpi.w	#200-15,d1
	bmi.s	.Continue2
	move.w	#199,d7
	sub.w	d1,d7
.Continue2:
	move.w	d7,Erase_height
	lea.l	Mouse_back_buffer,a2
	jsr	(a1)
	movem.l	(sp)+,d0-d3/d7/a0-a2/a6
; ---- Exit_DrawM (original source: NUCLEUS/KBDROUTS.ASM)
Exit_DrawM:
	rts	
Mouse_draw_normal:
	move.l	#T_1d164,Erase_rout
	jsr	Coord_convert
	move.w	d3,d0
	lea.l	(a6,d2.w),a1
	move.l	a1,Erase_adr
.l_1d078:
	moveq	#0,d2
	moveq	#-1,d3
	move.w	(a0)+,d2
	move.w	$1e(a0),d3
	ror.l	d0,d2
	ror.l	d0,d3
	move.w	(a1),(a2)+
	and.w	d3,(a1)
	or.w	d2,(a1)+
	move.w	(a1),(a2)+
	and.w	d3,(a1)
	or.w	d2,(a1)+
	move.w	(a1),(a2)+
	and.w	d3,(a1)
	or.w	d2,(a1)+
	move.w	(a1),(a2)+
	and.w	d3,(a1)
	or.w	d2,(a1)+
	swap	d2
	swap	d3
	move.w	(a1),(a2)+
	and.w	d3,(a1)
	or.w	d2,(a1)+
	move.w	(a1),(a2)+
	and.w	d3,(a1)
	or.w	d2,(a1)+
	move.w	(a1),(a2)+
	and.w	d3,(a1)
	or.w	d2,(a1)+
	move.w	(a1),(a2)+
	and.w	d3,(a1)
	or.w	d2,(a1)+
	lea.l	$90(a1),a1
	dbra	d7,.l_1d078
	rts
Mouse_draw_left:
	move.l	#T_1d176,Erase_rout
	addi.w	#$10,d0
	jsr	Coord_convert
	move.w	d3,d0
	lea.l	(a6,d2.w),a1
	move.l	a1,Erase_adr
.l_1d0e4:
	moveq	#0,d2
	moveq	#-1,d3
	move.w	(a0)+,d2
	move.w	$1e(a0),d3
	ror.l	d0,d2
	ror.l	d0,d3
	swap	d2
	swap	d3
	move.w	(a1),(a2)+
	and.w	d3,(a1)
	or.w	d2,(a1)+
	move.w	(a1),(a2)+
	and.w	d3,(a1)
	or.w	d2,(a1)+
	move.w	(a1),(a2)+
	and.w	d3,(a1)
	or.w	d2,(a1)+
	move.w	(a1),(a2)+
	and.w	d3,(a1)
	or.w	d2,(a1)+
	lea.l	$98(a1),a1
	dbra	d7,.l_1d0e4
	rts
Mouse_draw_right:
	move.l	#T_1d184,Erase_rout
	jsr	Coord_convert
	move.w	d3,d0
	lea.l	(a6,d2.w),a1
	move.l	a1,Erase_adr
.l_1d134:
	moveq	#0,d2
	moveq	#-1,d3
	move.w	(a0)+,d2
	move.w	$1e(a0),d3
	ror.l	d0,d2
	ror.l	d0,d3
	move.w	(a1),(a2)+
	and.w	d3,(a1)
	or.w	d2,(a1)+
	move.w	(a1),(a2)+
	and.w	d3,(a1)
	or.w	d2,(a1)+
	move.w	(a1),(a2)+
	and.w	d3,(a1)
	or.w	d2,(a1)+
	move.w	(a1),(a2)+
	and.w	d3,(a1)
	or.w	d2,(a1)+
	lea.l	$98(a1),a1
	dbra	d7,.l_1d134
	rts
T_1d164:
	movem.l	(a2)+,d0-d3
	movem.l	d0-d3,(a3)
	lea.l	$a0(a3),a3
	dbra	d7,T_1d164
	rts
T_1d176:
	move.l	(a2)+,(a3)+
	move.l	(a2)+,(a3)+
	lea.l	$98(a3),a3
	dbra	d7,T_1d176
	rts
T_1d184:
	move.l	(a2)+,(a3)+
	move.l	(a2)+,(a3)+
	lea.l	$98(a3),a3
	dbra	d7,T_1d184
	rts
T_1d192:
	movem.l	d0-d1/a0,-(a7)
	move.l	$18(a0),d0
	add.l	$1c(a0),d0
	move.l	d0,B_60a36
	move.l	$4(a0),d1
	sub.l	d0,d1
	cmpi.l	#$4b000,d1
	bpl.b	.l_1d212
	movem.l	d0-d7/a0-a6,-(a7)
	jsr	T_1c0ea
	jsr	T_1c1ac
	movea.l	Screen_base,a6
	lea.l	D_55504,a0
	jsr	DI_Print
	lea.l	D_55535,a0
	jsr	DI_Print
	lea.l	D_55566,a0
	jsr	DI_Print
	lea.l	D_55579,a0
	jsr	DI_Print
	jsr	Wait_4_key
	jsr	T_1c160
	movem.l	(a7)+,d0-d7/a0-a6
	movea.l	$4f2.w,a0
	movea.l	$4(a0),a0
	jmp	(a0)
.l_1d212:
	move.l	d1,Size_of_free_memory
	move.l	d1,B_60a3e
	lea.l	Memory_list,a0
	move.l	d0,(a0)+
	move.l	d1,(a0)+
	move.l	#$80000000,(a0)+
	move.l	a0,Memlist_end
	movem.l	(a7)+,d0-d1/a0
	rts

	section	data

MA_sp:
	dc.l	B_608e4
D_54caa:
	dc.b	$00,$00,$01,$3f,$00,$00,$00,$c7
Mptr_sp:
	dc.l	D_54cb6
D_54cb6:
	dc.l	Mouse_base
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
Mouse_flag:
	dc.b	$01,$00
Mouse_X:
	dc.b	$00,$98
Mouse_Y:
	dc.b	$00,$5c
Mouse_base:
	dc.b	$00,$01,$00,$01,$00,$00,$70,$00,$78,$00,$5c,$00,$2e,$00,$17,$00
	dc.b	$0b,$98,$05,$d8,$02,$f0,$01,$60,$00,$f0,$03,$b8,$03,$1e,$00,$0a
	dc.b	$00,$0c,$00,$00,$0f,$ff,$07,$ff,$03,$ff,$01,$ff,$80,$ff,$c0,$67
	dc.b	$e0,$03,$f0,$03,$f8,$07,$fc,$0f,$fc,$07,$f8,$00,$f8,$40,$fc,$e0
	dc.b	$ff,$e1,$ff,$e3,$00,$07,$00,$07,$00,$00,$00,$00,$00,$00,$01,$00
	dc.b	$02,$80,$05,$40,$0a,$a0,$1e,$f0,$02,$80,$02,$80,$02,$80,$02,$80
	dc.b	$03,$80,$00,$00,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$fe,$ff,$fc,$7f
	dc.b	$f8,$3f,$f0,$1f,$e0,$0f,$c0,$07,$c0,$07,$f8,$3f,$f8,$3f,$f8,$3f
	dc.b	$f8,$3f,$f8,$3f,$ff,$ff,$ff,$ff,$00,$07,$00,$07,$00,$00,$00,$00
	dc.b	$00,$00,$01,$c0,$01,$40,$01,$40,$01,$40,$01,$40,$0f,$78,$05,$50
	dc.b	$02,$a0,$01,$40,$00,$80,$00,$00,$00,$00,$00,$00,$ff,$ff,$ff,$ff
	dc.b	$fc,$1f,$fc,$1f,$fc,$1f,$fc,$1f,$fc,$1f,$e0,$03,$e0,$03,$f0,$07
	dc.b	$f8,$0f,$fc,$1f,$fe,$3f,$ff,$7f,$ff,$ff,$ff,$ff,$00,$07,$00,$07
	dc.b	$00,$00,$00,$00,$00,$00,$00,$80,$00,$c0,$00,$a0,$1f,$d0,$10,$28
	dc.b	$1f,$d0,$00,$a0,$00,$c0,$00,$80,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$ff,$ff,$ff,$ff,$fe,$7f,$fe,$3f,$fe,$1f,$c0,$0f,$c0,$07,$c0,$03
	dc.b	$c0,$07,$c0,$0f,$fe,$1f,$fe,$3f,$fe,$7f,$ff,$ff,$ff,$ff,$ff,$ff
	dc.b	$00,$07,$00,$07,$00,$00,$00,$00,$00,$00,$01,$00,$03,$00,$05,$00
	dc.b	$0b,$f8,$14,$08,$0b,$f8,$05,$00,$03,$00,$01,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$ff,$ff,$ff,$ff,$fe,$7f,$fc,$7f,$f8,$7f,$f0,$03
	dc.b	$e0,$03,$c0,$03,$e0,$03,$f0,$03,$f8,$7f,$fc,$7f,$fe,$7f,$ff,$ff
	dc.b	$ff,$ff,$ff,$ff,$00,$07,$00,$07,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$0f,$e0,$08,$40,$0b,$80,$0a,$c0,$0b,$60,$0d,$b0,$08,$d8,$00,$70
	dc.b	$00,$20,$00,$00,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$ff,$ff,$e0,$0f
	dc.b	$e0,$0f,$e0,$1f,$e0,$3f,$e0,$1f,$e0,$0f,$e0,$07,$e2,$03,$e7,$07
	dc.b	$ff,$8f,$ff,$df,$ff,$ff,$ff,$ff,$00,$07,$00,$07,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$07,$f0,$02,$10,$01,$d0,$03,$50,$06,$d0,$0d,$b0
	dc.b	$1b,$10,$0e,$00,$04,$00,$00,$00,$00,$00,$00,$00,$ff,$ff,$ff,$ff
	dc.b	$ff,$ff,$f0,$07,$f0,$07,$f8,$07,$fc,$07,$f8,$07,$f0,$07,$e0,$07
	dc.b	$c0,$47,$e0,$e7,$f1,$ff,$fb,$ff,$ff,$ff,$ff,$ff,$00,$07,$00,$07
	dc.b	$00,$00,$00,$00,$00,$00,$04,$00,$0e,$00,$1b,$10,$0d,$b0,$06,$d0
	dc.b	$03,$50,$01,$d0,$02,$10,$07,$f0,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$ff,$ff,$ff,$ff,$fb,$ff,$f1,$ff,$e0,$e7,$c0,$47,$e0,$07,$f0,$07
	dc.b	$f8,$07,$fc,$07,$f8,$07,$f0,$07,$f0,$07,$ff,$ff,$ff,$ff,$ff,$ff
	dc.b	$00,$07,$00,$07,$00,$00,$00,$00,$00,$00,$00,$20,$00,$70,$08,$d8
	dc.b	$0d,$b0,$0b,$60,$0a,$c0,$0b,$80,$08,$40,$0f,$e0,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$ff,$ff,$ff,$ff,$ff,$df,$ff,$8f,$e7,$07,$e2,$03
	dc.b	$e0,$07,$e0,$0f,$e0,$1f,$e0,$3f,$e0,$1f,$e0,$0f,$e0,$0f,$ff,$ff
	dc.b	$ff,$ff,$ff,$ff,$00,$07,$00,$07,$00,$00,$00,$00,$00,$00,$01,$00
	dc.b	$06,$c0,$1d,$70,$02,$80,$02,$80,$04,$40,$04,$40,$08,$20,$0f,$e0
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$fe,$ff,$f8,$3f
	dc.b	$e0,$0f,$80,$03,$80,$03,$f8,$3f,$f0,$1f,$f0,$1f,$e0,$0f,$e0,$0f
	dc.b	$c0,$07,$ff,$ff,$ff,$ff,$ff,$ff,$00,$07,$00,$07,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$03,$80,$02,$80,$04,$40,$7e,$fc,$19,$30,$06,$c0
	dc.b	$01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$ff,$ff,$ff,$ff
	dc.b	$ff,$ff,$fc,$7f,$f8,$3f,$f0,$1f,$00,$01,$00,$01,$80,$03,$e0,$0f
	dc.b	$f8,$3f,$fe,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$00,$07,$00,$07
	dc.b	$00,$00,$00,$00,$00,$00,$02,$00,$03,$80,$01,$e0,$3f,$d8,$7f,$b6
	dc.b	$00,$a4,$00,$48,$00,$50,$00,$20,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$ff,$ff,$ff,$ff,$f9,$ff,$f8,$7f,$f8,$1f,$c0,$07,$80,$01,$00,$00
	dc.b	$00,$01,$ff,$03,$ff,$07,$ff,$8f,$ff,$9f,$ff,$ff,$ff,$ff,$ff,$ff
	dc.b	$00,$07,$00,$07,$00,$00,$00,$00,$00,$00,$00,$40,$01,$c0,$07,$80
	dc.b	$1b,$fc,$6d,$fe,$25,$00,$12,$00,$0a,$00,$04,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$ff,$ff,$ff,$ff,$ff,$9f,$fe,$1f,$f8,$1f,$e0,$03
	dc.b	$80,$01,$00,$00,$80,$00,$c0,$ff,$e0,$ff,$f1,$ff,$f9,$ff,$ff,$ff
	dc.b	$ff,$ff,$ff,$ff,$00,$07,$00,$07,$00,$00,$00,$00,$00,$00,$02,$00
	dc.b	$03,$80,$01,$e0,$07,$d8,$1b,$b6,$24,$a4,$48,$48,$48,$50,$78,$20
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$f9,$ff,$f8,$7f
	dc.b	$f8,$1f,$f8,$07,$e0,$01,$c0,$00,$80,$01,$01,$03,$03,$07,$03,$8f
	dc.b	$03,$9f,$ff,$ff,$ff,$ff,$ff,$ff,$00,$07,$00,$07,$00,$00,$00,$00
	dc.b	$00,$00,$00,$40,$01,$c0,$07,$80,$1b,$e0,$6d,$d8,$25,$24,$12,$12
	dc.b	$0a,$12,$04,$1e,$00,$00,$00,$00,$00,$00,$00,$00,$ff,$ff,$ff,$ff
	dc.b	$ff,$9f,$fe,$1f,$f8,$1f,$e0,$1f,$80,$07,$00,$03,$80,$01,$c0,$80
	dc.b	$e0,$c0,$f1,$c0,$f9,$c0,$ff,$ff,$ff,$ff,$ff,$ff,$00,$07,$00,$07
	dc.b	$00,$00,$00,$00,$37,$68,$30,$0c,$30,$cc,$30,$cc,$30,$cc,$30,$0c
	dc.b	$3f,$fc,$3f,$fc,$3f,$fc,$3f,$fc,$3f,$fc,$00,$00,$00,$00,$00,$00
	dc.b	$ff,$ff,$80,$07,$80,$03,$80,$01,$80,$01,$80,$01,$80,$01,$80,$01
	dc.b	$80,$01,$80,$01,$80,$01,$80,$01,$80,$01,$80,$01,$ff,$ff,$ff,$ff
	dc.b	$00,$07,$00,$07,$00,$00,$00,$00,$00,$00,$3e,$00,$3e,$00,$06,$00
	dc.b	$0c,$00,$19,$e0,$3e,$60,$3e,$c0,$01,$9c,$01,$e4,$00,$08,$00,$1c
	dc.b	$00,$00,$00,$00,$ff,$ff,$ff,$ff,$80,$ff,$80,$ff,$80,$ff,$80,$ff
	dc.b	$e0,$0f,$c0,$0f,$80,$0f,$80,$01,$80,$01,$fc,$01,$fc,$01,$ff,$c1
	dc.b	$ff,$c1,$ff,$ff,$00,$07,$00,$07,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$0f,$f0,$30,$0c,$fc,$5e,$fe,$2f,$74,$2e,$7a,$5e,$1d,$b8,$07,$e0
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$ff,$ff,$f0,$0f
	dc.b	$c0,$03,$80,$01,$00,$00,$00,$00,$00,$00,$80,$01,$e0,$07,$f8,$1f
	dc.b	$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$00,$07,$00,$07,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$0e,$e0,$3f,$f8,$c0,$06,$78,$3c
	dc.b	$3f,$f8,$0f,$e0,$00,$00,$00,$00,$00,$00,$00,$00,$ff,$ff,$ff,$ff
	dc.b	$ff,$ff,$ff,$ff,$ff,$ff,$f0,$1f,$c0,$07,$00,$01,$00,$01,$00,$01
	dc.b	$80,$03,$c0,$07,$f0,$1f,$ff,$ff,$ff,$ff,$ff,$ff,$00,$07,$00,$07
	dc.b	$00,$00,$01,$c0,$07,$e0,$0e,$30,$1c,$10,$19,$98,$1b,$48,$0a,$48
	dc.b	$0d,$58,$0d,$90,$06,$b0,$06,$60,$0f,$c0,$0f,$80,$07,$00,$00,$00
	dc.b	$fe,$3f,$f8,$1f,$f0,$0f,$e0,$07,$c0,$07,$c0,$03,$c0,$03,$e0,$03
	dc.b	$e0,$03,$e0,$07,$f0,$07,$f0,$0f,$e0,$1f,$e0,$3f,$f0,$7f,$f8,$ff
	dc.b	$00,$07,$00,$07,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$07,$80,$1b,$60,$24,$90,$48,$50,$4b,$8e,$48,$d8,$78,$20,$00,$00
	dc.b	$00,$00,$00,$00,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$f8,$7f
	dc.b	$e0,$1f,$c0,$0f,$80,$07,$00,$01,$00,$00,$00,$01,$03,$07,$03,$df
	dc.b	$ff,$ff,$ff,$ff,$00,$07,$00,$07,$00,$00,$01,$00,$03,$80,$07,$c0
	dc.b	$0f,$e0,$03,$80,$03,$80,$03,$80,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$fe,$ff,$fc,$7f,$f8,$3f,$f0,$1f
	dc.b	$e0,$0f,$e0,$0f,$f8,$3f,$f8,$3f,$f8,$3f,$ff,$ff,$ff,$ff,$ff,$ff
	dc.b	$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$00,$07,$00,$07,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$03,$80,$03,$80
	dc.b	$03,$80,$0f,$e0,$07,$c0,$03,$80,$01,$00,$00,$00,$ff,$ff,$ff,$ff
	dc.b	$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$f8,$3f,$f8,$3f,$f8,$3f
	dc.b	$e0,$0f,$e0,$0f,$f0,$1f,$f8,$3f,$fc,$7f,$fe,$ff,$00,$07,$00,$07
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01,$e0,$06,$d8
	dc.b	$09,$24,$0a,$12,$71,$d2,$1b,$12,$04,$1e,$00,$00,$00,$00,$00,$00
	dc.b	$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$fe,$1f,$f8,$07,$f0,$03
	dc.b	$e0,$01,$80,$00,$00,$00,$80,$00,$e0,$c0,$fb,$c0,$ff,$ff,$ff,$ff
UDMPTR:
	dc.b	$00,$07,$00,$07
D_55364:
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$07,$00,$07,$00,$f8,$01,$04,$02,$2a,$02,$63,$02,$27,$12,$73
	dc.b	$15,$07,$6e,$fe,$10,$7c,$14,$10,$18,$18,$10,$18,$08,$38,$07,$f0
	dc.b	$03,$e0,$00,$00,$fe,$07,$fc,$03,$f8,$01,$f8,$00,$f8,$00,$d8,$00
	dc.b	$c0,$00,$00,$00,$80,$00,$80,$01,$80,$03,$80,$0f,$c0,$0f,$e0,$0f
	dc.b	$f0,$1f,$f8,$3f,$00,$07,$00,$07,$00,$00,$3c,$00,$7e,$00,$7f,$00
	dc.b	$7f,$00,$7f,$80,$3f,$80,$0e,$40,$01,$80,$01,$c0,$00,$e0,$00,$70
	dc.b	$00,$78,$00,$58,$00,$60,$00,$00,$c3,$ff,$80,$ff,$00,$7f,$00,$7f
	dc.b	$00,$3f,$00,$3f,$80,$1f,$c0,$1f,$f0,$1f,$fc,$0f,$fe,$07,$ff,$03
	dc.b	$ff,$01,$ff,$01,$ff,$03,$ff,$87
D_5542c:
	dc.b	$5b,$20,$50,$75,$73,$68,$5f,$4d,$41,$20,$5d,$20,$3a,$20,$4d,$41
	dc.b	$20,$53,$74,$61,$63,$6b,$20,$6f,$76,$65,$72,$66,$6c,$6f,$77,$20
	dc.b	$21,$21,$21,$0d,$00
D_55451:
	dc.b	$5b,$20,$50,$6f,$70,$5f,$4d,$41,$20,$5d,$20,$3a,$20,$4d,$41,$20
	dc.b	$53,$74,$61,$63,$6b,$20,$75,$6e,$64,$65,$72,$66,$6c,$6f,$77,$20
	dc.b	$21,$21,$21,$0d,$00
D_55476:
	dc.b	$5b,$20,$50,$75,$73,$68,$5f,$4d,$70,$74,$72,$20,$5d,$20,$3a,$20
	dc.b	$49,$6c,$6c,$65,$67,$61,$6c,$20,$69,$6e,$70,$75,$74,$20,$21,$21
	dc.b	$21,$0d,$00
D_55499:
	dc.b	$5b,$20,$50,$75,$73,$68,$5f,$4d,$70,$74,$72,$20,$5d,$20,$3a,$20
	dc.b	$53,$74,$61,$63,$6b,$20,$69,$73,$20,$66,$75,$6c,$6c,$20,$21,$21
	dc.b	$21,$0d,$00
D_554bc:
	dc.b	$5b,$20,$50,$6f,$70,$5f,$4d,$70,$74,$72,$20,$5d,$20,$3a,$20,$53
	dc.b	$74,$61,$63,$6b,$20,$69,$73,$20,$65,$6d,$70,$74,$79,$20,$21,$21
	dc.b	$21,$0d,$00
D_554df:
	dc.b	$5b,$20,$43,$68,$61,$6e,$67,$65,$5f,$4d,$70,$74,$72,$20,$5d,$20
	dc.b	$3a,$20,$49,$6c,$6c,$65,$67,$61,$6c,$20,$69,$6e,$70,$75,$74,$20
	dc.b	$21,$21,$21,$0d,$00
D_55504:
	dc.b	$59,$6f,$75,$20,$64,$6f,$20,$6e,$6f,$74,$20,$68,$61,$76,$65,$20
	dc.b	$65,$6e,$6f,$75,$67,$68,$20,$6d,$65,$6d,$6f,$72,$79,$20,$74,$6f
	dc.b	$20,$72,$75,$6e,$20,$41,$6d,$62,$65,$72,$73,$74,$61,$72,$21,$0d
	dc.b	$00
D_55535:
	dc.b	$50,$6c,$65,$61,$73,$65,$20,$72,$65,$6d,$6f,$76,$65,$20,$61,$6e
	dc.b	$79,$20,$61,$64,$64,$69,$74,$69,$6f,$6e,$61,$6c,$20,$70,$72,$6f
	dc.b	$67,$72,$61,$6d,$73,$20,$79,$6f,$75,$20,$68,$61,$76,$65,$2c,$0d
	dc.b	$00
D_55566:
	dc.b	$74,$68,$65,$6e,$20,$73,$74,$61,$72,$74,$20,$61,$67,$61,$69,$6e
	dc.b	$2e,$0d,$00
D_55579:
	dc.b	$50,$72,$65,$73,$73,$20,$61,$6e,$79,$20,$6b,$65,$79,$20,$74,$6f
	dc.b	$20,$72,$65,$73,$65,$74,$2e,$0d,$00
D_55592:
	dc.b	$5b,$20,$4b,$69,$6c,$6c,$5f,$6d,$65,$6d,$6f,$72,$79,$20,$5d,$20
	dc.b	$3a,$20,$4d,$65,$6d,$6f,$72,$79,$20,$77,$61,$73,$6e,$27,$74,$20
	dc.b	$61,$6c,$6c,$6f,$63,$61,$74,$65,$64,$20,$21,$21,$21,$0d,$00
D_555c1:
	dc.b	$5b,$20,$46,$72,$65,$65,$5f,$6d,$65,$6d,$6f,$72,$79,$20,$5d,$20
	dc.b	$3a,$20,$4d,$65,$6d,$6f,$72,$79,$20,$77,$61,$73,$6e,$27,$74,$20
	dc.b	$61,$6c,$6c,$6f,$63,$61,$74,$65,$64,$20,$21,$21,$21,$0d,$00
D_555f0:
	dc.b	$5b,$20,$53,$68,$72,$69,$6e,$6b,$5f,$6d,$65,$6d,$6f,$72,$79,$20
	dc.b	$5d,$20,$3a,$20,$4e,$65,$67,$61,$74,$69,$76,$65,$20,$73,$68,$72
	dc.b	$69,$6e,$6b,$20,$21,$21,$21,$0d,$00
D_55619:
	dc.b	$5b,$20,$53,$68,$72,$69,$6e,$6b,$5f,$6d,$65,$6d,$6f,$72,$79,$20
	dc.b	$5d,$20,$3a,$20,$4d,$65,$6d,$6f,$72,$79,$20,$77,$61,$73,$6e,$27
	dc.b	$74,$20,$61,$6c,$6c,$6f,$63,$61,$74,$65,$64,$20,$21,$21,$21,$0d
	dc.b	$00
D_5564a:
	dc.b	$5b,$20,$46,$69,$6c,$65,$5f,$61,$6c,$6c,$6f,$63,$61,$74,$65,$20
	dc.b	$5d,$20,$3a,$20,$4f,$75,$74,$20,$6f,$66,$20,$6d,$65,$6d,$6f,$72
	dc.b	$79,$20,$21,$21,$21,$0d,$00
D_55671:
	dc.b	$5b,$20,$41,$6c,$6c,$6f,$63,$61,$74,$65,$5f,$6d,$65,$6d,$6f,$72
	dc.b	$79,$20,$5d,$20,$3a,$20,$4f,$75,$74,$20,$6f,$66,$20,$6d,$65,$6d
	dc.b	$6f,$72,$79,$20,$21,$21,$21,$0d,$00,$3b,$9a,$ca,$00,$05,$f5,$e1
	dc.b	$00,$00,$98,$96,$80,$00,$0f,$42,$40,$00,$01,$86,$a0,$00,$00,$27
	dc.b	$10,$00,$00,$03,$e8,$00,$00,$00,$64,$00,$00,$00,$0a,$00,$00,$00
	dc.b	$01
D_556c2:
	dc.b	$5b,$20,$44,$65,$63,$5f,$63,$6f,$6e,$76,$65,$72,$74,$20,$5d,$20
	dc.b	$3a,$20,$4e,$75,$6d,$62,$65,$72,$20,$6f,$66,$20,$64,$69,$67,$69
	dc.b	$74,$73,$20,$74,$6f,$6f,$20,$68,$69,$67,$68,$20,$21,$21,$21,$0d
	dc.b	$00,$0a
D_556f4:
	dc.b	$5b,$20,$53,$65,$74,$5f,$73,$63,$72,$65,$65,$6e
D_55700:
	dc.b	$20,$5d,$20,$3a,$20,$49,$6c,$6c,$65,$67,$61,$6c,$20,$69,$6e,$70
	dc.b	$75,$74,$20,$21,$21,$21,$0d,$00

	section	bss

Last_key:
	ds.b	1
B_60925:
	ds.b	3
Erase_adr:
	ds.b	4
Erase_rout:
	ds.b	4
Erase_height:
	ds.b	2
Mouse_back_buffer:
	ds.b	256
Mouse_click_state:
	ds.b	1
Mouse_unclick_state:
	ds.b	1
Mouse_button_state:
	ds.b	2
B_60a36:
	ds.b	4
