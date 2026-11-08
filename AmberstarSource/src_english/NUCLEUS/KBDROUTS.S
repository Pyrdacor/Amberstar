; NUCLEUS/KBDROUTS.ASM (original module, merged with the disassembly of the shipped program)

Push_MA:
	movem.l	d0-d2/a0-a1,-(a7)
	bsr.w	Mouse_off
	movea.l	MA_sp,a1
	addq.l	#$4,a1
	move.l	Mouse_X,(a1)+
	cmpa.l	#Last_key,a1
	bmi.b	.l_1cd02
	lea.l	D_523fa,a1
	jsr	DI_Error
	bra.b	.l_1cd0e
.l_1cd02:
	move.l	a0,(a1)
	move.l	a1,MA_sp
	bsr.w	T_1cd18
.l_1cd0e:
	bsr.w	Mouse_on
	movem.l	(a7)+,d0-d2/a0-a1
	rts
T_1cd18:
	movem.l	d0-d1/a1,-(a7)
	movea.l	MA_sp,a1
	movea.l	(a1),a1
	move.w	Mouse_X,d0
	move.w	d0,d1
	sub.w	(a1),d1
	bpl.b	.l_1cd38
	move.w	(a1),Mouse_X
	bra.b	.l_1cd46
.l_1cd38:
	sub.w	$2(a1),d0
	blt.b	.l_1cd46
	move.w	$2(a1),Mouse_X
.l_1cd46:
	move.w	Mouse_Y,d0
	move.w	d0,d1
	sub.w	$4(a1),d1
	bpl.b	.l_1cd5e
	move.w	$4(a1),Mouse_Y
	bra.b	.l_1cd6c
.l_1cd5e:
	sub.w	$6(a1),d0
	blt.b	.l_1cd6c
	move.w	$6(a1),Mouse_Y
.l_1cd6c:
	movem.l	(a7)+,d0-d1/a1
	rts
Pop_MA:
	movem.l	d0-d2/a0-a1,-(a7)
	bsr.w	Mouse_off
	movea.l	MA_sp,a1
	cmpa.l	#B_5d8b2,a1
	bhi.b	.l_1cd96
	lea.l	D_5241f,a1
	jsr	DI_Error
	bra.b	.l_1cda8
.l_1cd96:
	move.l	-(a1),Mouse_X
	subq.l	#$4,a1
	move.l	a1,MA_sp
	bsr.w	T_1cd18
.l_1cda8:
	bsr.w	Mouse_on
	movem.l	(a7)+,d0-d2/a0-a1
	rts
Push_Mptr:
	movem.l	d0/a0-a1,-(a7)
	bsr.w	Mouse_off
	cmpi.w	#$1b,d0
	bmi.b	.l_1cdce
	lea.l	D_52444,a1
	jsr	DI_Error
	bra.b	.l_1ce00
.l_1cdce:
	lea.l	Mouse_base,a0
	mulu.w	#$44,d0
	adda.w	d0,a0
	movea.l	Mptr_sp,a1
	addq.l	#$4,a1
	cmpa.l	#Mouse_flag,a1
	bmi.b	.l_1cdf8
	lea.l	D_52467,a1
	jsr	DI_Error
	bra.b	.l_1ce00
.l_1cdf8:
	move.l	a0,(a1)
	move.l	a1,Mptr_sp
.l_1ce00:
	bsr.w	Mouse_on
	movem.l	(a7)+,d0/a0-a1
	rts
Pop_Mptr:
	move.l	a1,-(a7)
	bsr.w	Mouse_off
	movea.l	Mptr_sp,a1
	cmpa.l	#D_51c84,a1
	bhi.b	.l_1ce2c
	lea.l	D_5248a,a1
	jsr	DI_Error
	bra.b	.l_1ce34
.l_1ce2c:
	subq.l	#$4,a1
	move.l	a1,Mptr_sp
.l_1ce34:
	bsr.w	Mouse_on
	movea.l	(a7)+,a1
	rts
Change_Mptr:
	movem.l	d0/a0-a1,-(a7)
	cmpi.w	#$1b,d0
	bmi.b	.l_1ce54
	lea.l	D_524ad,a1
	jsr	DI_Error
	bra.b	.l_1ce68
.l_1ce54:
	lea.l	Mouse_base,a0
	mulu.w	#$44,d0
	adda.w	d0,a0
	movea.l	Mptr_sp,a1
	move.l	a0,(a1)
.l_1ce68:
	movem.l	(a7)+,d0/a0-a1
	rts
T_1ce6e:
	movem.l	d1-d3/a0-a2,-(a7)
	move.w	#$b,-(a7)
	trap	#$1
	addq.l	#$2,a7
	tst.w	d0
	bne.b	.l_1cea8
	movea.l	$4f2.w,a0
	cmpi.w	#$102,$2(a0)
	bmi.b	.l_1ce94
	movea.l	$24(a0),a0
	move.b	$1e(a0),d1
	bra.b	.l_1ce98
.l_1ce94:
	move.b	$e39.w,d1
.l_1ce98:
	cmp.b	B_5d8f3,d1
	bne.b	.l_1ced0
	move.l	Last_key,d0
	bra.b	.l_1ced0
.l_1cea8:
	move.w	#$7,-(a7)
	trap	#$1
	addq.l	#$2,a7
	move.l	d0,d3
.l_1ceb2:
	move.w	#$b,-(a7)
	trap	#$1
	addq.l	#$2,a7
	tst.w	d0
	beq.b	.l_1cec8
	move.w	#$7,-(a7)
	trap	#$1
	addq.l	#$2,a7
	bra.b	.l_1ceb2
.l_1cec8:
	move.l	d3,d0
	move.l	d0,Last_key
.l_1ced0:
	movem.l	(a7)+,d1-d3/a0-a2
	rts
Wait_4_key:
	movem.l	d1-d2/a0-a2,-(a7)
	move.w	#$7,-(a7)
	trap	#$1
	addq.l	#$2,a7
	movem.l	(a7)+,d1-d2/a0-a2
	rts
T_1cee8:
	move.l	#D_51c78,B_5d8b2
	bsr.w	Draw_mouse
	rts
T_1cef8:
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
	bpl.b	.l_1cf3e
	move.w	(a1),d1
	bra.b	.l_1cf4c
.l_1cf3e:
	move.w	d1,d2
	sub.w	$2(a1),d2
	blt.b	.l_1cf4c
	move.w	$2(a1),d1
	bra.b	.l_1cf52
.l_1cf4c:
	move.w	d1,Mouse_X
.l_1cf52:
	move.w	Mouse_Y,d1
	move.b	$2(a0),d0
	ext.w	d0
	add.w	d0,d1
	move.w	d1,d2
	sub.w	$4(a1),d2
	bpl.b	.l_1cf6e
	move.w	$4(a1),d1
	bra.b	.l_1cf7a
.l_1cf6e:
	dc.b	$34,$01,$94,$69,$00,$06,$6d,$04,$32,$29,$00,$06
.l_1cf7a:
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
	move.l	#T_1d162,Erase_rout
	jsr	Coord_convert
	move.w	d3,d0
	lea.l	(a6,d2.w),a1
	move.l	a1,Erase_adr
.l_1d076:
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
	dbra	d7,.l_1d076
	rts
Mouse_draw_left:
	move.l	#T_1d174,Erase_rout
	addi.w	#$10,d0
	jsr	Coord_convert
	move.w	d3,d0
	lea.l	(a6,d2.w),a1
	move.l	a1,Erase_adr
.l_1d0e2:
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
	dbra	d7,.l_1d0e2
	rts
Mouse_draw_right:
	move.l	#T_1d182,Erase_rout
	jsr	Coord_convert
	move.w	d3,d0
	lea.l	(a6,d2.w),a1
	move.l	a1,Erase_adr
.l_1d132:
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
	dbra	d7,.l_1d132
	rts
T_1d162:
	movem.l	(a2)+,d0-d3
	movem.l	d0-d3,(a3)
	lea.l	$a0(a3),a3
	dbra	d7,T_1d162
	rts
T_1d174:
	move.l	(a2)+,(a3)+
	move.l	(a2)+,(a3)+
	lea.l	$98(a3),a3
	dbra	d7,T_1d174
	rts
T_1d182:
	move.l	(a2)+,(a3)+
	move.l	(a2)+,(a3)+
	lea.l	$98(a3),a3
	dbra	d7,T_1d182
	rts
T_1d190:
	movem.l	d0-d1/a0,-(a7)
	move.l	$18(a0),d0
	add.l	$1c(a0),d0
	move.l	d0,B_5da04
	move.l	$4(a0),d1
	sub.l	d0,d1
	cmpi.l	#$4b000,d1
	bpl.b	.l_1d210
	movem.l	d0-d7/a0-a6,-(a7)
	jsr	T_1c0e8
	jsr	T_1c1aa
	movea.l	Screen_base,a6
	lea.l	D_524d2,a0
	jsr	DI_Print
	lea.l	D_52503,a0
	jsr	DI_Print
	lea.l	D_52534,a0
	jsr	DI_Print
	lea.l	D_52547,a0
	jsr	DI_Print
	jsr	Wait_4_key
	jsr	T_1c15e
	movem.l	(a7)+,d0-d7/a0-a6
	movea.l	$4f2.w,a0
	movea.l	$4(a0),a0
	jmp	(a0)
.l_1d210:
	move.l	d1,Size_of_free_memory
	move.l	d1,B_5da0c
	lea.l	Memory_list,a0
	move.l	d0,(a0)+
	move.l	d1,(a0)+
	move.l	#$80000000,(a0)+
	move.l	a0,Memlist_end
	movem.l	(a7)+,d0-d1/a0
	rts
