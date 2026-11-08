; NUCLEUS/DIAGNOST.ASM (original module, merged with the disassembly of the shipped program)

	section	text

; ---- DI_Error (original source: NUCLEUS/DIAGNOST.ASM)
DI_Error:
	movem.l	d0-d2/a0-a2/a6,-(sp)
	bsr.w	ON_Diag_screen
	movea.l	Screen_base,a6
	bsr.w	DI_Cursor_home
	lea.l	Error_msg1,a0
	bsr.w	DI_Print
	movea.l	a1,a0
	bsr.w	DI_Print
	lea.l	Error_msg2,a0
	bsr.w	DI_Print
	move.w	#$7,-(a7)	; CHANGE: was "cmpi.b #"x",d0"
	trap	#$1	; CHANGE: was "bne.s .Exit"
	addq.l	#$2,a7	; CHANGE: was "illegal"
	cmpi.b	#$78,d0	; CHANGE: added
	beq.b	.Exit	; CHANGE: added
	movea.l	$4f2.w,a0	; CHANGE: added
	movea.l	$4(a0),a0	; CHANGE: added
	jmp	(a0)	; CHANGE: added
.Exit:
	bsr.w	OFF_Diag_screen
	movem.l	(sp)+,d0-d2/a0-a2/a6
	rts	
ON_Diag_screen:
	movem.l	d0/a0/a6,-(a7)
	tst.b	B_6046c
	bne.b	.l_1c15a
	st.b	B_6046c
	jsr	Mouse_off
	move.l	$ffff8240.w,B_60472
	move.l	$ffff8244.w,B_60476
	move.l	Screen_base,Prev_screen
	jsr	HBL_off
	jsr	My_vsync
	move.b	#$1,$ffff8260.w
	moveq	#0,d0
	move.w	Old_screen,d0
	lsl.l	#$8,d0
	jsr	Set_screen
	movea.l	Screen_base,a6
	jsr	Clear_screen
	move.l	Diag_pal,$ffff8240.w
	move.l	D_54b04,$ffff8244.w
.l_1c15a:
	movem.l	(a7)+,d0/a0/a6
	rts
OFF_Diag_screen:
	move.l	a0,-(a7)
	sf.b	B_6046c
	jsr	My_vsync
	move.b	#$0,$ffff8260.w
	move.l	B_60472,$ffff8240.w
	move.l	B_60476,$ffff8244.w
	move.l	Prev_screen,d0
	jsr	Set_screen
	jsr	HBL_on
	jsr	Mouse_on
	movea.l	(a7)+,a0
	rts
; ---- Init_DI_print (original source: NUCLEUS/DIAGNOST.ASM)
Init_DI_print:
	dc.w	$a000
	move.l	-22(a0),DI_Font_ptr
	rts	
; ---- DI_Cursor_home (original source: NUCLEUS/DIAGNOST.ASM)
DI_Cursor_home:
	clr.w	Print_X
	clr.w	B_60480	; CHANGE: was "clr.w Print_Y"
	rts	
; ---- DI_Carriage_return (original source: NUCLEUS/DIAGNOST.ASM)
DI_Carriage_return:
	move.l	d0,-(sp)
	clr.w	Print_X
	move.w	B_60480,d0	; CHANGE: was "move.w Print_Y,d0"
	addi.w	#8*160,d0
	cmpi.w	#32000,d0
	bmi.s	.Exit
	jsr	Wait_4_key	; CHANGE: added
	movea.l	Screen_base,a6	; CHANGE: added
	jsr	Clear_screen	; CHANGE: added
	moveq.l	#0,d0
.Exit:
	move.w	d0,B_60480	; CHANGE: was ".Exit: move.w d0,Print_Y"
	move.l	(sp)+,d0
	rts	
; ---- DI_Backspace (original source: NUCLEUS/DIAGNOST.ASM)
DI_Backspace:
	move.l	d0,-(sp)
	move.w	Print_X,d0
	btst	#0,d0
	bne.s	.Odd_address
	subq.w	#3,d0
	bra.s	.Skip
.Odd_address:
	subq.w	#1,d0
.Skip:
	tst.w	d0
	bmi.s	.Exit
	move.w	d0,Print_X
.Exit:
	move.l	(sp)+,d0
	rts	
; ---- DI_Input (original source: NUCLEUS/DIAGNOST.ASM)
DI_Input:
	movem.l	d2-d4/d7/a0/a1,-(sp)
	bsr.w	DI_Print
	lea.l	D_54b62,a0	; CHANGE: was "lea.l Output_string,a0"
	lea.l	B_6046d,a1	; CHANGE: was "lea.l Input_buffer,a1"
	moveq.l	#0,d7
	move.b	#$20,$1(a0)	; CHANGE: was "move.b #" ",1(a0)"
	bsr.w	DI_Print
.Again:
	jsr	Wait_4_key
	cmpi.b	#$d,d0
	beq.s	.Return
	swap.w	d0
	cmpi.b	#$e,d0
	beq.s	.Backspace
	swap.w	d0
	cmpi.b	#$30,d0	; CHANGE: was "cmpi.b #"0",d0"
	bmi.s	.Again
	cmpi.b	#$39,d0	; CHANGE: was "cmpi.b #"9",d0"
	bhi.s	.Again
	move.b	d0,1(a0)
	bsr.w	DI_Print
	subi.b	#$30,d0	; CHANGE: was "subi.b #"0",d0"
	addq.l	#1,d7
	move.b	d0,-1(a1,d7.w)
	cmpi.b	#Max_digits,d7
	bmi.s	.Again
	bra.s	.Return
.Backspace:
	tst.w	d7
	beq.s	.Again
	lea.l	Backspace_string,a0
	bsr.w	DI_Print
	lea.l	D_54b62,a0	; CHANGE: was "lea.l Output_string,a0"
	subq.l	#1,d7
	bra.s	.Again
.Return:
	lea.l	End_string,a0
	bsr.w	DI_Print
	moveq.l	#0,d0
	moveq.l	#1,d2
	moveq.l	#10,d3
	subq.l	#1,d7
	bpl.s	.Loop
	moveq.l	#-1,d0
	bra.s	.Exit
.Loop:
	moveq.l	#0,d4
	move.b	0(a1,d7.w),d4
	mulu.w	d2,d4
	add.l	d4,d0
	mulu.w	d3,d2
	dbra	d7,.Loop
.Exit:
	movem.l	(sp)+,d2-d4/d7/a0/a1
	rts	
; ---- DI_Hexw_print (original source: NUCLEUS/DIAGNOST.ASM)
DI_Hexl_print:
DI_Hexb_print:
DI_Hexw_print:
	movem.l	d7/a0,-(sp)
	moveq	#2,d7	; CHANGE: was "moveq.l #4,d7"
	jsr	Hex_convert
	bsr.w	DI_Print
	movem.l	(sp)+,d7/a0
	rts	
	movem.l	d7/a0,-(a7)
	moveq	#4,d7
	jsr	Hex_convert
	bsr.w	DI_Print
	movem.l	(a7)+,d7/a0
	rts
T_1c2e0:
	movem.l	d7/a0,-(a7)
	moveq	#8,d7
	jsr	Hex_convert
	bsr.w	DI_Print
	movem.l	(a7)+,d7/a0
	rts
; ---- DI_Decb_print (original source: NUCLEUS/DIAGNOST.ASM)
DI_Decb_print:
	movem.l	d7/a0,-(sp)
	ext.w	d0
	ext.l	d0
	moveq.l	#3,d7
	jsr	Dec_convert
	bsr.w	DI_Print
	movem.l	(sp)+,d7/a0
	rts	
; ---- DI_Decw_print (original source: NUCLEUS/DIAGNOST.ASM)
DI_Decw_print:
	movem.l	d7/a0,-(sp)
	ext.l	d0
	moveq.l	#5,d7
	jsr	Dec_convert
	bsr.w	DI_Print
	movem.l	(sp)+,d7/a0
	rts	
; ---- DI_Decl_print (original source: NUCLEUS/DIAGNOST.ASM)
DI_Decl_print:
	movem.l	d7/a0,-(sp)
	moveq.l	#10,d7
	jsr	Dec_convert
	bsr.w	DI_Print
	movem.l	(sp)+,d7/a0
	rts	
; ---- DI_Print (original source: NUCLEUS/DIAGNOST.ASM)
DI_Print:
	movem.l	d0/a0/a1,-(sp)
	movea.l	DI_Font_ptr,a1
.Again:
	moveq.l	#0,d0
	move.b	(a0)+,d0
	beq.s	.Exit
	cmpi.b	#13,d0
	bne.s	.Skip1
	bsr.w	DI_Carriage_return
	bra.s	.Again
.Skip1:
	cmpi.b	#1,d0
	bne.s	.Skip2
	move.w	#-1,Inverse
	bra.s	.Again
.Skip2:
	cmpi.b	#2,d0
	bne.s	.Skip3
	move.w	#0,Inverse
	bra.s	.Again
.Skip3:
	cmpi.b	#3,d0
	bne.s	.Skip4
	move.b	(a0)+,d0
	andi.b	#3,d0
	move.b	d0,Ink
	bra.s	.Again
.Skip4:
	cmpi.b	#$e,d0
	bne.s	.Skip5
	bsr.w	DI_Backspace
	bra.s	.Again
.Skip5:
	bsr.w	DI_Pchar
	bra.s	.Again
.Exit:
	movem.l	(sp)+,d0/a0/a1
	rts	
; ---- DI_Pchar (original source: NUCLEUS/DIAGNOST.ASM)
DI_Pchar:
	movem.l	d0-d2/d7/a1/a6,-(sp)
	adda.w	Print_X,a6
	adda.w	B_60480,a6	; CHANGE: was "adda.w Print_Y,a6"
	adda.w	d0,a1
	move.b	Ink,d0
	move.w	Inverse,d2
	btst	#0,d0
	sne	d1
	lsl.w	#8,d1
	btst	#1,d0
	sne	d1
	moveq.l	#7,d7
.Loop:
	move.b	(a1),d0
	lsl.w	#8,d0
	move.b	(a1),d0
	eor.w	d2,d0
	and.w	d1,d0
	movep.w	d0,0(a6)
	lea.l	256(a1),a1
	lea.l	160(a6),a6
	dbra	d7,.Loop
	move.w	Print_X,d0
	btst	#0,d0
	bne.s	.Odd_address
	addq.w	#1,d0
	bra.s	.Skip
.Odd_address:
	addq.w	#3,d0
	cmpi.w	#160,d0
	bmi.s	.Skip
	bsr.w	DI_Carriage_return
	bra.s	.Exit
.Skip:
	move.w	d0,Print_X
.Exit:
	movem.l	(sp)+,d0-d2/d7/a1/a6
	rts	

	section	data

Diag_pal:
	dc.b	$00,$00,$07,$77
D_54b04:
	dc.b	$00,$57,$05,$55
Ink:
	dc.b	$01
Error_msg1:
	dc.b	$03,$02,$01,$20,$21,$21,$21,$20,$41,$6e,$20,$45,$52,$52,$4f,$52
	dc.b	$20,$68,$61,$73,$20,$6f,$63,$63,$75,$72,$72,$65,$64,$20,$21,$21
	dc.b	$21,$20,$0d,$0d,$02,$03,$01,$00
Error_msg2:
	dc.b	$0d,$03,$02,$01,$20,$50,$72,$65,$73,$73,$20,$61,$6e,$79,$20,$6b
	dc.b	$65,$79,$20,$74,$6f,$20,$63,$6f,$6e,$74,$69,$6e,$75,$65,$2e,$2e
	dc.b	$2e,$20,$20,$0d,$0d,$02,$00
Backspace_string:
	dc.b	$0e,$0e,$5f,$20,$0e,$00
End_string:
	dc.b	$0e,$20,$0d,$00
D_54b62:
	dc.b	$0e,$20,$5f,$00

	section	bss

Prev_screen:
	ds.b	4
Print_X:
	ds.b	2
B_60480:
	ds.b	2
Inverse:
	ds.b	2
DI_Font_ptr:
	ds.b	4
HBL_flag:
	ds.b	2
