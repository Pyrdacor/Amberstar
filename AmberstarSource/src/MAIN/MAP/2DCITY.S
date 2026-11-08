; MAIN/MAP/2DCITY.ASM (original module, merged with the disassembly of the shipped program)

; ---- C2_ModInit (original source: MAIN/MAP/2DCITY.ASM)
; CHANGE: removed "Pop MA"
C2_ModInit:
	move.l	a5,Mapd_ptr
	bsr.w	M2_time_evaluate
	move.w	New_radius,Current_radius
	move.w	Iconfile_nr(a5),d0
	lea.l	Icondata_filename,a0
	jsr	Load_subfile
	move.l	a0,Icondata_ptr
	bsr.w	Init_maptexts
	lea.l	Iconstats(a0),a0
	move.l	a0,Iconstats_ptr
	moveq.l	#0,d0
	move.b	Map_width(a5),d0
	move.w	d0,Width_of_map
	moveq.l	#0,d1
	move.b	Map_height(a5),d1
	move.w	d1,Height_of_map
	mulu.w	d0,d1
	move.w	d1,Size_of_map
	lea.l	Map_data(a5),a0
	move.l	a0,Map_pointer
	move.b	#C2_animspeed,Anim_speed
	move.b	#C2_animspeed,Anim_count
	move.w	#6,Anim_bias
	bsr.w	Recalc_mapbuf_coords
	move.w	Map_nr,d7
	movea.l	Mapd_ptr,a0
	bsr.w	Make_modifications
	bsr.w	Init_persons
	bsr.w	T_00208	; CHANGE: was "jsr C2_DisInit"
	bsr.w	C2_DisInit	; CHANGE: was "jsr Event_handler"
	bsr.w	Event_handler	; CHANGE: added
	rts	
; ---- Recalc_mapbuf_coords (original source: MAIN/MAP/2DCITY.ASM)
Recalc_mapbuf_coords:
	movem.l	d0/d1,-(sp)
	move.w	#Def_mapbuf_X,Mapbuf_X
	move.w	#Def_mapbuf_Y,Mapbuf_Y
	move.w	Map_Xcoord,d0
	move.w	Map_Ycoord,d1
	cmpi.w	#12,d0
	bpl.s	.Skip_1
	subi.w	#11,d0
	add.w	d0,Mapbuf_X
	bra.s	.Go_1
.Skip_1:
	sub.w	Width_of_map,d0
	cmpi.w	#$fff6,d0	; CHANGE: was "cmpi.w #-11,d0"
	bmi.s	.Go_1
	addi.w	#10,d0
	add.w	d0,Mapbuf_X
.Go_1:
	cmpi.w	#10,d1
	bpl.s	.Skip_2
	subi.w	#10,d1
	add.w	d1,Mapbuf_Y
	bra.s	.Go_2
.Skip_2:
	sub.w	Height_of_map,d1
	cmpi.w	#$fff8,d1	; CHANGE: was "cmpi.w #-9,d1"
	bmi.s	.Go_2
	addi.w	#9,d1
	add.w	d1,Mapbuf_Y
.Go_2:
	movem.l	(sp)+,d0/d1
	rts	
C2_DisInit:
	sf.b	Time_lock
	movea.l	Mapd_ptr,a5
	bsr.w	Set_spell_area
	bsr.w	Set_map_music
	movea.l	Off_screen,a6
	moveq	#1,d0
	bsr.w	Show_layout
	bsr.w	Print_headline
	move.l	#W2_CIL,First_CIL_ptr
	bsr.w	Handle_CIL
	bsr.w	Show_control_icons
	st.b	B_5ac7e
	bsr.w	C2_DisUpd
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	Lay1_c1,a0
	bsr.w	Set_layout_data
	move.l	#D_1e1d8,Mousemove_ptr
	movea.l	Icondata_ptr,a0
	lea.l	$7d2(a0),a0
	lea.l	Pal_buffer,a1
	jsr	IFF_pal_convert
	lea.l	Subfade1,a2
T_04d9e:
	lea.l	Hbl_2D_map,a0
	jsr	Update_HBL
	jsr	My_vsync
	jsr	My_vsync
	lea.l	Below_pal_2D,a0
	jsr	Fade_pal
	bne.b	T_04d9e
	lea.l	Hbl_2D_map,a0
	jsr	Update_HBL
	rts
; ---- C2_ModExit (original source: MAIN/MAP/2DCITY.ASM)
C2_ModExit:
	bsr.w	Clear_persons_buffer
	movea.l	Mapd_ptr,a0
	jsr	Free_memory
	movea.l	Icondata_ptr,a0
	jsr	Free_memory
	movea.l	Maptext_ptr,a0
	jsr	Free_memory
	jsr	Next_generation
	rts	
T_04e02:
	st.b	Time_lock
	lea.l	Void,a1
	lea.l	Subfade1,a2
T_04e14:
	lea.l	Hbl_2D_map,a0
	jsr	Update_HBL
	jsr	My_vsync
	jsr	My_vsync
	lea.l	Below_pal_2D,a0
	jsr	Fade_pal
	bne.b	T_04e14
	lea.l	Hbl_2D_map,a0
	jsr	Update_HBL
	rts
; ---- C2_downright (original source: MAIN/MAP/2DCITY.ASM)
C2_downright:
	bsr.w	Before_move
	movem.l	d0-d2,-(sp)
	moveq.l	#-1,d2
	move.w	#2,View_direction
	move.w	Map_Xcoord,d0
	move.w	Map_Ycoord,d1
	addq.w	#1,d0
	addq.w	#1,d1
	bsr.w	Movement_check_2D
	beq.s	.Downright
	bsr.w	C2_down
	beq.s	.Exit
	bsr.w	C2_right
	bra.s	.Exit
.Downright:
	move.w	d0,Map_Xcoord
	move.w	d1,Map_Ycoord
	bsr.w	Move_down_2D
	bsr.w	Move_right_2D
	bsr.w	Build_2D_map
	jsr	Switch_screen
	bsr.w	After_move
	moveq.l	#0,d2
.Exit:
	tst.w	d2
	movem.l	(sp)+,d0-d2
	rts	
; ---- C2_upright (original source: MAIN/MAP/2DCITY.ASM)
C2_upright:
	bsr.w	Before_move
	movem.l	d0-d2,-(sp)
	moveq.l	#-1,d2
	move.w	#0,View_direction
	move.w	Map_Xcoord,d0
	move.w	Map_Ycoord,d1
	addq.w	#1,d0
	subq.w	#1,d1
	bsr.w	Movement_check_2D
	beq.s	.Upright
	bsr.w	C2_up
	beq.s	.Exit
	bsr.w	C2_right
	bra.s	.Exit
.Upright:
	move.w	d0,Map_Xcoord
	move.w	d1,Map_Ycoord
	bsr.w	Move_up_2D
	bsr.w	Move_right_2D
	bsr.w	Build_2D_map
	jsr	Switch_screen
	bsr.w	After_move
	moveq.l	#0,d2
.Exit:
	tst.w	d2
	movem.l	(sp)+,d0-d2
	rts	
; ---- C2_downleft (original source: MAIN/MAP/2DCITY.ASM)
C2_downleft:
	bsr.w	Before_move
	movem.l	d0-d2,-(sp)
	moveq.l	#-1,d2
	move.w	#2,View_direction
	move.w	Map_Xcoord,d0
	move.w	Map_Ycoord,d1
	subq.w	#1,d0
	addq.w	#1,d1
	bsr.w	Movement_check_2D
	beq.s	.Downleft
	bsr.w	C2_down
	beq.s	.Exit
	bsr.w	C2_left
	bra.s	.Exit
.Downleft:
	move.w	d0,Map_Xcoord
	move.w	d1,Map_Ycoord
	bsr.w	Move_down_2D
	bsr.w	Move_left_2D
	bsr.w	Build_2D_map
	jsr	Switch_screen
	bsr.w	After_move
	moveq.l	#0,d2
.Exit:
	tst.w	d2
	movem.l	(sp)+,d0-d2
	rts	
; ---- C2_upleft (original source: MAIN/MAP/2DCITY.ASM)
C2_upleft:
	bsr.w	Before_move
	movem.l	d0-d2,-(sp)
	moveq.l	#-1,d2
	move.w	#0,View_direction
	move.w	Map_Xcoord,d0
	move.w	Map_Ycoord,d1
	subq.w	#1,d0
	subq.w	#1,d1
	bsr.w	Movement_check_2D
	beq.s	.Upleft
	bsr.w	C2_up
	beq.s	.Exit
	bsr.w	C2_left
	bra.s	.Exit
.Upleft:
	move.w	d0,Map_Xcoord
	move.w	d1,Map_Ycoord
	bsr.w	Move_up_2D
	bsr.w	Move_left_2D
	bsr.w	Build_2D_map
	jsr	Switch_screen
	bsr.w	After_move
	moveq.l	#0,d2
.Exit:
	tst.w	d2
	movem.l	(sp)+,d0-d2
	rts	
; ---- C2_up (original source: MAIN/MAP/2DCITY.ASM)
C2_up:
	bsr.w	Before_move
	movem.l	d0-d2,-(sp)
	moveq.l	#-1,d2
	move.w	#0,View_direction
	move.w	Map_Xcoord,d0
	move.w	Map_Ycoord,d1
	subq.w	#1,d1
	bsr.w	Movement_check_2D
	sne	Bumped
	bne.s	.Exit
	move.w	d1,Map_Ycoord
	bsr.w	Move_up_2D
	bsr.w	Build_2D_map
	jsr	Switch_screen
	bsr.w	After_move
	moveq.l	#0,d2
.Exit:
	tst.w	d2
	movem.l	(sp)+,d0-d2
	rts	
; ---- C2_down (original source: MAIN/MAP/2DCITY.ASM)
C2_down:
	bsr.w	Before_move
	movem.l	d0-d2,-(sp)
	moveq.l	#-1,d2
	move.w	#2,View_direction
	move.w	Map_Xcoord,d0
	move.w	Map_Ycoord,d1
	addq.w	#1,d1
	bsr.w	Movement_check_2D
	sne	Bumped
	bne.s	.Exit
	move.w	d1,Map_Ycoord
	bsr.w	Move_down_2D
	bsr.w	Build_2D_map
	jsr	Switch_screen
	bsr.w	After_move
	moveq.l	#0,d2
.Exit:
	tst.w	d2
	movem.l	(sp)+,d0-d2
	rts	
; ---- C2_right (original source: MAIN/MAP/2DCITY.ASM)
C2_right:
	bsr.w	Before_move
	movem.l	d0-d2,-(sp)
	moveq.l	#-1,d2
	move.w	#1,View_direction
	move.w	Map_Xcoord,d0
	move.w	Map_Ycoord,d1
	addq.w	#1,d0
	bsr.w	Movement_check_2D
	sne	Bumped
	bne.s	.Exit
	move.w	d0,Map_Xcoord
	bsr.w	Move_right_2D
	bsr.w	Build_2D_map
	jsr	Switch_screen
	bsr.w	After_move
	moveq.l	#0,d2
.Exit:
	tst.w	d2
	movem.l	(sp)+,d0-d2
	rts	
; ---- C2_left (original source: MAIN/MAP/2DCITY.ASM)
C2_left:
	bsr.w	Before_move
	movem.l	d0-d2,-(sp)
	moveq.l	#-1,d2
	move.w	#3,View_direction
	move.w	Map_Xcoord,d0
	move.w	Map_Ycoord,d1
	subq.w	#1,d0
	bsr.w	Movement_check_2D
	sne	Bumped
	bne.s	.Exit
	move.w	d0,Map_Xcoord
	bsr.w	Move_left_2D
	bsr.w	Build_2D_map
	jsr	Switch_screen
	bsr.w	After_move
	moveq.l	#0,d2
.Exit:
	tst.w	d2
	movem.l	(sp)+,d0-d2
	rts	
C2_DisUpd:
	movem.l	d0-d1/d6-d7/a0-a4,-(a7)
	movea.l	Map_pointer,a1
	move.w	Map_Xcoord,d0
	sub.w	Mapbuf_X,d0
	subq.w	#$2,d0
	adda.w	d0,a1
	move.w	Map_Ycoord,d0
	sub.w	Mapbuf_Y,d0
	subq.w	#$2,d0
	move.w	Width_of_map,d1
	mulu.w	d1,d0
	adda.w	d0,a1
	subi.w	#$d,d1
	movea.l	a1,a2
	adda.w	Size_of_map,a2
	lea.l	Underlay_buf,a3
	lea.l	Overlay_buf,a4
	moveq	#10,d7
T_0514c:
	moveq	#12,d6
T_0514e:
	move.b	(a1)+,(a3)+
	move.b	(a2)+,(a4)+
	dbra	d6,T_0514e
	adda.w	d1,a1
	adda.w	d1,a2
	dbra	d7,T_0514c
	move.w	Map_Xcoord,d0
	move.w	Map_Ycoord,d1
	bsr.w	Get_2D_icon_status
	btst	#$3,d1
	sne.b	Party_invisible
	beq.b	T_05194
	lea.l	B_56027,a0
	move.w	Mapbuf_Y,d0
	mulu.w	#$d,d0
	add.w	Mapbuf_X,d0
	addq.b	#$1,(a0,d0.w)
T_05194:
	tst.b	Pause_Upd
	bne.b	T_051a0
	bsr.w	TwoD_char_handler
T_051a0:
	bsr.w	Build_2D_map
	bsr.w	Update_map_CIL
	tst.b	CombatReq
	beq.b	T_051bc
	lea.l	CombatReq_Mod,a0
	jsr	Push_Module
T_051bc:
	movem.l	(a7)+,d0-d1/d6-d7/a0-a4
	rts
; ---- Move_left_2D (original source: MAIN/MAP/2DCITY.ASM)
Move_left_2D:
	cmpi.w	#5,Mapbuf_X
	bne.s	.No_scroll
	cmpi.w	#11,Map_Xcoord
	bmi.s	.No_scroll
	move.w	#-1,Scroll_X
	bra.s	.Exit
.No_scroll:
	subq.w	#1,Mapbuf_X
.Exit:
	move.w	#-1,Half_X
	rts	
; ---- Move_right_2D (original source: MAIN/MAP/2DCITY.ASM)
Move_right_2D:
	move.l	d0,-(sp)
	cmpi.w	#5,Mapbuf_X
	bne.s	.No_scroll
	move.w	Width_of_map,d0
	subi.w	#9,d0
	cmp.w	Map_Xcoord,d0
	bls.s	.No_scroll
	move.w	#1,Scroll_X
	bra.s	.Exit
.No_scroll:
	addq.w	#1,Mapbuf_X
.Exit:
	move.w	#1,Half_X
	move.l	(sp)+,d0
	rts	
; ---- Move_up_2D (original source: MAIN/MAP/2DCITY.ASM)
Move_up_2D:
	cmpi.w	#4,Mapbuf_Y
	bne.s	.No_scroll
	cmpi.w	#10,Map_Ycoord
	bmi.s	.No_scroll
	move.w	#-1,Scroll_Y
	bra.s	.Exit
.No_scroll:
	subq.w	#1,Mapbuf_Y
.Exit:
	move.w	#-1,Half_Y
	rts	
; ---- Move_down_2D (original source: MAIN/MAP/2DCITY.ASM)
Move_down_2D:
	move.l	d0,-(sp)
	cmpi.w	#4,Mapbuf_Y
	bne.s	.No_scroll
	move.w	Height_of_map,d0
	subq.w	#8,d0
	cmp.w	Map_Ycoord,d0
	bls.s	.No_scroll
	move.w	#1,Scroll_Y
	bra.s	.Exit
.No_scroll:
	addq.w	#1,Mapbuf_Y
.Exit:
	move.w	#1,Half_Y
	move.l	(sp)+,d0
	rts	
