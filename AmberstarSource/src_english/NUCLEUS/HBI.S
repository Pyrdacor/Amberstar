; NUCLEUS/HBI.ASM (original module, merged with the disassembly of the shipped program)

	section	text

; ---- HBL_handler (original source: NUCLEUS/HBI.ASM)
HBL_handler:
	movem.l	d0-d7/a0-a2,-(sp)
	tst.b	HBL_flag
	beq.w	No_HBLs
	tst.l	New_HBL_list
	beq.s	No_new_list
	movea.l	New_HBL_list,a0
	lea.l	HBL_list,a1
	moveq.l	#0,d0
	addq.l	#2,a0
	movem.l	(a0)+,d1-d7/a2
	movem.l	d1-d7/a2,(a1)
	lea.l	32(a1),a1
.Again:
	tst.w	(a0)
	beq.s	.End
	moveq.l	#0,d1
	move.b	(a0),d1
	sub.w	d0,d1
	move.b	d1,(a1)+
	move.b	(a0)+,d0
	move.b	(a0)+,d1
	move.b	d1,(a1)+
	beq.s	.Zero
	move.w	(a0)+,d2
	add.w	d2,d2
	addi.w	#$8240,d2
	move.w	d2,(a1)+
	move.w	(a0)+,(a1)+
	bra.s	.Again
.Zero:
	subq.b	#1,-2(a1)
	subq.w	#1,d0
	movem.l	(a0)+,d1-d7/a2
	movem.l	d1-d7/a2,(a1)
	lea.l	32(a1),a1
	bra.s	.Again
.End:
	move.w	(a0),(a1)+
	clr.l	New_HBL_list

; ---- No_new_list (original source: NUCLEUS/HBI.ASM) - the shipped program differs, its code follows, not assembled:
;No_new_list: lea.l     HBL_list,a0          ; Start of list
;             movem.l   (a0)+,d0-d7          ; Set main palette
;             movem.l   d0-d7,Colour_0
;             tst.w     (a0)                 ; End of list ?
;             beq.s     No_HBLs
;             move.b    (a0)+,MFP_Tbdr       ; Set TBDR
;             tst.b     (a0)+                ; Palette or single colour ?
;             beq.s     .Zero
;             move.l    #Single_HBL,Timer_B_vec    ; Install HBL-routine
;             move.w    (a0)+,Single_HBL+4   ; MODIFY INSTRUCTION
;             move.w    (a0)+,Single_HBL+2
;             bra.s     .Continue
;.Zero:       move.l    #Palette_HBL,Timer_B_vec   ; Install HBL-routine
;.Continue:   move.b    #8,MFP_Tbcr          ; Start Timer B
;             move.l    a0,HBL_list_ptr      ; Store pointer to HBL list

No_new_list:
	lea.l	HBL_list,a0
	movem.l	(a0)+,d0-d7
	movem.l	d0-d7,$ffff8240.w
	tst.w	(a0)
	beq.b	No_HBLs
	move.b	(a0)+,$fffffa21.w
	tst.b	(a0)+
	beq.b	.l_1c888
	move.l	#Single_HBL,$120.w
	move.w	(a0)+,Single_HBL+4
	move.w	(a0)+,Single_HBL+2
	bra.b	.l_1c890
.l_1c888:
	dc.b	$21,$fc
	dc.l	Palette_HBL
	dc.b	$01,$20
.l_1c890:
	move.b	#$8,$fffffa1b.w
	move.l	a0,HBL_list_ptr
; ---- No_HBLs (original source: NUCLEUS/HBI.ASM)
No_HBLs:
	movem.l	(sp)+,d0-d7/a0-a2
	rts	

; ---- Single_HBL (original source: NUCLEUS/HBI.ASM) - the shipped program differs, its code follows, not assembled:
;Single_HBL:
;             move.w    #$0000,Colour_0      ; SELF-MODIFYING CODE
;             move.l    a0,-(sp)
;             clr.b     MFP_Tbcr             ; Stop Timer B
;             movea.l   HBL_list_ptr,a0
;             tst.w     (a0)                 ; End of list ?
;             beq.s     .Exit
;             move.b    (a0)+,MFP_Tbdr       ; Set TBDR
;             tst.b     (a0)+                ; Palette or single colour ?
;             bne.s     .Single
;             move.l    #Palette_HBL,Timer_B_vec   ; Palette change
;             bra.s     .Continue
;.Single:     move.w    (a0)+,Single_HBL+4   ; MODIFY INSTRUCTION
;             move.w    (a0)+,Single_HBL+2
;.Continue:   move.l    a0,HBL_list_ptr
;             move.b    #8,MFP_Tbcr          ; Start Timer B
;.Exit:       movea.l   (sp)+,a0
;             bclr.b    #0,MFP_Isra
;             rte

Single_HBL:
	move.w	#$0,$ffff8240.w
	move.l	a0,-(a7)
	clr.b	$fffffa1b.w
	movea.l	HBL_list_ptr,a0
	tst.w	(a0)
	beq.b	.l_1c8e2
	move.b	(a0)+,$fffffa21.w
	tst.b	(a0)+
	bne.b	.l_1c8ca
	move.l	#Palette_HBL,$120.w
	bra.b	.l_1c8d6
.l_1c8ca:
	dc.b	$33,$d8
	dc.l	Single_HBL+4
	dc.b	$33,$d8
	dc.l	Single_HBL+2
.l_1c8d6:
	move.l	a0,HBL_list_ptr
	move.b	#$8,$fffffa1b.w
.l_1c8e2:
	movea.l	(a7)+,a0
	bclr	#$0,$fffffa0f.w
	rte

; ---- Palette_HBL (original source: NUCLEUS/HBI.ASM) - the shipped program differs, its code follows, not assembled:
;Palette_HBL:
;             movem.l   d0-d7/a0-a2,-(sp)
;             movea.l   HBL_list_ptr,a0      ; Load pointer to HBL list
;             movem.l   (a0)+,d1-d7/a1       ; Load palette
;             lea.l     Colour_0,a2
;             clr.b     MFP_Tbcr             ; Stop Timer B
;             moveq.l   #8,d0                ; Dummy TBDR value
;             move.b    d0,MFP_Tbdr
;             move.b    #8,MFP_Tbcr          ; Start Timer B
;.Wait:       cmp.b     MFP_Tbdr,d0          ; Wait for right border
;             beq.s     .Wait
;             movem.l   d1-d7/a1,(a2)        ; Set palette
;             move.b    #0,MFP_Tbcr          ; Stop Timer B
;             tst.w     (a0)                 ; End of list ?
;             beq.s     .Exit
;             move.b    (a0)+,MFP_Tbdr       ; Set TBDR
;             tst.b     (a0)+                ; Palette or single colour ?
;             beq.s     .Continue
;             move.l    #Single_HBL,Timer_B_vec    ; Install HBL-routine
;             move.w    (a0)+,Single_HBL+4   ; MODIFY INSTRUCTION
;             move.w    (a0)+,Single_HBL+2
;.Continue:   move.l    a0,HBL_list_ptr      ; Store pointer to HBL list
;             move.b    #8,MFP_Tbcr          ; Start Timer B
;.Exit:       movem.l   (sp)+,d0-d7/a0-a2
;             bclr.b    #0,MFP_Isra
;             rte

Palette_HBL:
	movem.l	d0-d7/a0-a2,-(a7)
	movea.l	HBL_list_ptr,a0
	movem.l	(a0)+,d1-d7/a1
	lea.l	$ffff8240.w,a2
	clr.b	$fffffa1b.w
	moveq	#8,d0
	move.b	d0,$fffffa21.w
	move.b	#$8,$fffffa1b.w
.l_1c90e:
	cmp.b	$fffffa21.w,d0
	beq.b	.l_1c90e
	movem.l	d1-d7/a1,(a2)
	move.b	#$0,$fffffa1b.w
	tst.w	(a0)
	beq.b	.l_1c94a
	move.b	(a0)+,$fffffa21.w
	tst.b	(a0)+
	beq.b	.l_1c93e
	move.l	#Single_HBL,$120.w
	move.w	(a0)+,Single_HBL+4
	move.w	(a0)+,Single_HBL+2
.l_1c93e:
	move.l	a0,HBL_list_ptr
	move.b	#$8,$fffffa1b.w
.l_1c94a:
	movem.l	(a7)+,d0-d7/a0-a2
	bclr	#$0,$fffffa0f.w
	rte
; ---- HBL_on (original source: NUCLEUS/HBI.ASM)
HBL_on:
	st	HBL_flag
	rts	
; ---- HBL_off (original source: NUCLEUS/HBI.ASM)
HBL_off:
	sf	HBL_flag
	rts	
; ---- Update_HBL (original source: NUCLEUS/HBI.ASM)
Update_HBL:
	move.l	a0,New_HBL_list
	move.l	a0,User_HBL_list
	rts	
; ---- Copy_HBL_list (original source: NUCLEUS/HBI.ASM)
Copy_HBL_list:
	movem.l	d0-d7/a0/a1,-(sp)
	move.w	(a0)+,(a1)+
	movem.l	(a0)+,d0-d7
	movem.l	d0-d7,(a1)
	lea.l	32(a1),a1
.Again:
	tst.w	(a0)
	beq.s	.End
	move.w	(a0)+,(a1)+
	tst.b	-1(a0)
	bne.s	.Single
	movem.l	(a0)+,d0-d7
	movem.l	d0-d7,(a1)
	lea.l	32(a1),a1
	bra.s	.Again
.Single:
	move.l	(a0)+,(a1)+
	bra.s	.Again
.End:
	move.w	#0,(a1)+
	movem.l	(sp)+,d0-d7/a0/a1
	rts	

	section	bss

New_HBL_list:
	ds.b	4
User_HBL_list:
	ds.b	4
HBL_list_ptr:
	ds.b	4
HBL_list:
	ds.b	1024
B_5d864:
	ds.b	4
