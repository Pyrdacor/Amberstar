; MAIN/MODCON.ASM (original module, merged with the disassembly of the shipped program)

	section	text

; ---- Init_display (original source: MAIN/MODCON.ASM)
Init_display:
	movem.l	d0-d7/a0-a6,-(sp)
	move.w	#$0,Draw_Cicon	; CHANGE: added
	jsr	My_vsync	; CHANGE: added
	movea.l	Module_sp,a1
	move.l	DisInit_ptr(a1),d0
	beq.s	.Exit
	movea.l	d0,a0
	jsr	(a0)
.Exit:
	movem.l	(sp)+,d0-d7/a0-a6
	rts	
; ---- Exit_display (original source: MAIN/MODCON.ASM)
Exit_display:
	movem.l	d0-d7/a0-a6,-(sp)
	move.w	#$0,Draw_Cicon	; CHANGE: added
	jsr	My_vsync	; CHANGE: added
	movea.l	Module_sp,a1
	move.l	DisExit_ptr(a1),d0
	beq.s	.Exit
	movea.l	d0,a0
	jsr	(a0)
.Exit:
	movem.l	(sp)+,d0-d7/a0-a6
	rts	
T_10938:
	movem.l	d0-d7/a0-a6,-(a7)
	st.b	Abort_list
.l_10942:
	movea.l	Module_sp,a1
	cmpa.l	#B_5b52a,a1
	beq.b	.l_1096c
	lea.l	-$2e(a1),a0
	move.l	a0,Module_sp
	move.l	$18(a1),d0
	beq.b	.l_10964
	movea.l	d0,a0
	jsr	(a0)
.l_10964:
	jsr	Pop_Mptr
	bra.b	.l_10942
.l_1096c:
	movem.l	(a7)+,d0-d7/a0-a6
	rts
Push_Module:
	movem.l	d0-d7/a0-a6,-(a7)
	move.w	#$0,Draw_Cicon
	jsr	My_vsync
	movea.l	Module_sp,a1
	lea.l	$2e(a1),a1
	cmpa.l	#Current_inventory_chardat_ptr,a1
	bmi.b	.l_109a4
	lea.l	D_31f48,a1
	jsr	DI_Error
	bra.b	.l_109d0
.l_109a4:
	move.l	a1,Module_sp
	moveq	#22,d7
.l_109ac:
	move.w	(a0)+,(a1)+
	dbra	d7,.l_109ac
	lea.l	-$2e(a1),a1
	st.b	Abort_list
	move.w	$2c(a1),d0
	jsr	Push_Mptr
	move.l	$14(a1),d0
	beq.b	.l_109d0
	movea.l	d0,a0
	jsr	(a0)
.l_109d0:
	movem.l	(a7)+,d0-d7/a0-a6
	rts
Pop_Module:
	movem.l	d0-d7/a0-a6,-(a7)
	jsr	T_1ccb8
	move.w	#$0,Draw_Cicon
	jsr	My_vsync
	movea.l	Module_sp,a1
	cmpa.l	#B_5b52a,a1
	bgt.b	.l_10a0a
	lea.l	D_31f75,a1
	jsr	DI_Error
	bra.b	.l_10a38
.l_10a0a:
	lea.l	-$2e(a1),a0
	move.l	a0,Module_sp
	move.l	$18(a1),d0
	beq.b	.l_10a22
	move.l	a1,-(a7)
	movea.l	d0,a0
	jsr	(a0)
	movea.l	(a7)+,a1
.l_10a22:
	st.b	Abort_list
	jsr	Pop_Mptr
	move.l	$28(a1),d0
	beq.b	.l_10a38
	movea.l	d0,a0
	jsr	(a0)
.l_10a38:
	movem.l	(a7)+,d0-d7/a0-a6
	rts
Input_handler:
	movem.l	d0-d2/a0,-(a7)
	sf.b	Abort_list
	move.w	Mouse_X,d0
	move.w	Mouse_Y,d1
	jsr	Find_object
	moveq	#0,d0
	move.b	Mouse_unclick_state,d0
	lsl.w	#$2,d0
	or.b	Mouse_click_state,d0
	lsl.w	#$2,d0
	or.b	Mouse_button_state,d0
	or.b	Mouse_click_state,d0
	lsl.w	#$8,d0
	swap	d0
	or.l	d2,d0
	clr.b	Mouse_click_state
	clr.b	Mouse_unclick_state
	movea.l	Module_sp,a0
	move.l	$c(a0),d1
	beq.b	.l_10a9c
	movea.l	d1,a0
	bsr.w	Handle_list
.l_10a9c:
	tst.b	Abort_list
	bne.b	.l_10ac4
	jsr	T_1ce70
	tst.l	d0
	beq.b	.l_10ac4
	bset	#$1f,d0
	movea.l	Module_sp,a0
	move.l	$10(a0),d1
	beq.b	.l_10ac4
	movea.l	d1,a0
	bsr.w	Handle_list
.l_10ac4:
	movem.l	(a7)+,d0-d2/a0
	rts
; ---- Handle_list (original source: MAIN/MODCON.ASM)
Handle_list:
	movem.l	d0-d7/a0-a6,-(sp)
.Again:
	tst.l	(a0)
	beq.s	.Exit
	move.l	(a0)+,d1
	and.l	d0,d1
	cmp.l	(a0)+,d1
	bne.s	.Next
	movem.l	d0/a0,-(sp)
	movea.l	(a0),a0
	jsr	(a0)
	movem.l	(sp)+,d0/a0
	tst.b	Abort_list
	bne.s	.Exit
.Next:
	addq.l	#4,a0
	bra.s	.Again
.Exit:
	movem.l	(sp)+,d0-d7/a0-a6
	rts	
; ---- ScrQ_handler (original source: MAIN/MODCON.ASM)
ScrQ_handler:
	movem.l	d0-d7/a0-a6,-(sp)
	movea.l	Module_sp,a0
	move.l	ScrQ_ptr(a0),d0
	beq.s	.Exit
	movea.l	d0,a0
.Loop:
	tst.l	(a0)
	beq.s	.Exit
	move.l	a0,-(sp)
	movea.l	(a0),a0
	jsr	(a0)
	movea.l	(sp)+,a0
	addq.l	#4,a0
	bra.s	.Loop
.Exit:
	movem.l	(sp)+,d0-d7/a0-a6
	rts	
; Calls the vertical blank routines of the module stack (the check of DangerZone was removed).
VblQ_handler:
	movem.l	d0-d7/a0-a6,-(a7)
	movea.l	Module_sp,a0
	move.l	$4(a0),d0
	beq.b	.l_10b42
	movea.l	d0,a0
.l_10b32:
	tst.l	(a0)
	beq.b	.l_10b42
	move.l	a0,-(a7)
	movea.l	(a0),a0
	jsr	(a0)
	movea.l	(a7)+,a0
	addq.l	#$4,a0
	bra.b	.l_10b32
.l_10b42:
	movem.l	(a7)+,d0-d7/a0-a6
	rts

	section	data

Module_sp:
	dc.l	Res_dat2_ptr

	section	bss

Abort_list:
	ds.b	2
B_5b52a:
	ds.b	736
