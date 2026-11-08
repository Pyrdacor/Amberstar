; LAYOUT/LAYOUT.ASM (original module, merged with the disassembly of the shipped program)

	section	text

; ---- Show_updated_status_block (original source: LAYOUT/LAYOUT.ASM)
Show_updated_status_block:
	tst.b	Updated
	beq.s	.Exit
	jsr	Mouse_off
	move.b	Updated,d4
	moveq.l	#16,d0
	moveq.l	#1,d1
	moveq.l	#1,d5
	moveq.l	#3,d6
	moveq.l	#35,d7
	movea.l	Screen_base,a0
	movea.l	Off_screen,a1
.Loop:
	btst	d5,d4
	beq.s	.Next
	jsr	Duplicate_block
.Next:
	addi.w	#48,d0
	addq.w	#1,d5
	cmpi.w	#6,d5
	bls.s	.Loop
	sf.b	Updated	; CHANGE: was "clr.b Updated"
	jsr	Mouse_on
.Exit:
	rts	
; ---- Force_char_update (original source: LAYOUT/LAYOUT.ASM)
Force_char_update:
	movem.l	d0/a0,-(sp)
	lea.l	Shadow_data,a0
	subq.w	#1,d0
	mulu.w	#XSize,d0
	clr.l	0(a0,d0.w)
	movem.l	(sp)+,d0/a0
	rts	
; ---- Update_status_block (original source: LAYOUT/LAYOUT.ASM)
Update_status_block:
	movem.l	d0-d7/a0-a4/a6,-(sp)
	lea.l	Shadow_data,a1
	lea.l	Chard_ptrs,a2
	lea.l	Char_status_icons,a3
	movea.l	Off_screen,a6
	move.w	Active_member,d1
	cmp.w	XActive_member,d1
	beq.s	.Continue
	move.w	XActive_member,d0
	beq.s	.Skip1
	subq.w	#1,d0
	mulu.w	#XSize,d0
	clr.l	0(a1,d0.w)
.Skip1:
	tst.w	d1
	beq.s	.Skip2
	move.w	d1,d0
	subq.w	#1,d0
	mulu.w	#XSize,d0
	clr.l	0(a1,d0.w)
.Skip2:
	move.w	d1,XActive_member
.Continue:
	moveq.l	#48,d4
	moveq.l	#1,d5
.Loop:
	tst.l	(a2)
	bne.s	.Not_empty
	tst.l	(a1)
	beq.s	.Next
	bsr.w	Erase_portrait
	bsr.w	Erase_status_icon
	bsr.w	Erase_bars
	clr.l	(a1)
	bset	d5,Updated
	bra.s	.Next
.Not_empty:
	movea.l	(a2),a4
	cmpa.l	(a1),a4
	beq.s	.Same_character
	move.l	a4,(a1)
	clr.l	$4(a1)	; CHANGE: added
	clr.l	$8(a1)	; CHANGE: added
	clr.w	$c(a1)	; CHANGE: added
	bsr.w	Erase_status_icon	; CHANGE: added
	bsr.w	Erase_bars	; CHANGE: added
	bsr.w	Display_portrait
	bsr.w	Update_status_icon
	bsr.w	Update_bars
	bset	d5,Updated
	bra.s	.Next
.Same_character:
	cmpi.b	#1,XStat_icon(a1)
	beq.s	.Next
	move.w	Body_conditions(a4),d0
	andi.w	#$e000,d0
	beq.s	.Not_dead
	move.b	#1,(a3)
	bsr.w	Display_portrait
	bsr.w	Update_status_icon
	bsr.w	Erase_bars
	bset	d5,Updated
	bra.s	.Next
.Not_dead:
	bsr.w	Update_status_icon
	bsr.w	Update_bars
.Next:
	lea.l	XSize(a1),a1
	addq.l	#4,a2
	addq.l	#1,a3
	addi.w	#48,d4
	addq.l	#1,d5
	cmpi.w	#6,d5
	bls.w	.Loop
	movem.l	(sp)+,d0-d7/a0-a4/a6
	rts	
; ---- Display_portrait (original source: LAYOUT/LAYOUT.ASM)
Display_portrait:
	movem.l	d0/d1/d6/d7/a0/a1,-(sp)
	lea.l	Portrait+6(a4),a0
	move.w	Body_conditions(a4),d0
	andi.w	#$e000,d0
	beq.s	.Not_dead
	lea.l	Skull_portrait,a0
.Not_dead:
	moveq.l	#-32,d0
	add.w	d4,d0
	moveq.l	#1,d1
	moveq.l	#2,d6
	moveq.l	#34,d7
	jsr	Blot_unmasked_block
	moveq.l	#35,d1
	moveq.l	#1,d7
	lea.l	Topblk_bot,a0
	jsr	Blot_unmasked_block
	lea.l	Char_name(a4),a0
	lea.l	Temp_name+4,a1
	moveq.l	#5-1,d7
.Loop3:
	move.b	(a0)+,(a1)+
	dbeq	d7,.Loop3
	lea.l	Status_PA,a0
	bsr.w	Push_PA
	addq.w	#2,d0
	moveq.l	#31,d1
	jsr	IG_Set_cursor
	moveq.l	#9,d0
	cmp.w	Active_member,d5
	bne.s	.Snarl
	moveq.l	#8,d0
.Snarl:
	lea.l	Temp_name,a0
	move.b	d0,1(a0)
	jsr	IG_Print
	bsr.w	Pop_PA
	movem.l	(sp)+,d0/d1/d6/d7/a0/a1
	rts	
; ---- Update_status_icon (original source: LAYOUT/LAYOUT.ASM)
Update_status_icon:
	movem.l	d0-d2/a0,-(sp)
	move.b	(a3),d2
	cmp.b	XStat_icon(a1),d2
	beq.s	.Exit
	move.b	d2,XStat_icon(a1)
	bsr.w	Erase_status_icon
	move.w	d4,d0
	tst.b	d2
	beq.s	.No_new
	moveq.l	#1,d1
	lea.l	Status_icn-128,a0
	ext.w	d2
	lsl.w	#7,d2
	adda.w	d2,a0
	jsr	Put_masked_block
.No_new:
	bset	d5,Updated
.Exit:
	movem.l	(sp)+,d0-d2/a0
	rts	
; ---- Update_bars (original source: LAYOUT/LAYOUT.ASM)
Update_bars:
	movem.l	d0/d1/d6/d7/a0,-(sp)
	move.w	Life_points_max(a4),d0
	add.w	Life_points_max_magic(a4),d0
	cmp.w	XLP_max(a1),d0
	bne.s	.Redraw
	move.w	Life_points_normal(a4),d0
	cmp.w	XLP_norm(a1),d0
	bne.s	.Redraw
	move.w	Power_points_max(a4),d0
	add.w	Power_points_max_magic(a4),d0
	cmp.w	XPP_max(a1),d0
	bne.s	.Redraw
	move.w	Power_points_normal(a4),d3
	cmp.w	XPP_norm(a1),d3
	beq.w	.Exit
.Redraw:
	bsr.w	Erase_bars
	bset	d5,Updated
	move.w	d4,d0
	move.w	Life_points_max(a4),d6
	add.w	Life_points_max_magic(a4),d6
	move.w	d6,XLP_max(a1)
	beq.s	.Do_power
	move.w	Life_points_normal(a4),d7
	move.w	d7,XLP_norm(a1)
	beq.s	.Exit
	cmp.w	d6,d7
	bmi.s	.Less1
	moveq.l	#16,d7
	bra.s	.Not_zero1
.Less1:
	ext.l	d7
	lsl.l	#4,d7
	divu.w	d6,d7
	bne.s	.Not_zero1
	addq.l	#1,d7
.Not_zero1:
	addq.l	#1,d7
	moveq.l	#35,d1
	sub.w	d7,d1
	moveq.l	#1,d6
	lea.l	Red_bar,a0
	jsr	Blot_masked_block
.Do_power:
	move.w	Power_points_max(a4),d6
	add.w	Power_points_max_magic(a4),d6
	move.w	d6,XPP_max(a1)
	beq.s	.Exit
	move.w	Power_points_normal(a4),d7
	move.w	d7,XPP_norm(a1)
	beq.s	.Exit
	cmp.w	d6,d7
	bmi.s	.Less2
	moveq.l	#16,d7
	bra.s	.Not_zero2
.Less2:
	ext.l	d7
	lsl.l	#4,d7
	divu.w	d6,d7
	bne.s	.Not_zero2
	addq.l	#1,d7
.Not_zero2:
	addq.l	#1,d7
	moveq.l	#35,d1
	sub.w	d7,d1
	moveq.l	#1,d6
	lea.l	Blue_bar,a0
	jsr	Blot_masked_block
.Exit:
	movem.l	(sp)+,d0/d1/d6/d7/a0
	rts	
; ---- Erase_portrait (original source: LAYOUT/LAYOUT.ASM)
Erase_portrait:
	movem.l	d0/d1/d6/d7/a0,-(sp)
	moveq.l	#-32,d0
	add.w	d4,d0
	moveq.l	#1,d1
	moveq.l	#2,d6
	moveq.l	#34,d7
	lea.l	D_40aea,a0	; CHANGE: was "lea.l Void,a0"
	jsr	Blot_unmasked_block
	moveq.l	#35,d1
	moveq.l	#1,d7
	lea.l	Topblk_bot,a0
	jsr	Blot_unmasked_block
	movem.l	(sp)+,d0/d1/d6/d7/a0
	rts	
; ---- Erase_status_icon (original source: LAYOUT/LAYOUT.ASM)
Erase_status_icon:
	movem.l	d0/d1/a0,-(sp)
	move.w	d4,d0
	moveq.l	#1,d1
	lea.l	Topblk_mid+8,a0
	jsr	Put_unmasked_block
	movem.l	(sp)+,d0/d1/a0
	rts	
; ---- Erase_bars (original source: LAYOUT/LAYOUT.ASM)
Erase_bars:
	movem.l	d0/d1/d6/d7/a0,-(sp)
	move.w	d4,d0
	moveq.l	#18,d1
	moveq.l	#1,d6
	moveq.l	#17,d7
	lea.l	Topblk_mid+144,a0
	jsr	Blot_unmasked_block
	movem.l	(sp)+,d0/d1/d6/d7/a0
	rts	
; ---- Show_spells (original source: LAYOUT/LAYOUT.ASM)
Show_spells:
	movem.l	d0-d3/d6/d7/a0/a1/a6,-(sp)
	lea.l	Daynight_icn+4864,a0
	lea.l	Spell_1_duration,a1
	movea.l	Off_screen,a6
	move.w	#208,d0
	move.w	#49+64,d1
	move.w	#208+95,d2
	move.w	#128,d3
	moveq.l	#2,d6
	jsr	Draw_box
	moveq.l	#6-1,d7
.Loop:
	tst.w	(a1)+
	beq.s	.Next
	jsr	Put_unmasked_block
.Next:
	addi.w	#16,d0
	lea.l	128(a0),a0
	dbra	d7,.Loop
	movem.l	(sp)+,d0-d3/d6/d7/a0/a1/a6
	rts	
; ---- Show_special_items (original source: LAYOUT/LAYOUT.ASM)
Show_special_items:
	movem.l	d0-d3/d6/d7/a0/a1/a3/a6,-(sp)
	movea.l	Off_screen,a6
	btst	#0,Special_item_flags+1
	beq.s	.No_compass
	lea.l	Daynight_icn+2048,a0
	cmpi.b	#2,Current_map_type
	bmi.s	.2D_map
	move.w	View_direction,d0
	moveq.l	#9,d1
	lsl.w	d1,d0
	adda.w	d0,a0
.2D_map:
	move.w	#208,d0
	move.w	#49+16,d1
	moveq.l	#2,d6
	moveq.l	#32,d7
	jsr	Blot_unmasked_block
.No_compass:
	btst	#1,Special_item_flags+1
	beq.s	.No_Amberstar
	move.w	#208+32,d0
	move.w	#49,d1
	moveq.l	#2,d6
	moveq.l	#32,d7
	lea.l	Daynight_icn+4096,a0
	jsr	Blot_unmasked_block
.No_Amberstar:
	btst	#2,Special_item_flags+1
	beq.s	.No_daynight
	lea.l	Daynight_icn,a0
	move.w	Hour,d0
	move.b	.Daynight_tab(pc,d0.w),d0
	moveq.l	#9,d1
	lsl.w	d1,d0
	adda.w	d0,a0
	move.w	#208+64,d0
	move.w	#49+16,d1
	moveq.l	#2,d6
	moveq.l	#32,d7
	jsr	Blot_unmasked_block
	bra.s	.No_daynight
.Daynight_tab:
	dc.b	0,0,0,0,0,0,1,1,2,2,2,2,2,2,2,2,2,2
	dc.b	3,3,0,0,0,0
.No_daynight:
	btst	#3,Special_item_flags+1
	beq.s	.No_windchain
	move.w	#208+32,d0
	move.w	#49+32,d1
	moveq.l	#2,d6
	moveq.l	#16,d7
	lea.l	Daynight_icn+4608,a0
	jsr	Blot_unmasked_block
.No_windchain:
	btst	#4,Special_item_flags+1
	beq.w	.No_coordinates
	lea.l	Control_icn,a0
	move.w	#208,d0
	move.w	#49,d1
	moveq.l	#2,d6
	moveq.l	#16,d7
	jsr	Blot_unmasked_block
	move.w	Map_Xcoord,d2
	move.w	Map_Ycoord,d3
	cmpi.b	#1,Current_map_type
	bne.s	.No_wild
	move.w	World_X,d0
	mulu.w	#Submap_width,d0
	add.w	d0,d2
	move.w	World_Y,d0
	mulu.w	#Submap_height,d0
	add.w	d0,d3
.No_wild:
	moveq.l	#3,d7
	move.w	#208+2,d0
	move.w	#49+2,d1
	jsr	IG_Set_cursor
	move.w	d2,d0
	moveq.l	#"0",d1
	lea.l	.X_string,a0
	lea.l	6(a0),a3
	jsr	RConvert_number
	jsr	IG_Print
	move.w	#208+2,d0
	move.w	#49+10,d1
	jsr	IG_Set_cursor
	move.w	d3,d0
	moveq.l	#"0",d1
	lea.l	.Y_string,a0
	lea.l	2(a0),a3
	jsr	RConvert_number
	jsr	IG_Print
.No_coordinates:
	btst	#5,Special_item_flags+1
	beq.s	.No_time
	lea.l	Control_icn,a0
	move.w	#208+64,d0
	move.w	#49,d1
	moveq.l	#2,d6
	moveq.l	#16,d7
	jsr	Blot_unmasked_block
	move.w	#208+65,d0
	move.w	#49+5,d1
	jsr	IG_Set_cursor
	lea.l	Time_string,a0
	moveq.l	#"0",d1
	moveq.l	#2,d7
	move.w	Hour,d0
	lea.l	4(a0),a3
	jsr	RConvert_number
	move.w	Minute,d0
	lea.l	7(a0),a3
	jsr	RConvert_number
	jsr	IG_Print
.No_time:
	movem.l	(sp)+,d0-d3/d6/d7/a0/a1/a3/a6
	rts	
.X_string:
	dc.b	1,15,2,2
	dc.b	"X:   ",0
.Y_string:
	dc.b	"Y:   ",0
	even	
; ---- Show_layout (original source: LAYOUT/LAYOUT.ASM)
Show_layout:
	movem.l	d0-d7/a0-a2,-(sp)
	subq.w	#1,d0
	cmpi.w	#Max_layouts+1,d0
	bmi.s	.No_error
	lea.l	ET_Show_layout_1,a1	; ERROR "[ Show_layout ] : Illegal input !!!"
	jsr	DI_Error
	bra.w	.Exit
.No_error:
	lea.l	Layouts,a2
	mulu.w	#220,d0
	adda.w	d0,a2
	lea.l	Layout_icn,a1
	moveq.l	#0,d0
	move.w	#Layout_1st_line,d1
	moveq.l	#20-1,d5
	moveq.l	#1,d6
	moveq.l	#12,d7
.Loop_1:
	moveq.l	#0,d2
	move.b	(a2)+,d2
	subq.w	#1,d2
	lea.l	32(a1),a0
	lsl.w	#7,d2
	adda.w	d2,a0
	jsr	Blot_unmasked_block
	addi.w	#16,d0
	dbra	d5,.Loop_1
	move.w	#Layout_1st_line+12,d1
	moveq.l	#9-1,d7
.Loop_2:
	moveq.l	#0,d0
	moveq.l	#20-1,d6
.Loop_3:
	moveq.l	#0,d2
	move.b	(a2)+,d2
	subq.w	#1,d2
	movea.l	a1,a0
	lsl.w	#7,d2
	adda.w	d2,a0
	jsr	Put_unmasked_block
	addi.w	#16,d0
	dbra	d6,.Loop_3
	addi.w	#16,d1
	dbra	d7,.Loop_2
	moveq.l	#0,d0
	move.w	#193,d1
	moveq.l	#20-1,d5
	moveq.l	#1,d6
	moveq.l	#7,d7
.Loop_4:
	moveq.l	#0,d2
	move.b	(a2)+,d2
	subq.w	#1,d2
	movea.l	a1,a0
	lsl.w	#7,d2
	adda.w	d2,a0
	jsr	Blot_unmasked_block
	addi.w	#16,d0
	dbra	d5,.Loop_4
	lea.l	Bot_corners,a0
	lea.l	Bot_masks,a1
	move.w	#0,d0
	move.w	#184,d1
	jsr	Coord_conv
	lea.l	0(a6,d2.w),a2
	moveq.l	#15,d7
.Loop_5:
	movem.w	(a2),d0-d3
	move.w	(a1)+,d4
	not.w	d4
	and.w	d4,d0
	and.w	d4,d1
	and.w	d4,d2
	and.w	d4,d3
	or.w	(a0)+,d0
	or.w	(a0)+,d1
	or.w	(a0)+,d2
	or.w	(a0)+,d3
	movem.w	d0-d3,(a2)
	lea.l	160(a2),a2
	dbra	d7,.Loop_5
	move.w	#304,d0
	move.w	#184,d1
	jsr	Coord_conv
	lea.l	0(a6,d2.w),a2
	moveq.l	#15,d7
.Loop_6:
	movem.w	(a2),d0-d3
	move.w	(a1)+,d4
	not.w	d4
	and.w	d4,d0
	and.w	d4,d1
	and.w	d4,d2
	and.w	d4,d3
	or.w	(a0)+,d0
	or.w	(a0)+,d1
	or.w	(a0)+,d2
	or.w	(a0)+,d3
	movem.w	d0-d3,(a2)
	lea.l	160(a2),a2
	dbra	d7,.Loop_6
.Exit:
	movem.l	(sp)+,d0-d7/a0-a2
	rts	
; ---- Show_status_block (original source: LAYOUT/LAYOUT.ASM)
Show_status_block:
	movem.l	d0/d1/d5-d7/a0/a6,-(sp)
	movea.l	Off_screen,a6
	moveq.l	#0,d0
	moveq.l	#0,d1
	moveq.l	#1,d6
	moveq.l	#36,d7
	lea.l	Topblk_left,a0
	jsr	Blot_unmasked_block
	moveq.l	#5,d5
	lea.l	Topblk_mid,a0
.Loop_1:
	addi.w	#48,d0
	jsr	Blot_unmasked_block
	dbra	d5,.Loop_1
	addi.w	#16,d0
	lea.l	Topblk_right,a0
	jsr	Blot_unmasked_block
	moveq.l	#16,d0
	moveq.l	#5,d5
	moveq.l	#2,d6
	moveq.l	#1,d7
	lea.l	Topblk_top,a0
.Loop_2:
	jsr	Blot_unmasked_block
	addi.w	#48,d0
	dbra	d5,.Loop_2
	moveq.l	#16,d0
	moveq.l	#35,d1
	moveq.l	#5,d5
	lea.l	Topblk_bot,a0
.Loop_3:
	jsr	Blot_unmasked_block
	addi.w	#48,d0
	dbra	d5,.Loop_3
	moveq	#16,d0	; CHANGE: added
	moveq	#1,d1	; CHANGE: added
	moveq	#5,d5	; CHANGE: added
	moveq	#2,d6	; CHANGE: added
	moveq	#34,d7	; CHANGE: added
	lea.l	D_40aea,a0	; CHANGE: added
.c_06f32:
	jsr	Blot_unmasked_block	; CHANGE: added
	addi.w	#$30,d0	; CHANGE: added
	dbra	d5,.c_06f32	; CHANGE: added
	movem.l	(sp)+,d0/d1/d5-d7/a0/a6
	rts	
; ---- Show_control_icons (original source: LAYOUT/LAYOUT.ASM)
Show_control_icons:
	movem.l	d0-d7/a0-a2,-(sp)
	sf	Control_icon_flag
	bsr.w	Feedb_off
; CHANGE: removed "move.w #0,Draw_Cicon"
; CHANGE: removed "move.w #0,Erase_Cicon"
	lea.l	Control_icn,a1
	movea.l	Control_list_ptr,a2
	move.w	#145,d1
	move.w	#208,d2
	moveq.l	#3-1,d5
	moveq.l	#2,d6
	moveq.l	#16,d7
.Loop1:
	move.w	d2,d0
	moveq.l	#3-1,d4
.Loop2:
	moveq.l	#$7f,d3
	and.b	(a2),d3
	lsl.w	#8,d3
	lea.l	0(a1,d3.w),a0
	jsr	Blot_unmasked_block
	btst.b	#7,(a2)+
	beq.s	.Next
	lea.l	Chequered,a0
	jsr	Blot_masked_block
.Next:
	addi.w	#32,d0
	dbra	d4,.Loop2
	addi.w	#16,d1
	dbra	d5,.Loop1
.Continue:
	st	Control_icon_flag
	movem.l	(sp)+,d0-d7/a0-a2
	rts	
; ---- Do_control_icons (original source: LAYOUT/LAYOUT.ASM)
Do_control_icons:
	tst.b	Control_icon_flag
	beq.s	.Exit
	andi.w	#$00ff,d0
	movea.l	Control_list_ptr,a0
	move.b	-1(a0,d0.w),d1
	cmpi.b	#56,d1
	beq.s	.Exit
	btst	#7,d1
	bne.s	.Exit
	move.w	d0,Draw_Cicon
	jsr	My_vsync	; CHANGE: added
	lsl.w	#2,d0
	move.l	10-4(a0,d0.w),d0
	beq.s	.Exit
	movea.l	d0,a0
	jsr	(a0)
.Exit:
	rts	
; ---- Feedb_on (original source: LAYOUT/LAYOUT.ASM)
Feedb_on:
	movem.l	d0-d2/d6/d7/a0/a1/a6,-(sp)
	move.w	Draw_Cicon,d2
	move.w	d2,Erase_Cicon
	beq.s	.Exit
	lea.l	Icon_pos-4,a1
	add.w	d2,d2
	add.w	d2,d2
	adda.w	d2,a1
	move.w	(a1)+,d0
	move.w	(a1)+,d1
	movea.l	On_screen,a6
	move.l	a6,Feedback_screen
	moveq.l	#2,d6
	moveq.l	#16,d7
	lea.l	Feedback,a0
	jsr	Blot_masked_block
.Exit:
	movem.l	(sp)+,d0-d2/d6/d7/a0/a1/a6
	rts	
; ---- Feedb_off (original source: LAYOUT/LAYOUT.ASM)
Feedb_off:
	movem.l	d0-d3/d6/d7/a0/a1/a6,-(sp)
	move.w	Erase_Cicon,d2
	beq.s	.Exit
	move.w	d2,d3
	lea.l	Icon_pos-4,a1
	add.w	d2,d2
	add.w	d2,d2
	adda.w	d2,a1
	move.w	(a1)+,d0
	move.w	(a1)+,d1
	lea.l	Control_icn,a0
	movea.l	Control_list_ptr,a1
	moveq.l	#$7f,d2
	and.b	-1(a1,d3.w),d2
	lsl.w	#8,d2
	adda.w	d2,a0
	moveq.l	#2,d6
	moveq.l	#16,d7
	movea.l	Feedback_screen,a6
	jsr	Blot_unmasked_block
.Exit:
	movem.l	(sp)+,d0-d3/d6/d7/a0/a1/a6
	rts	
T_0707a:
	movem.l	d0/d7/a0/a6,-(a7)
	movea.l	Off_screen,a6
	bsr.w	Erase_text_window
	jsr	T_1d8b6
	movea.l	RText_ptr,a0
	move.w	Nr_of_chars,d0
	move.w	Lines_in_text,d7
	bra.b	T_070b2
T_070a2:
	jsr	IG_Print
	jsr	IG_Carriage_return
	lea.l	$1(a0,d0.w),a0
T_070b2:
	dbra	d7,T_070a2
	movem.l	(a7)+,d0/d7/a0/a6
	rts

	section	data

Erase_icon:
	dc.b	$47,$48,$49,$4c,$4e,$4d,$4a,$5b,$4b
D_1e3fb:
	dc.b	$4e,$4e,$4e,$4e,$4e,$4e,$4e,$4e,$4e,$4e,$4e,$4e,$00
Status_PA:
	dc.b	$00,$00,$00,$00,$01,$3f,$00,$22
D_1e410:
	dc.b	$00,$09,$00,$00
Icon_pos:
	dc.b	$00,$d0,$00,$91,$00,$f0,$00,$91,$01,$10,$00,$91,$00,$d0,$00,$a1
	dc.b	$00,$f0,$00,$a1,$01,$10,$00,$a1,$00,$d0,$00,$b1,$00,$f0,$00,$b1
	dc.b	$01,$10,$00,$b1
Temp_name:
	dc.b	$01,$00,$02,$00
D_1e43c:
	dc.b	$20,$20,$20,$20,$20,$00
Time_string:
	dc.b	$01,$0f,$02,$02,$20,$20,$3a,$20,$20,$00
AutoIcon_flag:
	dc.b	$ff,$00

	section	bss

Control_icon_flag:
	ds.b	2
Feedback_screen:
	ds.b	4
Draw_Cicon:
	ds.b	2
Erase_Cicon:
	ds.b	2
Control_list_ptr:
	ds.b	4
XActive_member:
	ds.b	2
Shadow_data:
	ds.b	84
Updated:
	ds.b	2
B_5ad8a:
	ds.b	12
B_5ad96:
	ds.b	2
Input_buffer:
	ds.b	50
