; NUCLEUS/HBI.ASM (original module, merged with the disassembly of the shipped program)

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
No_new_list:
	lea.l	HBL_list,a0
	movem.l	(a0)+,d0-d7
	movem.l	d0-d7,$ffff8240.w
	tst.w	(a0)
	beq.b	No_HBLs
	move.b	(a0)+,$fffffa21.w
	tst.b	(a0)+
	beq.b	T_1c88a
	move.l	#Single_HBL,$120.w
	move.w	(a0)+,Single_HBL+4
	move.w	(a0)+,Single_HBL+2
	bra.b	T_1c892
T_1c88a:
	dc.b	$21,$fc
	dc.l	Palette_HBL
	dc.b	$01,$20
T_1c892:
	move.b	#$8,$fffffa1b.w
	move.l	a0,HBL_list_ptr
; ---- No_HBLs (original source: NUCLEUS/HBI.ASM)
No_HBLs:
	movem.l	(sp)+,d0-d7/a0-a2
	rts	
Single_HBL:
	move.w	#$0,$ffff8240.w
	move.l	a0,-(a7)
	clr.b	$fffffa1b.w
	movea.l	HBL_list_ptr,a0
	tst.w	(a0)
	beq.b	T_1c8e4
	move.b	(a0)+,$fffffa21.w
	tst.b	(a0)+
	bne.b	T_1c8cc
	move.l	#Palette_HBL,$120.w
	bra.b	T_1c8d8
T_1c8cc:
	dc.b	$33,$d8
	dc.l	Single_HBL+4
	dc.b	$33,$d8
	dc.l	Single_HBL+2
T_1c8d8:
	move.l	a0,HBL_list_ptr
	move.b	#$8,$fffffa1b.w
T_1c8e4:
	movea.l	(a7)+,a0
	bclr	#$0,$fffffa0f.w
	rte
Palette_HBL:
	movem.l	d0-d7/a0-a2,-(a7)
	movea.l	HBL_list_ptr,a0
	movem.l	(a0)+,d1-d7/a1
	lea.l	$ffff8240.w,a2
	clr.b	$fffffa1b.w
	moveq	#8,d0
	move.b	d0,$fffffa21.w
	move.b	#$8,$fffffa1b.w
T_1c910:
	cmp.b	$fffffa21.w,d0
	beq.b	T_1c910
	movem.l	d1-d7/a1,(a2)
	move.b	#$0,$fffffa1b.w
	tst.w	(a0)
	beq.b	T_1c94c
	move.b	(a0)+,$fffffa21.w
	tst.b	(a0)+
	beq.b	T_1c940
	move.l	#Single_HBL,$120.w
	move.w	(a0)+,Single_HBL+4
	move.w	(a0)+,Single_HBL+2
T_1c940:
	move.l	a0,HBL_list_ptr
	move.b	#$8,$fffffa1b.w
T_1c94c:
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
T_1c9b0:
	movem.l	d0-d7/a0,-(a7)
	move.l	$404.w,B_6089a
	movem.l	$ffff8240.w,d0-d7
	movem.l	d0-d7,B_608b0
	move.b	$ffff8260.w,Old_rez
	lea.l	$ffff8201.w,a0
	movep.w	$0(a0),d0
	move.w	d0,Old_screen
	move.w	sr,-(a7)
	ori.w	#$700,sr
	lea.l	Old_MFP,a0
	move.b	$fffffa07.w,(a0)+
	move.b	$fffffa09.w,(a0)+
	move.b	$fffffa0b.w,(a0)+
	move.b	$fffffa0d.w,(a0)+
	move.b	$fffffa13.w,(a0)+
	move.b	$fffffa15.w,(a0)+
	move.b	$fffffa17.w,(a0)+
	move.b	$fffffa1b.w,(a0)+
	move.b	$fffffa21.w,(a0)+
	move.b	$fffffa1d.w,(a0)+
	move.b	$fffffa25.w,(a0)+
	move.l	$114.w,T_1cbda
	move.l	$110.w,B_608aa
	move.l	$118.w,T_1cbd0
	move.l	$70.w,T_1cc22
	move.w	$454.w,Old_nvbls
	move.l	$502.w,Old_dump_vec
	move.b	$484.w,Old_conterm
	move.w	#$22,-(a7)
	trap	#$e
	addq.l	#$2,a7
	movea.l	d0,a0
	move.l	a0,KBD_vec
	move.l	$10(a0),Old_mouse_vec
	move.w	(a7)+,sr
	movem.l	(a7)+,d0-d7/a0
	rts
