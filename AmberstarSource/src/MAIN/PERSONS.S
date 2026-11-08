; MAIN/PERSONS.ASM (original module, merged with the disassembly of the shipped program)

	section	text

; ---- Init_persons (original source: MAIN/PERSONS.ASM)
Init_persons:
	movem.l	d0/d6/d7/a0-a3,-(sp)
	lea.l	CD-3,a0
	move.w	Map_nr,d0
	add.w	d0,d0
	add.w	Map_nr,d0
	adda.w	d0,a0
	moveq.l	#1,d0
	and.b	3(a0),d0
	lsl.w	#8,d0
	move.b	2(a0),d0
	swap.w	d0
	move.b	1(a0),d0
	lsl.w	#8,d0
	move.b	(a0),d0
	lsr.l	#1,d0
	move.l	d0,CD_value
	movea.l	Mapd_ptr,a0
	move.w	Max_steps(a0),d6
	move.w	d6,Length_of_day
	add.w	d6,d6
	movea.l	Map_pointer,a2
	adda.w	Size_of_map,a2
	adda.w	Size_of_map,a2
	cmpi.b	#2,Current_map_type
	bpl.s	.3D_map
	adda.w	Size_of_map,a2
.3D_map:
	lea.l	Char_data(a0),a0
	lea.l	VChar_data,a1
	moveq.l	#0,d7
.Loop:
	lea.l	0(a0,d7.w),a3
	move.w	0(a3,d7.w),d0
	move.w	d0,(a1)
	beq.s	.Next
	move.b	48(a3),VChar_icon(a1)
	move.b	72(a3),VChar_move(a1)
	move.b	120(a3),VChar_day(a1)
	move.b	144(a3),VChar_month(a1)
	move.w	#0,VPathlen(a1)
	move.b	96(a3),d0
	move.b	d0,VChar_stats(a1)
	btst	#0,d0
	bne.s	.No_path
	btst	#1,d0
	bne.s	.No_path
	move.l	a2,VPath_ptr(a1)
	adda.w	d6,a2
	bra.s	.Next
.No_path:
	moveq.l	#0,d0
	move.b	(a2)+,d0
	move.w	d0,VChar_X(a1)
	moveq.l	#0,d0
	move.b	(a2)+,d0
	move.w	d0,VChar_Y(a1)
.Next:
	lea.l	VData_length(a1),a1
	addq.w	#1,d7
	cmpi.w	#Max_chars,d7
	bmi.s	.Loop
	movem.l	(sp)+,d0/d6/d7/a0-a3
	rts	
; ---- Clear_persons_buffer (original source: MAIN/PERSONS.ASM)
Clear_persons_buffer:
	movem.l	d0/d7/a0,-(sp)
	cmpi.b	#2,Current_map_type
	bpl.s	.3D_map
	lea.l	Persons_buf,a0
	moveq.l	#0,d0
	moveq.l	#35-1,d7
.Loop:
	move.l	d0,(a0)+
	dbra	d7,.Loop
	move.w	d0,(a0)+
	move.b	d0,(a0)+
	bra.s	.Exit
.3D_map:
	lea.l	Persons_buf_3D,a0
	moveq.l	#0,d0
	move.l	d0,(a0)+
	move.l	d0,(a0)+
	move.l	d0,(a0)+
.Exit:
	movem.l	(sp)+,d0/d7/a0
	rts	
; ---- TwoD_char_handler (original source: MAIN/PERSONS.ASM)
TwoD_char_handler:
	movem.l	d0-d7/a0-a2,-(sp)
	bsr.w	Clear_persons_buffer
	lea.l	Persons_buf,a0
	lea.l	VChar_data,a1
	move.l	CD_value,d6
	moveq.l	#0,d7
.Loop:
	tst.w	(a1)
	beq.w	.Next
	btst	d7,d6
	bne.w	.Next
	move.b	VChar_stats(a1),d0
	btst	#0,d0
	beq.s	.Person
	btst	#2,d0
	beq.s	.Hunt
	move.w	VChar_X(a1),d0
	move.w	VChar_Y(a1),d1
	bsr.w	Battle_check
	bra.s	.Show
.Hunt:
	bsr.w	Hunting_monster
	bsr.w	Battle_check
	bra.s	.Show
.Person:
	btst	#3,d0
	beq.s	.There
	moveq.l	#0,d1
	move.b	VChar_day(a1),d1
	cmp.w	Day,d1
	bne.w	.Next
	move.b	VChar_month(a1),d1
	cmp.w	Month,d1
	bne.w	.Next
.There:
	btst	#1,d0
	beq.s	.Path
.Random:
	bsr.w	Random_person
	bra.s	.Show
.Path:
	movea.l	VPath_ptr(a1),a2
	move.w	Current_step,d2
	moveq.l	#0,d0
	move.b	0(a2,d2.w),d0
	add.w	Length_of_day,d2
	moveq.l	#0,d1
	move.b	0(a2,d2.w),d1
	move.w	d0,VChar_X(a1)
	move.w	d1,VChar_Y(a1)
	cmpi.w	#6,d0
	bne.s	.Show
	cmpi.w	#6,d1
	beq.s	.Next
.Show:
	sub.w	Map_Xcoord,d0
	sub.w	Map_Ycoord,d1
	add.w	Mapbuf_X,d0
	add.w	Mapbuf_Y,d1
	addq.w	#1,d0
	addq.w	#1,d1
	cmpi.w	#12,d0
	bhi.s	.Next
	cmpi.w	#10,d1
	bhi.s	.Next
	mulu.w	#13,d1
	add.w	d0,d1
	lea.l	Overlay_buf,a2
	moveq.l	#0,d0
	move.b	0(a2,d1.w),d0
	beq.s	.Normal
	move.w	d0,d2
	movea.l	Iconstats_ptr,a2
	add.w	d0,d0
	add.w	d0,d0
	move.l	-4(a2,d0.w),d0
	btst.l	#3,d0
	beq.s	.Normal
	lea.l	Overlay_buf,a2
	addq.b	#1,d2
	move.b	d2,0(a2,d1.w)
	bra.s	.Next
.Normal:
	move.b	VChar_icon(a1),0(a0,d1.w)
.Next:
	lea.l	VData_length(a1),a1
	addq.w	#1,d7
	cmpi.w	#Max_chars,d7
	bmi.w	.Loop
	sf	New_step
	sf	New_move
	movem.l	(sp)+,d0-d7/a0-a2
	rts	
; ---- ThreeD_char_handler (original source: MAIN/PERSONS.ASM)
ThreeD_char_handler:
	movem.l	d0-d7/a0-a2,-(sp)
	bsr.w	Clear_persons_buffer
	lea.l	VChar_data,a1
	move.l	CD_value,d6
	moveq.l	#0,d7
.Loop:
	tst.w	(a1)
	beq.w	.Next
	btst	d7,d6
	bne.w	.Next
	bclr	#2,VChar_flag(a1)
	move.b	VChar_stats(a1),d0
	btst	#0,d0
	beq.s	.Person
	btst	#2,d0
	beq.s	.Hunt
	move.w	VChar_X(a1),d0
	move.w	VChar_Y(a1),d1
	bsr.w	Battle_check
	bra.s	.Show
.Hunt:
	bsr.w	Hunting_monster
; CHANGE: removed "move.w VChar_X(a1),d0"
; CHANGE: removed "move.w VChar_Y(a1),d1"
	bsr.w	Battle_check
	bra.s	.Show
.Person:
	btst	#3,d0
	beq.s	.There
	moveq.l	#0,d1
	move.b	VChar_day(a1),d1
	cmp.w	Day,d1
	bne.s	.Next
	move.b	VChar_month(a1),d1
	cmp.w	Month,d1
	bne.s	.Next
.There:
	btst	#1,d0
	beq.s	.Path
.Random:
	bsr.w	Random_person
	bra.s	.Show
.Path:
	movea.l	VPath_ptr(a1),a2
	move.w	Current_step,d2
	moveq.l	#0,d0
	move.b	0(a2,d2.w),d0
	add.w	Length_of_day,d2
	moveq.l	#0,d1
	move.b	0(a2,d2.w),d1
	cmpi.w	#6,d0
	bne.s	.Ok
	cmpi.w	#6,d1
	beq.s	.Next
.Ok:
	move.w	d0,VChar_X(a1)
	move.w	d1,VChar_Y(a1)
.Show:
	bset	#2,VChar_flag(a1)
.Next:
	lea.l	VData_length(a1),a1
	addq.w	#1,d7
	cmpi.w	#Max_chars,d7
	bmi.w	.Loop
	sf	New_step
	sf	New_move
	move.w	Map_Xcoord,d0
	move.w	Map_Ycoord,d1
	lea.l	Cut_table_3D,a1
	move.w	View_direction,d2
	mulu.w	#24,d2
	adda.w	d2,a1
	lea.l	VChar_data,a0
	lea.l	Persons_buf_3D,a2
	moveq.l	#12-1,d7
.Loop_1_L1:
	move.b	(a1)+,d2
	ext.w	d2
	move.b	(a1)+,d3
	ext.w	d3
	add.w	d0,d2
	add.w	d1,d3
	movea.l	a0,a3
	moveq.l	#0,d5
.Loop_2_L1:
	tst.w	(a3)
	beq.s	.Next_L1
	btst	d5,d6
	bne.s	.Next_L1
	btst	#2,VChar_flag(a3)
	beq.s	.Next_L1
	cmp.w	VChar_X(a3),d2
	bne.s	.Next_L1
	cmp.w	VChar_Y(a3),d3
	bne.s	.Next_L1
	move.b	VChar_icon(a3),(a2)
	bra.s	.Next_2_L1
.Next_L1:
	lea.l	VData_length(a3),a3
	addq.w	#1,d5
	cmpi.w	#Max_chars,d5
	bmi.s	.Loop_2_L1
.Next_2_L1:
	addq.l	#1,a2
	dbra	d7,.Loop_1_L1
	movem.l	(sp)+,d0-d7/a0-a2
	rts	
; ---- Hunting_monster (original source: MAIN/PERSONS.ASM)
Hunting_monster:
	movem.l	d2-d6,-(sp)
	move.w	VChar_X(a1),d0
	move.w	VChar_Y(a1),d1
	bsr.w	Check_line_of_sight
	beq.s	.Visible
	tst.b	New_step
	beq.w	.Exit
	btst	#0,VChar_flag(a1)
	bne.s	.Not_random
	bsr.w	Random_person
	bra.w	.Exit
.Not_random:
	move.w	VDir(a1),d2
	bsr.w	Move_character
	tst.w	d0
	ble.s	.No_move1
	cmp.w	Width_of_map,d0
	bhi.s	.No_move1
	tst.w	d1
	ble.s	.No_move1
	cmp.w	Height_of_map,d1
	bhi.s	.No_move1
	bsr.w	Character_movement_check
	beq.w	.Move
.No_move1:
	bclr	#0,VChar_flag(a1)
	move.w	#0,VPathlen(a1)
	bsr.w	Random_person
	bra.w	.Exit
.Visible:
	ori.b	#3,VChar_flag(a1)
	tst.b	New_step
	bne.s	.Ok
	tst.b	New_move
	beq.w	.Exit
.Ok:
	move.w	d0,d2
	move.w	d1,d3
	sub.w	Map_Xcoord,d2
	sub.w	Map_Ycoord,d3
	move.w	d2,d4
	bpl.s	.Pos1
	neg.w	d4
.Pos1:
	move.w	d3,d5
	bpl.s	.Pos2
	neg.w	d5
.Pos2:
	ext.l	d2
	beq.s	.Zero1
	swap.w	d2
	bmi.s	.Zero1
	moveq.l	#1,d2
.Zero1:
	ext.l	d3
	beq.s	.Zero2
	swap.w	d3
	bmi.s	.Zero2
	moveq.l	#1,d3
.Zero2:
	sub.w	d5,d4
	ext.l	d4
	beq.s	.Zero3
	swap.w	d4
	bmi.s	.Zero3
	moveq.l	#1,d4
.Zero3:
	neg.w	d2
	neg.w	d3
	addq.w	#1,d2
	addq.w	#1,d3
	addq.w	#1,d4
	add.w	d3,d2
	add.w	d3,d3
	add.w	d3,d2
	move.w	d4,d3
	lsl.w	#3,d3
	add.w	d3,d2
	add.w	d4,d2
	add.w	d2,d2
	add.w	d2,d2
	move.l	.Dir_table(pc,d2.w),d2
	bmi.s	.Move
	move.w	d0,d4
	move.w	d1,d5
	rol.l	#8,d2
	tst.b	d2
	bmi.s	.No_move2
	bsr.w	Move_character
	bsr.w	Character_movement_check
	beq.s	.Move
	move.w	d4,d0
	move.w	d5,d1
	rol.l	#8,d2
	tst.b	d2
	bmi.s	.No_move2
	bsr.w	Move_character
	bsr.w	Character_movement_check
	beq.s	.Move
	move.w	d4,d0
	move.w	d5,d1
	rol.l	#8,d2
	tst.b	d2
	bmi.s	.No_move2
	bsr.w	Move_character
	bsr.w	Character_movement_check
	beq.s	.Move
.No_move2:
	move.w	d4,d0
	move.w	d5,d1
	bra.s	.Exit
.Move:
	move.w	d0,VChar_X(a1)
	move.w	d1,VChar_Y(a1)
	andi.w	#$00ff,d2
	move.w	d2,VDir(a1)
.Exit:
	movem.l	(sp)+,d2-d6
	rts	
.Dir_table:
	dc.l	$00030100,$00030100,$00010300
	dc.l	$03000200,-1,$01000200
	dc.l	$02030100,$02010300,$02010300
	dc.l	$0003ff00,-1,$0001ff00
	dc.l	-1,-1,-1
	dc.l	$0203ff00,-1,$0201ff00
	dc.l	$03000200,$00030100,$01000200
	dc.l	$03000200,-1,$01000200
	dc.l	$03020000,$02030100,$01020000
; ---- Random_person (original source: MAIN/PERSONS.ASM)
Random_person:
	movem.l	d2/d7,-(sp)
	moveq.l	#4-1,d7
	tst.w	VPathlen(a1)
	bne.s	.Loop
	bsr.w	Choose_random_path
.Loop:
	move.w	VChar_X(a1),d0
	move.w	VChar_Y(a1),d1
	tst.b	New_step
	beq.s	.Exit
	move.w	VDir(a1),d2
	bsr.w	Move_character
	bsr.w	Character_movement_check
	beq.s	.Move
	bsr.w	Choose_random_path
	dbra	d7,.Loop
	move.w	#0,VPathlen(a1)
	bra.s	.Exit
.Move:
	subq.w	#1,VPathlen(a1)
	move.w	d0,VChar_X(a1)
	move.w	d1,VChar_Y(a1)
.Exit:
	movem.l	(sp)+,d2/d7
	rts	
; ---- Move_character (original source: MAIN/PERSONS.ASM)
Move_character:
	movem.l	d2/d3/a0,-(sp)
	lea.l	Dir_offset,a0
	andi.w	#$00ff,d2
	add.w	d2,d2
	move.b	0(a0,d2.w),d3
	ext.w	d3
	add.w	d3,d0
	move.b	1(a0,d2.w),d3
	ext.w	d3
	add.w	d3,d1
	movem.l	(sp)+,d2/d3/a0
	rts	
; ---- Choose_random_path (original source: MAIN/PERSONS.ASM)
Choose_random_path:
	movem.l	d0-d2/a0,-(sp)
	jsr	Random
	lsr.w	#1,d0
	moveq.l	#$3,d1
	and.w	d0,d1
	addq.w	#1,d1
	move.w	VDir(a1),d2
	addq.w	#1,d2
	andi.w	#$0003,d2
	jsr	Random
	andi.w	#$0002,d0
	add.w	d0,d2
	andi.w	#$0003,d2
	move.w	d2,VDir(a1)
	add.w	d2,d2
	add.w	d2,d2
	movea.l	.Pathcheck(pc,d2.w),a0
	jsr	(a0)
	move.w	d1,VPathlen(a1)
	movem.l	(sp)+,d0-d2/a0
	rts	
.Pathcheck:
	dc.l	.Up,.Right,.Down,.Left
.Up:
	move.w	VChar_Y(a1),d0
	sub.w	d1,d0
	bmi.s	.Up_exit
	subq.w	#1,d0
	add.w	d0,d1
.Up_exit:
	rts	
.Right:
	move.w	Width_of_map,d0
	sub.w	VChar_X(a1),d0
	sub.w	d1,d0
	bpl.s	.Right_exit
	add.w	d0,d1
.Right_exit:
	rts	
.Down:
	move.w	Height_of_map,d0
	sub.w	VChar_Y(a1),d0
	sub.w	d1,d0
	bpl.s	.Down_exit
	add.w	d0,d1
.Down_exit:
	rts	
.Left:
	move.w	VChar_X(a1),d0
	sub.w	d1,d0
	bmi.s	.Left_exit
	subq.w	#1,d0
	add.w	d0,d1
.Left_exit:
	rts	
; ---- Character_movement_check (original source: MAIN/PERSONS.ASM)
Character_movement_check:
	movem.l	d0-d3/d6/d7/a0,-(sp)
	lea.l	VChar_data,a0
	move.l	CD_value,d6
	moveq.l	#0,d7
.Loop:
	tst.w	(a0)
	beq.s	.Next
	btst	d7,d6
	bne.s	.Next
	cmp.w	VChar_X(a0),d0
	bne.s	.Next
	cmp.w	VChar_Y(a0),d1
	bne.s	.Next
	st	d3
	bra.w	.Exit
.Next:
	lea.l	VData_length(a0),a0
	addq.w	#1,d7
	cmpi.w	#Max_chars,d7
	bmi.s	.Loop
	moveq.l	#0,d2
	move.b	VChar_move(a1),d2
	addq.w	#8,d2
	moveq.l	#-1,d3
	cmpi.b	#2,Current_map_type
	bmi.s	.2D_map
	bsr.w	Get_3D_icon_status
	btst.l	#7,d0
	sne	d3
	bne.s	.Exit
	btst.l	d2,d0
	seq	d3
	bra.s	.Exit
.2D_map:
	subq.w	#1,d0
	subq.w	#1,d1
	movea.l	Map_pointer,a0
	mulu.w	Width_of_map,d1
	add.w	d0,d1
	adda.w	d1,a0
	moveq.l	#0,d0
	move.b	(a0),d0
	adda.w	Size_of_map,a0
	moveq.l	#0,d1
	move.b	(a0),d1
	movea.l	Iconstats_ptr,a0
	add.w	d0,d0
	add.w	d0,d0
	move.l	-4(a0,d0.w),d0
	tst.w	d1
	beq.s	.Underlay
	add.w	d1,d1
	add.w	d1,d1
	move.l	-4(a0,d1.w),d1
	btst.l	#5,d1
	bne.s	.Underlay
	btst.l	#7,d1
	bne.s	.Exit
	btst.l	d2,d1
	seq	d3
	bra.s	.Exit
.Underlay:
	btst.l	#7,d0
	bne.s	.Exit
	btst.l	d2,d0
	seq	d3
.Exit:
	tst.b	d3
	movem.l	(sp)+,d0-d3/d6/d7/a0
	rts	
; ---- Check_line_of_sight (original source: MAIN/PERSONS.ASM)
Check_line_of_sight:
	movem.l	d0-d7/a0-a2,-(sp)
	tst.w	Spell_6_duration
	bne.w	.Exit
	movea.l	Iconstats_ptr,a2
	move.w	VChar_X(a1),d0
	move.w	VChar_Y(a1),d1
	sub.w	Map_Xcoord,d0
	sub.w	Map_Ycoord,d1
	movea.l	Map_pointer,a0
	move.w	Map_Ycoord,d2
	subq.w	#1,d2
	mulu.w	Width_of_map,d2
	add.w	Map_Xcoord,d2
	lea.l	-1(a0,d2.w),a0
	lea.l	(a0),a1
	adda.w	Size_of_map,a1
	move.w	d0,d2
	ext.l	d2
	beq.s	.Zero1
	swap.w	d2
	bmi.s	.Zero1
	moveq.l	#1,d2
.Zero1:
	move.w	d1,d3
	ext.l	d3
	beq.s	.Zero2
	swap.w	d3
	bmi.s	.Zero2
	moveq.l	#1,d3
.Zero2:
	neg.w	d2
	neg.w	d3
	move.w	d0,d4
	move.w	d1,d5
	tst.w	d2
	bmi.s	.No_abs1
	neg.w	d4
.No_abs1:
	tst.w	d3
	bmi.s	.No_abs2
	neg.w	d5
.No_abs2:
	muls.w	Width_of_map,d3
	muls.w	Width_of_map,d1
	add.w	d1,d0
	cmp.w	d5,d4
	bpl.s	.DxDy
	exg.l	d3,d2	; CHANGE: was "exg.l d2,d3"
	exg.l	d5,d4	; CHANGE: was "exg.l d4,d5"
.DxDy:
	move.w	d4,d6
	lsr.w	#1,d6
	move.w	d4,d7
	subq.w	#1,d7
	bmi.s	.End
	bra.s	.Entry
.Again:
	moveq.l	#0,d1
	move.b	0(a0,d0.w),d1
	add.w	d1,d1
	add.w	d1,d1
	move.l	-4(a2,d1.w),d1
	btst	#1,d1
	bne.s	.Exit
	moveq.l	#0,d1
	move.b	0(a1,d0.w),d1
	beq.s	.Entry
	add.w	d1,d1
	add.w	d1,d1
	move.l	-4(a2,d1.w),d1
	btst	#1,d1
	bne.s	.Exit
.Entry:
	add.w	d5,d6
	cmp.w	d4,d6
	bmi.s	.Skip
	sub.w	d4,d6
	add.w	d3,d0
.Skip:
	add.w	d2,d0
	dbra	d7,.Again
.End:
	moveq.l	#0,d0
.Exit:
	movem.l	(sp)+,d0-d7/a0-a2
	rts	
Battle_check:
	tst.b	B_5ac7e
	beq.b	.l_062aa
	sf.b	B_5ac7e
	bra.b	.l_062e0
.l_062aa:
	cmpi.w	#$5,Travel_mode
	bpl.w	.l_062e0
	cmp.w	Map_Xcoord,d0
	bne.b	.l_062e0
	cmp.w	Map_Ycoord,d1
	bne.b	.l_062e0
	move.w	$0(a1),B_5b94c
	move.w	d7,B_5be92
	st.b	CombatReq
	st.b	Pause_Upd
.l_062e0:
	rts
CombatReq_ModInit:
	sf.b	CombatReq
	sf.b	Party_advantage
	sf.b	Monster_advantage
	cmpi.b	#$2,Current_map_type
	bmi.b	.l_06338
	tst.b	Stygian
	bne.b	.l_06338
	st.b	B_5a946
	cmpi.b	#$2,Current_map_type
	bne.b	.l_0631e
	lea.l	D3_DisUpd,a0
	bra.b	.l_06324
.l_0631e:
	lea.l	C3_DisUpd,a0
.l_06324:
	moveq	#7,d7
.l_06326:
	jsr	(a0)
	jsr	Switch_screen
	dbra	d7,.l_06326
	sf.b	B_5a946
.l_06338:
	sf.b	Pause_Upd
	moveq	#16,d0
	moveq	#52,d1
	moveq	#18,d2
	moveq	#5,d3
	moveq	#1,d6
	lea.l	D_32234,a0
	jsr	Open_window
	move.w	d0,Window_handle
	lea.l	D_1e3b6,a0
	bsr.w	Push_PA
	moveq	#15,d0
	move.w	Nr_of_chars,d2
	lea.l	Code0004Sys,a1
	bsr.w	Prepare_text_block
	movea.l	Off_screen,a6
	movea.l	Text_buffer,a0
	move.w	Nr_of_chars,d0
	move.w	Lines_in_text,d7
	subq.w	#$1,d7
.l_06390:
	jsr	IG_Print
	jsr	IG_Carriage_return
	lea.l	$1(a0,d0.w),a0
	dbra	d7,.l_06390
	moveq	#2,d6
	moveq	#16,d7
	move.w	#$20,d0
	move.w	#$64,d1
	lea.l	D_3d2ea,a0
	jsr	Blot_unmasked_block
	move.w	#$40,d0
	move.w	#$64,d1
	lea.l	D_3f0ea,a0
	jsr	Blot_unmasked_block
	jsr	Switch_screen
	jsr	Copy_screen
	movea.l	Text_buffer,a0
	jsr	Free_memory
	rts
; ---- CombatReq_ModExit (original source: MAIN/PERSONS.ASM)
CombatReq_ModExit:
	move.w	Window_handle,d0
	jsr	Close_window
	bsr.w	Pop_PA
	rts	
T_063fc:
	movea.l	Module_sp,a0
	move.l	(a0),d0
	beq.b	CombatYes
	movea.l	d0,a0
	jsr	(a0)
	jsr	Switch_screen
; ---- CombatYes (original source: MAIN/PERSONS.ASM)
CombatYes:
	tst.w	Spell_6_duration
	beq.s	.Visible
	st	Party_advantage
.Visible:
	move.w	Map_Xcoord,d0
	move.w	Map_Ycoord,d1
	cmpi.b	#2,Current_map_type
	bpl.s	.3D_map
	bsr.w	Get_2D_icon_status
	tst.l	d1
	beq.s	.Go_on
	btst.l	#5,d1
	bne.s	.Go_on
	move.l	d1,d0
	bra.s	.Go_on
.3D_map:
	bsr.w	Get_3D_icon_status
.Go_on:
	moveq.l	#16,d1
	moveq.l	#14-1,d7
.Loop:
	btst	d1,d0
	bne.s	.Found
	addq.w	#1,d1
	dbra	d7,.Loop
	moveq.l	#16,d1
.Found:
	subi.w	#16-1,d1
	move.w	d1,comback_nr
	move.w	Active_member,B_5aa94	; CHANGE: added
	st	Battling
	move.w	#4,Spell_area_type
	jsr	Pop_Module	; CHANGE: was "jsr Exit_display"
	jsr	Exit_display	; CHANGE: added
	lea.l	Combat_Mod,a0
	jmp	Push_Module
T_06494:
	tst.w	Spell_6_duration
	bne.b	.l_064dc
	cmpi.w	#$6,Travel_mode
	bpl.b	.l_064da
	movea.l	Current_active_char_data,a0
	move.w	Attr_3_normal(a0),d0
	add.w	Attr_3_normal_magic(a0),d0
	add.w	Attr_7_normal(a0),d0
	add.w	Attr_7_normal_magic(a0),d0
	tst.w	d0
	bmi.b	.l_064da
	cmpi.w	#$96,d0
	bpl.b	.l_064da
	move.w	d0,d1
	jsr	Random
	lsr.w	#$1,d0
	ext.l	d0
	divu.w	#$96,d0
	swap	d0
	cmp.w	d0,d1
.l_064da:
	bmi.b	.l_064e8
.l_064dc:
	bsr.w	T_01f98
	jsr	Pop_Module
	bra.b	.l_064f2
.l_064e8:
	st.b	Monster_advantage
	bsr.w	T_063fc
.l_064f2:
	rts

	section	bss

CD_value:
	ds.b	4
Length_of_day:
	ds.b	2
VChar_data:
	ds.b	480
CombatReq:
	ds.b	1
Pause_Upd:
	ds.b	1
B_5ac7e:
	ds.b	2
B_5ac80:
	ds.b	2
B_5ac82:
	ds.b	2
B_5ac84:
	ds.b	2
B_5ac86:
	ds.b	2
B_5ac88:
	ds.b	2
B_5ac8a:
	ds.b	2
B_5ac8c:
	ds.b	2
Stygian:
	ds.b	1
Bumped:
	ds.b	1
New_move:
	ds.b	1
Anim_count:
	ds.b	1
Anim_speed:
	ds.b	1
B_5ac93:
	ds.b	1
Current_map_type:
	ds.b	1
Which_CIL:
	ds.b	1
Party_invisible:
	ds.b	2
B_5ac98:
	ds.b	2
B_5ac9a:
	ds.b	2
Mouse_direction:
	ds.b	2
Mousemove_ptr:
	ds.b	4
First_CIL_ptr:
	ds.b	4
Pal_buffer:
	ds.b	32
Width_of_map:
	ds.b	2
Height_of_map:
	ds.b	2
Size_of_map:
	ds.b	2
Map_pointer:
	ds.b	4
Iconstats_ptr:
	ds.b	4
Anim_bias:
	ds.b	2
Circle_anim:
	ds.b	4
B_5acda:
	ds.b	28
Wave_anim:
	ds.b	8
B_5acfe:
	ds.b	24
B_5ad16:
	ds.b	8
Time_lock:
	ds.b	1
