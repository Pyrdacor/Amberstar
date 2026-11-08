; LAYOUT/OBJFIND.ASM (original module, merged with the disassembly of the shipped program)

; ---- Find_object (original source: LAYOUT/OBJFIND.ASM)
Find_object:
	movem.l	d4/a0,-(sp)
	moveq.l	#0,d2
	movea.l	Object_sp,a0
	move.l	(a0),d4
	jsr	Search_layer
	tst.b	d2
	beq.s	.Exit
	swap.w	d2
	move.l	Obj_child(a0),d4
	beq.s	.Exit
	jsr	Search_layer
	tst.b	d2
	beq.s	.Exit
	lsl.w	#8,d2
	move.l	Obj_child(a0),d4
	beq.s	.Exit
	jsr	Search_layer
.Exit:
	movem.l	(sp)+,d4/a0
	rts	
; ---- Search_layer (original source: LAYOUT/OBJFIND.ASM)
Search_layer:
.Loop:
	movea.l	d4,a0
	cmp.w	(a0),d0
	bmi.s	.Next
	cmp.w	2(a0),d0
	bhi.s	.Next
	cmp.w	4(a0),d1
	bmi.s	.Next
	cmp.w	6(a0),d1
	bhi.s	.Next
	move.b	8(a0),d2
	bra.s	.Exit
.Next:
	move.l	Obj_brother(a0),d4
	bne.s	.Loop
.Exit:
	rts	
; ---- Translate_object_branch (original source: LAYOUT/OBJFIND.ASM)
Translate_object_branch:
	movem.l	d2/a0,-(sp)
	move.l	a0,d2
.Loop1:
	movea.l	d2,a0
	add.w	d0,(a0)
	add.w	d0,2(a0)
	add.w	d1,4(a0)
	add.w	d1,6(a0)
	move.l	Obj_child(a0),d2
	beq.w	.Next1
	move.l	a0,-(sp)
.Loop2:
	movea.l	d2,a0
	add.w	d0,(a0)
	add.w	d0,2(a0)
	add.w	d1,4(a0)
	add.w	d1,6(a0)
	move.l	Obj_child(a0),d2
	beq.s	.Next2
	move.l	a0,-(sp)
.Loop3:
	movea.l	d2,a0
	add.w	d0,(a0)
	add.w	d0,2(a0)
	add.w	d1,4(a0)
	add.w	d1,6(a0)
	move.l	Obj_brother(a0),d2
	bne.s	.Loop3
	movea.l	(sp)+,a0
.Next2:
	move.l	Obj_brother(a0),d2
	bne.s	.Loop2
	movea.l	(sp)+,a0
.Next1:
	move.l	Obj_brother(a0),d2
	bne.s	.Loop1
.Exit:
	movem.l	(sp)+,d2/a0
	rts	
Push_Root:
	move.l	a1,-(a7)
	movea.l	Object_sp,a1
	addq.l	#$4,a1
	cmpa.l	#Window_list,a1
	bmi.b	.l_1a58c
	lea.l	D_333dc,a1
	jsr	DI_Error
	bra.b	.l_1a594
.l_1a58c:
	move.l	a0,(a1)
	move.l	a1,Object_sp
.l_1a594:
	movea.l	(a7)+,a1
	rts
Pop_Root:
	move.l	a1,-(a7)
	movea.l	Object_sp,a1
	cmpa.l	#B_600fa,a1
	bpl.b	.l_1a5b6
	lea.l	D_33407,a1
	jsr	DI_Error
	bra.b	.l_1a5be
.l_1a5b6:
	subq.l	#$4,a1
	move.l	a1,Object_sp
.l_1a5be:
	movea.l	(a7)+,a1
	rts
