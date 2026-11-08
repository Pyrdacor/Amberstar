; MAIN/MAP/3DDUNGEO.ASM (original module, merged with the disassembly of the shipped program)

; ---- D3_ModInit (original source: MAIN/MAP/3DDUNGEO.ASM)
; CHANGE: removed "Pop MA"
D3_ModInit:
	move.l	a5,Mapd_ptr
	bsr.w	Prepare_3D_map
	bsr.w	Init_persons
	bsr.w	T_00208	; CHANGE: was "jsr D3_DisInit"
	bsr.w	D3_DisInit	; CHANGE: was "jsr Event_handler"
	bsr.w	Event_handler	; CHANGE: added
	rts	
D3_DisInit:
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
	bsr.w	D3_DisUpd
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	Lay5_c1,a0
	bsr.w	Set_layout_data
	move.l	#D_1e17c,Mousemove_ptr
	movea.l	Colpall_ptrs,a0
	lea.l	Pal_buffer,a1
	jsr	IFF_pal_convert
	lea.l	Subfade1,a2
T_05324:
	lea.l	Hbl_D3_map,a0
	jsr	Update_HBL
	jsr	My_vsync
	jsr	My_vsync
	lea.l	Below_pal_D3,a0
	jsr	Fade_pal
	bne.b	T_05324
	lea.l	Hbl_D3_map,a0
	jsr	Update_HBL
	rts
T_05358:
	bsr.w	T_00194
; ---- D3_ModExit (original source: MAIN/MAP/3DDUNGEO.ASM)
C3_ModExit:
D3_ModExit:
	bsr.w	Clear_persons_buffer
	jsr	Exit_automap
	movea.l	Mapd_ptr,a0
	jsr	Free_memory
	lea.l	Labblock_ptrs,a1
	move.w	Nr_labblocks,d7
.Loop:
	movea.l	(a1)+,a0
	jsr	Free_memory
	dbra	d7,.Loop
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
T_053c2:
	st.b	Time_lock
; ---- D3_DisExit (original source: MAIN/MAP/3DDUNGEO.ASM)
D3_DisExit:
	lea.l	Void,a1
	lea.l	Subfade1,a2
.Again:
	lea.l	Hbl_D3_map,a0
	jsr	Update_HBL
	jsr	My_vsync
	jsr	My_vsync
	lea.l	Below_pal_D3,a0
	jsr	Fade_pal
	bne.s	.Again
	lea.l	Hbl_D3_map,a0
	jsr	Update_HBL
	rts	
D3_DisUpd:
	movem.l	d0-d3/d6-d7/a0/a6,-(a7)
	bsr.w	Cut_from_3D_map
	move.w	Map_Xcoord,d2
	move.w	Map_Ycoord,d3
	eor.w	d3,d2
	andi.w	#$1,d2
	movea.l	Off_screen,a6
	movea.l	Ceiling_ptr,a0
	lea.l	$a(a0),a0
	moveq	#32,d0
	moveq	#49,d1
	move.w	(a0)+,d6
	addq.w	#$1,d6
	lsr.w	#$4,d6
	move.w	(a0)+,d7
	addq.w	#$1,d7
	addq.l	#$2,a0
	tst.w	d2
	bne.b	T_0544e
	jsr	Blot_unmasked_block
	bra.b	T_05452
T_0544e:
	bsr.w	Blot_mirrored_unmasked_block
T_05452:
	movea.l	Floor_ptr,a0
	lea.l	$a(a0),a0
	move.w	#$c1,d1
	move.w	(a0)+,d6
	addq.w	#$1,d6
	lsr.w	#$4,d6
	move.w	(a0)+,d7
	addq.w	#$1,d7
	sub.w	d7,d1
	addq.l	#$2,a0
	tst.w	d2
	beq.b	T_0547a
	jsr	Blot_unmasked_block
	bra.b	T_0547e
T_0547a:
	bsr.w	Blot_mirrored_unmasked_block
T_0547e:
	tst.b	Pause_Upd
	bne.b	T_0548a
	bsr.w	ThreeD_char_handler
T_0548a:
	bsr.w	Build_3D_map
	bsr.w	Update_map_CIL
	tst.b	CombatReq
	beq.b	T_054a6
	lea.l	CombatReq_Mod,a0
	jsr	Push_Module
T_054a6:
	movem.l	(a7)+,d0-d3/d6-d7/a0/a6
	rts
