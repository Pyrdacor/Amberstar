; MAIN/MAP/SHADOW.ASM (original module, merged with the disassembly of the shipped program)

	section	text

; ---- Do_shadow (original source: MAIN/MAP/SHADOW.ASM)
Do_shadow:
	movem.l	d0-d7,-(sp)
	moveq.l	#11,d2
	moveq.l	#-1,d3
	moveq.l	#9,d4
	moveq.l	#-1,d5
	sub.w	Mapbuf_X,d2
	sub.w	Mapbuf_X,d3
	sub.w	Mapbuf_Y,d4
	sub.w	Mapbuf_Y,d5
	ext.w	d0
	ext.w	d1
	move.w	d1,d7
	add.w	Mapbuf_Y,d7
	mulu.w	#13,d7
	add.w	d0,d7
	add.w	Mapbuf_X,d7
	moveq.l	#0,d6
	move.b	14(a2,d7.w),d6
	beq.s	.Underlay
	add.w	d6,d6
	add.w	d6,d6
	move.l	-4(a5,d6.w),d6
	btst	#5,d6
	bne.s	.Underlay
	btst	#1,d6
	beq.s	.Exit
	bra.s	.Ok
.Underlay:
	moveq.l	#0,d6
	move.b	14(a1,d7.w),d6
	add.w	d6,d6
	add.w	d6,d6
	move.l	-4(a5,d6.w),d6
	btst	#1,d6
	beq.s	.Exit
.Ok:
	move.w	d0,d6
	bpl.s	.Pos_1
	neg.w	d6
.Pos_1:
	move.w	d1,d7
	bpl.s	.Pos_2
	neg.w	d7
.Pos_2:
	lea.l	Shadow_table,a4
	mulu.w	#9,d7
	add.w	d6,d7
	add.w	d7,d7
	move.w	-2(a4,d7.w),d7
	lea.l	124(a4,d7.w),a4
	tst.w	d0
	bmi.s	.Quad_12
	tst.w	d1
	bmi.s	.Quad_0
	bsr.w	Quadrant_3
	bra.s	.Exit
.Quad_0:
	bsr.w	Quadrant_0
	bra.s	.Exit
.Quad_12:
	tst.w	d1
	bmi.s	.Quad_1
	bsr.w	Quadrant_2
	bra.s	.Exit
.Quad_1:
	bsr.w	Quadrant_1
.Exit:
	movem.l	(sp)+,d0-d7
	rts	

; ---- Quadrant_0 (original source: MAIN/MAP/SHADOW.ASM) - the shipped program differs, its code follows, not assembled:
;Quadrant_0:
;.Again:      tst.w     (a4)                 ; End of shadow run ?
;             beq.s     .Exit
;             move.b    (a4),d0              ; Load X
;             cmp.b     d2,d0                ; X too high ?
;             bgt.s     .Next
;             cmp.b     d3,d0                ; X too low ?
;             blt.s     .Next
;             move.b    1(a4),d1             ; Load Y
;             neg.b     d1                   ; Y = -Y
;             cmp.b     d4,d1                ; Y too high ?
;             bgt.s     .Next
;             cmp.b     d5,d1                ; Y too low ?
;             blt.s     .Next
;             ext.w     d0                   ; Extend to words
;             ext.w     d1
;             add.w     Mapbuf_Y,d1          ; Calculate map buffer offset
;             mulu.w    #13,d1
;             add.w     d0,d1
;             add.w     Mapbuf_X,d1
;             move.b    #1,14(a1,d1.w)       ; Hide underlay icon
;             move.b    #0,14(a2,d1.w)       ; Hide overlay icon
;             move.b    #0,14(a3,d1.w)       ; Hide person
;.Next:       addq.l    #2,a4                ; Next
;             bra.s     .Again
;.Exit:       rts

Quadrant_0:
	tst.w	(a4)
	beq.b	.l_059d0
	move.b	(a4),d0
	cmp.b	d2,d0
	bgt.b	.l_059cc
	cmp.b	d3,d0
	blt.b	.l_059cc
	move.b	$1(a4),d1
	neg.b	d1
	cmp.b	d4,d1
	bgt.b	.l_059cc
	cmp.b	d5,d1
	blt.b	.l_059cc
	ext.w	d0
	ext.w	d1
	add.w	Mapbuf_Y,d1
	mulu.w	#$d,d1
	add.w	d0,d1
	add.w	Mapbuf_X,d1
	move.b	#$1,$e(a1,d1.w)
	move.b	#$0,$e(a2,d1.w)
	move.b	#$0,$e(a3,d1.w)
	move.b	#$0,$e(a6,d1.w)
.l_059cc:
	addq.l	#$2,a4
	bra.b	Quadrant_0
.l_059d0:
	rts

; ---- Quadrant_1 (original source: MAIN/MAP/SHADOW.ASM) - the shipped program differs, its code follows, not assembled:
;Quadrant_1:
;.Again:      tst.w     (a4)                 ; End of shadow run ?
;             beq.s     .Exit
;             move.b    (a4),d0              ; Load X
;             neg.b     d0                   ; X = -X
;             cmp.b     d2,d0                ; X too high ?
;             bgt.s     .Next
;             cmp.b     d3,d0                ; X too low ?
;             blt.s     .Next
;             move.b    1(a4),d1             ; Load Y
;             neg.b     d1                   ; Y = -Y
;             cmp.b     d4,d1                ; Y too high ?
;             bgt.s     .Next
;             cmp.b     d5,d1                ; Y too low ?
;             blt.s     .Next
;             ext.w     d0                   ; Extend to words
;             ext.w     d1
;             add.w     Mapbuf_Y,d1          ; Calculate map buffer offset
;             mulu.w    #13,d1
;             add.w     d0,d1
;             add.w     Mapbuf_X,d1
;             move.b    #1,14(a1,d1.w)       ; Hide underlay icon
;             move.b    #0,14(a2,d1.w)       ; Hide overlay icon
;             move.b    #0,14(a3,d1.w)       ; Hide person
;.Next:       addq.l    #2,a4                ; Next
;             bra.s     .Again
;.Exit:       rts

Quadrant_1:
	tst.w	(a4)
	beq.b	.l_05a22
	move.b	(a4),d0
	neg.b	d0
	cmp.b	d2,d0
	bgt.b	.l_05a1e
	cmp.b	d3,d0
	blt.b	.l_05a1e
	move.b	$1(a4),d1
	neg.b	d1
	cmp.b	d4,d1
	bgt.b	.l_05a1e
	cmp.b	d5,d1
	blt.b	.l_05a1e
	ext.w	d0
	ext.w	d1
	add.w	Mapbuf_Y,d1
	mulu.w	#$d,d1
	add.w	d0,d1
	add.w	Mapbuf_X,d1
	move.b	#$1,$e(a1,d1.w)
	move.b	#$0,$e(a2,d1.w)
	move.b	#$0,$e(a3,d1.w)
	move.b	#$0,$e(a6,d1.w)
.l_05a1e:
	addq.l	#$2,a4
	bra.b	Quadrant_1
.l_05a22:
	rts

; ---- Quadrant_2 (original source: MAIN/MAP/SHADOW.ASM) - the shipped program differs, its code follows, not assembled:
;Quadrant_2:
;.Again:      tst.w     (a4)                 ; End of shadow run ?
;             beq.s     .Exit
;             move.b    (a4),d0              ; Load X
;             neg.b     d0                   ; X = -X
;             cmp.b     d2,d0                ; X too high ?
;             bgt.s     .Next
;             cmp.b     d3,d0                ; X too low ?
;             blt.s     .Next
;             move.b    1(a4),d1             ; Load Y
;             cmp.b     d4,d1                ; Y too high ?
;             bgt.s     .Next
;             cmp.b     d5,d1                ; Y too low ?
;             blt.s     .Next
;             ext.w     d0                   ; Extend to words
;             ext.w     d1
;             add.w     Mapbuf_Y,d1          ; Calculate map buffer offset
;             mulu.w    #13,d1
;             add.w     d0,d1
;             add.w     Mapbuf_X,d1
;             move.b    #1,14(a1,d1.w)       ; Hide underlay icon
;             move.b    #0,14(a2,d1.w)       ; Hide overlay icon
;             move.b    #0,14(a3,d1.w)       ; Hide person
;.Next:       addq.l    #2,a4                ; Next
;             bra.s     .Again
;.Exit:       rts

Quadrant_2:
	tst.w	(a4)
	beq.b	.l_05a72
	move.b	(a4),d0
	neg.b	d0
	cmp.b	d2,d0
	bgt.b	.l_05a6e
	cmp.b	d3,d0
	blt.b	.l_05a6e
	move.b	$1(a4),d1
	cmp.b	d4,d1
	bgt.b	.l_05a6e
	cmp.b	d5,d1
	blt.b	.l_05a6e
	ext.w	d0
	ext.w	d1
	add.w	Mapbuf_Y,d1
	mulu.w	#$d,d1
	add.w	d0,d1
	add.w	Mapbuf_X,d1
	move.b	#$1,$e(a1,d1.w)
	move.b	#$0,$e(a2,d1.w)
	move.b	#$0,$e(a3,d1.w)
	move.b	#$0,$e(a6,d1.w)
.l_05a6e:
	addq.l	#$2,a4
	bra.b	Quadrant_2
.l_05a72:
	rts

; ---- Quadrant_3 (original source: MAIN/MAP/SHADOW.ASM) - the shipped program differs, its code follows, not assembled:
;Quadrant_3:
;.Again:      tst.w     (a4)                 ; End of shadow run ?
;             beq.s     .Exit
;             move.b    (a4),d0              ; Load X
;             cmp.b     d2,d0                ; X too high ?
;             bgt.s     .Next
;             cmp.b     d3,d0                ; X too low ?
;             blt.s     .Next
;             move.b    1(a4),d1             ; Load Y
;             cmp.b     d4,d1                ; Y too high ?
;             bgt.s     .Next
;             cmp.b     d5,d1                ; Y too low ?
;             blt.s     .Next
;             ext.w     d0                   ; Extend to words
;             ext.w     d1
;             add.w     Mapbuf_Y,d1          ; Calculate map buffer offset
;             mulu.w    #13,d1
;             add.w     d0,d1
;             add.w     Mapbuf_X,d1
;             move.b    #1,14(a1,d1.w)       ; Hide underlay icon
;             move.b    #0,14(a2,d1.w)       ; Hide overlay icon
;             move.b    #0,14(a3,d1.w)       ; Hide person
;.Next:       addq.l    #2,a4                ; Next
;             bra.s     .Again
;.Exit:       rts

Quadrant_3:
	tst.w	(a4)
	beq.b	.l_05ac0
	move.b	(a4),d0
	cmp.b	d2,d0
	bgt.b	.l_05abc
	cmp.b	d3,d0
	blt.b	.l_05abc
	move.b	$1(a4),d1
	cmp.b	d4,d1
	bgt.b	.l_05abc
	cmp.b	d5,d1
	blt.b	.l_05abc
	ext.w	d0
	ext.w	d1
	add.w	Mapbuf_Y,d1
	mulu.w	#$d,d1
	add.w	d0,d1
	add.w	Mapbuf_X,d1
	move.b	#$1,$e(a1,d1.w)
	move.b	#$0,$e(a2,d1.w)
	move.b	#$0,$e(a3,d1.w)
	move.b	#$0,$e(a6,d1.w)
.l_05abc:
	addq.l	#$2,a4
	bra.b	Quadrant_3
.l_05ac0:
	rts

	section	data

Spiral_table:
	dc.b	$00,$ff,$01,$ff,$01,$00,$01,$01,$00,$01,$ff,$01,$ff,$00,$ff,$ff
	dc.b	$ff,$fe,$00,$fe,$01,$fe,$02,$fe,$02,$ff,$02,$00,$02,$01,$02,$02
	dc.b	$01,$02,$00,$02,$ff,$02,$fe,$02,$fe,$01,$fe,$00,$fe,$ff,$fe,$fe
	dc.b	$fe,$fd,$ff,$fd,$00,$fd,$01,$fd,$02,$fd,$03,$fd,$03,$fe,$03,$ff
	dc.b	$03,$00,$03,$01,$03,$02,$03,$03,$02,$03,$01,$03,$00,$03,$ff,$03
	dc.b	$fe,$03,$fd,$03,$fd,$02,$fd,$01,$fd,$00,$fd,$ff,$fd,$fe,$fd,$fd
	dc.b	$fd,$fc,$fe,$fc,$ff,$fc,$00,$fc,$01,$fc,$02,$fc,$03,$fc,$04,$fc
	dc.b	$04,$fd,$04,$fe,$04,$ff,$04,$00,$04,$01,$04,$02,$04,$03,$04,$04
	dc.b	$03,$04,$02,$04,$01,$04,$00,$04,$ff,$04,$fe,$04,$fd,$04,$fc,$04
	dc.b	$fc,$03,$fc,$02,$fc,$01,$fc,$00,$fc,$ff,$fc,$fe,$fc,$fd,$fc,$fc
	dc.b	$fc,$fb,$fd,$fb,$fe,$fb,$ff,$fb,$00,$fb,$01,$fb,$02,$fb,$03,$fb
	dc.b	$04,$fb,$05,$fb,$05,$fc,$05,$fd,$05,$fe,$05,$ff,$05,$00,$05,$01
	dc.b	$05,$02,$05,$03,$05,$04,$05,$05,$04,$05,$03,$05,$02,$05,$01,$05
	dc.b	$00,$05,$ff,$05,$fe,$05,$fd,$05,$fc,$05,$fb,$05,$fb,$04,$fb,$03
	dc.b	$fb,$02,$fb,$01,$fb,$00,$fb,$ff,$fb,$fe,$fb,$fd,$fb,$fc,$fb,$fb
	dc.b	$fb,$fa,$fc,$fa,$fd,$fa,$fe,$fa,$ff,$fa,$00,$fa,$01,$fa,$02,$fa
	dc.b	$03,$fa,$04,$fa,$05,$fa,$06,$fa,$06,$fb,$06,$fc,$06,$fd,$06,$fe
	dc.b	$06,$ff,$06,$00,$06,$01,$06,$02,$06,$03,$06,$04,$06,$05,$06,$06
	dc.b	$05,$06,$04,$06,$03,$06,$02,$06,$01,$06,$00,$06,$ff,$06,$fe,$06
	dc.b	$fd,$06,$fc,$06,$fb,$06,$fa,$06,$fa,$05,$fa,$04,$fa,$03,$fa,$02
	dc.b	$fa,$01,$fa,$00,$fa,$ff,$fa,$fe,$fa,$fd,$fa,$fc,$fa,$fb,$fa,$fa
	dc.b	$07,$fa,$07,$fb,$07,$fc,$07,$fd,$07,$fe,$07,$ff,$07,$00,$07,$01
	dc.b	$07,$02,$07,$03,$07,$04,$07,$05,$07,$06,$f9,$06,$f9,$05,$f9,$04
	dc.b	$f9,$03,$f9,$02,$f9,$01,$f9,$00,$f9,$ff,$f9,$fe,$f9,$fd,$f9,$fc
	dc.b	$f9,$fb,$f9,$fa,$08,$fa,$08,$fb,$08,$fc,$08,$fd,$08,$fe,$08,$ff
	dc.b	$08,$00,$08,$01,$08,$02,$08,$03,$08,$04,$08,$05,$08,$06,$f8,$06
	dc.b	$f8,$05,$f8,$04,$f8,$03,$f8,$02,$f8,$01,$f8,$00,$f8,$ff,$f8,$fe
	dc.b	$f8,$fd,$f8,$fc,$f8,$fb,$f8,$fa
D_1e3b6:
	dc.b	$00,$20,$00,$44,$01,$00,$00,$30,$00,$0f,$00,$02
Second_CIL:
	dc.b	$0b,$0a,$11,$15,$0c,$13,$39,$26,$3c,$00
	dc.l	Eye_spy
	dc.l	Ear_action
	dc.l	T_0df02
	dc.l	Change_travelmode
	dc.l	Cast_spell
	dc.l	Camp
	dc.l	Automapper
	dc.l	T_105e8
	dc.l	Options_menu
Vbl_per_step:
	dc.b	$01,$f4
