; MAIN/STATUS.ASM (original module, merged with the disassembly of the shipped program)

	section	text


; ---- Help (original source: MAIN/STATUS.ASM) - only in the debug build, not assembled:
;Help:
;             DIAG_ON
;             lea.l     Help_msg,a0          ; Print help message
;             jsr       DI_Print
;             jsr       Wait_4_key
;             DIAG_OFF
;             rts                            ; Return

; ---- Status_F1 (original source: MAIN/STATUS.ASM) - only in the debug build, not assembled:
;Status_F1:
;             DIAG_ON
;             PRINT     "[ AMBERSTAR STATUS SCREEN ]"        ; Header
;             PRINTNR   "  Map number : ",Dec,w,Map_nr       ; Status display
;             CR
;             PRINTNR   "X coordinate : ",Dec,w,Map_Xcoord
;             CR
;             PRINTNR   "Y coordinate : ",Dec,w,Map_Ycoord
;             CR
;             CR
;             PRINTNR   "View direction : ",Dec,w,View_direction
;             CR
;             PRINTNR   "   Travel mode : ",Dec,w,Travel_mode
;             CR
;             cmpi.b    #1,Current_map_type  ; Wilderness ?
;             bne.s     .Skip
;             CR
;             PRINTNR   "World X : ",Dec,w,World_X
;             CR
;             PRINTNR   "World Y : ",Dec,w,World_Y
;             CR
;.Skip:       CR
;             PRINTNR   "  Year : ",Dec,w,Year
;             CR
;             PRINTNR   " Month : ",Dec,w,Month
;             CR
;             PRINTNR   "   Day : ",Dec,w,Day
;             CR
;             PRINTNR   "  Hour : ",Dec,w,Hour
;             CR
;             PRINTNR   "Minute : ",Dec,w,Minute
;             CR
;             PRINTNR   " Frame : ",Dec,w,Frame
;             CR
;             CR
;             PRINTNR   "Number of members in party : ",Dec,w,Nr_members
;             CR
;             CR
;             PRINT     "[ Press any key to exit ]"          ; Footer
;             jsr       Wait_4_key
;             DIAG_OFF
;             rts                            ; Return

; ---- Status_F2 (original source: MAIN/STATUS.ASM) - only in the debug build, not assembled:
;Status_F2:
;             jmp       Show_memory

; ---- Status_F3 (original source: MAIN/STATUS.ASM) - only in the debug build, not assembled:
;Status_F3:
;             DIAG_ON
;             PRINT     "[ VIEW FREE MEMORY ]"     ; Header
;             CR
;             PRINTNR   "        Size of free memory : ",Dec,l,Size_of_free_memory
;             CR
;             move.l    Total_size,d0
;             sub.l     Size_of_free_memory,d0
;             move.l    d0,d1
;             PRINTNR   "                Memory used : ",Dec,l,d0
;             CR
;             CR
;             movea.l   Basepage,a1
;             PRINTNR   "       Size of TEXT segment : ",Dec,l,P_tlen(a1)
;             CR
;             PRINTNR   "       Size of DATA segment : ",Dec,l,P_dlen(a1)
;             CR
;             PRINTNR   "       Size of  BSS segment : ",Dec,l,P_blen(a1)
;             CR
;             CR
;             move.l    #256,d0
;             add.l     P_tlen(a1),d0
;             add.l     P_dlen(a1),d0
;             add.l     P_blen(a1),d0
;             PRINTNR   "      Total size of program : ",Dec,l,d0
;             CR
;             CR
;             add.l     d1,d0
;             PRINTNR   "Total amount of memory used : ",Dec,l,d0
;             CR
;             CR
;             PRINT     "[ Press any key to exit ]"          ; Footer
;             jsr       Wait_4_key
;             DIAG_OFF
;             rts

; ---- Status_F4 (original source: MAIN/STATUS.ASM) - only in the debug build, not assembled:
;Status_F4:
;             DIAG_ON
;             PRINT     "[ VIEW MODIFICATION INFO ]"         ; Header
;             CR
;             move.w    Nr_of_modifications,d7
;             PRINTNR   "Number of modifications : ",Dec,w,d7
;             CR
;             CR
;             movea.l   Modifications_ptr,a1
;             bra.s     .Entry
;.Loop:       PRINTNR   "> ",Dec,w,(a1)+
;             PRINTNR   ",",Dec,b,(a1)+
;             PRINTNR   ",",Dec,b,(a1)+
;             PRINTNR   ",",Dec,w,(a1)+
;             CR
;.Entry:      dbra      d7,.Loop
;             CR
;             PRINT     "[ Press any key to exit ]"          ; Footer
;             jsr       Wait_4_key
;             DIAG_OFF
;             rts

; ---- Status_F5 (original source: MAIN/STATUS.ASM) - only in the debug build, not assembled:
;Status_F5:
;             DIAG_ON
;             PRINT     "[ VIEW MODULE STACK ]"    ; Header
;             CR
;             lea.l     Module_stack,a1
;             movea.l   Module_sp,a2
;             bra.s     .Entry
;.Loop:       movea.l   IDString_ptr(a1),a0  ; Print ID string
;             jsr       DI_Print
;             CR
;             lea.l     ModuleDataSize(a1),a1      ; Next module
;.Entry:      cmpa.l    a1,a2
;             bhi.s     .Loop
;             PRINT     .Blue
;             movea.l   IDString_ptr(a1),a0  ; Print last ID string
;             jsr       DI_Print
;             PRINT     .White
;             CR
;             PRINT     "[ Press any key to exit ]"          ; Footer
;             jsr       Wait_4_key
;             DIAG_OFF
;             rts
;
;.Blue:       .DC.b 3,2,0
;.White:      .DC.b " <- ACTIVE.",3,1,13,0
;             .EVEN

; ---- Status_F6 (original source: MAIN/STATUS.ASM) - only in the debug build, not assembled:
;Status_F6:
;             DIAG_ON
;             PRINT     "[ INCREASE EXPERIENCE POINTS ]"     ; Header
;             CR
;             movea.l   Current_active_char_data,a1
;             PRINTNR   "Current experience points : ",Dec,l,Experience_points(a1)
;             CR
;.Again1:     INPUT     "Enter extra amount : "
;             tst.l     d0                   ; Error check
;             bmi.s     .Exit
;             beq.s     .Again1
;             add.l     d0,Experience_points(a1)   ; Store
;.Exit:       DIAG_OFF
;             rts                            ; Return

; ---- Status_F7 (original source: MAIN/STATUS.ASM) - only in the debug build, not assembled:
;Status_F7:
;             jsr       Exit_display
;             Push      Module,Minimap_Mod
;             rts

; ---- Status_F8 (original source: MAIN/STATUS.ASM) - only in the debug build, not assembled:
;Status_F8:
;             DIAG_ON
;             PRINT     "[ CHANGE MAP ]"     ; Header
;             CR
;.Again:      INPUT     "Enter new map : "
;             tst.l     d0                   ; Error check
;             bmi.s     .Exit
;             beq.s     .Again
;             move.w    d0,New_map
;             DIAG_OFF
;             jsr       Exit_map             ; Change map
;             move.w    New_map,Map_nr
;             move.w    #7,Map_Xcoord
;             move.w    #7,Map_Ycoord
;             move.w    #0,View_direction
;             jsr       Init_map
;             rts
;.Exit:       DIAG_OFF
;             rts

; ---- Status_F9 (original source: MAIN/STATUS.ASM) - only in the debug build, not assembled:
;Status_F9:
;             DIAG_ON
;             PRINT     "[ SAVE NEO PICTURE ]"     ; Header
;             CR
;             INPUT     "Enter 4-digit identifier ('AMBR????.NEO') : "
;             CR
;             tst.w     d0
;             bmi       .Exit
;             move.w    #"0",d1              ; Insert number in filenames
;             moveq.l   #4,d7
;             lea.l     Picture_filename+4,a3
;             jsr       RConvert_number
;             lea.l     Raster_filename+4,a3
;             jsr       RConvert_number
;; ------------- Make & save picture file -----------------------------
;             PRINT     "Creating picture..."
;             CR
;             move.l    #32128,d0            ; Make buffer
;             jsr       Allocate_memory
;             movea.l   a1,a2
;             moveq.l   #32-1,d7             ; Clear first 128 bytes
;.Loop1:      clr.l     (a1)+
;             dbra      d7,.Loop1
;             movea.l   User_HBL_list,a1     ; Copy palette
;             addq.l    #2,a1
;             movem.l   (a1),d0-d7
;             movem.l   d0-d7,4(a2)
;             move.l    #"NEO!",124(a2)      ; Insert magic longword
;             moveq.l   #0,d0                ; Copy screen to file buffer
;             moveq.l   #0,d1
;             moveq.l   #20,d6
;             move.w    #200,d7
;             movea.l   On_screen,a0
;             lea.l     128(a2),a1
;             jsr       Duplicate_block
;             move.l    #32128,d0            ; Save file
;             lea.l     Picture_filename,a0
;             movea.l   a2,a1
;             jsr       Save_file
;             PRINT     "Picture has been saved."
;             CR
;             movea.l   a2,a0                ; De-allocate file buffer
;             jsr       Free_memory
;; ------------- Make & save raster file ------------------------------
;             PRINT     "Creating raster file..."
;             CR
;             move.l    #6800,d0             ; Make buffer
;             jsr       Allocate_memory
;             movea.l   a1,a2
;             movea.l   a1,a0                ; Clear buffer
;             move.w    #1700-1,d7
;.Loop2:      clr.l     (a0)+
;             dbra      d7,.Loop2
;             movea.l   User_HBL_list,a0     ; Get pointer to HBL list
;             addq.l    #2,a0
;             move.w    #0,(a1)+             ; Write first Y-offset
;             bra.s     .Entry
;.Again:      tst.w     (a0)                 ; End of list ?
;             beq.s     .End
;             moveq.l   #0,d0                ; Write Y-offset
;             move.b    (a0)+,d0
;             move.w    d0,(a1)+
;             tst.b     (a0)+                ; Palette or single colour ?
;             bne.s     .Single
;.Entry:      moveq.l   #8-1,d7              ; Write palette
;.Loop3:      move.l    (a0)+,(a1)+
;             dbra      d7,.Loop3
;             bra.s     .Again
;.Single:     movea.l   a1,a3                ; Copy previous palette
;             moveq.l   #8-1,d7
;.Loop4:      move.l    -34(a3),(a3)+
;             dbra      d7,.Loop4
;             move.w    (a0)+,d0             ; Write altered colour
;             add.w     d0,d0
;             move.w    (a0)+,0(a1,d0.w)
;             lea.l     32(a1),a1
;             bra.s     .Again
;.End:        move.l    #6800,d0             ; Save file
;             lea.l     Raster_filename,a0
;             movea.l   a2,a1
;             jsr       Save_file
;             PRINT     "Raster-file has been saved."
;             CR
;             movea.l   a2,a0                ; De-allocate file buffer
;             jsr       Free_memory
;             PRINT     "[ Press any key to exit ]"          ; Footer
;             jsr       Wait_4_key
;.Exit:       DIAG_OFF
;             rts

; ---- Status_F0 (original source: MAIN/STATUS.ASM)
Status_F0:
	move.w	Travel_mode,d0
	tst.w	d0
	beq.s	.On
	moveq.l	#0,d0
	bra.s	.Exit
.On:
	moveq.l	#6,d0
.Exit:
	bsr.w	Set_new_travel_mode
	rts	

; ---- Show_memory (original source: MAIN/STATUS.ASM) - only in the debug build, not assembled:
;Show_memory::
;             DIAG_ON
;             PRINT     .White
;             lea.l     Memory_list,a1       ; Ptr = Start
;             movea.l   Memlist_end,a2
;.Loop:       btst      #7,8(a1)             ; Free or allocated ?
;             bne.s     .Next
;.Continue:   PRINTNR   ,Hex,l,0(a1)         ; Print start & length
;             PRINTNR   ,Dec,l,4(a1)
;             lea.l     Memory_types,a3      ; Print type
;             moveq.l   #$7f,d0
;             and.b     8(a1),d0
;             add.w     d0,d0
;             add.w     d0,d0
;             movea.l   0(a3,d0.w),a3
;             PRINT     (a3)
;             tst.w     d0                   ; Memory block ?
;             beq.s     .Skip
;             move.w    10(a1),d0            ; Print subfile number
;             addq.w    #1,d0
;             PRINTNR   ,Dec,w,d0
;.Skip:       CR
;.Next:       lea.l     12(a1),a1            ; Increase Ptr
;             cmpa.l    a2,a1                ; While Ptr < End
;             bmi.s     .Loop
;.Exit:       jsr       Wait_4_key
;             DIAG_OFF
;             rts
;
;.Blue:       .DC.b 3,2,0
;.White:      .DC.b 3,1,0
;             .EVEN

T_019d6:
	tst.b	D_1dc92
	beq.w	.l_01af8
	st.b	Time_lock
	movem.l	d0-d7/a0-a6,-(a7)
	jsr	ON_Diag_screen
	jsr	DI_Cursor_home
	movea.l	Screen_base,a6
	lea.l	D_2ec30,a0
	jsr	DI_Print
	jsr	DI_Carriage_return
	lea.l	Chard_ptrs,a0
	moveq	#5,d7
.l_01a16:
	tst.l	(a0)
	beq.w	.l_01aca
	movea.l	(a0),a1
	lea.l	$22(a1),a2
	lea.l	Inv_data(a1),a3
	moveq	#0,d1
	moveq	#20,d6
.l_01a2a:
	moveq	#0,d0
	move.b	(a2)+,d0
	beq.b	.l_01a36
	mulu.w	$22(a3),d0
	add.l	d0,d1
.l_01a36:
	lea.l	$28(a3),a3
	dbra	d6,.l_01a2a
	moveq	#0,d0
	move.w	Gold_coins(a1),d0
	mulu.w	#$a,d0
	add.l	d0,d1
	moveq	#0,d0
	move.w	Food_rations(a1),d0
	mulu.w	#$fa,d0
	add.l	d0,d1
	move.l	Weight_normal(a1),d0
	cmp.l	d0,d1
	beq.b	.l_01aca
	move.l	a0,-(a7)
	lea.l	D_2ec42,a0
	jsr	DI_Print
	lea.l	Char_name(a1),a0
	jsr	DI_Print
	jsr	DI_Carriage_return
	lea.l	D_2ec4d,a0
	jsr	DI_Print
	jsr	DI_Carriage_return
	lea.l	D_2ec67,a0
	jsr	DI_Print
	move.l	d0,d0
	jsr	DI_Decl_print
	jsr	DI_Carriage_return
	lea.l	D_2ec7c,a0
	jsr	DI_Print
	move.l	d1,d0
	jsr	DI_Decl_print
	jsr	DI_Carriage_return
	jsr	DI_Carriage_return
	movea.l	(a7)+,a0
.l_01aca:
	addq.l	#$4,a0
	dbra	d7,.l_01a16
	jsr	DI_Carriage_return
	lea.l	D_2ec91,a0
	jsr	DI_Print
	jsr	Wait_4_key
	jsr	OFF_Diag_screen
	movem.l	(a7)+,d0-d7/a0-a6
	sf.b	Time_lock
.l_01af8:
	rts
T_01afa:
	tst.b	D_1dc92
	beq.b	.l_01b24
	movea.l	Current_active_char_data,a1
	clr.w	Body_conditions(a1)
	move.w	Life_points_max(a1),d0
	add.w	Life_points_max_magic(a1),d0
	move.w	d0,Life_points_normal(a1)
	move.w	Power_points_max(a1),d0
	add.w	Power_points_max_magic(a1),d0
	move.w	d0,Power_points_normal(a1)
.l_01b24:
	rts
T_01b26:
	tst.b	D_1dc92
	beq.b	.l_01b3a
	lea.l	D_2d860,a0
	jsr	Push_Module
.l_01b3a:
	rts
T_01b3c:
	tst.b	D_1dc92
	beq.b	.l_01b82
	movea.l	Current_active_char_data,a0
	move.b	#$8e,Spell_class_counter(a0)
	move.l	#$ffffffff,Spells_class_1(a0)
	move.l	#$ffffffff,Spells_class_2(a0)
	move.l	#$ffffffff,Spells_class_3(a0)
	move.l	#$ffffffff,Spells_class_7(a0)
	move.w	#$1f4,Power_points_normal(a0)
	move.w	#$1f4,Power_points_max(a0)
	move.b	#$63,Skill_10(a0)
.l_01b82:
	rts
T_01b84:
	tst.b	D_1dc92
	beq.b	.l_01ba0
	move.w	Travel_mode,d0
	addq.w	#$1,d0
	cmpi.w	#$7,d0
	bmi.b	.l_01b9c
	moveq	#0,d0
.l_01b9c:
	bsr.w	Set_new_travel_mode
.l_01ba0:
	rts
T_01ba2:
	tst.b	D_1dc92
	beq.b	.l_01bb0
	jmp	T_1a212
.l_01bb0:
	rts
T_01bb2:
	tst.b	D_1dc92
	beq.w	.l_01c46
	st.b	Time_lock
	movem.l	d0-d7/a0-a6,-(a7)
	jsr	ON_Diag_screen
	jsr	DI_Cursor_home
	movea.l	Screen_base,a6
	lea.l	D_2ecac,a0
	jsr	DI_Print
	jsr	DI_Carriage_return
	movea.l	Current_active_char_data,a1
	lea.l	D_2ecc5,a0
	jsr	DI_Print
	move.w	Gold_coins(a1),d0
	jsr	DI_Decw_print
	jsr	DI_Carriage_return
.l_01c0c:
	lea.l	D_2ecdb,a0
	jsr	DI_Input
	tst.l	d0
	bmi.b	.l_01c36
	beq.b	.l_01c0c
	moveq	#0,d1
	move.w	Gold_coins(a1),d1
	add.w	d0,d1
	bvs.b	.l_01c0c
	move.w	d0,d1
	mulu.w	#$a,d1
	add.l	d1,Weight_normal(a1)
	add.w	d0,Gold_coins(a1)
.l_01c36:
	jsr	OFF_Diag_screen
	movem.l	(a7)+,d0-d7/a0-a6
	sf.b	Time_lock
.l_01c46:
	rts
T_01c48:
	tst.b	D_1dc92
	beq.w	.l_01d8c
	st.b	Time_lock
	movem.l	d0-d7/a0-a6,-(a7)
	jsr	ON_Diag_screen
	jsr	DI_Cursor_home
	movea.l	Screen_base,a6
	lea.l	D_2ecf1,a0
	jsr	DI_Print
	jsr	DI_Carriage_return
	movea.l	Event_data_ptr,a1
	lea.l	D_2ed06,a0
	jsr	DI_Print
	move.b	(a1),d0
	jsr	DI_Decb_print
	jsr	DI_Carriage_return
	lea.l	D_2ed10,a0
	jsr	DI_Print
	move.b	$1(a1),d0
	jsr	DI_Decb_print
	jsr	DI_Carriage_return
	lea.l	D_2ed1a,a0
	jsr	DI_Print
	move.b	$2(a1),d0
	jsr	DI_Decb_print
	jsr	DI_Carriage_return
	lea.l	D_2ed24,a0
	jsr	DI_Print
	move.b	$3(a1),d0
	jsr	DI_Decb_print
	jsr	DI_Carriage_return
	lea.l	D_2ed2e,a0
	jsr	DI_Print
	move.b	$4(a1),d0
	jsr	DI_Decb_print
	jsr	DI_Carriage_return
	lea.l	D_2ed38,a0
	jsr	DI_Print
	move.w	$6(a1),d0
	jsr	DI_Decw_print
	jsr	DI_Carriage_return
	lea.l	D_2ed42,a0
	jsr	DI_Print
	move.w	$8(a1),d0
	jsr	DI_Decw_print
	jsr	DI_Carriage_return
	lea.l	D_2ed4c,a0
	jsr	DI_Print
	move.b	$5(a1),d0
	jsr	DI_Decb_print
	jsr	DI_Carriage_return
	jsr	DI_Carriage_return
	lea.l	D_2ed56,a0
	jsr	DI_Print
	jsr	Wait_4_key
	jsr	OFF_Diag_screen
	movem.l	(a7)+,d0-d7/a0-a6
	sf.b	Time_lock
.l_01d8c:
	rts
T_01d8e:
	tst.b	D_1dc92
	beq.b	.l_01de0
	st.b	Time_lock
	movem.l	d0-d7/a0-a6,-(a7)
	jsr	ON_Diag_screen
	jsr	DI_Cursor_home
	movea.l	Screen_base,a6
	lea.l	D_2ed71,a0
	jsr	DI_Print
	move.w	Active_member,d0
	jsr	DI_Decw_print
	jsr	Wait_4_key
	jsr	OFF_Diag_screen
	movem.l	(a7)+,d0-d7/a0-a6
	sf.b	Time_lock
.l_01de0:
	rts
T_01de2:
	st.b	Time_lock
	movem.l	d0-d7/a0-a6,-(a7)
	jsr	ON_Diag_screen
	jsr	DI_Cursor_home
	movea.l	Screen_base,a6
	lea.l	Memory_list,a1
	movea.l	Memlist_end,a2
.l_01e0a:
	btst	#$7,$8(a1)
	bne.b	.l_01e5a
	move.l	$0(a1),d0
	jsr	T_1c2de
	move.l	$4(a1),d0
	jsr	DI_Decl_print
	lea.l	Memory_types,a3
	moveq	#127,d0
	and.b	$8(a1),d0
	add.w	d0,d0
	add.w	d0,d0
	movea.l	(a3,d0.w),a3
	lea.l	(a3),a0
	jsr	DI_Print
	tst.w	d0
	beq.b	.l_01e54
	move.w	$a(a1),d0
	addq.w	#$1,d0
	move.w	d0,d0
	jsr	DI_Decw_print
.l_01e54:
	jsr	DI_Carriage_return
.l_01e5a:
	lea.l	$c(a1),a1
	cmpa.l	a2,a1
	bmi.b	.l_01e0a
	jsr	Wait_4_key
	lea.l	Memory_list,a1
	movea.l	Memlist_end,a2
	move.l	B_5da0c,d0
.l_01e7a:
	btst	#$7,$8(a1)
	bne.b	.l_01e86
	sub.l	$4(a1),d0
.l_01e86:
	lea.l	$c(a1),a1
	cmpa.l	a2,a1
	bmi.b	.l_01e7a
	sub.l	Size_of_free_memory,d0
	beq.b	.l_01eb8
	lea.l	D_2ed82,a0
	jsr	DI_Print
	lea.l	D_2ed96,a0
	jsr	DI_Print
	move.l	d0,d0
	jsr	DI_Decl_print
	bra.b	.l_01ec4
.l_01eb8:
	lea.l	D_2eda4,a0
	jsr	DI_Print
.l_01ec4:
	jsr	Wait_4_key
	jsr	OFF_Diag_screen
	movem.l	(a7)+,d0-d7/a0-a6
	sf.b	Time_lock
	rts

	section	data

Picture_filename:
	dc.b	$00,$41,$4d,$42
D_1dc97:
	dc.b	$52,$6e,$6e,$6e,$6e,$2e,$4e,$45,$4f,$00
Raster_filename:
	dc.b	$00,$41,$4d,$42
D_1dca5:
	dc.b	$52,$6e,$6e,$6e,$6e,$2e,$52,$53,$54,$00
D_1dcaf:
	dc.b	$03,$02,$41,$4d,$42,$45,$52,$53,$54,$41,$52,$03,$01,$20,$48,$45
	dc.b	$4c,$50,$20,$53,$43,$52,$45,$45,$4e,$20,$0d,$03,$02,$20,$5b,$20
	dc.b	$51,$20,$5d,$03,$01,$20,$2d,$20,$53,$74,$61,$74,$75,$73,$20,$73
	dc.b	$63,$72,$65,$65,$6e,$2e,$0d,$03,$02,$20,$5b,$20,$57,$20,$5d,$03
	dc.b	$01,$20,$2d,$20,$56,$69,$65,$77,$20,$61,$6c,$6c,$6f,$63,$61,$74
	dc.b	$65,$64,$20,$6d,$65,$6d,$6f,$72,$79,$2e,$0d,$03,$02,$20,$5b,$20
	dc.b	$45,$20,$5d,$03,$01,$20,$2d,$20,$56,$69,$65,$77,$20,$66,$72,$65
	dc.b	$65,$20,$6d,$65,$6d,$6f,$72,$79,$2e,$0d,$03,$02,$20,$5b,$20,$52
	dc.b	$20,$5d,$03,$01,$20,$2d,$20,$56,$69,$65,$77,$20,$6d,$6f,$64,$69
	dc.b	$66,$69,$63,$61,$74,$69,$6f,$6e,$20,$69,$6e,$66,$6f,$2e,$0d,$03
	dc.b	$02,$20,$5b,$20,$54,$20,$5d,$03,$01,$20,$2d,$20,$56,$69,$65,$77
	dc.b	$20,$6d,$6f,$64,$75,$6c,$65,$20,$73,$74,$61,$63,$6b,$2e,$0d,$03
	dc.b	$02,$20,$5b,$20,$5a,$20,$5d,$03,$01,$20,$2d,$20,$49,$6e,$63,$72
	dc.b	$65,$61,$73,$65,$20,$65,$78,$70,$65,$72,$69,$65,$6e,$63,$65,$20
	dc.b	$70,$6f,$69,$6e,$74,$73,$2e,$0d,$03,$02,$20,$5b,$20,$55,$20,$5d
	dc.b	$03,$01,$20,$2d,$20,$56,$69,$65,$77,$20,$6d,$61,$70,$2e,$0d,$03
	dc.b	$02,$20,$5b,$20,$49,$20,$5d,$03,$01,$20,$2d,$20,$43,$68,$61,$6e
	dc.b	$67,$65,$20,$6d,$61,$70,$2e,$0d,$03,$02,$20,$5b,$20,$4f,$20,$5d
	dc.b	$03,$01,$20,$2d,$20,$53,$61,$76,$65,$20,$4e,$45,$4f,$2d,$70,$69
	dc.b	$63,$74,$75,$72,$65,$2e,$0d,$03,$02,$20,$5b,$20,$50,$20,$5d,$03
	dc.b	$01,$20,$2d,$20,$54,$6f,$67,$67,$6c,$65,$20,$53,$75,$70,$65,$72
	dc.b	$63,$68,$69,$63,$6b,$65,$6e,$20,$6d,$6f,$64,$65,$2e,$0d,$0d,$03
	dc.b	$02,$20,$5b,$20,$41,$20,$5d,$03,$01,$20,$2d,$20,$54,$65,$73,$74
	dc.b	$20,$77,$65,$69,$67,$68,$74,$2e,$0d,$03,$02,$20,$5b,$20,$53,$20
	dc.b	$5d,$03,$01,$20,$2d,$20,$52,$65,$76,$69,$76,$65,$20,$61,$63,$74
	dc.b	$69,$76,$65,$20,$63,$68,$61,$72,$61,$63,$74,$65,$72,$2e,$0d,$03
	dc.b	$02,$20,$5b,$20,$44,$20,$5d,$03,$01,$20,$2d,$20,$53,$65,$6c,$65
	dc.b	$63,$74,$20,$6d,$75,$73,$69,$63,$2e,$0d,$03,$02,$20,$5b,$20,$46
	dc.b	$20,$5d,$03,$01,$20,$2d,$20,$43,$68,$65,$61,$74,$20,$73,$70,$65
	dc.b	$6c,$6c,$73,$2e,$0d,$03,$02,$20,$5b,$20,$47,$20,$5d,$03,$01,$20
	dc.b	$2d,$20,$43,$79,$63,$6c,$65,$20,$74,$68,$72,$6f,$75,$67,$68,$20
	dc.b	$74,$72,$61,$76,$65,$6c,$6d,$6f,$64,$65,$73,$2e,$0d,$03,$02,$20
	dc.b	$5b,$20,$48,$20,$5d,$03,$01,$20,$2d,$20,$54,$65,$73,$74,$20,$67
	dc.b	$61,$72,$62,$61,$67,$65,$20,$63,$6f,$6c,$6c,$65,$63,$74,$69,$6f
	dc.b	$6e,$2e,$0d,$03,$02,$20,$5b,$20,$4a,$20,$5d,$03,$01,$20,$2d,$20
	dc.b	$49,$6e,$63,$72,$65,$61,$73,$65,$20,$67,$6f,$6c,$64,$20,$63,$6f
	dc.b	$69,$6e,$73,$2e,$0d,$03,$02,$20,$5b,$20,$4b,$20,$5d,$03,$01,$20
	dc.b	$2d,$20,$56,$69,$65,$77,$20,$6c,$61,$73,$74,$20,$65,$76,$65,$6e
	dc.b	$74,$27,$73,$20,$64,$61,$74,$61,$2e,$0d,$03,$02,$20,$5b,$20,$4c
	dc.b	$20,$5d,$03,$01,$20,$2d,$20,$57,$68,$61,$74,$65,$76,$65,$72,$2e
	dc.b	$0d,$0d,$03,$02,$50,$72,$65,$73,$73,$20,$61,$6e,$79,$20,$6b,$65
	dc.b	$79,$20,$74,$6f,$20,$72,$65,$73,$75,$6d,$65,$2e,$03,$01,$00
D_1df4e:
	dc.b	$5b,$20,$41,$4d,$42,$45,$52,$53,$54,$41,$52,$20,$49,$20,$5d,$0d
	dc.b	$0d,$56,$65,$72,$73,$69,$6f,$6e,$20,$3a,$20,$31,$2e,$39,$34,$20
	dc.b	$45,$20,$28,$38,$2d,$39,$2d,$31,$39,$39,$32,$29,$0d,$0d,$50,$72
	dc.b	$65,$73,$73,$20,$61,$6e,$79,$20,$6b,$65,$79,$20,$74,$6f,$20,$72
	dc.b	$65,$73,$75,$6d,$65,$2e,$00,$00
Memory_types:
	dc.l	Memory_types_Text00
	dc.l	Memory_types_Text01
	dc.l	Memory_types_Text02
	dc.l	Memory_types_Text03
	dc.l	Memory_types_Text04
	dc.l	Memory_types_Text05
	dc.l	Memory_types_Text06
	dc.l	Memory_types_Text07
	dc.l	Memory_types_Text08
	dc.l	Memory_types_Text09
	dc.l	Memory_types_Text10
	dc.l	Memory_types_Text11
	dc.l	Memory_types_Text12
	dc.l	Memory_types_Text13
	dc.l	Memory_types_Text14
	dc.l	Memory_types_Text15
	dc.l	Memory_types_Text16
	dc.l	Memory_types_Text17
	dc.l	Memory_types_Text18
	dc.l	D_1e0d3
	dc.l	D_1e0e2
	dc.l	D_1e0f3
	dc.l	D_1e103
Memory_types_Text00:
	dc.b	$4d,$65,$6d,$6f,$72,$79,$20,$62,$6c,$6f,$63,$6b,$00
Memory_types_Text01:
	dc.b	$50,$61,$72,$74,$79,$20,$64,$61,$74,$61,$00
Memory_types_Text02:
	dc.b	$49,$63,$6f,$6e,$20,$64,$61,$74,$61,$00
Memory_types_Text03:
	dc.b	$43,$68,$61,$72,$61,$63,$74,$65,$72,$20,$64,$61,$74,$61,$00
Memory_types_Text04:
	dc.b	$4d,$61,$70,$20,$64,$61,$74,$61,$00
Memory_types_Text05:
	dc.b	$4c,$61,$62,$20,$64,$61,$74,$61,$00
Memory_types_Text06:
	dc.b	$4c,$61,$62,$20,$62,$6c,$6f,$63,$6b,$00
Memory_types_Text07:
	dc.b	$42,$61,$63,$6b,$67,$72,$6f,$75,$6e,$64,$00
Memory_types_Text08:
	dc.b	$43,$6f,$6c,$6f,$75,$72,$20,$70,$61,$6c,$65,$74,$74,$65,$00
Memory_types_Text09:
	dc.b	$38,$30,$78,$38,$30,$20,$50,$69,$63,$00
Memory_types_Text10:
	dc.b	$4d,$61,$70,$20,$74,$65,$78,$74,$73,$00
Memory_types_Text11:
	dc.b	$43,$68,$65,$73,$74,$20,$64,$61,$74,$61,$00
Memory_types_Text12:
	dc.b	$4d,$6f,$6e,$73,$74,$65,$72,$20,$64,$61,$74,$61,$00
Memory_types_Text13:
	dc.b	$4d,$65,$72,$63,$68,$61,$6e,$74,$20,$64,$61,$74,$61,$00
Memory_types_Text14:
	dc.b	$44,$69,$63,$74,$69,$6f,$6e,$61,$72,$79,$00
Memory_types_Text15:
	dc.b	$43,$6f,$6d,$62,$61,$74,$20,$62,$61,$63,$6b,$67,$72,$6f,$75,$6e
	dc.b	$64,$00
Memory_types_Text16:
	dc.b	$4d,$6f,$6e,$73,$74,$65,$72,$20,$67,$72,$61,$70,$68,$69,$63,$73
	dc.b	$00
Memory_types_Text17:
	dc.b	$41,$75,$74,$6f,$6d,$61,$70,$00
Memory_types_Text18:
	dc.b	$54,$65,$78,$74,$20,$66,$69,$6c,$65,$00
D_1e0d3:
	dc.b	$54,$61,$63,$74,$69,$63,$61,$6c,$20,$69,$63,$6f,$6e,$73,$00
D_1e0e2:
	dc.b	$4d,$61,$67,$69,$63,$20,$61,$6e,$69,$6d,$61,$74,$69,$6f,$6e,$73
	dc.b	$00
D_1e0f3:
	dc.b	$50,$75,$7a,$7a,$6c,$65,$20,$67,$72,$61,$70,$68,$69,$63,$73,$00
D_1e103:
	dc.b	$50,$75,$7a,$7a,$6c,$65,$20,$74,$65,$78,$74,$00,$00

	section	bss

New_map:
	ds.b	2
B_52f40:
	ds.b	1
B_52f41:
	ds.b	1
B_52f42:
	ds.b	1
B_52f43:
	ds.b	1
