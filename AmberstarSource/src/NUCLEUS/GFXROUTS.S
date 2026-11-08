; NUCLEUS/GFXROUTS.ASM (original module, merged with the disassembly of the shipped program)

	section	text


; ---- Init_gfx (original source: NUCLEUS/GFXROUTS.ASM) - not found in the shipped program, the original source is older, not assembled:
;Init_gfx:
;             movem.l   d0/d1/d6/d7/a0,-(sp)
;             lea.l     X_conv_tab,a0        ; Fill X-conversion table
;             moveq.l   #0,d0
;             moveq.l   #19,d7
;.Loop_1:     moveq.l   #0,d1
;             moveq.l   #15,d6
;.Loop_2:     move.w    d0,(a0)+             ; Store RSA
;             move.w    d1,(a0)+             ; Store pixel number
;             addq.l    #1,d1                ; Next pixel
;             dbra      d6,.Loop_2
;             addq.l    #8,d0                ; Next column
;             dbra      d7,.Loop_1
;             .LOCAL
;             lea.l     Y_conv_tab,a0        ; Fill Y-conversion table
;             moveq.l   #0,d0
;             move.w    #160,d1
;             move.w    #199,d7
;.Loop:       move.w    d0,(a0)+             ; Store data
;             add.w     d1,d0                ; Next line
;             dbra      d7,.Loop
;             movem.l   (sp)+,d0/d1/d6/d7/a0
;             rts

; ---- Coord_convert (original source: NUCLEUS/GFXROUTS.ASM) - the shipped program differs, its code follows, not assembled:
;Coord_convert:
;             movem.l   d0/d1/a0,-(sp)
;             lea.l     Y_conv_tab,a0        ; Convert Y-coordinate
;             add.w     d1,d1
;             move.w    0(a0,d1.w),d2
;             lea.l     X_conv_tab,a0        ; Convert X-coordinate
;             lsl.w     #2,d0
;             add.w     0(a0,d0.w),d2
;             move.w    2(a0,d0.w),d3
;             movem.l   (sp)+,d0/d1/a0
;             rts

Coord_convert:
Coord_conv:
	move.l	d0,-(a7)
	move.w	d1,d2
	mulu.w	#$a0,d2
	move.w	d0,d3
	andi.w	#$f,d3
	sub.w	d3,d0
	lsr.w	#$1,d0
	add.w	d0,d2
	move.l	(a7)+,d0
	rts
T_1c430:
	movem.l	d0-d7/a0-a4,-(a7)
	subq.w	#$1,d6
	subq.w	#$1,d7
	movea.w	d6,a4
	bsr.w	Coord_convert
	lea.l	(a6,d2.w),a1
	andi.w	#$f,d0
.l_1c446:
	movea.l	a1,a3
	move.w	a4,d6
.l_1c44a:
	moveq	#0,d1
	moveq	#0,d2
	moveq	#0,d3
	moveq	#0,d4
	move.w	(a0)+,d1
	move.w	(a0)+,d2
	move.w	(a0)+,d3
	move.w	(a0)+,d4
	ror.l	d0,d1
	ror.l	d0,d2
	ror.l	d0,d3
	ror.l	d0,d4
	move.l	d1,d5
	or.l	d2,d5
	or.l	d3,d5
	or.l	d4,d5
	not.l	d5
	and.w	d5,(a3)
	or.w	d1,(a3)+
	and.w	d5,(a3)
	or.w	d2,(a3)+
	and.w	d5,(a3)
	or.w	d3,(a3)+
	and.w	d5,(a3)
	or.w	d4,(a3)+
	swap	d1
	swap	d2
	swap	d3
	swap	d4
	swap	d5
	and.w	d5,(a3)
	or.w	d1,(a3)+
	and.w	d5,(a3)
	or.w	d2,(a3)+
	and.w	d5,(a3)
	or.w	d3,(a3)+
	and.w	d5,(a3)
	or.w	d4,(a3)+
	subq.l	#$8,a3
	dbra	d6,.l_1c44a
	lea.l	$a0(a1),a1
	dbra	d7,.l_1c446
	movem.l	(a7)+,d0-d7/a0-a4
	rts

; ---- Draw_box (original source: NUCLEUS/GFXROUTS.ASM) - the shipped program differs, its code follows, not assembled:
;Draw_box:
;             movem.l   d0-d7/a0-a3,-(sp)
;             sub.w     d1,d3                ; Calculate number of lines-1
;             move.w    d3,d7
;             mulu.w    #160,d1              ; Calculate screen address (Y)
;             lea.l     0(a6,d1.w),a0
;             move.w    d2,d1
;
;; ------------- REGISTER CONTENTS ------------------------------------
;;   d0 - X-coordinate 1 (.w)
;;   d1 - Y-coordinate 2 (.w)
;;   d6 - Colour {0...15} (.w)
;;   d7 - Number of lines - 1 (.w)
;;   a0 - Screen address (.l)
;
;             moveq.l   #15,d2               ; Get low nibbles of X's
;             moveq.l   #15,d3
;             and.w     d0,d2
;             and.w     d1,d3
;             sub.w     d2,d0                ; Clear low nibbles
;             sub.w     d3,d1
;             lea       StartEnd_tab,a1      ; Load start & end masks
;             add.w     d2,d2
;             add.w     d3,d3
;             move.w    0(a1,d2.w),d2        ; (left)
;             move.w    32(a1,d3.w),d3       ; (right)
;             move.w    d2,d4                ; Invert start & end masks
;             not.w     d4
;             move.w    d3,d5
;             not.w     d5
;             lsr.w     #1,d0                ; Calculate screen address (X)
;             adda.w    d0,a0
;
;; ------------- REGISTER CONTENTS ------------------------------------
;;   d0 - X-coordinate 1 AND $fff0 / 2 (.w)
;;   d1 - Y-coordinate 2 AND $fff0 (.w)
;;   d2 - Start mask (.w)
;;   d3 - End mask (.w)
;;   d4 - Inverted start mask (.w)
;;   d5 - Inverted end mask (.w)
;;   d6 - Colour {0...15} (.w)
;;   d7 - Number of lines - 1 (.w)
;;   a0 - Screen address (.l)
;
;             add.w     d0,d0                ; Calculate
;             sub.w     d0,d1                ; (nr. of truncs-1)*16
;             beq       .Boxonetrunc
;             movea.w   #160-8,a3            ; Calculate next line offset
;             lsr.w     #1,d1
;             suba.w    d1,a3
;             lea       .Jumptower_end+4(pc),a1    ; Calculate jump tower pointer
;             lsr.w     #1,d1
;             suba.w    d1,a1
;             lea       Box_hl_comms,a2      ; Colour patching
;             lsl.w     #3,d6
;             movem.l   0(a2,d6.w),d0/d1
;             movem.l   d0/d1,.Patch1
;             ori.l     #$2000200,d0
;             ori.l     #$2000200,d1
;             movem.l   d0/d1,.Patch2
;             lea       Colour_tab,a2        ; Get colour data
;             movem.l   0(a2,d6.w),d0/d1
;; ------------- Draw horizontal lines --------------------------------
;.Patch1:     or.w      d2,(a0)+             ; First trunc
;             or.w      d2,(a0)+
;             and.w     d4,(a0)+
;             and.w     d4,(a0)+
;             jmp       (a1)                 ; Jump into tower
;             .REPT 18
;             move.l    d0,(a0)+
;             move.l    d1,(a0)+
;             .ENDR
;.Jumptower_end:
;.Patch2:     or.w      d3,(a0)+             ; Last trunc
;             or.w      d3,(a0)+
;             and.w     d5,(a0)+
;             and.w     d5,(a0)+
;             adda.w    a3,a0                ; Next line
;             dbra      d7,.Patch1
;             bra       .Exit
;; ------------- Box is only one trunc wide ---------------------------
;.Boxonetrunc:          lea                  Box_hl_comms,a2 ; Colour patching
;             lsl.w     #3,d6
;             movem.l   0(a2,d6.w),d0/d1
;             movem.l   d0/d1,.Patch3
;             and.w     d3,d2
;             or.w      d5,d4
;.Patch3:     or.w      d2,(a0)+
;             or.w      d2,(a0)+
;             and.w     d4,(a0)+
;             and.w     d4,(a0)+
;             lea       160-8(a0),a0
;             dbra      d7,.Patch3
;.Exit:       movem.l   (sp)+,d0-d7/a0-a3
;             rts

Draw_box:
	movem.l	d0-d7/a0-a3,-(a7)
	sub.w	d1,d3
	move.w	d3,d7
	mulu.w	#$a0,d1
	lea.l	(a6,d1.w),a0
	move.w	d2,d1
	moveq	#15,d2
	moveq	#15,d3
	and.w	d0,d2
	and.w	d1,d3
	sub.w	d2,d0
	sub.w	d3,d1
	lea.l	D_54be6,a1
	add.w	d2,d2
	add.w	d3,d3
	move.w	(a1,d2.w),d2
	move.w	$20(a1,d3.w),d3
	move.w	d2,d4
	not.w	d4
	move.w	d3,d5
	not.w	d5
	lsr.w	#$1,d0
	adda.w	d0,a0
	add.w	d0,d0
	sub.w	d0,d1
	beq.w	T_1c596
	movea.w	#$98,a3
	lsr.w	#$1,d1
	suba.w	d1,a3
	lea.l	T_1c58a(pc),a1
	lsr.w	#$1,d1
	suba.w	d1,a1
	lea.l	Box_hl_comms,a2
	lsl.w	#$3,d6
	movem.l	(a2,d6.w),d0-d1
	movem.l	d0-d1,T_1c534
	ori.l	#$2000200,d0
	ori.l	#$2000200,d1
	movem.l	d0-d1,T_1c586
	lea.l	D_54c26,a2
	movem.l	(a2,d6.w),d0-d1
T_1c534:
	or.w	d2,(a0)+
	or.w	d2,(a0)+
	and.w	d4,(a0)+
	and.w	d4,(a0)+
	jmp	(a1)
	dc.b	$20,$c0,$20,$c1,$20,$c0,$20,$c1,$20,$c0,$20,$c1,$20,$c0,$20,$c1
	dc.b	$20,$c0,$20,$c1,$20,$c0,$20,$c1,$20,$c0,$20,$c1,$20,$c0,$20,$c1
	dc.b	$20,$c0,$20,$c1,$20,$c0,$20,$c1,$20,$c0,$20,$c1,$20,$c0,$20,$c1
	dc.b	$20,$c0,$20,$c1,$20,$c0,$20,$c1,$20,$c0,$20,$c1,$20,$c0,$20,$c1
	dc.b	$20,$c0,$20,$c1,$20,$c0,$20,$c1
T_1c586:
	or.w	d3,(a0)+
	or.w	d3,(a0)+
T_1c58a:
	and.w	d5,(a0)+
	and.w	d5,(a0)+
	adda.w	a3,a0
	dbra	d7,T_1c534
	bra.b	T_1c5c0
T_1c596:
	lea.l	Box_hl_comms,a2
	lsl.w	#$3,d6
	movem.l	(a2,d6.w),d0-d1
	movem.l	d0-d1,.l_1c5b0
	and.w	d3,d2
	or.w	d5,d4
.l_1c5b0:
	or.w	d2,(a0)+
	or.w	d2,(a0)+
	and.w	d4,(a0)+
	and.w	d4,(a0)+
	lea.l	$98(a0),a0
	dbra	d7,.l_1c5b0
T_1c5c0:
	movem.l	(a7)+,d0-d7/a0-a3
	rts
; ---- Duplicate_block (original source: NUCLEUS/GFXROUTS.ASM)
Duplicate_block:
	movem.l	d2-d7/a0/a1,-(sp)
	bsr.w	Coord_convert
	adda.w	d2,a0
	adda.w	d2,a1
	move.w	d6,d5
	lsl.w	#3,d5
	subi.w	#160,d5
	neg.w	d5
	subq.w	#1,d7
	subq.w	#1,d6
.Loop_1:
	move.w	d6,d4
.Loop_2:
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	dbra	d4,.Loop_2
	adda.w	d5,a0
	adda.w	d5,a1
	dbra	d7,.Loop_1
	movem.l	(sp)+,d2-d7/a0/a1
	rts	
; ---- Get2_block (original source: NUCLEUS/GFXROUTS.ASM)
Get2_block:
	movem.l	d2-d7/a0/a1,-(sp)
	jsr	Mouse_off
	bsr.w	Coord_convert
	lea.l	0(a6,d2.w),a1
	move.w	d6,d5
	lsl.w	#3,d5
	subi.w	#160,d5
	neg.w	d5
	subq.w	#1,d7
	subq.w	#1,d6
.Loop_1:
	move.w	d6,d4
.Loop_2:
	move.l	(a1)+,(a0)+
	move.l	(a1)+,(a0)+
	dbra	d4,.Loop_2
	adda.w	d5,a1
	dbra	d7,.Loop_1
	jsr	Mouse_on
	movem.l	(sp)+,d2-d7/a0/a1
	rts	

; ---- Blit_unmasked_block (original source: NUCLEUS/GFXROUTS.ASM) - the shipped program differs, its code follows, not assembled:
;Blit_unmasked_block:
;             movem.l   d0-d5/d7/a0/a1,-(sp)
;             jsr       Coord_convert        ; Calculate screen pointer
;             lea.l     0(a6,d2.w),a1
;             move.l    #$ffff0000,d5        ; Calculate mask
;             ror.l     d3,d5
;             moveq.l   #15,d7
;.Loop:       moveq.l   #0,d0                ; Load one line
;             move.w    (a0)+,d0
;             moveq.l   #0,d1
;             move.w    (a0)+,d1
;             moveq.l   #0,d2
;             move.w    (a0)+,d2
;             moveq.l   #0,d4
;             move.w    (a0)+,d4
;             ror.l     d3,d0                ; Rotate
;             ror.l     d3,d1
;             ror.l     d3,d2
;             ror.l     d3,d4
;             and.w     d5,(a1)              ; Mask half a line
;             or.w      d0,(a1)+
;             and.w     d5,(a1)
;             or.w      d1,(a1)+
;             and.w     d5,(a1)
;             or.w      d2,(a1)+
;             and.w     d5,(a1)
;             or.w      d4,(a1)+
;             swap.w    d0                   ; Swap
;             swap.w    d1
;             swap.w    d2
;             swap.w    d4
;             swap.w    d5
;             and.w     d5,(a1)              ; Mask half a line
;             or.w      d0,(a1)+
;             and.w     d5,(a1)
;             or.w      d1,(a1)+
;             and.w     d5,(a1)
;             or.w      d2,(a1)+
;             and.w     d5,(a1)
;             or.w      d4,(a1)+
;             swap.w    d5
;             lea.l     160-16(a1),a1        ; Next line
;             dbra      d7,.Loop
;             movem.l   (sp)+,d0-d5/d7/a0/a1
;             Check
;             rts

Blit_unmasked_block:
	movem.l	d0-d5/d7/a0-a1,-(a7)
	bsr.w	Coord_convert
	lea.l	(a6,d2.w),a1
	move.l	#$ffff0000,d5
	ror.l	d3,d5
	moveq	#15,d7
.l_1c64a:
	moveq	#0,d0
	move.w	(a0)+,d0
	moveq	#0,d1
	move.w	(a0)+,d1
	moveq	#0,d2
	move.w	(a0)+,d2
	moveq	#0,d4
	move.w	(a0)+,d4
	ror.l	d3,d0
	ror.l	d3,d1
	ror.l	d3,d2
	ror.l	d3,d4
	and.w	d5,(a1)
	or.w	d0,(a1)+
	and.w	d5,(a1)
	or.w	d1,(a1)+
	and.w	d5,(a1)
	or.w	d2,(a1)+
	and.w	d5,(a1)
	or.w	d4,(a1)+
	swap	d0
	swap	d1
	swap	d2
	swap	d4
	swap	d5
	and.w	d5,(a1)
	or.w	d0,(a1)+
	and.w	d5,(a1)
	or.w	d1,(a1)+
	and.w	d5,(a1)
	or.w	d2,(a1)+
	and.w	d5,(a1)
	or.w	d4,(a1)+
	swap	d5
	lea.l	$90(a1),a1
	dbra	d7,.l_1c64a
	movem.l	(a7)+,d0-d5/d7/a0-a1
	rts

; ---- Blit_masked_block (original source: NUCLEUS/GFXROUTS.ASM) - the shipped program differs, its code follows, not assembled:
;Blit_masked_block:
;             movem.l   d0-d7/a0/a1,-(sp)
;             jsr       Coord_convert        ; Calculate screen pointer
;             lea.l     0(a6,d2.w),a1
;             move.l    #$ffff0000,d5        ; Calculate mask
;             ror.l     d3,d5
;             move.w    d3,d6                ; Copy bit number
;             moveq.l   #15,d7
;.Loop:       moveq.l   #0,d0                ; Load one line
;             move.w    (a0)+,d0
;             moveq.l   #0,d1
;             move.w    (a0)+,d1
;             moveq.l   #0,d2
;             move.w    (a0)+,d2
;             moveq.l   #0,d3
;             move.w    (a0)+,d3
;             ror.l     d6,d0                ; Rotate
;             ror.l     d6,d1
;             ror.l     d6,d2
;             ror.l     d6,d3
;             move.l    d0,d4                ; Calculate mask
;             or.l      d1,d4
;             or.l      d2,d4
;             or.l      d3,d4
;             not.l     d4
;             or.l      d5,d4
;             and.w     d4,(a1)              ; Mask half a line
;             or.w      d0,(a1)+
;             and.w     d4,(a1)
;             or.w      d1,(a1)+
;             and.w     d4,(a1)
;             or.w      d2,(a1)+
;             and.w     d4,(a1)
;             or.w      d3,(a1)+
;             swap.w    d0                   ; Swap
;             swap.w    d1
;             swap.w    d2
;             swap.w    d3
;             swap.w    d4
;             and.w     d4,(a1)              ; Mask half a line
;             or.w      d0,(a1)+
;             and.w     d4,(a1)
;             or.w      d1,(a1)+
;             and.w     d4,(a1)
;             or.w      d2,(a1)+
;             and.w     d4,(a1)
;             or.w      d3,(a1)+
;             lea.l     160-16(a1),a1        ; Next line
;             dbra      d7,.Loop
;             movem.l   (sp)+,d0-d7/a0/a1
;             Check
;             rts

Blit_masked_block:
	movem.l	d0-d7/a0-a1,-(a7)
	bsr.w	Coord_convert
	lea.l	(a6,d2.w),a1
	move.l	#$ffff0000,d5
	ror.l	d3,d5
	move.w	d3,d6
	moveq	#15,d7
.l_1c6b4:
	moveq	#0,d0
	move.w	(a0)+,d0
	moveq	#0,d1
	move.w	(a0)+,d1
	moveq	#0,d2
	move.w	(a0)+,d2
	moveq	#0,d3
	move.w	(a0)+,d3
	ror.l	d6,d0
	ror.l	d6,d1
	ror.l	d6,d2
	ror.l	d6,d3
	move.l	d0,d4
	or.l	d1,d4
	or.l	d2,d4
	or.l	d3,d4
	not.l	d4
	or.l	d5,d4
	and.w	d4,(a1)
	or.w	d0,(a1)+
	and.w	d4,(a1)
	or.w	d1,(a1)+
	and.w	d4,(a1)
	or.w	d2,(a1)+
	and.w	d4,(a1)
	or.w	d3,(a1)+
	swap	d0
	swap	d1
	swap	d2
	swap	d3
	swap	d4
	and.w	d4,(a1)
	or.w	d0,(a1)+
	and.w	d4,(a1)
	or.w	d1,(a1)+
	and.w	d4,(a1)
	or.w	d2,(a1)+
	and.w	d4,(a1)
	or.w	d3,(a1)+
	lea.l	$90(a1),a1
	dbra	d7,.l_1c6b4
	movem.l	(a7)+,d0-d7/a0-a1
	rts

; ---- Put_unmasked_block (original source: NUCLEUS/GFXROUTS.ASM) - the shipped program differs, its code follows, not assembled:
;Put_unmasked_block:
;             movem.l   d2/d3/d7/a0/a1,-(sp)
;             jsr       Coord_convert        ; Calculate screen pointer
;             lea.l     0(a6,d2.w),a1
;             moveq.l   #15,d7
;.Loop:       move.l    (a0)+,(a1)+          ; Display line
;             move.l    (a0)+,(a1)+
;             lea.l     160-8(a1),a1         ; Next line
;             dbra      d7,.Loop
;             movem.l   (sp)+,d2/d3/d7/a0/a1
;             Check
;             rts

Put_unmasked_block:
	movem.l	d2-d3/d7/a0-a1,-(a7)
	bsr.w	Coord_convert
	lea.l	(a6,d2.w),a1
	moveq	#15,d7
.l_1c71e:
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	lea.l	$98(a1),a1
	dbra	d7,.l_1c71e
	movem.l	(a7)+,d2-d3/d7/a0-a1
	rts

; ---- Blot_unmasked_block (original source: NUCLEUS/GFXROUTS.ASM) - the shipped program differs, its code follows, not assembled:
;Blot_unmasked_block:
;             movem.l   d2-d7/a0/a1,-(sp)
;             jsr       Coord_convert        ; Calculate screen pointer
;             lea.l     0(a6,d2.w),a1
;             move.w    d6,d5                ; Calculate scanline offset
;             lsl.w     #3,d5
;             subi.w    #160,d5
;             neg.w     d5
;             subq.w    #1,d7                ; DBRA corrections
;             subq.w    #1,d6
;.Loop_1:     move.w    d6,d4                ; Duplicate counter
;.Loop_2:     move.l    (a0)+,(a1)+          ; Display line
;             move.l    (a0)+,(a1)+
;             dbra      d4,.Loop_2
;             adda.w    d5,a1                ; Next line
;             dbra      d7,.Loop_1
;             movem.l   (sp)+,d2-d7/a0/a1
;             Check
;             rts

Blot_unmasked_block:
	movem.l	d2-d7/a0-a1,-(a7)
	bsr.w	Coord_convert
	lea.l	(a6,d2.w),a1
	move.w	d6,d5
	lsl.w	#$3,d5
	subi.w	#$a0,d5
	neg.w	d5
	subq.w	#$1,d7
	subq.w	#$1,d6
.l_1c74a:
	move.w	d6,d4
.l_1c74c:
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	dbra	d4,.l_1c74c
	adda.w	d5,a1
	dbra	d7,.l_1c74a
	movem.l	(a7)+,d2-d7/a0-a1
	rts

; ---- Put_masked_block (original source: NUCLEUS/GFXROUTS.ASM) - the shipped program differs, its code follows, not assembled:
;Put_masked_block:
;             movem.l   d0-d4/d7/a0/a1,-(sp)
;             jsr       Coord_convert        ; Calculate screen pointer
;             lea.l     0(a6,d2.w),a1
;             moveq.l   #15,d7
;.Loop:       movem.w   (a0)+,d0-d3          ; Load one line
;             move.w    d0,d4                ; Calculate mask
;             or.w      d1,d4
;             or.w      d2,d4
;             or.w      d3,d4
;             not.w     d4
;             and.w     d4,(a1)              ; Display one line
;             or.w      d0,(a1)+
;             and.w     d4,(a1)
;             or.w      d1,(a1)+
;             and.w     d4,(a1)
;             or.w      d2,(a1)+
;             and.w     d4,(a1)
;             or.w      d3,(a1)+
;             lea.l     160-8(a1),a1         ; Next line
;             dbra      d7,.Loop
;             movem.l   (sp)+,d0-d4/d7/a0/a1
;             Check
;             rts

Put_masked_block:
	movem.l	d0-d4/d7/a0-a1,-(a7)
	bsr.w	Coord_convert
	lea.l	(a6,d2.w),a1
	moveq	#15,d7
.l_1c76e:
	movem.w	(a0)+,d0-d3
	move.w	d0,d4
	or.w	d1,d4
	or.w	d2,d4
	or.w	d3,d4
	not.w	d4
	and.w	d4,(a1)
	or.w	d0,(a1)+
	and.w	d4,(a1)
	or.w	d1,(a1)+
	and.w	d4,(a1)
	or.w	d2,(a1)+
	and.w	d4,(a1)
	or.w	d3,(a1)+
	lea.l	$98(a1),a1
	dbra	d7,.l_1c76e
	movem.l	(a7)+,d0-d4/d7/a0-a1
	rts

; ---- Blot_masked_block (original source: NUCLEUS/GFXROUTS.ASM) - the shipped program differs, its code follows, not assembled:
;Blot_masked_block:
;             movem.l   d0-d7/a0/a1,-(sp)
;             jsr       Coord_convert        ; Calculate screen pointer
;             lea.l     0(a6,d2.w),a1
;             move.w    d6,d5                ; Calculate scanline offset
;             lsl.w     #3,d5
;             subi.w    #160,d5
;             neg.w     d5
;             subq.w    #1,d7                ; DBRA corrections
;             subq.w    #1,d6
;             move.w    d6,-(sp)             ;tore counter
;.Loop_1:     move.w    (sp),d6              ; Load counter
;.Loop_2:     movem.w   (a0)+,d0-d3          ; Load one line
;             move.w    d0,d4                ; Calculate mask
;             or.w      d1,d4
;             or.w      d2,d4
;             or.w      d3,d4
;             not.w     d4
;             and.w     d4,(a1)              ; Display one line
;             or.w      d0,(a1)+
;             and.w     d4,(a1)
;             or.w      d1,(a1)+
;             and.w     d4,(a1)
;             or.w      d2,(a1)+
;             and.w     d4,(a1)
;             or.w      d3,(a1)+
;             dbra      d6,.Loop_2
;             adda.w    d5,a1                ; Next line
;             dbra      d7,.Loop_1
;             addq.l    #2,sp                ; Adjust stack pointer
;             movem.l   (sp)+,d0-d7/a0/a1
;             Check
;             rts

Blot_masked_block:
	movem.l	d0-d7/a0-a1,-(a7)
	bsr.w	Coord_convert
	lea.l	(a6,d2.w),a1
	move.w	d6,d5
	lsl.w	#$3,d5
	subi.w	#$a0,d5
	neg.w	d5
	subq.w	#$1,d7
	subq.w	#$1,d6
	move.w	d6,-(a7)
.l_1c7b6:
	move.w	(a7),d6
.l_1c7b8:
	movem.w	(a0)+,d0-d3
	move.w	d0,d4
	or.w	d1,d4
	or.w	d2,d4
	or.w	d3,d4
	not.w	d4
	and.w	d4,(a1)
	or.w	d0,(a1)+
	and.w	d4,(a1)
	or.w	d1,(a1)+
	and.w	d4,(a1)
	or.w	d2,(a1)+
	and.w	d4,(a1)
	or.w	d3,(a1)+
	dbra	d6,.l_1c7b8
	adda.w	d5,a1
	dbra	d7,.l_1c7b6
	addq.l	#$2,a7
	movem.l	(a7)+,d0-d7/a0-a1
	rts

	section	data

Box_hl_comms:
	dc.b	$c9,$58,$c9,$58,$c9,$58,$c9,$58,$85,$58,$c9,$58,$c9,$58,$c9,$58
	dc.b	$c9,$58,$85,$58,$c9,$58,$c9,$58,$85,$58,$85,$58,$c9,$58,$c9,$58
	dc.b	$c9,$58,$c9,$58,$85,$58,$c9,$58,$85,$58,$c9,$58,$85,$58,$c9,$58
	dc.b	$c9,$58,$85,$58,$85,$58,$c9,$58,$85,$58,$85,$58,$85,$58,$c9,$58
	dc.b	$c9,$58,$c9,$58,$c9,$58,$85,$58,$85,$58,$c9,$58,$c9,$58,$85,$58
	dc.b	$c9,$58,$85,$58,$c9,$58,$85,$58,$85,$58,$85,$58,$c9,$58,$85,$58
	dc.b	$c9,$58,$c9,$58,$85,$58,$85,$58,$85,$58,$c9,$58,$85,$58,$85,$58
	dc.b	$c9,$58,$85,$58,$85,$58,$85,$58,$85,$58,$85,$58,$85,$58,$85,$58
D_54be6:
	dc.b	$ff,$ff,$7f,$ff,$3f,$ff,$1f,$ff,$0f,$ff,$07,$ff,$03,$ff,$01,$ff
	dc.b	$00,$ff,$00,$7f,$00,$3f,$00,$1f,$00,$0f,$00,$07,$00,$03,$00,$01
	dc.b	$80,$00,$c0,$00,$e0,$00,$f0,$00,$f8,$00,$fc,$00,$fe,$00,$ff,$00
	dc.b	$ff,$80,$ff,$c0,$ff,$e0,$ff,$f0,$ff,$f8,$ff,$fc,$ff,$fe,$ff,$ff
D_54c26:
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$ff,$ff,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$ff,$ff,$00,$00,$ff,$ff,$00,$00,$ff,$ff,$00,$00
	dc.b	$00,$00,$ff,$ff,$ff,$ff,$00,$00,$ff,$ff,$ff,$ff,$ff,$ff,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff
	dc.b	$00,$00,$ff,$ff,$00,$00,$ff,$ff,$ff,$ff,$ff,$ff,$00,$00,$ff,$ff
	dc.b	$00,$00,$00,$00,$ff,$ff,$ff,$ff,$ff,$ff,$00,$00,$ff,$ff,$ff,$ff
	dc.b	$00,$00,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
