; NUCLEUS/MEMORY.ASM (original module, merged with the disassembly of the shipped program)

	section	text


; ---- Init_memory (original source: NUCLEUS/MEMORY.ASM) - the shipped program differs, its code follows, not assembled:
;Init_memory:
;             movem.l   d0/d1/a0,-(sp)
;             move.l    P_bbase(a0),d0       ; Calculate start of TPA
;             add.l     P_blen(a0),d0
;             move.l    d0,Start_of_free_memory
;             move.l    P_hitpa(a0),d1       ; Calculate size of memory
;             sub.l     d0,d1
;             cmpi.l    #Minimum_mem,d1      ; Is it enough ?
;             bpl.s     .Enough
;             ERROR     "[ Init_memory ] : Not enough memory !!!"
;             bra.s     .Exit
;.Enough:     move.l    d1,Size_of_free_memory
;             lea.l     Memory_list,a0       ; Initialize the memory list
;             move.l    d0,(a0)+
;             move.l    d1,(a0)+
;             move.w    #$8000,(a0)
;             addq.l    #4,a0
;             move.l    a0,Memlist_end
;.Exit:       movem.l   (sp)+,d0/d1/a0
;             rts

; The ERROR is replaced by a diagnostic screen and a reset.
Init_memory:
	movem.l	d0-d1/a0,-(a7)
	move.l	$18(a0),d0
	add.l	$1c(a0),d0
	move.l	d0,Start_of_free_memory
	move.l	$4(a0),d1
	sub.l	d0,d1
	cmpi.l	#$4b000,d1
	bpl.b	.l_1d212
	movem.l	d0-d7/a0-a6,-(a7)
	jsr	ON_Diag_screen
	jsr	DI_Cursor_home
	movea.l	Screen_base,a6
	lea.l	D_55504,a0
	jsr	DI_Print
	lea.l	D_55535,a0
	jsr	DI_Print
	lea.l	D_55566,a0
	jsr	DI_Print
	lea.l	D_55579,a0
	jsr	DI_Print
	jsr	Wait_4_key
	jsr	OFF_Diag_screen
	movem.l	(a7)+,d0-d7/a0-a6
	movea.l	$4f2.w,a0
	movea.l	$4(a0),a0
	jmp	(a0)
.l_1d212:
	move.l	d1,Size_of_free_memory
	move.l	d1,B_60a3e
	lea.l	Memory_list,a0
	move.l	d0,(a0)+
	move.l	d1,(a0)+
	move.l	#$80000000,(a0)+
	move.l	a0,Memlist_end
	movem.l	(a7)+,d0-d1/a0
	rts
; ---- Next_generation (original source: NUCLEUS/MEMORY.ASM)
Next_generation:
	movem.l	d0/d1/a0/a1,-(sp)
	lea.l	Memory_list,a0
	movea.l	Memlist_end,a1
	moveq.l	#$3f,d0
	bra.s	.Entry
.Loop:
	btst.b	#7,8(a0)
	beq.s	.Next
	move.b	d0,d1
	and.b	8(a0),d1
	beq.s	.Next
	moveq.l	#0,d1
	move.b	9(a0),d1
	subq.w	#8,d1
	bmi.s	.Next
	move.b	d1,9(a0)
.Next:
	lea.l	12(a0),a0
.Entry:
	cmpa.l	a1,a0
	bmi.s	.Loop
.Overflow:
	movem.l	(sp)+,d0/d1/a0/a1
	rts	
T_1d27a:
	move.l	a0,-(a7)
	lea.l	Memory_list,a0
	move.l	Start_of_free_memory,(a0)+
	move.l	B_60a3e,(a0)+
	move.l	#$80000000,(a0)+
	move.l	a0,Memlist_end
	move.l	B_60a3e,Size_of_free_memory
	movea.l	(a7)+,a0
	rts

; ---- Kill_memory (original source: NUCLEUS/MEMORY.ASM) - the shipped program differs, its code follows, not assembled:
;Kill_memory:
;             movem.l   d0/a1/a2,-(sp)
;             lea.l     Memory_list,a1       ; Ptr = Start
;             movea.l   Memlist_end,a2
;             bra.s     .Entry
;.Loop:       btst      #7,8(a1)             ; Allocated ?
;             bne.s     .Next
;             cmpa.l    (a1),a0              ; Found ?
;             bne.s     .Next
;             move.l    #$80000000,8(a1)     ; De-allocated memory block
;             move.l    4(a1),d0             ; Update
;             add.l     d0,Size_of_free_memory
;             bra.s     .Exit
;.Next:       lea.l     12(a1),a1            ; Increase Ptr
;.Entry:      cmpa.l    a2,a1                ; While Ptr < End
;             bmi.s     .Loop
;             ERROR     "[ Kill_memory ] : Memory wasn't allocated !!!"
;.Exit:       movem.l   (sp)+,d0/a1/a2
;             rts

Kill_memory:
	movem.l	d0/a1-a2,-(a7)
	lea.l	Memory_list,a1
	movea.l	Memlist_end,a2
	bra.b	T_1d2de
T_1d2ba:
	btst	#$7,$8(a1)
	bne.b	.l_1d2da
	cmpa.l	(a1),a0
	bne.b	.l_1d2da
	move.l	#$80000000,$8(a1)
	move.l	$4(a1),d0
	add.l	d0,Size_of_free_memory
	bra.b	T_1d2ee
.l_1d2da:
	lea.l	$c(a1),a1
T_1d2de:
	cmpa.l	a2,a1
	bmi.b	T_1d2ba
	lea.l	D_55592,a1
	jsr	DI_Error
T_1d2ee:
	movem.l	(a7)+,d0/a1-a2
	rts

; ---- Free_memory (original source: NUCLEUS/MEMORY.ASM) - the shipped program differs, its code follows, not assembled:
;Free_memory:
;             movem.l   d0/a1/a2,-(sp)
;             lea.l     Memory_list,a1       ; Ptr = Start
;             movea.l   Memlist_end,a2
;             bra.s     .Entry
;.Loop:       btst      #7,8(a1)             ; Allocated ?
;             bne.s     .Next
;             cmpa.l    (a1),a0              ; Found ?
;             bne.s     .Next
;             bset      #7,8(a1)             ; De-allocate
;             move.l    4(a1),d0             ; Update
;             add.l     d0,Size_of_free_memory
;             bra.s     .Exit
;.Next:       lea.l     12(a1),a1            ; Increase Ptr
;.Entry:      cmpa.l    a2,a1                ; While Ptr < End
;             bmi.s     .Loop
;             ERROR     "[ Free_memory ] : Memory wasn't allocated !!!"
;.Exit:       movem.l   (sp)+,d0/a1/a2
;             rts

Free_memory:
	movem.l	d0/a1-a2,-(a7)
	lea.l	Memory_list,a1
	movea.l	Memlist_end,a2
	bra.b	T_1d328
T_1d306:
	btst	#$7,$8(a1)
	bne.b	.l_1d324
	cmpa.l	(a1),a0
	bne.b	.l_1d324
	bset	#$7,$8(a1)
	move.l	$4(a1),d0
	add.l	d0,Size_of_free_memory
	bra.b	T_1d338
.l_1d324:
	lea.l	$c(a1),a1
T_1d328:
	cmpa.l	a2,a1
	bmi.b	T_1d306
	lea.l	D_555c1,a1
	jsr	DI_Error
T_1d338:
	movem.l	(a7)+,d0/a1-a2
	rts

; ---- Shrink_memory (original source: NUCLEUS/MEMORY.ASM) - the shipped program differs, its code follows, not assembled:
;Shrink_memory:
;             movem.l   d0/a1/a2,-(sp)
;             addq.l    #1,d0                ; Force word boundary
;             andi.b    #$fe,d0
;             lea.l     Memory_list,a1       ; Ptr = Start
;             movea.l   Memlist_end,a2
;             bra.s     .Entry
;.Loop:       btst      #7,8(a1)             ; Allocated ?
;             bne.s     .Next
;             cmpa.l    (a1),a0              ; Found ?
;             bne.s     .Next
;             move.l    d0,d1                ; Split memory block
;             lea.l     (a1),a0
;             jsr       Split_memory_block
;             move.l    d0,4(a0)             ; Set size of first block
;             move.l    12+4(a0),d0          ; Update
;             add.l     d0,Size_of_free_memory
;             bra.s     .Exit
;.Next:       lea.l     12(a1),a1            ; Increase Ptr
;.Entry:      cmpa.l    a2,a1                ; While Ptr < End
;             bmi.s     .Loop
;             ERROR     "[ Shrink_memory ] : Memory wasn't allocated !!!"
;.Exit:       movem.l   (sp)+,d0/a1/a2
;             rts

Shrink_memory:
	movem.l	d0-d1/a0-a2,-(a7)
	addq.l	#$1,d0
	andi.b	#$fe,d0
	lea.l	Memory_list,a1
	movea.l	Memlist_end,a2
	bra.b	T_1d390
T_1d356:
	btst	#$7,$8(a1)
	bne.b	.l_1d38c
	cmpa.l	(a1),a0
	bne.b	.l_1d38c
	cmp.l	$4(a1),d0
	beq.b	T_1d3a0
	bmi.b	.l_1d378
	lea.l	D_555f0,a1
	jsr	DI_Error
	bra.b	T_1d3a0
.l_1d378:
	move.l	d0,d1
	movea.l	a1,a0
	bsr.w	T_1d532
	move.l	$10(a0),d0
	add.l	d0,Size_of_free_memory
	bra.b	T_1d3a0
.l_1d38c:
	lea.l	$c(a1),a1
T_1d390:
	cmpa.l	a2,a1
	bmi.b	T_1d356
	lea.l	D_55619,a1
	jsr	DI_Error
T_1d3a0:
	movem.l	(a7)+,d0-d1/a0-a2
	rts
; ---- Reallocate_memory (original source: NUCLEUS/MEMORY.ASM)
Reallocate_memory:
	movem.l	d0-d2/a1,-(sp)
	lsl.w	#8,d0
	swap.w	d0
	move.w	d1,d0
	ori.l	#$80000000,d0	; CHANGE: added
	move.l	#$bf00ffff,d1	; CHANGE: was "move.l #$3f00ffff,d1"
	lea.l	Memory_list,a0
	movea.l	Memlist_end,a1
	bra.s	.Entry
.Loop:
	move.l	d1,d2
	and.l	8(a0),d2
	cmp.l	d0,d2
	beq.s	.Found
	lea.l	12(a0),a0
.Entry:
	cmpa.l	a1,a0
	bmi.s	.Loop
	suba.l	a0,a0
	bra.s	.Exit
.Found:
	bclr	#7,8(a0)
	move.l	4(a0),d0
	sub.l	d0,Size_of_free_memory
	ori.b	#7*8,9(a0)
	movea.l	(a0),a0
.Exit:
	movem.l	(sp)+,d0-d2/a1
	rts	

; ---- File_allocate (original source: NUCLEUS/MEMORY.ASM) - the shipped program differs, its code follows, not assembled:
;File_allocate:
;             movem.l   d0-d3/d7/a0,-(sp)
;             addq.l    #1,d1                ; Force word boundary
;             andi.b    #$fe,d1
;             cmp.l     Size_of_free_memory,d1     ; Enough memory ?
;             bls       .Ok
;             ERROR     "[ File_allocate ] : Out of memory !!!"
;             bra       .Exit
;
;; Priorities 0-7 !!!
;.Priority:   .DC.b 0,0,7,1,4,0,3,3,1,0,4,2,1,1,7,2
;             .DC.b 3,1,2,0,0,0,0,0,0,0,0,0,0,0,0,0
;             .DC.b 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
;             .DC.b 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
;             .EVEN
;.Ok:         swap.w    d2                   ; Create identifier
;             move.b    d0,d2
;             lsl.w     #8,d2
;             ext.w     d0
;             move.b    .Priority(pc,d0.w),d0
;             ori.b     #7*8,d0              ; Top generation
;             move.b    d0,d2
;             swap.w    d2
;             ext.w     d0
;
;; ------------- REGISTER CONTENTS ------------------------------------
;;  d0 - Priority (.w)
;;  d1 - Size of requested memory block (.l)
;;  d2 - Identifier (.l)
;
;             jsr       Scan_memory
;             cmp.l     4(a0),d1             ; Perfect fit ?
;             beq.s     .Continue
;             jsr       Split_memory_block
;.Continue:   move.l    d1,4(a0)             ; Set block length
;             move.l    d2,8(a0)             ; Set file type & priority
;             sub.l     d1,Size_of_free_memory     ; Adapt size
;             movea.l   (a0),a1              ; Get pointer to actual memory
;.Exit:       movem.l   (sp)+,d0-d3/d7/a0
;             rts

File_allocate:
	movem.l	d0-d3/d7/a0,-(a7)
	addq.l	#$1,d1
	andi.b	#$fe,d1
	cmp.l	Size_of_free_memory,d1
	bls.b	T_1d460
	lea.l	D_5564a,a1
	jsr	DI_Error
	bra.w	T_1d4a6
T_1d420:
	dc.b	$00,$00,$07,$01,$04,$00,$03,$03,$01,$00,$04,$02,$01,$01,$07,$02
	dc.b	$03,$01,$02,$03,$03,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
T_1d460:
	swap	d2
	move.b	d0,d2
	lsl.w	#$8,d2
	ext.w	d0
	move.b	T_1d420(pc,d0.w),d0
	ori.b	#$38,d0
	move.b	d0,d2
	swap	d2
	ext.w	d0
	bsr.w	T_1d510
	cmp.l	$4(a0),d1
	beq.b	.l_1d49a
	move.l	d1,d0
	sub.l	$4(a0),d1
	neg.l	d1
	bsr.w	T_1d532
	move.l	#$80000000,$8(a0)
	move.l	d0,d1
	lea.l	$c(a0),a0
.l_1d49a:
	move.l	d2,$8(a0)
	sub.l	d1,Size_of_free_memory
	movea.l	(a0),a1
T_1d4a6:
	movem.l	(a7)+,d0-d3/d7/a0
	rts

; ---- Allocate_memory (original source: NUCLEUS/MEMORY.ASM) - the shipped program differs, its code follows, not assembled:
;Allocate_memory:
;             movem.l   d0/d1/d7/a0,-(sp)
;             move.l    d0,d1
;             addq.l    #1,d1                ; Force word boundary
;             andi.b    #$fe,d1
;             cmp.l     Size_of_free_memory,d1     ; Enough memory ?
;             bls.s     .Ok
;             ERROR     "[ Allocate_memory ] : Out of memory !!!"
;             bra       .Exit
;.Ok:         jsr       Scan_memory
;             cmp.l     4(a0),d1             ; Perfect fit ?
;             beq.s     .Continue
;             jsr       Split_memory_block
;.Continue:   move.l    d1,4(a0)             ; Set block length
;             clr.w     8(a0)                ; Set file type & priority
;             sub.l     d1,Size_of_free_memory     ; Adapt size
;             movea.l   (a0),a1              ; Get pointer to actual memory
;.Exit:       movem.l   (sp)+,d0/d1/d7/a0
;             rts

Allocate_memory:
	movem.l	d0-d1/d7/a0,-(a7)
	move.l	d0,d1
	addq.l	#$1,d1
	andi.b	#$fe,d1
	cmp.l	Size_of_free_memory,d1
	bls.b	.l_1d4ce
	lea.l	D_55671,a1
	jsr	DI_Error
	bra.b	T_1d4e8
.l_1d4ce:
	bsr.w	Scan_memory
	cmp.l	$4(a0),d1
	beq.b	.l_1d4dc
	bsr.w	T_1d532
.l_1d4dc:
	clr.l	$8(a0)
T_1d4e0:
	sub.l	d1,Size_of_free_memory
	movea.l	(a0),a1
T_1d4e8:
	movem.l	(a7)+,d0-d1/d7/a0
	rts

; ---- Scan_memory (original source: NUCLEUS/MEMORY.ASM) - the shipped program differs, its code follows, not assembled:
;Scan_memory:
;             move.l    d0,-(sp)
;             moveq.l   #0,d0                ; Initial priority
;.Loop:       jsr       Connect_memory       ; Connect
;             jsr       Find_free_memory     ; Find
;             cmpa.l    #0,a0                ; Success ?
;             bne.s     .Exit
;             addq.b    #1,d0                ; Increase maximum priority
;             bne.s     .Loop
;             ERROR     "[ Scan_memory ] : Garbage collection required !!!"
;.Exit:       move.l    (sp)+,d0
;             rts

Scan_memory:
	move.l	d0,-(a7)
	moveq	#0,d0
.l_1d4f2:
	bsr.w	Connect_memory
	bsr.w	Find_free_memory
	cmpa.l	#$0,a0
	bne.b	.l_1d50c
	addq.b	#$1,d0
	bne.b	.l_1d4f2
	jmp	T_1a214
.l_1d50c:
	move.l	(a7)+,d0
	rts
T_1d510:
	move.l	d0,-(a7)
	moveq	#0,d0
.l_1d514:
	bsr.w	Connect_memory
	bsr.w	T_1d58e
	cmpa.l	#$0,a0
	bne.b	.l_1d52e
	addq.b	#$1,d0
	bne.b	.l_1d514
	jmp	T_1a214
.l_1d52e:
	move.l	(a7)+,d0
	rts
T_1d532:
	lea.l	$c(a0),a0
	bsr.w	Insert_memblock
	move.l	-$c(a0),(a0)
	move.l	-$8(a0),$4(a0)
	move.l	#$80000000,$8(a0)
	add.l	d1,(a0)
	sub.l	d1,$4(a0)
	lea.l	-$c(a0),a0
	move.l	d1,$4(a0)
	rts
; ---- Find_free_memory (original source: NUCLEUS/MEMORY.ASM)
Find_free_memory:
	move.l	a1,-(sp)
	lea.l	Memory_list,a0
	movea.l	Memlist_end,a1
	bra.s	.Entry
.Loop:
	btst	#7,8(a0)
	beq.s	.Next
	cmp.b	9(a0),d0
	bmi.s	.Next
	cmp.l	4(a0),d1
	bls.s	.Exit
.Next:
	lea.l	12(a0),a0
.Entry:
	cmpa.l	a1,a0
	bmi.s	.Loop
	suba.l	a0,a0
.Exit:
	movea.l	(sp)+,a1
	rts	
T_1d58e:
	move.l	a1,-(a7)
	movea.l	Memlist_end,a0
	lea.l	Memory_list,a1
	bra.b	T_1d5b2
T_1d59e:
	btst	#$7,$8(a0)
	beq.b	T_1d5b2
	cmp.b	$9(a0),d0
	bmi.b	T_1d5b2
	cmp.l	$4(a0),d1
	bls.b	T_1d5bc
T_1d5b2:
	lea.l	-$c(a0),a0
	cmpa.l	a0,a1
	bls.b	T_1d59e
	suba.l	a0,a0
T_1d5bc:
	movea.l	(a7)+,a1
	rts
; ---- Connect_memory (original source: NUCLEUS/MEMORY.ASM)
Connect_memory:
	movem.l	d0/d1/a0/a1,-(sp)
	lea.l	Memory_list,a0
	bra.s	.Entry1
.Loop1:
	btst	#7,8(a0)
	beq.s	.Next1
	cmp.b	9(a0),d0
	bmi.s	.Next1
	moveq.l	#-1,d1
	lea.l	12(a0),a1
	bra.s	.Entry2
.Loop2:
	addq.w	#1,d1
	btst	#7,8(a1)
	beq.s	.End2
	cmp.b	9(a1),d0
	bmi.s	.End2
	lea.l	12(a1),a1
.Entry2:
	cmpa.l	Memlist_end,a1
	bmi.s	.Loop2
.End2:
	tst.w	d1
	beq.s	.Next1
	move.l	a1,-(sp)
	move.l	4(a0),d1
	bra.s	.Entry3
.Loop3:
	add.l	4(a1),d1
.Entry3:
	lea.l	-12(a1),a1
	cmpa.l	a0,a1
	bhi.s	.Loop3
.End3:
	move.l	d1,4(a0)
	move.l	#$80000000,$8(a0)	; CHANGE: was "move.w #$8000,8(a0)"
	lea.l	12(a0),a0
	movea.l	(sp)+,a1
	bsr.w	Delete_memblocks
	bra.s	.Entry1
.Next1:
	lea.l	12(a0),a0
.Entry1:
	cmpa.l	Memlist_end,a0
	bmi.s	.Loop1
	movem.l	(sp)+,d0/d1/a0/a1
	rts	
; ---- Insert_memblock (original source: NUCLEUS/MEMORY.ASM)
Insert_memblock:
	movem.l	d0/d1/a1,-(sp)
	movea.l	Memlist_end,a1
	bra.s	.Entry
.Loop:
	move.l	-(a1),12(a1)
	move.l	-(a1),12(a1)
	move.l	-(a1),12(a1)
.Entry:
	cmpa.l	a0,a1
	bpl.s	.Loop
	addi.l	#12,Memlist_end
	movem.l	(sp)+,d0/d1/a1
	rts	
; ---- Delete_memblocks (original source: NUCLEUS/MEMORY.ASM)
Delete_memblocks:
	movem.l	d0/d1/a0-a2,-(sp)
	movea.l	Memlist_end,a2
	move.l	a1,d0
	sub.l	a0,d0
	bls.s	.Exit
	sub.l	d0,Memlist_end
	bra.s	.Entry
.Again:
	move.l	(a1)+,(a0)+
	move.l	(a1)+,(a0)+
	move.l	(a1)+,(a0)+
.Entry:
	cmpa.l	a2,a1
	bmi.s	.Again
.Exit:
	movem.l	(sp)+,d0/d1/a0-a2
	rts	

	section	bss

Start_of_free_memory:
	ds.b	4
Size_of_free_memory:
	ds.b	4
B_60a3e:
	ds.b	4
Memlist_end:
	ds.b	4
Memory_list:
	ds.b	24000
Output_string:
	ds.b	34
