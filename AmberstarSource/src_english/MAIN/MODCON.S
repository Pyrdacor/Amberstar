; MAIN/MODCON.ASM (original module, merged with the disassembly of the shipped program)

	section	text

; ---- Init_display (original source: MAIN/MODCON.ASM)
Init_display:
	movem.l	d0-d7/a0-a6,-(sp)
	move.w	#$0,Draw_Cicon	; CHANGE: added
	jsr	My_vsync	; CHANGE: added
	movea.l	Module_sp,a1
	move.l	DisInit_ptr(a1),d0
	beq.s	.Exit
	movea.l	d0,a0
	jsr	(a0)
.Exit:
	movem.l	(sp)+,d0-d7/a0-a6
	rts	
; ---- Exit_display (original source: MAIN/MODCON.ASM)
Exit_display:
	movem.l	d0-d7/a0-a6,-(sp)
	move.w	#$0,Draw_Cicon	; CHANGE: added
	jsr	My_vsync	; CHANGE: added
	movea.l	Module_sp,a1
	move.l	DisExit_ptr(a1),d0
	beq.s	.Exit
	movea.l	d0,a0
	jsr	(a0)
.Exit:
	movem.l	(sp)+,d0-d7/a0-a6
	rts	
T_10936:
	movem.l	d0-d7/a0-a6,-(a7)
	st.b	Abort_list
.l_10940:
	movea.l	Module_sp,a1
	cmpa.l	#B_584f8,a1
	beq.b	.l_1096a
	lea.l	-$2e(a1),a0
	move.l	a0,Module_sp
	move.l	$18(a1),d0
	beq.b	.l_10962
	movea.l	d0,a0
	jsr	(a0)
.l_10962:
	jsr	Pop_Mptr
	bra.b	.l_10940
.l_1096a:
	movem.l	(a7)+,d0-d7/a0-a6
	rts

; ---- Push_Module (original source: MAIN/MODCON.ASM) - the shipped program differs, its code follows, not assembled:
;Push_Module:
;             movem.l   d0-d7/a0-a6,-(sp)
;             movea.l   Module_sp,a1
;             lea.l     ModuleDataSize(a1),a1      ; Increase module sp
;             cmpa.l    #End_of_module_stack,a1
;             bmi.s     .Not_full
;             ERROR     "[ Push_Module ] : Module stack overflow !!!"
;             bra.s     .Exit
;.Not_full:   move.l    a1,Module_sp
;             moveq.l   #(ModuleDataSize/2)-1,d7   ; Copy module data
;.Loop:       move.w    (a0)+,(a1)+
;             dbra      d7,.Loop
;             lea.l     -ModuleDataSize(a1),a1
;             st        Abort_list           ; Abort list
;             move.w    Mouse_ptr(a1),d0     ; Set new mouse pointer
;             jsr       Push_Mptr
;             move.l    ModInit_ptr(a1),d0   ; Call initialization routine
;             beq.s     .Exit
;             movea.l   d0,a0
;             jsr       (a0)
;.Exit:       movem.l   (sp)+,d0-d7/a0-a6
;             rts

Push_Module:
	movem.l	d0-d7/a0-a6,-(a7)
	move.w	#$0,Draw_Cicon
	jsr	My_vsync
	movea.l	Module_sp,a1
	lea.l	$2e(a1),a1
	cmpa.l	#Current_inventory_chardat_ptr,a1
	bmi.b	.l_109a2
	lea.l	D_2efbe,a1
	jsr	DI_Error
	bra.b	.l_109ce
.l_109a2:
	move.l	a1,Module_sp
	moveq	#22,d7
.l_109aa:
	move.w	(a0)+,(a1)+
	dbra	d7,.l_109aa
	lea.l	-$2e(a1),a1
	st.b	Abort_list
	move.w	$2c(a1),d0
	jsr	Push_Mptr
	move.l	$14(a1),d0
	beq.b	.l_109ce
	movea.l	d0,a0
	jsr	(a0)
.l_109ce:
	movem.l	(a7)+,d0-d7/a0-a6
	rts

; ---- Pop_Module (original source: MAIN/MODCON.ASM) - the shipped program differs, its code follows, not assembled:
;Pop_Module:
;             movem.l   d0-d7/a0-a6,-(sp)
;             movea.l   Module_sp,a1
;             cmpa.l    #Module_stack,a1
;             bpl.s     .Not_empty
;             ERROR     "[ Pop_Module ] : Module stack underflow !!!"
;             bra       .Exit
;.Not_empty:  lea.l     -ModuleDataSize(a1),a0     ; Decrease sp
;             move.l    a0,Module_sp
;             move.l    ModExit_ptr(a1),d0   ; Exit current module
;             beq.s     .Zero1
;             move.l    a1,-(sp)
;             movea.l   d0,a0
;             jsr       (a0)
;             movea.l   (sp)+,a1
;.Zero1:      st        Abort_list           ; Abort list
;             Pop       Mptr                 ; Previous mouse pointer
;             move.l    Return_ptr(a1),d0    ; Execute return routine
;             beq.s     .Exit
;             movea.l   d0,a0
;             jsr       (a0)
;.Exit:       movem.l   (sp)+,d0-d7/a0-a6
;             rts

Pop_Module:
	movem.l	d0-d7/a0-a6,-(a7)
	jsr	T_1ccb6
	move.w	#$0,Draw_Cicon
	jsr	My_vsync
	movea.l	Module_sp,a1
	cmpa.l	#B_584f8,a1
	bgt.b	.l_10a08
	lea.l	D_2efeb,a1
	jsr	DI_Error
	bra.b	.l_10a36
.l_10a08:
	lea.l	-$2e(a1),a0
	move.l	a0,Module_sp
	move.l	$18(a1),d0
	beq.b	.l_10a20
	move.l	a1,-(a7)
	movea.l	d0,a0
	jsr	(a0)
	movea.l	(a7)+,a1
.l_10a20:
	st.b	Abort_list
	jsr	Pop_Mptr
	move.l	$28(a1),d0
	beq.b	.l_10a36
	movea.l	d0,a0
	jsr	(a0)
.l_10a36:
	movem.l	(a7)+,d0-d7/a0-a6
	rts

; ---- Input_handler (original source: MAIN/MODCON.ASM) - the shipped program differs, its code follows, not assembled:
;Input_handler:
;             movem.l   d0-d2/a0,-(sp)
;             sf        Abort_list
;; ------------- Handle mouse input -----------------------------------
;             move.w    Mouse_X,d0           ; Get object ID
;             move.w    Mouse_Y,d1
;             jsr       Find_object
;             moveq.l   #0,d0                ; Create event ID
;             move.b    Mouse_unclick_state,d0     ; Button states
;             lsl.w     #2,d0
;             or.b      Mouse_click_state,d0
;             lsl.w     #2,d0
;             or.b      Mouse_button_state,d0
;             or.b      Mouse_click_state,d0 ; HA !
;             tst.w     X_trespass           ; Horizontal trespass ?
;             beq.s     .Skip1
;             bset      #6,d0
;.Skip1:      tst.w     Y_trespass           ; Vertical trespass ?
;             beq.s     .Skip2
;             bset      #7,d0
;.Skip2:      lsl.w     #8,d0                ; Object ID
;             swap.w    d0
;             or.l      d2,d0
;             clr.b     Mouse_click_state    ; Clear flags
;             clr.b     Mouse_unclick_state
;             movea.l   Module_sp,a0         ; Get pointer to Mev
;             move.l    Mev_ptr(a0),d1
;             beq.s     .No_Mev
;             movea.l   d1,a0
;             jsr       Handle_list
;.No_Mev:     tst.b     Abort_list
;             bne.s     .Exit
;; ------------- Handle key input -------------------------------------
;             jsr       Read_key             ; Read a key
;             tst.l     d0                   ; Key pressed ?
;             beq.s     .Exit
;             bset      #31,d0               ; Indicate key was pressed
;             movea.l   Module_sp,a0         ; Get pointer to Kev
;             move.l    Kev_ptr(a0),d1
;             beq.s     .Exit
;             movea.l   d1,a0
;             jsr       Handle_list
;.Exit:       movem.l   (sp)+,d0-d2/a0
;             rts

Input_handler:
	movem.l	d0-d2/a0,-(a7)
	sf.b	Abort_list
	move.w	Mouse_X,d0
	move.w	Mouse_Y,d1
	jsr	Find_object
	moveq	#0,d0
	move.b	Mouse_unclick_state,d0
	lsl.w	#$2,d0
	or.b	Mouse_click_state,d0
	lsl.w	#$2,d0
	or.b	Mouse_button_state,d0
	or.b	Mouse_click_state,d0
	lsl.w	#$8,d0
	swap	d0
	or.l	d2,d0
	clr.b	Mouse_click_state
	clr.b	Mouse_unclick_state
	movea.l	Module_sp,a0
	move.l	$c(a0),d1
	beq.b	.l_10a9a
	movea.l	d1,a0
	bsr.w	Handle_list
.l_10a9a:
	tst.b	Abort_list
	bne.b	.l_10ac2
	jsr	Read_key
	tst.l	d0
	beq.b	.l_10ac2
	bset	#$1f,d0
	movea.l	Module_sp,a0
	move.l	$10(a0),d1
	beq.b	.l_10ac2
	movea.l	d1,a0
	bsr.w	Handle_list
.l_10ac2:
	movem.l	(a7)+,d0-d2/a0
	rts
; ---- Handle_list (original source: MAIN/MODCON.ASM)
Handle_list:
	movem.l	d0-d7/a0-a6,-(sp)
.Again:
	tst.l	(a0)
	beq.s	.Exit
	move.l	(a0)+,d1
	and.l	d0,d1
	cmp.l	(a0)+,d1
	bne.s	.Next
	movem.l	d0/a0,-(sp)
	movea.l	(a0),a0
	jsr	(a0)
	movem.l	(sp)+,d0/a0
	tst.b	Abort_list
	bne.s	.Exit
.Next:
	addq.l	#4,a0
	bra.s	.Again
.Exit:
	movem.l	(sp)+,d0-d7/a0-a6
	rts	
; ---- ScrQ_handler (original source: MAIN/MODCON.ASM)
ScrQ_handler:
	movem.l	d0-d7/a0-a6,-(sp)
	movea.l	Module_sp,a0
	move.l	ScrQ_ptr(a0),d0
	beq.s	.Exit
	movea.l	d0,a0
.Loop:
	tst.l	(a0)
	beq.s	.Exit
	move.l	a0,-(sp)
	movea.l	(a0),a0
	jsr	(a0)
	movea.l	(sp)+,a0
	addq.l	#4,a0
	bra.s	.Loop
.Exit:
	movem.l	(sp)+,d0-d7/a0-a6
	rts	

; ---- VblQ_handler (original source: MAIN/MODCON.ASM) - the shipped program differs, its code follows, not assembled:
;VblQ_handler:
;             movem.l   d0-d7/a0-a6,-(sp)
;
;             move.l    DangerZone,d0
;             beq.s     .AllClear
;             movea.l   d0,a0
;             tst.l     (a0)
;             beq.s     .AllClear
;             ERROR     "Fatal error! Contact the programmer!"
;             illegal
;.AllClear:
;             movea.l   Module_sp,a0         ; Get pointer to Vbl Q
;             move.l    VblQ_ptr(a0),d0
;             beq.s     .Exit
;             movea.l   d0,a0
;.Loop:       tst.l     (a0)                 ; End of list ?
;             beq.s     .Exit
;             move.l    a0,-(sp)             ; Execute routine
;             movea.l   (a0),a0
;             jsr       (a0)
;             movea.l   (sp)+,a0
;             addq.l    #4,a0                ; Next entry
;             bra.s     .Loop
;.Exit:       movem.l   (sp)+,d0-d7/a0-a6
;             rts

; Calls the vertical blank routines of the module stack (the check of DangerZone was removed).
VblQ_handler:
	movem.l	d0-d7/a0-a6,-(a7)
	movea.l	Module_sp,a0
	move.l	$4(a0),d0
	beq.b	.l_10b40
	movea.l	d0,a0
.l_10b30:
	tst.l	(a0)
	beq.b	.l_10b40
	move.l	a0,-(a7)
	movea.l	(a0),a0
	jsr	(a0)
	movea.l	(a7)+,a0
	addq.l	#$4,a0
	bra.b	.l_10b30
.l_10b40:
	movem.l	(a7)+,d0-d7/a0-a6
	rts

	section	data

Module_sp:
	dc.l	Res_dat2_ptr

	section	bss

Abort_list:
	ds.b	2
B_584f8:
	ds.b	736
