; MAIN/MAP/2DMAP.ASM (original module, merged with the disassembly of the shipped program)

	section	text

M2_time_evaluate:
	movem.l	d0-d1/a0,-(a7)
	movea.l	Current_active_char_data,a0
	btst	#$4,$3b(a0)
	sne.b	Stygian
	bne.w	.l_02844
	movea.l	Mapd_ptr,a0
	move.b	$5(a0),d0
	btst	#$0,d0
	beq.b	.l_027c8
	move.w	#$0,Current_radius
	move.w	#$0,New_radius
	bra.b	.l_02844
.l_027c8:
	btst	#$1,d0
	beq.b	.l_0280e
	move.w	Hour,d0
	moveq	#0,d1
	move.b	.l_027f4(pc,d0.w),d1
	tst.w	Spell_1_duration
	beq.b	.l_027ec
	move.w	Spell_1_data,d0
	lsl.w	#$3,d0
	add.w	d0,d1
.l_027ec:
	move.w	d1,New_radius
	bra.b	.l_02844
.l_027f4:
	dc.b	$10,$10,$10,$10,$10,$10,$28,$40,$c8,$c8,$c8,$c8,$c8,$c8,$c8,$c8
	dc.b	$c8,$40,$40,$28,$10,$10,$10,$10,$10,$00
.l_0280e:
	btst	#$2,d0
	beq.b	.l_02844
	cmpi.w	#$6,Travel_mode
	beq.b	.l_02844
	tst.w	Spell_1_duration
	seq.b	Stygian
	beq.b	.l_02844
	move.w	Spell_1_data,d1
	lsl.w	#$3,d1
	addi.w	#$10,d1
	move.w	d1,New_radius
	move.w	d1,Current_radius
.l_02844:
	movem.l	(a7)+,d0-d1/a0
	rts
Build_2D_map:
	movem.l	d0-d7/a0-a6,-(a7)
	bsr.w	M2_time_evaluate
	move.w	Mapbuf_X,d0
	move.w	Mapbuf_Y,d1
	addq.w	#$1,d0
	addq.w	#$1,d1
	add.w	d0,d0
	add.w	d1,d1
	add.w	Half_X,d0
	add.w	Half_Y,d1
	tst.w	Scroll_X
	bne.b	.l_02886
	sub.w	Half_X,d0
	sub.w	Half_X,d0
.l_02886:
	tst.w	Scroll_Y
	bne.b	.l_0289a
	sub.w	Half_Y,d1
	sub.w	Half_Y,d1
.l_0289a:
	move.w	d0,Buffer_X
	move.w	d1,Buffer_Y
	tst.b	Stygian
	beq.b	.l_028ce
	lea.l	Graphics_buf,a0
	moveq	#0,d0
	move.w	#$11df,d7
.l_028ba:
	move.l	d0,(a0)+
	dbra	d7,.l_028ba
	movea.l	Icondata_ptr,a0
	bsr.w	Display_party_icon
	bra.w	.l_02990
.l_028ce:
	bsr.w	T_05836
	movea.l	Icondata_ptr,a0
	lea.l	Underlay_buf,a1
	lea.l	Overlay_buf,a2
	lea.l	Persons_buf,a3
	lea.l	Trans_buf,a4
	movea.l	Iconstats_ptr,a5
	bsr.w	Get_hashable_number
	moveq	#0,d1
	moveq	#0,d2
	moveq	#10,d7
.l_02900:
	moveq	#0,d0
	moveq	#12,d6
.l_02904:
	move.b	(a1)+,d2
	subq.w	#$1,d2
	move.w	d2,d3
	add.w	d3,d3
	add.w	d3,d3
	move.l	(a5,d3.w),d3
	btst	#$f,d3
	bne.b	.l_0293c
	bsr.w	Display_underlay_icon
	move.b	(a2),d2
	beq.b	.l_0293c
	subq.w	#$1,d2
	move.w	d2,d3
	add.w	d3,d3
	add.w	d3,d3
	move.l	(a5,d3.w),d3
	btst	#$6,d3
	bne.b	.l_0293c
	btst	#$f,d3
	bne.b	.l_0293c
	bsr.w	Display_overlay_icon
.l_0293c:
	addq.l	#$1,a2
	move.b	(a3)+,d2
	beq.b	.l_02948
	subq.w	#$1,d2
	bsr.w	Display_overlay_icon
.l_02948:
	move.b	(a4)+,d2
	beq.b	.l_02952
	subq.w	#$1,d2
	bsr.w	Display_overlay_icon
.l_02952:
	addq.w	#$1,d0
	addq.w	#$1,d5
	dbra	d6,.l_02904
	addq.w	#$1,d1
	subi.w	#$d,d5
	add.w	Width_of_map,d5
	dbra	d7,.l_02900
	movea.l	Icondata_ptr,a0
	cmpi.w	#$5,Travel_mode
	bmi.b	.l_02984
	bsr.w	Display_sky_icons
	bsr.w	Display_party_icon
	bra.b	.l_0298c
.l_02984:
	bsr.w	Display_party_icon
	bsr.w	Display_sky_icons
.l_0298c:
	bsr.w	Display_night_circle
.l_02990:
	movea.l	Off_screen,a6
	bsr.w	Display_buffer
	bsr.w	Update_animation
	clr.l	Scroll_X
	clr.l	Half_X
	tst.b	Bumped
	beq.b	.l_029dc
	move.w	Buffer_X,d0
	move.w	Buffer_Y,d1
	lsl.w	#$3,d0
	lsl.w	#$3,d1
	addi.w	#$e,d0
	addi.w	#$17,d1
	lea.l	D_44f90,a0
	jsr	Blit_masked_block
	sf.b	Bumped
.l_029dc:
	bsr.w	Update_status_block
	bsr.w	Show_special_items
	bsr.w	Show_spells
	movem.l	(a7)+,d0-d7/a0-a6
	rts
; ---- Get_hashable_number (original source: MAIN/MAP/2DMAP.ASM)
Get_hashable_number:
	move.w	Map_Ycoord,d5
	sub.w	Buffer_Y,d5
	subq.w	#1,d5
	mulu.w	Width_of_map,d5
	add.w	Map_Xcoord,d5
	sub.w	Buffer_X,d5
	subq.w	#1,d5
	rts	
; ---- Display_sky_icons (original source: MAIN/MAP/2DMAP.ASM)
Display_sky_icons:
	movem.l	d0-d3/d5-d7/a0-a3,-(a7)	; CHANGE: was "movem.l d0-d3/d5-d7/a1-a3,-(sp)"
	lea.l	Underlay_buf,a1
	lea.l	Overlay_buf,a2
	movea.l	Iconstats_ptr,a3
	bsr.w	Get_hashable_number
	moveq.l	#0,d1
	moveq.l	#0,d2
	moveq.l	#10,d7
.Loop_1:
	moveq.l	#0,d0
	moveq.l	#12,d6
.Loop_2:
	move.b	(a1)+,d2
	subq.w	#1,d2
	move.w	d2,d3
	add.w	d3,d3
	add.w	d3,d3
	move.l	0(a3,d3.w),d3
	btst	#15,d3
	beq.s	.No_under
	bsr.w	Display_underlay_icon
	move.b	(a2)+,d2
	beq.s	.Next
	subq.w	#1,d2
	bsr.w	Display_overlay_icon
	bra.s	.Next
.No_under:
	move.b	(a2)+,d2
	beq.s	.Next
	subq.w	#1,d2
	move.w	d2,d3
	add.w	d3,d3
	add.w	d3,d3
	move.l	0(a3,d3.w),d3
	btst	#6,d3
	bne.s	.Draw
	btst	#15,d3
	beq.s	.Next
.Draw:
	bsr.w	Display_overlay_icon
.Next:
	addq.w	#1,d0
	addq.w	#1,d5
	dbra	d6,.Loop_2
	addq.w	#1,d1
	subi.w	#13,d5
	add.w	Width_of_map,d5
	dbra	d7,.Loop_1
	movem.l	(a7)+,d0-d3/d5-d7/a0-a3	; CHANGE: was "movem.l (sp)+,d0-d3/d5-d7/a1-a3"
	rts	
; ---- Display_party_icon (original source: MAIN/MAP/2DMAP.ASM)
Display_party_icon:
	movem.l	d0-d7/a0/a1,-(sp)
	tst.b	Party_invisible
	bne.w	.Exit
	lea.l	Hold_1(a0),a1
	moveq.l	#0,d0
	move.b	Travel_icon_start(a0),d0
	subq.w	#1,d0
	tst.b	Current_map_type
	beq.s	.Skip
	add.w	Travel_mode,d0
.Skip:
	add.w	d0,d0
	move.w	0(a1,d0.w),d4
	move.w	View_direction,d0
	add.w	d0,d4
	lea.l	Frame_graphics-128(a0),a0
	mulu.w	#134,d4
	adda.l	d4,a0
	move.w	Buffer_X,d0
	move.w	Buffer_Y,d1
	move.w	d1,d2
	mulu.w	#13*64,d2
	move.w	d0,d3
	andi.w	#$fffe,d3
	add.w	d3,d3
	add.w	d3,d3
	add.w	d3,d2
	moveq.l	#1,d3
	and.w	d0,d3
	lsl.w	#3,d3
	lea.l	Graphics_buf,a1
	adda.w	d2,a1
	move.l	#$ffff0000,d5
	ror.l	d3,d5
	move.w	d3,d6
	moveq.l	#15,d7
.Loop:
	moveq.l	#0,d0
	move.w	(a0)+,d0
	moveq.l	#0,d1
	move.w	(a0)+,d1
	moveq.l	#0,d2
	move.w	(a0)+,d2
	moveq.l	#0,d3
	move.w	(a0)+,d3
	ror.l	d6,d0
	ror.l	d6,d1
	ror.l	d6,d2
	ror.l	d6,d3
	move.l	d0,d4
	or.l	d1,d4
	or.l	d2,d4
	or.l	d3,d4
	not.l	d4
	or.l	d5,d4
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
	lea.l	13*8-16(a1),a1
	dbra	d7,.Loop
.Exit:
	movem.l	(sp)+,d0-d7/a0/a1
	rts	
; ---- Display_underlay_icon (original source: MAIN/MAP/2DMAP.ASM)
Display_underlay_icon:
	movem.l	d0-d6/a0-a2,-(sp)
	lea.l	Frames(a0),a1
	moveq.l	#0,d3
	move.b	0(a1,d2.w),d3
	subq.w	#1,d3
	lea.l	250(a1),a1
	add.w	d2,d2
	move.w	0(a1,d2.w),d4
	lea.l	500(a1),a1
	add.w	d2,d2
	move.l	0(a1,d2.w),d6
	lea.l	Circle_anim,a1
	btst	#0,d6
	beq.s	.Circle
	lea.l	Wave_anim,a1
.Circle:
	add.w	d3,d3
	add.w	d3,d3
	adda.w	d3,a1
	btst	#4,d6
	beq.s	.No_random
	move.b	1(a1),d2
	ext.w	d2
	add.w	d2,d5
	andi.w	#$000f,d5
	move.w	2(a1),d2
	btst	d5,d2
	beq.s	.No_anim
.No_random:
	move.b	(a1),d3
	ext.w	d3
	add.w	d3,d4
.No_anim:
	lea.l	Frame_graphics-128(a0),a0
	mulu.w	#134,d4
	adda.l	d4,a0
	lea.l	Graphics_buf,a1
	lsl.w	#3,d0
	adda.w	d0,a1
	mulu.w	#13*128,d1
	adda.w	d1,a1
	moveq.l	#15,d2
.Loop:
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	lea.l	13*8-8(a1),a1
	dbra	d2,.Loop
.Exit:
	movem.l	(sp)+,d0-d6/a0-a2
	rts	
; ---- Display_overlay_icon (original source: MAIN/MAP/2DMAP.ASM)
Display_overlay_icon:
	movem.l	d0-d6/a0/a1,-(sp)
	lea.l	Frames(a0),a1
	moveq.l	#0,d3
	move.b	0(a1,d2.w),d3
	subq.w	#1,d3
	lea.l	250(a1),a1
	add.w	d2,d2
	move.w	0(a1,d2.w),d4
	lea.l	500(a1),a1
	add.w	d2,d2
	move.l	0(a1,d2.w),d6
	lea.l	Circle_anim,a1
	btst	#0,d6
	beq.s	.Circle
	lea.l	Wave_anim,a1
.Circle:
	add.w	d3,d3
	add.w	d3,d3
	adda.w	d3,a1
	btst	#4,d6
	beq.s	.No_random
	move.b	1(a1),d2
	ext.w	d2
	add.w	d2,d5
	andi.w	#$000f,d5
	move.w	2(a1),d2
	btst	d5,d2
	beq.s	.No_anim
.No_random:
	move.b	(a1),d3
	ext.w	d3
	add.w	d3,d4
.No_anim:
	lea.l	Frame_graphics-128(a0),a0
	mulu.w	#134,d4
	adda.l	d4,a0
	lea.l	Graphics_buf,a1
	lsl.w	#3,d0
	adda.w	d0,a1
	mulu.w	#13*128,d1
	adda.w	d1,a1
	moveq.l	#15,d5
.Loop:
	movem.w	(a0)+,d0-d3
	move.w	d0,d4
	or.w	d1,d4
	or.w	d2,d4
	or.w	d3,d4
	not.w	d4
	and.w	d4,(a1)
	or.w	d0,(a1)+
	and.w	d4,(a1)
	or.w	d1,(a1)+
	and.w	d4,(a1)
	or.w	d2,(a1)+
	and.w	d4,(a1)
	or.w	d3,(a1)+
	lea.l	13*8-8(a1),a1
	dbra	d5,.Loop
	movem.l	(sp)+,d0-d6/a0/a1
	rts	
; ---- Display_buffer (original source: MAIN/MAP/2DMAP.ASM)
Display_buffer:
	movem.l	d0-d7/a0-a3,-(sp)
	lea.l	Graphics_buf+1672,a0
	moveq.l	#16,d0
	moveq.l	#49,d1
	jsr	Coord_convert
	lea.l	0(a6,d2.w),a1
	move.w	#143,d7
	move.w	Scroll_Y,d0
	muls.w	#832,d0
	tst.w	Scroll_X
	bne.s	.Shifted
	adda.w	d0,a0
.Loop_1:
	movea.l	a0,a2
	movea.l	a1,a3
	moveq.l	#10,d6
.Loop_2:
	move.l	(a2)+,(a3)+
	move.l	(a2)+,(a3)+
	dbra	d6,.Loop_2
	lea.l	13*8(a0),a0
	lea.l	160(a1),a1
	dbra	d7,.Loop_1
	bra.s	.Exit
.Shifted:
	bpl.s	.Skip
	subq.w	#8,d0
.Skip:
	adda.w	d0,a0
.Loop_3:
	movea.l	a0,a2
	movea.l	a1,a3
	movep.l	1(a2),d0
	movep.l	d0,0(a3)
	addq.l	#8,a2
	moveq.l	#10-1,d6
.Loop_4:
	movep.l	0(a2),d0
	movep.l	d0,1(a3)
	movep.l	1(a2),d0
	movep.l	d0,8(a3)
	addq.l	#8,a2
	addq.l	#8,a3
	dbra	d6,.Loop_4
	movep.l	0(a2),d0
	movep.l	d0,1(a3)
	lea.l	13*8(a0),a0
	lea.l	160(a1),a1
	dbra	d7,.Loop_3
.Exit:
	movem.l	(sp)+,d0-d7/a0-a3
	rts	
; ---- Get_2D_icon_status (original source: MAIN/MAP/2DMAP.ASM)
Get_2D_icon_status:
	movem.l	a0/a1,-(sp)
	movea.l	Iconstats_ptr,a0
	tst.b	Current_map_type
	bne.s	.Wild
	movea.l	Map_pointer,a1
	subq.w	#1,d1
	mulu.w	Width_of_map,d1
	add.w	d0,d1
	lea.l	-1(a1,d1.w),a1
	moveq.l	#0,d0
	move.b	(a1),d0
	subq.w	#1,d0
	add.w	d0,d0
	add.w	d0,d0
	move.l	0(a0,d0.w),d0
	adda.w	Size_of_map,a1
	moveq.l	#0,d1
	move.b	(a1),d1
	beq.s	.Exit
	subq.w	#1,d1
	add.w	d1,d1
	add.w	d1,d1
	move.l	0(a0,d1.w),d1
	bra.s	.Exit
.Wild:
	lea.l	Underlay_buf+71,a1
	sub.w	Map_Xcoord,d0
	sub.w	Map_Ycoord,d1
	mulu.w	#13,d1
	add.w	d0,d1
	adda.w	d1,a1
	moveq.l	#0,d0
	move.b	(a1),d0
	subq.w	#1,d0
	add.w	d0,d0
	add.w	d0,d0
	move.l	0(a0,d0.w),d0
	moveq.l	#0,d1
	move.b	143(a1),d1
	beq.s	.Exit
	subq.w	#1,d1
	add.w	d1,d1
	add.w	d1,d1
	move.l	0(a0,d1.w),d1
.Exit:
	movem.l	(sp)+,a0/a1
	rts	
; ---- Movement_check_2D (original source: MAIN/MAP/2DMAP.ASM)
Movement_check_2D:
	movem.l	d0-d3/a0,-(sp)
	tst.b	Current_map_type	; CHANGE: added
	bne.b	.c_02df0	; CHANGE: added
	cmpi.w	#$6,d0	; CHANGE: added
	bmi.b	.c_02dea	; CHANGE: added
	cmpi.w	#$6,d1	; CHANGE: added
	bmi.b	.c_02dea	; CHANGE: added
	move.w	Width_of_map,d2	; CHANGE: added
	subq.w	#$5,d2	; CHANGE: added
	cmp.w	d0,d2	; CHANGE: added
	bmi.b	.c_02dea	; CHANGE: added
	move.w	Height_of_map,d2	; CHANGE: added
	subq.w	#$5,d2	; CHANGE: added
	cmp.w	d1,d2	; CHANGE: added
	bpl.b	.c_02df0	; CHANGE: added
.c_02dea:
	moveq	#-1,d3	; CHANGE: added
	bra.w	.Exit	; CHANGE: added
.c_02df0:
	cmpi.w	#6,Travel_mode
	bne.s	.Normal
	moveq.l	#0,d3
	bra.s	.Exit
.Normal:
	moveq.l	#-1,d3
	moveq.l	#0,d2
	tst.b	Current_map_type
	beq.s	.Skip
	move.w	Travel_mode,d2
.Skip:
	addq.w	#8,d2
	sub.w	Map_Xcoord,d0
	sub.w	Map_Ycoord,d1
	add.w	Mapbuf_X,d0
	add.w	Mapbuf_Y,d1
	lea.l	Underlay_buf+14,a0
	mulu.w	#13,d1
	add.w	d0,d1
	adda.w	d1,a0
	moveq.l	#0,d0
	move.b	(a0),d0
	moveq.l	#0,d1
	move.b	143(a0),d1
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
	movem.l	(sp)+,d0-d3/a0
	rts	
; ---- Display_night_circle (original source: MAIN/MAP/2DMAP.ASM)
Display_night_circle:
	movem.l	d0-d7/a0/a1/a5,-(sp)
	cmpi.w	#6,Travel_mode
	beq.w	.Exit
	lea.l	Graphics_buf,a5
	move.w	#13*8,d5
	move.w	Current_radius,d1
	bne.s	.Ok
	tst.w	New_radius
	beq.w	.Exit
.Ok:
	cmp.w	New_radius,d1
	beq.s	.Continue
	bmi.s	.Up
	subq.w	#$4,d1	; CHANGE: was "subq.w #2,d1"
	move.w	d1,Current_radius
	bra.s	.Continue
.Up:
	addq.w	#$4,d1	; CHANGE: was ".Up: addq.w #2,d1"
	cmpi.w	#Max_radius,d1
	bhi.w	.Exit
	move.w	d1,Current_radius
.Continue:
	move.w	Buffer_X,d6
	move.w	Buffer_Y,d7
	addq.w	#1,d6
	addq.w	#1,d7
	lsl.w	#3,d6
	lsl.w	#3,d7
	moveq.l	#0,d2
	movea.l	a5,a0
	move.w	d7,d0
	sub.w	d1,d0
	cmpi.w	#175,d0
	bhi.s	.Clip_1
	bra.s	.Entry_1
.Loop_1:
	moveq.l	#12,d3
.Loop_3a:
	move.l	d2,(a0)+
	move.l	d2,(a0)+
	dbra	d3,.Loop_3a
.Entry_1:
	dbra	d0,.Loop_1
.Clip_1:
	lea.l	18304(a5),a0
	move.w	#176,d0
	sub.w	d1,d0
	sub.w	d7,d0
	cmpi.w	#175,d0
	bhi.s	.Clip_2
	bra.s	.Entry_2
.Loop_2:
	moveq.l	#12,d3
.Loop_3b:
	move.l	d2,-(a0)
	move.l	d2,-(a0)
	dbra	d3,.Loop_3b
.Entry_2:
	dbra	d0,.Loop_2
.Clip_2:
	moveq.l	#0,d0
	moveq.l	#0,d2
	move.w	d1,d3
	subq.w	#1,d3
	add.w	d3,d3
	move.w	d1,d4
.Again:
	exg.l	d1,d0	; CHANGE: was ".Again: exg.l d0,d1"
	bsr.w	Draw_four_lines
	exg.l	d1,d0	; CHANGE: was "exg.l d0,d1"
	addq.w	#1,d0
	add.w	d2,d4
	addq.w	#2,d2
	tst.w	d4
	bmi.s	.Skip
	bsr.w	Draw_four_lines
	subq.w	#1,d1
	sub.w	d3,d4
	subq.w	#2,d3
.Skip:
	cmp.w	d1,d0
	bls.s	.Again
.Exit:
	movem.l	(sp)+,d0-d7/a0/a1/a5
	rts	
; ---- Draw_four_lines (original source: MAIN/MAP/2DMAP.ASM)
Draw_four_lines:
	movem.l	d0-d4/d6,-(sp)
	move.w	d6,d2
	add.w	d0,d2
	sub.w	d6,d0
	neg.w	d0
	add.w	d7,d1
	bsr.w	Draw_two_lines
	sub.w	d7,d1
	neg.w	d1
	add.w	d7,d1
	bsr.w	Draw_two_lines
	movem.l	(sp)+,d0-d4/d6
	rts	
; ---- Draw_two_lines (original source: MAIN/MAP/2DMAP.ASM)
Draw_two_lines:
	cmpi.w	#175,d1
	bhi.s	.Exit
	moveq.l	#0,d6
	movea.l	a5,a0
	move.w	d1,d3
	mulu.w	d5,d3
	adda.w	d3,a0
	movea.l	a0,a1
	adda.w	d5,a1
	cmpi.w	#207,d0
	bhi.s	.Skip
	move.w	d0,d3
	lsr.w	#4,d3
	bra.s	.Entry_1
.Loop_1:
	move.l	d6,(a0)+
	move.l	d6,(a0)+
.Entry_1:
	dbra	d3,.Loop_1
	move.w	d0,d4
	andi.w	#$000f,d4
	move.l	#$0000ffff,d3
	ror.l	d4,d3
	and.w	d3,(a0)+
	and.w	d3,(a0)+	; CHANGE: added
	and.w	d3,(a0)+	; CHANGE: added
	and.w	d3,(a0)+	; CHANGE: added
.Skip:
	cmpi.w	#207,d2
	bhi.s	.Exit
	move.w	#207,d3
	sub.w	d2,d3
	lsr.w	#4,d3
	bra.s	.Entry_2
.Loop_2:
	move.l	d6,-(a1)
	move.l	d6,-(a1)
.Entry_2:
	dbra	d3,.Loop_2
	move.w	d2,d4
	andi.w	#$000f,d4
	move.l	#$ffff0000,d3
	ror.l	d4,d3
	and.w	d3,-(a1)
	and.w	d3,-(a1)	; CHANGE: added
	and.w	d3,-(a1)	; CHANGE: added
	and.w	d3,-(a1)	; CHANGE: added
.Exit:
	rts	

	section	bss

Current_radius:
	ds.b	2
New_radius:
	ds.b	2
Mapbuf_X:
	ds.b	2
Mapbuf_Y:
	ds.b	2
Buffer_X:
	ds.b	2
Buffer_Y:
	ds.b	2
Half_X:
	ds.b	2
Half_Y:
	ds.b	2
Scroll_X:
	ds.b	2
Scroll_Y:
	ds.b	2
Underlay_buf:
	ds.b	14
B_52f66:
	ds.b	57
B_52f9f:
	ds.b	72
Overlay_buf:
	ds.b	14
B_52ff5:
	ds.b	129
Persons_buf:
	ds.b	143
Trans_buf:
	ds.b	143
Graphics_buf:
	ds.b	1672
B_5381c:
	ds.b	16632
B_57914:
	ds.b	2
