; MAIN/MAP/MAP.ASM (original module, merged with the disassembly of the shipped program)

	section	text

Init_map:
	movem.l	d0/a0/a5,-(a7)
	bsr.w	T_00194
	lea.l	D_3217c,a0
	move.w	Map_nr,d0
	jsr	Load_subfile
	movea.l	a0,a5
	move.b	$4(a5),d0
	tst.b	d0
	beq.b	.l_01f12
	move.b	$5(a5),d0
	btst	#$6,d0
	bne.b	.l_01f0e
	moveq	#2,d0
	bra.b	.l_01f22
.l_01f0e:
	moveq	#3,d0
	bra.b	.l_01f22
.l_01f12:
	move.b	$5(a5),d0
	btst	#$5,d0
	bne.b	.l_01f20
	moveq	#0,d0
	bra.b	.l_01f22
.l_01f20:
	moveq	#1,d0
.l_01f22:
	move.b	d0,Current_map_type
	tst.b	First
	bne.b	.l_01f3a
	bsr.w	Init_time
	st.b	First
.l_01f3a:
	bsr.w	T_01ff6
	lea.l	.l_01f56(pc),a0
	add.w	d0,d0
	add.w	d0,d0
	movea.l	(a0,d0.w),a0
	jsr	Push_Module
	movem.l	(a7)+,d0/a0/a5
	rts
.l_01f56:
	dc.l	C2map_Mod
	dc.l	W2map_Mod
	dc.l	D3map_Mod
	dc.l	C3map_Mod
Exit_map:
	jsr	Exit_display
	bsr.w	T_00194
	jmp	Pop_Module
; ---- Init_maptexts (original source: MAIN/WORDS.ASM)
Init_maptexts:
	movem.l	d0/a0,-(sp)
	lea.l	Maptext_filename,a0
	move.w	Map_nr,d0
	jsr	Load_subfile
	move.l	a0,Maptext_ptr
	movem.l	(sp)+,d0/a0
	rts	
T_01f98:
	move.w	B_5ac80,Map_Xcoord
	move.w	B_5ac82,Map_Ycoord
	cmpi.b	#$0,Current_map_type
	bne.b	.l_01fcc
	move.w	B_5ac84,Mapbuf_X
	move.w	B_5ac86,Mapbuf_Y
	bra.b	.l_01ff4
.l_01fcc:
	cmpi.b	#$1,Current_map_type
	bne.b	.l_01ff4
	move.w	B_5ac88,Quad_X
	move.w	B_5ac8a,Quad_Y
	move.w	B_5ac8c,Quad_index
.l_01ff4:
	rts
T_01ff6:
	move.w	Map_Xcoord,B_5ac80
	move.w	Map_Ycoord,B_5ac82
	cmpi.b	#$0,Current_map_type
	bne.b	.l_0202a
	move.w	Mapbuf_X,B_5ac84
	move.w	Mapbuf_Y,B_5ac86
	bra.b	.l_02052
.l_0202a:
	cmpi.b	#$1,Current_map_type
	bne.b	.l_02052
	move.w	Quad_X,B_5ac88
	move.w	Quad_Y,B_5ac8a
	move.w	Quad_index,B_5ac8c
.l_02052:
	rts
T_02054:
	movem.l	d0-d2/a0,-(a7)
	move.w	Mouse_X,d0
	move.w	Mouse_Y,d1
	jsr	Find_object
	andi.l	#$ffff00,d2
	cmpi.l	#$20200,d2
	bne.b	.l_020f2
	cmpi.b	#$2,Current_map_type
	bpl.b	.l_020be
	lea.l	.l_020f8,a0
	subi.w	#$10,d0
	subi.w	#$31,d1
	lsr.w	#$4,d0
	lsr.w	#$4,d1
	sub.w	Mapbuf_X,d0
	sub.w	Mapbuf_Y,d1
	tst.w	d0
	beq.b	.l_020aa
	bmi.b	.l_020ae
	moveq	#2,d2
	bra.b	.l_020b0
.l_020aa:
	moveq	#1,d2
	bra.b	.l_020b0
.l_020ae:
	moveq	#0,d2
.l_020b0:
	tst.w	d1
	beq.b	.l_020ba
	bmi.b	.l_020e0
	addq.w	#$6,d2
	bra.b	.l_020e0
.l_020ba:
	addq.w	#$3,d2
	bra.b	.l_020e0
.l_020be:
	lea.l	.l_02101,a0
	subi.w	#$20,d0
	subi.w	#$31,d1
	ext.l	d0
	ext.l	d1
	divu.w	#$30,d0
	divu.w	#$30,d1
	add.w	d1,d0
	add.w	d1,d1
	add.w	d0,d1
	move.w	d1,d2
.l_020e0:
	move.w	d2,Mouse_direction
	moveq	#0,d0
	move.b	(a0,d2.w),d0
	jsr	Change_Mptr
.l_020f2:
	movem.l	(a7)+,d0-d2/a0
	rts
.l_020f8:
	dc.b	$05,$01,$06,$04,$10,$03,$08,$02,$07
.l_02101:
	dc.b	$0e,$09,$0d,$0c,$10,$0b,$17,$0a,$14
; ---- Reset_mouse (original source: MAIN/MAP/MAP.ASM)
Reset_mouse:
	move.w	Mouse_X,d0
	move.w	Mouse_Y,d1
	jsr	Find_object
	andi.l	#$00ffff00,d2
	cmpi.l	#$00020200,d2
	beq.s	.Exit
	moveq.l	#0,d0
	jsr	Change_Mptr
.Exit:
	rts	
Update_animation:
	subq.b	#$1,Anim_count
	bne.b	No_animation
	movem.l	d0-d2/d6-d7/a0-a1,-(a7)
	moveq	#15,d1
	lea.l	B_5acda,a0
	moveq	#2,d7
.l_0214a:
	move.b	(a0),d0
	addq.b	#$1,d0
	cmp.b	d0,d7
	bne.b	.l_02158
	bsr.w	Recalc_random
	moveq	#0,d0
.l_02158:
	move.b	d0,(a0)
	addq.l	#$4,a0
	addq.w	#$1,d7
	cmpi.w	#$9,d7
	bmi.b	.l_0214a
	lea.l	B_5acfe,a0
	lea.l	B_5ad16,a1
	moveq	#3,d7
.l_02172:
	move.b	(a0),d0
	tst.b	(a1)+
	bne.b	.l_02186
	addq.b	#$1,d0
	cmp.b	d0,d7
	bne.b	.l_02192
	subq.b	#$2,d0
	not.b	-$1(a1)
	bra.b	.l_02192
.l_02186:
	subq.b	#$1,d0
	bne.b	.l_02192
	not.b	-$1(a1)
	bsr.w	Recalc_random
.l_02192:
	move.b	d0,(a0)
	addq.l	#$4,a0
	addq.w	#$1,d7
	cmpi.w	#$9,d7
	bmi.b	.l_02172
	move.b	Anim_speed,Anim_count
	movem.l	(a7)+,d0-d2/d6-d7/a0-a1
; ---- No_animation (original source: MAIN/MAP/MAP.ASM)
No_animation:
	rts	
; ---- Recalc_random (original source: MAIN/MAP/MAP.ASM)
Recalc_random:
	move.l	d0,-(sp)
	moveq.l	#0,d2
	move.w	Anim_bias,d6
	subq.w	#1,d6
.Loop:
	jsr	Random
	lsr.w	#1,d0
	and.w	d1,d0
	bset	d0,d2
	dbra	d6,.Loop
	move.w	d2,2(a0)
	jsr	Random
	lsr.w	#1,d0
	move.b	d0,1(a0)
	move.l	(sp)+,d0
	rts	
Before_move:
	movem.l	d0/a0,-(a7)
	tst.b	B_5c30f
	beq.b	.l_021f2
	movem.l	(a7)+,d0/a0
	addq.l	#$4,a7
	rts
.l_021f2:
	bsr.w	T_01ff6
	movem.l	(a7)+,d0/a0
	rts
After_move:
	movem.l	d0-d1/d7/a0-a1,-(a7)
	st.b	New_move
	move.w	#$0,Frame
	move.w	B_5ac98,d0
	beq.b	.l_0221a
	subq.w	#$1,d0
	bra.b	T_0223e
.l_0221a:
	cmpi.b	#$1,Current_map_type
	bne.b	T_02238
	move.w	B_5ac9a,d7
	bra.b	T_02230
T_0222c:
	bsr.w	Update_time
T_02230:
	dbra	d7,T_0222c
	moveq	#1,d0
	bra.b	T_0223e
T_02238:
	bsr.w	Update_time
	moveq	#4,d0
T_0223e:
	move.w	d0,B_5ac98
	cmpi.w	#$4,Travel_mode
	beq.b	.l_02258
	cmpi.w	#$2,Travel_mode
	bpl.b	.l_022d4
.l_02258:
	move.w	Map_Xcoord,d0
	move.w	Map_Ycoord,d1
	cmpi.b	#$2,Current_map_type
	bpl.b	.l_0228c
	bsr.w	Get_2D_icon_status
	tst.l	d1
	beq.b	.l_02284
	btst	#$5,d1
	bne.b	.l_02284
	btst	#$1f,d1
	beq.b	.l_022d4
	bra.b	.l_02296
.l_02284:
	btst	#$1f,d0
	beq.b	.l_022d4
	bra.b	.l_02296
.l_0228c:
	bsr.w	Get_3D_icon_status
	btst	#$1f,d0
	beq.b	.l_022d4
.l_02296:
	lea.l	Chard_ptrs,a0
	moveq	#0,d1
	moveq	#1,d7
.l_022a0:
	tst.l	(a0)
	beq.b	.l_022ca
	movea.l	(a0),a1
	move.w	#$e400,d0
	and.w	$3a(a1),d0
	bne.b	.l_022ca
	move.w	$54(a1),d0
	add.w	$a8(a1),d0
	bsr.w	Probe
	bpl.b	.l_022ca
	bset	#$1,$3a(a1)
	move.w	d7,d0
	bsr.w	Do_damage
.l_022ca:
	addq.l	#$4,a0
	addq.w	#$1,d7
	cmpi.w	#$7,d7
	bmi.b	.l_022a0
.l_022d4:
	tst.w	Travel_mode
	bne.w	.l_0236e
	cmpi.b	#$2,Current_map_type
	bpl.w	.l_0236e
	bsr.w	Seek_transport
	tst.w	d0
	beq.b	.l_022fe
	cmpi.w	#$2,d0
	beq.b	.l_0236e
	cmpi.w	#$3,d0
	beq.b	.l_0236e
.l_022fe:
	move.w	Map_Xcoord,d0
	move.w	Map_Ycoord,d1
	bsr.w	Get_2D_icon_status
	tst.l	d1
	beq.b	.l_02320
	btst	#$5,d1
	bne.b	.l_02320
	btst	#$e,d1
	beq.b	.l_0236e
	bra.b	.l_02326
.l_02320:
	btst	#$e,d0
	beq.b	.l_0236e
.l_02326:
	lea.l	Chard_ptrs,a0
	moveq	#1,d7
.l_0232e:
	tst.l	(a0)
	beq.b	.l_02364
	movea.l	(a0),a1
	move.w	#$e400,d0
	and.w	$3a(a1),d0
	bne.b	.l_02364
	moveq	#0,d0
	move.b	$8(a1),d0
	add.w	$b4(a1),d0
	bsr.w	Probe
	bpl.b	.l_02364
	jsr	Random
	move.w	d0,d1
	mulu.w	#$5,d1
	swap	d1
	addq.w	#$1,d1
	move.w	d7,d0
	bsr.w	Do_damage
.l_02364:
	addq.l	#$4,a0
	addq.w	#$1,d7
	cmpi.w	#$7,d7
	bmi.b	.l_0232e
.l_0236e:
	bsr.w	Event_handler
	tst.w	Spell_5_duration
	beq.w	.l_02424
	cmpi.w	#$5,Travel_mode
	bpl.w	.l_02424
	lea.l	Dir_offset,a0
	move.w	View_direction,d0
	add.w	d0,d0
	adda.w	d0,a0
	move.b	(a0)+,d0
	ext.w	d0
	add.w	Map_Xcoord,d0
	move.b	(a0),d1
	ext.w	d1
	add.w	Map_Ycoord,d1
	bsr.w	Find_event
	beq.b	.l_02424
	moveq	#0,d0
	move.b	(a5),d0
	cmpi.w	#$4,d0
	bne.b	.l_023e6
	tst.b	$4(a5)
	beq.b	.l_02424
	bsr.w	T_01ff6
	movea.l	Module_sp,a0
	move.l	(a0),d0
	beq.b	.l_023da
	movea.l	d0,a0
	jsr	(a0)
	jsr	Switch_screen
.l_023da:
	st.b	B_5ac93
	bsr.w	Handle_event
	bra.b	.l_02440
.l_023e6:
	lea.l	D_292c6,a0
	move.b	-$1(a0,d0.w),d1
	bmi.b	.l_02424
	movea.l	Module_sp,a0
	move.l	(a0),d0
	beq.b	.l_02406
	movea.l	d0,a0
	jsr	(a0)
	jsr	Switch_screen
.l_02406:
	move.w	d1,WText_nr
	move.l	#Code0003Sys,Textfile_ptr
	lea.l	D_2a410,a0
	jsr	Push_Module
	bra.b	.l_02440
.l_02424:
	cmpi.b	#$1,Current_map_type
	bne.b	.l_02440
	move.w	Travel_mode,d0
	add.w	d0,d0
	move.w	.l_02446(pc,d0.w),d0
	beq.b	.l_02440
	bsr.w	Delay
.l_02440:
	movem.l	(a7)+,d0-d1/d7/a0-a1
	rts
.l_02446:
	dc.b	$00,$05,$00,$02,$00,$03,$00,$02,$00,$04,$00,$00,$00,$00
T_02454:
	move.w	Mouse_direction,d0
	add.w	d0,d0
	add.w	d0,d0
	movea.l	Mousemove_ptr,a0
	movea.l	(a0,d0.w),a0
	jsr	(a0)
	rts
; ---- Print_headline (original source: MAIN/MAP/MAP.ASM)
Print_headline:
	movem.l	d0/d1/d7/a0,-(sp)
	lea.l	Map_headline(a5),a0
	moveq.l	#30-1,d7
.Loop:
	cmpi.b	#" ",0(a0,d7.w)
	dbne	d7,.Loop
	addq.w	#1,d7
	move.w	d7,d0
	add.w	d0,d0
	add.w	d7,d0
	add.w	d0,d0
	subi.w	#180,d0
	neg.w	d0
	lsr.w	#1,d0
	addi.w	#13,d0
	moveq.l	#39,d1
	jsr	IG_Set_cursor
	moveq.l	#15,d0
	jsr	IG_Set_ink
	moveq.l	#-1,d0
	jsr	IG_Set_paper
	jsr	IG_Print
	movem.l	(sp)+,d0/d1/d7/a0
	rts	
; ---- Handle_CIL (original source: MAIN/MAP/MAP.ASM)
Handle_CIL:
	tst.b	Which_CIL
	beq.s	.First
	lea.l	Second_CIL,a0
	bsr.w	Second_CIL_evaluate
	move.l	a0,Control_list_ptr
	bra.s	.Exit
.First:
	movea.l	First_CIL_ptr,a0
	bsr.w	Map_CIL_evaluate
	move.l	a0,Control_list_ptr
.Exit:
	rts	
; ---- Switch_control_icons (original source: MAIN/MAP/MAP.ASM)
Switch_control_icons:
	not.b	Which_CIL
	bsr.w	Handle_CIL
	jsr	Copy_screen
	jsr	Switch_screen
	movea.l	Off_screen,a6
	bsr.w	Show_control_icons
	jsr	Switch_screen
	jsr	Copy_screen
	rts
Map_CIL_evaluate:
	bclr	#$7,(a0)
	bclr	#$7,$1(a0)
	bclr	#$7,$2(a0)
	bclr	#$7,$3(a0)
	bclr	#$7,$5(a0)
	bclr	#$7,$6(a0)
	bclr	#$7,$7(a0)
	bclr	#$7,$8(a0)
	tst.b	B_5c30f
	beq.b	.l_0259c
	cmpi.b	#$2,Current_map_type
	bpl.b	.l_02584
	bset	#$7,(a0)
	bset	#$7,$1(a0)
	bset	#$7,$2(a0)
	bset	#$7,$3(a0)
	bset	#$7,$5(a0)
	bset	#$7,$6(a0)
	bset	#$7,$7(a0)
	bset	#$7,$8(a0)
	bra.b	.l_0259c
.l_02584:
	bset	#$7,$1(a0)
	bset	#$7,$3(a0)
	bset	#$7,$5(a0)
	bset	#$7,$7(a0)
.l_0259c:
	rts
; ---- Second_CIL_evaluate (original source: MAIN/MAP/MAP.ASM)
Second_CIL_evaluate:
	movem.l	d0/d1/a1,-(sp)
	bclr	#7,(a0)
	bclr	#7,3(a0)
	bclr	#7,4(a0)
	bclr	#7,5(a0)
	bclr	#7,6(a0)
	movea.l	Current_active_char_data,a1
	btst	#4,Mind_conditions(a1)
	beq.s	.Not_blind
	bset	#7,(a0)
.Not_blind:
	cmpi.b	#1,Current_map_type
	bne.s	.Deac
	tst.w	Travel_mode
	beq.s	.Get_up
	move.w	Map_Xcoord,d0
	move.w	Map_Ycoord,d1
	bsr.w	Get_2D_icon_status
	tst.l	d1
	beq.s	.Underlay1
	btst.l	#5,d1
	bne.s	.Underlay1
	btst.l	#7,d1
	bne.s	.Deac
	btst.l	#8,d1
	beq.s	.Deac
	bra.s	.Go_on
.Underlay1:
	btst.l	#7,d0
	bne.s	.Deac
	btst.l	#8,d0
	beq.s	.Deac
.Go_on:
	bsr.w	Seek_transport
	tst.w	d0
	bne.s	.Deac
	bra.s	.Ok
.Get_up:
	bsr.w	Seek_transport
	tst.w	d0
	bne.s	.Ok
.Deac:
	bset	#7,3(a0)
.Ok:
	tst.b	Spell_class_counter(a1)
	bne.s	.Magic
	bset	#7,4(a0)
.Magic:
	movea.l	Mapd_ptr,a1
	btst	#4,Map_special(a1)
	beq.s	.No_camp
	tst.w	Travel_mode
	bne.s	.Camp
	cmpi.b	#2,Current_map_type
	bpl.s	.Camp
	move.w	Map_Xcoord,d0
	move.w	Map_Ycoord,d1
	bsr.w	Get_2D_icon_status
	tst.l	d1
	beq.s	.Underlay2
	btst	#5,d1
	bne.s	.Underlay2
	btst	#14,d1
	beq.s	.Camp
	bra.s	.No_camp
.Underlay2:
	btst	#14,d0
	beq.s	.Camp
.No_camp:
	bset	#7,5(a0)
.Camp:
	cmpi.b	#2,Current_map_type
	bpl.s	.Exit
	bset	#7,6(a0)
.Exit:
	movem.l	(sp)+,d0/d1/a1
	rts	
; ---- Seek_transport (original source: MAIN/MAP/MAP.ASM)
Seek_transport:
	movem.l	d2/d3/d7/a0/a1,-(sp)
	lea.l	Trans_T,a0
	lea.l	90(a0),a1
	move.w	Map_Xcoord,d0
	move.w	Map_Ycoord,d1
	move.w	Map_nr,d2
	moveq.l	#0,d3
	moveq.l	#30-1,d7
.Loop:
	tst.b	(a0)
	beq.s	.Next
	cmp.w	(a1),d2
	bne.s	.Next
	cmp.b	30(a0),d0
	bne.s	.Next
	cmp.b	60(a0),d1
	bne.s	.Next
	moveq.l	#0,d0
	move.b	(a0),d0
	move.w	d3,d1
	bra.s	.Exit
.Next:
	addq.w	#1,d3
	addq.l	#1,a0
	addq.l	#2,a1
	dbra	d7,.Loop
	moveq.l	#0,d0
.Exit:
	movem.l	(sp)+,d2/d3/d7/a0/a1
	rts	
; ---- Update_map_CIL (original source: MAIN/MAP/MAP.ASM)
Update_map_CIL:
	movem.l	a0/a1,-(sp)
	tst.b	Which_CIL
	bne.s	.Second
	movea.l	First_CIL_ptr,a0
	lea.l	Map_CIL_evaluate,a1
	bsr.w	Update_control_icons
	bra.s	.Exit
.Second:
	lea.l	Second_CIL,a0
	lea.l	Second_CIL_evaluate,a1
	bsr.w	Update_control_icons
.Exit:
	movem.l	(sp)+,a0/a1
	rts	
; ---- Set_spell_area (original source: MAIN/MAP/MAP.ASM)
Set_spell_area:
	movem.l	d0/a0,-(sp)
	movea.l	Mapd_ptr,a0
	move.b	Map_special(a0),d0
	btst	#5,d0
	beq.s	.No_W
	moveq.l	#0,d0
	bra.s	.Exit
.No_W:
	btst	#6,d0
	beq.s	.No_C
	moveq.l	#1,d0
	bra.s	.Exit
.No_C:
	moveq.l	#2,d0
.Exit:
	move.w	d0,Spell_area_type
	movem.l	(sp)+,d0/a0
	rts	
; Plays the song of the map: on the world map (maps 1-64) the song of the travel mode, otherwise the song of the map data (byte 6).
Set_map_music:
	movem.l	d0/a0,-(a7)
	movea.l	Mapd_ptr,a0
	cmpi.w	#$41,Map_nr
	bpl.b	.l_0277c
	move.w	Travel_mode,d0
	move.b	.l_02774(pc,d0.w),d0
	bra.b	.l_02782
.l_02774:
	dc.b	$05,$03,$02,$02,$04,$04,$04,$00
.l_0277c:
	moveq	#0,d0
	move.b	$6(a0),d0
.l_02782:
	bsr.w	Play_song
	movem.l	(a7)+,d0/a0
	rts
