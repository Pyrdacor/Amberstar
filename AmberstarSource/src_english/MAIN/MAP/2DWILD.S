; MAIN/MAP/2DWILD.ASM (original module, merged with the disassembly of the shipped program)

	section	text


; ---- W2_ModInit (original source: MAIN/MAP/2DWILD.ASM) - the shipped program differs, its code follows, not assembled:
;W2_ModInit:
;             Pop       MA
;             move.l    a5,Mapd_ptr          ; Store pointer to map data
;             jsr       M2_time_evaluate     ; Set light parameters
;             move.w    New_radius,Current_radius
;; ------------- Load data --------------------------------------------
;             move.w    Iconfile_nr(a5),d0   ; Icon data
;             lea.l     Icondata_filename,a0
;             jsr       Load_subfile
;             move.l    a0,Icondata_ptr
;             jsr       Init_maptexts
;; ------------- Calculate variables ----------------------------------
;             lea.l     Iconstats(a0),a0     ; Get & store pointer
;             move.l    a0,Iconstats_ptr     ;  to icon status array
;             moveq.l   #0,d0                ; Get & store map's width
;             move.b    Map_width(a5),d0
;             move.w    d0,Width_of_map
;             moveq.l   #0,d1                ; Get & store map's height
;             move.b    Map_height(a5),d1
;             move.w    d1,Height_of_map
;             mulu.w    d0,d1                ; Calculate & store map's size
;             move.w    d1,Size_of_map
;             lea.l     Map_data(a5),a0      ; Get & store pointer
;             move.l    a0,Map_pointer       ;  to actual map data
;             move.b    #W2_animspeed,Anim_speed   ; Set animation speed
;             move.b    #W2_animspeed,Anim_count
;             move.w    #6,Anim_bias
;             move.w    #Def_mapbuf_X,Mapbuf_X     ; Set window coordinates
;             move.w    #Def_mapbuf_Y,Mapbuf_Y
;             move.w    Map_nr,d7            ; Modify map
;             movea.l   Mapd_ptr,a0
;             jsr       Make_modifications
;; ------------- Wilderness initialization ----------------------------
;             moveq.l   #0,d2                ; Get current map number
;             move.w    Map_nr,d2
;             subq.l    #1,d2                ; Subtract number of first map
;             divu.w    #World_width,d2      ; Calculate world coordinates
;             move.w    d2,World_Y           ; Store
;             swap.w    d2
;             move.w    d2,World_X
;             move.w    Map_Xcoord,d0        ; Load party coordinates
;             move.w    Map_Ycoord,d1
;             moveq.l   #0,d2                ; Calculate quad-index
;             cmpi.w    #Submap_width/2+1,d0 ; & quad-coordinates
;             bpl.s     .Skip_X
;             addi.w    #Submap_width,d0
;             bset      #0,d2
;.Skip_X:     cmpi.w    #Submap_height/2+1,d1
;             bpl.s     .Skip_Y
;             addi.w    #Submap_height,d1
;             bset      #1,d2
;.Skip_Y:     move.w    d0,Quad_X            ; Store
;             move.w    d1,Quad_Y
;             move.w    d2,Quad_index
;             move.w    World_X,d0           ; Initialize registers
;             move.w    World_Y,d1
;             lea.l     Quad_map,a1
;             lea.l     Load_table,a2
;             add.w     d2,d2                ; Set map & text pointer
;             add.w     d2,d2
;             move.l    a5,0(a1,d2.w)
;             move.l    Maptext_ptr,16(a1,d2.w)
;             move.w    Map_nr,34(a1,d2.w)
;             move.l    -16(a2,d2.w),d2      ; Get altered quad-index
;             movea.l   0(a2,d2.w),a0        ; Execute routine
;             jsr       (a0)
;             addq.w    #4,d2                ; Next routine
;             andi.w    #$000f,d2
;             movea.l   0(a2,d2.w),a0        ; Execute routine
;             jsr       (a0)
;             addq.w    #4,d2                ; Next routine
;             andi.w    #$000f,d2
;             movea.l   0(a2,d2.w),a0        ; Execute routine
;             jsr       (a0)
;             .LOCAL
;             jsr       W2_DisInit
;             jsr       Event_handler        ; Handle first event
;             rts
;
;             .DC.l 4,8,0,12
;Load_table:  .DC.l Load_0,Load_1,Load_3,Load_2

W2_ModInit:
	move.l	a5,Mapd_ptr
	bsr.w	M2_time_evaluate
	move.w	New_radius,Current_radius
	move.w	$2(a5),d0
	lea.l	Icondata_filename,a0
	jsr	Load_subfile
	move.l	a0,Icondata_ptr
	bsr.w	Init_maptexts
	lea.l	$2f0(a0),a0
	move.l	a0,Iconstats_ptr
	moveq	#0,d0
	move.b	$7(a5),d0
	move.w	d0,Width_of_map
	moveq	#0,d1
	move.b	$8(a5),d1
	move.w	d1,Height_of_map
	mulu.w	d0,d1
	move.w	d1,Size_of_map
	lea.l	$ac5(a5),a0
	move.l	a0,Map_pointer
	move.b	#$2,Anim_speed
	move.b	#$2,Anim_count
	move.w	#$6,Anim_bias
	move.w	#$5,Mapbuf_X
	move.w	#$4,Mapbuf_Y
	move.w	Map_nr,d7
	movea.l	Mapd_ptr,a0
	bsr.w	Make_modifications
	moveq	#0,d2
	move.w	Map_nr,d2
	subq.l	#$1,d2
	divu.w	#$8,d2
	move.w	d2,World_Y
	swap	d2
	move.w	d2,World_X
	move.w	Map_Xcoord,d0
	move.w	Map_Ycoord,d1
	moveq	#0,d2
	cmpi.w	#$1a,d0
	bpl.b	.l_03d36
	addi.w	#$32,d0
	bset	#$0,d2
.l_03d36:
	cmpi.w	#$1a,d1
	bpl.b	.l_03d44
	addi.w	#$32,d1
	bset	#$1,d2
.l_03d44:
	move.w	d0,Quad_X
	move.w	d1,Quad_Y
	move.w	d2,Quad_index
	move.w	World_X,d0
	move.w	World_Y,d1
	lea.l	Quad_map,a1
	lea.l	.l_03dc6,a2
	add.w	d2,d2
	add.w	d2,d2
	move.l	a5,(a1,d2.w)
	move.l	Maptext_ptr,$10(a1,d2.w)
	move.w	Map_nr,$22(a1,d2.w)
	move.l	-$10(a2,d2.w),d2
	movea.l	(a2,d2.w),a0
	jsr	(a0)
	addq.w	#$4,d2
	andi.w	#$f,d2
	movea.l	(a2,d2.w),a0
	jsr	(a0)
	addq.w	#$4,d2
	andi.w	#$f,d2
	movea.l	(a2,d2.w),a0
	jsr	(a0)
	bsr.w	T_00208
	bsr.w	W2_DisInit
	bsr.w	Event_handler
	rts
	dc.b	$00,$00,$00,$04,$00,$00,$00,$08,$00,$00,$00,$00,$00,$00,$00,$0c
.l_03dc6:
	dc.l	Load_0	; ori.b #$d6, d0
	dc.l	Load_3	; ori.b #$f6, d0
	dc.l	T_03e18	; ori.b #$18, d0
	dc.l	Load_2	; ori.b #$3a, d0
; ---- Load_0 (original source: MAIN/MAP/2DWILD.ASM)
Load_0:
	movem.l	d2/d7/a2,-(sp)
	subq.w	#1,d1
	bsr.w	Load_submap
	move.l	a0,(a1)
	move.l	a2,16(a1)
	move.w	d2,34(a1)
	move.w	d2,d7
	bsr.w	Make_modifications
	movem.l	(sp)+,d2/d7/a2
	rts	
; ---- Load_3 (original source: MAIN/MAP/2DWILD.ASM)
Load_1:
Load_3:
	movem.l	d2/d7/a2,-(sp)
	addq.w	#$1,d0	; CHANGE: was "addq.w #1,d1"
	bsr.w	Load_submap
	move.l	a0,$4(a1)	; CHANGE: was "move.l a0,12(a1)"
	move.l	a2,$14(a1)	; CHANGE: was "move.l a2,16+12(a1)"
	move.w	d2,$26(a1)	; CHANGE: was "move.w d2,34+12(a1)"
	move.w	d2,d7
	bsr.w	Make_modifications
	movem.l	(sp)+,d2/d7/a2
	rts	
T_03e18:
	movem.l	d2/d7/a2,-(a7)
	addq.w	#$1,d1
	bsr.w	Load_submap
	move.l	a0,$c(a1)
	move.l	a2,$1c(a1)
	move.w	d2,$2e(a1)
	move.w	d2,d7
	bsr.w	Make_modifications
	movem.l	(a7)+,d2/d7/a2
	rts
; ---- Load_2 (original source: MAIN/MAP/2DWILD.ASM)
Load_2:
	movem.l	d2/d7/a2,-(sp)
	subq.w	#1,d0
	bsr.w	Load_submap
	move.l	a0,8(a1)
	move.l	a2,16+8(a1)
	move.w	d2,34+8(a1)
	move.w	d2,d7
	bsr.w	Make_modifications
	movem.l	(sp)+,d2/d7/a2
	rts	

; ---- W2_DisInit (original source: MAIN/MAP/2DWILD.ASM) - the shipped program differs, its code follows, not assembled:
;W2_DisInit:
;             movea.l   Mapd_ptr,a5          ; Get pointer to map dta
;             jsr       Set_spell_area
;; ------------- Initialize display -----------------------------------
;             movea.l   Off_screen,a6        ; Get screen base
;             moveq.l   #1,d0                ; Show 2D map layout
;             jsr       Show_layout
;             jsr       Print_headline
;             move.l    #W2_CIL,First_CIL_ptr      ; Display control icons
;             jsr       Handle_CIL
;             jsr       Show_control_icons
;             jsr       W2_DisUpd            ; Display 2D map
;             Update_screen
;; ------------- Various installations --------------------------------
;             sf        Time_lock
;             lea.l     Lay1_c1,a0           ; Object branch
;             jsr       Set_layout_data
;             move.l    #W2_CIL+10,Mousemove_ptr   ; Mouse actions
;; ------------- Fade-in display --------------------------------------
;             movea.l   Icondata_ptr,a0      ; Convert IFF-palette
;             lea.l     Icon_palette(a0),a0
;             lea.l     Pal_buffer,a1
;             jsr       IFF_pal_convert
;             lea.l     Subfade1,a2          ; Fade in
;.Again:      lea.l     Hbl_2D_map,a0        ; Update palettes
;             jsr       Update_HBL
;             jsr       My_vsync             ; Wait 2 Vbl's
;             jsr       My_vsync
;             lea.l     Below_pal_2D,a0      ; Fade
;             jsr       Fade_pal
;             bne.s     .Again
;             lea.l     Hbl_2D_map,a0        ; Update palettes
;             jsr       Update_HBL
;             rts

W2_DisInit:
	sf.b	Time_lock
	movea.l	Mapd_ptr,a5
	bsr.w	Set_spell_area
	bsr.w	Set_map_music
	movea.l	Off_screen,a6
	moveq	#1,d0
	bsr.w	Show_layout
	bsr.w	Print_headline
	move.l	#C2_CIL,First_CIL_ptr
	bsr.w	Handle_CIL
	bsr.w	Show_control_icons
	st.b	B_57c4c
	bsr.w	W2_DisUpd
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	Lay1_c1,a0
	bsr.w	Set_layout_data
	move.l	#D_1e1a8,Mousemove_ptr
	movea.l	Icondata_ptr,a0
	lea.l	$7d2(a0),a0
	lea.l	Pal_buffer,a1
	jsr	IFF_pal_convert
	lea.l	Subfade1,a2
.l_03ed8:
	lea.l	Hbl_2D_map,a0
	jsr	Update_HBL
	jsr	My_vsync
	jsr	My_vsync
	lea.l	Below_pal_2D,a0
	jsr	Fade_pal
	bne.b	.l_03ed8
	lea.l	Hbl_2D_map,a0
	jsr	Update_HBL
	rts
; ---- W2_ModExit (original source: MAIN/MAP/2DWILD.ASM)
W2_ModExit:
	lea.l	Trans_buf,a0
	moveq.l	#0,d0
	move.b	d0,(a0)+
	move.w	d0,(a0)+
	moveq.l	#35-1,d7
.Loop:
	move.l	d0,(a0)+
	dbra	d7,.Loop
	lea.l	Quad_map,a1
	moveq.l	#8-1,d7
.Loop_L1:
	movea.l	(a1)+,a0
	jsr	Free_memory
	dbra	d7,.Loop_L1
	movea.l	Icondata_ptr,a0
	jsr	Free_memory
	jsr	Next_generation
	rts	
T_03f48:
	st.b	Time_lock
; ---- W2_DisExit (original source: MAIN/MAP/2DWILD.ASM)
C2_DisExit:
W2_DisExit:
	lea.l	Void,a1
	lea.l	Subfade1,a2
.Again:
	lea.l	Hbl_2D_map,a0
	jsr	Update_HBL
	jsr	My_vsync
	jsr	My_vsync
	lea.l	Below_pal_2D,a0
	jsr	Fade_pal
	bne.s	.Again
	lea.l	Hbl_2D_map,a0
	jsr	Update_HBL
	rts	
; ---- Quad_evaluate (original source: MAIN/MAP/2DWILD.ASM)
Quad_evaluate:
	movem.l	d0-d4/a0/a1,-(sp)
	move.w	Map_Xcoord,d0
	move.w	Map_Ycoord,d1
	move.w	World_X,d2
	move.w	World_Y,d3
	move.w	Quad_index,d4
	cmpi.w	#1,d0
	bpl.s	.Skip_1
	addi.w	#Submap_width,d0
	bclr	#0,d4
	subq.w	#1,d2
	bpl.s	.Check_Y
	move.w	#World_width-1,d2
	bra.s	.Check_Y
.Skip_1:
	cmpi.w	#Submap_width+1,d0
	bmi.s	.Check_Y
	subi.w	#Submap_width,d0
	bset	#0,d4
	addq.w	#1,d2
	cmpi.w	#World_width,d2
	bmi.s	.Check_Y
	moveq.l	#0,d2
.Check_Y:
	cmpi.w	#1,d1
	bpl.s	.Skip_2
	addi.w	#Submap_height,d1
	bclr	#1,d4
	subq.w	#1,d3
	bpl.s	.Cont
	move.w	#World_height-1,d3
	bra.s	.Cont
.Skip_2:
	cmpi.w	#Submap_height+1,d1
	bmi.s	.Cont
	subi.w	#Submap_height,d1
	bset	#1,d4
	addq.w	#1,d3
	cmpi.w	#World_height,d3
	bmi.s	.Cont
	moveq.l	#0,d3
.Cont:
	move.w	d0,Map_Xcoord
	move.w	d1,Map_Ycoord
	move.w	d2,World_X
	move.w	d3,World_Y
	move.w	d4,Quad_index
	mulu.w	#World_width,d3
	add.w	d2,d3
	addq.w	#1,d3
	move.w	d3,Map_nr
	move.w	Quad_X,d0
	move.w	Quad_Y,d1
	moveq.l	#0,d3
	cmpi.w	#Trigger+1,d0
	bmi.s	.Check_Y_L1
	cmpi.w	#101-Trigger,d0
	bmi.s	.Mid_X_L1
	addq.w	#8,d3
	bra.s	.Check_Y_L1
.Mid_X_L1:
	addq.w	#4,d3
.Check_Y_L1:
	cmpi.w	#Trigger+1,d1
	bmi.s	.Cont_L1
	cmpi.w	#101-Trigger,d1
	bmi.s	.Mid_Y_L1
	addi.w	#24,d3
	bra.s	.Cont_L1
.Mid_Y_L1:
	addi.w	#12,d3
.Cont_L1:
	move.w	World_X,d0
	move.w	World_Y,d1
	move.w	Quad_index,d2
	lea.l	Quad_map,a1
	lea.l	Shift_tab,a0
	move.l	0(a0,d3.w),d3
	beq.s	.Skip_L2
	movea.l	d3,a0
	jsr	(a0)
	move.w	d2,Quad_index
.Skip_L2:
	lea.l	Quad_map,a1
	move.w	Quad_index,d2
	add.w	d2,d2
	add.w	d2,d2
	movea.l	0(a1,d2.w),a0
	move.l	a0,Mapd_ptr
	lea.l	Map_data(a0),a0
	move.l	a0,Map_pointer
	move.l	16(a1,d2.w),Maptext_ptr
	movem.l	(sp)+,d0-d4/a0/a1
	rts	
Shift_tab:
	dc.l	Shift_UL,Shift_U,Shift_UR
	dc.l	Shift_L,0,Shift_R
	dc.l	Shift_DL,Shift_D,Shift_DR
; ---- Shift_UL (original source: MAIN/MAP/2DWILD.ASM)
Shift_UL:
	movea.l	4(a1),a0
	jsr	Free_memory
	movea.l	8(a1),a0
	jsr	Free_memory
	movea.l	12(a1),a0
	jsr	Free_memory
	movea.l	16+4(a1),a0
	jsr	Free_memory
	movea.l	16+8(a1),a0
	jsr	Free_memory
	movea.l	16+12(a1),a0
	jsr	Free_memory
	move.l	(a1),12(a1)
	move.l	16(a1),16+12(a1)
	move.w	34(a1),34+12(a1)
	subq.w	#1,d0
	bsr.w	Load_submap
	move.l	a0,8(a1)
	move.l	a2,16+8(a1)
	move.w	d2,34+8(a1)
	subq.w	#1,d1
	bsr.w	Load_submap
	move.l	a0,(a1)
	move.l	a2,16(a1)
	move.w	d2,34(a1)
	addq.w	#1,d0
	bsr.w	Load_submap
	move.l	a0,4(a1)
	move.l	a2,16+4(a1)
	move.w	d2,34+4(a1)
	addi.w	#Submap_width,Quad_X
	addi.w	#Submap_height,Quad_Y
	move.w	#3,d2
	rts	
; ---- Shift_U (original source: MAIN/MAP/2DWILD.ASM)
Shift_U:
	move.l	d2,-(sp)
	movea.l	8(a1),a0
	jsr	Free_memory
	movea.l	12(a1),a0
	jsr	Free_memory
	movea.l	16+8(a1),a0
	jsr	Free_memory
	movea.l	16+12(a1),a0
	jsr	Free_memory
	move.l	(a1),8(a1)
	move.l	4(a1),12(a1)
	move.l	16(a1),16+8(a1)
	move.l	16+4(a1),16+12(a1)
	move.w	34(a1),34+8(a1)
	move.w	34+4(a1),34+12(a1)
	btst	#0,Quad_index+1
	beq.s	.Skip
	subq.w	#1,d0
.Skip:
	subq.w	#1,d1
	bsr.w	Load_submap
	move.l	a0,(a1)
	move.l	a2,16(a1)
	move.w	d2,34(a1)
	addq.w	#1,d0
	bsr.w	Load_submap
	move.l	a0,4(a1)
	move.l	a2,16+4(a1)
	move.w	d2,34+4(a1)
	addi.w	#Submap_height,Quad_Y
	move.l	(sp)+,d2
	bset	#1,d2
	rts	
; ---- Shift_UR (original source: MAIN/MAP/2DWILD.ASM)
Shift_UR:
	movea.l	(a1),a0
	jsr	Free_memory
	movea.l	8(a1),a0
	jsr	Free_memory
	movea.l	12(a1),a0
	jsr	Free_memory
	movea.l	16(a1),a0
	jsr	Free_memory
	movea.l	16+8(a1),a0
	jsr	Free_memory
	movea.l	16+12(a1),a0
	jsr	Free_memory
	move.l	4(a1),8(a1)
	move.l	16+4(a1),16+8(a1)
	move.w	34+4(a1),34+8(a1)
	subq.w	#1,d1
	bsr.w	Load_submap
	move.l	a0,(a1)
	move.l	a2,16(a1)
	move.w	d2,34(a1)
	addq.w	#1,d0
	bsr.w	Load_submap
	move.l	a0,4(a1)
	move.l	a2,16+4(a1)
	move.w	d2,34+4(a1)
	addq.w	#1,d1
	bsr.w	Load_submap
	move.l	a0,12(a1)
	move.l	a2,16+12(a1)
	move.w	d2,34+12(a1)
	subi.w	#Submap_width,Quad_X
	addi.w	#Submap_height,Quad_Y
	move.w	#2,d2
	rts	
; ---- Shift_L (original source: MAIN/MAP/2DWILD.ASM)
Shift_L:
	move.l	d2,-(sp)
	movea.l	4(a1),a0
	jsr	Free_memory
	movea.l	12(a1),a0
	jsr	Free_memory
	movea.l	16+4(a1),a0
	jsr	Free_memory
	movea.l	16+12(a1),a0
	jsr	Free_memory
	move.l	(a1),4(a1)
	move.l	8(a1),12(a1)
	move.l	16(a1),16+4(a1)
	move.l	16+8(a1),16+12(a1)
	move.w	34(a1),34+4(a1)
	move.w	34+8(a1),34+12(a1)
	btst	#1,Quad_index+1
	beq.s	.Skip
	subq.w	#1,d1
.Skip:
	subq.w	#1,d0
	bsr.w	Load_submap
	move.l	a0,(a1)
	move.l	a2,16(a1)
	move.w	d2,34(a1)
	addq.w	#1,d1
	bsr.w	Load_submap
	move.l	a0,8(a1)
	move.l	a2,16+8(a1)
	move.w	d2,34+8(a1)
	addi.w	#Submap_width,Quad_X
	move.l	(sp)+,d2
	bset	#0,d2
	rts	
; ---- Shift_R (original source: MAIN/MAP/2DWILD.ASM)
Shift_R:
	move.l	d2,-(sp)
	movea.l	(a1),a0
	jsr	Free_memory
	movea.l	8(a1),a0
	jsr	Free_memory
	movea.l	16(a1),a0
	jsr	Free_memory
	movea.l	16+8(a1),a0
	jsr	Free_memory
	move.l	4(a1),(a1)
	move.l	12(a1),8(a1)
	move.l	16+4(a1),16(a1)
	move.l	16+12(a1),16+8(a1)
	move.w	34+4(a1),34(a1)
	move.w	34+12(a1),34+8(a1)
	btst	#1,Quad_index+1
	beq.s	.Skip
	subq.w	#1,d1
.Skip:
	addq.w	#1,d0
	bsr.w	Load_submap
	move.l	a0,4(a1)
	move.l	a2,16+4(a1)
	move.w	d2,34+4(a1)
	addq.w	#1,d1
	bsr.w	Load_submap
	move.l	a0,12(a1)
	move.l	a2,16+12(a1)
	move.w	d2,34+12(a1)
	subi.w	#Submap_width,Quad_X
	move.l	(sp)+,d2
	bclr	#0,d2
	rts	
; ---- Shift_DL (original source: MAIN/MAP/2DWILD.ASM)
Shift_DL:
	movea.l	(a1),a0
	jsr	Free_memory
	movea.l	4(a1),a0
	jsr	Free_memory
	movea.l	12(a1),a0
	jsr	Free_memory
	movea.l	16(a1),a0
	jsr	Free_memory
	movea.l	16+4(a1),a0
	jsr	Free_memory
	movea.l	16+12(a1),a0
	jsr	Free_memory
	move.l	8(a1),4(a1)
	move.l	16+8(a1),16+4(a1)
	move.w	34+8(a1),34+4(a1)
	addq.w	#1,d1
	bsr.w	Load_submap
	move.l	a0,12(a1)
	move.l	a2,16+12(a1)
	move.w	d2,34+12(a1)
	subq.w	#1,d0
	bsr.w	Load_submap
	move.l	a0,8(a1)
	move.l	a2,16+8(a1)
	move.w	d2,34+8(a1)
	subq.w	#1,d1
	bsr.w	Load_submap
	move.l	a0,(a1)
	move.l	a2,16(a1)
	move.w	d2,34(a1)
	addi.w	#Submap_width,Quad_X
	subi.w	#Submap_height,Quad_Y
	move.w	#1,Quad_index
	rts	
; ---- Shift_D (original source: MAIN/MAP/2DWILD.ASM)
Shift_D:
	move.l	d2,-(sp)
	movea.l	(a1),a0
	jsr	Free_memory
	movea.l	4(a1),a0
	jsr	Free_memory
	movea.l	16(a1),a0
	jsr	Free_memory
	movea.l	16+4(a1),a0
	jsr	Free_memory
	move.l	8(a1),(a1)
	move.l	12(a1),4(a1)
	move.l	16+8(a1),16(a1)
	move.l	16+12(a1),16+4(a1)
	move.w	34+8(a1),34(a1)
	move.w	34+12(a1),34+4(a1)
	btst	#0,Quad_index+1
	beq.s	.Skip
	subq.w	#1,d0
.Skip:
	addq.w	#1,d1
	bsr.w	Load_submap
	move.l	a0,8(a1)
	move.l	a2,16+8(a1)
	move.w	d2,34+8(a1)
	addq.w	#1,d0
	bsr.w	Load_submap
	move.l	a0,12(a1)
	move.l	a2,16+12(a1)
	move.w	d2,34+12(a1)
	subi.w	#Submap_height,Quad_Y
	move.l	(sp)+,d2
	bclr	#1,d2
	rts	
; ---- Shift_DR (original source: MAIN/MAP/2DWILD.ASM)
Shift_DR:
	movea.l	(a1),a0
	jsr	Free_memory
	movea.l	4(a1),a0
	jsr	Free_memory
	movea.l	8(a1),a0
	jsr	Free_memory
	movea.l	16(a1),a0
	jsr	Free_memory
	movea.l	16+4(a1),a0
	jsr	Free_memory
	movea.l	16+8(a1),a0
	jsr	Free_memory
	move.l	12(a1),(a1)
	move.l	16+12(a1),16(a1)
	move.w	34+12(a1),34(a1)
	addq.w	#1,d0
	bsr.w	Load_submap
	move.l	a0,4(a1)
	move.l	a2,16+4(a1)
	move.w	d2,34+4(a1)
	addq.w	#1,d1
	bsr.w	Load_submap
	move.l	a0,12(a1)
	move.l	a2,16+12(a1)
	move.w	d2,34+12(a1)
	subq.w	#1,d0
	bsr.w	Load_submap
	move.l	a0,8(a1)
	move.l	a2,16+8(a1)
	move.w	d2,34+8(a1)
	subi.w	#Submap_width,Quad_X
	subi.w	#Submap_height,Quad_Y
	move.w	#0,d2
	rts	

; ---- Load_submap (original source: MAIN/MAP/2DWILD.ASM) - the shipped program differs, its code follows, not assembled:
;Load_submap:
;             movem.l   d0/d1,-(sp)
;             tst.w     d0                   ; Wrap X
;             bpl.s     .Skip_1
;             addi.w    #World_width,d0
;             bra.s     .Check_Y
;.Skip_1:     cmpi.w    #World_width,d0
;             bmi.s     .Check_Y
;             subi.w    #World_width,d0
;.Check_Y:    tst.w     d1                   ; Wrap Y
;             bpl.s     .Skip_2
;             addi.w    #World_height,d1
;             bra.s     .Cont
;.Skip_2:     cmpi.w    #World_height,d1
;             bmi.s     .Cont
;             subi.w    #World_height,d1
;.Cont:       mulu.w    #World_width,d1
;             add.w     d1,d0
;             addq.w    #1,d0                ; Add number of first map
;             lea.l     Maptext_filename,a0  ; Load text
;             jsr       Load_subfile
;             movea.l   a0,a2
;             lea.l     Mapd_filename,a0     ; Load map
;             jsr       Load_subfile
;             move.w    d0,d2                ; Copy
;             movem.l   (sp)+,d0/d1
;             rts

Load_submap:
	movem.l	d0-d1/d7,-(a7)
	tst.w	d0
	bpl.b	.l_04586
	addq.w	#$8,d0
	bra.b	.l_0458e
.l_04586:
	dc.b	$0c,$40,$00,$08,$6b,$02,$51,$40
.l_0458e:
	tst.w	d1
	bpl.b	.l_04596
	addq.w	#$8,d1
	bra.b	.l_0459e
.l_04596:
	dc.b	$0c,$41,$00,$08,$6b,$02,$51,$41
.l_0459e:
	mulu.w	#$8,d1
	add.w	d1,d0
	addq.w	#$1,d0
	lea.l	Maptext_filename,a0
	jsr	Load_subfile
	movea.l	a0,a2
	lea.l	D_2f1f2,a0
	jsr	Load_subfile
	move.w	d0,d7
	bsr.w	Make_modifications
	move.w	d0,d2
	movem.l	(a7)+,d0-d1/d7
	rts
; ---- W2_downright (original source: MAIN/MAP/2DWILD.ASM)
W2_downright:
	bsr.w	Before_move
	movem.l	d0-d2,-(sp)
	moveq.l	#-1,d2
	move.w	#2,View_direction
	move.w	Map_Xcoord,d0
	move.w	Map_Ycoord,d1
	addq.w	#1,d0
	addq.w	#1,d1
	bsr.w	Movement_check_2D
	beq.s	.Move
	bsr.w	W2_down
	beq.s	.Exit
	bsr.w	W2_right
	bra.s	.Exit
.Move:
	move.w	d0,Map_Xcoord
	move.w	d1,Map_Ycoord
	addq.w	#1,Quad_X
	addq.w	#1,Quad_Y
	bsr.w	Quad_evaluate
	move.w	#1,Scroll_X
	move.w	#1,Scroll_Y
	move.w	#1,Half_X
	move.w	#1,Half_Y
	bsr.w	Build_2D_map
	jsr	Switch_screen
	bsr.w	After_move
	moveq.l	#0,d2
.Exit:
	tst.w	d2
	movem.l	(sp)+,d0-d2
	rts	
; ---- W2_upright (original source: MAIN/MAP/2DWILD.ASM)
W2_upright:
	bsr.w	Before_move
	movem.l	d0-d2,-(sp)
	moveq.l	#-1,d2
	move.w	#0,View_direction
	move.w	Map_Xcoord,d0
	move.w	Map_Ycoord,d1
	addq.w	#1,d0
	subq.w	#1,d1
	bsr.w	Movement_check_2D
	beq.s	.Move
	bsr.w	W2_up
	beq.s	.Exit
	bsr.w	W2_right
	bra.s	.Exit
.Move:
	move.w	d0,Map_Xcoord
	move.w	d1,Map_Ycoord
	addq.w	#1,Quad_X
	subq.w	#1,Quad_Y
	bsr.w	Quad_evaluate
	move.w	#1,Scroll_X
	move.w	#-1,Scroll_Y
	move.w	#1,Half_X
	move.w	#-1,Half_Y
	bsr.w	Build_2D_map
	jsr	Switch_screen
	bsr.w	After_move
	moveq.l	#0,d2
.Exit:
	tst.w	d2
	movem.l	(sp)+,d0-d2
	rts	
; ---- W2_downleft (original source: MAIN/MAP/2DWILD.ASM)
W2_downleft:
	bsr.w	Before_move
	movem.l	d0-d2,-(sp)
	moveq.l	#-1,d2
	move.w	#2,View_direction
	move.w	Map_Xcoord,d0
	move.w	Map_Ycoord,d1
	subq.w	#1,d0
	addq.w	#1,d1
	bsr.w	Movement_check_2D
	beq.s	.Move
	bsr.w	W2_down
	beq.s	.Exit
	bsr.w	W2_left
	bra.s	.Exit
.Move:
	move.w	d0,Map_Xcoord
	move.w	d1,Map_Ycoord
	subq.w	#1,Quad_X
	addq.w	#1,Quad_Y
	bsr.w	Quad_evaluate
	move.w	#-1,Scroll_X
	move.w	#1,Scroll_Y
	move.w	#-1,Half_X
	move.w	#1,Half_Y
	bsr.w	Build_2D_map
	jsr	Switch_screen
	bsr.w	After_move
	moveq.l	#0,d2
.Exit:
	tst.w	d2
	movem.l	(sp)+,d0-d2
	rts	
; ---- W2_upleft (original source: MAIN/MAP/2DWILD.ASM)
W2_upleft:
	bsr.w	Before_move
	movem.l	d0-d2,-(sp)
	moveq.l	#-1,d2
	move.w	#0,View_direction
	move.w	Map_Xcoord,d0
	move.w	Map_Ycoord,d1
	subq.w	#1,d0
	subq.w	#1,d1
	bsr.w	Movement_check_2D
	beq.s	.Move
	bsr.w	W2_up
	beq.s	.Exit
	bsr.w	W2_left
	bra.s	.Exit
.Move:
	move.w	d0,Map_Xcoord
	move.w	d1,Map_Ycoord
	subq.w	#1,Quad_X
	subq.w	#1,Quad_Y
	bsr.w	Quad_evaluate
	move.w	#-1,Scroll_X
	move.w	#-1,Scroll_Y
	move.w	#-1,Half_X
	move.w	#-1,Half_Y
	bsr.w	Build_2D_map
	jsr	Switch_screen
	bsr.w	After_move
	moveq.l	#0,d2
.Exit:
	tst.w	d2
	movem.l	(sp)+,d0-d2
	rts	
; ---- W2_up (original source: MAIN/MAP/2DWILD.ASM)
W2_up:
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
	subq.w	#1,Quad_Y
	bsr.w	Quad_evaluate
	move.w	#-1,Scroll_Y
	move.w	#-1,Half_Y
	bsr.w	Build_2D_map
	jsr	Switch_screen
	bsr.w	After_move
	moveq.l	#0,d2
.Exit:
	tst.w	d2
	movem.l	(sp)+,d0-d2
	rts	
; ---- W2_down (original source: MAIN/MAP/2DWILD.ASM)
W2_down:
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
	addq.w	#1,Quad_Y
	bsr.w	Quad_evaluate
	move.w	#1,Scroll_Y
	move.w	#1,Half_Y
	bsr.w	Build_2D_map
	jsr	Switch_screen
	bsr.w	After_move
	moveq.l	#0,d2
.Exit:
	tst.w	d2
	movem.l	(sp)+,d0-d2
	rts	
; ---- W2_right (original source: MAIN/MAP/2DWILD.ASM)
W2_right:
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
	addq.w	#1,Quad_X
	bsr.w	Quad_evaluate
	move.w	#1,Scroll_X
	move.w	#1,Half_X
	bsr.w	Build_2D_map
	jsr	Switch_screen
	bsr.w	After_move
	moveq.l	#0,d2
.Exit:
	tst.w	d2
	movem.l	(sp)+,d0-d2
	rts	
; ---- W2_left (original source: MAIN/MAP/2DWILD.ASM)
W2_left:
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
	subq.w	#1,Quad_X
	bsr.w	Quad_evaluate
	move.w	#-1,Scroll_X
	move.w	#-1,Half_X
	bsr.w	Build_2D_map
	jsr	Switch_screen
	bsr.w	After_move
	moveq.l	#0,d2
.Exit:
	tst.w	d2
	movem.l	(sp)+,d0-d2
	rts	

; ---- W2_DisUpd (original source: MAIN/MAP/2DWILD.ASM) - the shipped program differs, its code follows, not assembled:
;W2_DisUpd:
;             movem.l   d0-d2/a0/a1,-(sp)
;             lea.l     Trans_buf,a0         ; Clear transport buffer
;             moveq.l   #0,d0
;             move.b    d0,(a0)+
;             move.w    d0,(a0)+
;             moveq.l   #35-1,d1
;.Loop:       move.l    d0,(a0)+
;             dbra      d1,.Loop
;             move.w    Quad_X,d0            ; Get quad-map coordinates
;             move.w    Quad_Y,d1
;             subi.w    #Def_mapbuf_X+2,d0   ; Adjust coordinates
;             subi.w    #Def_mapbuf_Y+2,d1
;             move.w    Quad_index,d2        ; Calculate multi-map index
;             add.w     d2,d2
;             add.w     d2,d2
;             cmpi.w    #Submap_width-12,d0
;             bmi.s     .Check_Y
;             cmpi.w    #Submap_width,d0
;             bpl.s     .Check_Y
;             bset      #4,d2
;.Check_Y:    cmpi.w    #Submap_height-10,d1
;             bmi.s     .Cont
;             cmpi.w    #Submap_height,d1
;             bpl.s     .Cont
;             bset      #5,d2
;.Cont:       lea.l     Quad_map,a1          ; Pointer to quad-map
;             lea.l     Multimap_table,a0    ; Get routine address
;             movea.l   0(a0,d2.w),a0
;             jsr       (a0)                 ; Execute routine
;             .LOCAL
;             jsr       Build_2D_map         ; Build 2D map
;             jsr       Update_map_CIL
;             tst.b     CombatReq            ; Start combat ?
;             beq.s     .Exit
;             Push      Module,CombatReq_Mod
;.Exit:       movem.l   (sp)+,d0-d2/a0/a1
;             rts

W2_DisUpd:
	movem.l	d0-d2/a0-a1,-(a7)
	lea.l	Trans_buf,a0
	moveq	#0,d0
	move.b	d0,(a0)+
	move.w	d0,(a0)+
	moveq	#34,d1
.l_04990:
	move.l	d0,(a0)+
	dbra	d1,.l_04990
	move.w	Quad_X,d0
	move.w	Quad_Y,d1
	subq.w	#$7,d0
	subq.w	#$6,d1
	move.w	Quad_index,d2
	add.w	d2,d2
	add.w	d2,d2
	cmpi.w	#$26,d0
	bmi.b	.l_049c0
	cmpi.w	#$32,d0
	bpl.b	.l_049c0
	bset	#$4,d2
.l_049c0:
	cmpi.w	#$28,d1
	bmi.b	.l_049d0
	cmpi.w	#$32,d1
	bpl.b	.l_049d0
	bset	#$5,d2
.l_049d0:
	lea.l	Quad_map,a1
	lea.l	.l_04a04,a0
	movea.l	(a0,d2.w),a0
	jsr	(a0)
	bsr.w	Build_2D_map
	bsr.w	Update_map_CIL
	tst.b	CombatReq
	beq.b	.l_049fe
	lea.l	CombatReq_Mod,a0
	jsr	Push_Module
.l_049fe:
	movem.l	(a7)+,d0-d2/a0-a1
	rts
.l_04a04:
	dc.l	.l_04a44	; ori.b #$44, d0
	dc.l	.l_04a44	; ori.b #$44, d0
	dc.l	.l_04a44	; ori.b #$44, d0
	dc.l	.l_04a44	; ori.b #$44, d0
	dc.l	Cut_C	; ori.b #$64, d0
	dc.l	Cut_C	; ori.b #$64, d0
	dc.l	T_04ab8	; ori.b #$b8, d0
	dc.l	T_04ab8	; ori.b #$b8, d0
	dc.l	T_04a7e	; ori.b #$7e, d0
	dc.l	Cut_E	; ori.b #$98, d0
	dc.l	T_04a7e	; ori.b #$7e, d0
	dc.l	Cut_E	; ori.b #$98, d0
	dc.l	Cut_F	; ori.b #$d8, d0
	dc.l	Cut_F	; ori.b #$d8, d0
	dc.l	Cut_F	; ori.b #$d8, d0

; ---- Multimap_table (original source: MAIN/MAP/2DWILD.ASM) - not found in the shipped program, the original source is older, not assembled:
;Multimap_table:
;             .DC.l Cut_A,Cut_A,Cut_A,Cut_A
;             .DC.l Cut_B,Cut_B,Cut_E,Cut_E
;             .DC.l Cut_C,Cut_D,Cut_C,Cut_D
;             .DC.l Cut_F,Cut_F,Cut_F,Cut_F

; ---- Cut_A (original source: MAIN/MAP/2DWILD.ASM) - the shipped program differs, its code follows, not assembled:
;Cut_A:       move.w    Map_Xcoord,d0        ; Get party coordinates
;             move.w    Map_Ycoord,d1
;             subi.w    #Def_mapbuf_X+2,d0   ; Adjust coordinates
;             subi.w    #Def_mapbuf_Y+2,d1
;             movea.l   Mapd_ptr,a0          ; Cut from normal map
;             move.w    Map_nr,d2
;             jmp       Copy_map_part

	dc.l	Cut_F	; ori.b #$d8, d0
.l_04a44:
	move.w	Map_Xcoord,d0
	move.w	Map_Ycoord,d1
	subq.w	#$7,d0
	subq.w	#$6,d1
	movea.l	Mapd_ptr,a0
	move.w	Map_nr,d2
	bra.w	Copy_map_part
; ---- Cut_C (original source: MAIN/MAP/2DWILD.ASM)
Cut_B:
Cut_C:
	movea.l	(a1),a0
	move.w	34(a1),d2
	bsr.w	Copy_map_part
	subi.w	#$32,d0	; CHANGE: was "subi.w #Submap_height,d1"
	movea.l	$4(a1),a0	; CHANGE: was "movea.l 8(a1),a0"
	move.w	$26(a1),d2	; CHANGE: was "move.w 34+8(a1),d2"
	bra.w	Copy_map_part
T_04a7e:
	movea.l	(a1),a0
	move.w	$22(a1),d2
	bsr.w	Copy_map_part
	subi.w	#$32,d1
	movea.l	$8(a1),a0
	move.w	$2a(a1),d2
	bra.w	Copy_map_part
; ---- Cut_E (original source: MAIN/MAP/2DWILD.ASM)
Cut_D:
Cut_E:
	subi.w	#$32,d0	; CHANGE: was "Cut_E: subi.w #Submap_height,d1"
	movea.l	$4(a1),a0	; CHANGE: was "movea.l 8(a1),a0"
	move.w	$26(a1),d2	; CHANGE: was "move.w 34+8(a1),d2"
	bsr.w	Copy_map_part
	subi.w	#$32,d1	; CHANGE: was "subi.w #Submap_width,d0"
	movea.l	12(a1),a0
	move.w	34+12(a1),d2
	bra.w	Copy_map_part
T_04ab8:
	subi.w	#$32,d1
	movea.l	$8(a1),a0
	move.w	$2a(a1),d2
	bsr.w	Copy_map_part
	subi.w	#$32,d0
	movea.l	$c(a1),a0
	move.w	$2e(a1),d2
	bra.w	Copy_map_part
; ---- Cut_F (original source: MAIN/MAP/2DWILD.ASM)
Cut_F:
	movea.l	(a1),a0
	move.w	34(a1),d2
	bsr.w	Copy_map_part
	subi.w	#Submap_width,d0
	movea.l	4(a1),a0
	move.w	34+4(a1),d2
	bsr.w	Copy_map_part
	subi.w	#Submap_height,d1
	movea.l	12(a1),a0
	move.w	34+12(a1),d2
	bsr.w	Copy_map_part
	addi.w	#Submap_width,d0
	movea.l	8(a1),a0
	move.w	34+8(a1),d2
	bra.w	Copy_map_part
; ---- Copy_map_part (original source: MAIN/MAP/2DWILD.ASM)
Copy_map_part:
	movem.l	d0-d3/d5-d7/a0-a3,-(sp)
	lea.l	Map_data(a0),a0
	lea.l	Underlay_buf,a1
	moveq.l	#10,d7
	moveq.l	#12,d6
	tst.w	d0
	bpl.s	.X_pos
	add.w	d0,d6
	neg.w	d0
	adda.w	d0,a1
	moveq.l	#0,d0
	bra.s	.Y_check
.X_pos:
	cmpi.w	#Submap_width-12,d0
	bmi.s	.Y_check
	move.w	#Submap_width-1,d3
	sub.w	d0,d3
	move.w	d3,d6
.Y_check:
	tst.w	d1
	bpl.s	.Y_pos
	add.w	d1,d7
	neg.w	d1
	mulu.w	#13,d1
	adda.w	d1,a1
	moveq.l	#0,d1
	bra.s	.Cont
.Y_pos:
	cmpi.w	#Submap_height-10,d1
	bmi.s	.Cont
	move.w	#Submap_height-1,d3
	sub.w	d1,d3
	move.w	d3,d7
.Cont:
	tst.w	d6
	bmi.s	.Exit
	tst.w	d7
	bmi.s	.Exit
	bsr.w	Enter_transport_icons
	move.w	Width_of_map,d2
	adda.w	d0,a0
	mulu.w	d2,d1
	adda.w	d1,a0
	move.w	Size_of_map,d0
	move.w	#13*11,d1
.Loop_1:
	movea.l	a0,a2
	movea.l	a1,a3
	move.w	d6,d5
.Loop_2:
	move.b	(a2)+,(a3)+
	move.b	-1(a2,d0.w),-1(a3,d1.w)
	dbra	d5,.Loop_2
	adda.w	d2,a0
	lea.l	13(a1),a1
	dbra	d7,.Loop_1
.Exit:
	movem.l	(sp)+,d0-d3/d5-d7/a0-a3
	rts	
; ---- Enter_transport_icons (original source: MAIN/MAP/2DWILD.ASM)
Enter_transport_icons:
	movem.l	d0-d7/a0-a2,-(sp)
	lea.l	429(a1),a2
	addq.w	#1,d0
	addq.w	#1,d1
	move.w	d0,d4
	move.w	d1,d5
	add.w	d0,d6
	add.w	d1,d7
	lea.l	Trans_T,a0
	lea.l	90(a0),a1
	moveq.l	#30-1,d3
.Loop:
	tst.b	(a0)
	beq.s	.Next
	cmp.w	(a1),d2
	bne.s	.Next
	moveq.l	#0,d0
	move.b	30(a0),d0
	moveq.l	#0,d1
	move.b	60(a0),d1
	cmp.w	d4,d0
	bmi.s	.Next
	cmp.w	d0,d6
	bmi.s	.Next
	cmp.w	d5,d1
	bmi.s	.Next
	cmp.w	d1,d7
	bmi.s	.Next
	sub.w	d4,d0
	sub.w	d5,d1
	mulu.w	#13,d1
	add.w	d0,d1
	moveq.l	#0,d0
	move.b	(a0),d0
	addi.w	#244,d0
	move.b	d0,0(a2,d1.w)
.Next:
	addq.l	#1,a0
	addq.l	#2,a1
	dbra	d3,.Loop
	movem.l	(sp)+,d0-d7/a0-a2
	rts	

	section	data

W2_CIL:
	dc.b	$2e,$01,$2d,$04,$07,$03,$30,$02,$2f,$00
D_1e1d6:
	dc.l	C2_upleft
	dc.l	C2_up
	dc.l	C2_upright
	dc.l	C2_left
	dc.l	Zzz
	dc.l	C2_right
	dc.l	C2_downleft
	dc.l	C2_down
	dc.l	C2_downright
D_1e1fa:
	dc.b	$ff,$00

	section	bss

World_X:
	ds.b	2
World_Y:
	ds.b	2
Quad_X:
	ds.b	2
Quad_Y:
	ds.b	2
Quad_index:
	ds.b	1
B_5795d:
	ds.b	1
Quad_map:
	ds.b	48
