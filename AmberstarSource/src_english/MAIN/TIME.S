; MAIN/TIME.ASM (original module, merged with the disassembly of the shipped program)

; ---- Init_time (original source: MAIN/TIME.ASM)
Init_time:
	movem.l	d0/d1,-(sp)
	moveq.l	#0,d0
	move.b	Time_hour_len(a5),d0
	mulu.w	Hour,d0
	moveq.l	#0,d1
	move.w	Minute,d1
	add.l	d1,d0
	moveq.l	#0,d1
	move.b	Time_step_len(a5),d1
	divu.w	d1,d0
	move.w	d0,Current_step
	movem.l	(sp)+,d0/d1
	rts	
; ---- Update_time (original source: MAIN/TIME.ASM)
Update_time:
	st	New_step
	movem.l	d0/d1/a0,-(sp)
	bsr.w	Every_step
	moveq.l	#0,d1
	movea.l	Mapd_ptr,a0
	addq.w	#1,Current_step
	move.w	Minute,d0
	move.b	Time_step_len(a0),d1
	add.w	d1,d0
	move.w	d0,Minute
	move.b	Time_hour_len(a0),d1
	sub.w	d1,d0
	bmi.w	.Exit
	move.w	d0,Minute
	move.w	Hour,d0
	addq.w	#1,d0
	move.w	d0,Hour
	bsr.w	Every_hour
	move.b	Time_day_len(a0),d1
	sub.w	d1,d0
	bmi.s	.Exit
	move.w	d0,Hour
	move.w	#0,Current_step
	addq.w	#1,Nr_travelled_days
	move.w	Day,d0
	addq.w	#1,d0
	move.w	d0,Day
	bsr.w	Every_day
	move.b	Time_month_len(a0),d1
	sub.w	d1,d0
	bls.s	.Exit
	move.w	d0,Day
	move.w	Month,d0
	addq.w	#1,d0
	move.w	d0,Month
	move.b	Time_year_len(a0),d1
	sub.w	d1,d0
	bls.s	.Exit
	move.w	d0,Month
	addq.w	#1,Year
	addq.w	#1,Time_data_year
	bsr.w	Every_year
.Exit:
	movem.l	(sp)+,d0/d1/a0
	rts	
; ---- Every_step (original source: MAIN/TIME.ASM)
Every_step:
	movem.l	d7/a0,-(sp)
	lea.l	Spell_1_duration,a0
	moveq.l	#6-1,d7
.Loop:
	tst.w	(a0)
	beq.s	.Next
	subq.w	#1,(a0)
.Next:
	addq.l	#2,a0
	dbra	d7,.Loop
	tst.w	B_5930c	; CHANGE: added
	beq.b	.c_06618	; CHANGE: added
	subq.w	#$1,B_5930c	; CHANGE: added
	bne.b	.c_06618	; CHANGE: added
	cmpi.w	#$5,Travel_mode	; CHANGE: added
	bpl.b	.c_06618	; CHANGE: added
	st.b	D_1e1fa	; CHANGE: added
.c_06618:
	movem.l	(sp)+,d7/a0
	rts	
; ---- Every_hour (original source: MAIN/TIME.ASM)
Every_hour:
	movem.l	d0-d2/d7/a0/a1,-(sp)
	lea.l	Chard_ptrs,a0
	moveq.l	#1,d7
.Loop:
	tst.l	(a0)
	beq.s	.Next
	movea.l	(a0),a1
	move.w	#$e400,d2
	and.w	Body_conditions(a1),d2
	bne.s	.Next
	btst	#1,Body_conditions(a1)
	beq.s	.Next
	jsr	Random
	moveq.l	#5,d1
	mulu.w	d0,d1
	swap.w	d1
	addq.w	#1,d1
	move.w	d7,d0
	bsr.w	Do_damage
.Next:
	addq.l	#4,a0
	addq.w	#1,d7
	cmpi.w	#6+1,d7
	bmi.s	.Loop
	movem.l	(sp)+,d0-d2/d7/a0/a1
	rts	
; ---- Every_day (original source: MAIN/TIME.ASM)
Every_day:
	movem.l	d0/d1/d7/a0/a1,-(sp)
	lea.l	Chard_ptrs,a0
	moveq.l	#0,d1
	moveq.l	#1,d7
.Loop:
	tst.l	(a0)
	beq.s	.Next
	movea.l	(a0),a1
	move.w	#$e400,d0
	and.w	Body_conditions(a1),d0
	bne.s	.Next
	btst	#3,Body_conditions(a1)
	beq.s	.Next
	lea.l	Attr_1_normal(a1),a2
	jsr	Random
	mulu.w	#8,d0
	swap.w	d0
	add.w	d0,d0
	adda.w	d0,a2
	move.w	(a2),d0
	cmpi.w	#1,d0
	beq.s	.Done
	subq.w	#1,d0
	move.w	d0,(a2)
.Done:
	move.w	d7,d0
	bsr.w	Do_damage
.Next:
	addq.l	#4,a0
	addq.w	#1,d7
	cmpi.w	#6+1,d7
	bmi.s	.Loop
	movem.l	(sp)+,d0/d1/d7/a0/a1
	rts	
; ---- Every_year (original source: MAIN/TIME.ASM)
Every_year:
	movem.l	d0/d1/d7/a0/a1,-(sp)
	lea.l	Chard_ptrs,a0
	moveq.l	#1,d7
.Loop:
	tst.l	(a0)
	beq.s	.Next
	movea.l	(a0),a1
	move.w	#$e400,d0
	and.w	Body_conditions(a1),d0
	bne.s	.Next
	move.w	Attr_9_normal(a1),d0
	add.w	Attr_9_normal_magic(a1),d0
	add.w	Time_data_year,d0
	move.w	Attr_9_max(a1),d1
	cmp.w	d0,d1
	bpl.s	.Next
	ori.w	#$2000,Body_conditions(a1)
	cmp.w	Active_member,d7
	bne.s	.Next
; CHANGE: removed "clr.w Active_member"
	bsr.w	Check_party_alive	; CHANGE: was "jsr Exit_display"
; CHANGE: removed "move.l a0,-(sp)"
; CHANGE: removed "Push Module,ActSel_Mod"
; CHANGE: removed "Push Module,ActSel_Mod"
; CHANGE: removed "movea.l (sp)+,a0"
.Next:
	addq.l	#4,a0
	addq.w	#1,d7
	cmpi.w	#6+1,d7
	bmi.s	.Loop
	movem.l	(sp)+,d0/d1/d7/a0/a1
	rts	
; ---- Zzz (original source: MAIN/TIME.ASM)
Zzz:
	move.w	#0,Frame
	bsr.w	Update_time
	rts	
; ---- Realtime_step (original source: MAIN/TIME.ASM)
Realtime_step:
	move.l	d0,-(sp)
	tst.b	Time_lock
	bne.s	.Exit
	move.w	Frame,d0
	addq.w	#1,d0
	move.w	d0,Frame
	sub.w	Vbl_per_step,d0
	bmi.s	.Exit
	move.w	d0,Frame
	bsr.w	Update_time
.Exit:
	move.l	(sp)+,d0
	rts	
T_06752:
	cmpi.w	#$64,B_57d64
	bmi.w	T_067f8
	clr.w	B_57d64
DoAutoIcon:
	movem.l	d0-d3/d5-d7/a0-a3,-(a7)
	tst.b	AutoIcon_flag
	beq.w	T_067f4
	lea.l	Chard_ptrs,a0
	lea.l	Char_status_icons,a1
	lea.l	B_57d58,a3
	move.b	B_592dd,d5
	moveq	#1,d7
T_0678c:
	tst.l	(a0)
	beq.b	T_067e6
	btst	d7,d5
	beq.b	T_0679a
	move.b	#$14,(a1)
	bra.b	T_067e6
T_0679a:
	movea.l	(a0),a2
	move.w	$3a(a2),d1
	move.w	#$e000,d2
	and.w	d1,d2
	bne.b	T_067e6
	move.w	(a3),d2
	addq.w	#$1,d2
	cmpi.w	#$a,d2
	bmi.b	T_067b6
	subi.w	#$a,d2
T_067b6:
	moveq	#9,d6
T_067b8:
	move.b	T_067d4(pc,d2.w),d3
	btst	d3,d1
	bne.b	T_067de
	addq.w	#$1,d2
	cmpi.w	#$a,d2
	bmi.b	T_067cc
	subi.w	#$a,d2
T_067cc:
	dbra	d6,T_067b8
	clr.b	(a1)
	bra.b	T_067e6
T_067d4:
	dc.b	$08,$09,$0a,$0b,$0c,$00,$01,$02,$03,$04
T_067de:
	move.w	d2,(a3)
	addi.w	#$a,d2
	move.b	d2,(a1)
T_067e6:
	addq.l	#$4,a0
	addq.l	#$1,a1
	addq.l	#$2,a3
	addq.w	#$1,d7
	cmpi.w	#$7,d7
	bmi.b	T_0678c
T_067f4:
	movem.l	(a7)+,d0-d3/d5-d7/a0-a3
T_067f8:
	rts
T_067fa:
	addq.w	#$1,B_57d64
	rts
