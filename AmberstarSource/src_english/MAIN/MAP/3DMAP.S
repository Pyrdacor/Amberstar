; MAIN/MAP/3DMAP.ASM (original module, merged with the disassembly of the shipped program)

; ---- Cut_from_3D_map (original source: MAIN/MAP/3DMAP.ASM)
Cut_from_3D_map:
	movem.l	d0-d4/d7/a0-a3,-(sp)
	move.w	Map_Xcoord,d0
	move.w	Map_Ycoord,d1
	subq.w	#1,d0
	subq.w	#1,d1
	move.w	Width_of_map,d4
	movea.l	Map_pointer,a0
	lea.l	Cut_table_3D,a1
	moveq.l	#24,d2
	mulu.w	View_direction,d2
	adda.w	d2,a1
	lea.l	Map_buffer_3D,a2
	lea.l	Hash_buffer_3D,a3
	moveq.l	#12-1,d7
.Loop:
	move.b	(a1)+,d2
	ext.w	d2
	add.w	d0,d2
	move.b	(a1)+,d3
	ext.w	d3
	add.w	d1,d3
	muls.w	d4,d3
	add.w	d2,d3
	move.w	d3,(a3)+
	move.b	0(a0,d3.w),(a2)+
	dbra	d7,.Loop
	movem.l	(sp)+,d0-d4/d7/a0-a3
	rts	
; ---- M3_Dark_check (original source: MAIN/MAP/3DMAP.ASM)
M3_Dark_check:
	movem.l	d0/a0,-(sp)
	movea.l	Current_active_char_data,a0
	btst	#4,Mind_conditions(a0)
	sne	Stygian
	bne.s	.Exit
	movea.l	Mapd_ptr,a0
	move.b	Map_special(a0),d0
	btst	#2,d0
	beq.s	.Exit
	cmpi.w	#6,Travel_mode
	beq.s	.Exit
	tst.w	Spell_1_duration
	seq	Stygian
.Exit:
	movem.l	(sp)+,d0/a0
	rts	
Build_3D_map:
	movem.l	d0-d2/d6-d7/a0-a6,-(a7)
	bsr.w	M3_Dark_check
	tst.b	Stygian
	beq.b	T_030be
	move.w	#$20,d0
	move.w	#$31,d1
	move.w	d0,d2
	move.w	d1,d3
	addi.w	#$8f,d2
	addi.w	#$8f,d3
	moveq	#0,d6
	movea.l	Off_screen,a6
	jsr	Draw_box
	bra.w	T_031ea
T_030be:
	lea.l	Map_buffer_3D,a1
	movea.l	INB_ptr,a2
	lea.l	Labblock_ptrs,a3
	movea.l	Iconstats_ptr,a4
	lea.l	Persons_buf_3D,a5
	movea.l	Off_screen,a6
	moveq	#1,d7
T_030e4:
	moveq	#0,d0
	move.b	-$1(a1,d7.w),d0
	bsr.w	Get_ptr_to_labblock
	cmpi.b	#$1,$1(a0)
	bne.b	T_030fc
	bsr.w	Display_element
	bra.b	T_03142
T_030fc:
	cmpi.b	#$2,$1(a0)
	bne.b	T_0313e
	movem.l	d0/a0,-(a7)
	movea.l	OUH_ptr,a0
	move.b	-$1(a0,d0.w),d0
	bsr.w	Get_ptr_to_labblock
	bsr.w	Display_element
	movem.l	(a7)+,d0/a0
	bsr.w	Display_element
	move.w	d7,d6
	move.b	T_03130+1(pc,d7.w),d7
	beq.b	T_0312e
	bsr.w	Display_element
T_0312e:
	move.w	d6,d7
T_03130:
	bra.b	T_03142
	dc.b	$0c,$0d,$00,$0e,$0f,$00,$10,$11,$00,$00,$00,$00
T_0313e:
	bsr.w	Display_object
T_03142:
	moveq	#0,d0
	move.b	-$1(a5,d7.w),d0
	beq.b	T_03196
	bsr.w	Get_ptr_to_labblock
	cmpi.b	#$1,$1(a0)
	bne.b	T_0315c
	bsr.w	Display_element
	bra.b	T_03196
T_0315c:
	cmpi.b	#$2,$1(a0)
	bne.b	T_03192
	movem.l	d0/a0,-(a7)
	movea.l	OUH_ptr,a0
	move.b	-$1(a0,d0.w),d0
	bsr.w	Get_ptr_to_labblock
	bsr.w	Display_element
	movem.l	(a7)+,d0/a0
	bsr.w	Display_element
	move.w	d7,d6
	move.b	T_03130+1(pc,d7.w),d7
	beq.b	T_0318e
	bsr.w	Display_element
T_0318e:
	move.w	d6,d7
	bra.b	T_03196
T_03192:
	bsr.w	Display_object
T_03196:
	addq.w	#$1,d7
	cmpi.w	#$c,d7
	bmi.w	T_030e4
	moveq	#0,d0
	move.b	$b(a1),d0
	bsr.w	Get_ptr_to_labblock
	cmpi.b	#$3,$1(a0)
	bne.b	T_031c4
	cmpi.b	#$1,$3(a0)
	bne.b	T_031c0
	bsr.w	Display_object
	bra.b	T_031c4
T_031c0:
	bsr.w	Display_special_object
T_031c4:
	moveq	#0,d0
	move.b	$b(a5),d0
	beq.b	T_031ea
	bsr.w	Get_ptr_to_labblock
	cmpi.b	#$3,$1(a0)
	bne.b	T_031ea
	cmpi.b	#$1,$3(a0)
	bne.b	T_031e6
	bsr.w	Display_object
	bra.b	T_031ea
T_031e6:
	bsr.w	Display_special_object
T_031ea:
	tst.b	Bumped
	beq.b	T_03222
	move.w	#$31,d1
	jsr	Random
	andi.w	#$3f,d0
	add.w	d0,d1
	move.w	#$70,d0
	moveq	#2,d6
	moveq	#32,d7
	lea.l	D_3d360,a0
	movea.l	Off_screen,a6
	jsr	Blot_masked_block
	sf.b	Bumped
T_03222:
	bsr.w	Update_animation
	bsr.w	Update_status_block
	bsr.w	Show_special_items
	bsr.w	Show_spells
	movem.l	(a7)+,d0-d2/d6-d7/a0-a6
	rts
; ---- Get_ptr_to_labblock (original source: MAIN/MAP/3DMAP.ASM)
Get_ptr_to_labblock:
	move.l	d1,-(sp)
	moveq.l	#0,d1
	move.b	-1(a2,d0.w),d1
	add.w	d1,d1
	add.w	d1,d1
	movea.l	-4(a3,d1.w),a0
	move.l	(sp)+,d1
	rts	
; ---- Display_element (original source: MAIN/MAP/3DMAP.ASM)
Display_element:
	movem.l	d0-d2/d7/a0/a1,-(sp)
	moveq.l	#0,d1
	move.b	Block_animation(a0),d1
	bsr.w	Get_current_anim_frame
	lea.l	Block_elements(a0),a1
	moveq.l	#0,d0
	move.b	Block_number(a0),d0
	subq.w	#1,d0
	subq.w	#1,d1
	bmi.s	.First_frame
.Loop_1:
	move.w	d0,d2
.Loop_2:
	adda.l	(a1)+,a1
	dbra	d2,.Loop_2
	dbra	d1,.Loop_1
.First_frame:
	move.w	d7,d0
	subq.w	#2,d0
	bmi.s	.First_size
.Loop_3:
	adda.l	(a1)+,a1
	dbra	d0,.Loop_3
.First_size:
	add.w	d7,d7
	move.w	Block_X_cor-2(a0,d7.w),d0
	move.w	Block_Y_cor-2(a0,d7.w),d1
	lea.l	4(a1),a0
	bsr.w	Blit
	movem.l	(sp)+,d0-d2/d7/a0/a1
	rts	
; ---- OD_Table (original source: MAIN/MAP/3DMAP.ASM)
OD_Table:
	dc.b	1,1,1,2,2,2,3,3,3,0,0,4
	dc.b	0,8,4,0,8,4,0,8,4,0,8,4
	even	
; ---- Display_object (original source: MAIN/MAP/3DMAP.ASM)
Display_object:
	movem.l	d0-d2/d6/d7/a0/a1,-(sp)
	moveq.l	#0,d1
	move.b	Block_animation(a0),d1
	bsr.w	Get_current_anim_frame
	move.b	OD_Table+11(pc,d7.w),d6
	ext.w	d6
	move.b	OD_Table-1(pc,d7.w),d7
	beq.s	.Exit
	lea.l	Block_elements+4(a0),a1
	moveq.l	#0,d0
	move.b	Block_number(a0),d0
	subq.w	#1,d0
	subq.w	#1,d1
	bmi.s	.First_frame
.Loop_1:
	move.w	d0,d2
.Loop_2:
	adda.l	(a1)+,a1
	dbra	d2,.Loop_2
	dbra	d1,.Loop_1
.First_frame:
	move.w	d7,d0
	subq.w	#2,d0
	bmi.s	.First_size
.Loop_3:
	adda.l	(a1)+,a1
	dbra	d0,.Loop_3
.First_size:
	add.w	d7,d7
	move.w	Block_X_cor-2(a0,d7.w),d0
	move.w	Block_Y_cor-2(a0,d7.w),d1
	lea.l	4(a1),a0
	movea.l	.OD_ptrs(pc,d6.w),a1
	jsr	(a1)
.Exit:
	movem.l	(sp)+,d0-d2/d6/d7/a0/a1
	rts	
.OD_ptrs:
	dc.l	Blit_left,Blit,Blit_right
; ---- Display_special_object (original source: MAIN/MAP/3DMAP.ASM)
Display_special_object:
	movem.l	d0-d2/d7/a0/a1,-(sp)
	move.l	a0,-(sp)
	move.w	d0,-(sp)
	lea.l	Block_elements+4(a0),a1
	adda.l	(a1)+,a1
	adda.l	(a1)+,a1
	adda.l	(a1)+,a1
	move.w	Block_X_cor+6(a0),d0
	move.w	Block_Y_cor+6(a0),d1
	lea.l	4(a1),a0
	bsr.w	Blit
	move.w	(sp)+,d0
	movea.l	(sp)+,a0
	moveq.l	#0,d1
	move.b	Block_animation(a0),d1
	subq.w	#1,d1
	moveq.l	#12,d7
	bsr.w	Get_current_anim_frame
	addq.w	#1,d1
	lea.l	Block_elements+4(a0),a1
	moveq.l	#0,d0
	move.b	Block_number(a0),d0
	subq.w	#1,d0
	subq.w	#1,d1
	bmi.s	.First_frame
.Loop_1:
	move.w	d0,d2
.Loop_2:
	adda.l	(a1)+,a1
	dbra	d2,.Loop_2
	dbra	d1,.Loop_1
.First_frame:
	adda.l	(a1)+,a1
	adda.l	(a1)+,a1
	adda.l	(a1)+,a1
	move.w	Block_elements(a0),d0
	move.w	Block_elements+2(a0),d1
	lea.l	4(a1),a0
	bsr.w	Blit
	movem.l	(sp)+,d0-d2/d7/a0/a1
	rts	
Get_current_anim_frame:
	movem.l	d0/a0-a1,-(a7)
	subq.w	#$1,d1
	beq.b	T_033e4
	add.w	d0,d0
	add.w	d0,d0
	move.l	-$4(a4,d0.w),d0
	lea.l	Circle_anim,a1
	btst	#$0,d0
	beq.b	T_033aa
	lea.l	Wave_anim,a1
T_033aa:
	add.w	d1,d1
	add.w	d1,d1
	adda.w	d1,a1
	btst	#$4,d0
	beq.b	T_033e0
	tst.b	B_57914
	bne.b	T_033e0
	move.b	$1(a1),d0
	ext.w	d0
	lea.l	B_5793a,a0
	adda.w	d7,a0
	adda.w	d7,a0
	add.w	(a0),d0
	andi.w	#$f,d0
	move.w	$2(a1),d1
	btst	d0,d1
	bne.b	T_033e0
	moveq	#0,d1
	bra.b	T_033e4
T_033e0:
	move.b	(a1),d1
	ext.w	d1
T_033e4:
	movem.l	(a7)+,d0/a0-a1
	rts
End_masks:
	dc.b	$ff,$ff,$80,$00,$c0,$00,$e0,$00,$f0,$00,$f8,$00,$fc,$00,$fe,$00
	dc.b	$ff,$00,$ff,$80,$ff,$c0,$ff,$e0,$ff,$f0,$ff,$f8,$ff,$fc,$ff,$fe
; ---- Blit (original source: MAIN/MAP/3DMAP.ASM)
Blit:
	movem.l	d0-d7/a0-a4,-(sp)
	link	a4,#-Local_size
	addi.w	#Topleft_X,d0
	addi.w	#Topleft_Y,d1
	move.w	(a0)+,d6
	move.w	(a0)+,d7
	cmpi.w	#4,(a0)+
	bne.w	.Exit
	addq.w	#1,d6
	addq.w	#1,d7
	lea.l	End_masks,a1
	moveq.l	#$f,d2
	and.w	d6,d2
	add.w	d2,d2
	move.w	0(a1,d2.w),-End_mask(a4)
	moveq.l	#15,d2
	add.w	d6,d2
	lsr.w	#4,d2
	subq.w	#1,d2
	move.w	d2,-Nr_columns(a4)
	subq.w	#1,d7
	jsr	Coord_convert
	lea.l	0(a6,d2.w),a1
	andi.w	#$f,d0
.Loop_Y:
	movea.l	a1,a3
	move.w	-Nr_columns(a4),d6
.Loop_X:
	moveq.l	#0,d1
	moveq.l	#0,d2
	moveq.l	#0,d3
	moveq.l	#0,d4
	move.w	(a0)+,d1
	move.w	(a0)+,d2
	move.w	(a0)+,d3
	move.w	(a0)+,d4
	tst.w	d6
	bne.s	.Not_last
	and.w	-End_mask(a4),d1
	and.w	-End_mask(a4),d2
	and.w	-End_mask(a4),d3
	and.w	-End_mask(a4),d4
.Not_last:
	ror.l	d0,d1
	ror.l	d0,d2
	ror.l	d0,d3
	ror.l	d0,d4
	move.l	d1,d5
	or.l	d2,d5
	or.l	d3,d5
	or.l	d4,d5
	not.l	d5
	and.w	d5,(a3)
	or.w	d1,(a3)+
	and.w	d5,(a3)
	or.w	d2,(a3)+
	and.w	d5,(a3)
	or.w	d3,(a3)+
	and.w	d5,(a3)
	or.w	d4,(a3)+
	swap.w	d1
	swap.w	d2
	swap.w	d3
	swap.w	d4
	swap.w	d5
	and.w	d5,(a3)
	or.w	d1,(a3)+
	and.w	d5,(a3)
	or.w	d2,(a3)+
	and.w	d5,(a3)
	or.w	d3,(a3)+
	and.w	d5,(a3)
	or.w	d4,(a3)+
	subq.l	#8,a3
	dbra	d6,.Loop_X
	lea.l	160(a1),a1
	dbra	d7,.Loop_Y
.Exit:
	unlk	a4
	movem.l	(sp)+,d0-d7/a0-a4
	rts	
; ---- Blit_left (original source: MAIN/MAP/3DMAP.ASM)
Blit_left:
	movem.l	d0-d7/a0-a4,-(sp)
	link	a4,#-Local_size
	addi.w	#Topleft_Y,d1
	move.w	(a0)+,d6
	move.w	(a0)+,d7
	cmpi.w	#4,(a0)+
	bne.w	.Exit
	addq.w	#1,d6
	addq.w	#1,d7
	moveq.l	#15,d2
	add.w	d6,d2
	andi.w	#$fff0,d2
	lsr.w	#1,d2
	move.w	d2,-Line_size(a4)
	lea.l	End_masks,a1
	moveq.l	#$f,d2
	and.w	d6,d2
	add.w	d2,d2
	move.w	0(a1,d2.w),-End_mask(a4)
	move.w	d6,d5
	lsr.w	#1,d5
	move.w	d6,d4
	sub.w	d5,d4
	move.w	d4,d0
	neg.w	d0
	andi.w	#$f,d0
	move.w	d0,-(sp)
	moveq.l	#-1,d2
	add.w	d4,d2
	andi.w	#$fff0,d2
	lsr.w	#1,d2
	adda.w	d2,a0
	moveq.l	#$f,d2
	and.w	d6,d2
	move.w	d5,d3
	sub.w	d2,d3
	addi.w	#15,d3
	lsr.w	#4,d3
	tst.w	d2
	bne.s	.Not_zero1
	subq.w	#1,d3
.Not_zero1:
	move.w	d3,-Nr_columns(a4)
	subq.w	#1,d7
	move.w	#Topleft_X,d0
	jsr	Coord_convert
	lea.l	0(a6,d2.w),a1
	move.w	(sp)+,d0
	bne.s	.Not_zero2
	addq.w	#1,-Nr_columns(a4)
.Not_zero2:
.Loop_Y:
	movea.l	a0,a2
	movea.l	a1,a3
	move.w	-Nr_columns(a4),d6
	moveq.l	#0,d1
	moveq.l	#0,d2
	moveq.l	#0,d3
	moveq.l	#0,d4
	move.w	(a2)+,d1
	move.w	(a2)+,d2
	move.w	(a2)+,d3
	move.w	(a2)+,d4
	tst.w	d6
	bne.s	.Not_last1
	and.w	-End_mask(a4),d1
	and.w	-End_mask(a4),d2
	and.w	-End_mask(a4),d3
	and.w	-End_mask(a4),d4
.Not_last1:
	ror.l	d0,d1
	ror.l	d0,d2
	ror.l	d0,d3
	ror.l	d0,d4
	move.l	d1,d5
	or.l	d2,d5
	or.l	d3,d5
	or.l	d4,d5
	not.l	d5
	swap.w	d1
	swap.w	d2
	swap.w	d3
	swap.w	d4
	swap.w	d5
	and.w	d5,(a3)
	or.w	d1,(a3)+
	and.w	d5,(a3)
	or.w	d2,(a3)+
	and.w	d5,(a3)
	or.w	d3,(a3)+
	and.w	d5,(a3)
	or.w	d4,(a3)+
	subq.l	#8,a3
	bra.s	.Entry
.Loop_X:
	moveq.l	#0,d1
	moveq.l	#0,d2
	moveq.l	#0,d3
	moveq.l	#0,d4
	move.w	(a2)+,d1
	move.w	(a2)+,d2
	move.w	(a2)+,d3
	move.w	(a2)+,d4
	tst.w	d6
	bne.s	.Not_last2
	and.w	-End_mask(a4),d1
	and.w	-End_mask(a4),d2
	and.w	-End_mask(a4),d3
	and.w	-End_mask(a4),d4
.Not_last2:
	ror.l	d0,d1
	ror.l	d0,d2
	ror.l	d0,d3
	ror.l	d0,d4
	move.l	d1,d5
	or.l	d2,d5
	or.l	d3,d5
	or.l	d4,d5
	not.l	d5
	and.w	d5,(a3)
	or.w	d1,(a3)+
	and.w	d5,(a3)
	or.w	d2,(a3)+
	and.w	d5,(a3)
	or.w	d3,(a3)+
	and.w	d5,(a3)
	or.w	d4,(a3)+
	swap.w	d1
	swap.w	d2
	swap.w	d3
	swap.w	d4
	swap.w	d5
	and.w	d5,(a3)
	or.w	d1,(a3)+
	and.w	d5,(a3)
	or.w	d2,(a3)+
	and.w	d5,(a3)
	or.w	d3,(a3)+
	and.w	d5,(a3)
	or.w	d4,(a3)+
	subq.l	#8,a3
.Entry:
	dbra	d6,.Loop_X
	adda.w	-Line_size(a4),a0
	lea.l	160(a1),a1
	dbra	d7,.Loop_Y
.Exit:
	unlk	a4
	movem.l	(sp)+,d0-d7/a0-a4
	rts	
; ---- Blit_right (original source: MAIN/MAP/3DMAP.ASM)
Blit_right:
	movem.l	d0-d7/a0-a4,-(sp)
	link	a4,#-Local_size
	addi.w	#Topleft_Y,d1
	move.w	(a0)+,d6
	move.w	(a0)+,d7
	cmpi.w	#4,(a0)+
	bne.w	.Exit
	addq.w	#1,d6
	addq.w	#1,d7
	moveq.l	#15,d2
	add.w	d6,d2
	andi.w	#$fff0,d2
	lsr.w	#1,d2
	move.w	d2,-Line_size(a4)
	move.w	d6,d5
	lsr.w	#1,d5
	move.w	#Topleft_X+144,d0
	sub.w	d5,d0
	lea.l	End_masks,a1
	moveq.l	#$f,d2
	and.w	d5,d2
	add.w	d2,d2
	move.w	0(a1,d2.w),-End_mask(a4)
	moveq.l	#15,d2
	add.w	d5,d2
	lsr.w	#4,d2
	subq.w	#1,d2
	move.w	d2,-Nr_columns(a4)
	subq.w	#1,d7
	jsr	Coord_convert
	lea.l	0(a6,d2.w),a1
	andi.w	#$f,d0
.Loop_Y:
	movea.l	a0,a2
	movea.l	a1,a3
	move.w	-Nr_columns(a4),d6
.Loop_X:
	moveq.l	#0,d1
	moveq.l	#0,d2
	moveq.l	#0,d3
	moveq.l	#0,d4
	move.w	(a2)+,d1
	move.w	(a2)+,d2
	move.w	(a2)+,d3
	move.w	(a2)+,d4
	tst.w	d6
	bne.s	.Not_last
	and.w	-End_mask(a4),d1
	and.w	-End_mask(a4),d2
	and.w	-End_mask(a4),d3
	and.w	-End_mask(a4),d4
.Not_last:
	ror.l	d0,d1
	ror.l	d0,d2
	ror.l	d0,d3
	ror.l	d0,d4
	move.l	d1,d5
	or.l	d2,d5
	or.l	d3,d5
	or.l	d4,d5
	not.l	d5
	and.w	d5,(a3)
	or.w	d1,(a3)+
	and.w	d5,(a3)
	or.w	d2,(a3)+
	and.w	d5,(a3)
	or.w	d3,(a3)+
	and.w	d5,(a3)
	or.w	d4,(a3)+
	swap.w	d1
	swap.w	d2
	swap.w	d3
	swap.w	d4
	swap.w	d5
	and.w	d5,(a3)
	or.w	d1,(a3)+
	and.w	d5,(a3)
	or.w	d2,(a3)+
	and.w	d5,(a3)
	or.w	d3,(a3)+
	and.w	d5,(a3)
	or.w	d4,(a3)+
	subq.l	#8,a3
	dbra	d6,.Loop_X
	adda.w	-Line_size(a4),a0
	lea.l	160(a1),a1
	dbra	d7,.Loop_Y
.Exit:
	unlk	a4
	movem.l	(sp)+,d0-d7/a0-a4
	rts	
D3_turnleft:
	btst	#$1,Mouse_button_state
	bne.b	D3_turnleft
	move.l	d0,-(a7)
	move.w	View_direction,d0
	subq.w	#$1,d0
	andi.w	#$3,d0
	move.w	d0,View_direction
	move.l	(a7)+,d0
	rts
T_0373a:
	btst	#$1,Mouse_button_state
	bne.b	T_0373a
; ---- D3_turnright (original source: MAIN/MAP/3DMAP.ASM)
D3_turnright:
	move.l	d0,-(sp)
	move.w	View_direction,d0
	addq.w	#1,d0
	andi.w	#3,d0
	move.w	d0,View_direction
	move.l	(sp)+,d0
	rts	
; ---- D3_fullturnleft (original source: MAIN/MAP/3DMAP.ASM)
D3_fullturnleft:
	move.l	a0,-(sp)
	bsr.w	D3_turnleft
	movea.l	Module_sp,a0
	movea.l	(a0),a0
	jsr	(a0)
	jsr	Switch_screen
	bsr.w	D3_turnleft
	movea.l	(sp)+,a0
	rts	
; ---- D3_fullturnright (original source: MAIN/MAP/3DMAP.ASM)
D3_fullturnright:
	move.l	a0,-(sp)
	bsr.w	T_0373a	; CHANGE: was "jsr D3_turnright"
	movea.l	Module_sp,a0
	movea.l	(a0),a0
	jsr	(a0)
	jsr	Switch_screen
	bsr.w	T_0373a	; CHANGE: was "jsr D3_turnright"
	movea.l	(sp)+,a0
	rts	
; ---- D3_forward (original source: MAIN/MAP/3DMAP.ASM)
D3_right:
D3_left:
D3_back:
D3_forward:
	bsr.w	Before_move
	movem.l	d0/d1,-(sp)
	move.w	View_direction,d1
	add.w	d1,d1
	move.b	.Forward(pc,d1.w),d0
	ext.w	d0
	add.w	Map_Xcoord,d0
	move.b	.Forward+1(pc,d1.w),d1
	ext.w	d1
	add.w	Map_Ycoord,d1
	bsr.w	Movement_check_3D
	sne	Bumped
	bne.s	.Exit
	move.w	d0,Map_Xcoord
	move.w	d1,Map_Ycoord
	jsr	Update_automap
	bsr.w	After_move
.Exit:
	movem.l	(sp)+,d0/d1
	rts	
.Forward:
	dc.b	0,-1,1,0,0,1,-1,0
T_037f0:
	bsr.w	Before_move
	movem.l	d0-d1,-(a7)
	move.w	View_direction,d1
	add.w	d1,d1
	move.b	T_03840(pc,d1.w),d0
	ext.w	d0
	add.w	Map_Xcoord,d0
	move.b	T_03841(pc,d1.w),d1
	ext.w	d1
	add.w	Map_Ycoord,d1
	bsr.w	Movement_check_3D
	sne.b	Bumped
	bne.b	T_0383a
	move.w	d0,Map_Xcoord
	move.w	d1,Map_Ycoord
	jsr	Update_automap
	bsr.w	After_move
T_0383a:
	movem.l	(a7)+,d0-d1
	rts
T_03840:
	dc.b	$ff
T_03841:
	dc.b	$00,$00,$ff,$01,$00,$00,$01
T_03848:
	bsr.w	Before_move
	movem.l	d0-d1,-(a7)
	move.w	View_direction,d1
	add.w	d1,d1
	move.b	T_03898(pc,d1.w),d0
	ext.w	d0
	add.w	Map_Xcoord,d0
	move.b	T_03899(pc,d1.w),d1
	ext.w	d1
	add.w	Map_Ycoord,d1
	bsr.w	Movement_check_3D
	sne.b	Bumped
	bne.b	T_03892
	move.w	d0,Map_Xcoord
	move.w	d1,Map_Ycoord
	jsr	Update_automap
	bsr.w	After_move
T_03892:
	movem.l	(a7)+,d0-d1
	rts
T_03898:
	dc.b	$01
T_03899:
	dc.b	$00,$00,$01,$ff,$00,$00,$ff
T_038a0:
	bsr.w	Before_move
	movem.l	d0-d1,-(a7)
	move.w	View_direction,d1
	add.w	d1,d1
	move.b	T_038f0(pc,d1.w),d0
	ext.w	d0
	add.w	Map_Xcoord,d0
	move.b	T_038f1(pc,d1.w),d1
	ext.w	d1
	add.w	Map_Ycoord,d1
	bsr.w	Movement_check_3D
	sne.b	Bumped
	bne.b	T_038ea
	move.w	d0,Map_Xcoord
	move.w	d1,Map_Ycoord
	jsr	Update_automap
	bsr.w	After_move
T_038ea:
	movem.l	(a7)+,d0-d1
	rts
T_038f0:
	dc.b	$00
T_038f1:
	dc.b	$01,$ff,$00,$00,$ff,$01,$00
; ---- Get_3D_icon_status (original source: MAIN/MAP/3DMAP.ASM)
Get_3D_icon_status:
	movem.l	d1/a0/a1,-(sp)
	movea.l	Iconstats_ptr,a0
	movea.l	Map_pointer,a1
	subq.w	#1,d1
	mulu.w	Width_of_map,d1
	add.w	d0,d1
	moveq.l	#0,d0
	move.b	-1(a1,d1.w),d0
	beq.s	.Exit
	subq.w	#1,d0
	add.w	d0,d0
	add.w	d0,d0
	move.l	0(a0,d0.w),d0
.Exit:
	movem.l	(sp)+,d1/a0/a1
	rts	
; ---- Movement_check_3D (original source: MAIN/MAP/3DMAP.ASM)
Movement_check_3D:
	movem.l	d0/d6/d7/a0,-(sp)
	cmpi.w	#$6,d0	; CHANGE: added
	bmi.b	.c_03952	; CHANGE: added
	cmpi.w	#$6,d1	; CHANGE: added
	bmi.b	.c_03952	; CHANGE: added
	move.w	Width_of_map,d6	; CHANGE: added
	subq.w	#$5,d6	; CHANGE: added
	cmp.w	d0,d6	; CHANGE: added
	bmi.b	.c_03952	; CHANGE: added
	move.w	Height_of_map,d6	; CHANGE: added
	subq.w	#$5,d6	; CHANGE: added
	cmp.w	d1,d6	; CHANGE: added
	bpl.b	.c_03956	; CHANGE: added
.c_03952:
	moveq	#-1,d0	; CHANGE: added
	bra.b	.Exit	; CHANGE: added
.c_03956:
	move.w	d0,d6
	cmpi.w	#6,Travel_mode
	bne.s	.Normal
	moveq.l	#0,d0
	bra.s	.Exit
.Normal:
	bsr.w	Get_3D_icon_status
	btst.l	#7,d0
	bne.s	.Exit
	move.w	d6,d0
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
	move.b	VChar_icon(a0),d0
	beq.s	.Exit
	movea.l	Iconstats_ptr,a0
	subq.w	#1,d0
	add.w	d0,d0
	add.w	d0,d0
	move.l	0(a0,d0.w),d0
	btst.l	#7,d0
	bra.s	.Exit
.Next:
	lea.l	VData_length(a0),a0
	addq.w	#1,d7
	cmpi.w	#Max_chars,d7
	bmi.s	.Loop
	moveq.l	#0,d0
.Exit:
	movem.l	(sp)+,d0/d6/d7/a0
	rts	
; ---- Blot_mirrored_unmasked_block (original source: MAIN/MAP/3DMAP.ASM)
Blot_mirrored_unmasked_block:
	movem.l	d2-d7/a0-a2,-(sp)
	jsr	Coord_convert
	move.w	d6,d3
	lsl.w	#3,d3
	add.w	d3,d2
	lea.l	-8(a6,d2.w),a1
	moveq.l	#0,d2
	subq.w	#1,d7
	subq.w	#1,d6
.Loop_1:
	movea.l	a1,a2
	move.w	d6,d5
.Loop_2:
	move.b	(a0)+,d2
	move.b	.Reverse_tab(pc,d2.w),1(a2)
	move.b	(a0)+,d2
	move.b	.Reverse_tab(pc,d2.w),0(a2)
	move.b	(a0)+,d2
	move.b	.Reverse_tab(pc,d2.w),3(a2)
	move.b	(a0)+,d2
	move.b	.Reverse_tab(pc,d2.w),2(a2)
	move.b	(a0)+,d2
	move.b	.Reverse_tab(pc,d2.w),5(a2)
	move.b	(a0)+,d2
	move.b	.Reverse_tab(pc,d2.w),4(a2)
	move.b	(a0)+,d2
	move.b	.Reverse_tab(pc,d2.w),7(a2)
	move.b	(a0)+,d2
	move.b	.Reverse_tab(pc,d2.w),6(a2)
	subq.l	#8,a2
	dbra	d5,.Loop_2
	lea.l	160(a1),a1
	dbra	d7,.Loop_1
	movem.l	(sp)+,d2-d7/a0-a2
	rts	
.Reverse_tab:
	dc.b	0,128,64,192,32,160,96,224,16,144,80,208,48,176,112,240,8,136,72,200,40,168,104,232,24,152,88,216
	dc.b	56,184,120,248,4,132,68,196,36,164,100,228,20,148,84,212,52,180,116,244,12,140,76,204,44,172,108
	dc.b	236,28,156,92,220,60,188,124,252,2,130,66,194,34,162,98,226,18,146,82,210,50,178,114,242,10,138
	dc.b	74,202,42,170,106,234,26,154,90,218,58,186,122,250,6,134,70,198,38,166,102,230,22,150,86,214,54
	dc.b	182,118,246,14,142,78,206,46,174,110,238,30,158,94,222,62,190,126,254,1,129,65,193,33,161,97,225
	dc.b	17,145,81,209,49,177,113,241,9,137,73,201,41,169,105,233,25,153,89,217,57,185,121,249,5,133,69,197
	dc.b	37,165,101,229,21,149,85,213,53,181,117,245,13,141,77,205,45,173,109,237,29,157,93,221,61,189,125
	dc.b	253,3,131,67,195,35,163,99,227,19,147,83,211,51,179,115,243,11,139,75,203,43,171,107,235,27,155
	dc.b	91,219,59,187,123,251,7,135,71,199,39,167,103,231,23,151,87,215,55,183,119,247,15,143,79,207,47
	dc.b	175,111,239,31,159,95,223,63,191,127,255
	even	
Prepare_3D_map:
	movem.l	d0-d1/d7/a0-a3,-(a7)
	lea.l	D_2f1ba,a0
	move.w	$2(a5),d0
	jsr	Load_subfile
	movea.l	a0,a3
	lea.l	$2(a0),a2
	lea.l	Labblock_ptrs,a1
	moveq	#0,d7
	move.b	(a2)+,d7
	bne.b	T_03b6c
	lea.l	D_2edb3,a1
	jsr	DI_Error
	bra.w	T_03c5e
T_03b6c:
	subq.w	#$1,d7
	move.w	d7,Nr_labblocks
T_03b74:
	lea.l	D_2f1c8,a0
	moveq	#0,d0
	move.b	(a2)+,d0
	jsr	Load_subfile
	move.l	a0,(a1)+
	dbra	d7,T_03b74
	addq.l	#$3,a2
	lea.l	D_2f1d6,a1
	movea.l	a1,a0
	move.b	(a2)+,d0
	jsr	Load_subfile
	move.l	a0,Ceiling_ptr
	movea.l	a1,a0
	move.b	(a2)+,d0
	jsr	Load_subfile
	move.l	a0,Floor_ptr
	addq.l	#$1,a2
	lea.l	D_2f1e4,a0
	moveq	#0,d0
	move.b	(a2)+,d0
	jsr	Load_subfile
	move.l	a0,Colpall_ptrs
	movea.l	a3,a0
	jsr	Free_memory
	bsr.w	Init_maptexts
	lea.l	$ac5(a5),a0
	moveq	#0,d7
	move.b	(a0)+,d7
	move.l	a0,Iconstats_ptr
	adda.w	d7,a0
	adda.w	d7,a0
	adda.w	d7,a0
	adda.w	d7,a0
	move.l	a0,INB_ptr
	adda.w	d7,a0
	move.l	a0,OUH_ptr
	adda.w	d7,a0
	move.l	a0,Lab_IC_ptr
	adda.w	d7,a0
	move.l	a0,Map_pointer
	moveq	#0,d0
	move.b	$7(a5),d0
	move.w	d0,Width_of_map
	moveq	#0,d1
	move.b	$8(a5),d1
	move.w	d1,Height_of_map
	mulu.w	d0,d1
	move.w	d1,Size_of_map
	move.b	#$1,Anim_speed
	move.b	#$1,Anim_count
	move.w	#$c,Anim_bias
	move.w	Map_nr,d7
	movea.l	Mapd_ptr,a0
	bsr.w	Make_modifications
	jsr	Init_automap
	jsr	Update_automap
T_03c5e:
	movem.l	(a7)+,d0-d1/d7/a0-a3
	rts
