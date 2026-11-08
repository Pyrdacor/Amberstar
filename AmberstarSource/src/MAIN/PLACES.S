; MAIN/PLACES.ASM (original module, merged with the disassembly of the shipped program)

	section	text


; ---- Places (original source: MAIN/PLACES.ASM) - the shipped program differs, its code follows, not assembled:
;Places:
;             moveq.l   #0,d0                ; Get opening time
;             move.b    1(a5),d0
;             beq.s     .Open                ; Open 24 hours ?
;             move.w    Hour,d1
;             cmp.w     d1,d0                ; Too early ?
;             ble.s     .Not_early
;.Closed:     Restore_coords                 ; Back, sinister fiend !
;             moveq.l   #0,d0                ; Closed text ?
;             move.b    4(a5),d0
;             cmpi.w    #26,d0
;             beq       .Exit
;             move.w    d0,WText_nr          ; Show text
;             move.l    Maptext_ptr,Textfile_ptr
;             Push      Module,TxtW_Mod
;             bra       .Exit
;.Not_early:  move.b    2(a5),d0             ; Get closing time
;             cmp.w     d0,d1                ; Too late ?
;             bge.s     .Closed
;.Open:       lea.l     Place_dat-22,a0      ; Get address of place data
;             move.w    6(a5),d0
;             mulu.w    #24,d0
;             adda.w    d0,a0
;             move.l    a0,Placedat_ptr
;             moveq.l   #0,d0                ; Get place type
;             move.b    3(a5),d0
;             add.w     d0,d0                ; Get pointer to module
;             add.w     d0,d0
;             move.l    .Place_mods-4(pc,d0.w),d0
;             bne.s     .Ok
;             ERROR     "[ Places ] : Illegal place type !!!"
;             bra.s     .Exit
;.Ok:         jsr       Exit_display
;             movea.l   d0,a0                ; Do it
;             jsr       Push_Module
;.Exit:       rts
;
;.Place_mods: .REPT 8
;             .DC.l Guild_Mod
;             .ENDR
;             .DC.l MerchOBJC_Mod,MerchFOOD_Mod
;             .DC.l 0,MerchHORSE_Mod,Healer_Mod,Sage_Mod
;             .DC.l MerchRAFT_Mod,MerchSHIP_Mod,Inn_Mod,MerchMAGIC_Mod,0,0

Places:
	moveq	#0,d0
	move.b	$1(a5),d0
	beq.b	T_0aab8
	move.w	Hour,d1
	cmp.w	d1,d0
	ble.b	T_0aab0
T_0aa82:
	jsr	Restore_coords
	moveq	#0,d0
	move.b	$4(a5),d0
	cmpi.w	#$1a,d0
	beq.b	T_0aaf6
	move.w	d0,WText_nr
	move.l	Maptext_ptr,Textfile_ptr
	lea.l	TxtW_Mod,a0
	bsr.w	Push_Module
	bra.b	T_0aaf6
T_0aab0:
	move.b	$2(a5),d0
	cmp.w	d0,d1
	bge.b	T_0aa82
T_0aab8:
	lea.l	D_4b9ae,a0
	move.w	$6(a5),d0
	mulu.w	#$18,d0
	adda.w	d0,a0
	move.l	a0,Placedat_ptr
	moveq	#0,d0
	move.b	$3(a5),d0
	add.w	d0,d0
	add.w	d0,d0
	move.l	.l_0aaf4(pc,d0.w),d0
	bne.b	.l_0aaec
	lea.l	D_31e93,a1
	jsr	DI_Error
	bra.b	T_0aaf6
.l_0aaec:
	dc.b	$61,$00,$5e,$22,$20,$40,$61,$00
.l_0aaf4:
	dc.b	$5e,$7e
T_0aaf6:
	rts
	dc.l	Guild_Mod
	dc.l	Guild_Mod
	dc.l	Guild_Mod
	dc.l	Guild_Mod
	dc.l	Guild_Mod
	dc.l	Guild_Mod
	dc.l	Guild_Mod
	dc.l	Guild_Mod
	dc.l	MerchOBJC_Mod
	dc.l	MerchFOOD_Mod
	dc.b	$00,$00,$00,$00
	dc.l	MerchHORSE_Mod
	dc.l	Healer_Mod
	dc.l	Sage_Mod
	dc.l	MerchRAFT_Mod
	dc.l	MerchSHIP_Mod
	dc.l	Inn_Mod
	dc.l	MerchMAGIC_Mod
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00
T_0ab48:
	jsr	T_0025a

; ---- Places_ModInit (original source: MAIN/PLACES.ASM) - the shipped program differs, its code follows, not assembled:
;Places_ModInit:
;             clr.w     Places_gold          ; No gold here
;             movea.l   Event_data_ptr,a0    ; Get picture number
;             moveq.l   #0,d0
;             move.b    3(a0),d0
;             move.w    d0,Place_nr
;             move.b    .Place_pix-1(pc,d0.w),d0
;             lea.l     Lay3_target_hbl+2,a0 ; Load picture
;             jsr       Load_80x80_picture
;             cmpi.w    #9,Place_nr          ; Object merchant ?
;             beq.s     .Yes
;             cmpi.w    #18,Place_nr         ; Magic merchant ?
;             bne.s     .No
;.Yes:        movea.l   Event_data_ptr,a0    ; Load merchant data
;             move.w    8(a0),d0
;             lea.l     Waredat_filename,a0
;             jsr       Load_subfile
;             move.l    a0,Waredat_ptr
;             lea.l     Ware_count-12,a0     ; Calculate pointer to slot
;             mulu.w    #12,d0               ; list
;             adda.w    d0,a0
;             move.l    a0,Warecount_ptr
;             lea.l     Sold_slots,a0        ; Clear slots
;             clr.l     (a0)+
;             clr.l     (a0)+
;             clr.l     (a0)
;.No:         jmp       Init_display
;
;.Place_pix:  .DC.b 3,3,3,3,3,3,3,3,4,4,6,7,8,10,14,14,15,23,0,0
;             .EVEN

Places_ModInit:
	clr.w	Places_gold
	movea.l	Event_data_ptr,a0
	moveq	#0,d0
	move.b	$3(a0),d0
	move.w	d0,Place_nr
	lea.l	T_0ac2e,a0
	move.b	-$1(a0,d0.w),d0
	lea.l	D_2902e,a0
	bsr.w	Load_80x80_picture
	cmpi.w	#$9,Place_nr
	beq.b	.l_0ab8e
	cmpi.w	#$12,Place_nr
	bne.b	.l_0abc8
.l_0ab8e:
	movea.l	Event_data_ptr,a0
	move.w	$8(a0),d0
	lea.l	D_321ca,a0
	jsr	Load_subfile
	move.l	a0,Waredat_ptr
	lea.l	B_5ea14,a0
	mulu.w	#$c,d0
	adda.w	d0,a0
	move.l	a0,Warecount_ptr
	lea.l	Sold_slots,a0
	clr.l	(a0)+
	clr.l	(a0)+
	clr.l	(a0)
.l_0abc8:
	jsr	T_00208
	bsr.w	Init_display
	move.w	Place_nr,d0
	move.b	T_0ac18+1(pc,d0.w),d0
	ext.w	d0
	bmi.b	T_0ac18
	lea.l	Lay3_PA,a0
	bsr.w	Push_PA
	lea.l	Lay3_PlusMes,a0
	jsr	Push_MA
	lea.l	Code0008Sys,a1
	bsr.w	Mr_Blue_Sky
	jsr	Pop_MA
	bsr.w	Pop_PA
	cmpi.w	#$9,Place_nr
	bpl.b	T_0ac18
	bsr.w	Update_guild_messages
T_0ac18:
	rts
	dc.b	$10,$10,$10,$10,$10,$10,$10,$10,$ff,$ff,$ff,$ff,$ff,$0f,$ff,$ff
	dc.b	$0e,$ff,$ff,$ff
T_0ac2e:
	dc.b	$03,$03,$03,$03,$03,$03,$03,$03,$04,$04,$06,$07,$08,$0a,$0e,$0e
	dc.b	$0f,$17,$00,$00
; ---- Places_ModExit (original source: MAIN/PLACES.ASM)
Places_ModExit:
	movea.l	Pic80_ptr,a0
	jsr	Free_memory
	cmpi.w	#9,Place_nr
	beq.s	.Yes
	cmpi.w	#18,Place_nr
	bne.s	.No
.Yes:
	movea.l	Waredat_ptr,a0
	jmp	Free_memory
.No:
	rts	
; ---- Exit_PLACES (original source: MAIN/PLACES.ASM)
Exit_PLACES:
	tst.w	Places_gold
	bne.s	.No_exit
	cmpi.w	#10,Place_nr
	bne.s	.No1
	tst.w	Places_food
	beq.w	Do_PlacesExit
	bra.s	.No_exit
.No1:
	cmpi.w	#9,Place_nr
	beq.s	.Yes
	cmpi.w	#18,Place_nr
	bne.s	Do_PlacesExit
.Yes:
	lea.l	Sold_slots,a0
	tst.l	(a0)+
	bne.s	.No_exit
	tst.l	(a0)+
	bne.s	.No_exit
	tst.l	(a0)
	beq.s	Do_PlacesExit
.No_exit:
	move.w	Place_nr,d0
	move.b	.Exit_txts-1(pc,d0.w),d0
	ext.w	d0
	move.w	d0,ReqText_nr
	lea.l	Code0002Sys,a0
	cmpi.w	#17,Place_nr
	bne.s	.No2
	lea.l	Code0003Sys,a0
.No2:
	move.l	a0,Textfile_ptr
	move.l	#Do_PlacesExit,ReqDo_ptr
	lea.l	Req_Mod,a0
	bra.w	Push_Module
.Exit_txts:
	dc.b	8,8,8,8,8,8,8,8,17,17,-1,18,21,18,18,18,5,17,-1,-1
	even	

; ---- Do_PlacesExit (original source: MAIN/PLACES.ASM) - the shipped program differs, its code follows, not assembled:
;Do_PlacesExit:
;             Restore_coords                 ; Exit !
;             jsr       Exit_display
;             Pop       Module
;             cmpi.w    #17,Place_nr         ; Inn ?
;             bne.s     .Exit
;             tst.b     Inn_flag             ; Gonna camp ?
;             beq.s     .Exit
;             Push      Module,Camp_Mod
;.Exit:       jmp       Init_display

Do_PlacesExit:
	jsr	Restore_coords
	bsr.w	Exit_display
	bsr.w	Pop_Module
	cmpi.w	#$11,Place_nr
	bne.b	.l_0ad34
	tst.b	Inn_flag
	beq.b	.l_0ad34
	lea.l	Camp_Mod,a0
	bsr.w	Push_Module
.l_0ad34:
	bra.w	Init_display
; ---- Pool_gold_PLACES (original source: MAIN/PLACES.ASM)
Pool_gold_PLACES:
	suba.l	a0,a0
	move.w	Places_gold,d0
	moveq.l	#0,d1
	moveq.l	#-1,d2
	lsr.l	#1,d2
	jsr	Pool_gold
	add.w	d0,Places_gold
	rts	
; ---- Divide_gold_PLACES (original source: MAIN/PLACES.ASM)
Divide_gold_PLACES:
	moveq.l	#0,d0
	move.w	Places_gold,d0
	bsr.w	Divide_gold
	move.w	d0,Places_gold
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	rts	
; ---- Transfer_gold_PLACES (original source: MAIN/PLACES.ASM)
Transfer_gold_PLACES:
	move.w	#112,Mesmin_X
	move.w	#63,Mesmin_Y
	move.w	#192,Mesmin_Wd
	move.l	#Code0001Sys,Textfile_ptr
	movea.l	Off_screen,a6
	move.w	#6,d0
	bsr.w	Minus_message
	jsr	Switch_screen
	jsr	Copy_screen
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	moveq.l	#0,d0
	move.w	Places_gold,d0
	move.l	d0,Original_number
	clr.l	ItemW_nr
	lea.l	TransGoldPLACES_Mod,a0
	bsr.w	Push_Module
	rts	
T_0add8:
	move.l	ItemW_nr,d0
	beq.b	.l_0ae1a
	move.w	d0,d1
	mulu.w	#$a,d0
	suba.l	a0,a0
	jsr	Scan_4_gold_victims
	bne.b	.l_0adfa
	move.w	#$5,d0
	bsr.w	Plus_message
	bra.b	.l_0ae1a
.l_0adfa:
	jsr	Show_transfer_victims
	move.l	#.l_0ae26,TIVS_Ptr
	lea.l	TIVS2_Mod,a0
	move.w	#$19,$2c(a0)
	bsr.w	Push_Module
.l_0ae1a:
	btst	#$1,Mouse_button_state
	bne.b	.l_0ae1a
	rts
.l_0ae26:
	move.l	ItemW_nr,d0
	add.w	d0,$90(a0)
	sub.w	d0,Places_gold
	mulu.w	#$a,d0
	add.l	d0,$ec(a0)
	rts
; ---- Places_CIL_evaluate (original source: MAIN/PLACES.ASM)
Places_CIL_evaluate:
	movem.l	d0/d7/a1/a2,-(sp)
	bclr	#7,6(a0)
	bclr	#7,7(a0)
	bclr	#7,8(a0)
	tst.w	Places_gold
	bne.s	.Ok1
	bset	#7,7(a0)
	bset	#7,8(a0)
.Ok1:
	lea.l	Chard_ptrs,a1
	moveq.l	#6-1,d7
.Loop:
	tst.l	(a1)
	beq.s	.Next
	movea.l	(a1)+,a2
	move.w	#$0402,d0
	and.w	Body_conditions(a2),d0
	bne.s	.Next
	tst.w	Gold_coins(a2)
	bne.s	.Ok2
.Next:
	dbra	d7,.Loop
	bset	#7,6(a0)
.Ok2:
	movem.l	(sp)+,d0/d7/a1/a2
	rts	
; ---- Display_gold (original source: MAIN/PLACES.ASM)
Display_gold:
	movem.l	d0-d2/d7/a0/a3/a6,-(sp)
	moveq.l	#15,d0
	jsr	IG_Set_ink
	moveq.l	#2,d0
	jsr	IG_Set_paper
	move.w	Places_gold,d0
	moveq.l	#"0",d1
	moveq.l	#5,d7
	lea.l	GoldDis_text,a0
	movea.l	a0,a3
	bsr.w	RConvert_number
	move.w	#112,d0
	move.w	#113+8,d1
	move.w	#64,d2
	movea.l	Off_screen,a6
	bsr.w	Print_centered_string
	movem.l	(sp)+,d0-d2/d7/a0/a3/a6
	rts	
; ---- Places_DisInit (original source: MAIN/PLACES.ASM)
Places_DisInit:
	movem.l	d0-d2/a0,-(sp)
	moveq.l	#15,d0
	jsr	IG_Set_ink
	moveq.l	#-1,d0
	jsr	IG_Set_paper
	movea.l	Event_data_ptr,a0
	move.w	6(a0),d0
	subq.w	#1,d0
	mulu.w	#30,d0
	movea.l	Placetext_ptr,a0
	adda.w	d0,a0
	clr.b	29(a0)
	moveq.l	#16,d0
	moveq.l	#39,d1
	move.w	#320,d2
	bsr.w	Print_centered_string
	move.w	#112,d0
	move.w	#113,d1
	move.w	#64,d2
	lea.l	Gold_txt,a0
	bsr.w	Print_centered_string
	movem.l	(sp)+,d0-d2/a0
	rts	
; ---- Guild_DisUpd (original source: MAIN/PLACES.ASM)
Guild_DisUpd:
	bsr.w	Update_status_block
	lea.l	Guild_CIL,a0
	lea.l	GuildCIL_evaluate,a1
	bsr.w	Update_control_icons
	bsr.w	Display_gold
	rts	

; ---- Guild_DisInit (original source: MAIN/PLACES.ASM) - the shipped program differs, its code follows, not assembled:
;Guild_DisInit:
;             move.l    #Lay3_PlusMes,PlusMes_info ; Set message parameters
;             movea.l   Off_screen,a6
;             moveq.l   #3,d0                ; Show layout 3
;             jsr       Show_layout
;             jsr       Display_80x80_picture      ; Show picture
;             jsr       Places_DisInit       ; Print headline & "GOLD"
;             lea.l     Guild_CIL,a0         ; Show control icons
;             jsr       GuildCIL_evaluate
;             move.l    a0,Control_list_ptr
;             jsr       Show_control_icons
;             jsr       Update_guild_messages
;             Update_screen
;             lea.l     Lay3_L2,a0           ; Set object branch
;             jsr       Set_layout_data
;             jmp       Fadein_lay3          ; Fade in

Guild_DisInit:
	move.l	#Lay3_PlusMes,PlusMes_info
	movea.l	Off_screen,a6
	moveq	#3,d0
	bsr.w	Show_layout
	bsr.w	Display_80x80_picture
	bsr.w	Places_DisInit
	lea.l	Guild_CIL,a0
	bsr.w	GuildCIL_evaluate
	move.l	a0,Control_list_ptr
	bsr.w	Show_control_icons
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	Lay3_L2,a0
	jsr	Set_layout_data
	bra.w	Fadein_lay3

; ---- Update_guild_messages (original source: MAIN/PLACES.ASM) - the shipped program differs, its code follows, not assembled:
;Update_guild_messages:
;             movem.l   d0/d1/d7/a0-a6,-(sp)
;             Push      PA,Lay3_PlusMes+8    ; Start message
;             jsr       Init_RText
;             movea.l   Current_active_char_data,a2          ; Initialize registers
;             movea.l   Placedat_ptr,a4
;             lea.l     Class_dat+10,a5
;             move.w    Place_nr,d0
;             mulu.w    #394,d0
;             adda.w    d0,a5
;             moveq.l   #0,d0
;             move.b    Level_nr(a2),d0
;             add.w     d0,d0
;             add.w     d0,d0
;             adda.w    d0,a5
;             movea.l   Off_screen,a6
;             jsr       Erase_text_window    ; Clear text area
;; ------------- Print price of joining -------------------------------
;             tst.b     Character_class(a2)  ; Any class ?
;             bne       .Skip1
;             move.w    Place_nr,d0          ; Possible ?
;             move.w    Possible_class(a2),d1
;             btst      d0,d1
;             beq       .Skip1
;             move.l    (a5),d0              ; Enough experience ?
;             cmp.l     Experience_points(a2),d0
;             bgt.s     .Skip1
;             lea.l     Code0003Sys,a1       ; Add message
;             move.w    #19,d0
;             jsr       Add_encoded_2_RText
;             lea.l     Number_buffer,a0     ; Add price of joining
;             movea.l   a0,a3
;             moveq.l   #0,d0
;             move.w    (a4),d0
;             moveq.l   #4,d7
;             jsr       LConvert_number
;             move.b    #" ",(a3)+
;             clr.b     (a3)
;             jsr       Add_ASCII_2_RText
;             lea.l     Gold_txt,a0          ; Add "GOLD"
;             jsr       Add_ASCII_2_RText
;             lea.l     Return,a0            ; Add 2 carriage returns
;             jsr       Add_ASCII_2_RText
;             jsr       Add_ASCII_2_RText
;; ------------- Print price of making a level ------------------------
;.Skip1:      move.w    Place_nr,d0          ; Right guild ?
;             cmp.b     Character_class(a2),d0
;             bne.s     .Skip2
;             cmpi.b    #MaxLevel,Level_nr(a2)     ; Maximum level ?
;             bpl.s     .Skip2
;             move.l    (a5),d0              ; Enough experience ?
;             cmp.l     Experience_points(a2),d0
;             bgt.s     .Skip2
;             lea.l     Code0003Sys,a1       ; Add message
;             move.w    #20,d0
;             jsr       Add_encoded_2_RText
;             lea.l     Number_buffer,a0     ; Add price of making
;             movea.l   a0,a3
;             move.w    2(a4),d0
;             moveq.l   #4,d7
;             jsr       LConvert_number
;             move.b    #" ",(a3)+
;             clr.b     (a3)
;             jsr       Add_ASCII_2_RText
;             lea.l     Gold_txt,a0          ; Add "GOLD"
;             jsr       Add_ASCII_2_RText
;             lea.l     Return,a0            ; Add 2 carriage returns
;             jsr       Add_ASCII_2_RText
;             jsr       Add_ASCII_2_RText
;; ------------- Print amount of experience points needed -------------
;.Skip2:      tst.b     Character_class(a2)  ; Any class ?
;             bne       .Class
;             move.w    Place_nr,d0          ; Possible to join ?
;             move.w    Possible_class(a2),d1
;             btst      d0,d1
;             bne       .Ok3
;             bra       .Skip3
;.Class:      move.w    Place_nr,d0          ; Right guild ?
;             cmp.b     Character_class(a2),d0
;             bne.s     .Skip3
;             cmpi.b    #MaxLevel,Level_nr(a2)     ; Maximum level ?
;             bpl.s     .Skip3
;.Ok3:        move.l    (a5),d1              ; Get needed experience points
;             sub.l     Experience_points(a2),d1
;             ble.s     .Skip3
;             lea.l     Char_name(a2),a0     ; Add name of active character
;             jsr       Add_ASCII_2_RText
;             lea.l     Space,a0             ; Add space
;             jsr       Add_ASCII_2_RText
;             lea.l     Code0004Sys,a1       ; Add message
;             move.w    #17,d0
;             jsr       Add_encoded_2_RText
;             lea.l     Number_buffer,a0     ; Add number of experience
;             movea.l   a0,a3                ; points
;             move.l    d1,d0
;             moveq.l   #4,d7
;             jsr       LConvert_number
;             jsr       Add_ASCII_2_RText
;; ------------- Print message & exit ---------------------------------
;.Skip3:      jsr       Erase_text_window    ; Clear window
;             jsr       IG_Cursor_home
;             movea.l   RText_ptr,a0         ; Print text
;             move.w    Nr_of_chars,d0
;             move.w    Lines_in_text,d7
;             bra.s     .Entry
;.Loop:       jsr       IG_Print
;             jsr       IG_Carriage_return
;             lea.l     1(a0,d0.w),a0
;.Entry:      dbra      d7,.Loop
;             Update_screen
;             jsr       Exit_RText
;             Pop       PA
;             movem.l   (sp)+,d0/d1/d7/a0-a6
;             rts

Update_guild_messages:
	movem.l	d0-d1/d7/a0-a5,-(a7)
	lea.l	Lay3_PA,a0
	bsr.w	Push_PA
	bsr.w	Init_RText
	movea.l	Current_active_char_data,a2
	movea.l	Placedat_ptr,a4
	lea.l	D_4a318,a5
	move.w	Place_nr,d0
	mulu.w	#$18a,d0
	adda.w	d0,a5
	moveq	#0,d0
	move.b	Level_nr(a2),d0
	add.w	d0,d0
	add.w	d0,d0
	adda.w	d0,a5
	tst.b	Character_class(a2)
	bne.b	.l_0b038
	move.w	Place_nr,d0
	move.w	Possible_class(a2),d1
	btst	d0,d1
	beq.b	.l_0b038
	move.l	(a5),d0
	cmp.l	Experience_points(a2),d0
	bgt.b	.l_0b038
	lea.l	Code0003Sys,a1
	move.w	#$13,d0
	bsr.w	Add_encoded_2_RText
	lea.l	Number_buffer,a0
	movea.l	a0,a3
	moveq	#0,d0
	move.w	(a4),d0
	moveq	#4,d7
	bsr.w	LConvert_number
	move.b	#$20,(a3)+
	clr.b	(a3)
	bsr.w	Add_ASCII_2_RText
	lea.l	Gold_txt,a0
	bsr.w	Add_ASCII_2_RText
	lea.l	Return,a0
	bsr.w	Add_ASCII_2_RText
	bsr.w	Add_ASCII_2_RText
.l_0b038:
	move.w	Place_nr,d0
	cmp.b	Character_class(a2),d0
	bne.b	.l_0b096
	cmpi.b	#$32,Level_nr(a2)
	bpl.b	.l_0b096
	move.l	(a5),d0
	cmp.l	Experience_points(a2),d0
	bgt.b	.l_0b096
	lea.l	Code0003Sys,a1
	move.w	#$14,d0
	bsr.w	Add_encoded_2_RText
	lea.l	Number_buffer,a0
	movea.l	a0,a3
	move.w	$2(a4),d0
	moveq	#4,d7
	bsr.w	LConvert_number
	move.b	#$20,(a3)+
	clr.b	(a3)
	bsr.w	Add_ASCII_2_RText
	lea.l	Gold_txt,a0
	bsr.w	Add_ASCII_2_RText
	lea.l	Return,a0
	bsr.w	Add_ASCII_2_RText
	bsr.w	Add_ASCII_2_RText
.l_0b096:
	tst.b	Character_class(a2)
	bne.b	.l_0b0ac
	move.w	Place_nr,d0
	move.w	Possible_class(a2),d1
	btst	d0,d1
	bne.b	.l_0b0c0
	bra.b	.l_0b106
.l_0b0ac:
	move.w	Place_nr,d0
	cmp.b	Character_class(a2),d0
	bne.b	.l_0b106
	cmpi.b	#$32,Level_nr(a2)
	bpl.b	.l_0b106
.l_0b0c0:
	move.l	(a5),d1
	sub.l	Experience_points(a2),d1
	ble.b	.l_0b106
	lea.l	Char_name(a2),a0
	bsr.w	Add_ASCII_2_RText
	lea.l	Space,a0
	bsr.w	Add_ASCII_2_RText
	lea.l	Code0004Sys,a1
	move.w	#$11,d0
	bsr.w	Add_encoded_2_RText
	lea.l	Number_buffer,a0
	movea.l	a0,a3
	move.l	d1,d0
	moveq	#4,d7
	bsr.w	LConvert_number
	bsr.w	Add_ASCII_2_RText
	lea.l	D_29096,a0
	bsr.w	Add_ASCII_2_RText
.l_0b106:
	bsr.w	T_0707a
	jsr	Switch_screen
	jsr	Copy_screen
	bsr.w	Exit_RText
	bsr.w	Pop_PA
	movem.l	(a7)+,d0-d1/d7/a0-a5
	rts
; ---- GuildCIL_evaluate (original source: MAIN/PLACES.ASM)
GuildCIL_evaluate:
	movem.l	d0/d1/a1-a3,-(sp)
	bclr	#7,0(a0)
	bclr	#7,3(a0)
	movea.l	Current_active_char_data,a1
	movea.l	Placedat_ptr,a2
	lea.l	D_4a318,a3	; CHANGE: was "lea.l Class_dat+10,a3"
	move.w	Place_nr,d0
	mulu.w	#394,d0
	adda.w	d0,a3
	moveq.l	#0,d0
	move.b	Level_nr(a1),d0
	add.w	d0,d0
	add.w	d0,d0
	adda.w	d0,a3
	tst.b	Character_class(a1)
	bne.s	.Deac1
	move.w	Places_gold,d0
	cmp.w	(a2),d0
	bmi.s	.Deac1
	move.w	Place_nr,d0
	move.w	Possible_class(a1),d1
	btst	d0,d1
	beq.s	.Deac1
	move.l	(a3),d0
	cmp.l	Experience_points(a1),d0
	ble.s	.Ok1
.Deac1:
	bset	#7,0(a0)
.Ok1:
	move.w	Place_nr,d0
	cmp.b	Character_class(a1),d0
	bne.s	.Deac2
	move.w	Places_gold,d0
	cmp.w	2(a2),d0
	bmi.s	.Deac2
	cmpi.b	#$32,$1b(a1)	; CHANGE: was "cmpi.b #MaxLevel,Level_nr(a1)"
	bpl.s	.Deac2
	move.l	(a3),d0
	cmp.l	Experience_points(a1),d0
	ble.s	.Ok2
.Deac2:
	bset	#7,3(a0)
.Ok2:
	bsr.w	Places_CIL_evaluate
	movem.l	(sp)+,d0/d1/a1-a3
	rts	
; ---- Join_guild (original source: MAIN/PLACES.ASM)
Join_guild:
	btst	#1,Mouse_button_state
	bne.s	*-8
	move.w	#$0,Draw_Cicon	; CHANGE: was "Wait_4_unclick"
	jsr	My_vsync	; CHANGE: added
	movea.l	Placedat_ptr,a0
	move.w	(a0),d0
	sub.w	d0,Places_gold
	movea.l	Current_active_char_data,a0
	move.w	Place_nr,d0
	move.b	d0,Character_class(a0)
	lea.l	D_4a30e,a2	; CHANGE: was "lea.l Class_dat,a2"
	move.w	Place_nr,d0
	mulu.w	#394,d0
	adda.w	d0,a2
	lea.l	Skill_1_max(a0),a1
	moveq.l	#10-1,d7
.Loop1:
	move.b	(a2)+,(a1)+
	dbra	d7,.Loop1
	lea.l	Special_1(a0),a1
	lea.l	360(a2),a2
	moveq.l	#11-1,d7
.Loop2:
	move.w	(a2)+,(a1)+
	dbra	d7,.Loop2
	move.b	(a2)+,Spell_class_counter(a0)
	bsr.w	Increase_level
	rts	
T_0b230:
	btst	#$1,Mouse_button_state
; ---- Make_level (original source: MAIN/PLACES.ASM)
; CHANGE: removed "Wait_4_unclick"
Make_level:
	bne.s	*-8
	move.w	#$0,Draw_Cicon	; CHANGE: was "Wait_4_unclick"
	jsr	My_vsync	; CHANGE: added
	movea.l	Placedat_ptr,a0
	move.w	2(a0),d0
	sub.w	d0,Places_gold
	movea.l	Current_active_char_data,a0
; ---- Increase_level (original source: MAIN/PLACES.ASM)
Increase_level:
	addq.b	#1,Level_nr(a0)
	moveq.l	#0,d0
	move.b	Level_nr(a0),d0
	subq.w	#$1,d0	; CHANGE: added
	move.w	Special_1(a0),d1
	beq.s	.Zero
	divu.w	d1,d0
	addq.w	#$1,d0	; CHANGE: added
	move.b	d0,Attacks_per_round(a0)
.Zero:
	moveq.l	#0,d0
	move.w	Attr_5_normal(a0),d0
	add.w	Attr_5_normal_magic(a0),d0
	divu.w	#10,d0
	add.w	Special_2(a0),d0
	add.w	d0,Life_points_max(a0)
	tst.b	Spell_class_counter(a0)
	beq.s	.No_magic
	moveq.l	#0,d0
	move.w	Attr_2_normal(a0),d0
	add.w	Attr_2_normal_magic(a0),d0
	divu.w	#20,d0
	move.w	d0,d1
	add.w	Special_3(a0),d0
	add.w	d0,Power_points_max(a0)
	add.w	Special_4(a0),d1
	add.w	d1,Nr_spell_learn_points(a0)
.No_magic:
	move.l	#Code0004Sys,Textfile_ptr
	move.w	#18,d0
	bsr.w	Plus_message
	lea.l	SkillW_Mod,a0
	bsr.w	Push_Module
	rts	
; ---- Guild_Member_left (original source: MAIN/PLACES.ASM)
Guild_Member_left:
	andi.l	#$0000ff00,d0
	beq.s	.Exit
	lsr.w	#6,d0
	move.w	d0,d1
	lea.l	Chard_ptrs,a0
	move.l	-$4(a0,d0.w),d0	; CHANGE: was "movea.l -4(a0,d0.w),a0"
	beq.b	.Exit	; CHANGE: added
	movea.l	d0,a0	; CHANGE: added
	move.w	Body_conditions(a0),d0
	andi.w	#$e406,d0	; CHANGE: was "andi.w #$e506,d0"
	bne.s	.Exit
	lsr.w	#2,d1
	move.w	d1,Active_member
	lea.l	Chard_ptrs,a0
	add.w	d1,d1
	add.w	d1,d1
	move.l	-4(a0,d1.w),Current_active_char_data
	bsr.w	Update_guild_messages
.Exit:
	rts	
; ---- SkillW_ModInit (original source: MAIN/PLACES.ASM)
SkillW_ModInit:
	moveq.l	#32,d0
	moveq.l	#37,d1
	moveq.l	#10,d2
	moveq.l	#8,d3
	moveq.l	#2,d4
	moveq.l	#1,d6
	lea.l	SkillW_L1,a0
	jsr	Open_window
	move.w	d0,Window_handle
	movea.l	Off_screen,a6
	move.w	#32+16,d0
	move.w	#37+16+7,d1
	move.w	d0,d2
	addi.w	#127,d2
	move.w	d1,d3
	addi.w	#70,d3
	moveq.l	#3,d6
	jsr	Draw_box
	moveq.l	#2,d6
	moveq.l	#16,d7
	move.w	#32+16,d0
	move.w	#37+16+80,d1
; CHANGE: removed "lea.l Control_icn+7680,a0"
; CHANGE: removed "jsr Blot_unmasked_block"
	lea.l	D_3ccea,a0	; CHANGE: was "lea.l Chequered,a0"
	jsr	Blot_unmasked_block	; CHANGE: was "jsr Blot_masked_block"
	moveq.l	#-1,d0
	jsr	IG_Set_paper
	moveq.l	#1,d0
	jsr	IG_Set_ink
	move.w	#32+16,d0
	move.w	#37+16,d1
	move.w	#128,d2
	jsr	IG_Set_cursor
	lea.l	Skills_name,a0
	bsr.w	Print_centered_string
	moveq.l	#15,d0
	jsr	IG_Set_ink
	move.w	#61,d2
	moveq.l	#0,d6
	moveq.l	#2,d7
	movea.l	Current_active_char_data,a1
	lea.l	Class_dat+Class_names+22,a2
	lea.l	Skill_1(a1),a4
	lea.l	Skill_1_normal_magic(a1),a5
.Loop:
	move.w	#48+2,d0
	move.w	d2,d1
	jsr	IG_Set_cursor
	move.w	d6,d0
	add.w	d0,d0
	move.w	0(a2,d0.w),d0
	bsr.w	Get_word
	lea.l	Line_buffer,a0
	clr.b	7(a0)
	jsr	IG_Print
	move.w	#48+9*6,d0
	move.w	d2,d1
	jsr	IG_Set_cursor
	lea.l	Skill_txt,a0	; CHANGE: was "lea.l Skill_txt,a3"
	movea.l	a0,a3	; CHANGE: was "moveq.l #"0",d1"
	moveq	#48,d1	; CHANGE: added
	moveq.l	#0,d0
	move.b	(a4)+,d0
	add.w	(a5)+,d0
	bsr.w	RConvert_number
	addq.l	#2,a3
	moveq.l	#0,d0
	move.b	10-1(a4),d0
	bsr.w	RConvert_number
; CHANGE: removed "lea.l Skill_txt,a0"
	jsr	IG_Print
	jsr	IG_Carriage_return
	addq.w	#7,d2
	addq.w	#1,d6
	cmpi.w	#10,d6
	bmi.s	.Loop
; CHANGE: removed "Update_screen"
; CHANGE: removed "Update_screen"
; CHANGE: removed "move.w #10,Remaining_offset"
	lea.l	Make_level_offsets,a0
	clr.l	(a0)+
	clr.l	(a0)+
	clr.w	(a0)
	movea.l	Current_active_char_data,a0
	move.w	$78(a0),d0	; CHANGE: added
	bne.b	.c_0b442	; CHANGE: added
	moveq	#10,d0	; CHANGE: added
.c_0b442:
	move.w	d0,Remaining_offset	; CHANGE: added
	lea.l	Skill_1(a0),a0
	lea.l	Possible_level_offsets,a1
	moveq	#0,d0	; CHANGE: added
	moveq	#0,d1	; CHANGE: added
	moveq.l	#10-1,d7
.Loop_L1:
	move.b	10(a0),d0
	sub.b	(a0)+,d0
	move.b	d0,(a1)+
	add.w	d0,d1	; CHANGE: added
	dbra	d7,.Loop_L1
	cmp.w	Remaining_offset,d1	; CHANGE: added
	bpl.b	.c_0b474	; CHANGE: added
	move.w	d1,Remaining_offset	; CHANGE: added
.c_0b474:
	tst.w	Remaining_offset	; CHANGE: added
	beq.b	.c_0b486	; CHANGE: added
	move.w	-(a1),d0
	or.w	-(a1),d0
	or.w	-(a1),d0	; CHANGE: added
	or.w	-(a1),d0	; CHANGE: added
	or.w	-(a1),d0	; CHANGE: added
.c_0b486:
	seq	Exit_on
	beq.b	.c_0b4a6	; CHANGE: added
	move.w	#$30,d0	; CHANGE: added
	move.w	#$85,d1	; CHANGE: added
	moveq	#2,d6	; CHANGE: added
	moveq	#16,d7	; CHANGE: added
	lea.l	Chequered,a0	; CHANGE: added
	jsr	Blot_masked_block	; CHANGE: added
.c_0b4a6:
	jsr	Switch_screen	; CHANGE: added
	jsr	Copy_screen	; CHANGE: added
	rts	
; ---- SkillW_ModExit (original source: MAIN/PLACES.ASM)
SkillW_ModExit:
	move.w	Window_handle,d0
	jsr	Close_window
	rts	
; ---- SkillW_DisUpd (original source: MAIN/PLACES.ASM)
SkillW_DisUpd:
	moveq.l	#6,d0
	jsr	IG_Set_ink
	moveq.l	#3,d0
	jsr	IG_Set_paper
	move.w	#154,d2
	move.w	#37+24,d3
	moveq.l	#10-1,d6
	moveq.l	#2,d7
	lea.l	Make_level_txt,a0
	lea.l	Make_level_offsets,a1
	movea.l	Off_screen,a6
.Loop:
	move.w	d2,d0
	move.w	d3,d1
	jsr	IG_Set_cursor
	moveq.l	#0,d0
	move.b	(a1)+,d0
	moveq.l	#"0",d1
	movea.l	a0,a3
	bsr.w	RConvert_number
	jsr	IG_Print
	addq.w	#7,d3
	dbra	d6,.Loop
	moveq.l	#15,d0
	jsr	IG_Set_ink
	moveq.l	#2,d0
	jsr	IG_Set_paper
	move.w	#96,d0
	move.w	#137,d1
	jsr	IG_Set_cursor
	move.w	Remaining_offset,d0
	moveq.l	#"0",d1
	lea.l	Bonus_txt,a0
	lea.l	8(a0),a3
	bsr.w	RConvert_number
	jsr	IG_Print
	rts	
; ---- Inc_skill (original source: MAIN/PLACES.ASM)
Inc_skill:
	tst.w	Remaining_offset
	beq.w	.Exit
	lsr.w	#8,d0
	lea.l	Possible_level_offsets-1,a1
	adda.w	d0,a1
	tst.b	(a1)
	beq.s	.Exit
	movea.l	Current_active_char_data,a0
	lea.l	Skill_1-1(a0),a0
	addq.b	#1,0(a0,d0.w)
	bsr.w	Reprint_skill
	lea.l	Make_level_offsets-1,a0
	adda.w	d0,a0
	addq.b	#1,(a0)
	subq.w	#1,Remaining_offset
	subq.b	#1,(a1)
	bne.s	.Ok
	lea.l	Possible_level_offsets,a0
	move.w	(a0)+,d0
	or.w	(a0)+,d0
	or.w	(a0)+,d0	; CHANGE: added
	or.w	(a0)+,d0	; CHANGE: added
	or.w	(a0)+,d0	; CHANGE: added
	beq.s	.Done
.Ok:
	tst.w	Remaining_offset
	bne.s	.Exit
.Done:
	moveq.l	#2,d6
	moveq.l	#16,d7
	move.w	#32+16,d0
	move.w	#37+16+80,d1
	lea.l	Control_icn+7680,a0
	movea.l	Off_screen,a6
	jsr	Blot_unmasked_block
	jsr	Switch_screen
	jsr	Copy_screen
	st	Exit_on
.Exit:
	rts	
; ---- Dec_skill (original source: MAIN/PLACES.ASM)
Dec_skill:
	lea.l	Make_level_offsets-1,a0
	lsr.w	#8,d0
	adda.w	d0,a0
	tst.b	(a0)
	beq.s	.Exit
	movea.l	Current_active_char_data,a1
	lea.l	Skill_1-1(a1),a1
	adda.w	d0,a1
	tst.b	(a1)
	beq.s	.Exit
	subq.b	#1,(a1)
	bsr.w	Reprint_skill
	subq.b	#1,(a0)
	lea.l	Possible_level_offsets-1,a0
	adda.w	d0,a0
	addq.b	#1,(a0)
	tst.w	Remaining_offset
	bne.s	.Skip
	moveq.l	#2,d6
	moveq.l	#16,d7
	move.w	#32+16,d0
	move.w	#37+16+80,d1
	lea.l	Chequered,a0
	movea.l	Off_screen,a6
	jsr	Blot_masked_block
	jsr	Switch_screen
	jsr	Copy_screen
	sf	Exit_on
.Skip:
	addq.w	#1,Remaining_offset
.Exit:
	rts	
; ---- Reprint_skill (original source: MAIN/PLACES.ASM)
Reprint_skill:
	movem.l	d0-d2/d6/d7/a0-a3/a6,-(sp)
	move.w	d0,d2
	movea.l	Off_screen,a6
	moveq.l	#15,d0
	jsr	IG_Set_ink
	moveq.l	#3,d0
	jsr	IG_Set_paper
	move.w	#48+9*6,d0
	move.w	d2,d1
	mulu.w	#7,d1
	addi.w	#61-7,d1
	jsr	IG_Set_cursor
	movea.l	Current_active_char_data,a1
	lea.l	$ae(a1),a2	; CHANGE: was "lea.l Skill_1_normal_magic(a1),a2"
	lea.l	Skill_1-1(a1),a1
	adda.w	d2,a1
	adda.w	d2,a2
	adda.w	d2,a2
	lea.l	Skill_txt,a0	; CHANGE: was "lea.l Skill_txt,a3"
	movea.l	a0,a3	; CHANGE: was "moveq.l #"0",d1"
	moveq	#48,d1	; CHANGE: added
	moveq.l	#2,d7
	moveq.l	#0,d0
	move.b	(a1),d0
	add.w	(a2),d0
	bsr.w	RConvert_number
	addq.l	#2,a3
	moveq.l	#0,d0
	move.b	10(a1),d0
	bsr.w	RConvert_number
; CHANGE: removed "lea.l Skill_txt,a0"
	jsr	IG_Print
	jsr	Switch_screen
	jsr	Copy_screen
	movem.l	(sp)+,d0-d2/d6/d7/a0-a3/a6
	rts	
; ---- Exit_SkillW (original source: MAIN/PLACES.ASM)
Exit_SkillW:
	tst.b	Exit_on
	beq.w	.Exit
	bsr.w	Pop_Module
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	movea.l	Current_active_char_data,a2
	lea.l	Lay3_PlusMes+8,a0
	bsr.w	Push_PA
	bsr.w	Init_RText
	lea.l	Char_name(a2),a0
	bsr.w	Add_ASCII_2_RText
	lea.l	Space,a0
	bsr.w	Add_ASCII_2_RText
	lea.l	Code0004Sys,a1
	moveq.l	#19,d0
	bsr.w	Add_encoded_2_RText
	lea.l	Number_buffer,a0
	movea.l	a0,a3
	moveq.l	#0,d0
	move.b	Level_nr(a2),d0
	moveq.l	#2,d7
	bsr.w	LConvert_number
	move.b	#$20,(a3)+	; CHANGE: was "move.b #" ",(a3)+"
	clr.b	(a3)
	bsr.w	Add_ASCII_2_RText
	moveq.l	#20,d0
	bsr.w	Add_encoded_2_RText
	lea.l	Return,a0
	bsr.w	Add_ASCII_2_RText
	moveq.l	#21,d0
	bsr.w	Add_encoded_2_RText
	lea.l	Number_buffer,a0
	movea.l	a0,a3
	move.w	Life_points_max(a2),d0
	add.w	Life_points_max_magic(a2),d0
	moveq.l	#3,d7
	bsr.w	LConvert_number
	bsr.w	Add_ASCII_2_RText
	tst.b	Spell_class_counter(a2)
	beq.s	.No_magic
	lea.l	Return,a0
	bsr.w	Add_ASCII_2_RText
	moveq.l	#22,d0
	bsr.w	Add_encoded_2_RText
	lea.l	Number_buffer,a0
	movea.l	a0,a3
	move.w	Power_points_max(a2),d0
	add.w	Power_points_max_magic(a2),d0
	moveq.l	#3,d7
	bsr.w	LConvert_number
	bsr.w	Add_ASCII_2_RText
	lea.l	Return,a0
	bsr.w	Add_ASCII_2_RText
	moveq.l	#23,d0
	bsr.w	Add_encoded_2_RText
	lea.l	Number_buffer,a0
	movea.l	a0,a3
	move.w	Nr_spell_learn_points(a2),d0
	moveq.l	#3,d7
	bsr.w	LConvert_number
	bsr.w	Add_ASCII_2_RText
.No_magic:
	bsr.w	T_0707a	; CHANGE: was ".No_magic: jsr Erase_text_window"
	jsr	IG_Cursor_home
; CHANGE: removed "movea.l RText_ptr,a0"
; CHANGE: removed "move.w Nr_of_chars,d0"
; CHANGE: removed "move.w Lines_in_text,d7"
; CHANGE: removed "bra.s .Entry"
; CHANGE: removed ".Loop: jsr IG_Print"
; CHANGE: removed "jsr IG_Carriage_return"
; CHANGE: removed "lea.l 1(a0,d0.w),a0"
; CHANGE: removed ".Entry: dbra d7,.Loop"
; CHANGE: removed "Update_screen"
.Entry:
.Loop:
	jsr	Copy_screen
	bsr.w	Wait_4_user
	bsr.w	Exit_RText
	bsr.w	Pop_PA
	bsr.w	Update_guild_messages
.Exit:
	rts	
; ---- MerchOBJC_DisUpd (original source: MAIN/PLACES.ASM)
MerchOBJC_DisUpd:
	bsr.w	Update_status_block
	lea.l	MOBJC_CIL,a0
	lea.l	MOBJCCIL_evaluate,a1
	bsr.w	Update_control_icons
	bsr.w	Display_gold
	bsr.w	Update_quantity_colours
	rts	
; ---- MerchOBJC_DisInit (original source: MAIN/PLACES.ASM)
MerchOBJC_DisInit:
	move.l	#Lay3_PlusMes,PlusMes_info
	move.l	#Code0002Sys,Textfile_ptr
	move.l	#Sold_data,Itemdata_ptr
	move.l	#Sold_slots,Itemslots_ptr
	movea.l	Off_screen,a6
	moveq.l	#3,d0
	bsr.w	Show_layout
	bsr.w	Display_80x80_picture
	bsr.w	Places_DisInit
	lea.l	MOBJC_CIL,a0
	bsr.w	MOBJCCIL_evaluate
	move.l	a0,Control_list_ptr
	bsr.w	Show_control_icons
	bsr.w	Show_objects_LAY3
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	Lay3_L2,a0
	jsr	Set_layout_data
	bra.w	Fadein_lay3
; ---- MOBJCCIL_evaluate (original source: MAIN/PLACES.ASM)
MOBJCCIL_evaluate:
	movem.l	d0/d7/a1,-(sp)
	bclr	#7,(a0)
	bclr	#7,3(a0)
	bclr	#7,4(a0)
	bclr	#7,5(a0)
	movea.l	Warecount_ptr,a1
	move.l	(a1)+,d0
	or.l	(a1)+,d0
	or.l	(a1)+,d0
	bne.s	.Ok
	bset	#7,4(a0)
.Ok:
	movea.l	Current_active_char_data,a1
	lea.l	Inventory_1_place_counter(a1),a1
	move.b	(a1)+,d0
	moveq.l	#11-1,d7
.Loop1:
	or.b	(a1)+,d0
	dbra	d7,.Loop1
	tst.b	d0
	bne.s	.Not_empty1
	bset	#7,3(a0)
.Not_empty1:
	tst.w	Places_gold
	beq.s	.Deac
	movea.l	Warecount_ptr,a1
	move.l	(a1)+,d0
	or.l	(a1)+,d0
	or.l	(a1)+,d0
	beq.s	.Deac
	lea.l	Sold_slots,a1
	move.b	(a1)+,d0
	moveq.l	#11-1,d7
.Loop2:
	and.b	(a1)+,d0
	dbra	d7,.Loop2
	tst.b	d0
	beq.s	.Not_empty2
.Deac:
	bset	#7,(a0)
.Not_empty2:
	lea.l	Sold_slots,a1
	move.l	(a1)+,d0
	or.l	(a1)+,d0
	or.l	(a1)+,d0
	bne.s	.Not_empty3
	bset	#7,5(a0)
.Not_empty3:
	bsr.w	Places_CIL_evaluate
	movem.l	(sp)+,d0/d7/a1
	rts	
; ---- View_item_MOBJC (original source: MAIN/PLACES.ASM)
View_item_MOBJC:
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	lea.l	ViewItemMOBJC_Mod,a0
	bra.w	Push_Module
; ---- ViewItemMOBJC_DisInit (original source: MAIN/PLACES.ASM)
ViewItemMOBJC_DisInit:
	move.l	#Lay3_PlusMes,PlusMes_info
	lea.l	Lay3_PA,a0
	bsr.w	Push_PA
	lea.l	L3_objects_area,a0
	jsr	Push_MA
	move.l	Waredat_ptr,Itemdata_ptr
	move.l	Warecount_ptr,Itemslots_ptr
	movea.l	Off_screen,a6
	movea.l	Textfile_ptr,a0
	move.l	#Code0001Sys,Textfile_ptr
	move.w	#3,d0
	bsr.w	Hash_message
	move.l	a0,Textfile_ptr
	bsr.w	Show_objects_LAY3
	jsr	Switch_screen
	jsr	Copy_screen
	rts	
; ---- ViewItem_objselect (original source: MAIN/PLACES.ASM)
ViewItem_objselect:
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	tst.b	d0
	beq.s	.Exit
	ext.w	d0
	movea.l	Itemslots_ptr,a0
	adda.w	d0,a0
	tst.b	-1(a0)
	beq.s	.Exit
	move.b	d0,Object_slot_number
	lea.l	ItemView1_Mod,a0
	bsr.w	Push_Module
.Exit:
	rts	
; ---- Sell_item (original source: MAIN/PLACES.ASM)
Sell_item:
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	lea.l	SellItem_Mod,a0
	bra.w	Push_Module
SellItem_DisInit:
	move.w	#$70,Mesmin_X
	move.w	#$42,Mesmin_Y
	move.w	#$c0,Mesmin_Wd
	move.l	#Code0002Sys,Textfile_ptr
	move.l	#Lay3_PlusMes,PlusMes_info
	lea.l	Lay3_PA,a0
	bsr.w	Push_PA
; ---- LearnSpell_DisInit (original source: MAIN/EYE.ASM)
LearnSpell_DisInit:
	lea.l	L3_objects_area,a0
	jsr	Push_MA
	movea.l	Current_active_char_data,a0
	lea.l	Inventory_1_place_counter(a0),a1
	lea.l	Inv_data+360(a0),a0
	move.l	a0,Itemdata_ptr
	move.l	a1,Itemslots_ptr
	movea.l	Off_screen,a6
	move.w	#$c,d0	; CHANGE: was "HashMes 11"
	bsr.w	Hash_message
	bsr.w	Show_objects_LAY3
	jsr	Switch_screen
	jsr	Copy_screen
	rts	
; ---- SellItem_DisExit (original source: MAIN/PLACES.ASM)
BuyItem_DisExit:
SellItem_DisExit:
	move.l	#Sold_data,Itemdata_ptr
	move.l	#Sold_slots,Itemslots_ptr
	movea.l	Off_screen,a6
	bsr.w	Show_objects_LAY3
	bsr.w	Erase_text_window
	jsr	Switch_screen
	jsr	Copy_screen
	bsr.w	Pop_PA
	jsr	Pop_MA
	rts	

; ---- BuyItem_objselect (original source: MAIN/PLACES.ASM) - the shipped program differs, its code follows, not assembled:
;BuyItem_objselect:
;             Wait_4_unclick
;             tst.b     d0                   ; Any slot selected ?
;             beq       .Exit
;             move.b    d0,Object_slot_number
;             ext.w     d0                   ; Calculate pointers to item
;             subq.w    #1,d0                ; data
;             movea.l   Itemslots_ptr,a1
;             movea.l   Itemdata_ptr,a2
;             adda.w    d0,a1
;             mulu.w    #40,d0
;             adda.w    d0,a2
;             tst.b     (a1)                 ; Any object in this slot ?
;             beq.s     .Exit
;             move.w    Total_price,d1       ; Enough dough ?
;             cmp.w     Places_gold,d1
;             bgt.s     .Exit
;             btst      #2,Item_stat_bits(a2)      ; Multiple item ?
;             beq.s     .One
;             cmpi.b    #1,(a1)              ; Only one item ?
;             bne.s     .Multiple
;.One:        move.l    #1,ItemW_nr          ; One item
;             Push      Module,BuyReq_Mod
;             rts
;.Multiple:   moveq.l   #0,d1                ; How many can you buy ?
;             move.w    Places_gold,d1
;             divu.w    Total_price,d1
;             cmpi.w    #1,d1                ; Only one ?
;             beq.s     .One
;             cmpi.w    #100,d1              ; Too much ?
;             bmi.s     .Not2much
;             moveq.l   #99,d1
;.Not2much:   ext.l     d1                   ; How many do you want ?
;             move.l    d1,Original_number
;             clr.l     ItemW_nr
;             Push      Module,BuyMItem_Mod
;.Exit:       rts

; ---- SellItem_DisUpd (original source: MAIN/PLACES.ASM)
SellItem_DisUpd:
	bsr.w	Update_status_block
	bsr.w	Update_quantity_colours
	bsr.w	Display_gold
	rts	
; ---- SellItem_objselect (original source: MAIN/PLACES.ASM)
SellItem_objselect:
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	tst.b	d0
	beq.s	.Exit
	move.b	d0,Object_slot_number
	ext.w	d0
	subq.w	#1,d0
	movea.l	Itemslots_ptr,a1
	movea.l	Itemdata_ptr,a2
	adda.w	d0,a1
	mulu.w	#40,d0
	adda.w	d0,a2
	tst.b	(a1)
	beq.s	.Exit
	btst	#1,Item_stat_bits(a2)
	beq.s	.Exit
	cmpi.w	#2,Price(a2)
	bmi.s	.Exit
	btst	#2,Item_stat_bits(a2)
	beq.s	.Single
	cmpi.b	#1,(a1)
	bhi.s	.Multiple
.Single:
	move.l	#1,ItemW_nr
	lea.l	SellReq_Mod,a0
	bsr.w	Push_Module
	rts	
.Multiple:
	moveq.l	#0,d0
	move.b	(a1),d0
	move.l	d0,Original_number
	clr.l	ItemW_nr
	lea.l	SellMItem_Mod,a0
	bsr.w	Push_Module
.Exit:
	rts	
; ---- SellMItem_DisInit (original source: MAIN/PLACES.ASM)
SellMItem_DisInit:
	movem.l	d0/d1/a0-a2/a6,-(sp)
	move.w	#First_add,Adding
	moveq.l	#15,d0
	jsr	IG_Set_ink
	moveq.l	#2,d0
	jsr	IG_Set_paper
	bsr.w	ItemW_DisInit
	movea.l	Itemslots_ptr,a1
	movea.l	Itemdata_ptr,a2
	move.b	Object_slot_number,d0
	ext.w	d0
	subq.w	#1,d0
	adda.w	d0,a1
	mulu.w	#40,d0
	adda.w	d0,a2
	movea.l	Off_screen,a6
	move.b	(a2),d0
	moveq.l	#0,d1
	bsr.w	INV2_Show_object
	move.w	#49+18,d0
	move.w	#80+18+32,d1
	jsr	IG_Set_cursor
	move.w	Name_word_nr(a2),d0
	bsr.w	Get_word
	lea.l	Line_buffer,a0
	jsr	IG_Print
	move.w	#32+17,d0
	move.w	#80+38+32,d1
	jsr	IG_Set_cursor
	moveq.l	#15,d0
	lea.l	Code0002Sys,a1
	bsr.w	Convert_text_line
	lea.l	Line_buffer,a0
	jsr	IG_Print
	jsr	Switch_screen
	jsr	Copy_screen
	movem.l	(sp)+,d0/d1/a0-a2/a6
	rts	
; ---- SellMItem_Return (original source: MAIN/PLACES.ASM)
SellMItem_Return:
	tst.l	ItemW_nr
	bne.s	.Go_on
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	rts	
.Go_on:
	lea.l	SellReq_Mod,a0
	bsr.w	Push_Module
	rts	
; ---- SellReq_ModInit (original source: MAIN/PLACES.ASM)
SellReq_ModInit:
	move.l	ItemW_nr,d6
	movea.l	Itemdata_ptr,a1
	move.b	Object_slot_number,d0
	ext.w	d0
	subq.w	#1,d0
	mulu.w	#40,d0
	adda.w	d0,a1
	movea.l	Off_screen,a6
	lea.l	Lay3_PA,a0
	bsr.w	Push_PA
	bsr.w	Erase_text_window
	move.w	Name_word_nr(a1),d0
	bsr.w	Get_word
	lea.l	Line_buffer,a0
	jsr	IG_Print
	cmpi.w	#1,d6
	beq.s	.Single
	lea.l	Multi_txt,a0
	jsr	IG_Print
	move.w	d6,d0
	moveq.l	#2,d7
	lea.l	Line_buffer,a0
	movea.l	a0,a3
	bsr.w	LConvert_number
	jsr	IG_Print
.Single:
	jsr	IG_Carriage_return
	move.l	a1,-(sp)
	moveq.l	#14,d0
	lea.l	Code0002Sys,a1
	bsr.w	Convert_text_line
	movea.l	(sp)+,a1
	lea	Line_buffer,a0
	jsr	IG_Print
	jsr	IG_Carriage_return
	moveq.l	#0,d1
	move.w	Price(a1),d1
	divu.w	#3,d1
	movea.l	Current_active_char_data,a2
	moveq.l	#0,d2
	move.w	Attr_6_normal(a2),d2
	add.w	Attr_6_normal_magic(a2),d2
	divu.w	#10,d2
	mulu.w	Price(a1),d2
	divu.w	#100,d2
	add.l	d2,d1
	mulu.w	d6,d1
	move.w	d1,Total_price
	move.l	d1,d0
	moveq.l	#5,d7
	lea.l	Line_buffer,a0
	movea.l	a0,a3
	bsr.w	LConvert_number
	move.b	#" ",(a3)+
	clr.b	(a3)
	jsr	IG_Print
	lea.l	Gold_txt,a0
	jsr	IG_Print
	moveq.l	#2,d6
	moveq.l	#16,d7
	move.w	#240,d0
	move.w	#81,d1
	lea.l	Control_icn+6912,a0
	jsr	Blot_unmasked_block
	addi.w	#32,d0
	lea.l	Control_icn+7168,a0
	jsr	Blot_unmasked_block
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	SellReq_L2,a0
	jsr	Set_layout_data
	lea.l	Lay3_PlusMes,a0
	jsr	Push_MA
	rts	
; ---- SellReq_ModExit (original source: MAIN/PLACES.ASM)
BuyTRANSReq_ModExit:
SellReq_ModExit:
	movea.l	Off_screen,a6
	bsr.w	Erase_text_window
	jsr	Switch_screen
	jsr	Copy_screen
	jsr	Pop_MA
	bsr.w	Pop_PA
	lea.l	Lay3_L2,a0
	jsr	Set_layout_data
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	movea.l	Itemslots_ptr,a0
	move.b	(a0)+,d0
	moveq.l	#11-1,d7
.Loop:
	or.b	(a0)+,d0
	dbra	d7,.Loop
	tst.b	d0
	bne.s	.Exit
	bsr.w	Pop_Module
.Exit:
	rts	
; ---- SellYes (original source: MAIN/PLACES.ASM)
SellYes:
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	movea.l	Itemslots_ptr,a0
	movea.l	Itemdata_ptr,a1
	move.b	Object_slot_number,d0
	ext.w	d0
	subq.w	#1,d0
	adda.w	d0,a0
	mulu.w	#40,d0
	adda.w	d0,a1
	movea.l	Current_active_char_data,a2
	move.l	ItemW_nr,d0
	sub.b	d0,(a0)
	mulu.w	Weight(a1),d0
	sub.l	d0,Weight_normal(a2)
	move.w	Total_price,d0
	add.w	d0,Places_gold
	movea.l	Off_screen,a6
	bsr.w	Show_objects_LAY3
	jsr	Switch_screen
	jsr	Copy_screen
	bra.w	Pop_Module
; ---- Buy_item (original source: MAIN/PLACES.ASM)
Buy_item:
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	lea.l	BuyItem_Mod,a0
	bra.w	Push_Module
; ---- BuyItem_DisInit (original source: MAIN/PLACES.ASM)
BuyItem_DisInit:
	move.w	#112,Mesmin_X
	move.w	#66,Mesmin_Y
	move.w	#192,Mesmin_Wd
	move.l	#Code0003Sys,Textfile_ptr
	move.l	#Lay3_PlusMes,PlusMes_info
	lea.l	Lay3_PA,a0
	bsr.w	Push_PA
	lea.l	L3_objects_area,a0
	jsr	Push_MA
	move.l	Waredat_ptr,Itemdata_ptr
	move.l	Warecount_ptr,Itemslots_ptr
	movea.l	Off_screen,a6
	move.w	#21,d0
	bsr.w	Hash_message
	bsr.w	Show_objects_LAY3
	jsr	Switch_screen
	jsr	Copy_screen
	rts	
T_0be40:
	move.l	#Sold_data,Itemdata_ptr
	move.l	#Sold_slots,Itemslots_ptr
	movea.l	Off_screen,a6
	bsr.w	Show_objects_LAY3
	bsr.w	Erase_text_window
	jsr	Switch_screen
	jsr	Copy_screen
	bsr.w	Pop_PA
	jsr	Pop_MA
	rts
T_0be7a:
	btst	#$1,Mouse_button_state
	bne.b	T_0be7a
	tst.b	d0
	beq.w	T_0bf1c
	move.b	d0,Object_slot_number
	ext.w	d0
	subq.w	#$1,d0
	movea.l	Itemslots_ptr,a1
	movea.l	Itemdata_ptr,a2
	adda.w	d0,a1
	mulu.w	#$28,d0
	adda.w	d0,a2
	tst.b	(a1)
	beq.b	T_0bf1c
	move.w	Total_price,d1
	cmp.w	Places_gold,d1
	bgt.b	T_0bf1c
	btst	#$2,$18(a2)
	beq.b	T_0bec8
	cmpi.b	#$1,(a1)
	bne.b	T_0bede
T_0bec8:
	move.l	#$1,ItemW_nr
	lea.l	BuyReq_Mod,a0
	bsr.w	Push_Module
	rts
T_0bede:
	moveq	#0,d0
	move.b	(a1),d0
	moveq	#0,d1
	move.w	Places_gold,d1
	divu.w	Total_price,d1
	cmpi.w	#$1,d1
	beq.b	T_0bec8
	cmpi.w	#$64,d1
	bmi.b	.l_0befe
	moveq	#99,d1
.l_0befe:
	cmp.w	d1,d0
	bpl.b	.l_0bf04
	move.w	d0,d1
.l_0bf04:
	ext.l	d1
	move.l	d1,Original_number
	clr.l	ItemW_nr
	lea.l	BuyMItem_Mod,a0
	bsr.w	Push_Module
T_0bf1c:
	rts
; ---- BuyMItem_DisInit (original source: MAIN/PLACES.ASM)
BuyMItem_DisInit:
	move.w	#First_add,Adding
	moveq.l	#15,d0
	jsr	IG_Set_ink
	moveq.l	#2,d0
	jsr	IG_Set_paper
	bsr.w	ItemW_DisInit
	movea.l	Itemslots_ptr,a1
	movea.l	Itemdata_ptr,a2
	move.b	Object_slot_number,d0
	ext.w	d0
	subq.w	#1,d0
	adda.w	d0,a1
	mulu.w	#40,d0
	adda.w	d0,a2
	movea.l	Off_screen,a6
	move.b	(a2),d0
	moveq.l	#0,d1
	bsr.w	INV2_Show_object
	move.w	#49+18,d0
	move.w	#80+18+32,d1
	jsr	IG_Set_cursor
	move.w	Name_word_nr(a2),d0
	bsr.w	Get_word
	lea.l	Line_buffer,a0
	jsr	IG_Print
	move.w	#32+17,d0
	move.w	#80+38+32,d1
	jsr	IG_Set_cursor
	moveq.l	#22,d0
	lea.l	Code0003Sys,a1
	bsr.w	Convert_text_line
	lea.l	Line_buffer,a0
	jsr	IG_Print
	jsr	Switch_screen
	jsr	Copy_screen
	rts	
; ---- BuyMItem_Return (original source: MAIN/PLACES.ASM)
BuyMItem_Return:
	tst.l	ItemW_nr
	bne.s	.Go_on
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	bra.w	Pop_Module
.Go_on:
	lea.l	BuyReq_Mod,a0
	bsr.w	Push_Module
.Exit:
	rts	
; ---- BuyReq_ModInit (original source: MAIN/PLACES.ASM)
BuyReq_ModInit:
	movea.l	Off_screen,a6
	lea.l	Lay3_PA,a0
	bsr.w	Push_PA
	bsr.w	Erase_text_window
	movea.l	Itemdata_ptr,a1
	move.b	Object_slot_number,d0
	ext.w	d0
	subq.w	#1,d0
	mulu.w	#40,d0
	adda.w	d0,a1
	move.w	Name_word_nr(a1),d0
	bsr.w	Get_word
	lea.l	Line_buffer,a0
	jsr	IG_Print
	move.l	ItemW_nr,d6
	cmpi.w	#1,d6
	beq.s	.Single
	lea.l	Multi_txt,a0
	jsr	IG_Print
	move.w	d6,d0
	moveq.l	#2,d7
	lea.l	Line_buffer,a0
	movea.l	a0,a3
	bsr.w	LConvert_number
	jsr	IG_Print
.Single:
	jsr	IG_Carriage_return
	moveq.l	#23,d0
	lea.l	Code0003Sys,a1
	bsr.w	Convert_text_line
	lea	Line_buffer,a0
	jsr	IG_Print
	jsr	IG_Carriage_return
	move.w	Total_price,d0
	mulu.w	d6,d0
	moveq.l	#5,d7
	lea.l	Line_buffer,a0
	movea.l	a0,a3
	bsr.w	LConvert_number
	move.b	#" ",(a3)+
	clr.b	(a3)
	jsr	IG_Print
	lea.l	Gold_txt,a0
	jsr	IG_Print
	moveq.l	#2,d6
	moveq.l	#16,d7
	move.w	#240,d0
	move.w	#81,d1
	lea.l	Control_icn+6912,a0
	jsr	Blot_unmasked_block
	addi.w	#32,d0
	lea.l	Control_icn+7168,a0
	jsr	Blot_unmasked_block
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	SellReq_L2,a0
	jsr	Set_layout_data
	lea.l	Lay3_PlusMes,a0
	jsr	Push_MA
	rts	
; ---- BuyReq_ModExit (original source: MAIN/PLACES.ASM)
BuyReq_ModExit:
	movea.l	Off_screen,a6
	bsr.w	Erase_text_window
	jsr	Switch_screen
	jsr	Copy_screen
	jsr	Pop_MA
	bsr.w	Pop_PA
	lea.l	Lay3_L2,a0
	jsr	Set_layout_data
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	movea.l	Warecount_ptr,a0
	tst.l	(a0)+
	bne.s	.Exit
	tst.l	(a0)+
	bne.s	.Exit
	tst.l	(a0)+
	bne.s	.Exit
	bsr.w	Pop_Module
.Exit:
	rts	

; ---- BuyYes (original source: MAIN/PLACES.ASM) - the shipped program differs, its code follows, not assembled:
;BuyYes:
;             Wait_4_unclick
;             movea.l   Itemslots_ptr,a0     ; Get pointer to item slot
;             movea.l   Itemdata_ptr,a1      ; & item data
;             move.b    Object_slot_number,d0
;             ext.w     d0
;             subq.w    #1,d0
;             adda.w    d0,a0
;             mulu.w    #40,d0
;             adda.w    d0,a1
;             moveq.l   #1,d1
;             btst      #2,Item_stat_bits(a1)      ; Multiple item ?
;             beq       .Continue
;             cmpi.b    #1,(a0)              ; More as one in slot ?
;             bhi.s     .Multiple
;             move.l    d1,ItemW_nr
;; ------------- Search for a slot already containing this item -------
;.Multiple:   lea.l     Sold_slots,a4
;             lea.l     Sold_data,a5
;             move.w    Item_ID(a1),d0
;             move.l    ItemW_nr,d1
;             moveq.l   #12-1,d7
;.Loop1:      tst.b     (a4)                 ; Anything there ?
;             beq.s     .Next1
;             cmp.w     Item_ID(a5),d0       ; Same item ?
;             bne.s     .Next1
;             cmpi.b    #99,(a4)             ; Not full ?
;             bmi.s     .Found1
;.Next1:      addq.l    #1,a4
;             lea.l     40(a5),a5
;             dbra      d7,.Loop1
;             bra       .Continue
;.Found1:     moveq.l   #0,d0                ; Does it fit in the slot ?
;             move.b    (a4),d0
;             add.w     d1,d0
;             cmpi.w    #99,d0
;             bls       .Do_it
;             moveq.l   #99,d2               ; Calculate number that will
;             sub.b     (a4),d2              ; fit
;             sub.l     d2,ItemW_nr
;             move.b    #99,(a4)             ; Fill slot
;             cmpi.b    #-1,(a0)             ; Infinite slot ?
;             beq       .Multiple
;             sub.b     d2,(a0)              ; Remove item(s)
;             bra       .Multiple
;; ------------- Search for a free slot then transfer the item --------
;.Continue:   lea.l     Sold_slots,a4
;             lea.l     Sold_data,a5
;             moveq.l   #12-1,d7
;.Loop2:      tst.b     (a4)                 ; Free slot ?
;             beq.s     .Do_it
;             addq.l    #1,a4                ; Next slot
;             lea.l     40(a5),a5
;             dbra      d7,.Loop2
;             bra       .Exit
;.Do_it:      add.b     d1,(a4)              ; Fill slot
;             moveq.l   #20-1,d7             ; Copy item data
;.Loop3:      move.w    (a1)+,(a5)+
;             dbra      d7,.Loop3
;             lea.l     -40(a1),a1
;             cmpi.b    #-1,(a0)             ; Infinite slot ?
;             beq.s     .Infinity
;             sub.b     d1,(a0)              ; Remove item(s)
;.Infinity:   move.l    ItemW_nr,d0          ; Pay the price
;             mulu.w    Total_price,d0
;             sub.w     d0,Places_gold
;             movea.l   Off_screen,a6        ; Redraw objects
;             jsr       Show_objects_LAY3
;             Update_screen
;.Exit:       jmp       Pop_Module

T_0c138:
	btst	#$1,Mouse_button_state
	bne.b	T_0c138
	movea.l	Itemslots_ptr,a0
	movea.l	Itemdata_ptr,a1
	move.b	Object_slot_number,d0
	ext.w	d0
	subq.w	#$1,d0
	adda.w	d0,a0
	mulu.w	#$28,d0
	adda.w	d0,a1
	moveq	#1,d1
	btst	#$2,$18(a1)
	beq.b	.l_0c1ce
	cmpi.b	#$1,(a0)
	bhi.b	.l_0c176
	move.l	d1,ItemW_nr
.l_0c176:
	lea.l	Sold_slots,a4
	lea.l	Sold_data,a5
	move.w	$24(a1),d0
	move.l	ItemW_nr,d1
	moveq	#11,d7
.l_0c18e:
	tst.b	(a4)
	beq.b	.l_0c19e
	cmp.w	$24(a5),d0
	bne.b	.l_0c19e
	cmpi.b	#$63,(a4)
	bmi.b	.l_0c1aa
.l_0c19e:
	addq.l	#$1,a4
	lea.l	$28(a5),a5
	dbra	d7,.l_0c18e
	bra.b	.l_0c1ce
.l_0c1aa:
	moveq	#0,d0
	move.b	(a4),d0
	add.w	d1,d0
	cmpi.w	#$63,d0
	bls.b	.l_0c1ec
	moveq	#99,d2
	sub.b	(a4),d2
	sub.l	d2,ItemW_nr
	move.b	#$63,(a4)
	dc.w	$0c10,$ffff	; cmpi.b #$ff, (a0)
	beq.b	.l_0c176
	sub.b	d2,(a0)
	bra.b	.l_0c176
.l_0c1ce:
	lea.l	Sold_slots,a4
	lea.l	Sold_data,a5
	moveq	#11,d7
.l_0c1dc:
	tst.b	(a4)
	beq.b	.l_0c1ec
	addq.l	#$1,a4
	lea.l	$28(a5),a5
	dbra	d7,.l_0c1dc
	bra.b	.l_0c22a
.l_0c1ec:
	add.b	d1,(a4)
	moveq	#19,d7
.l_0c1f0:
	move.w	(a1)+,(a5)+
	dbra	d7,.l_0c1f0
	lea.l	-$28(a1),a1
	dc.w	$0c10,$ffff	; cmpi.b #$ff, (a0)
	beq.b	.l_0c202
	sub.b	d1,(a0)
.l_0c202:
	move.l	ItemW_nr,d0
	mulu.w	Total_price,d0
	sub.w	d0,Places_gold
	movea.l	Off_screen,a6
	bsr.w	Show_objects_LAY3

; ---- Transfer_item_CHEST (original source: MAIN/EVENTS.ASM) - the shipped program differs, its code follows, not assembled:
;Transfer_item_CHEST:
;             Wait_4_unclick
;             lea.l     TIChest_Mod,a0
;             jmp       Push_Module

	jsr	Switch_screen
	jsr	Copy_screen
.l_0c22a:
	bra.w	Pop_Module
; ---- Transfer_item_MOBJC (original source: MAIN/PLACES.ASM)
Transfer_item_MOBJC:
	lea.l	TIMOBJC_Mod,a0
	bra.w	Push_Module
; ---- TIMOBJC_DisInit (original source: MAIN/PLACES.ASM)
TIChest_DisInit:
TIMOBJC_DisInit:
	movem.l	d0/a6,-(sp)
	move.w	#112,Mesmin_X
	move.w	#66,Mesmin_Y
	move.w	#192,Mesmin_Wd
	move.l	#Code0001Sys,Textfile_ptr
	lea.l	Lay3_L2,a0
	jsr	Push_MA
	movea.l	Off_screen,a6
	move.w	#4,d0
	bsr.w	Minus_message
	jsr	Switch_screen
	jsr	Copy_screen
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	movem.l	(sp)+,d0/a6
	rts	
; ---- Do_TIMOBJC (original source: MAIN/PLACES.ASM)
Do_TIMOBJC:
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	tst.b	d0
	bne.s	.A_slot
.Exit:
	bra.w	Pop_Module
.A_slot:
	move.b	d0,Object_slot_number
	movea.l	Itemslots_ptr,a1	; CHANGE: was "lea.l Sold_slots,a1"
	movea.l	Itemdata_ptr,a2	; CHANGE: was "lea.l Sold_data,a2"
	ext.w	d0
	subq.w	#1,d0
	adda.w	d0,a1
	mulu.w	#40,d0
	adda.w	d0,a2
	tst.b	(a1)
	beq.s	.Exit
	moveq.l	#-1,d1
	btst	#2,Item_stat_bits(a2)
	beq.s	.Single_L1
	cmpi.b	#1,(a1)
	bhi.s	.Multiple_L1
	move.w	Item_ID(a2),d1
.Single_L1:
	moveq.l	#0,d0
	move.w	Weight(a2),d0
	moveq.l	#1,d2
	bra.w	MOBJC_TI_2
.Multiple_L1:
	moveq.l	#0,d0
	move.b	(a1),d0
	move.l	d0,Original_number
	clr.l	ItemW_nr
	lea.l	TMI_MOBJC_Mod,a0
	bsr.w	Push_Module
	rts	
; ---- TMI_MOBJC_DisInit (original source: MAIN/PLACES.ASM)
TMI_MOBJC_DisInit:
	movem.l	d0-d7/a0-a6,-(sp)
	move.w	#First_add,Adding
	moveq.l	#15,d0
	jsr	IG_Set_ink
	moveq.l	#2,d0
	jsr	IG_Set_paper
	bsr.w	ItemW_DisInit
	move.b	Object_slot_number,d0
	ext.w	d0
	subq.w	#$1,d0	; CHANGE: was "lea.l Sold_slots-1,a2"
	movea.l	Itemslots_ptr,a2	; CHANGE: was "lea.l Sold_data-40,a3"
	movea.l	Itemdata_ptr,a3	; CHANGE: added
	adda.w	d0,a2
	mulu.w	#40,d0
	adda.w	d0,a3
	movea.l	Off_screen,a6
	move.b	(a3),d0
	moveq.l	#0,d1
	bsr.w	INV2_Show_object
	move.w	#49+18,d0
	move.w	#80+18+32,d1
	jsr	IG_Set_cursor
	move.w	Name_word_nr(a3),d0
	bsr.w	Get_word
	lea.l	Line_buffer,a0
	jsr	IG_Print
	move.w	#32+17,d0
	move.w	#80+38+32,d1
	jsr	IG_Set_cursor
	moveq.l	#14,d0
	lea.l	Code0001Sys,a1
	bsr.w	Convert_text_line
	lea.l	Line_buffer,a0
	jsr	IG_Print
	jsr	Switch_screen
	jsr	Copy_screen
	movem.l	(sp)+,d0-d7/a0-a6
	rts	
; ---- TMI_MOBJC_Return (original source: MAIN/PLACES.ASM)
TMI_MOBJC_Return:
	movea.l	Itemdata_ptr,a0	; CHANGE: was "lea.l Sold_data-40,a0"
	move.b	Object_slot_number,d0
	ext.w	d0
	subq.w	#$1,d0	; CHANGE: added
	mulu.w	#40,d0
	adda.w	d0,a0
	move.l	ItemW_nr,d0
	bne.s	.Not_zero
	bra.w	Pop_Module
.Not_zero:
	mulu.w	Weight(a0),d0
	move.w	Item_ID(a0),d1
; ---- MOBJC_TI_2 (original source: MAIN/PLACES.ASM)
MOBJC_TI_2:
	suba.l	a0,a0
	bsr.w	Scan_4_transfer_victims
	bne.s	.Go
	move.w	#5,d0
	bsr.w	Plus_message
	bsr.w	Pop_Module
	bra.s	.Exit
.Go:
	bsr.w	Show_transfer_victims
	movea.l	Itemdata_ptr,a0	; CHANGE: was "lea.l Sold_data,a0"
	move.b	Object_slot_number,d0
	ext.w	d0
	subq.w	#$1,d0	; CHANGE: added
	mulu.w	#40,d0
	move.b	(a0,d0.w),TIVS_Icon_nr	; CHANGE: was "move.b -40(a0,d0.w),TIVS_Icon_nr"
	move.l	#MOBJC_TI_3,TIVS_Ptr
	lea.l	TIVS2_Mod,a0
	move.w	#24,Mouse_ptr(a0)
	bsr.w	Push_Module
.Exit:
	rts	

; ---- MOBJC_TI_3 (original source: MAIN/PLACES.ASM) - the shipped program differs, its code follows, not assembled:
;MOBJC_TI_3:
;             lea.l     Sold_slots-1,a2      ; Initialize registers
;             lea.l     Sold_data-40,a3
;             move.b    Object_slot_number,d0
;             ext.w     d0
;             adda.w    d0,a2
;             mulu.w    #40,d0
;             adda.w    d0,a3
;
;; ------------- REGISTER CONTENTS ------------------------------------
;;  a0 - Pointer to victim's character data (.l)
;;  a2 - Pointer to transferred object's slot (.l)
;;  a3 - Pointer to transferred object's data (.l)
;
;             moveq.l   #1,d1
;             btst      #2,Item_stat_bits(a3)      ; Multiple item ?
;             beq       .Continue
;             cmpi.b    #1,(a2)              ; More as one in slot ?
;             bhi.s     .Multiple
;             move.l    d1,ItemW_nr
;; ------------- Search for a slot already containing this item -------
;.Multiple:   lea.l     Inventory_1_place_counter(a0),a4
;             lea.l     Inv_data+360(a0),a5
;             move.w    Item_ID(a3),d0
;             move.l    ItemW_nr,d1
;             moveq.l   #12-1,d7
;.Loop1:      tst.b     (a4)                 ; Anything there ?
;             beq.s     .Next1
;             cmp.w     Item_ID(a5),d0       ; Same item ?
;             bne.s     .Next1
;             cmpi.b    #99,(a4)             ; Not full ?
;             bmi.s     .Found1
;.Next1:      addq.l    #1,a4
;             lea.l     40(a5),a5
;             dbra      d7,.Loop1
;             bra       .Continue
;.Found1:     moveq.l   #0,d0                ; Does it fit in the slot ?
;             move.b    (a4),d0
;             add.w     d1,d0
;             cmpi.w    #99,d0
;             bls       .Do_it
;             moveq.l   #99,d2               ; Calculate number that will
;             sub.b     (a4),d2              ; fit
;             sub.l     d2,ItemW_nr
;             move.b    #99,(a4)             ; Fill slot
;             sub.b     d2,(a2)              ; Remove item(s)
;             mulu.w    Weight(a3),d2        ; Adjust weight
;             add.l     d2,Weight_normal(a0)
;             bra       .Multiple
;; ------------- Search for a free slot then transfer the item --------
;.Continue:   lea.l     Inventory_1_place_counter(a0),a4
;             lea.l     Inv_data+360(a0),a5
;             moveq.l   #12-1,d7
;.Loop2:      tst.b     (a4)                 ; Free slot ?
;             beq.s     .Do_it
;             addq.l    #1,a4
;             lea.l     40(a5),a5
;             dbra      d7,.Loop2
;             bra       .Exit
;.Do_it:      moveq.l   #0,d2                ; Adjust weight
;             move.b    d1,d2
;             mulu.w    Weight(a3),d2
;             add.l     d2,Weight_normal(a0)
;             add.b     d1,(a4)              ; Fill slot
;             moveq.l   #20-1,d7             ; Copy item data
;.Loop3:      move.w    (a3)+,(a5)+
;             dbra      d7,.Loop3
;             lea.l     -40(a3),a3
;             sub.b     d1,(a2)              ; Remove item(s)
;             bne.s     .Skip
;             lea.l     Door_object_pos_list-4,a0  ; Erase object icon
;             moveq.l   #0,d0
;             move.b    Object_slot_number,d0
;             add.w     d0,d0
;             add.w     d0,d0
;             adda.w    d0,a0
;             move.w    (a0)+,d0
;             move.w    (a0)+,d1
;             lea.l     Layout_icn+9856,a0
;             movea.l   Off_screen,a6
;             jsr       Put_unmasked_block
;             Update_screen
;             bra.s     .Go_on
;.Skip:       cmpi.b    #1,(a2)              ; Remove quantity ?
;             bne.s     .Go_on
;             lea.l     Door_object_pos_list-4,a0  ; Erase object icon
;             moveq.l   #0,d0
;             move.b    Object_slot_number,d0
;             add.w     d0,d0
;             add.w     d0,d0
;             adda.w    d0,a0
;             move.w    (a0)+,d0
;             move.w    (a0)+,d1
;             lea.l     Layout_icn+9856,a0
;             movea.l   Off_screen,a6
;             jsr       Put_unmasked_block
;             lea.l     Objects_icn,a0       ; Redraw object icon
;             moveq.l   #0,d2
;             move.b    (a3),d2
;             lsl.w     #7,d2
;             adda.w    d2,a0
;             jsr       Put_masked_block
;             Update_screen
;.Go_on:      lea.l     Sold_slots,a0        ; All transferred ?
;             tst.l     (a0)+
;             bne.s     .Exit
;             tst.l     (a0)+
;             bne.s     .Exit
;             tst.l     (a0)+
;             bne.s     .Exit
;             Pop       Module
;.Exit:       rts

MOBJC_TI_3:
	movea.l	Itemslots_ptr,a2
	movea.l	Itemdata_ptr,a3
	move.b	Object_slot_number,d0
	ext.w	d0
	subq.w	#$1,d0
	adda.w	d0,a2
	mulu.w	#$28,d0
	adda.w	d0,a3
	moveq	#1,d1
	btst	#$2,$18(a3)
	beq.b	.l_0c4b0
	cmpi.b	#$1,(a2)
	bhi.b	.l_0c45a
	move.l	d1,ItemW_nr
.l_0c45a:
	lea.l	$2b(a0),a4
	lea.l	$29a(a0),a5
	move.w	$24(a3),d0
	move.l	ItemW_nr,d1
	moveq	#11,d7
.l_0c46e:
	tst.b	(a4)
	beq.b	.l_0c47e
	cmp.w	$24(a5),d0
	bne.b	.l_0c47e
	cmpi.b	#$63,(a4)
	bmi.b	.l_0c48a
.l_0c47e:
	addq.l	#$1,a4
	lea.l	$28(a5),a5
	dbra	d7,.l_0c46e
	bra.b	.l_0c4b0
.l_0c48a:
	moveq	#0,d0
	move.b	(a4),d0
	add.w	d1,d0
	cmpi.w	#$63,d0
	bls.b	.l_0c4cc
	moveq	#99,d2
	sub.b	(a4),d2
	sub.l	d2,ItemW_nr
	move.b	#$63,(a4)
	sub.b	d2,(a2)
	mulu.w	$22(a3),d2
	add.l	d2,$ec(a0)
	bra.b	.l_0c45a
.l_0c4b0:
	lea.l	$2b(a0),a4
	lea.l	$29a(a0),a5
	moveq	#11,d7
.l_0c4ba:
	tst.b	(a4)
	beq.b	.l_0c4cc
	addq.l	#$1,a4
	lea.l	$28(a5),a5
	dbra	d7,.l_0c4ba
	bra.w	.l_0c588
.l_0c4cc:
	moveq	#0,d2
	move.b	d1,d2
	mulu.w	$22(a3),d2
	add.l	d2,$ec(a0)
	add.b	d1,(a4)
	moveq	#19,d7
.l_0c4dc:
	move.w	(a3)+,(a5)+
	dbra	d7,.l_0c4dc
	lea.l	-$28(a3),a3
	sub.b	d1,(a2)
	bne.b	.l_0c522
	lea.l	D_28f40,a0
	moveq	#0,d0
	move.b	Object_slot_number,d0
	add.w	d0,d0
	add.w	d0,d0
	adda.w	d0,a0
	move.w	(a0)+,d0
	move.w	(a0)+,d1
	lea.l	D_3936a,a0
	movea.l	Off_screen,a6
	jsr	Put_unmasked_block
	jsr	Switch_screen
	jsr	Copy_screen
	bra.b	.l_0c572
.l_0c522:
	dc.b	$0c,$12,$00,$01,$66,$4a,$41,$f9
	dc.l	D_28f40
	dc.b	$70,$00,$10,$39
	dc.l	Object_slot_number
	dc.b	$d0,$40,$d0,$40,$d0,$c0,$30,$18,$32,$18,$41,$f9
	dc.l	D_3936a
	dc.b	$2c,$79
	dc.l	Off_screen
	dc.b	$4e,$b9
	dc.l	Put_unmasked_block
	dc.b	$41,$f9
	dc.l	Objects_icn
	dc.b	$74,$00,$14,$13,$ef,$4a,$d0,$c2,$4e,$b9
	dc.l	Put_masked_block
	dc.b	$4e,$b9
	dc.l	Switch_screen
	dc.b	$4e,$b9
	dc.l	Copy_screen
.l_0c572:
	dc.b	$20,$79
	dc.l	Itemslots_ptr
	dc.b	$4a,$98,$66,$0c,$4a,$98,$66,$08,$4a,$98,$66,$04,$61,$00,$44,$50
.l_0c588:
	rts
; ---- Show3_object_name (original source: MAIN/PLACES.ASM)
Show3_object_name:
	tst.b	d0
	beq.s	.Exit
	movea.l	Itemdata_ptr,a0
	movea.l	Itemslots_ptr,a1
	ext.w	d0
	tst.b	-1(a1,d0.w)
	beq.s	.Exit
	mulu.w	#40,d0
	lea.l	-40(a0,d0.w),a0
	cmpi.b	#17,Item_type(a0)
	beq.s	.Exit
	move.w	Name_word_nr(a0),d0
	cmp.w	Object_name_nr,d0
	beq.s	.Exit
	move.w	d0,Object_name_nr
	btst	#1,Item_stat_bits(a0)
	beq.s	.No_sell
	moveq.l	#0,d1
	move.w	Price(a0),d1
	cmpi.w	#2,d1
	bpl.s	.Go_on
.No_sell:
	movea.l	Off_screen,a6
	move.w	#13,d0
	bsr.w	Minus_message
	jsr	Switch_screen
	jsr	Copy_screen
.Go_on:
	move.b	#2,Print_objname_flag
.Exit:
	rts	
; ---- Upd4_objname_erase (original source: MAIN/PLACES.ASM)
Upd3_objname_erase:
Upd4_objname_erase:
	tst.b	Erase_objname_flag
	beq.s	.Exit
	movea.l	Off_screen,a6
	bsr.w	Erase_message_minus
	move.w	#112,d0
	move.w	#73,d1
	move.w	#112+192-1,d2
	move.w	#$4f,d3	; CHANGE: was "move.w #73+14,d3"
	move.w	#2,d6
	jsr	Draw_box
	subq.b	#1,Erase_objname_flag
	clr.w	Object_name_nr
.Exit:
	rts	
; ---- Show4_object_name (original source: MAIN/PLACES.ASM)
Show4_object_name:
	tst.b	d0
	beq.w	.Exit
	movea.l	Itemdata_ptr,a0
	movea.l	Itemslots_ptr,a1
	ext.w	d0
	tst.b	-1(a1,d0.w)
	beq.s	.Exit
	mulu.w	#40,d0
	lea.l	-40(a0,d0.w),a0
	move.w	Name_word_nr(a0),d0
	cmp.w	Object_name_nr,d0
	beq.s	.Exit
	move.w	d0,Object_name_nr
	moveq.l	#0,d1
	move.w	Price(a0),d1
	movea.l	Current_active_char_data,a2
	moveq.l	#0,d2
	move.w	Attr_6_normal(a2),d2
	add.w	Attr_6_normal_magic(a2),d2
	divu.w	#10,d2
	mulu.w	Price(a0),d2
	divu.w	#100,d2
	sub.l	d2,d1
	move.w	d1,Total_price
	cmp.w	Places_gold,d1
	bls.s	.Go_on
	movea.l	Off_screen,a6
	move.w	#24,d0
	bsr.w	Minus_message
	jsr	Switch_screen
	jsr	Copy_screen
.Go_on:
	move.b	#2,Print_objname_flag
.Exit:
	rts	
; ---- Upd4_objname_print (original source: MAIN/PLACES.ASM)
Upd4_objname_print:
	tst.b	Print_objname_flag
	beq.s	.Exit
	lea.l	.Init_string(pc),a0
	jsr	IG_Print
	move.w	Object_name_nr,d0
	beq.s	.Exit
	bsr.w	Get_word
	move.w	#112,d0
	move.w	#73,d1
	move.w	#112+192-1,d2
	move.w	#73+14,d3
	move.w	#2,d6
	movea.l	Off_screen,a6
	jsr	Draw_box
	move.w	#192,d2
	lea.l	Line_buffer,a0
	bsr.w	Print_centered_string
	moveq.l	#0,d0
	move.w	Total_price,d0
	moveq.l	#5,d7
	lea.l	Line_buffer,a0
	movea.l	a0,a3
	bsr.w	LConvert_number
	move.w	#112,d0
	move.w	#73+7,d1
	move.w	#192,d2
	bsr.w	Print_centered_string
	subq.b	#1,Print_objname_flag
.Exit:
	rts	
.Init_string:
	dc.b	1,15,2,-1,0
	even	
T_0c740:
	tst.b	Erase_objname_flag
	beq.b	.l_0c778
	movea.l	Off_screen,a6
	bsr.w	Erase_message_minus
	move.w	#$70,d0
	move.w	#$49,d1
	move.w	#$12f,d2
	move.w	#$57,d3
	move.w	#$2,d6
	jsr	Draw_box
	subq.b	#$1,Erase_objname_flag
	clr.w	Object_name_nr
.l_0c778:
	rts
; ---- MerchFOOD_DisUpd (original source: MAIN/PLACES.ASM)
MerchFOOD_DisUpd:
	bsr.w	Update_status_block
	lea.l	MFOOD_CIL,a0
	lea.l	MFOODCIL_evaluate,a1
	bsr.w	Update_control_icons
	bsr.w	Display_gold
	move.w	Places_food,d0
	moveq.l	#"0",d1
	moveq.l	#4,d7
	lea.l	GoldDis_text+1,a0
	movea.l	a0,a3
	bsr.w	RConvert_number
	move.w	#240,d0
	move.w	#113+8,d1
	move.w	#64,d2
	movea.l	Off_screen,a6
	bsr.w	Print_centered_string
	rts	
; ---- MerchFOOD_DisInit (original source: MAIN/PLACES.ASM)
MerchFOOD_DisInit:
	move.l	#Lay3_PlusMes,PlusMes_info
	movea.l	Off_screen,a6
	moveq.l	#3,d0
	bsr.w	Show_layout
	bsr.w	Display_80x80_picture
	bsr.w	Places_DisInit
	move.w	#240,d0
	move.w	#113,d1
	move.w	#64,d2
	lea.l	Food_txt,a0
	bsr.w	Print_centered_string
	movea.l	Placedat_ptr,a0
	move.w	(a0),Total_price
	lea.l	MFOOD_CIL,a0
	bsr.w	MFOODCIL_evaluate
	move.l	a0,Control_list_ptr
	bsr.w	Show_control_icons
	lea.l	Lay3_PA,a0
	bsr.w	Push_PA
	bsr.w	Init_RText
	moveq.l	#16,d0
	lea.l	Code0004Sys,a1
	bsr.w	Add_encoded_2_RText
	moveq.l	#0,d0
	move.w	Total_price,d0
	moveq.l	#5,d7
	lea.l	Number_buffer,a0
	movea.l	a0,a3
	bsr.w	LConvert_number
	move.b	#$20,(a3)+	; CHANGE: was "move.b #" ",(a3)+"
	clr.b	(a3)
	bsr.w	Add_ASCII_2_RText
	lea.l	Gold_txt,a0
	bsr.w	Add_ASCII_2_RText
; CHANGE: removed "movea.l RText_ptr,a0"
; CHANGE: removed "move.w Nr_of_chars,d0"
; CHANGE: removed "move.w Lines_in_text,d1"
; CHANGE: removed "bra.s .Entry2"
.Loop2:
	bsr.w	T_0707a	; CHANGE: was ".Loop2: jsr IG_Print"
; CHANGE: removed "jsr IG_Carriage_return"
; CHANGE: removed "lea.l 1(a0,d0.w),a0"
; CHANGE: removed ".Entry2: dbra d1,.Loop2"
.Entry2:
	bsr.w	Exit_RText
	bsr.w	Pop_PA
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	Lay3_L2,a0
	jsr	Set_layout_data
	bra.w	Fadein_lay3
; ---- MFOODCIL_evaluate (original source: MAIN/PLACES.ASM)
MFOODCIL_evaluate:
	bclr	#7,3(a0)
	bclr	#7,4(a0)
	bclr	#7,5(a0)
	move.w	Total_price,d0
	cmp.w	Places_gold,d0
	bls.s	.Ok1
	bset	#7,3(a0)
.Ok1:
	tst.w	Places_food
	bne.s	.Ok2
	bset	#7,4(a0)
	bset	#7,5(a0)
.Ok2:
	bsr.w	Places_CIL_evaluate
	rts	
; ---- MFOOD_Transfer_food (original source: MAIN/PLACES.ASM)
MFOOD_Transfer_food:
	move.w	#112,Mesmin_X
	move.w	#63,Mesmin_Y
	move.w	#192,Mesmin_Wd
	move.l	#Code0001Sys,Textfile_ptr
	movea.l	Off_screen,a6
	move.w	#7,d0
	bsr.w	Minus_message
	jsr	Switch_screen
	jsr	Copy_screen
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	moveq.l	#0,d0
	move.w	Places_food,d0
	move.l	d0,Original_number
	clr.l	ItemW_nr
	lea.l	TFMFOOD_Mod,a0
	bsr.w	Push_Module
	rts	
; ---- TFMFOOD_Return (original source: MAIN/PLACES.ASM)
TFMFOOD_Return:
	move.l	ItemW_nr,d0
	beq.w	.Exit
	mulu.w	#Food_weight,d0
	lea.l	Chard_ptrs,a1
	lea.l	Char_status_icons,a4
	moveq.l	#0,d6
	moveq.l	#1,d7
.Loop1:
	tst.l	(a1)
	beq.s	.Next
.Do_it:
	movea.l	(a1),a2
	move.w	Attr_1_normal(a2),d1
	add.w	Attr_1_normal_magic(a2),d1
	mulu.w	#1000,d1
	sub.l	Weight_normal(a2),d1
	cmp.l	d0,d1
	bmi.s	.Next
	move.w	Food_rations(a2),d1
	add.w	d0,d1
	bvs.s	.Next
	move.w	#$e402,d1
	and.w	Body_conditions(a2),d1
	bne.s	.Next
	bset	d7,d6
.Next:
	addq.l	#4,a1
	addq.w	#1,d7
	cmpi.w	#6+1,d7
	bmi.s	.Loop1
	bmi.s	.Loop1
	move.w	d5,Transferring
	move.w	d6,Transfer_victims
	tst.w	d6
	bne.s	.Go
	move.w	#5,d0
	bsr.w	Plus_message
	bsr.w	Pop_Module
	bra.s	.Exit
.Go:
	bsr.w	Show_transfer_victims
	move.l	#Do_TFMFOOD,TIVS_Ptr
	lea.l	TIVS2_Mod,a0
	move.w	#26,Mouse_ptr(a0)
	bsr.w	Push_Module
.Exit:
	rts	
; ---- Do_TFMFOOD (original source: MAIN/PLACES.ASM)
Do_TFMFOOD:
	move.l	ItemW_nr,d0
	add.w	d0,Food_rations(a0)
	sub.w	d0,Places_food
	mulu.w	#Food_weight,d0
	add.l	d0,Weight_normal(a0)
	rts	

; ---- MFOOD_Divide_food (original source: MAIN/PLACES.ASM) - the shipped program differs, its code follows, not assembled:
;MFOOD_Divide_food:
;             moveq.l   #0,d0                ; Get food
;             move.w    Places_food,d0
;             jsr       Divide_food          ; Divide it
;             move.w    d0,Places_food       ; Store remaining food
;             rts

T_0c9d6:
	btst	#$1,Mouse_button_state
	bne.b	T_0c9d6
	moveq	#0,d0
	move.w	Places_food,d0
	bsr.w	T_0cbee
	move.w	d0,Places_food
	rts
T_0c9f4:
	btst	#$1,Mouse_button_state
	bne.b	T_0c9f4
	moveq	#0,d1
	move.w	Places_gold,d1
	divu.w	Total_price,d1
	cmpi.w	#$63,d1
	bmi.b	.l_0ca14
	moveq	#99,d1
.l_0ca14:
	ext.l	d1
	move.l	d1,Original_number
	clr.l	ItemW_nr
	lea.l	BuyFood_Mod,a0
	bra.w	Push_Module
; ---- BuyFood_DisInit (original source: MAIN/PLACES.ASM)
BuyFood_DisInit:
	move.w	#112,Mesmin_X
	move.w	#63,Mesmin_Y
	move.w	#192,Mesmin_Wd
	move.l	#Code0002Sys,Textfile_ptr
	move.w	#First_add,Adding
	moveq.l	#15,d0
	jsr	IG_Set_ink
	moveq.l	#2,d0
	jsr	IG_Set_paper
	bsr.w	ItemW_DisInit
	move.w	#Food_icon,d0
	moveq.l	#0,d1
	bsr.w	INV2_Show_object
	move.w	#49+18,d0
	move.w	#80+18+32,d1
	jsr	IG_Set_cursor
	lea.l	Food_txt,a0
	jsr	IG_Print
	move.w	#32+17,d0
	move.w	#80+38+32,d1
	jsr	IG_Set_cursor
	moveq.l	#22,d0
	lea.l	Code0003Sys,a1
	bsr.w	Convert_text_line
	lea.l	Line_buffer,a0
	jsr	IG_Print
	jsr	Switch_screen
	jsr	Copy_screen
	rts	
; ---- BuyFood_Return (original source: MAIN/PLACES.ASM)
BuyFood_Return:
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	tst.l	ItemW_nr
	beq.s	.Exit
	lea.l	BuyFoodReq_Mod,a0
	bsr.w	Push_Module
.Exit:
	rts	
; ---- BuyFoodReq_ModInit (original source: MAIN/PLACES.ASM)
BuyFoodReq_ModInit:
	movea.l	Off_screen,a6
	lea.l	Lay3_PA,a0
	bsr.w	Push_PA
	bsr.w	Erase_text_window
	lea.l	Food_txt,a0
	jsr	IG_Print
	move.l	ItemW_nr,d6
	cmpi.w	#1,d6
	beq.s	.Single
	lea.l	Multi_txt,a0
	jsr	IG_Print
	move.w	d6,d0
	moveq.l	#2,d7
	lea.l	Line_buffer,a0
	movea.l	a0,a3
	bsr.w	LConvert_number
	jsr	IG_Print
.Single:
	jsr	IG_Carriage_return
	moveq.l	#23,d0
	lea.l	Code0003Sys,a1
	bsr.w	Convert_text_line
	lea	Line_buffer,a0
	jsr	IG_Print
	jsr	IG_Carriage_return
	moveq.l	#0,d0
	move.w	Total_price,d0
	mulu.w	d6,d0
	moveq.l	#5,d7
	lea.l	Line_buffer,a0
	movea.l	a0,a3
	bsr.w	LConvert_number
	move.b	#" ",(a3)+
	clr.b	(a3)
	jsr	IG_Print
	lea.l	Gold_txt,a0
	jsr	IG_Print
	moveq.l	#2,d6
	moveq.l	#16,d7
	move.w	#240,d0
	move.w	#81,d1
	lea.l	Control_icn+6912,a0
	jsr	Blot_unmasked_block
	addi.w	#32,d0
	lea.l	Control_icn+7168,a0
	jsr	Blot_unmasked_block
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	SellReq_L2,a0
	jsr	Set_layout_data
	lea.l	Lay3_PlusMes,a0
	jsr	Push_MA
	rts	
; ---- BuyFoodYes (original source: MAIN/PLACES.ASM)
BuyFoodYes:
	move.l	ItemW_nr,d0
	move.l	d0,d1
	mulu.w	Total_price,d1
	sub.w	d1,Places_gold
	add.w	d0,Places_food
	bra.w	Pop_Module
T_0cbee:
	movem.l	d1-d3/d6-d7/a0-a2,-(a7)
	ext.l	d0
	beq.w	.l_0ccb4
	move.l	d0,d3
	lea.l	Chard_ptrs,a0
	lea.l	Divide_gold_workspace,a1
	moveq	#0,d6
	moveq	#5,d7
.l_0cc0a:
	moveq	#0,d0
	tst.l	(a0)
	beq.b	.l_0cc48
	movea.l	(a0),a2
	cmpi.b	#$9,Character_race(a2)
	bpl.b	.l_0cc48
	move.w	#$e402,d1
	and.w	Body_conditions(a2),d1
	bne.b	.l_0cc48
	move.w	Attr_1_normal(a2),d0
	add.w	Attr_1_normal_magic(a2),d0
	mulu.w	#$3e8,d0
	sub.l	Weight_normal(a2),d0
	divu.w	#$fa,d0
	move.w	Food_rations(a2),d1
	add.w	d0,d1
	bvc.b	.l_0cc48
	move.w	#$7fff,d0
	sub.w	Food_rations(a2),d0
.l_0cc48:
	tst.w	d0
	beq.b	.l_0cc4e
	addq.w	#$1,d6
.l_0cc4e:
	move.w	d0,(a1)+
	addq.l	#$4,a0
	dbra	d7,.l_0cc0a
	move.l	d3,d0
	tst.w	d6
	beq.b	.l_0ccb4
.l_0cc5c:
	lea.l	-$18(a0),a0
	lea.l	-$c(a1),a1
	moveq	#5,d7
.l_0cc66:
	move.w	(a1),d1
	beq.b	.l_0cca4
	movea.l	(a0),a2
	move.l	d0,d2
	divu.w	d6,d2
	tst.w	d2
	bne.b	.l_0cc76
	move.l	d0,d2
.l_0cc76:
	cmp.w	d2,d1
	bpl.b	.l_0cc90
	sub.w	d1,(a1)
	bne.b	.l_0cc80
	subq.w	#$1,d6
.l_0cc80:
	sub.w	d1,d0
	add.w	d1,$92(a2)
	mulu.w	#$fa,d1
	add.l	d1,$ec(a2)
	bra.b	.l_0cca4
.l_0cc90:
	sub.w	d2,(a1)
	bne.b	.l_0cc96
	subq.w	#$1,d6
.l_0cc96:
	sub.w	d2,d0
	add.w	d2,$92(a2)
	mulu.w	#$fa,d2
	add.l	d2,$ec(a2)
.l_0cca4:
	addq.l	#$4,a0
	addq.l	#$2,a1
	dbra	d7,.l_0cc66
	tst.w	d0
	beq.b	.l_0ccb4
	tst.w	d6
	bne.b	.l_0cc5c
.l_0ccb4:
	movem.l	(a7)+,d1-d3/d6-d7/a0-a2
	rts
; ---- MerchHORSE_DisUpd (original source: MAIN/PLACES.ASM)
MerchHORSE_DisUpd:
	bsr.w	Update_status_block
	lea.l	MHORSE_CIL,a0
	lea.l	MHORSECIL_evaluate,a1
	bsr.w	Update_control_icons
	bsr.w	Display_gold
	rts	
; ---- MerchHORSE_DisInit (original source: MAIN/PLACES.ASM)
MerchHORSE_DisInit:
	move.l	#Lay3_PlusMes,PlusMes_info
	movea.l	Off_screen,a6
	moveq.l	#3,d0
	bsr.w	Show_layout
	bsr.w	Display_80x80_picture
	bsr.w	Places_DisInit
	bsr.w	Check_trans_creation
	bsr.w	T_0dcde	; CHANGE: added
	move.w	d0,d1	; CHANGE: added
	movea.l	Placedat_ptr,a1
	move.w	(a1),d0
	mulu.w	d1,d0	; CHANGE: was "mulu.w Nr_members,d0"
	move.w	d0,Total_price
	lea.l	MHORSE_CIL,a0
	bsr.w	MHORSECIL_evaluate
	move.l	a0,Control_list_ptr
	bsr.w	Show_control_icons
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	Lay3_L2,a0
	jsr	Set_layout_data
	bra.w	Fadein_lay3
; ---- MSHIPCIL_evaluate (original source: MAIN/PLACES.ASM)
MHORSECIL_evaluate:
MRAFTCIL_evaluate:
MSHIPCIL_evaluate:
	movem.l	d0/d7/a1,-(sp)
	bclr	#7,3(a0)
	tst.b	Trans_created
	bne.s	.Deac
	move.w	Places_gold,d0
	cmp.w	Total_price,d0
	bpl.s	.Ok
.Deac:
	bset	#7,3(a0)
.Ok:
	bsr.w	Places_CIL_evaluate
	movem.l	(sp)+,d0/d7/a1
	rts	
; ---- Buy_ship (original source: MAIN/PLACES.ASM)
Buy_horses:
Buy_raft:
Buy_ship:
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	lea.l	BuyHORSEReq_Mod,a0	; CHANGE: was "Push Module,BuySHIPReq_Mod"
	bsr.w	Push_Module
	rts	
; ---- BuyHORSEReq_ModInit (original source: MAIN/PLACES.ASM)
BuyHORSEReq_ModInit:
	move.l	#Code0002Sys,Textfile_ptr
	moveq.l	#19,d0
	bra.w	BuyTRANSReq_ModInit
; ---- BuyHORSEYes (original source: MAIN/PLACES.ASM)
BuyHORSEYes:
	bsr.w	Create_transport
	move.w	Total_price,d0
	sub.w	d0,Places_gold
	move.l	#Lay3_PlusMes,PlusMes_info
	move.l	#Code0002Sys,Textfile_ptr
	move.w	#20,d0
	bsr.w	Plus_message
	bsr.w	Pop_Module
.Exit:
	rts	
; ---- MerchRAFT_DisUpd (original source: MAIN/PLACES.ASM)
MerchRAFT_DisUpd:
	bsr.w	Update_status_block
	lea.l	MRAFT_CIL,a0
	lea.l	T_0ce3e,a1	; CHANGE: was "lea.l MRAFTCIL_evaluate,a1"
	bsr.w	Update_control_icons
	bsr.w	Display_gold
	rts	
; ---- MerchSHIP_DisInit (original source: MAIN/PLACES.ASM)
MerchRAFT_DisInit:
MerchSHIP_DisInit:
	move.l	#Lay3_PlusMes,PlusMes_info
	movea.l	Off_screen,a6
	moveq.l	#3,d0
	bsr.w	Show_layout
	bsr.w	Display_80x80_picture
	bsr.w	Places_DisInit
	movea.l	Placedat_ptr,a1
	move.w	(a1),d0
	move.w	d0,Total_price
	bsr.w	Check_trans_creation
	lea.l	MSHIP_CIL,a0
	bsr.w	T_0ce3e	; CHANGE: was "jsr MSHIPCIL_evaluate"
	move.l	a0,Control_list_ptr
	bsr.w	Show_control_icons
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	Lay3_L2,a0
	jsr	Set_layout_data
	bra.w	Fadein_lay3
T_0ce3e:
	movem.l	d0/d7/a1,-(a7)
	bclr	#$7,$3(a0)
	tst.b	Trans_created
	bne.b	.l_0ce5e
	move.w	Places_gold,d0
	cmp.w	Total_price,d0
	bpl.b	.l_0ce64
.l_0ce5e:
	bset	#$7,$3(a0)
.l_0ce64:
	bsr.w	Places_CIL_evaluate
	movem.l	(a7)+,d0/d7/a1
	rts
T_0ce6e:
	btst	#$1,Mouse_button_state
	bne.b	T_0ce6e
	lea.l	BuyRAFTReq_Mod,a0
	bsr.w	Push_Module
	rts
; ---- BuyRAFTReq_ModInit (original source: MAIN/PLACES.ASM)
BuyRAFTReq_ModInit:
	move.l	#Code0003Sys,Textfile_ptr
	moveq.l	#1,d0
	bra.w	BuyTRANSReq_ModInit
; ---- BuySHIPYes (original source: MAIN/PLACES.ASM)
BuyRAFTYes:
BuySHIPYes:
	bsr.w	Create_transport
	move.w	Total_price,d0
	sub.w	d0,Places_gold
	move.l	#Lay3_PlusMes,PlusMes_info
	move.l	#Code0003Sys,Textfile_ptr
	move.w	#$2,d0	; CHANGE: was "PlusMes 4"
	bsr.w	Plus_message
	bsr.w	Pop_Module
.Exit:
	rts	
; ---- MerchSHIP_DisUpd (original source: MAIN/PLACES.ASM)
MerchSHIP_DisUpd:
	bsr.w	Update_status_block
	lea.l	D_29182,a0	; CHANGE: was "lea.l MSHIP_CIL,a0"
	lea.l	T_0cf40,a1	; CHANGE: was "lea.l MSHIPCIL_evaluate,a1"
	bsr.w	Update_control_icons
	bsr.w	Display_gold
	rts	
T_0cee0:
	move.l	#Lay3_PlusMes,PlusMes_info
	movea.l	Off_screen,a6
	moveq	#3,d0
	bsr.w	Show_layout
	bsr.w	Display_80x80_picture
	bsr.w	Places_DisInit
	movea.l	Placedat_ptr,a1
	move.w	(a1),d0
	move.w	d0,Total_price
	bsr.w	Check_trans_creation
	lea.l	D_29182,a0
	bsr.w	T_0cf40
	move.l	a0,Control_list_ptr
	bsr.w	Show_control_icons
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	Lay3_L2,a0
	jsr	Set_layout_data
	bra.w	Fadein_lay3
T_0cf40:
	movem.l	d0/d7/a1,-(a7)
	bclr	#$7,$3(a0)
	tst.b	Trans_created
	bne.b	.l_0cf60
	move.w	Places_gold,d0
	cmp.w	Total_price,d0
	bpl.b	.l_0cf66
.l_0cf60:
	bset	#$7,$3(a0)
.l_0cf66:
	bsr.w	Places_CIL_evaluate
	movem.l	(a7)+,d0/d7/a1
	rts
T_0cf70:
	btst	#$1,Mouse_button_state
	bne.b	T_0cf70
	lea.l	BuySHIPReq_Mod,a0
	bsr.w	Push_Module
	rts
; ---- BuySHIPReq_ModInit (original source: MAIN/PLACES.ASM)
BuySHIPReq_ModInit:
	move.l	#Code0003Sys,Textfile_ptr
	moveq.l	#3,d0
	bra.w	BuyTRANSReq_ModInit
T_0cf96:
	bsr.w	Create_transport
	move.w	Total_price,d0
	sub.w	d0,Places_gold
	move.l	#Lay3_PlusMes,PlusMes_info
	move.l	#Code0003Sys,Textfile_ptr
	move.w	#$4,d0
	bsr.w	Plus_message
	bsr.w	Pop_Module
	rts
; ---- Create_transport (original source: MAIN/PLACES.ASM)
Create_transport:
	movem.l	d0/d7/a0/a1,-(sp)
	lea.l	Trans_T,a0
	moveq.l	#30-1,d7
.Loop:
	tst.b	0(a0,d7.w)
	beq.s	.Yay
	subq.w	#1,d7
	bpl.s	.Loop
	lea.l	ET_Create_transport_1,a1	; ERROR "[ Create_transport ] : No slot free !!!"
	jsr	DI_Error
	bra.s	.Exit
.Yay:
	movea.l	Placedat_ptr,a1
	move.w	8(a1),d0
	move.b	d0,0(a0,d7.w)
	move.w	2(a1),d0
	move.b	d0,30(a0,d7.w)
	move.w	4(a1),d0
	move.b	d0,60(a0,d7.w)
	lea.l	90(a0,d7.w),a0
	move.w	6(a1),0(a0,d7.w)
	st	Trans_created
.Exit:
	movem.l	(sp)+,d0/d7/a0/a1
	rts	
; ---- Check_trans_creation (original source: MAIN/PLACES.ASM)
Check_trans_creation:
	movem.l	d0-d2/d7/a0/a1,-(sp)
	movea.l	Placedat_ptr,a0
	move.w	2(a0),d0
	move.w	4(a0),d1
	move.w	6(a0),d2
	lea.l	Trans_T,a0
	lea.l	90(a0),a1
	moveq.l	#30-1,d7
.Loop1:
	tst.b	(a0)
	beq.s	.Next
	cmp.w	(a1),d2
	bne.s	.Next
	cmp.b	30(a0),d0
	bne.s	.Next
	cmp.b	60(a0),d1
	bne.s	.Next
	st	Trans_created
	bra.s	.Exit
.Next:
	addq.l	#1,a0
	addq.l	#2,a1
	dbra	d7,.Loop1
	sf	Trans_created
.Exit:
	lea.l	Trans_T,a0
	move.b	(a0)+,d0
	moveq.l	#30-2,d7
.Loop2:
	and.b	(a0)+,d0
	dbra	d7,.Loop2
	tst.b	d0
	sne	Trans_created
	movem.l	(sp)+,d0-d2/d7/a0/a1
	rts	
; ---- BuyTRANSReq_ModInit (original source: MAIN/PLACES.ASM)
BuyTRANSReq_ModInit:
	movea.l	Off_screen,a6
	lea.l	Lay3_PlusMes,a0
	jsr	Push_MA
	lea.l	Lay3_PA,a0
	bsr.w	Push_PA
	bsr.w	Erase_text_window
	movea.l	Textfile_ptr,a1
	bsr.w	Convert_text_line
	lea	Line_buffer,a0
	jsr	IG_Print
	jsr	IG_Carriage_return
	move.w	Total_price,d0
	moveq.l	#5,d7
	lea.l	Line_buffer,a0
	movea.l	a0,a3
	bsr.w	LConvert_number
	move.b	#" ",(a3)+
	clr.b	(a3)
	jsr	IG_Print
	lea.l	Gold_txt,a0
	jsr	IG_Print
	moveq.l	#2,d6
	moveq.l	#16,d7
	move.w	#240,d0
	move.w	#81,d1
	lea.l	Control_icn+6912,a0
	jsr	Blot_unmasked_block
	addi.w	#32,d0
	lea.l	Control_icn+7168,a0
	jsr	Blot_unmasked_block
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	SellReq_L2,a0
	jsr	Set_layout_data
	rts	
T_0d134:
	movea.l	Off_screen,a6
	bsr.w	Erase_text_window
	jsr	Switch_screen
	jsr	Copy_screen
	jsr	Pop_MA
	bsr.w	Pop_PA
	lea.l	Lay3_L2,a0
	jsr	Set_layout_data
.l_0d160:
	btst	#$1,Mouse_button_state
	bne.b	.l_0d160
	rts
; ---- BuyTRANSReq_DisUpd (original source: MAIN/PLACES.ASM)
BuyTRANSReq_DisUpd:
	bsr.w	Update_status_block
	bsr.w	Display_gold
	rts	
; ---- Healer_DisUpd (original source: MAIN/PLACES.ASM)
Healer_DisUpd:
	bsr.w	Update_status_block
	lea.l	Healer_CIL,a0
	lea.l	HealerCIL_evaluate,a1
	bsr.w	Update_control_icons
	bsr.w	Display_gold
	rts	
; ---- Healer_ModInit (original source: MAIN/PLACES.ASM)
Healer_ModInit:
	move.l	Current_active_char_data,Current_healer_victim
	move.w	Active_member,Healer_victim_nr
	bra.w	T_0ab48	; CHANGE: was "jmp Places_ModInit"
; ---- Healer_DisInit (original source: MAIN/PLACES.ASM)
Healer_DisInit:
	move.l	#Lay3_PlusMes,PlusMes_info
	movea.l	Off_screen,a6
	moveq.l	#3,d0
	bsr.w	Show_layout
	bsr.w	Display_80x80_picture
	bsr.w	Places_DisInit
	bsr.w	Display_BodyMind
	move.l	#Sold_data,Itemdata_ptr
	move.l	#Sold_slots,Itemslots_ptr
	lea.l	Healer_CIL,a0
	bsr.w	HealerCIL_evaluate
	move.l	a0,Control_list_ptr
	bsr.w	Show_control_icons
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	Lay3_L2,a0
	jsr	Set_layout_data
	lea.l	XLay3_target_hbl,a1
	movem.l	Lay3_target_hbl+2,d0-d7
	movem.l	d0-d7,2(a1)
	bra.w	Fade_lay3
; ---- Healer_DisExit (original source: MAIN/PLACES.ASM)
Healer_DisExit:
	move.w	Healer_victim_nr,d5
	move.w	d5,d4
	mulu.w	#48,d4
	movea.l	Current_healer_victim,a4
	movea.l	Off_screen,a6
	bsr.w	Display_portrait
	jsr	Switch_screen
	jsr	Copy_screen
	bra.w	Fadeout_lay3
; ---- HealerCIL_evaluate (original source: MAIN/PLACES.ASM)
HealerCIL_evaluate:
	movem.l	d7/a1/a2,-(sp)
	bclr	#7,3(a0)
	movea.l	Current_healer_victim,a1
	lea.l	Inv_data(a1),a2
	lea.l	Neck_place_counter(a1),a1
	moveq.l	#9-1,d7
.Loop:
	tst.b	(a1)+
	beq.s	.Next
	btst	#0,Item_stat_bits(a2)
	bne.s	.Ok
.Next:
	lea.l	40(a2),a2
	dbra	d7,.Loop
	bset	#7,3(a0)
.Ok:
	bsr.w	Places_CIL_evaluate
	movem.l	(sp)+,d7/a1/a2
	rts	
; ---- Healer_Remove_curse (original source: MAIN/PLACES.ASM)
Healer_Remove_curse:
	movea.l	Current_healer_victim,a1
	lea.l	Inv_data(a1),a2
	lea.l	Neck_place_counter(a1),a1
	lea.l	Cursed_slots,a3
	moveq.l	#0,d0
	clr.l	(a3)+
	clr.l	(a3)+
	clr.b	(a3)
	lea.l	-8(a3),a3
	moveq.l	#9-1,d7
.Loop:
	tst.b	(a1)+
	beq.s	.Next
	btst	#0,Item_stat_bits(a2)
	beq.s	.Next
	st	(a3)
	addq.w	#1,d0
.Next:
	lea.l	40(a2),a2
	addq.l	#1,a3
	dbra	d7,.Loop
	move.w	d0,Nr_cursed_objects
	movea.l	Placedat_ptr,a0
	moveq.l	#0,d1
	move.w	20(a0),d1
	mulu.w	d1,d0
	move.w	d0,Total_price
	cmp.w	Places_gold,d0
	ble.s	.Ok
	move.l	#Lay3_PlusMes,PlusMes_info
	move.l	#Code0002Sys,Textfile_ptr
	move.w	#22,d0
	bsr.w	Plus_message
	bra.s	.Exit
.Ok:
	move.w	d0,Total_price
	lea.l	RemCurseReq_Mod,a0
	bsr.w	Push_Module
.Exit:
	rts	

; ---- Heal_condition (original source: MAIN/PLACES.ASM) - the shipped program differs, its code follows, not assembled:
;Heal_condition:
;             tst.b     d0                   ; Any slot ?
;             beq       .Exit
;             move.b    d0,Object_slot_number      ; Store slot number
;             lea.l     Sold_slots,a0        ; Calculate pointers
;             lea.l     Sold_data,a1
;             ext.w     d0
;             subq.w    #1,d0
;             adda.w    d0,a0
;             mulu.w    #40,d0
;             adda.w    d0,a1
;             tst.b     (a0)                 ; Slot filled ?
;             beq       .Exit
;             Wait_4_unclick
;             movea.l   Placedat_ptr,a0      ; Get price
;             moveq.l   #0,d0
;             move.b    1(a1),d0
;             move.b    .Price_indices(pc,d0.w),d0
;             move.w    0(a0,d0.w),d0
;             cmp.w     Places_gold,d0       ; Enough dough ?
;             ble.s     .Ok
;             move.l    #Lay3_PlusMes,PlusMes_info ; Print message {22,+}
;             move.l    #Code0002Sys,Textfile_ptr
;             PlusMes   22
;             bra       .Exit
;.Ok:         move.w    d0,Total_price       ; Store price
;             Push      Module,HealCondReq_Mod
;.Exit:       rts
;
;.Price_indices:
;             .DC.b -1,10,-1,-1,12,-1,-1,-1
;             .DC.b 0,2,4,6,8,14,16,18
;             .EVEN

Heal_condition:
	tst.b	d0
	beq.b	.l_0d394
	move.b	d0,Object_slot_number
	lea.l	Sold_slots,a0
	lea.l	Sold_data,a1
	ext.w	d0
	subq.w	#$1,d0
	adda.w	d0,a0
	mulu.w	#$28,d0
	adda.w	d0,a1
	tst.b	(a0)
	beq.b	.l_0d394
.l_0d340:
	btst	#$1,Mouse_button_state
	bne.b	.l_0d340
	movea.l	Placedat_ptr,a0
	moveq	#0,d0
	move.b	$1(a1),d0
	move.b	.l_0d396(pc,d0.w),d0
	move.w	(a0,d0.w),d0
	cmp.w	Places_gold,d0
	ble.b	.l_0d384
	move.l	#Lay3_PlusMes,PlusMes_info
	move.l	#Code0002Sys,Textfile_ptr
	move.w	#$16,d0
	bsr.w	Plus_message
	bra.b	.l_0d394
.l_0d384:
	move.w	d0,Total_price
	lea.l	HealCondReq_Mod,a0
	bsr.w	Push_Module
.l_0d394:
	rts
.l_0d396:
	dc.b	$ff,$0a,$ff,$ff,$0c,$ff,$ff,$ff,$00,$02,$04,$06,$08,$0e,$10,$12
; ---- HealCondReq_ModInit (original source: MAIN/PLACES.ASM)
HealCondReq_ModInit:
	move.l	#Code0002Sys,Textfile_ptr
	moveq.l	#24,d0
	bra.w	BuyTRANSReq_ModInit
; ---- HealCondYes (original source: MAIN/PLACES.ASM)
HealCondYes:
	move.w	Total_price,d0
	sub.w	d0,Places_gold
	lea.l	Sold_data-40,a0
	move.b	Object_slot_number,d0
	ext.w	d0
	mulu.w	#40,d0
	move.b	1(a0,d0.w),d0
	movea.l	Current_healer_victim,a0
	move.w	Body_conditions(a0),d1
	bclr	d0,d1
	move.w	d1,Body_conditions(a0)
	cmpi.w	#13,d0
	bmi.s	.No
	move.w	Healer_victim_nr,d0
	bsr.w	Resurrection
.No:
	movea.l	Off_screen,a6
	bsr.w	Display_BodyMind
	jsr	Switch_screen
	jsr	Copy_screen
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	bra.w	Pop_Module
; ---- RemCurseReq_ModInit (original source: MAIN/PLACES.ASM)
RemCurseReq_ModInit:
	move.l	#Code0002Sys,Textfile_ptr
	moveq.l	#23,d0
	bra.w	BuyTRANSReq_ModInit
; ---- RemCurseYes (original source: MAIN/PLACES.ASM)
RemCurseYes:
	move.w	Total_price,d0
	sub.w	d0,Places_gold
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	bsr.w	Pop_Module
	bsr.w	Exit_display
	lea.l	RemCurse_Mod,a0
	bsr.w	Push_Module
	rts	
; ---- RemCurse_DisInit (original source: MAIN/PLACES.ASM)
RemCurse_DisInit:
	jsr	Mouse_off
	bsr.w	Inv2_DisInit
	moveq.l	#50,d0
	jsr	Delay
	lea.l	Cursed_slots,a0
	movea.l	Current_healer_victim,a1
	lea.l	Neck_place_counter(a1),a2
	lea.l	Inv_data(a1),a3
	moveq.l	#1,d0
	moveq.l	#9-1,d7
.Loop:
	tst.b	(a0)+
	beq.s	.Next
	clr.b	(a2)
	moveq.l	#0,d2
	move.w	Weight(a3),d2
	sub.l	d2,Weight_normal(a1)
	bsr.w	T_0d4e0	; CHANGE: added
	move.l	d0,-(sp)
	moveq.l	#0,d2
	moveq.l	#0,d3
	move.b	(a3),d2
	lea.l	Erase_icon,a4
	move.b	-1(a4,d0.w),d3
	lea.l	Object_pos_list-4,a4
	add.w	d0,d0
	add.w	d0,d0
	move.w	2(a4,d0.w),d1
	move.w	0(a4,d0.w),d0
	bsr.w	Show_item_destruction
	move.l	(sp)+,d0
.Next:
	addq.w	#1,d0
	addq.l	#1,a2
	lea.l	40(a3),a3
	dbra	d7,.Loop
	moveq.l	#50,d0
	jsr	Delay
	bsr.w	Pop_Module
	jsr	Mouse_on
	bra.w	Init_display
T_0d4e0:
	movem.l	d2/a0/a2/a5,-(a7)
	movea.l	a1,a0
	movea.l	a3,a2
	move.b	$4(a2),d2
	sub.b	d2,$1c(a0)
	move.b	$5(a2),d2
	sub.b	d2,$1d(a0)
	move.b	$13(a2),d2
	sub.b	d2,$20(a0)
	move.b	$14(a2),d2
	sub.b	d2,$21(a0)
	lea.l	$ae(a0),a5
	move.b	$19(a2),d2
	ext.w	d2
	add.w	d2,d2
	adda.w	d2,a5
	move.b	$1b(a2),d2
	ext.w	d2
	add.w	d2,(a5)
	lea.l	$ae(a0),a5
	move.b	$1a(a2),d2
	ext.w	d2
	add.w	d2,d2
	adda.w	d2,a5
	move.b	$1c(a2),d2
	ext.w	d2
	add.w	d2,(a5)
	bsr.w	Positive_boni
	movem.l	(a7)+,d2/a0/a2/a5
	rts
; ---- Show_item_destruction (original source: MAIN/PLACES.ASM)
Show_item_destruction:
	movem.l	d0-d2/d7/a0-a4/a6,-(sp)
	lea.l	Objects_icn,a1
	ext.w	d2
	lsl.w	#7,d2
	adda.w	d2,a1
	lea.l	Layout_icn-128,a2
	ext.w	d3
	lsl.w	#7,d3
	adda.w	d3,a2
	lea.l	Curse_anim,a3
	lea.l	Layout_icn+9856,a4
	moveq.l	#8-1,d7
.Loop1:
	movea.l	Off_screen,a6
	movea.l	a4,a0
	jsr	Put_unmasked_block
	movea.l	a1,a0
	jsr	Put_masked_block
	movea.l	a3,a0
	jsr	Put_masked_block
	jsr	Switch_screen
	jsr	My_vsync
	jsr	My_vsync	; CHANGE: added
	jsr	My_vsync	; CHANGE: added
	lea.l	128(a3),a3
	dbra	d7,.Loop1
	moveq.l	#8-1,d7
.Loop2:
	movea.l	Off_screen,a6
	movea.l	a2,a0
	jsr	Put_unmasked_block
	movea.l	a3,a0
	jsr	Put_masked_block	; CHANGE: added
	jsr	Switch_screen	; CHANGE: added
	jsr	My_vsync	; CHANGE: was "jsr Put_masked_block"
	jsr	My_vsync	; CHANGE: was "jsr Switch_screen"
	jsr	My_vsync
	lea.l	128(a3),a3
	dbra	d7,.Loop2
	movea.l	Off_screen,a6
	movea.l	a2,a0
	jsr	Put_unmasked_block
	jsr	Switch_screen
	jsr	Copy_screen
	movem.l	(sp)+,d0-d2/d7/a0-a4/a6
	rts	
; ---- Display_BodyMind (original source: MAIN/PLACES.ASM)
Display_BodyMind:
	movem.l	d0-d2/d6/d7/a0-a3,-(sp)
	moveq	#0,d1	; CHANGE: was "move.l #0,d1"
	movea.l	Current_healer_victim,a0
	move.w	Body_conditions(a0),d6
	lea.l	BodyMind_Distribution,a0
	lea.l	Sold_slots,a1
	lea.l	Sold_data,a2
	lea.l	Misc_dat+Body_names,a3
	clr.l	(a1)+
	clr.l	(a1)+
	clr.l	(a1)
	lea.l	-8(a1),a1
	moveq.l	#13-1,d7
.Loop:
	move.b	(a0),d0
	bmi.s	.Next
	btst	d0,d6
	beq.s	.Next
	move.b	#1,(a1)+
	move.b	1(a0),(a2)
	move.b	d0,1(a2)
	move.w	(a3),Name_word_nr(a2)
	lea.l	40(a2),a2
.Next:
	addq.l	#2,a0
	addq.l	#2,a3
	dbra	d7,.Loop
.Exit:
	lea.l	Sold_data,a1
	lea.l	Door_object_pos_list,a2
	lea.l	Sold_slots,a3
	moveq.l	#12-1,d7
.Loop_L1:
	move.w	(a2)+,d0
	move.w	(a2)+,d1
	lea.l	Layout_icn+9856,a0
	jsr	Put_unmasked_block
	tst.b	(a3)+
	beq.s	.Next_L1
	lea.l	Status_icn,a0
	move.b	(a1),d2
	ext.w	d2
	lsl.w	#7,d2
	adda.w	d2,a0
	jsr	Put_masked_block
.Next_L1:
	lea.l	40(a1),a1
	dbra	d7,.Loop_L1
	movem.l	(sp)+,d0-d2/d6/d7/a0-a3
	rts	
; ---- Healer_Member_left (original source: MAIN/PLACES.ASM)
Healer_Member_left:
	andi.l	#$0000ff00,d0
	beq.s	.Exit
	lsr.w	#8,d0
	cmp.w	Healer_victim_nr,d0
	beq.s	.Exit
	lea.l	Chard_ptrs-4,a0
	move.w	d0,d1
	add.w	d1,d1
	add.w	d1,d1
	adda.w	d1,a0
	tst.l	(a0)
	beq.s	.Exit
	move.w	Healer_victim_nr,d5
	move.w	d0,Healer_victim_nr
	move.w	d5,d4
	mulu.w	#48,d4
	movea.l	Current_healer_victim,a4
	movea.l	Off_screen,a6
	bsr.w	Display_portrait
	move.l	(a0),Current_healer_victim
	movea.l	Off_screen,a6
	bsr.w	Display_BodyMind
	jsr	Switch_screen
	jsr	Copy_screen
.Exit:
	rts	
; ---- Display_Ankh (original source: MAIN/PLACES.ASM)
Display_Ankh:
	move.w	Healer_victim_nr,d0
	mulu.w	#48,d0
	subi.w	#32,d0
	moveq.l	#1,d1
	moveq.l	#2,d6
	moveq.l	#32,d7
	lea.l	Status_icn+3072,a0
	movea.l	Off_screen,a6
	jsr	Blot_masked_block
	rts	

; ---- Resurrection (original source: MAIN/PLACES.ASM) - the shipped program differs, its code follows, not assembled:
;Resurrection:
;             movem.l   d0/d4/d5/a0/a6,-(sp)
;             move.w    #1,Life_points_normal(a0)  ; ONE hitpoint
;
;             DIAG_ON
;             PRINT     .Text
;             jsr       Wait_4_key
;             DIAG_OFF
;
;             lea.l     Char_status_icons,a0 ; Remove cross icon
;             clr.b     -1(a0,d0.w)
;             jsr       Force_char_update    ; Update
;             movem.l   (sp)+,d0/d4/d5/a0/a6
;             rts
;
;.Text:       .DC.b "The healer puts his hand on the dead persons's forehead.",13
;             .DC.b "White light pulses down his arm and all watch in awe",13
;             .DC.b "as life returns to the once cold body. The resurrected",13
;             .DC.b "person opens his eyes and asks 'What's for dinner ?'",0
;             .EVEN

Resurrection:
	movem.l	d0/d4-d5/d7/a0-a2/a6,-(a7)
	lea.l	$f0(a0),a2
	move.w	#$1,$86(a0)
	lea.l	Char_status_icons,a0
	clr.b	-$1(a0,d0.w)
	bsr.w	Force_char_update
	lea.l	Lay3_PA,a0
	bsr.w	Push_PA
	bsr.w	Init_RText
	lea.l	Code0006Sys,a1
	move.w	#$15,d0
	bsr.w	Add_encoded_2_RText
	movea.l	a2,a0
	bsr.w	Add_ASCII_2_RText
	lea.l	D_313bc,a0
	bsr.w	Add_ASCII_2_RText
	move.w	#$16,d0
	bsr.w	Add_encoded_2_RText
	bsr.w	T_0707a
	jsr	Switch_screen
	jsr	Copy_screen
	bsr.w	Exit_RText
	bsr.w	Wait_4_user
	movea.l	Off_screen,a6
	bsr.w	Erase_text_window
	jsr	Switch_screen
	jsr	Copy_screen
	bsr.w	Pop_PA
	movem.l	(a7)+,d0/d4-d5/d7/a0-a2/a6
	rts
; ---- MerchMAGIC_DisUpd (original source: MAIN/PLACES.ASM)
MerchMAGIC_DisUpd:
	bsr.w	Update_status_block
	lea.l	MMAGIC_CIL,a0
	lea.l	MMAGICCIL_evaluate,a1
	bsr.w	Update_control_icons
	bsr.w	Display_gold
	bsr.w	Update_quantity_colours
	rts	
; ---- MerchMAGIC_DisInit (original source: MAIN/PLACES.ASM)
MerchMAGIC_DisInit:
	move.l	#Lay3_PlusMes,PlusMes_info
	move.l	#Code0002Sys,Textfile_ptr
	move.l	#Sold_data,Itemdata_ptr
	move.l	#Sold_slots,Itemslots_ptr
	movea.l	Off_screen,a6
	moveq.l	#3,d0
	bsr.w	Show_layout
	bsr.w	Display_80x80_picture
	bsr.w	Places_DisInit
	lea.l	MMAGIC_CIL,a0
	bsr.w	MMAGICCIL_evaluate
	move.l	a0,Control_list_ptr
	bsr.w	Show_control_icons
	bsr.w	Show_objects_LAY3
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	Lay3_L2,a0
	jsr	Set_layout_data
	bra.w	Fadein_lay3
; ---- MMAGICCIL_evaluate (original source: MAIN/PLACES.ASM)
MMAGICCIL_evaluate:
	movem.l	d0/d7/a1,-(sp)
	bclr	#7,(a0)
	bclr	#7,5(a0)
	tst.w	Places_gold
	beq.s	.Deac
	movea.l	Warecount_ptr,a1
	move.l	(a1)+,d0
	or.l	(a1)+,d0
	or.l	(a1)+,d0
	beq.s	.Deac
	lea.l	Sold_slots,a1
	move.b	(a1)+,d0
	moveq.l	#11-1,d7
.Loop2:
	and.b	(a1)+,d0
	dbra	d7,.Loop2
	tst.b	d0
	beq.s	.Not_empty2
.Deac:
	bset	#7,(a0)
.Not_empty2:
	lea.l	Sold_slots,a1
	move.l	(a1)+,d0
	or.l	(a1)+,d0
	or.l	(a1)+,d0
	bne.s	.Not_empty3
	bset	#7,5(a0)
.Not_empty3:
	bsr.w	Places_CIL_evaluate
	movem.l	(sp)+,d0/d7/a1
	rts	
; ---- Sage_DisUpd (original source: MAIN/PLACES.ASM)
Sage_DisUpd:
	bsr.w	Update_status_block
	lea.l	Sage_CIL,a0
	lea.l	SageCIL_evaluate,a1
	bsr.w	Update_control_icons
	bsr.w	Display_gold
	rts	
; ---- Sage_DisInit (original source: MAIN/PLACES.ASM)
Sage_DisInit:
	move.l	#Lay3_PlusMes,PlusMes_info
	movea.l	Off_screen,a6
	moveq.l	#3,d0
	bsr.w	Show_layout
	bsr.w	Display_80x80_picture
	bsr.w	Places_DisInit
	bsr.w	List_body_items
	move.l	#Sold_data,Itemdata_ptr
	move.l	#Sold_slots,Itemslots_ptr
	bsr.w	Show_objects_LAY3
	sf	Body_backpack
	lea.l	Sage_CIL,a0
	bsr.w	SageCIL_evaluate
	move.l	a0,Control_list_ptr
	bsr.w	Show_control_icons
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	Lay3_L2,a0
	jsr	Set_layout_data
	bra.w	Fadein_lay3
; ---- SageCIL_evaluate (original source: MAIN/PLACES.ASM)
SageCIL_evaluate:
	tst.b	Body_backpack
	beq.s	.Backpack
	bclr	#7,(a0)
	bset	#7,3(a0)
	bra.s	.Exit
.Backpack:
	bset	#7,(a0)
	bclr	#7,3(a0)
.Exit:
	bsr.w	Places_CIL_evaluate
	rts	
; ---- Show_body_items (original source: MAIN/PLACES.ASM)
Show_body_items:
	move.l	#Sold_data,Itemdata_ptr
	move.l	#Sold_slots,Itemslots_ptr
	movea.l	Off_screen,a6
	bsr.w	Show_objects_LAY3
	jsr	Switch_screen
	jsr	Copy_screen
	not.b	Body_backpack
	rts	
; ---- Show_backpack_items (original source: MAIN/PLACES.ASM)
Show_backpack_items:
	movea.l	Current_active_char_data,a0
	lea.l	Inv_data+360(a0),a1
	move.l	a1,Itemdata_ptr
	lea.l	Inventory_1_place_counter(a0),a1
	move.l	a1,Itemslots_ptr
	movea.l	Off_screen,a6
	bsr.w	Show_objects_LAY3
	jsr	Switch_screen
	jsr	Copy_screen
	not.b	Body_backpack
	rts	
; ---- Lore_item (original source: MAIN/PLACES.ASM)
Lore_item:
	tst.b	d0
	beq.w	.Exit
	movea.l	Itemslots_ptr,a0
	ext.w	d0
	tst.b	-1(a0,d0.w)
	beq.w	.Exit
	tst.b	Body_backpack
	beq.s	.Body
	addi.w	#9,d0
.Body:
	move.b	d0,Object_slot_number
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	movea.l	Current_active_char_data,a0
	lea.l	Inv_data-40(a0),a0
	mulu.w	#40,d0
	adda.w	d0,a0
	btst	#7,Item_stat_bits(a0)
	beq.s	.No
	move.l	#Lay3_PlusMes,PlusMes_info
	move.l	#Code0003Sys,Textfile_ptr
	move.w	#$19,d0	; CHANGE: was "PlusMes 24"
	bsr.w	Plus_message
	bra.s	.Exit
.No:
	movea.l	Placedat_ptr,a0
	move.w	(a0),d0
	cmp.w	Places_gold,d0
	ble.s	.Ok
	move.l	#Lay3_PlusMes,PlusMes_info
	move.l	#Code0002Sys,Textfile_ptr
	move.w	#22,d0
	bsr.w	Plus_message
	bra.s	.Exit
.Ok:
	move.w	d0,Total_price
	lea.l	LoreItemReq_Mod,a0
	bsr.w	Push_Module
.Exit:
	rts	
; ---- LoreItemReq_ModInit (original source: MAIN/PLACES.ASM)
LoreItemReq_ModInit:
	move.l	#Code0003Sys,Textfile_ptr
	moveq.l	#0,d0
	bra.w	BuyTRANSReq_ModInit
; ---- LoreItemYes (original source: MAIN/PLACES.ASM)
LoreItemYes:
	move.w	Total_price,d0
	sub.w	d0,Places_gold
	movea.l	Current_active_char_data,a0
	lea.l	Inv_data(a0),a0
	move.b	Object_slot_number,d0
	ext.w	d0
	subq.w	#1,d0
	mulu.w	#40,d0
	adda.w	d0,a0
	bset	#7,Item_stat_bits(a0)
	btst	#1,Mouse_button_state
	bne.s	*-8
	movea.l	Current_active_char_data,a0	; CHANGE: was "Wait_4_unclick"
	lea.l	$22(a0),a1	; CHANGE: was "move.l Current_active_char_data,Current_inventory_chardat_ptr"
	lea.l	$132(a0),a0	; CHANGE: added
	move.l	a0,Itemdata_ptr	; CHANGE: added
	move.l	a1,Itemslots_ptr	; CHANGE: added
	lea.l	ItemView1_Mod,a0
	move.l	#T_0dad0,$28(a0)	; CHANGE: added
	bsr.w	Push_Module
	rts	
T_0dad0:
	clr.l	D_2b0f6
	tst.b	Body_backpack
	bne.b	.l_0daf4
	move.l	#Sold_data,Itemdata_ptr
	move.l	#Sold_slots,Itemslots_ptr
	bra.b	.l_0db0e
.l_0daf4:
	dc.b	$20,$79
	dc.l	Current_active_char_data
	dc.b	$43,$e8,$02,$9a,$23,$c9
	dc.l	Itemdata_ptr
	dc.b	$43,$e8,$00,$2b,$23,$c9
	dc.l	Itemslots_ptr
.l_0db0e:
	rts
; ---- List_body_items (original source: MAIN/PLACES.ASM)
List_body_items:
	movem.l	d6/d7/a0-a3,-(sp)
	movea.l	Current_active_char_data,a0
	lea.l	Inv_data(a0),a1
	lea.l	Neck_place_counter(a0),a0
	lea.l	Sold_slots,a2
	lea.l	Sold_data,a3
	clr.l	(a2)+
	clr.l	(a2)+
	clr.l	(a2)
	lea.l	-8(a2),a2
	moveq.l	#9-1,d7
.Loop1:
	tst.b	(a0)+
	beq.s	.Next
	cmpi.b	#17,Item_type(a1)
	beq.s	.Next
	move.b	#1,(a2)+
	moveq.l	#10-1,d6
.Loop2:
	move.l	(a1)+,(a3)+
	dbra	d6,.Loop2
	bra.s	.Skip
.Next:
	lea.l	40(a1),a1
	addq.l	#1,a2
	lea.l	40(a3),a3
.Skip:
	dbra	d7,.Loop1
	movem.l	(sp)+,d6/d7/a0-a3
	rts	
; ---- Sage_Member_left (original source: MAIN/PLACES.ASM)
Sage_Member_left:
	andi.l	#$0000ff00,d0
	beq.s	.Exit
	lsr.w	#8,d0
	cmp.w	Active_member,d0
	beq.s	.Exit
	lea.l	Chard_ptrs-4,a0
	move.w	d0,d1
	add.w	d1,d1
	add.w	d1,d1
	adda.w	d1,a0
	tst.l	(a0)
	beq.s	.Exit
	movea.l	(a0),a1
	move.w	Body_conditions(a1),d1
	andi.w	#$e406,d1	; CHANGE: was "andi.w #$e506,d1"
	bne.s	.Exit
	move.w	d0,Active_member
	move.l	a1,Current_active_char_data
	bsr.w	List_body_items
	tst.b	Body_backpack
	beq.s	.Body
	movea.l	Current_active_char_data,a0
	lea.l	Inv_data+360(a0),a1
	move.l	a1,Itemdata_ptr
	lea.l	Inventory_1_place_counter(a0),a1
	move.l	a1,Itemslots_ptr
.Body:
	movea.l	Off_screen,a6
	bsr.w	Show_objects_LAY3
	jsr	Switch_screen
	jsr	Copy_screen
.Exit:
	rts	
; ---- Inn_DisUpd (original source: MAIN/PLACES.ASM)
Inn_DisUpd:
	bsr.w	Update_status_block
	lea.l	Inn_CIL,a0
	lea.l	InnCIL_evaluate,a1
	bsr.w	Update_control_icons
	bsr.w	Display_gold
	rts	
; ---- Inn_DisInit (original source: MAIN/PLACES.ASM)
Inn_DisInit:
	sf	Room_rented
	move.l	#Lay3_PlusMes,PlusMes_info
	movea.l	Off_screen,a6
	moveq.l	#3,d0
	bsr.w	Show_layout
	bsr.w	Display_80x80_picture
	bsr.w	Places_DisInit
	bsr.w	T_0dcde	; CHANGE: added
	move.w	d0,d1	; CHANGE: added
	movea.l	Placedat_ptr,a0
	move.w	(a0),d0
	mulu.w	d1,d0	; CHANGE: was "mulu.w Nr_members,d0"
	move.w	d0,Total_price
	lea.l	Inn_CIL,a0
	bsr.w	InnCIL_evaluate
	move.l	a0,Control_list_ptr
	bsr.w	Show_control_icons
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	Lay3_L2,a0
	jsr	Set_layout_data
	bra.w	Fadein_lay3
; ---- InnCIL_evaluate (original source: MAIN/PLACES.ASM)
InnCIL_evaluate:
	bclr	#7,3(a0)
	tst.b	Room_rented
	bne.s	.Deac
	move.w	Total_price,d0
	cmp.w	Places_gold,d0
	ble.s	.Ok
.Deac:
	bset	#7,3(a0)
.Ok:
	bsr.w	Places_CIL_evaluate
	rts	
; ---- Guestroom (original source: MAIN/PLACES.ASM)
Guestroom:
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	lea.l	GuestroomReq_Mod,a0
	bsr.w	Push_Module
	rts	
; ---- GuestroomReq_ModInit (original source: MAIN/PLACES.ASM)
GuestroomReq_ModInit:
	moveq.l	#6,d0
	move.l	#Code0003Sys,Textfile_ptr
	bra.w	BuyTRANSReq_ModInit
; ---- GuestroomYes (original source: MAIN/PLACES.ASM)
GuestroomYes:
	move.w	Total_price,d0
	sub.w	d0,Places_gold
	st	Inn_flag
	st	Room_rented
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	bsr.w	Exit_display
	bra.w	Pop_Module
T_0dcde:
	movem.l	d7/a0-a1,-(a7)
	lea.l	Chard_ptrs,a0
	moveq	#0,d0
	moveq	#5,d7
.l_0dcec:
	tst.l	(a0)
	beq.b	.l_0dcfc
	movea.l	(a0),a1
	cmpi.b	#$9,Character_race(a1)
	bpl.b	.l_0dcfc
	addq.w	#$1,d0
.l_0dcfc:
	addq.l	#$4,a0
	dbra	d7,.l_0dcec
	movem.l	(a7)+,d7/a0-a1
	rts

	section	data

GoldDis_text:
	dc.b	$30
D_2907d:
	dc.b	$31,$32,$33,$34,$00
Make_level_txt:
	dc.b	$30,$31,$25,$00
Bonus_txt:
	dc.b	$42,$4f,$4e,$55,$53,$20,$3a,$20,$30,$31,$25,$00
Multi_txt:
	dc.b	$20,$78,$20,$00
D_29096:
	dc.b	$20,$45,$50,$2e,$00,$00
Guild_CIL:
	dc.b	$34,$38,$1e,$35,$38,$38,$1f,$32,$12,$00
	dc.l	Join_guild
	dc.b	$00,$00,$00,$00
	dc.l	Exit_PLACES
	dc.l	T_0b230
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00
	dc.l	Pool_gold_PLACES
	dc.l	Divide_gold_PLACES
	dc.l	Transfer_gold_PLACES
MOBJC_CIL:
	dc.b	$36,$38,$1e,$37,$23,$21,$1f,$32,$12,$00
	dc.l	Buy_item
	dc.b	$00,$00,$00,$00
	dc.l	Exit_PLACES
	dc.l	Sell_item
	dc.l	View_item_MOBJC
	dc.l	Transfer_item_MOBJC
	dc.l	Pool_gold_PLACES
	dc.l	Divide_gold_PLACES
	dc.l	Transfer_gold_PLACES
MFOOD_CIL:
	dc.b	$38,$38,$1e,$40,$33,$14,$1f,$32,$12,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00
	dc.l	Exit_PLACES
	dc.l	T_0c9f4
	dc.l	T_0c9d6
	dc.l	MFOOD_Transfer_food
	dc.l	Pool_gold_PLACES
	dc.l	Divide_gold_PLACES
	dc.l	Transfer_gold_PLACES
MHORSE_CIL:
	dc.b	$38,$38,$1e,$05,$38,$38,$1f,$32,$12,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00
	dc.l	Exit_PLACES
	dc.l	Buy_horses
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00
	dc.l	Pool_gold_PLACES
	dc.l	Divide_gold_PLACES
	dc.l	Transfer_gold_PLACES
MRAFT_CIL:
MSHIP_CIL:
	dc.b	$38,$38,$1e,$06,$38,$38,$1f,$32,$12,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00
	dc.l	Exit_PLACES
	dc.l	T_0ce6e
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00
	dc.l	Pool_gold_PLACES
	dc.l	Divide_gold_PLACES
	dc.l	Transfer_gold_PLACES
D_29182:
	dc.b	$38,$38,$1e,$16,$38,$38,$1f,$32,$12,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00
	dc.l	Exit_PLACES
	dc.l	T_0cf70
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00
	dc.l	Pool_gold_PLACES
	dc.l	Divide_gold_PLACES
	dc.l	Transfer_gold_PLACES
Healer_CIL:
	dc.b	$38,$38,$1e,$0c,$38,$38,$1f,$32,$12,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00
	dc.l	Exit_PLACES
	dc.l	Healer_Remove_curse
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00
	dc.l	Pool_gold_PLACES
	dc.l	Divide_gold_PLACES
	dc.l	Transfer_gold_PLACES
MMAGIC_CIL:
	dc.b	$36,$38,$1e,$38,$23,$21,$1f,$32,$12,$00
	dc.l	Buy_item
	dc.b	$00,$00,$00,$00
	dc.l	Exit_PLACES
	dc.b	$00,$00,$00,$00
	dc.l	View_item_MOBJC
	dc.l	Transfer_item_MOBJC
	dc.l	Pool_gold_PLACES
	dc.l	Divide_gold_PLACES
	dc.l	Transfer_gold_PLACES
Sage_CIL:
	dc.b	$09,$38,$1e,$1d,$38,$38,$1f,$32,$12,$00
	dc.l	Show_body_items
	dc.b	$00,$00,$00,$00
	dc.l	Exit_PLACES
	dc.l	Show_backpack_items
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00
	dc.l	Pool_gold_PLACES
	dc.l	Divide_gold_PLACES
	dc.l	Transfer_gold_PLACES
Inn_CIL:
	dc.b	$38,$38,$1e,$13,$38,$38,$1f,$32,$12,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00
	dc.l	Exit_PLACES
	dc.l	Guestroom
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00
	dc.l	Pool_gold_PLACES
	dc.l	Divide_gold_PLACES
	dc.l	Transfer_gold_PLACES
XLay3_target_hbl:
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$07,$50,$03,$33,$02,$22,$01,$11,$07,$42
	dc.b	$06,$31,$02,$00,$05,$66,$03,$45,$07,$54,$06,$43,$05,$32,$04,$21
	dc.b	$03,$10,$07,$65
BodyMind_Distribution:
	dc.b	$08,$09,$09,$0a,$0a,$0b,$0b,$0c,$0c,$0d,$0d,$00,$0e,$00,$0f,$00
	dc.b	$ff,$00,$01,$0f,$ff,$00,$ff,$00,$04,$12
D_292c6:
	dc.b	$ff,$ff,$ff,$ff,$0e,$ff,$ff,$0f,$10,$11,$11,$11,$12,$ff,$ff,$ff
	dc.b	$ff,$ff,$ff,$ff,$ff,$ff,$ff,$00

	section	bss

Place_nr:
	ds.b	2
Places_gold:
	ds.b	2
Placedat_ptr:
	ds.b	4
Placetext_ptr:
	ds.b	3
B_5b2a5:
	ds.b	1
Make_level_offsets:
	ds.b	9
B_5b2af:
	ds.b	1
Possible_level_offsets:
	ds.b	10
Exit_on:
	ds.b	1
Room_rented:
	ds.b	1
Trans_created:
	ds.b	1
Body_backpack:
	ds.b	1
Cursed_slots:
	ds.b	10
Remaining_offset:
	ds.b	2
Warecount_ptr:
	ds.b	4
Sold_data:
	ds.b	479
B_5b4ad:
	ds.b	1
Sold_slots:
	ds.b	12
Total_price:
	ds.b	2
Places_food:
	ds.b	2
Nr_cursed_objects:
	ds.b	2
Current_healer_victim:
	ds.b	4
Healer_victim_nr:
	ds.b	2
