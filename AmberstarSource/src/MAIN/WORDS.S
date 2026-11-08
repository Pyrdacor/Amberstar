; MAIN/WORDS.ASM (original module, merged with the disassembly of the shipped program)

; ---- Hash_message (original source: MAIN/WORDS.ASM)
Hash_message:
	movem.l	d0/d2/d7/a0,-(sp)
	movea.l	PlusMes_info,a0
	addq.l	#8,a0
	bsr.w	Push_PA
	bsr.w	Erase_text_window
	move.w	Nr_of_chars,d2
	movea.l	Textfile_ptr,a1
	bsr.w	Prepare_text_block
	movea.l	Text_buffer,a0
	move.w	Nr_of_chars,d0
	addq.w	#1,d0
	move.w	Lines_in_text,d7
	subq.w	#1,d7
.Loop:
	jsr	IG_Print
	jsr	IG_Carriage_return
	adda.w	d0,a0
	dbra	d7,.Loop
	bsr.w	Pop_PA
	movea.l	Text_buffer,a0
	jsr	Free_memory
	movem.l	(sp)+,d0/d2/d7/a0
	rts	
; ---- Print_centered_string (original source: MAIN/WORDS.ASM)
Print_centered_string:
	movem.l	d0-d2/d6/d7,-(sp)
	move.l	a0,-(sp)
	moveq.l	#0,d7
.Loop:
	tst.b	(a0)+
	beq.s	.End
	cmpi.b	#32,-1(a0)
	bmi.s	.Loop
	addq.l	#1,d7
	bra.s	.Loop
.End:
	movea.l	(sp)+,a0
	move.w	d7,d6
	add.w	d7,d7
	add.w	d6,d7
	add.w	d7,d7
	sub.w	d7,d2
	bmi.s	.Skip
	asr.w	#1,d2
	add.w	d2,d0
.Skip:
	jsr	IG_Set_cursor
	jsr	IG_Print
	movem.l	(sp)+,d0-d2/d6/d7
	rts	
; ---- Plus_message (original source: MAIN/WORDS.ASM)
Plus_message:
	movem.l	a0/a1,-(sp)
	movea.l	PlusMes_info,a0
	jsr	Push_MA
	addq.l	#8,a0
	bsr.w	Push_PA
	movea.l	Textfile_ptr,a1
	bsr.w	Mr_Blue_Sky
	jsr	Pop_MA
	bsr.w	Pop_PA
	movem.l	(sp)+,a0/a1
	rts	
; ---- Minus_message (original source: MAIN/WORDS.ASM)
Minus_message:
	movem.l	d0-d2/a0/a1,-(sp)
	movea.l	Textfile_ptr,a1
	bsr.w	Convert_text_line
	lea.l	.Init_string,a0
	jsr	IG_Print
	bsr.w	Erase_message_minus
	move.w	Mesmin_X,d0
	move.w	Mesmin_Y,d1
	move.w	Mesmin_Wd,d2
	lea.l	Line_buffer,a0
	bsr.w	Print_centered_string
	movem.l	(sp)+,d0-d2/a0/a1
	rts	
.Init_string:
	dc.b	1,15,2,2,0
	even	
; ---- Erase_message_minus (original source: MAIN/WORDS.ASM)
Erase_message_minus:
	movem.l	d0-d3/d6,-(sp)
	move.w	Mesmin_X,d0
	move.w	Mesmin_Y,d1
	move.w	d0,d2
	add.w	Mesmin_Wd,d2
	subq.w	#1,d2
	move.w	d1,d3
	addi.w	#15-1,d3
	move.w	#2,d6
	jsr	Draw_box
	movem.l	(sp)+,d0-d3/d6
	rts	
T_07200:
	movem.l	d0/d7/a0-a1,-(a7)
	lea.l	D_1e54e,a0
	move.l	a0,Dictionary_ptr
	move.w	(a0)+,B_5adfe
	lea.l	B_5ae00,a1
	move.l	a0,(a1)+
	moveq	#0,d0
.l_07220:
	moveq	#31,d7
.l_07222:
	move.b	(a0),d0
	beq.b	.l_07230
	adda.w	d0,a0
	dbra	d7,.l_07222
	move.l	a0,(a1)+
	bra.b	.l_07220
.l_07230:
	movem.l	(a7)+,d0/d7/a0-a1
	rts
Find_word:
	movem.l	d0-d1,-(a7)
	cmp.w	B_5adfe,d0
	bmi.b	.l_07250
	lea.l	D_31d8e,a1
	jsr	DI_Error
	bra.b	T_07282
.l_07250:
	move.w	d0,d1
	lsr.w	#$3,d1
	andi.w	#$fffc,d1
	lea.l	B_5ae00,a0
	movea.l	(a0,d1.w),a0
	andi.w	#$1f,d0
	moveq	#0,d1
	bra.b	T_0726e
T_0726a:
	move.b	(a0),d1
	adda.w	d1,a0
T_0726e:
	dbra	d0,T_0726a
	tst.b	(a0)
	bne.b	T_07282
	lea.l	D_31db8,a1
	jsr	DI_Error
T_07282:
	movem.l	(a7)+,d0-d1
	rts
; ---- Convert_text_line (original source: MAIN/WORDS.ASM)
Convert_text_line:
	movem.l	d0-d2/d6/d7/a0-a3,-(sp)
	bsr.w	Calc_textblock_address
	lea.l	Line_buffer,a2
	move.w	(a1)+,d0
	bra.s	.Next1
.Loop1:
	bsr.w	Find_word
	moveq.l	#0,d6
	move.b	(a0)+,d6
	subq.w	#1,d6
	add.w	d6,d1
	bra.s	.Entry2
.Loop2:
	move.b	(a0)+,(a2)+
; CHANGE: removed "tst.w d6"
; CHANGE: removed "bpl.s .Entry2"
; CHANGE: removed "illegal"
.Entry2:
	dbra	d6,.Loop2
	move.w	(a1)+,d0
	lea.l	EndPuncts,a3
	moveq.l	#Nr_Endpuncts-1,d6
.Loop3:
	cmp.w	(a3)+,d0
	beq.s	.Next1
	dbra	d6,.Loop3
	move.b	#$20,(a2)+	; CHANGE: was "move.b #" ",(a2)+"
.Next1:
	dbra	d7,.Loop1
	move.b	#0,-(a2)
	movem.l	(sp)+,d0-d2/d6/d7/a0-a3
	rts	
Calc_textblock_address:
	moveq	#0,d1
	move.b	(a1),d1
	cmp.w	d1,d0
	bmi.b	.l_072e8
	lea.l	D_31de1,a1
	jsr	DI_Error
	bra.b	.l_072fe
.l_072e8:
	addq.l	#$2,a1
	add.w	d0,d0
	move.w	(a1,d0.w),d6
	move.w	$2(a1,d0.w),d7
	sub.w	d6,d7
	add.w	d6,d1
	add.w	d1,d1
	adda.w	d1,a1
	addq.l	#$2,a1
.l_072fe:
	rts
; ---- Prepare_scrolling (original source: MAIN/WORDS.ASM)
Prepare_scrolling:
	movem.l	d0-d7/a0-a3/a5/a6,-(sp)
	move.w	PA_Ink(a5),d0
	jsr	IG_Set_ink
	moveq.l	#-1,d0
	jsr	IG_Set_paper
	move.w	Nr_of_chars,d0
	mulu.w	#6,d0
	addi.w	#15,d0
	andi.w	#$fff0,d0
	lsr.w	#1,d0
	move.w	Lines_in_text,d1
	mulu.w	#7,d1
	move.w	d1,Height_of_buffer
	mulu.w	d1,d0
	jsr	Allocate_memory
	move.l	a1,Text_graphics_buffer
	move.l	#7*160,d0
	jsr	Allocate_memory
	move.l	a1,Line_graphics_buffer
	moveq.l	#0,d0
	moveq.l	#0,d1
	move.w	Nr_of_chars,d2
	movea.w	d2,a2
	addq.w	#1,a2
	mulu.w	#6,d2
	move.w	d2,d5
	addi.w	#15,d5
	andi.w	#$fff0,d5
	lsr.w	#1,d5
	move.w	d5,Width_of_buffer
	mulu.w	#7,d5
	movea.w	d5,a3
	addi.w	#15,d2
	move.w	d2,d6
	lsr.w	#4,d6
	andi.w	#$fff0,d2
	subq.w	#1,d2
	moveq.l	#7-1,d3
	move.w	PA_Paper(a5),d4
	move.w	Lines_in_text,d5
	subq.w	#1,d5
	moveq.l	#7,d7
	movea.l	Text_buffer,a0
	movea.l	Text_graphics_buffer,a1
	movea.l	Line_graphics_buffer,a6
.Loop:
	exg.l	d6,d4	; CHANGE: was ".Loop: exg.l d4,d6"
	jsr	Draw_box
	exg.l	d6,d4	; CHANGE: was "exg.l d4,d6"
	jsr	IG_Set_cursor
	jsr	IG_Print
	exg.l	a1,a0	; CHANGE: was "exg.l a0,a1"
	jsr	Get2_block
	exg.l	a1,a0	; CHANGE: was "exg.l a0,a1"
	adda.w	a2,a0
	adda.w	a3,a1
	dbra	d5,.Loop
	movea.l	Text_buffer,a0
	jsr	Free_memory
	movea.l	Line_graphics_buffer,a0
	jsr	Free_memory
	movem.l	(sp)+,d0-d7/a0-a3/a5/a6
	rts	
; ---- Refresh_text_window (original source: MAIN/WORDS.ASM)
Refresh_text_window:
	movem.l	d0-d3/d6/d7/a0,-(sp)
	movea.l	Text_graphics_buffer,a0
	tst.w	d0
	bpl.s	.Ok_1
	move.w	d0,d3
	neg.w	d3
	cmp.w	$6(a5),d3	; CHANGE: added
	bmi.b	.c_0741a	; CHANGE: added
	bsr.w	Erase_text_window	; CHANGE: added
	bra.w	.Exit	; CHANGE: added
.c_0741a:
	move.w	PA_X(a5),d0
	move.w	PA_Y(a5),d1
	move.w	d0,d2
	add.w	d1,d3
	add.w	PA_Wd(a5),d2
	subq.w	#1,d2
	subq.w	#1,d3
	move.w	PA_Paper(a5),d6
	jsr	Draw_box
	move.w	d3,d1
	addq.w	#1,d1
	move.w	PA_Y(a5),d7
	add.w	PA_Ht(a5),d7
	sub.w	d3,d7
	subq.w	#1,d7
	bra.s	.Continue
.Ok_1:
	move.w	Height_of_buffer,d1
	subq.w	#1,d1
	cmp.w	d1,d0
	bmi.s	.Ok_2
	bsr.w	Erase_text_window
	bra.s	.Exit
.Ok_2:
	move.w	Width_of_buffer,d2
	ext.l	d2
	mulu.w	d0,d2
	adda.l	d2,a0
	move.w	PA_Ht(a5),d7
	move.w	d0,d1
	add.w	d7,d1
	cmp.w	Height_of_buffer,d1
	bmi.s	.Ok_3
	move.w	Height_of_buffer,d7
	sub.w	d0,d7
	bmi.s	.Exit
	subq.w	#1,d7
	move.w	PA_X(a5),d0
	move.w	PA_Y(a5),d1
	move.w	d0,d2
	add.w	PA_Wd(a5),d2
	subq.w	#1,d2
	move.w	d1,d3
	add.w	PA_Ht(a5),d3
	subq.w	#1,d3
	add.w	d7,d1
	move.w	PA_Paper(a5),d6
	jsr	Draw_box
.Ok_3:
	move.w	PA_X(a5),d0
	move.w	PA_Y(a5),d1
.Continue:
	move.w	Width_of_buffer,d6
	lsr.w	#3,d6
	jsr	Blot_unmasked_block
.Exit:
	movem.l	(sp)+,d0-d3/d6/d7/a0
	rts	
; ---- Erase_text_window (original source: MAIN/WORDS.ASM)
Erase_text_window:
	movem.l	d0-d3/d6/a5,-(sp)
	movea.l	PA_sp,a5
	movea.l	(a5),a5
	move.w	PA_X(a5),d0
	move.w	PA_Y(a5),d1
	move.w	d0,d2
	move.w	d1,d3
	add.w	PA_Wd(a5),d2
	add.w	PA_Ht(a5),d3
	subq.w	#1,d2
	subq.w	#1,d3
	move.w	PA_Paper(a5),d6
	jsr	Draw_box
	movem.l	(sp)+,d0-d3/d6/a5
	rts	
Push_PA:
	movem.l	d0/a1,-(a7)
	movea.l	PA_sp,a1
	addq.l	#$4,a1
	cmpa.l	#Textfile_ptr,a1
	bmi.b	.l_0751a
	lea.l	D_31e1c,a1
	jsr	DI_Error
	bra.b	.l_07526
.l_0751a:
	move.l	a0,(a1)
	move.l	a1,PA_sp
	bsr.w	Init_PA
.l_07526:
	movem.l	(a7)+,d0/a1
	rts
Pop_PA:
	movem.l	a0-a1,-(a7)
	movea.l	PA_sp,a1
	cmpa.l	#PA_Stack,a1
	bpl.b	.l_0754c
	lea.l	D_31e41,a1
	jsr	DI_Error
	bra.b	.l_0755a
.l_0754c:
	subq.l	#$4,a1
	move.l	a1,PA_sp
	movea.l	(a1),a0
	bsr.w	Init_PA
.l_0755a:
	movem.l	(a7)+,a0-a1
	rts
; ---- Init_PA (original source: MAIN/WORDS.ASM)
Init_PA:
	moveq.l	#0,d0
	move.w	PA_Wd(a0),d0
	divu.w	#6,d0
	move.w	d0,Nr_of_chars
	moveq.l	#0,d0
	move.w	PA_Ht(a0),d0
	divu.w	#7,d0
	move.w	d0,Nr_of_lines
	lea.l	PArea,a1
	move.w	PA_X(a0),d0
	move.w	d0,(a1)+
	add.w	PA_Wd(a0),d0
	subq.w	#1,d0
	move.w	d0,(a1)+
	move.w	PA_Y(a0),d0
	move.w	d0,(a1)+
	add.w	PA_Ht(a0),d0
	subq.w	#1,d0
	move.w	d0,(a1)
	move.w	PA_X(a0),d0
	move.w	PA_Y(a0),d1
	jsr	IG_Set_cursor
	move.w	PA_Ink(a0),d0
	jsr	IG_Set_ink
	move.w	PA_Paper(a0),d0
	jsr	IG_Set_paper
	rts	
; ---- Prepare_text_block (original source: MAIN/WORDS.ASM)
Prepare_text_block:
	movem.l	d0-d3/d7/a0-a5,-(sp)
	bsr.w	Calc_textblock_address
	movea.l	a1,a3
	move.l	#$bb8,d0	; CHANGE: was "move.l #Max_textblock_size,d0"
	jsr	Allocate_memory
	exg.l	a3,a1	; CHANGE: was "exg.l a1,a3"
	move.l	a3,Text_buffer
	lea.l	Line_buffer,a2
	lea.l	Paragraph_list,a4
	moveq.l	#0,d1
	moveq.l	#0,d3
	moveq.l	#0,d4
	moveq.l	#1,d5
	bra.s	.Next1
.Loop1:
	move.w	(a1)+,d0
	cmpi.w	#OpenBracket,d0
	bne.s	.No_OB
	bsr.w	.Copy_word
	bra.s	.Next1
.No_OB:
	cmpi.w	#CarrReturn,d0
	bne.s	.No_CR
	bsr.w	.Carriage_return
	lea.l	Line_buffer,a2
	bra.s	.Next1
.No_CR:
	cmpi.w	#ParaMark,d0
	bne.s	.No_para
	bsr.w	.Carriage_return	; CHANGE: added
	lea.l	Line_buffer,a2	; CHANGE: added
	move.w	d4,(a4)+
	moveq.l	#0,d4
	addq.w	#1,d5
; CHANGE: removed "jsr .Carriage_return"
	bra.s	.Next1
.No_para:
	lea.l	EndPuncts,a5
	moveq.l	#Nr_Endpuncts-1,d6
.Loop2:
	cmp.w	(a5)+,d0
	beq.s	.Punct
	dbra	d6,.Loop2
	bsr.w	.Copy_word
	bsr.w	.Insert_space
	bra.s	.Next1
.Punct:
	tst.w	d1
	beq.s	.Skip
	cmpi.b	#$20,-$1(a2)	; CHANGE: was "cmpi.b #" ",-1(a2)"
	bne.s	.Skip
	subq.l	#1,a2
	subq.w	#1,d1
.Skip:
	bsr.w	.Copy_word
	bsr.w	.Insert_space
.Next1:
	dbra	d7,.Loop1
	move.b	#0,(a2)
	movea.l	a3,a0
	lea.l	Line_buffer,a2
.Loop3:
	move.b	(a2)+,(a0)+
	tst.b	-1(a2)
	bne.s	.Loop3
	tst.w	d1
	beq.s	.Empty
	addq.w	#1,d3
	addq.w	#1,d4
	lea.l	1(a3,d2.w),a3
.Empty:
	move.w	d3,Lines_in_text
	move.w	d4,(a4)+
	move.w	d5,Paras_in_text
	movea.l	Text_buffer,a0
	suba.l	a0,a3
	move.l	a3,d0
	jsr	Shrink_memory
	movem.l	(sp)+,d0-d3/d7/a0-a5
	rts	
.Copy_word:
	bsr.w	Find_word
	moveq.l	#0,d6
	move.b	(a0)+,d6
	subq.w	#1,d6
	add.w	d6,d1
	bra.s	.Entry4
.Loop4:
	move.b	(a0)+,(a2)+
.Entry4:
	dbra	d6,.Loop4
	rts	
.Insert_space:
	move.b	#$20,(a2)+	; CHANGE: was "move.b #" ",(a2)+"
	addq.w	#1,d1
	cmp.w	d2,d1
	bls.s	.Exit
	subq.l	#1,a2
.Seek:
	cmpi.b	#$20,-(a2)	; CHANGE: was ".Seek: cmpi.b #" ",-(a2)"
	bne.s	.Seek
	bsr.w	.Carriage_return
	lea.l	Line_buffer,a0
.Loop5:
	move.b	(a2)+,(a0)+
	addq.l	#1,d1
	cmpi.b	#$20,-$1(a2)	; CHANGE: was "cmpi.b #" ",-1(a2)"
	bne.s	.Loop5
	movea.l	a0,a2
.Exit:
	rts	
.Carriage_return:
	move.b	#0,(a2)
	movea.l	a3,a0
	lea.l	Line_buffer,a2
.Loop6:
	move.b	(a2)+,(a0)+
	tst.b	-1(a2)
	bne.s	.Loop6
	moveq.l	#0,d1
	addq.w	#1,d3
	addq.w	#1,d4
	lea.l	1(a3,d2.w),a3
	rts	
Mr_Blue_Sky:
	movem.l	d0-d7/a0-a6,-(a7)
	move.w	Nr_of_chars,d2
	bsr.w	Prepare_text_block
	movea.l	PA_sp,a5
	movea.l	(a5),a5
	bsr.w	Prepare_scrolling
	movea.l	Off_screen,a6
	bsr.w	Erase_text_window
	jsr	Switch_screen
	jsr	Copy_screen
	move.w	$6(a5),d0
	cmp.w	Height_of_buffer,d0
	bmi.b	.l_0776a
	moveq	#0,d0
	movea.l	Off_screen,a6
	bsr.w	Refresh_text_window
	jsr	Switch_screen
	jsr	Copy_screen
	bsr.w	Wait_4_user
	bra.w	Exit_Blue_Sky
.l_0776a:
	lea.l	Paragraph_list,a0
	move.w	$6(a5),d0
	neg.w	d0
	move.w	Nr_of_lines,d6
	move.w	Paras_in_text,d7
	subq.w	#$1,d7
.l_07784:
	move.w	(a0)+,d2
.l_07786:
	cmp.w	d6,d2
	bhi.b	.l_07796
	move.w	d2,d1
	bsr.w	Scroll_up
	bsr.w	Wait_4_user
	bra.b	.l_077a4
.l_07796:
	move.w	d6,d1
	bsr.w	Scroll_up
	bsr.w	Wait_4_user
	sub.w	d6,d2
	bra.b	.l_07786
.l_077a4:
	dbra	d7,.l_07784
	jsr	Mouse_off
	lea.l	D_1e462,a0
	move.w	Height_of_buffer,d1
	subq.w	#$1,d1
	move.w	d1,$6(a0)
	jsr	Push_MA
	move.w	Height_of_buffer,d2
	sub.w	$6(a5),d2
	move.w	Mouse_Y,d1
.l_077d6:
	movea.l	Off_screen,a6
	bsr.w	Refresh_text_window
	jsr	Switch_screen
.l_077e6:
	tst.b	Mouse_button_state
	bne.b	.l_07812
	move.w	Mouse_Y,d3
	move.w	d3,d4
	sub.w	d1,d4
	beq.b	.l_077e6
	move.w	d3,d1
	tst.w	d4
	bmi.b	.l_0780a
	add.w	d4,d0
	cmp.w	d2,d0
	bmi.b	.l_077d6
	move.w	d2,d0
	bra.b	.l_077d6
.l_0780a:
	add.w	d4,d0
	bpl.b	.l_077d6
	moveq	#0,d0
	bra.b	.l_077d6
.l_07812:
	jsr	Pop_MA
; ---- Exit_Blue_Sky (original source: MAIN/WORDS.ASM)
Exit_Blue_Sky:
	movea.l	Off_screen,a6
	bsr.w	Erase_text_window
	jsr	Switch_screen
	jsr	Copy_screen
	jsr	Mouse_on
	movea.l	Text_graphics_buffer,a0
	jsr	Free_memory
	clr.b	Mouse_click_state
	movem.l	(sp)+,d0-d7/a0-a6
	rts	
Wait_4_user:
	movem.l	a0-a1,-(a7)
	lea.l	D_29994,a0
	movea.l	Module_sp,a1
	move.l	$4(a1),$4(a0)
	move.l	$8(a1),$8(a0)
	jsr	Push_Module
.l_0786e:
	jsr	Input_handler
	tst.b	Abort_list
	beq.b	.l_0786e
.l_0787c:
	btst	#$1,Mouse_button_state
	bne.b	.l_0787c
	movem.l	(a7)+,a0-a1
	rts
; ---- Scroll_up (original source: MAIN/WORDS.ASM)
Scroll_up:
	movem.l	d1/a6,-(sp)
	mulu.w	#7,d1
	add.w	d0,d1
.Again:
	movea.l	Off_screen,a6
	bsr.w	Refresh_text_window
	jsr	Switch_screen
	addq.w	#1,d0
	cmp.w	d1,d0
	bmi.s	.Again
	jsr	Copy_screen
	movem.l	(sp)+,d1/a6
	rts	
T_078b8:
	movem.l	d0-d1/d7/a0-a2,-(a7)
	lea.l	Input_buffer,a1
	lea.l	EndPuncts,a2
	move.w	d0,d1
	moveq	#0,d7
	lea.l	.l_07944(pc),a0
	jsr	IG_Print
.l_078d6:
	jsr	Wait_4_key
	cmpi.b	#$d,d0
	beq.b	.l_07930
	swap	d0
	cmpi.b	#$e,d0
	beq.b	.l_0791e
	swap	d0
	cmp.w	d1,d7
	bpl.b	.l_078d6
	andi.w	#$ff,d0
	cmpi.w	#$20,d0
	bmi.b	.l_078d6
	move.b	(a2,d0.w),d0
	andi.w	#$ff,d0
	cmpi.w	#$ff,d0
	beq.b	.l_078d6
	lea.l	.l_07946(pc),a0
	move.b	d0,$1(a0)
	jsr	IG_Print
	move.b	d0,(a1,d7.w)
	addq.w	#$1,d7
	bra.b	.l_078d6
.l_0791e:
	tst.w	d7
	beq.b	.l_078d6
	lea.l	.l_0794a(pc),a0
	jsr	IG_Print
	subq.l	#$1,d7
	bra.b	.l_078d6
.l_07930:
	lea.l	.l_07950(pc),a0
	jsr	IG_Print
	clr.b	(a1,d7.w)
	movem.l	(a7)+,d0-d1/d7/a0-a2
	rts
.l_07944:
	dc.b	$5f,$00
.l_07946:
	dc.b	$0e,$20,$5f,$00
.l_0794a:
	dc.b	$0e,$0e,$5f,$20,$0e,$00
.l_07950:
	dc.b	$0e,$20,$00,$00
; ---- Init_RText (original source: MAIN/WORDS.ASM)
Init_RText:
	movem.l	d0/a1,-(sp)
	move.w	#0,RText_X
	move.w	#0,RText_Y
	move.w	#0,Lines_in_text
	move.l	#$1f4,d0	; CHANGE: was "move.l #Max_textblock_size,d0"
	jsr	Allocate_memory
	move.l	a1,RText_ptr
	clr.b	(a1)
	movem.l	(sp)+,d0/a1
	rts	
; ---- Exit_RText (original source: MAIN/WORDS.ASM)
Exit_RText:
	move.l	a0,-(sp)
	movea.l	RText_ptr,a0
	jsr	Free_memory
	movea.l	(sp)+,a0
	rts	
; ---- Add_ASCII_2_RText (original source: MAIN/WORDS.ASM)
Add_ASCII_2_RText:
	movem.l	d0-d3/a0-a3,-(sp)
	move.w	Nr_of_chars,d1
	move.w	RText_X,d2
	move.w	RText_Y,d3
	movea.l	RText_ptr,a1
	move.w	d3,d0
	mulu.w	d1,d0
	adda.w	d0,a1
	adda.w	d3,a1
	move.l	a1,-(sp)
	lea.l	Line_buffer,a2
	move.w	d2,d0
	bra.s	.Entry
.Loop:
	move.b	(a1)+,(a2)+
.Entry:
	dbra	d0,.Loop
	movea.l	(sp)+,a1
.Again:
	move.b	(a0)+,d0
	beq.s	.End
	cmpi.b	#13,d0
	bne.s	.No_CR
	bsr.w	.Carriage_return
	lea.l	Line_buffer,a2
	bra.s	.Again
.No_CR:
	move.b	d0,(a2)+
	addq.w	#1,d2
	cmp.w	d1,d2
	bls.s	.Again
	clr.b	(a2)
	subq.l	#1,a2
.Seek:
	cmpi.b	#" ",-(a2)
	bne.s	.Seek
	bsr.w	.Carriage_return
	lea.l	1(a2),a3
	lea.l	Line_buffer,a2
.Loop1:
	tst.b	(a3)
	beq.s	.Again
	move.b	(a3)+,(a2)+
	addq.w	#1,d2
	bra.s	.Loop1
.End:
	move.w	d2,RText_X
	move.w	d3,RText_Y
	tst.w	d2
	beq.s	.Skip
	lea.l	Line_buffer,a0
	move.w	d2,d0
	subq.w	#1,d0
.Loop2:
	move.b	(a0)+,(a1)+
	dbra	d0,.Loop2
	addq.w	#1,d3
.Skip:
	clr.b	(a1)
	move.w	d3,Lines_in_text
	movem.l	(sp)+,d0-d3/a0-a3
	rts	
.Carriage_return:
	move.l	a2,-(sp)
	move.b	#0,(a2)
	lea.l	Line_buffer,a2
	movea.l	a1,a3
.Loop3:
	move.b	(a2)+,(a3)+
	tst.b	-1(a2)
	bne.s	.Loop3
	moveq.l	#0,d2
	addq.w	#1,d3
	lea.l	1(a1,d1.w),a1
	movea.l	(sp)+,a2
	rts	
; ---- Add_encoded_2_RText (original source: MAIN/WORDS.ASM)
Add_encoded_2_RText:
	movem.l	d0/d1/d6/d7/a0-a3,-(sp)
	bsr.w	Calc_textblock_address
	movea.l	a1,a2
	move.l	#$bb8,d0	; CHANGE: was "move.l #Max_textblock_size,d0"
	jsr	Allocate_memory
	exg.l	a2,a1	; CHANGE: was "exg.l a1,a2"
	move.l	a2,Text_buffer
	bra.s	.Next1
.Loop1:
	move.w	(a1)+,d0
	cmpi.w	#OpenBracket,d0
	bne.s	.No_OB
	bsr.w	.Copy_word
	bra.s	.Next1
.No_OB:
	cmpi.w	#CarrReturn,d0
	bne.s	.No_CR
	move.b	#13,(a2)+
	bra.s	.Next1
.No_CR:
	lea.l	EndPuncts,a3
	moveq.l	#Nr_Endpuncts-1,d6
.Loop2:
	cmp.w	(a3)+,d0
	beq.s	.Punct
	dbra	d6,.Loop2
	bra.s	.Skip
.Punct:
	cmpi.b	#$20,-$1(a2)	; CHANGE: was ".Punct: cmpi.b #" ",-1(a2)"
	bne.s	.Skip
	subq.l	#1,a2
.Skip:
	bsr.w	.Copy_word
	move.b	#$20,(a2)+	; CHANGE: was "move.b #" ",(a2)+"
.Next1:
	dbra	d7,.Loop1
	clr.b	(a2)
	movea.l	Text_buffer,a0
	bsr.w	Add_ASCII_2_RText
	jsr	Free_memory
	movem.l	(sp)+,d0/d1/d6/d7/a0-a3
	rts	
.Copy_word:
	bsr.w	Find_word
	moveq.l	#0,d6
	move.b	(a0)+,d6
	subq.w	#1,d6
	bra.s	.Entry3
.Loop3:
	move.b	(a0)+,(a2)+
.Entry3:
	dbra	d6,.Loop3
	rts	
