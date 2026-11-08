; NUCLEUS/SCREEN.ASM (original module, merged with the disassembly of the shipped program)

	section	text

; ---- Init_screen (original source: NUCLEUS/SCREEN.ASM)
Init_screen:
	movem.l	d0/d1,-(sp)
	move.l	#Screen,d0
	clr.b	d0
	addi.l	#256,d0
	move.l	d0,d1
	addi.l	#32000,d1
	move.l	d0,On_screen
	move.l	d1,Off_screen
	bsr.w	Set_screen
	movem.l	(sp)+,d0/d1
	rts	
; ---- Copy_screen (original source: NUCLEUS/SCREEN.ASM)
Copy_screen:
	movem.l	d0-d7/a0-a6,-(sp)
	jsr	Mouse_off
	movea.l	Screen_base,a0
	movea.l	Off_screen,a1
	move.w	#666-1,d7
.Loop:
	movem.l	(a0)+,d0-d6/a2-a6
	movem.l	d0-d6/a2-a6,(a1)
	lea.l	48(a1),a1
	dbra	d7,.Loop
	movem.l	(a0),d0-d6/a2
	movem.l	d0-d6/a2,(a1)
	jsr	Mouse_on
	movem.l	(sp)+,d0-d7/a0-a6
	rts	

; ---- Set_screen (original source: NUCLEUS/SCREEN.ASM) - the shipped program differs, its code follows, not assembled:
;Set_screen:
;             movem.l   d0/a0,-(sp)
;             tst.b     d0                   ; Error check on input
;             beq.s     .Ok
;             ERROR     "[ Set_screen ] : Illegal input !!!"
;             bra.s     .Exit
;.Ok:         move.l    d0,Screen_base       ; Store screen base
;             lea.l     Vbase_Hi-1,a0        ; Set screen base
;             lsr.w     #8,d0                ; (Trick by M.Bittner)
;             move.l    d0,(a0)
;.Exit:       movem.l   (sp)+,d0/a0
;             rts

Set_screen:
	movem.l	d0/a0,-(a7)
	tst.b	d0
	beq.b	.l_1d828
	lea.l	D_556f4,a1
	jsr	DI_Error
	bra.b	.l_1d836
.l_1d828:
	move.l	d0,Screen_base
	lea.l	$ffff8200.w,a0
	lsr.w	#$8,d0
	move.l	d0,(a0)
.l_1d836:
	movem.l	(a7)+,d0/a0
	rts

; ---- IG_Cursor_home (original source: NUCLEUS/TEXTPUT.ASM) - the shipped program differs, its code follows, not assembled:
;IG_Cursor_home:
;             move.w    PArea,Print_X        ; Back to 1st column
;             move.w    PArea+4,Print_Y      ; Back to 1st line
;             rts

; ---- Switch_screen (original source: NUCLEUS/SCREEN.ASM)
IG_Cursor_home:
Switch_screen:
	move.l	d0,-(sp)
	move.l	Off_screen,d0
	move.l	On_screen,Off_screen
	move.l	d0,On_screen
	bsr.w	Set_screen
	bsr.w	My_vsync
	jsr	ScrQ_handler
	move.l	(sp)+,d0
	rts	
; ---- Clear_screen (original source: NUCLEUS/SCREEN.ASM)
Clear_screen:
	movem.l	d0-d7/a0/a1,-(sp)
	movem.l	Void,d0-d6/a0
	lea.l	32000(a6),a1
	move.w	#1000-1,d7
.Loop:
	movem.l	d0-d6/a0,-(a1)
	dbra	d7,.Loop
	movem.l	(sp)+,d0-d7/a0/a1
	rts	
; ---- My_vsync (original source: NUCLEUS/SCREEN.ASM)
My_vsync:
	movem.l	d0-d2/a0-a2,-(sp)
	move.w	#$25,-(sp)
	trap	#14
	addq.l	#2,sp
	movem.l	(sp)+,d0-d2/a0-a2
	rts	

	section	bss

On_screen:
	ds.b	4
Off_screen:
	ds.b	4
Screen_base:
	ds.b	4
Screen:
	ds.b	65280
B_76734:
	ds.b	2
B_76736:
	ds.b	2
