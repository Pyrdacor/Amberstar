; MAIN/TEST.ASM (original module, merged with the disassembly of the shipped program)

	dc.w	$a00a
	movea.l	$4(a7),a0
	move.l	a0,B_5bea4
	lea.l	$80(a0),a0
	move.b	(a0)+,d0
	bne.b	T_00022
T_00014:
	dc.w	$a009
	move.w	#$0,-(a7)
	move.w	#$4c,-(a7)
	trap	#$1
	addq.l	#$4,a7
T_00022:
	ext.w	d0
	subq.w	#$1,d0
	lea.l	D_2e510,a1
T_0002c:
	cmpm.b	(a0)+,(a1)+
	bne.b	T_00014
	dbra	d0,T_0002c
	move.l	a7,B_5bea8
	lea.l	Icondata_ptr,a7
	clr.l	-(a7)
	move.w	#$20,-(a7)
	trap	#$1
	addq.l	#$6,a7
	move.l	d0,B_5beac
	lea.l	B_5ceb0,a7
	jsr	T_1c19e
	jsr	T_1c9ae
	jsr	T_1cb2c
	movea.l	B_5bea4,a0
	jsr	T_1d190
	jsr	T_1cee8
	jsr	T_1b63c
	jsr	HBL_on
	jsr	Mouse_on
	move.b	#$dd,d0
	move.b	d0,B_52f40
	neg.b	d0
	move.b	d0,B_52f41
	move.b	#$fe,B_52f42
	move.b	#$c,B_52f43
	lea.l	D_48a3a,a0
	move.w	(a0)+,d0
	mulu.w	#$18,d0
	adda.w	d0,a0
	move.l	a0,Placetext_ptr
	lea.l	Buffer_Mod,a0
	jsr	Push_Module
	move.w	#$ffff,Music_block
T_000d6:
	moveq	#0,d0
	bsr.w	Play_song
	lea.l	D_2fcfa,a0
	jsr	Push_Root
	movea.l	Off_screen,a6
	jsr	Clear_screen
	bsr.w	Show_status_block
	jsr	Switch_screen
	jsr	Copy_screen
	jsr	T_1d278
	jsr	T_10936
	lea.l	D_2e7ae,a0
	bsr.w	Push_PA
	bsr.w	T_00194
	bsr.w	T_07200
	bsr.w	Restore_game
	bsr.w	Update_status_block
	jsr	Switch_screen
	jsr	Copy_screen
	bsr.w	DoAutoIcon
	bsr.w	Init_map
; ---- Main_loop (original source: MAIN/TEST.ASM)
Main_loop:
	move.w	#0,Draw_Cicon
	jsr	Input_handler
	movea.l	Module_sp,a0
	move.l	(a0),d0
	beq.s	.Skip
	movea.l	d0,a0
	jsr	(a0)
.Skip:
	jsr	Switch_screen
	bra.s	Main_loop
Exit_all:
	move.l	#$700ff00,$ffff8800.w
	jsr	Restore_computer
	move.l	B_5beac,-(a7)
	move.w	#$20,-(a7)
	trap	#$1
	addq.l	#$6,a7
	movea.l	B_5bea8,a7
	dc.w	$a009
	move.w	B_59312,-(a7)
	move.w	#$4c,-(a7)
	trap	#$1
	addq.l	#$4,a7
T_00194:
	movem.l	d0-d3/d6/a0-a2/a6,-(a7)
	bsr.w	T_0029c
	move.w	#$60,d0
	move.w	#$3e,d1
	move.w	#$8,d6
	move.w	#$70,d7
	lea.l	D_45208,a0
	movea.l	Off_screen,a6
	jsr	Blot_unmasked_block
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	D_2e4ec,a1
	lea.l	Subfade2,a2
T_001d6:
	lea.l	D_30408,a0
	jsr	Update_HBL
	jsr	My_vsync
	lea.l	D_3042c,a0
	jsr	Fade_pal
	bne.b	T_001d6
	lea.l	D_30408,a0
	jsr	Update_HBL
	movem.l	(a7)+,d0-d3/d6/a0-a2/a6
	rts
T_00208:
	movem.l	d0-d7/a0-a6,-(a7)
	lea.l	Void,a1
	lea.l	Subfade2,a2
T_00218:
	lea.l	D_30408,a0
	jsr	Update_HBL
	jsr	My_vsync
	lea.l	D_3042c,a0
	jsr	Fade_pal
	bne.b	T_00218
	lea.l	D_30408,a0
	jsr	Update_HBL
	bsr.w	T_0029c
	jsr	Switch_screen
	jsr	Copy_screen
	movem.l	(a7)+,d0-d7/a0-a6
	rts
T_0025a:
	tst.b	B_5d0f1
	bne.b	T_00266
	bra.w	T_00194
T_00266:
	movem.l	d0-d7/a6,-(a7)
	bsr.w	T_0029c
	jsr	Switch_screen
	jsr	Copy_screen
	movem.l	D_2e4ec,d0-d7
	movem.l	d0-d7,D_3042c
	lea.l	D_30408,a0
	jsr	Update_HBL
	movem.l	(a7)+,d0-d7/a6
	rts
T_0029c:
	move.w	#$0,d0
	move.w	#$25,d1
	move.w	#$13f,d2
	move.w	#$c7,d3
	moveq	#0,d6
	movea.l	Off_screen,a6
	jsr	Draw_box
	rts
; ---- Restore_game (original source: MAIN/TEST.ASM)
Restore_game:
	movem.l	d0/d7/a0-a2,-(sp)
	bsr.w	Load_party_data
	move.w	Travel_mode,d0
	bsr.w	Set_new_travel_mode
	lea.l	Member_1_nr,a1
	lea.l	Chard_ptrs,a2
	moveq.l	#5,d7
.Loop:
	move.w	(a1)+,d0
	beq.s	.Next
	lea.l	Chard_filename,a0
	jsr	Load_subfile
	move.l	a0,(a2)
.Next:
	addq.l	#4,a2
	dbra	d7,.Loop
	lea.l	Chard_ptrs,a0
	move.w	Active_member,d0
	add.w	d0,d0
	add.w	d0,d0
	move.l	-4(a0,d0.w),Current_active_char_data
	movem.l	(sp)+,d0/d7/a0-a2
	rts	
Load_party_data:
	movem.l	d0/d7/a0-a1,-(a7)
	lea.l	D_2f26a,a0
	jsr	T_1b786
	move.l	a0,-(a7)
	cmpi.l	#$59415921,(a0)
	bne.b	T_00342
	addq.l	#$4,a0
	move.w	(a0),d0
	eori.w	#$4a48,d0
	move.l	B_5d0f4,d7
	subq.l	#$4,d7
	bsr.w	T_00ef0
	addq.l	#$2,a0
T_00342:
	lea.l	Month,a1
	moveq	#0,d0
	moveq	#23,d7
T_0034c:
	move.b	(a0)+,d0
	move.w	d0,(a1)+
	dbra	d7,T_0034c
	move.w	#$15ad,d7
T_00358:
	move.w	(a0)+,(a1)+
	dbra	d7,T_00358
	bsr.w	Init_modifications
	movea.l	(a7)+,a0
	jsr	Kill_memory
	movem.l	(a7)+,d0/d7/a0-a1
	rts
Init_modifications:
	movem.l	d0/a0-a1,-(a7)
	move.l	#$200,d0
	mulu.w	#$6,d0
	addq.l	#$2,d0
	jsr	Allocate_memory
	move.l	a1,Modifications_ptr
	moveq	#0,d0
T_0038e:
	tst.w	(a0)
	beq.b	T_0039a
	move.l	(a0)+,(a1)+
	move.w	(a0)+,(a1)+
	addq.w	#$1,d0
	bra.b	T_0038e
T_0039a:
	clr.w	(a1)
	move.w	d0,Nr_of_modifications
	movem.l	(a7)+,d0/a0-a1
	rts
; ---- Make_modifications (original source: MAIN/TEST.ASM)
Make_modifications:
	movem.l	d0-d2/a1,-(sp)
	moveq.l	#0,d0
	moveq.l	#0,d1
	movea.l	Modifications_ptr,a1
.Again:
	tst.w	(a1)
	beq.s	.Exit
	cmp.w	(a1),d7
	bne.s	.Next
	move.b	2(a1),d0
	move.b	3(a1),d1
	move.w	4(a1),d2
	bmi.s	.Event
	jsr	Do_change_icon
	bra.s	.Next
.Event:
	jsr	Remove_event
.Next:
	addq.l	#6,a1
	bra.s	.Again
.Exit:
	movem.l	(sp)+,d0-d2/a1
	rts	
Enter_modification:
	movem.l	d7/a0,-(a7)
	move.w	Nr_of_modifications,d7
	cmpi.w	#$200,d7
	bmi.b	T_00402
	lea.l	D_2e7d6,a1
	jsr	DI_Error
	bra.b	T_00424
T_00402:
	addq.w	#$1,d7
	move.w	d7,Nr_of_modifications
	movea.l	Modifications_ptr,a0
	mulu.w	#$6,d7
	lea.l	-$6(a0,d7.w),a0
	move.w	Map_nr,(a0)+
	move.b	d0,(a0)+
	move.b	d1,(a0)+
	move.w	d2,(a0)
T_00424:
	movem.l	(a7)+,d7/a0
	rts
Set_new_travel_mode:
	move.l	d0,-(a7)
	cmpi.w	#$7,d0
	bmi.b	T_00440
	lea.l	D_2e80b,a1
	jsr	DI_Error
	bra.b	T_0047c
T_00440:
	move.w	d0,Travel_mode
	cmpi.b	#$1,Current_map_type
	bne.b	T_00454
	bsr.w	Set_map_music
T_00454:
	cmpi.w	#$5,d0
	smi.b	D_1e1fa
	tst.w	B_5930c
	beq.b	T_0046c
	sf.b	D_1e1fa
T_0046c:
	add.w	d0,d0
	move.w	T_00480(pc,d0.w),B_57c68
	clr.w	B_57c66
T_0047c:
	move.l	(a7)+,d0
	rts
T_00480:
	dc.b	$00,$04,$00,$02,$00,$03,$00,$02,$00,$04,$00,$01,$00,$01
; ---- Member_left (original source: MAIN/TEST.ASM)
Member_left:
	andi.l	#$0000ff00,d0
	beq.s	.Exit
	lsr.w	#6,d0
	move.w	d0,d1
	lea.l	Chard_ptrs,a0
	move.l	-$4(a0,d0.w),d0	; CHANGE: was "movea.l -4(a0,d0.w),a0"
	beq.b	.Exit	; CHANGE: added
	movea.l	d0,a0	; CHANGE: added
	move.w	Body_conditions(a0),d0
	andi.w	#$e486,d0	; CHANGE: was "andi.w #$e506,d0"
	bne.s	.Exit
	lsr.w	#2,d1
	move.w	d1,Active_member
	lea.l	Chard_ptrs,a0
	add.w	d1,d1
	add.w	d1,d1
	move.l	-4(a0,d1.w),Current_active_char_data
.Exit:
	rts	
T_004ce:
	movem.l	d0/a0,-(a7)
	andi.l	#$ff00,d0
	beq.b	T_004e0
	lsr.w	#$8,d0
	bsr.w	T_00546
T_004e0:
	movem.l	(a7)+,d0/a0
	rts
; ---- Set_layout_data (original source: MAIN/TEST.ASM)
Set_layout_data:
	move.l	a0,Layout_data_ptr
	rts	
; ---- Delay (original source: MAIN/TEST.ASM)
Delay:
	move.l	d0,-(sp)
	bra.s	.Entry
.Loop:
	jsr	My_vsync
.Entry:
	dbra	d0,.Loop
.Exit:
	move.l	(sp)+,d0
	rts	
T_00500:
	move.w	#$100,d0
	bra.w	Member_left
T_00508:
	move.w	#$200,d0
	bra.w	Member_left
T_00510:
	move.w	#$300,d0
	bra.w	Member_left
T_00518:
	move.w	#$400,d0
	bra.w	Member_left
T_00520:
	move.w	#$500,d0
	bra.w	Member_left
T_00528:
	move.w	#$600,d0
	bra.w	Member_left
T_00530:
	moveq	#1,d0
	bra.b	T_00546
T_00534:
	moveq	#2,d0
	bra.b	T_00546
T_00538:
	moveq	#3,d0
	bra.b	T_00546
T_0053c:
	moveq	#4,d0
	bra.b	T_00546
T_00540:
	moveq	#5,d0
	bra.b	T_00546
T_00544:
	moveq	#6,d0
T_00546:
	lea.l	Codetxt_ptr,a0
	add.w	d0,d0
	add.w	d0,d0
	adda.w	d0,a0
	tst.l	(a0)
	beq.b	T_005a0
	movea.l	(a0),a0
	move.l	a0,Current_inventory_chardat_ptr
	st.b	B_587f8
	jsr	Exit_display
	lea.l	Inv1_Mod,a0
	jsr	Push_Module
	movea.l	Current_inventory_chardat_ptr,a0
	move.w	$3a(a0),d0
	andi.w	#$482,d0
	beq.b	T_00594
	sf.b	B_587f8
	jsr	Init_display
	bra.b	T_005a0
T_00594:
	lea.l	Inv2_Mod,a0
	jsr	Push_Module
T_005a0:
	rts
T_005a2:
	moveq	#1,d0
	bra.w	Do_control_icons
T_005a8:
	moveq	#2,d0
	bra.w	Do_control_icons
T_005ae:
	moveq	#3,d0
	bra.w	Do_control_icons
T_005b4:
	moveq	#4,d0
	bra.w	Do_control_icons
T_005ba:
	moveq	#5,d0
	bra.w	Do_control_icons
T_005c0:
	moveq	#6,d0
	bra.w	Do_control_icons
T_005c6:
	moveq	#7,d0
	bra.w	Do_control_icons
T_005cc:
	moveq	#8,d0
	bra.w	Do_control_icons
T_005d2:
	moveq	#9,d0
	bra.w	Do_control_icons
Update_damage_magic:
	movem.l	d0/d7/a0-a1/a6,-(a7)
	lea.l	B_58ec0,a0
	lea.l	Char_damage,a1
	movea.l	Off_screen,a6
	moveq	#1,d7
T_005f0:
	tst.b	(a0)
	beq.b	T_00604
	move.w	(a1),d0
	bsr.w	Display_damage
	subq.b	#$1,(a0)
	bne.b	T_00604
	move.w	d7,d0
	bsr.w	Force_char_update
T_00604:
	addq.l	#$1,a0
	addq.l	#$2,a1
	addq.w	#$1,d7
	cmpi.w	#$7,d7
	bmi.b	T_005f0
	move.w	Magic_anim_counter,d0
	addq.w	#$1,d0
	cmpi.w	#$c,d0
	bmi.b	T_00620
	moveq	#0,d0
T_00620:
	move.w	d0,Magic_anim_counter
	lea.l	Magic_timers,a0
	movea.l	Off_screen,a6
	moveq	#1,d7
T_00634:
	tst.b	(a0)
	beq.b	T_00646
	bsr.w	Display_magic
	subq.b	#$1,(a0)
	bne.b	T_00646
	move.w	d7,d0
	bsr.w	Force_char_update
T_00646:
	addq.l	#$1,a0
	addq.w	#$1,d7
	cmpi.w	#$7,d7
	bmi.b	T_00634
	movem.l	(a7)+,d0/d7/a0-a1/a6
	rts
Display_damage:
	movem.l	d0-d2/d6-d7/a0,-(a7)
	lea.l	Status_PA,a0
	bsr.w	Push_PA
	move.w	d0,d2
	move.w	d7,d0
	mulu.w	#$30,d0
	subi.w	#$20,d0
	moveq	#1,d1
	moveq	#2,d6
	moveq	#32,d7
	lea.l	D_3cf60,a0
	jsr	Blot_masked_block
	addi.w	#$a,d0
	exg.l	d0,d2
	tst.w	d0
	beq.b	T_006a8
	moveq	#2,d7
	lea.l	D_2e7ce,a0
	lea.l	$4(a0),a3
	jsr	LConvert_number
	moveq	#12,d0
	exg.l	d2,d0
	moveq	#11,d1
	bsr.w	Print_centered_string
T_006a8:
	bsr.w	Pop_PA
	movem.l	(a7)+,d0-d2/d6-d7/a0
	rts
; ---- Display_magic (original source: MAIN/TEST.ASM)
Display_magic:
	movem.l	d0/d1/d6/d7/a0,-(sp)
	move.w	d7,d0
	mulu.w	#48,d0
	subi.w	#32,d0
	lea.l	Chard_ptrs,a0
	add.w	d7,d7
	add.w	d7,d7
	movea.l	-4(a0,d7.w),a0
	lea.l	Portrait+6(a0),a0
	moveq.l	#1,d1
	moveq.l	#2,d6
	moveq.l	#32,d7
	jsr	Blot_unmasked_block
	lea.l	Status_icn+4096,a0
	move.w	Magic_anim_counter,d2
	andi.w	#$fffc,d2
	lsl.w	#7,d2
	adda.w	d2,a0
	jsr	Blot_masked_block
	movem.l	(sp)+,d0/d1/d6/d7/a0
	rts	
; If no member can be the active member, a battle ends or the party is dead (Shandra's rescue or game over).
Check_party_alive:
	movem.l	d0-d1/d7/a0-a1,-(a7)
	jsr	Exit_display
	lea.l	Chard_ptrs,a0
	moveq	#5,d7
T_00710:
	tst.l	(a0)
	beq.b	T_00762
	movea.l	(a0),a1
	move.w	$3a(a1),d0
	andi.w	#$e586,d0
	bne.b	T_00762
	clr.w	Active_member
	lea.l	ActSel_Mod,a0
	jsr	Push_Module
T_00732:
	move.w	#$0,Draw_Cicon
	jsr	Input_handler
	bsr.w	Update_status_block
	jsr	Switch_screen
	tst.w	Active_member
	beq.b	T_00732
	jsr	Pop_Module
	jsr	Init_display
	bra.w	T_00800
T_00762:
	addq.l	#$4,a0
	dbra	d7,T_00710
	st.b	B_58aac
	tst.b	Battling
	beq.b	T_007a2
	movea.l	Current_active_char_data,a0
	btst	#$7,$3b(a0)
	beq.b	T_0078c
	tst.w	B_58ab0
	beq.b	T_007a2
T_0078c:
	move.w	#$ffff,B_58e5e
	clr.w	B_58ab0
	jsr	Pop_Module
	bra.b	T_00800
T_007a2:
	jsr	T_10936
	moveq	#6,d0
	move.w	d0,d1
	lsr.w	#$3,d0
	lea.l	Quest,a0
	btst	d1,(a0,d0.w)
	beq.b	T_007f4
	lea.l	Chard_ptrs,a0
	moveq	#0,d0
	moveq	#5,d7
T_007c4:
	tst.l	(a0)
	beq.b	T_007d2
	movea.l	(a0),a1
	add.w	$54(a1),d0
	add.w	$a8(a1),d0
T_007d2:
	addq.l	#$4,a0
	dbra	d7,T_007c4
	ext.l	d0
	divu.w	Nr_members,d0
	bsr.w	Probe
	bmi.b	T_007f4
	lea.l	D_2cc0c,a0
	jsr	Push_Module
	bra.b	T_00800
T_007f4:
	lea.l	D_2cc52,a0
	jsr	Push_Module
T_00800:
	movem.l	(a7)+,d0-d1/d7/a0-a1
	rts
ActSel_ModInit:
	move.w	#$0,d0
	move.w	#$25,d1
	move.w	#$13f,d2
	move.w	#$c7,d3
	move.w	#$0,d6
	movea.l	Off_screen,a6
	jsr	Draw_box
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	TxtW_PA,a0
	bsr.w	Push_PA
	moveq	#23,d0
	move.w	Nr_of_chars,d2
	lea.l	Code0006Sys,a1
	bsr.w	Prepare_text_block
HearTxtW_ModInit:
	move.w	Lines_in_text,d0
	mulu.w	#$7,d0
	moveq	#15,d3
	add.w	d0,d3
	andi.w	#$fff0,d3
	lsr.w	#$4,d3
	cmpi.w	#$2,d3
	bpl.b	T_0086a
	moveq	#2,d3
T_0086a:
	move.w	d3,d4
	lsl.w	#$4,d4
	sub.w	d0,d4
	moveq	#16,d0
	moveq	#52,d1
	moveq	#18,d2
	addq.w	#$2,d3
	moveq	#0,d6
	suba.l	a0,a0
	jsr	Open_window
	move.w	d0,B_592e0
	lsr.w	#$1,d4
	add.w	d4,d1
	addi.w	#$10,d1
	move.w	d1,D_25f80
	subq.w	#$2,d3
	lsl.w	#$4,d3
	move.w	d3,D_25f84
	bsr.w	Pop_PA
	lea.l	TxtW_PA,a0
	bsr.w	Push_PA
	movea.l	Text_buffer,a0
	movea.l	Off_screen,a6
	move.w	Nr_of_chars,d0
	move.w	Lines_in_text,d7
	bra.b	T_008d8
T_008c8:
	jsr	IG_Print
	jsr	IG_Carriage_return
	lea.l	$1(a0,d0.w),a0
T_008d8:
	dbra	d7,T_008c8
	jsr	Switch_screen
	jsr	Copy_screen
	movea.l	Text_buffer,a0
	jsr	Free_memory
	lea.l	D_2e7a6,a0
	jsr	Push_MA
	lea.l	D_2fce8,a0
	jsr	Push_Root
	lea.l	Lay6_target,a1
	lea.l	Subfade1,a2
T_00918:
	lea.l	Hbl_Lay6_list,a0
	jsr	Update_HBL
	jsr	My_vsync
	jsr	My_vsync
	lea.l	Lay6_below,a0
	jsr	Fade_pal
	bne.b	T_00918
	lea.l	Hbl_Lay6_list,a0
	jsr	Update_HBL
	rts
ActSel_ModExit:
	jsr	Pop_Root
	bsr.w	Pop_PA
	jsr	Pop_MA
	move.w	B_592e0,d0
	jsr	Close_window
; ---- Options_DisExit (original source: MAIN/EYE.ASM)
Options_DisExit:
	lea.l	Void,a1
	lea.l	Subfade1,a2
.Again:
	lea.l	Hbl_Lay6_list,a0
	jsr	Update_HBL
	jsr	My_vsync
	jsr	My_vsync
	lea.l	Lay6_below,a0
	jsr	Fade_pal
	bne.s	.Again
	lea.l	Hbl_Lay6_list,a0
	jsr	Update_HBL
	rts	
; Shandra rescues the party once: song 19, next day 7:20, map 70 at 16,13, conditions cleared, hit points filled.
Resurrection_sequence:
	bsr.w	T_0025a
	moveq	#19,d0
	lea.l	B_592ea,a0
	jsr	Load_80x80_picture
	bsr.w	T_00208
	movea.l	Mapd_ptr,a0
	addq.w	#$1,Nr_travelled_days
	move.w	Day,d0
	addq.w	#$1,d0
	move.w	d0,Day
	bsr.w	Every_day
	move.b	$abf(a0),d1
	sub.w	d1,d0
	bls.b	T_00a16
	move.w	d0,Day
	move.w	Month,d0
	addq.w	#$1,d0
	move.w	d0,Month
	move.b	$abe(a0),d1
	sub.w	d1,d0
	bls.b	T_00a16
	move.w	d0,Month
	addq.w	#$1,Year
	addq.w	#$1,Time_data_year
	bsr.w	Every_year
T_00a16:
	move.w	#$7,Hour
	move.w	#$14,Minute
	move.w	#$10,Map_Xcoord
	move.w	#$d,Map_Ycoord
	move.w	#$0,View_direction
	move.w	#$46,Map_nr
	lea.l	Chard_ptrs,a0
	moveq	#5,d7
T_00a4e:
	tst.l	(a0)
	beq.b	T_00a64
	movea.l	(a0),a1
	clr.w	$3a(a1)
	move.w	$88(a1),d0
	add.w	$98(a1),d0
	move.w	d0,$86(a1)
T_00a64:
	addq.l	#$4,a0
	dbra	d7,T_00a4e
	lea.l	Char_damage,a0
	moveq	#14,d7
T_00a72:
	clr.w	(a0)+
	dbra	d7,T_00a72
	lea.l	XActive_member,a0
	move.w	#$2a,d7
T_00a82:
	clr.w	(a0)+
	dbra	d7,T_00a82
	sf.b	First
	sf.b	Which_CIL
	sf.b	Battling
	sf.b	Party_invisible
	sf.b	Stygian
	move.w	Active_member,d0
	lsl.w	#$8,d0
	bsr.w	Member_left
	movea.l	Off_screen,a6
	bsr.w	DoAutoIcon
	bsr.w	Update_status_block
	moveq	#7,d0
	bsr.w	Show_layout
	moveq	#16,d0
	moveq	#81,d1
	moveq	#5,d6
	moveq	#80,d7
	movea.l	Pic80_ptr,a0
	jsr	Blot_unmasked_block
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	B_592ea,a1
	lea.l	Subfade2,a2
T_00af2:
	lea.l	D_30408,a0
	jsr	Update_HBL
	jsr	My_vsync
	jsr	My_vsync
	lea.l	D_3042c,a0
	jsr	Fade_pal
	bne.b	T_00af2
	lea.l	D_30408,a0
	jsr	Update_HBL
	lea.l	P80_PA,a0
	bsr.w	Push_PA
	lea.l	P80_area,a0
	jsr	Push_MA
	lea.l	Code0004Sys,a1
	moveq	#9,d0
	bsr.w	Mr_Blue_Sky
	jsr	Pop_Module
	bra.w	Init_map
T_00b50:
	bsr.w	Pop_PA
	jsr	Pop_MA
	movea.l	Pic80_ptr,a0
	jsr	Free_memory
	lea.l	Void,a1
	lea.l	Subfade2,a2
T_00b72:
	lea.l	D_30408,a0
	jsr	Update_HBL
	jsr	My_vsync
	jsr	My_vsync
	lea.l	D_3042c,a0
	jsr	Fade_pal
	bne.b	T_00b72
	lea.l	D_30408,a0
	jmp	Update_HBL
; Song 19, the message of the dead party, then the game restarts.
Game_over_sequence:
	bsr.w	T_0025a
	moveq	#19,d0
	bsr.w	Play_song
	moveq	#18,d0
	lea.l	B_592ea,a0
	jsr	Load_80x80_picture
	bsr.w	T_00208
	lea.l	D_2fe1a,a0
	jsr	Push_Root
	bra.w	T_00be8
T_00bd0:
	bsr.w	T_00ce2
	jsr	Pop_Root
	movea.l	Pic80_ptr,a0
	jsr	Free_memory
	rts
T_00be8:
	lea.l	P80_area,a0
	jsr	Push_MA
	movea.l	Off_screen,a6
	moveq	#7,d0
	bsr.w	Show_layout
	moveq	#16,d0
	moveq	#81,d1
	moveq	#5,d6
	moveq	#80,d7
	movea.l	Pic80_ptr,a0
	jsr	Blot_unmasked_block
	lea.l	P80_PA,a0
	bsr.w	Push_PA
	moveq	#10,d0
	move.w	Nr_of_chars,d2
	lea.l	Code0004Sys,a1
	bsr.w	Prepare_text_block
	movea.l	Text_buffer,a0
	move.w	Nr_of_chars,d0
	addq.w	#$1,d0
	move.w	Lines_in_text,d7
	subq.w	#$1,d7
T_00c46:
	jsr	IG_Print
	jsr	IG_Carriage_return
	adda.w	d0,a0
	dbra	d7,T_00c46
	bsr.w	Pop_PA
	movea.l	Text_buffer,a0
	jsr	Free_memory
	move.w	#$f0,d0
	move.w	#$b0,d1
	moveq	#2,d6
	moveq	#16,d7
	lea.l	D_39760,a0
	jsr	Blot_unmasked_block
	move.w	#$110,d0
	move.w	#$b0,d1
	moveq	#2,d6
	moveq	#16,d7
	lea.l	D_3c060,a0
	jsr	Blot_unmasked_block
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	B_592ea,a1
	lea.l	Subfade2,a2
T_00cb0:
	lea.l	D_30408,a0
	jsr	Update_HBL
	jsr	My_vsync
	jsr	My_vsync
	lea.l	D_3042c,a0
	jsr	Fade_pal
	bne.b	T_00cb0
	lea.l	D_30408,a0
	jmp	Update_HBL
T_00ce2:
	jsr	Pop_MA
	lea.l	Void,a1
	lea.l	Subfade2,a2
T_00cf4:
	lea.l	D_30408,a0
	jsr	Update_HBL
	jsr	My_vsync
	jsr	My_vsync
	lea.l	D_3042c,a0
	jsr	Fade_pal
	bne.b	T_00cf4
	lea.l	D_30408,a0
	jmp	Update_HBL
T_00d26:
	btst	#$1,Mouse_button_state
	bne.b	T_00d26
	move.l	#Code0004Sys,Textfile_ptr
	move.w	#$19,ReqText_nr
	move.l	#T_00d58,ReqDo_ptr
	lea.l	Req_Mod,a0
	jmp	Push_Module
T_00d58:
	jsr	Pop_Module
	bra.w	T_00e04
Req_ModInit:
	move.w	#$30,d0
	move.w	#$3c,d1
	moveq	#12,d2
	moveq	#5,d3
	moveq	#1,d6
	lea.l	D_2fe3e,a0
	jsr	Open_window
	move.w	d0,B_592e8
	movea.l	Off_screen,a6
	movea.l	PlusMes_info,a0
	move.l	#D_2e7ba,PlusMes_info
	move.w	ReqText_nr,d0
	bsr.w	Hash_message
	move.l	a0,PlusMes_info
	moveq	#2,d6
	moveq	#16,d7
	move.w	#$50,d0
	move.w	#$6c,d1
	lea.l	D_39a60,a0
	jsr	Blot_unmasked_block
	addi.w	#$20,d0
	lea.l	D_39b60,a0
	jsr	Blot_unmasked_block
	jsr	Switch_screen
	jsr	Copy_screen
	rts
Req_ModExit:
	move.w	B_592e8,d0
	jsr	Close_window
T_00dea:
	btst	#$1,Mouse_button_state
	bne.b	T_00dea
	rts
T_00df6:
	jsr	Pop_Module
	movea.l	ReqDo_ptr,a0
	jmp	(a0)
T_00e04:
	lea.l	Chard_ptrs,a0
	moveq	#5,d7
T_00e0c:
	clr.l	(a0)+
	dbra	d7,T_00e0c
	lea.l	Char_damage,a0
	moveq	#14,d7
T_00e1a:
	clr.w	(a0)+
	dbra	d7,T_00e1a
	lea.l	XActive_member,a0
	move.w	#$2a,d7
T_00e2a:
	clr.w	(a0)+
	dbra	d7,T_00e2a
	sf.b	First
	sf.b	Which_CIL
	sf.b	Battling
	sf.b	Party_invisible
	sf.b	Stygian
	move.l	#PA_Stack,PA_sp
	move.l	#B_5d8b2,MA_sp
	move.l	#B_5d0c4,Object_sp
	move.l	#D_51c84,Mptr_sp
	lea.l	B_5ceb0,a7
	bra.w	T_000d6
T_00e80:
	movem.l	d0-d1/d6-d7/a0-a1,-(a7)
	moveq	#0,d6
	lea.l	Chard_ptrs,a0
	moveq	#1,d7
T_00e8e:
	tst.l	(a0)
	beq.b	T_00eaa
	movea.l	(a0),a1
	move.l	$ec(a1),d0
	move.w	$48(a1),d1
	add.w	$9c(a1),d1
	mulu.w	#$3e8,d1
	cmp.l	d0,d1
	bpl.b	T_00eaa
	bset	d7,d6
T_00eaa:
	addq.l	#$4,a0
	addq.w	#$1,d7
	cmpi.w	#$7,d7
	bmi.b	T_00e8e
	lea.l	Chard_ptrs,a0
	bset	#$7,d6
	moveq	#5,d7
T_00ec0:
	tst.l	(a0)
	beq.b	T_00ede
	movea.l	(a0),a1
	move.w	$3a(a1),d0
	move.w	d0,d1
	andi.w	#$e000,d1
	bne.b	T_00ede
	btst	#$8,d1
	bne.b	T_00ede
	bclr	#$7,d6
	bra.b	T_00ee4
T_00ede:
	addq.l	#$4,a0
	dbra	d7,T_00ec0
T_00ee4:
	move.b	d6,B_592dd
	movem.l	(a7)+,d0-d1/d6-d7/a0-a1
	rts
T_00ef0:
	movem.l	d0-d2/d7/a0,-(a7)
	move.w	#$57,d2
	addq.l	#$1,d7
	asr.l	#$1,d7
	bra.b	T_00f08
T_00efe:
	eor.w	d0,(a0)+
	move.w	d0,d1
	lsl.w	#$4,d0
	add.w	d1,d0
	add.w	d2,d0
T_00f08:
	dbra	d7,T_00efe
	movem.l	(a7)+,d0-d2/d7/a0
	rts
; Plays the song in d0 (1-19, 0 stops the music, 20 and more are ignored). The current song is in Current_song.
Play_song:
	movem.l	d0-d1/a0,-(a7)
	tst.w	d0
	bne.b	T_00f32
	lea.l	D_4aa1c,a0
	moveq	#0,d0
	moveq	#1,d1
	jsr	Coso_player
	move.w	d0,Current_song
	bra.b	T_00f9a
T_00f32:
	cmpi.w	#$14,d0
	bmi.b	T_00f46
	lea.l	D_2e83d,a1
	jsr	DI_Error
	bra.b	T_00f9a
T_00f46:
	cmp.w	Current_song,d0
	beq.b	T_00f9a
	move.w	d0,Current_song
	move.l	d0,-(a7)
	lea.l	D_4aa1c,a0
	moveq	#0,d0
	moveq	#1,d1
	jsr	Coso_player
	move.l	(a7)+,d0
	lea.l	Song_table,a0
	add.w	d0,d0
	add.w	d0,d0
	movea.l	-$4(a0,d0.w),a0
	moveq	#1,d0
	moveq	#1,d1
	jsr	Coso_player
	move.w	sr,-(a7)
	ori.w	#$700,sr
	andi.b	#$f0,$fffffa1d.w
	move.b	#$f6,$fffffa25.w
	ori.b	#$7,$fffffa1d.w
	move.w	(a7)+,sr
T_00f9a:
	movem.l	(a7)+,d0-d1/a0
	rts
T_00fa0:
	movem.l	d0/a0-a1,-(a7)
	cmpi.w	#$8,B_5930a
	beq.w	T_01032
	movea.l	D_2e50c,a0
	cmp.b	(a0)+,d0
	beq.b	T_00fc2
	lea.l	D_2e523,a0
	bra.b	T_0102c
T_00fc2:
	tst.b	(a0)
	bne.b	T_0102c
	lea.l	D_2e52c,a1
	move.w	B_5930a,d0
	add.w	d0,d0
	add.w	d0,d0
	movea.l	(a1,d0.w),a1
	st.b	Time_lock
	movem.l	d0-d7/a0-a6,-(a7)
	jsr	T_1c0e8
	jsr	T_1c1aa
	movea.l	Screen_base,a6
	lea.l	(a1),a0
	jsr	DI_Print
	lea.l	D_2e54c,a0
	jsr	DI_Print
	jsr	Wait_4_key
	jsr	T_1c15e
	movem.l	(a7)+,d0-d7/a0-a6
	sf.b	Time_lock
	addq.w	#$1,B_5930a
	lea.l	D_2e523,a0
T_0102c:
	move.l	a0,D_2e50c
T_01032:
	movem.l	(a7)+,d0/a0-a1
	rts
T_01038:
	tst.b	D_1dc92
	beq.b	T_01044
	bra.w	Exit_all
T_01044:
	rts
T_01046:
	st.b	Time_lock
	movem.l	d0-d7/a0-a6,-(a7)
	jsr	T_1c0e8
	jsr	T_1c1aa
	movea.l	Screen_base,a6
	lea.l	D_1df4e,a0
	jsr	DI_Print
	jsr	Wait_4_key
	jsr	T_1c15e
	movem.l	(a7)+,d0-d7/a0-a6
	sf.b	Time_lock
	rts
T_01086:
	movem.l	d0-d4/a0-a1,-(a7)
	tst.b	D_1dc92
	bne.w	T_0113c
	lea.l	D_4a91c,a0
	lea.l	T_1d4de+1,a1
	moveq	#0,d1
	move.b	B_52f40,d1
	moveq	#0,d2
	moveq	#0,d3
	moveq	#7,d4
T_010ae:
	btst	d3,d0
	beq.b	T_010ba
	btst	d3,d1
	bne.b	T_010c0
	bset	d4,d2
	bra.b	T_010c0
T_010ba:
	btst	d3,d1
	beq.b	T_010c0
	bset	d4,d2
T_010c0:
	addq.w	#$1,d3
	dbra	d4,T_010ae
	move.w	d1,d0
	lsl.w	#$4,d0
	add.w	d1,d0
	addi.w	#$57,d0
	move.b	d0,B_52f40
	moveq	#15,d0
	and.b	d2,d0
	move.b	B_52f42,d3
	and.b	d3,d2
	ror.b	d0,d3
	move.b	d3,B_52f42
	moveq	#0,d1
	move.b	B_52f41,d1
	cmp.b	(a0,d1.w),d2
	bne.b	T_0111a
	move.w	d1,d0
	lsl.w	#$4,d0
	add.w	d1,d0
	addi.w	#$57,d0
	move.b	d0,B_52f41
	subq.b	#$1,B_52f43
	seq.b	$7b3(a1)
	jsr	T_1ccb6
	bra.b	T_0113c
T_0111a:
	move.b	#$dd,d0
	move.b	d0,B_52f40
	neg.b	d0
	move.b	d0,B_52f41
	move.b	#$fe,B_52f42
	move.b	#$c,B_52f43
T_0113c:
	movem.l	(a7)+,d0-d4/a0-a1
	rts
T_01142:
	tst.b	D_1dc92
	beq.b	T_01188
	st.b	Time_lock
	movem.l	d0-d7/a0-a6,-(a7)
	jsr	T_1c0e8
	jsr	T_1c1aa
	movea.l	Screen_base,a6
	lea.l	D_1dcaf,a0
	jsr	DI_Print
	jsr	Wait_4_key
	jsr	T_1c15e
	movem.l	(a7)+,d0-d7/a0-a6
	sf.b	Time_lock
T_01188:
	rts
T_0118a:
	tst.b	D_1dc92
	beq.w	T_013aa
	st.b	Time_lock
	movem.l	d0-d7/a0-a6,-(a7)
	jsr	T_1c0e8
	jsr	T_1c1aa
	movea.l	Screen_base,a6
	lea.l	D_2e867,a0
	jsr	DI_Print
	lea.l	D_2e884,a0
	jsr	DI_Print
	move.w	Map_nr,d0
	jsr	DI_Decw_print
	jsr	DI_Carriage_return
	lea.l	D_2e894,a0
	jsr	DI_Print
	move.w	Map_Xcoord,d0
	jsr	DI_Decw_print
	jsr	DI_Carriage_return
	lea.l	D_2e8a4,a0
	jsr	DI_Print
	move.w	Map_Ycoord,d0
	jsr	DI_Decw_print
	jsr	DI_Carriage_return
	jsr	DI_Carriage_return
	lea.l	D_2e8b4,a0
	jsr	DI_Print
	move.w	View_direction,d0
	jsr	DI_Decw_print
	jsr	DI_Carriage_return
	lea.l	D_2e8c6,a0
	jsr	DI_Print
	move.w	Travel_mode,d0
	jsr	DI_Decw_print
	jsr	DI_Carriage_return
	cmpi.b	#$1,Current_map_type
	bne.b	T_012a4
	jsr	DI_Carriage_return
	lea.l	D_2e8d8,a0
	jsr	DI_Print
	move.w	World_X,d0
	jsr	DI_Decw_print
	jsr	DI_Carriage_return
	lea.l	D_2e8e3,a0
	jsr	DI_Print
	move.w	World_Y,d0
	jsr	DI_Decw_print
	jsr	DI_Carriage_return
T_012a4:
	jsr	DI_Carriage_return
	lea.l	D_2e8ee,a0
	jsr	DI_Print
	move.w	Year,d0
	jsr	DI_Decw_print
	jsr	DI_Carriage_return
	lea.l	D_2e8f8,a0
	jsr	DI_Print
	move.w	Month,d0
	jsr	DI_Decw_print
	jsr	DI_Carriage_return
	lea.l	D_2e902,a0
	jsr	DI_Print
	move.w	Day,d0
	jsr	DI_Decw_print
	jsr	DI_Carriage_return
	lea.l	D_2e90c,a0
	jsr	DI_Print
	move.w	Hour,d0
	jsr	DI_Decw_print
	jsr	DI_Carriage_return
	lea.l	D_2e916,a0
	jsr	DI_Print
	move.w	Minute,d0
	jsr	DI_Decw_print
	jsr	DI_Carriage_return
	lea.l	D_2e920,a0
	jsr	DI_Print
	move.w	Frame,d0
	jsr	DI_Decw_print
	jsr	DI_Carriage_return
	jsr	DI_Carriage_return
	lea.l	D_2e92a,a0
	jsr	DI_Print
	move.w	Nr_members,d0
	jsr	DI_Decw_print
	jsr	DI_Carriage_return
	jsr	DI_Carriage_return
	lea.l	D_2e948,a0
	jsr	DI_Print
	jsr	Wait_4_key
	jsr	T_1c15e
	movem.l	(a7)+,d0-d7/a0-a6
	sf.b	Time_lock
T_013aa:
	rts
T_013ac:
	tst.b	D_1dc92
	beq.b	T_013b8
	bsr.w	T_01de2
T_013b8:
	rts
T_013ba:
	tst.b	D_1dc92
	beq.w	T_01514
	st.b	Time_lock
	movem.l	d0-d7/a0-a6,-(a7)
	jsr	T_1c0e8
	jsr	T_1c1aa
	movea.l	Screen_base,a6
	lea.l	D_2e963,a0
	jsr	DI_Print
	jsr	DI_Carriage_return
	lea.l	D_2e979,a0
	jsr	DI_Print
	move.l	Size_of_free_memory,d0
	jsr	DI_Decl_print
	jsr	DI_Carriage_return
	move.l	B_5da0c,d0
	sub.l	Size_of_free_memory,d0
	move.l	d0,d1
	lea.l	D_2e998,a0
	jsr	DI_Print
	move.l	d0,d0
	jsr	DI_Decl_print
	jsr	DI_Carriage_return
	jsr	DI_Carriage_return
	movea.l	B_5bea4,a1
	lea.l	D_2e9b7,a0
	jsr	DI_Print
	move.l	$c(a1),d0
	jsr	DI_Decl_print
	jsr	DI_Carriage_return
	lea.l	D_2e9d6,a0
	jsr	DI_Print
	move.l	$14(a1),d0
	jsr	DI_Decl_print
	jsr	DI_Carriage_return
	lea.l	D_2e9f5,a0
	jsr	DI_Print
	move.l	$1c(a1),d0
	jsr	DI_Decl_print
	jsr	DI_Carriage_return
	jsr	DI_Carriage_return
	move.l	#$100,d0
	add.l	$c(a1),d0
	add.l	$14(a1),d0
	add.l	$1c(a1),d0
	lea.l	D_2ea14,a0
	jsr	DI_Print
	move.l	d0,d0
	jsr	DI_Decl_print
	jsr	DI_Carriage_return
	jsr	DI_Carriage_return
	add.l	d1,d0
	lea.l	D_2ea33,a0
	jsr	DI_Print
	move.l	d0,d0
	jsr	DI_Decl_print
	jsr	DI_Carriage_return
	jsr	DI_Carriage_return
	lea.l	D_2ea52,a0
	jsr	DI_Print
	jsr	Wait_4_key
	jsr	T_1c15e
	movem.l	(a7)+,d0-d7/a0-a6
	sf.b	Time_lock
T_01514:
	rts
T_01516:
	tst.b	D_1dc92
	beq.w	T_015fe
	st.b	Time_lock
	movem.l	d0-d7/a0-a6,-(a7)
	jsr	T_1c0e8
	jsr	T_1c1aa
	movea.l	Screen_base,a6
	lea.l	D_2ea6d,a0
	jsr	DI_Print
	jsr	DI_Carriage_return
	move.w	Nr_of_modifications,d7
	lea.l	D_2ea89,a0
	jsr	DI_Print
	move.w	d7,d0
	jsr	DI_Decw_print
	jsr	DI_Carriage_return
	jsr	DI_Carriage_return
	movea.l	Modifications_ptr,a1
	bra.b	T_015d2
T_0157c:
	lea.l	D_2eaa4,a0
	jsr	DI_Print
	move.w	(a1)+,d0
	jsr	DI_Decw_print
	lea.l	D_2eaa7,a0
	jsr	DI_Print
	move.b	(a1)+,d0
	jsr	DI_Decb_print
	lea.l	D_2eaa9,a0
	jsr	DI_Print
	move.b	(a1)+,d0
	jsr	DI_Decb_print
	lea.l	D_2eaab,a0
	jsr	DI_Print
	move.w	(a1)+,d0
	jsr	DI_Decw_print
	jsr	DI_Carriage_return
T_015d2:
	dbra	d7,T_0157c
	jsr	DI_Carriage_return
	lea.l	D_2eaad,a0
	jsr	DI_Print
	jsr	Wait_4_key
	jsr	T_1c15e
	movem.l	(a7)+,d0-d7/a0-a6
	sf.b	Time_lock
T_015fe:
	rts
T_01600:
	tst.b	D_1dc92
	beq.w	T_016a8
	st.b	Time_lock
	movem.l	d0-d7/a0-a6,-(a7)
	jsr	T_1c0e8
	jsr	T_1c1aa
	movea.l	Screen_base,a6
	lea.l	D_2eac8,a0
	jsr	DI_Print
	jsr	DI_Carriage_return
	lea.l	B_584f8,a1
	movea.l	Module_sp,a2
	bra.b	T_0165a
T_01646:
	movea.l	$24(a1),a0
	jsr	DI_Print
	jsr	DI_Carriage_return
	lea.l	$2e(a1),a1
T_0165a:
	cmpa.l	a1,a2
	bhi.b	T_01646
	lea.l	T_016aa,a0
	jsr	DI_Print
	movea.l	$24(a1),a0
	jsr	DI_Print
	lea.l	T_016ad,a0
	jsr	DI_Print
	jsr	DI_Carriage_return
	lea.l	D_2eadf,a0
	jsr	DI_Print
	jsr	Wait_4_key
	jsr	T_1c15e
	movem.l	(a7)+,d0-d7/a0-a6
	sf.b	Time_lock
T_016a8:
	rts
T_016aa:
	dc.b	$03,$02,$00
T_016ad:
	dc.b	$20,$3c,$2d,$20,$41,$43,$54,$49,$56,$45,$2e,$03,$01,$0d,$00
T_016bc:
	tst.b	D_1dc92
	beq.b	T_0173a
	st.b	Time_lock
	movem.l	d0-d7/a0-a6,-(a7)
	jsr	T_1c0e8
	jsr	T_1c1aa
	movea.l	Screen_base,a6
	lea.l	D_2eafa,a0
	jsr	DI_Print
	jsr	DI_Carriage_return
	movea.l	Current_active_char_data,a1
	lea.l	D_2eb1a,a0
	jsr	DI_Print
	move.l	$cc(a1),d0
	jsr	DI_Decl_print
	jsr	DI_Carriage_return
T_01714:
	lea.l	D_2eb37,a0
	jsr	DI_Input
	tst.l	d0
	bmi.b	T_0172a
	beq.b	T_01714
	add.l	d0,$cc(a1)
T_0172a:
	jsr	T_1c15e
	movem.l	(a7)+,d0-d7/a0-a6
	sf.b	Time_lock
T_0173a:
	rts
T_0173c:
	tst.b	D_1dc92
	beq.b	T_0175c
	sf.b	Magic_object_flag
	jsr	Exit_display
	lea.l	Minimap_Mod,a0
	jsr	Push_Module
T_0175c:
	rts
T_0175e:
	tst.b	D_1dc92
	beq.w	T_017fa
	st.b	Time_lock
	movem.l	d0-d7/a0-a6,-(a7)
	jsr	T_1c0e8
	jsr	T_1c1aa
	movea.l	Screen_base,a6
	lea.l	D_2eb4d,a0
	jsr	DI_Print
	jsr	DI_Carriage_return
T_01796:
	lea.l	D_2eb5d,a0
	jsr	DI_Input
	tst.l	d0
	bmi.b	T_017ea
	beq.b	T_01796
	move.w	d0,New_map
	jsr	T_1c15e
	movem.l	(a7)+,d0-d7/a0-a6
	sf.b	Time_lock
	bsr.w	Exit_map
	move.w	New_map,Map_nr
	move.w	#$7,Map_Xcoord
	move.w	#$7,Map_Ycoord
	move.w	#$0,View_direction
	bsr.w	Init_map
	rts
T_017ea:
	jsr	T_1c15e
	movem.l	(a7)+,d0-d7/a0-a6
	sf.b	Time_lock
T_017fa:
	rts
T_017fc:
	tst.b	D_1dc92
	beq.w	T_019b0
	st.b	Time_lock
	movem.l	d0-d7/a0-a6,-(a7)
	jsr	T_1c0e8
	jsr	T_1c1aa
	movea.l	Screen_base,a6
	lea.l	D_2eb6e,a0
	jsr	DI_Print
	jsr	DI_Carriage_return
	lea.l	D_2eb84,a0
	jsr	DI_Input
	jsr	DI_Carriage_return
	tst.w	d0
	bmi.w	T_019a0
	move.w	#$30,d1
	moveq	#4,d7
	lea.l	D_1dc97,a3
	jsr	RConvert_number
	lea.l	D_1dca5,a3
	jsr	RConvert_number
	lea.l	D_2ebb1,a0
	jsr	DI_Print
	jsr	DI_Carriage_return
	move.l	#$7d80,d0
	jsr	Allocate_memory
	movea.l	a1,a2
	moveq	#31,d7
T_0188c:
	clr.l	(a1)+
	dbra	d7,T_0188c
	movea.l	User_HBL_list,a1
	addq.l	#$2,a1
	movem.l	(a1),d0-d7
	movem.l	d0-d7,$4(a2)
	move.l	#$4e454f21,$7c(a2)
	moveq	#0,d0
	moveq	#0,d1
	moveq	#20,d6
	move.w	#$c8,d7
	movea.l	On_screen,a0
	lea.l	$80(a2),a1
	jsr	Duplicate_block
	move.l	#$7d80,d0
	lea.l	Picture_filename,a0
	movea.l	a2,a1
	jsr	Save_file
	lea.l	D_2ebc6,a0
	jsr	DI_Print
	jsr	DI_Carriage_return
	movea.l	a2,a0
	jsr	Free_memory
	lea.l	D_2ebdf,a0
	jsr	DI_Print
	jsr	DI_Carriage_return
	move.l	#$1a90,d0
	jsr	Allocate_memory
	movea.l	a1,a2
	movea.l	a1,a0
	move.w	#$6a3,d7
T_0191a:
	clr.l	(a0)+
	dbra	d7,T_0191a
	movea.l	User_HBL_list,a0
	addq.l	#$2,a0
	move.w	#$0,(a1)+
	bra.b	T_0193c
T_0192e:
	tst.w	(a0)
	beq.b	T_01960
	moveq	#0,d0
	move.b	(a0)+,d0
	move.w	d0,(a1)+
	tst.b	(a0)+
	bne.b	T_01946
T_0193c:
	moveq	#7,d7
T_0193e:
	move.l	(a0)+,(a1)+
	dbra	d7,T_0193e
	bra.b	T_0192e
T_01946:
	movea.l	a1,a3
	moveq	#7,d7
T_0194a:
	move.l	-$22(a3),(a3)+
	dbra	d7,T_0194a
	move.w	(a0)+,d0
	add.w	d0,d0
	move.w	(a0)+,(a1,d0.w)
	lea.l	$20(a1),a1
	bra.b	T_0192e
T_01960:
	move.l	#$1a90,d0
	lea.l	Raster_filename,a0
	movea.l	a2,a1
	jsr	Save_file
	lea.l	D_2ebf8,a0
	jsr	DI_Print
	jsr	DI_Carriage_return
	movea.l	a2,a0
	jsr	Free_memory
	lea.l	D_2ec15,a0
	jsr	DI_Print
	jsr	Wait_4_key
T_019a0:
	jsr	T_1c15e
	movem.l	(a7)+,d0-d7/a0-a6
	sf.b	Time_lock
T_019b0:
	rts
T_019b2:
	tst.b	D_1dc92
	beq.b	T_019d4
	moveq	#20,d0
	bsr.w	Delay
