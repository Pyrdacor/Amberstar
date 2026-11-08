; MAIN/WSELW.ASM (original module, merged with the disassembly of the shipped program)

	section	text


; ---- WSelW_ModInit (original source: MAIN/WSELW.ASM) - the shipped program differs, its code follows, not assembled:
;WSelW_ModInit:
;             movem.l   d0-d7/a0-a6,-(sp)
;             sf        No_word_entered
;; ------------- Make list of known words -----------------------------
;             move.l    #5000*2,d0           ; Make word buffer
;             jsr       Allocate_memory
;             move.l    a1,Word_list_ptr
;             lea.l     WD,a0                ; Initialize registers
;             moveq.l   #0,d0
;             moveq.l   #1,d1
;             moveq.l   #1,d2
;             moveq.l   #0,d3
;             move.w    #5000-1,d7
;.Loop:       btst      d1,0(a0,d0.w)        ; Word known ?
;             beq.s     .Zero
;             move.w    d2,(a1)+             ; Store word number
;             addq.w    #1,d3
;.Zero:       addq.w    #1,d1                ; Next bit
;             cmpi.w    #8,d1
;             bmi.s     .Ok
;             moveq.l   #0,d1
;             addq.w    #1,d0
;.Ok:         addq.w    #1,d2
;             dbra      d7,.Loop
;             tst.w     d3                   ; Know any words ?
;             beq       No_words_known
;             moveq.l   #0,d0                ; Return unused memory
;             move.w    d3,d0
;             add.l     d0,d0
;             movea.l   Word_list_ptr,a0
;             jsr       Shrink_memory
;             move.w    d3,Nr_of_known_words ; Store results
;             .LOCAL
;; ------------- Convert list to text ---------------------------------
;             move.w    #21,d0               ; Make text buffer
;             mulu.w    d3,d0
;             jsr       Allocate_memory
;             move.l    a1,Text_buffer
;             movea.l   Word_list_ptr,a2
;             subq.w    #1,d3
;.Loop1:      movea.l   a1,a3
;             move.w    (a2)+,d0             ; Get pointer to word
;             jsr       Find_word
;             moveq.l   #0,d0                ; Get length of word
;             move.b    (a0)+,d0
;             subq.w    #1,d0                ; !!! REMOVE LATER !!!
;             bra.s     .Entry2
;.Loop2:      move.b    (a0)+,(a3)+          ; Copy word
;.Entry2:     dbra      d0,.Loop2
;             clr.b     (a3)                 ; Insert EOL
;             lea.l     21(a1),a1            ; Next word
;             dbra      d3,.Loop1
;             movea.l   Word_list_ptr,a0     ; Free memory
;             jsr       Free_memory
;             cmpi.w    #1,Nr_of_known_words ; Only one word ?
;             beq.s     .No_sort
;             jsr       Sort_word_list       ; Sort words
;.No_sort:    .LOCAL
;; ------------- Make graphics buffer ---------------------------------
;             moveq.l   #15,d0               ; Set ink & paper
;             jsr       IG_Set_ink
;             moveq.l   #-1,d0
;             jsr       IG_Set_paper
;             move.w    #448,d0              ; Make graphics buffer
;             mulu.w    Nr_of_known_words,d0
;             jsr       Allocate_memory
;             move.l    a1,Text_graphics_buffer
;             move.l    #7*160,d0            ; Make line graphics buffer
;             jsr       Allocate_memory
;             movea.l   a1,a6
;             moveq.l   #0,d0                ; Initialize registers
;             moveq.l   #0,d1
;             move.w    #128-1,d2
;             moveq.l   #7-1,d3
;             moveq.l   #3,d4
;             move.w    Nr_of_known_words,d5
;             subq.w    #1,d5
;             moveq.l   #8,d6
;             moveq.l   #7,d7
;             movea.l   Text_buffer,a0
;             movea.l   Text_graphics_buffer,a1
;             lea.l     3,a2
;.Loop:       exg.l     d4,d6                ; Clear line graphics buffer
;             jsr       Draw_box
;             exg.l     d4,d6
;             exg.l     d0,a2                ; Set cursor at (3,0)
;             jsr       IG_Set_cursor
;             exg.l     d0,a2
;             jsr       IG_Print             ; Print text on fake screen
;             exg.l     a0,a1                ; Copy line to graphics buffer
;             jsr       Get2_block
;             exg.l     a0,a1
;             lea.l     21(a0),a0            ; Next line
;             lea.l     448(a1),a1
;             dbra      d5,.Loop
;             .LOCAL
;; ------------- Do stuff ---------------------------------------------
;             move.w    Nr_of_known_words,d0 ; Store height of buffer
;             mulu.w    #7,d0
;             move.w    d0,Height_of_buffer
;             move.w    #64,Width_of_buffer  ; Store width of buffer
;             movea.l   a6,a0                ; Free memory
;             jsr       Free_memory
;             Push      PA,WSelW_PA
;             move.w    #First_add,Adding    ; Reset
;; ------------- Open a window ----------------------------------------
;             moveq.l   #32,d0
;             moveq.l   #40,d1
;             moveq.l   #10,d2
;             moveq.l   #10,d3
;             moveq.l   #2,d4
;             moveq.l   #1,d6
;             lea.l     WSelW_L1,a0
;             jsr       Open_window
;             move.w    d0,WSelW_handle
;; ------------- Fill window ------------------------------------------
;             movea.l   Off_screen,a6
;             moveq.l   #32+16,d0            ; Clear word area
;             moveq.l   #40+16,d1
;             move.w    d0,d2
;             addi.w    #127,d2
;             move.w    d1,d3
;             addi.w    #111,d3
;             moveq.l   #3,d6
;             jsr       Draw_box
;             moveq.l   #2,d6                ; Display icons
;             moveq.l   #16,d7
;             move.w    #32+16,d0            ; Input word
;             move.w    #40+16+112,d1
;             lea.l     Control_icn+4352,a0
;             jsr       Blot_unmasked_block
;             addi.w    #32,d0               ; Up
;             lea.l     Control_icn+256,a0
;             jsr       Blot_unmasked_block
;             addi.w    #32,d0               ; Down
;             lea.l     Control_icn+512,a0
;             jsr       Blot_unmasked_block
;             addi.w    #32,d0               ; Exit
;             lea.l     Control_icn+7680,a0
;             jsr       Blot_unmasked_block
;             Update_screen

WSelW_ModInit:
	movem.l	d0-d7/a0-a6,-(a7)
	sf.b	No_word_entered
	move.l	#$3e8,d0
	jsr	Allocate_memory
	move.l	a1,Word_list_ptr
	lea.l	WD,a0
	moveq	#0,d0
	moveq	#1,d1
	moveq	#1,d2
	moveq	#0,d3
	move.w	#$1387,d7
.l_0a652:
	btst	d1,(a0,d0.w)
	beq.b	.l_0a65c
	move.w	d2,(a1)+
	addq.w	#$1,d3
.l_0a65c:
	addq.w	#$1,d1
	cmpi.w	#$8,d1
	bmi.b	.l_0a668
	moveq	#0,d1
	addq.w	#$1,d0
.l_0a668:
	addq.w	#$1,d2
	dbra	d7,.l_0a652
	tst.w	d3
	beq.w	No_words_known
	moveq	#0,d0
	move.w	d3,d0
	add.l	d0,d0
	movea.l	Word_list_ptr,a0
	jsr	Shrink_memory
	move.w	d3,Nr_of_known_words
	move.w	#$15,d0
	mulu.w	d3,d0
	jsr	Allocate_memory
	move.l	a1,Text_buffer
	movea.l	Word_list_ptr,a2
	subq.w	#$1,d3
T_0a6a6:
	movea.l	a1,a3
	move.w	(a2)+,d0
	bsr.w	Find_word
	moveq	#0,d0
	move.b	(a0)+,d0
	subq.w	#$1,d0
	bra.b	T_0a6b8
T_0a6b6:
	move.b	(a0)+,(a3)+
T_0a6b8:
	dbra	d0,T_0a6b6
	clr.b	(a3)
	lea.l	$15(a1),a1
	dbra	d3,T_0a6a6
	movea.l	Word_list_ptr,a0
	jsr	Free_memory
	cmpi.w	#$1,Nr_of_known_words
	beq.b	.l_0a6e0
	bsr.w	Sort_word_list
.l_0a6e0:
	moveq	#15,d0
	jsr	IG_Set_ink
	moveq	#-1,d0
	jsr	IG_Set_paper
	move.w	#$1c0,d0
	mulu.w	Nr_of_known_words,d0
	jsr	Allocate_memory
	move.l	a1,Text_graphics_buffer
	move.l	#$460,d0
	jsr	Allocate_memory
	movea.l	a1,a6
	moveq	#0,d0
	moveq	#0,d1
	move.w	#$7f,d2
	moveq	#6,d3
	moveq	#3,d4
	move.w	Nr_of_known_words,d5
	subq.w	#$1,d5
	moveq	#8,d6
	moveq	#7,d7
	movea.l	Text_buffer,a0
	movea.l	Text_graphics_buffer,a1
	lea.l	$3.w,a2
.l_0a73c:
	exg.l	d6,d4
	jsr	Draw_box
	exg.l	d6,d4
	exg.l	d0,a2
	jsr	IG_Set_cursor
	exg.l	d0,a2
	jsr	IG_Print
	exg.l	a1,a0
	jsr	Get2_block
	exg.l	a1,a0
	lea.l	$15(a0),a0
	lea.l	$1c0(a1),a1
	dbra	d5,.l_0a73c
	move.w	Nr_of_known_words,d0
	mulu.w	#$7,d0
	move.w	d0,Height_of_buffer
	move.w	#$40,Width_of_buffer
	movea.l	a6,a0
	jsr	Free_memory
	lea.l	D_26102,a0
	bsr.w	Push_PA
	move.w	#$60,Adding
	moveq	#32,d0
	moveq	#40,d1
	moveq	#10,d2
	moveq	#10,d3
	moveq	#2,d4
	moveq	#1,d6
	lea.l	D_2f388,a0
	jsr	Open_window
	move.w	d0,WSelW_handle
	movea.l	Off_screen,a6
	moveq	#48,d0
	moveq	#56,d1
	move.w	d0,d2
	addi.w	#$7f,d2
	move.w	d1,d3
	addi.w	#$6f,d3
	moveq	#3,d6
	jsr	Draw_box
	moveq	#2,d6
	moveq	#16,d7
	move.w	#$30,d0
	move.w	#$a8,d1
	lea.l	D_39060,a0
	jsr	Blot_unmasked_block
	addi.w	#$20,d0
	lea.l	D_38060,a0
	jsr	Blot_unmasked_block
	addi.w	#$20,d0
	lea.l	D_38160,a0
	jsr	Blot_unmasked_block
	addi.w	#$20,d0
	lea.l	D_39d60,a0
	jsr	Blot_unmasked_block
	jsr	Switch_screen
	jsr	Copy_screen
; ---- No_words_known (original source: MAIN/WSELW.ASM)
No_words_known:
	movem.l	(sp)+,d0-d7/a0-a6
	rts	
; ---- WSelW_DisUpd (original source: MAIN/WSELW.ASM)
WSelW_DisUpd:
	move.w	Word_list_pos,d0
	mulu.w	#7,d0
	movea.l	PA_sp,a5
	movea.l	(a5),a5
	movea.l	Off_screen,a6
	bsr.w	Refresh_text_window
	rts	
; ---- WSelW_ModExit (original source: MAIN/WSELW.ASM)
WSelW_ModExit:
	bsr.w	Pop_PA
	movea.l	Text_buffer,a0
	jsr	Free_memory
	movea.l	Text_graphics_buffer,a0
	jsr	Free_memory
	move.w	WSelW_handle,d0
	jsr	Close_window
	rts	
; ---- WordSelected (original source: MAIN/WSELW.ASM)
WordSelected:
	lsr.w	#8,d0
	subq.w	#1,d0
	add.w	Word_list_pos,d0
	cmp.w	Nr_of_known_words,d0
	bpl.s	.Exit
	movea.l	Text_buffer,a0
	mulu.w	#21,d0
	adda.w	d0,a0
	bsr.w	Search_word
	move.w	d0,Found_word
	bsr.w	Pop_Module
.Exit:
	rts	
; ---- InputWord (original source: MAIN/WSELW.ASM)
InputWord:
	lea.l	WordIn_Mod,a0
	bsr.w	Push_Module
	lea.l	Input_buffer,a0
	bsr.w	Search_word
	move.w	d0,Found_word
	bra.w	Pop_Module
; ---- ExitWordSelect (original source: MAIN/WSELW.ASM)
ExitWordSelect:
	st	No_word_entered
	bsr.w	Pop_Module
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	rts	
; ---- WordSel_1Up (original source: MAIN/WSELW.ASM)
WordSel_1Up:
	moveq.l	#1,d0
	bra.w	WordSel_UP
; ---- WordSel_1Down (original source: MAIN/WSELW.ASM)
WordSel_1Down:
	moveq.l	#1,d0
	bra.w	WordSel_DOWN
; ---- WordSel_8Up (original source: MAIN/WSELW.ASM)
WordSel_8Up:
	moveq.l	#8,d0
	bra.w	WordSel_UP
; ---- WordSel_8Down (original source: MAIN/WSELW.ASM)
SpSel_8Down:
WordSel_8Down:
	moveq.l	#8,d0
	bra.w	WordSel_DOWN
; ---- WordSel_X1Up (original source: MAIN/WSELW.ASM)
SpSel_X1Up:
WordSel_X1Up:
	move.w	Adding,d0
	lsr.w	#8,d0
	bsr.w	WordSel_UP
	bra.w	Inc_adding
; ---- WordSel_X1Down (original source: MAIN/WSELW.ASM)
SpSel_X1Down:
WordSel_X1Down:
	move.w	Adding,d0
	lsr.w	#8,d0
	bsr.w	WordSel_DOWN
	bra.w	Inc_adding
; ---- WordSel_X8Up (original source: MAIN/WSELW.ASM)
SpSel_X8Up:
WordSel_X8Up:
	move.w	Adding,d0
	lsr.w	#5,d0
	andi.w	#$fff8,d0
	bsr.w	WordSel_UP
	bra.w	Inc_adding
; ---- WordSel_X8Down (original source: MAIN/WSELW.ASM)
SpSel_X8Down:
WordSel_X8Down:
	move.w	Adding,d0
	lsr.w	#5,d0
	andi.w	#$fff8,d0
	bsr.w	WordSel_DOWN
	bra.w	Inc_adding
; ---- WordSel_UP (original source: MAIN/WSELW.ASM)
SpSel_UP:
WordSel_UP:
	move.w	Word_list_pos,d1
	sub.w	d0,d1
	bpl.s	.Skip
	moveq.l	#0,d1
	move.w	#First_add,Adding
.Skip:
	move.w	d1,Word_list_pos
	rts	
; ---- WordSel_DOWN (original source: MAIN/WSELW.ASM)
SpSel_DOWN:
WordSel_DOWN:
	move.w	Word_list_pos,d1
	add.w	d0,d1	; CHANGE: added
	moveq	#16,d2	; CHANGE: added
	add.w	d1,d2	; CHANGE: was "add.w d0,d1"
	cmp.w	Nr_of_known_words,d2	; CHANGE: was "cmp.w Nr_of_known_words,d1"
	bmi.s	.Skip
	move.w	Nr_of_known_words,d1
	subi.w	#$10,d1	; CHANGE: was "subq.w #1,d1"
	move.w	#First_add,Adding
.Skip:
	move.w	d1,Word_list_pos
	rts	
; ---- Sort_word_list (original source: MAIN/WSELW.ASM)
Sort_word_list:
	movem.l	d0-d3/d5/d6/a0,-(sp)
	movea.l	Text_buffer,a0
	lea.l	-21(a0),a0
	move.w	Nr_of_known_words,d1
	lsr.w	#1,d1
	mulu.w	#21,d1
	move.w	Nr_of_known_words,d0
	mulu.w	#21,d0
	sub.w	d1,d0
.Loop1:
	moveq.l	#0,d2
.Loop2:
	move.w	d2,d3
	addi.w	#21,d3
.Loop3:
	move.w	d3,d5
	add.w	d1,d5
	move.w	d3,d6
	bsr.w	Compare_words
	bgt.s	.Next3
	bsr.w	Swap_words
.Next3:
	add.w	d1,d3
	cmp.w	d0,d3
	ble.s	.Loop3
	addi.w	#21,d2
	cmp.w	d1,d2
	bmi.s	.Loop2
	addi.w	#21,d0
	subi.w	#21,d1
	bne.s	.Loop1
	movem.l	(sp)+,d0-d3/d5/d6/a0
	rts	
; ---- Compare_words (original source: MAIN/WSELW.ASM)
Compare_words:
	movem.l	d0/d7/a0/a1,-(sp)
	lea.l	0(a0,d6.w),a1
	lea.l	0(a0,d5.w),a0
	moveq.l	#0,d7
.Loop:
	move.b	0(a0,d7.w),d0
	cmp.b	0(a1,d7.w),d0
	bne.s	.Exit
	addq.w	#1,d7
	cmpi.w	#20,d7
	bmi.s	.Loop
	cmp.w	d0,d0
.Exit:
	movem.l	(sp)+,d0/d7/a0/a1
	rts	
; ---- Swap_words (original source: MAIN/WSELW.ASM)
Swap_words:
	movem.l	d0/d7/a0/a1,-(sp)
	lea.l	0(a0,d6.w),a1
	lea.l	0(a0,d5.w),a0
	moveq.l	#20-1,d7
.Loop:
	move.b	(a0),d0
	move.b	(a1),(a0)+
	move.b	d0,(a1)+
	dbra	d7,.Loop
	movem.l	(sp)+,d0/d7/a0/a1
	rts	
; ---- Search_word (original source: MAIN/WSELW.ASM)
Search_word:
	movem.l	d4-d7/a1-a3,-(sp)
	movea.l	a0,a1
	moveq.l	#-1,d4
.Again:
	addq.w	#1,d4
	tst.b	(a1)+
	bne.s	.Again
	movea.l	Dictionary_ptr,a1
	moveq.l	#0,d0
	move.w	(a1)+,d7
	subq.w	#1,d7
.Loop1:
	moveq.l	#0,d6
	move.b	(a1)+,d6
	subq.w	#1,d6
	move.w	d6,d5
	movea.l	a0,a2
	movea.l	a1,a3
	bra.s	.Entry2
.Loop2:
	cmpm.b	(a2)+,(a3)+
	bne.s	.Next1
.Entry2:
	dbra	d6,.Loop2
	cmp.w	d4,d5
	beq.s	.Found
.Next1:
	addq.w	#1,d0
	adda.w	d5,a1
	dbra	d7,.Loop1
	moveq.l	#0,d0
.Found:
	movem.l	(sp)+,d4-d7/a1-a3
	rts	

	section	bss

No_word_entered:
	ds.b	2
Found_word:
	ds.b	2
WSelW_handle:
	ds.b	2
Word_list_ptr:
	ds.b	4
Nr_of_known_words:
	ds.b	2
Word_list_pos:
	ds.b	2
