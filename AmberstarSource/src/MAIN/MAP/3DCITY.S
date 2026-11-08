; MAIN/MAP/3DCITY.ASM (original module, merged with the disassembly of the shipped program)

	section	text

; ---- C3_ModInit (original source: MAIN/MAP/3DCITY.ASM)
; CHANGE: removed "Pop MA"
C3_ModInit:
	move.l	a5,Mapd_ptr
	bsr.w	Prepare_3D_map
	movea.l	Colpall_ptrs,a0
	lea.l	Skypal_buffer,a1
	jsr	IFF_pal_convert
	move.w	22(a1),d0
	move.w	d0,Old_11
	move.w	d0,Day_pal+166
	move.w	d0,Dawndusk_pal+166
	move.w	d0,Night_pal+166
	movea.l	Ceiling_ptr,a0
	lea.l	Bg_elements(a0),a0
	movea.l	a0,a1
	adda.l	(a1)+,a1
	addq.l	#4,a0
	addq.l	#4,a1
	lea.l	Night_pal,a2
	move.w	Hour,d0
	cmpi.w	#6,d0
	bmi.s	.End
	cmpi.w	#8,d0
	bpl.s	.Not_1
	lea.l	Dawndusk_pal,a2
	bra.s	.End
.Not_1:
	cmpi.w	#18,d0
	bpl.s	.Not_2
	lea.l	Day_pal,a2
	exg.l	a1,a0	; CHANGE: was "exg.l a0,a1"
	bra.s	.End
.Not_2:
	cmpi.w	#20,d0
	bpl.s	.End
	lea.l	Dawndusk_pal,a2
	exg.l	a1,a0	; CHANGE: was "exg.l a0,a1"
.End:
	move.l	a0,Sky_ptr
	lea.l	Skypal_buffer+32,a0
	lea.l	Sky_pal_C3+4,a1
	moveq.l	#83-1,d7
.Loop_2:
	move.w	(a2),(a0)+
	move.w	(a2)+,(a1)
	addq.l	#6,a1
	dbra	d7,.Loop_2
	bsr.w	Init_persons
	bsr.w	T_00208	; CHANGE: was "jsr C3_DisInit"
	bsr.w	C3_DisInit	; CHANGE: was "jsr Event_handler"
	bsr.w	Event_handler	; CHANGE: added
.Exit:
	rts	

; ---- C3_DisInit (original source: MAIN/MAP/3DCITY.ASM) - the shipped program differs, its code follows, not assembled:
;C3_DisInit:
;             movea.l   Mapd_ptr,a5          ; Get pointer to map data
;             jsr       Set_spell_area
;; ------------- Initialize display -----------------------------------
;             movea.l   Off_screen,a6        ; Get screen base
;             moveq.l   #5,d0                ; Show 2D map layout
;             jsr       Show_layout
;             jsr       Print_headline
;             move.l    #M3_CIL,First_CIL_ptr      ; Display control icons
;             jsr       Handle_CIL
;             jsr       Show_control_icons
;             jsr       C3_DisUpd            ; Display 3D map
;             Update_screen
;; ------------- Various installations --------------------------------
;             sf        Time_lock
;             lea.l     Lay5_c1,a0           ; Object branch
;             jsr       Set_layout_data
;             move.l    #M3_CIL+10,Mousemove_ptr   ; Mouse actions
;; ------------- Fade-in display --------------------------------------
;             lea.l     Skypal_buffer,a1     ; Fade in
;             lea.l     Subfade1,a2
;.Again:      lea.l     Hbl_C3_map,a0        ; Update palettes
;             jsr       Update_HBL
;             jsr       My_vsync             ; Wait 2 Vbl's
;             jsr       My_vsync
;             lea.l     Below_pal_C3,a0      ; Fade
;             jsr       List_fade
;             bne.s     .Again
;             lea.l     Hbl_C3_map,a0        ; Update palettes
;             jsr       Update_HBL
;             rts

C3_DisInit:
	sf.b	Time_lock
	movea.l	Mapd_ptr,a5
	bsr.w	Set_spell_area
	bsr.w	Set_map_music
	movea.l	Off_screen,a6
	moveq	#5,d0
	bsr.w	Show_layout
	bsr.w	Print_headline
	move.l	#M3_CIL,First_CIL_ptr
	bsr.w	Handle_CIL
	bsr.w	Show_control_icons
	st.b	B_5ac7e
	bsr.w	C3_DisUpd
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	Lay5_c1,a0
	bsr.w	Set_layout_data
	move.l	#D_1e17c,Mousemove_ptr
	lea.l	Skypal_buffer,a1
	lea.l	Subfade1,a2
.l_055d0:
	lea.l	Hbl_C3_map,a0
	jsr	Update_HBL
	jsr	My_vsync
	jsr	My_vsync
	lea.l	Below_pal_C3,a0
	jsr	List_fade
	bne.b	.l_055d0
	lea.l	Hbl_C3_map,a0
	jsr	Update_HBL
	rts
T_05604:
	bsr.w	T_00194
	bsr.w	Clear_persons_buffer
	jsr	Exit_automap
	movea.l	Mapd_ptr,a0
	jsr	Free_memory
	lea.l	Labblock_ptrs,a1
	move.w	Nr_labblocks,d7
.l_0562a:
	movea.l	(a1)+,a0
	jsr	Free_memory
	dbra	d7,.l_0562a
	movea.l	Ceiling_ptr,a0
	jsr	Free_memory
	movea.l	Floor_ptr,a0
	jsr	Free_memory
	movea.l	Colpall_ptrs,a0
	jsr	Free_memory
	movea.l	Maptext_ptr,a0
	jsr	Free_memory
	jsr	Next_generation
	rts
T_0566e:
	st.b	Time_lock
; ---- C3_DisExit (original source: MAIN/MAP/3DCITY.ASM)
C3_DisExit:
	lea.l	Void,a1
	lea.l	Subfade1,a2
.Again:
	lea.l	Hbl_C3_map,a0
	jsr	Update_HBL
	jsr	My_vsync
	jsr	My_vsync
	lea.l	Below_pal_C3,a0
	jsr	Hbl_outfade
	bne.s	.Again
	lea.l	Hbl_C3_map,a0
	jsr	Update_HBL
	rts	
; ---- C3_DisUpd (original source: MAIN/MAP/3DCITY.ASM)
C3_DisUpd:
	movem.l	d0-d3/d6/d7/a0/a6,-(sp)
	bsr.w	C3_time_evaluate
	bsr.w	Cut_from_3D_map
	move.w	Map_Xcoord,d2
	move.w	Map_Ycoord,d3
	eor.w	d3,d2
	andi.w	#$1,d2
	movea.l	Off_screen,a6
	movea.l	Sky_ptr,a0
	moveq.l	#Topleft_X,d0
	moveq.l	#Topleft_Y,d1
	move.w	(a0)+,d6
	addq.w	#1,d6
	lsr.w	#4,d6
	move.w	(a0)+,d7
	addq.w	#1,d7
	addq.l	#2,a0
	btst	#0,View_direction+1
	bne.s	.Mirror
	jsr	Blot_unmasked_block
	bra.s	.Cont
.Mirror:
	bsr.w	Blot_mirrored_unmasked_block
.Cont:
	movea.l	Floor_ptr,a0
	lea.l	Bg_elements+4(a0),a0
	move.w	#$c1,d1	; CHANGE: was "add.w d7,d1"
	move.w	(a0)+,d6
	addq.w	#1,d6
	lsr.w	#4,d6
	move.w	(a0)+,d7
	addq.w	#1,d7
	sub.w	d7,d1	; CHANGE: added
	addq.l	#2,a0
	tst.w	d2
	beq.s	.Mirror_L1
	jsr	Blot_unmasked_block
	bra.s	.Cont_L1
.Mirror_L1:
	bsr.w	Blot_mirrored_unmasked_block
.Cont_L1:
	tst.b	Pause_Upd
	bne.s	.Skip_L2
	bsr.w	ThreeD_char_handler
.Skip_L2:
	bsr.w	Build_3D_map
	bsr.w	Update_map_CIL
	tst.b	CombatReq
	beq.s	.Exit_L2
	lea.l	CombatReq_Mod,a0
	jsr	Push_Module
.Exit_L2:
	movem.l	(sp)+,d0-d3/d6/d7/a0/a6
	rts	
; ---- C3_time_evaluate (original source: MAIN/MAP/3DCITY.ASM)
C3_time_evaluate:
	movem.l	d0/a0-a2,-(sp)
	tst.b	Blending
	beq.s	.Check
	lea.l	Sky_pal_C3,a0
	movea.l	Blend_ptr,a1
	lea.l	Subfade1,a2
	jsr	List_fade
	sne	Blending
	bne.s	.Skip
	lea.l	Skypal_buffer+32,a0
	moveq.l	#83-1,d7
.Loop:
	move.w	(a1)+,(a0)+
	dbra	d7,.Loop
.Skip:
	lea.l	Hbl_C3_map,a0
	jsr	Update_HBL
	bra.w	.Exit
.Check:
	move.w	Hour,d0
	cmpi.w	#6,d0
	bne.s	.Not_1
	move.l	#Dawndusk_pal,Blend_ptr
	st	Blending
	bra.s	.Exit
.Not_1:
	cmpi.w	#8,d0
	bne.s	.Not_2
	movea.l	Ceiling_ptr,a0
	lea.l	Bg_elements(a0),a0
	adda.l	(a0)+,a0
	addq.l	#4,a0
	move.l	a0,Sky_ptr
	move.l	#Day_pal,Blend_ptr
	st	Blending
	bra.s	.Exit
.Not_2:
	cmpi.w	#18,d0
	bne.s	.Not_3
	move.l	#Dawndusk_pal,Blend_ptr
	st	Blending
	bra.s	.Exit
.Not_3:
	cmpi.w	#20,d0
	bne.s	.Exit
	movea.l	Ceiling_ptr,a0
	lea.l	Bg_elements+4(a0),a0
	move.l	a0,Sky_ptr
	move.l	#Night_pal,Blend_ptr
	st	Blending
.Exit:
	movem.l	(sp)+,d0/a0-a2
	rts	

; ---- Shadow_handler (original source: MAIN/MAP/SHADOW.ASM) - the shipped program differs, its code follows, not assembled:
;Shadow_handler:
;             movem.l   d0-d5/d7/a0-a4,-(sp)
;             tst.b     Shadow_flag          ; Display shadow ?
;             beq       .Exit
;             lea.l     Spiral_table,a0      ; Initialize registers
;             lea.l     Underlay_buf,a1
;             lea.l     Overlay_buf,a2
;             lea.l     Persons_buf,a3
;             movea.l   Iconstats_ptr,a5
;             moveq.l   #10,d2               ; Calculate boundaries
;             moveq.l   #0,d3
;             moveq.l   #8,d4
;             moveq.l   #0,d5
;             sub.w     Mapbuf_X,d2
;             sub.w     Mapbuf_X,d3
;             sub.w     Mapbuf_Y,d4
;             sub.w     Mapbuf_Y,d5
;             add.w     Half_X,d2
;             add.w     Half_X,d3
;             add.w     Half_Y,d4
;             add.w     Half_Y,d5
;             move.w    #219,d7              ; 220 entries in spiral
;.Loop:       move.b    (a0),d0              ; Load X
;             cmp.b     d2,d0                ; X too high ?
;             bgt.s     .Next
;             cmp.b     d3,d0                ; X too low ?
;             blt.s     .Next
;             move.b    1(a0),d1             ; Load Y
;             cmp.b     d4,d1                ; Y too high ?
;             bgt.s     .Next
;             cmp.b     d5,d1                ; Y too low ?
;             blt.s     .Next
;             jsr       Do_shadow            ; Yay!
;.Next:       addq.l    #2,a0                ; Next
;             dbra      d7,.Loop
;.Exit:       movem.l   (sp)+,d0-d5/d7/a0-a4
;             rts

Shadow_handler:
	movem.l	d0-d5/d7/a0-a6,-(a7)
	tst.b	D_1e1fc
	beq.w	.l_058c4
	lea.l	Spiral_table,a0
	lea.l	Underlay_buf,a1
	lea.l	Overlay_buf,a2
	lea.l	Persons_buf,a3
	movea.l	Iconstats_ptr,a5
	lea.l	Trans_buf,a6
	moveq	#10,d2
	moveq	#0,d3
	moveq	#8,d4
	moveq	#0,d5
	sub.w	Mapbuf_X,d2
	sub.w	Mapbuf_X,d3
	sub.w	Mapbuf_Y,d4
	sub.w	Mapbuf_Y,d5
	add.w	Half_X,d2
	add.w	Half_X,d3
	add.w	Half_Y,d4
	add.w	Half_Y,d5
	move.w	#$db,d7
.l_058a4:
	move.b	(a0),d0
	cmp.b	d2,d0
	bgt.b	.l_058be
	cmp.b	d3,d0
	blt.b	.l_058be
	move.b	$1(a0),d1
	cmp.b	d4,d1
	bgt.b	.l_058be
	cmp.b	d5,d1
	blt.b	.l_058be
	bsr.w	Do_shadow
.l_058be:
	addq.l	#$2,a0
	dbra	d7,.l_058a4
.l_058c4:
	movem.l	(a7)+,d0-d5/d7/a0-a6
	rts

	section	bss

Blending:
	ds.b	2
Blend_ptr:
	ds.b	4
Sky_ptr:
	ds.b	4
Skypal_buffer:
	ds.b	32
B_5a9ea:
	ds.b	166
Old_11:
	ds.b	2
B_5aa92:
	ds.b	2
B_5aa94:
	ds.b	2
