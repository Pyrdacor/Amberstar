; MAIN/COMBAT.ASM (original module, merged with the disassembly of the shipped program)

	section	text

Combat_ModInit:
	sf.b	B_58aae
	jsr	T_00194
	moveq	#16,d0
	jsr	Play_song
	lea.l	D_2dfc2,a0
	jsr	Push_PA
	tst.b	Party_advantage
	beq.b	.l_15984
	tst.b	Monster_advantage
	beq.b	.l_15984
	clr.b	Party_advantage
	clr.b	Monster_advantage
.l_15984:
	clr.w	B_589d4
	clr.w	B_589d6
	clr.w	B_58966
	move.w	#$ffff,B_589e0
	clr.w	B_589e2
	clr.w	B_589e4
	clr.w	B_589e6
	clr.w	B_58ab0
	clr.w	B_58e5e
	sf.b	B_58aad
	bsr.w	Choose_particle_path
	lea.l	T_15bab,a0
	jsr	T_1b786
	move.l	a0,B_58908
	lea.l	T_15bb7,a0
	jsr	T_1b786
	move.l	a0,B_5890c
	lea.l	.l_15b82,a0
	move.w	B_58910,d0
	jsr	Load_subfile
	move.l	a0,B_58912
	lea.l	.l_15b90,a0
	move.w	B_5891a,d0
	jsr	Load_subfile
	move.l	a0,B_58916
	bsr.w	T_15bc6
	lea.l	B_58a0e,a0
	moveq	#29,d7
.l_15a26:
	clr.l	(a0)+
	dbra	d7,.l_15a26
	movea.l	B_58916,a0
	lea.l	$6(a0),a0
	moveq	#0,d0
	moveq	#0,d2
	moveq	#2,d7
.l_15a3c:
	move.b	(a0)+,d1
	lsl.w	#$2,d1
	moveq	#5,d6
.l_15a42:
	add.b	d1,d1
	addx.w	d2,d0
	dbra	d6,.l_15a42
	dbra	d7,.l_15a3c
	mulu.w	#$380,d0
	moveq	#0,d1
	lea.l	Chard_ptrs,a2
	moveq	#5,d7
.l_15a5c:
	tst.l	(a2)+
	beq.b	.l_15a62
	addq.w	#$1,d1
.l_15a62:
	dbra	d7,.l_15a5c
	mulu.w	#$e,d1
	add.l	d1,d0
	jsr	Allocate_memory
	movea.l	a1,a4
	move.l	a4,B_58a86
	lea.l	B_58a3e,a5
	movea.l	B_58916,a0
	lea.l	$6(a0),a1
	moveq	#2,d7
.l_15a8c:
	pea.l	-$18(a5)
	move.b	(a1)+,d1
	move.w	(a0)+,d0
	beq.b	.l_15ad0
	tst.b	d1
	beq.b	.l_15ad0
	bsr.w	T_15dd2
	moveq	#5,d6
	lsl.b	#$2,d1
.l_15aa2:
	add.b	d1,d1
	bcc.b	.l_15aca
	move.l	a4,(a5)
	clr.w	(a4)+
	move.l	a2,(a4)+
	clr.w	(a4)+
	move.l	a3,(a4)+
	clr.w	(a4)+
	clr.w	(a4)+
	clr.l	(a4)+
	clr.l	(a4)+
	movem.l	a0-a1,-(a7)
	movea.l	a4,a1
	movea.l	a2,a0
	bsr.w	T_1836a
	movea.l	a1,a4
	movem.l	(a7)+,a0-a1
.l_15aca:
	addq.l	#$4,a5
	dbra	d6,.l_15aa2
.l_15ad0:
	movea.l	(a7)+,a5
	dbra	d7,.l_15a8c
	lea.l	B_589b0,a0
	bsr.w	T_15d6c
	lea.l	B_5be9e,a3
	lea.l	B_58a56,a5
	lea.l	Chard_ptrs,a2
	moveq	#1,d6
	moveq	#5,d7
.l_15af6:
	moveq	#0,d0
	move.b	(a3)+,d0
	move.l	(a2)+,d1
	beq.b	.l_15b2e
	lsl.w	#$2,d0
	tst.l	(a5,d0.w)
	beq.b	.l_15b12
	lea.l	D_2f018,a1
	jsr	DI_Error
.l_15b12:
	movea.l	d1,a0
	move.b	$3a(a0),d2
	andi.w	#$e4,d2
	bne.b	.l_15b2e
	move.l	a4,(a5,d0.w)
	move.w	#$ff00,(a4)+
	move.l	d1,(a4)+
	clr.w	(a4)+
	move.w	d6,(a4)+
	clr.l	(a4)+
.l_15b2e:
	addq.w	#$1,d6
	dbra	d7,.l_15af6
	move.w	#$ffff,B_5891c
	move.w	#$1,B_589da
	clr.w	B_589dc
	moveq	#0,d0
	moveq	#3,d1
	tst.b	Monster_advantage
	beq.b	.l_15b5a
	moveq	#5,d0
	moveq	#0,d1
.l_15b5a:
	lea.l	B_58924,a0
	lea.l	Char_status_icons,a1
	moveq	#5,d7
.l_15b68:
	move.w	d0,(a0)
	addq.l	#$8,a0
	move.b	d1,(a1)+
	dbra	d7,.l_15b68
	st.b	B_58aae
	jsr	T_00208
	bra.w	Combat_DisInit
.l_15b82:
	dc.b	$0f,$63,$6f,$6d,$5f,$62,$61,$63,$6b,$2e,$61,$6d,$62,$00
.l_15b90:
	dc.b	$0c,$6d,$6f,$6e,$5f,$64,$61,$74,$61,$2e,$61,$6d,$62,$00
T_15b9e:
	dc.b	$10,$6d,$6f,$6e,$5f,$67,$66,$78,$2e,$61,$6d,$62,$00
T_15bab:
	dc.b	$13,$54,$41,$43,$54,$49,$43,$2e,$49,$43,$4e,$00
T_15bb7:
	dc.b	$14,$46,$5f,$54,$5f,$41,$4e,$49,$4d,$2e,$49,$43,$4e,$00,$00
T_15bc6:
	movem.l	d0-d7/a0-a6,-(a7)
	lea.l	Chard_filename,a3
	movea.l	a0,a4
	lea.l	B_58a8a,a5
	move.w	(a4)+,d0
	move.w	d0,(a5)
	bne.b	.l_15be8
	clr.l	$2(a5)
	clr.l	$6(a5)
	bra.b	.l_15bf4
.l_15be8:
	movea.l	a3,a0
	jsr	Load_subfile
	move.l	a0,$2(a5)
.l_15bf4:
	lea.l	$a(a5),a5
	move.w	(a4)+,d0
	move.w	d0,(a5)
	bne.b	.l_15c08
	clr.l	$2(a5)
	clr.l	$6(a5)
	bra.b	.l_15c22
.l_15c08:
	cmp.w	-$a(a5),d0
	bne.b	.l_15c16
	move.l	-$8(a5),$2(a5)
	bra.b	.l_15c22
.l_15c16:
	movea.l	a3,a0
	jsr	Load_subfile
	move.l	a0,$2(a5)
.l_15c22:
	lea.l	$a(a5),a5
	move.w	(a4)+,d0
	move.w	d0,(a5)
	bne.b	.l_15c36
	clr.l	$2(a5)
	clr.l	$6(a5)
	bra.b	.l_15c5e
.l_15c36:
	cmp.w	-$14(a5),d0
	bne.b	.l_15c44
	move.l	-$12(a5),$2(a5)
	bra.b	.l_15c5e
.l_15c44:
	cmp.w	-$a(a5),d0
	bne.b	.l_15c52
	move.l	-$8(a5),$2(a5)
	bra.b	.l_15c5e
.l_15c52:
	movea.l	a3,a0
	jsr	Load_subfile
	move.l	a0,$2(a5)
.l_15c5e:
	lea.l	T_15b9e,a3
	lea.l	B_58a8a,a5
	tst.w	(a5)
	beq.b	.l_15c84
	movea.l	$2(a5),a0
	moveq	#0,d0
	move.b	$3e(a0),d0
	movea.l	a3,a0
	jsr	Load_subfile
	move.l	a0,$6(a5)
.l_15c84:
	lea.l	$a(a5),a5
	tst.w	(a5)
	beq.b	.l_15cb8
	movea.l	$2(a5),a0
	moveq	#0,d0
	move.b	$3e(a0),d0
	movea.l	-$8(a5),a1
	moveq	#0,d1
	move.b	$3e(a1),d1
	cmp.w	d0,d1
	bne.b	.l_15cac
	move.l	-$4(a5),$6(a5)
	bra.b	.l_15cb8
.l_15cac:
	movea.l	a3,a0
	jsr	Load_subfile
	move.l	a0,$6(a5)
.l_15cb8:
	lea.l	$a(a5),a5
	tst.w	(a5)
	beq.b	.l_15d02
	movea.l	$2(a5),a0
	moveq	#0,d0
	move.b	$3e(a0),d0
	movea.l	-$12(a5),a1
	moveq	#0,d1
	move.b	$3e(a1),d1
	cmp.w	d0,d1
	bne.b	.l_15ce0
	move.l	-$e(a5),$6(a5)
	bra.b	.l_15d02
.l_15ce0:
	movea.l	-$8(a5),a1
	moveq	#0,d1
	move.b	$3e(a1),d1
	cmp.w	d0,d1
	bne.b	.l_15cf6
	move.l	-$4(a5),$6(a5)
	bra.b	.l_15d02
.l_15cf6:
	movea.l	a3,a0
	jsr	Load_subfile
	move.l	a0,$6(a5)
.l_15d02:
	movem.l	(a7)+,d0-d7/a0-a6
	rts
T_15d08:
	tst.b	B_58aab
	bne.b	.l_15d1e
	bset	#$7,$4(a0)
	bclr	#$7,$5(a0)
	bra.b	.l_15d2a
.l_15d1e:
	bclr	#$7,$4(a0)
	bset	#$7,$5(a0)
.l_15d2a:
	rts
T_15d2c:
	btst	#$1,Mouse_button_state
	bne.b	T_15d2c
	move.w	#$0,Draw_Cicon
	jsr	My_vsync
	sf.b	B_58aab
	rts
T_15d4c:
	btst	#$1,Mouse_button_state
	bne.b	T_15d4c
	move.w	#$0,Draw_Cicon
	jsr	My_vsync
	st.b	B_58aab
	rts
T_15d6c:
	movem.l	d0-d7/a0-a3,-(a7)
	movea.l	a0,a1
	moveq	#8,d7
.l_15d74:
	clr.w	(a1)+
	dbra	d7,.l_15d74
	lea.l	B_58a0e,a1
	moveq	#17,d7
.l_15d82:
	move.l	(a1)+,d0
	beq.b	.l_15da0
	movea.l	d0,a2
	movea.l	$2(a2),a2
	movea.l	a0,a3
.l_15d8e:
	tst.l	(a3)
	beq.b	.l_15d9a
	cmpa.l	(a3),a2
	beq.b	.l_15d9c
	addq.l	#$6,a3
	bra.b	.l_15d8e
.l_15d9a:
	move.l	a2,(a3)
.l_15d9c:
	addq.w	#$1,$4(a3)
.l_15da0:
	dbra	d7,.l_15d82
	movem.l	(a7)+,d0-d7/a0-a3
	rts
T_15daa:
	movem.l	d7/a0-a1,-(a7)
	moveq	#2,d7
.l_15db0:
	cmpa.l	(a0),a1
	beq.b	.l_15dc8
	addq.l	#$6,a0
	dbra	d7,.l_15db0
	lea.l	D_2f05b,a1
	jsr	DI_Error
	moveq	#0,d0
.l_15dc8:
	move.w	$4(a0),d0
	movem.l	(a7)+,d7/a0-a1
	rts
T_15dd2:
	move.w	d7,-(a7)
	moveq	#2,d7
	lea.l	B_58a8a,a2
.l_15ddc:
	cmp.w	(a2)+,d0
	beq.b	.l_15df2
	addq.l	#$8,a2
	dbra	d7,.l_15ddc
	lea.l	D_2f083,a1
	jsr	DI_Error
.l_15df2:
	movea.l	$4(a2),a3
	movea.l	(a2),a2
	move.w	(a7)+,d7
	rts
Combat_ModExit:
	bsr.w	Combat_DisExit
	sf.b	B_58aae
	movea.l	B_58908,a0
	jsr	Free_memory
	movea.l	B_5890c,a0
	jsr	Free_memory
	movea.l	B_58912,a0
	jsr	Free_memory
	movea.l	B_58916,a0
	jsr	Free_memory
	lea.l	B_58a8a,a4
	moveq	#2,d7
.l_15e3e:
	move.l	$2(a4),d0
	beq.b	.l_15e66
	movea.l	d0,a0
	jsr	Free_memory
	movea.l	a4,a0
	move.w	d7,d6
	move.l	$2(a4),d0
.l_15e54:
	cmp.l	$2(a0),d0
	bne.b	.l_15e5e
	clr.l	$2(a0)
.l_15e5e:
	adda.w	#$a,a0
	dbra	d6,.l_15e54
.l_15e66:
	adda.w	#$a,a4
	dbra	d7,.l_15e3e
	lea.l	B_58a8a,a4
	moveq	#2,d7
.l_15e76:
	move.l	$6(a4),d0
	beq.b	.l_15e9e
	movea.l	d0,a0
	jsr	Free_memory
	movea.l	a4,a0
	move.w	d7,d6
	move.l	$6(a4),d0
.l_15e8c:
	cmp.l	$6(a0),d0
	bne.b	.l_15e96
	clr.l	$6(a0)
.l_15e96:
	adda.w	#$a,a0
	dbra	d6,.l_15e8c
.l_15e9e:
	adda.w	#$a,a4
	dbra	d7,.l_15e76
	jsr	Set_map_music
	jsr	Pop_PA
	rts
Combat_DisInit:
	move.w	#$10,Mesmin_X
	move.w	#$b1,Mesmin_Y
	move.w	#$b0,Mesmin_Wd
	move.l	#Code0004Sys,Textfile_ptr
	move.l	#D_2dfba,PlusMes_info
	movea.l	Off_screen,a6
	moveq	#4,d0
	jsr	Show_layout
	lea.l	D_2dfce,a0
	bsr.w	T_15d08
	move.l	a0,Control_list_ptr
	jsr	Show_control_icons
	move.l	#Blink_markers,B_58920
	bsr.w	T_15f8c
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	D_2e070,a0
	jsr	Set_layout_data
	move.w	B_58910,d0
	lea.l	D_2e014,a0
	lea.l	D_2e016,a1
	mulu.w	#$6,d0
	adda.w	d0,a1
	move.l	(a1)+,(a0)+
	move.w	(a1)+,(a0)+
	lea.l	D_2dffc,a1
	lea.l	Subfade1,a2
.l_15f52:
	lea.l	D_2e082,a0
	jsr	Update_HBL
	jsr	My_vsync
	jsr	My_vsync
	lea.l	D_2e0a6,a0
	jsr	Fade_pal
	bne.b	.l_15f52
	lea.l	D_2e082,a0
	jsr	Update_HBL
	rts
T_15f86:
	movem.l	d0-d7/a0-a6,-(a7)
	bra.b	T_15f94
T_15f8c:
	movem.l	d0-d7/a0-a6,-(a7)
	bsr.w	T_18416
T_15f94:
	lea.l	$1f08(a6),a1
	move.l	#$10001,d0
	moveq	#-1,d1
	moveq	#4,d7
.l_15fa2:
	moveq	#14,d6
.l_15fa4:
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	lea.l	$70(a1),a1
	dbra	d6,.l_15fa4
	move.l	d1,(a1)+
	move.l	d1,(a1)+
	move.l	d1,(a1)+
	move.l	d1,(a1)+
	move.l	d1,(a1)+
	move.l	d1,(a1)+
	move.l	d1,(a1)+
	move.l	d1,(a1)+
	move.l	d1,(a1)+
	move.l	d1,(a1)+
	move.l	d1,(a1)+
	move.l	d1,(a1)+
	lea.l	$70(a1),a1
	dbra	d7,.l_15fa2
	lea.l	B_58a0e,a4
	moveq	#0,d4
	moveq	#0,d5
	moveq	#29,d7
.l_15ff0:
	move.l	(a4)+,d0
	beq.b	.l_1602e
	movea.l	d0,a0
	moveq	#0,d2
	cmpi.b	#$ff,(a0)
	bne.b	.l_16008
	movea.l	$2(a0),a2
	move.b	$5(a2),d2
	bra.b	.l_16014
.l_16008:
	movea.l	$2(a0),a2
	move.b	$3e(a2),d2
	addi.w	#$9,d2
.l_16014:
	move.w	d4,d0
	move.w	d5,d1
	mulu.w	#$3,d2
	move.w	$6(a0),d3
	add.w	d3,d3
	lea.l	.l_16052(pc),a2
	add.w	(a2,d3.w),d2
	bsr.w	T_1646a
.l_1602e:
	addq.w	#$1,d4
	cmpi.w	#$6,d4
	bne.b	.l_1603a
	moveq	#0,d4
	addq.w	#$1,d5
.l_1603a:
	dbra	d7,.l_15ff0
	move.l	B_58920,d0
	beq.b	.l_1604a
	movea.l	d0,a0
	jsr	(a0)
.l_1604a:
	bsr.b	Show_damage
	movem.l	(a7)+,d0-d7/a0-a6
	rts
.l_16052:
	dc.b	$00,$00,$00,$01,$00,$02,$00,$01
; Shows the damage of a participant in its tactical cell (monsters for 100 VBL, party members for 70 VBL).
Show_damage:
	movem.l	d0-d2/d4-d5/d7/a0/a4,-(a7)
	lea.l	B_58a0e,a4
	moveq	#0,d4
	moveq	#57,d5
	moveq	#17,d7
.l_1606a:
	move.l	(a4)+,d0
	beq.b	.l_16086
	movea.l	d0,a0
	tst.w	$10(a0)
	beq.b	.l_16086
	move.w	$12(a0),d2
	move.w	d4,d0
	addi.w	#$d,d0
	move.w	d5,d1
	bsr.w	Draw_damage_digits
.l_16086:
	addq.w	#$1,d4
	cmpi.w	#$6,d4
	bne.b	.l_16094
	moveq	#0,d4
	addi.w	#$10,d5
.l_16094:
	dbra	d7,.l_1606a
	moveq	#11,d7
.l_1609a:
	move.l	(a4)+,d0
	beq.b	.l_160b6
	movea.l	d0,a0
	tst.w	$a(a0)
	beq.b	.l_160b6
	move.w	$c(a0),d2
	move.w	d4,d0
	addi.w	#$d,d0
	move.w	d5,d1
	bsr.w	Draw_damage_digits
.l_160b6:
	addq.w	#$1,d4
	cmpi.w	#$6,d4
	bne.b	.l_160c4
	moveq	#0,d4
	addi.w	#$10,d5
.l_160c4:
	dbra	d7,.l_1609a
	movem.l	(a7)+,d0-d2/d4-d5/d7/a0/a4
	rts
T_160ce:
	movem.l	d0-d2/a3-a4,-(a7)
	move.w	d1,d2
	bsr.w	T_1642a
	tst.w	d1
	beq.b	.l_160e6
	move.w	#$46,$a(a4)
	move.w	d2,$c(a4)
.l_160e6:
	movem.l	(a7)+,d0-d2/a3-a4
	rts
T_160ec:
	move.w	Active_member,d0
	beq.b	.l_1615e
	bsr.w	T_1642a
	movem.w	d0-d1,-(a7)
	moveq	#10,d2
	bsr.w	Draw_grid_frame
	movem.w	(a7)+,d2-d3
	move.w	B_5891e,d0
	btst	#$4,d0
	bne.b	.l_16128
	moveq	#0,d6
.l_16114:
	bsr.w	Get_move_targets
	tst.w	d0
	bmi.b	.l_1615e
	move.w	d2,-(a7)
	moveq	#9,d2
	bsr.w	Draw_cell_frame
	move.w	(a7)+,d2
	bra.b	.l_16114
.l_16128:
	moveq	#1,d7
	lea.l	B_58924,a0
	movem.w	(a0),d0-d2
	cmpi.w	#$1,d0
	bne.b	.l_16154
	move.w	d1,d0
	move.w	d2,d1
	cmp.w	Active_member,d7
	beq.b	.l_1614e
	moveq	#6,d2
	bsr.w	Draw_cell_cross
	bra.b	.l_16154
.l_1614e:
	dc.b	$74,$06,$61,$00,$04,$24
.l_16154:
	dc.b	$50,$88,$52,$47,$0c,$47,$00,$07,$66,$d2
.l_1615e:
	rts
T_16160:
	move.w	Active_member,d0
	beq.b	.l_161ac
	bsr.w	T_1642a
	movem.w	d0-d1,-(a7)
	moveq	#10,d2
	bsr.w	Draw_grid_frame
	movem.w	(a7)+,d2-d3
	move.w	B_5891e,d0
	btst	#$4,d0
	bne.b	.l_161ac
	moveq	#0,d0
	moveq	#0,d1
	moveq	#17,d7
	lea.l	B_58a0e,a0
.l_16192:
	tst.l	(a0)+
	beq.b	.l_1619c
	moveq	#1,d2
	bsr.w	Draw_cell_frame
.l_1619c:
	addq.w	#$1,d0
	cmpi.w	#$6,d0
	bne.b	.l_161a8
	moveq	#0,d0
	addq.w	#$1,d1
.l_161a8:
	dbra	d7,.l_16192
.l_161ac:
	rts
T_161ae:
	move.w	B_5891e,d0
	btst	#$4,d0
	bne.b	.l_161e0
	moveq	#0,d0
	moveq	#3,d1
	moveq	#11,d7
	lea.l	B_58a56,a0
.l_161c6:
	tst.l	(a0)+
	beq.b	.l_161d0
	moveq	#1,d2
	bsr.w	Draw_cell_frame
.l_161d0:
	addq.w	#$1,d0
	cmpi.w	#$6,d0
	bne.b	.l_161dc
	moveq	#0,d0
	addq.w	#$1,d1
.l_161dc:
	dbra	d7,.l_161c6
.l_161e0:
	rts
T_161e2:
	move.w	Active_member,d0
	beq.b	.l_16248
	bsr.w	T_1642a
	movem.w	d0-d1,-(a7)
	moveq	#10,d2
	bsr.w	Draw_grid_frame
	movem.w	(a7)+,d2-d3
	move.w	B_5891e,d0
	btst	#$4,d0
	bne.b	.l_16248
	moveq	#0,d0
	move.w	Mouse_Y,d1
	subi.w	#$30,d1
	bmi.b	.l_16248
	lsr.w	#$4,d1
	cmpi.w	#$3,d1
	bge.b	.l_16248
	moveq	#5,d7
	lea.l	B_58a0e,a0
	move.w	d1,d2
	mulu.w	#$18,d2
	adda.w	d2,a0
.l_1622e:
	tst.l	(a0)+
	beq.b	.l_16238
	moveq	#1,d2
	bsr.w	Draw_cell_frame
.l_16238:
	addq.w	#$1,d0
	cmpi.w	#$6,d0
	bne.b	.l_16244
	moveq	#0,d0
	addq.w	#$1,d1
.l_16244:
	dbra	d7,.l_1622e
.l_16248:
	rts
T_1624a:
	move.w	Active_member,d0
	beq.b	.l_162a8
	bsr.w	T_1642a
	movem.w	d0-d1,-(a7)
	moveq	#10,d2
	bsr.w	Draw_grid_frame
	movem.w	(a7)+,d2-d3
	move.w	B_5891e,d0
	btst	#$4,d0
	bne.b	.l_16286
	moveq	#0,d6
.l_16272:
	bsr.w	Get_melee_targets
	tst.w	d0
	bmi.b	.l_162a8
	move.w	d2,-(a7)
	moveq	#1,d2
	bsr.w	Draw_cell_frame
	move.w	(a7)+,d2
	bra.b	.l_16272
.l_16286:
	dc.b	$41,$f9
	dc.l	B_58924
	dc.b	$30,$39
	dc.l	Active_member
	dc.b	$53,$40,$e7,$48,$d0,$c0,$0c,$58,$00,$03,$66,$0a,$30,$18,$32,$18
	dc.b	$74,$05,$61,$00,$02,$d0
.l_162a8:
	rts
; The free neighbour cells in the party rows which no other member wants to move to.
Get_move_targets:
	movem.l	d4-d5/a0,-(a7)
	move.w	Active_member,d5
	neg.w	d5
	addq.w	#$6,d5
.l_162b8:
	cmpi.w	#$8,d6
	beq.b	.l_16322
	move.w	d6,d4
	lsl.w	#$2,d4
	movem.w	.l_1632a(pc,d4.w),d0-d1
	add.w	d2,d0
	bmi.b	.l_1631e
	add.w	d3,d1
	cmpi.w	#$5,d0
	bgt.b	.l_1631e
	cmpi.w	#$4,d1
	bgt.b	.l_1631e
	cmpi.w	#$3,d1
	blt.b	.l_1631e
	lea.l	B_58a0e,a0
	move.w	d1,d4
	mulu.w	#$6,d4
	add.w	d0,d4
	lsl.w	#$2,d4
	tst.l	(a0,d4.w)
	bne.b	.l_1631e
	addq.w	#$1,d6
	lea.l	B_58924,a0
	moveq	#5,d4
.l_16300:
	cmp.w	d5,d4
	beq.b	.l_16316
	cmpi.w	#$1,(a0)
	bne.b	.l_16316
	cmp.w	$2(a0),d0
	bne.b	.l_16316
	cmp.w	$4(a0),d1
	beq.b	.l_162b8
.l_16316:
	addq.l	#$8,a0
	dbra	d4,.l_16300
	bra.b	.l_16324
.l_1631e:
	addq.w	#$1,d6
	bra.b	.l_162b8
.l_16322:
	moveq	#-1,d0
.l_16324:
	movem.l	(a7)+,d4-d5/a0
	rts
.l_1632a:
	dc.b	$ff,$ff,$ff,$ff,$00,$00,$ff,$ff,$00,$01,$ff,$ff,$ff,$ff,$00,$00
	dc.b	$00,$01,$00,$00,$ff,$ff,$00,$01,$00,$00,$00,$01,$00,$01,$00,$01
; Melee attacks only from the front row against the cell in front or diagonal in front. Ranged weapons reach every monster.
Get_melee_targets:
	tst.w	B_58958
	bne.b	.l_163aa
	movem.l	d4/a0,-(a7)
.l_16356:
	cmpi.w	#$3,d6
	beq.b	.l_16396
	move.w	d6,d4
	lsl.w	#$2,d4
	movem.w	.l_1639e(pc,d4.w),d0-d1
	add.w	d2,d0
	bmi.b	.l_16392
	add.w	d3,d1
	cmpi.w	#$5,d0
	bgt.b	.l_16392
	cmpi.w	#$2,d1
	bne.b	.l_16392
	lea.l	B_58a0e,a0
	move.w	d1,d4
	mulu.w	#$6,d4
	add.w	d0,d4
	lsl.w	#$2,d4
	tst.l	(a0,d4.w)
	beq.b	.l_16392
	addq.w	#$1,d6
	bra.b	.l_16398
.l_16392:
	addq.w	#$1,d6
	bra.b	.l_16356
.l_16396:
	moveq	#-1,d0
.l_16398:
	movem.l	(a7)+,d4/a0
	rts
.l_1639e:
	dc.b	$00,$00,$ff,$ff,$ff,$ff,$ff,$ff,$00,$01,$ff,$ff
.l_163aa:
	movem.l	d4/a0,-(a7)
	lea.l	B_58a0e,a0
	move.w	d6,d0
	lsl.w	#$2,d0
	adda.w	d0,a0
.l_163ba:
	cmpi.w	#$12,d6
	beq.b	.l_163d8
	move.w	d6,d1
	ext.l	d1
	divu.w	#$6,d1
	move.l	d1,d0
	swap	d0
	tst.l	(a0)+
	beq.b	.l_163d4
	addq.w	#$1,d6
	bra.b	.l_163da
.l_163d4:
	addq.w	#$1,d6
	bra.b	.l_163ba
.l_163d8:
	moveq	#-1,d0
.l_163da:
	movem.l	(a7)+,d4/a0
	rts
; The markers on the tactical battle field blink.
Blink_markers:
	move.w	B_5891e,d0
	btst	#$4,d0
	bne.b	.l_16428
	move.w	Active_member,d0
	beq.b	.l_16428
	bsr.b	T_1642a
	moveq	#9,d2
	bsr.w	Draw_grid_frame
	lea.l	B_58924,a0
	move.w	Active_member,d0
	subq.w	#$1,d0
	lsl.w	#$3,d0
	adda.w	d0,a0
	move.w	(a0)+,d0
	cmpi.w	#$1,d0
	beq.b	.l_1641e
	cmpi.w	#$3,d0
	beq.b	.l_1641e
	bra.b	.l_16428
.l_1641e:
	dc.b	$30,$18,$32,$18,$74,$06,$61,$00,$01,$50
.l_16428:
	rts
T_1642a:
	movem.l	d2-d7/a0-a1,-(a7)
	lea.l	B_58a56,a0
	move.w	d0,d2
	moveq	#0,d0
	moveq	#3,d1
	moveq	#11,d7
.l_1643c:
	move.l	(a0)+,d3
	beq.b	.l_16448
	movea.l	d3,a1
	cmp.w	$8(a1),d2
	beq.b	.l_1645e
.l_16448:
	addq.w	#$1,d0
	cmpi.w	#$6,d0
	bne.b	.l_16454
	moveq	#0,d0
	addq.w	#$1,d1
.l_16454:
	dbra	d7,.l_1643c
	moveq	#0,d0
	moveq	#0,d1
	move.l	a1,d3
.l_1645e:
	movea.l	d3,a4
	lea.l	-$4(a0),a3
	movem.l	(a7)+,d2-d7/a0-a1
	rts
T_1646a:
	movem.l	d0-d2/a0,-(a7)
	lsl.w	#$7,d2
	movea.l	B_58908,a0
	adda.w	d2,a0
	lsl.w	#$4,d0
	lsl.w	#$4,d1
	addi.w	#$d0,d0
	addi.w	#$31,d1
	jsr	Put_unmasked_block
	movem.l	(a7)+,d0-d2/a0
	rts
; A frame on the grid lines around a cell.
Draw_grid_frame:
	movem.l	d0-d7/a0-a6,-(a7)
	lsl.w	#$4,d1
	addi.w	#$30,d1
	mulu.w	#$a0,d1
	addi.w	#$d,d0
	lsl.w	#$3,d0
	add.w	d1,d0
	lea.l	$8(a6,d0.w),a1
	lea.l	.l_164ea,a0
	lsl.w	#$4,d2
	moveq	#16,d7
.l_164b4:
	move.w	d2,d3
	move.l	(a0)+,d0
	move.l	d0,d1
	not.l	d1
	moveq	#3,d4
.l_164be:
	add.b	d3,d3
	bcc.b	.l_164ce
	or.w	d0,-(a1)
	swap	d0
	or.w	d0,-$8(a1)
	swap	d0
	bra.b	.l_164d8
.l_164ce:
	dc.b	$c3,$61,$48,$41,$c3,$69,$ff,$f8,$48,$41
.l_164d8:
	dbra	d4,.l_164be
	lea.l	$a8(a1),a1
	dbra	d7,.l_164b4
	movem.l	(a7)+,d0-d7/a0-a6
	rts
.l_164ea:
	dc.b	$00,$01,$ff,$ff,$00,$01,$00,$01,$00,$01,$00,$01,$00,$01,$00,$01
	dc.b	$00,$01,$00,$01,$00,$01,$00,$01,$00,$01,$00,$01,$00,$01,$00,$01
	dc.b	$00,$01,$00,$01,$00,$01,$00,$01,$00,$01,$00,$01,$00,$01,$00,$01
	dc.b	$00,$01,$00,$01,$00,$01,$00,$01,$00,$01,$00,$01,$00,$01,$00,$01
	dc.b	$00,$01,$ff,$ff
T_1652e:
	dc.b	$ff,$fe,$80,$02,$80,$02,$80,$02,$80,$02,$80,$02,$80,$02,$80,$02
	dc.b	$80,$02,$80,$02,$80,$02,$80,$02,$80,$02,$80,$02,$ff,$fe
; The lines of the cross (y offset, x offset, width).
Cross_lines:
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$0c,$60,$0e,$e0,$07,$c0,$03,$80
	dc.b	$07,$c0,$0e,$e0,$0c,$60,$00,$00,$00,$00,$00,$00,$00,$00
; A cross inside of a cell.
Draw_cell_cross:
	movem.l	d0-d7/a0-a6,-(a7)
	lea.l	Cross_lines,a0
	bra.b	T_16580
; A frame inside of a cell.
Draw_cell_frame:
	movem.l	d0-d7/a0-a6,-(a7)
	lea.l	T_1652e,a0
T_16580:
	lsl.w	#$4,d1
	addi.w	#$31,d1
	mulu.w	#$a0,d1
	addi.w	#$d,d0
	lsl.w	#$3,d0
	add.w	d1,d0
	lea.l	$8(a6,d0.w),a1
	lsl.w	#$4,d2
	moveq	#14,d7
.l_1659a:
	move.w	d2,d3
	move.w	(a0)+,d0
	move.w	d0,d1
	not.w	d1
	moveq	#3,d4
.l_165a4:
	add.b	d3,d3
	bcc.b	.l_165ac
	or.w	d0,-(a1)
	bra.b	.l_165ae
.l_165ac:
	dc.b	$c3,$61
.l_165ae:
	dbra	d4,.l_165a4
	lea.l	$a8(a1),a1
	dbra	d7,.l_1659a
	movem.l	(a7)+,d0-d7/a0-a6
	rts
; 3 digits (leading zeros) of a 4x5 font at the top left of the lower half of the tactical cell.
Draw_damage_digits:
	movem.l	d0-d2/a0-a2/a5,-(a7)
	lsl.w	#$3,d0
	mulu.w	#$a0,d1
	add.w	d1,d0
	lea.l	(a6,d0.w),a5
	andi.l	#$fff,d2
	lea.l	T_16644,a0
	divu.w	#$a,d2
	swap	d2
	move.w	d2,d0
	mulu.w	#$5,d0
	lea.l	(a0,d0.w),a2
	clr.w	d2
	swap	d2
	divu.w	#$a,d2
	move.w	d2,d0
	swap	d2
	mulu.w	#$5,d2
	lea.l	(a0,d2.w),a1
	mulu.w	#$5,d0
	adda.w	d0,a0
	moveq	#4,d2
T_16608:
	moveq	#0,d0
	move.b	(a0)+,d0
	lsl.w	#$8,d0
	moveq	#0,d1
	move.b	(a1)+,d1
T_16612:
	lsl.w	#$3,d1
	or.w	d1,d0
T_16616:
	moveq	#0,d1
	move.b	(a2)+,d1
	lsr.w	#$2,d1
	or.w	d1,d0
	move.w	d0,d1
	not.w	d1
	or.w	d0,(a5)+
T_16624:
	and.w	d1,(a5)+
	and.w	d1,(a5)+
	or.w	d0,(a5)+
	asr.w	#$1,d1
	lea.l	$98(a5),a5
	and.w	d1,(a5)+
	and.w	d1,(a5)+
	and.w	d1,(a5)+
	and.w	d1,(a5)+
	subq.l	#$8,a5
	dbra	d2,T_16608
	movem.l	(a7)+,d0-d2/a0-a2/a5
	rts
T_16644:
	bra.b	T_16616
	adda.w	(a0),a0
	bra.b	T_1667a
	moveq	#48,d0
	move.w	$30(a0,a6.w),d0
	bra.b	T_16612
	dc.w	$f0e0
	movea.w	-(a0),a0
	move.w	-(a0),(a0)+
	movea.l	-(a0),a0
	adda.w	-$10(a0,d3.w),a0
	mulu.w	-(a0),d0
	move.w	-(a0),(a0)+
	bra.b	T_16624
	dc.b	$e0,$d0,$60,$f0,$30,$60,$c0,$c0,$60,$d0,$60,$d0,$60,$60,$b0,$70
	dc.b	$30,$60
; While the actions are chosen, random participants show their frames (not stunned or sleeping ones).
Idle_animations:
	movem.l	d0/d6-d7/a0/a4,-(a7)
T_1667a:
	move.w	B_5891e,d5
	andi.w	#$7,d5
	bne.b	.l_166d2
	jsr	Random
	andi.w	#$f,d0
	move.w	d0,d6
	lea.l	B_58a0e,a4
	moveq	#29,d7
.l_1669a:
	move.l	(a4)+,d0
	beq.b	.l_166ce
	movea.l	d0,a0
	tst.w	$6(a0)
	beq.b	.l_166b0
	addq.w	#$1,$6(a0)
	andi.w	#$3,$6(a0)
.l_166b0:
	subq.w	#$1,d6
	move.w	$2e(a1),d0
	andi.w	#$104,d0
	bne.b	.l_166ce
	andi.w	#$f,d6
	bne.b	.l_166ce
	tst.w	$6(a0)
	bne.b	.l_166ce
	move.w	#$1,$6(a0)
.l_166ce:
	dbra	d7,.l_1669a
.l_166d2:
	movem.l	(a7)+,d0/d6-d7/a0/a4
	rts
; Next frame of the attack animation of a monster.
Attack_animation_step:
	movem.l	d0/d6-d7/a0/a4,-(a7)
	subq.w	#$1,B_589e6
	bgt.b	.l_1675e
	move.w	#$6,B_589e6
	tst.b	B_58aab
	beq.b	.l_166fc
	move.w	#$4,B_589e6
.l_166fc:
	lea.l	T_18614,a3
	lea.l	B_58a0e,a4
	lea.l	T_185a8,a5
	moveq	#0,d6
	moveq	#17,d7
.l_16712:
	move.l	(a4)+,d0
	beq.b	.l_16752
	movea.l	d0,a0
	move.w	$e(a0),d0
	beq.b	.l_16752
	moveq	#-1,d6
	add.w	d0,$c(a0)
	bne.b	.l_1672c
	clr.w	$e(a0)
	bra.b	.l_16752
.l_1672c:
	movea.l	$2(a0),a1
	moveq	#0,d1
	move.b	$3e(a1),d1
	subq.w	#$1,d1
	lsl.w	#$2,d1
	add.w	$4(a5),d1
	move.b	(a3,d1.w),d1
	cmp.w	$c(a0),d1
	bne.b	.l_16752
	subq.w	#$1,$c(a0)
	neg.w	d0
	move.w	d0,$e(a0)
.l_16752:
	addq.l	#$6,a5
	dbra	d7,.l_16712
	move.w	d6,B_589e2
.l_1675e:
	movem.l	(a7)+,d0/d6-d7/a0/a4
	rts
; A monster which attacks or casts a spell shows the frames 1 to count-1 and back to 0.
Start_attack_animation:
	movem.l	d0-d1/a0,-(a7)
	moveq	#0,d0
	moveq	#0,d1
	move.b	$2(a4),d0
	move.b	$3(a4),d1
	lea.l	B_58a0e,a0
	mulu.w	#$6,d1
	add.w	d1,d0
	lsl.w	#$2,d0
	movea.l	(a0,d0.w),a0
	move.w	#$1,$e(a0)
	clr.w	B_589e0
	move.w	#$1,B_589e2
	move.w	#$6,B_589e6
	movem.l	(a7)+,d0-d1/a0
	rts
; The next action waits until the animation is finished.
Wait_for_animation:
	movem.l	d0-d7/a0-a6,-(a7)
	tst.w	B_589e2
	beq.b	T_16806
	sf.b	B_58aaa
	lea.l	D_2d58c,a0
	bsr.w	Push_Module
	move.w	#$1,B_589e0
.l_167cc:
	move.w	#$0,Draw_Cicon
	bsr.w	Input_handler
	movea.l	Module_sp,a0
	move.l	(a0),d0
	beq.b	.l_167e6
	movea.l	d0,a0
	jsr	(a0)
.l_167e6:
	jsr	Switch_screen
	tst.b	B_58aaa
	beq.b	.l_167cc
	tst.b	B_58aab
	bne.b	T_16800
T_167fc:
	bsr.w	T_18668
T_16800:
	movem.l	(a7)+,d0-d7/a0-a6
	rts
T_16806:
	tst.b	B_58aab
	beq.b	T_167fc
	clr.w	B_5891e
.l_16814:
	jsr	My_vsync
	movea.l	Off_screen,a6
	bsr.w	T_15f86
	jsr	Switch_screen
	cmpi.w	#$32,B_5891e
	blt.b	.l_16814
	bra.b	T_16800
Combat_DisExit:
	lea.l	Void,a1
	lea.l	Subfade1,a2
.l_16842:
	lea.l	D_2e082,a0
	jsr	Update_HBL
	jsr	My_vsync
	jsr	My_vsync
	lea.l	D_2e0a6,a0
	jsr	Fade_pal
	bne.b	.l_16842
	lea.l	D_2e082,a0
	jsr	Update_HBL
	rts
T_16876:
	move.w	Mouse_X,d0
	move.w	Mouse_Y,d1
	subi.w	#$d0,d0
	bmi.b	.l_168c6
	subi.w	#$30,d1
	bmi.b	.l_168c6
	lsr.w	#$4,d0
	lsr.w	#$4,d1
	cmpi.w	#$5,d0
	bgt.b	.l_168c6
	cmpi.w	#$3,d1
	blt.b	.l_168c6
	cmpi.w	#$4,d1
	bgt.b	.l_168c6
	mulu.w	#$6,d1
	add.w	d1,d0
	lsl.w	#$2,d0
	lea.l	B_58a0e,a0
	move.l	(a0,d0.w),d0
	beq.b	.l_168c6
	movea.l	d0,a0
	move.w	$8(a0),d0
	lsl.w	#$8,d0
	jsr	Member_left
.l_168c6:
	rts
Combat_DisUpd:
	lea.l	D_2dfce,a0
	lea.l	T_15d08,a1
	jsr	Update_control_icons
	tst.b	Monster_advantage
	beq.b	.l_168f6
	clr.b	Monster_advantage
	bsr.w	Monster_actions
	tst.b	B_58aac
	bne.w	.l_16a48
.l_168f6:
	tst.w	B_589da
	beq.b	.l_16908
	clr.w	B_589da
	bsr.w	Prepare_party_actions
.l_16908:
	movea.l	Off_screen,a6
	move.w	Active_member,d0
	cmp.w	B_5891c,d0
	beq.w	.l_16a48
	move.w	d0,B_5891c
	movea.l	Control_list_ptr,a5
	move.b	#$2,CIL_update
	andi.l	#$7f7f7f7f,(a5)
	andi.w	#$7f7f,$6(a5)
	andi.b	#$7f,$8(a5)
	move.w	Active_member,d0
	bsr.w	T_1642a
	move.w	d0,d2
	move.w	d1,d3
	movea.l	$2(a4),a4
	btst	#$2,$3b(a4)
	bne.b	.l_1696e
	btst	#$1,$3b(a4)
	bne.b	.l_1696e
	btst	#$3,$3b(a4)
	beq.b	.l_1698e
.l_1696e:
	bset	#$7,(a5)
	bset	#$7,$3(a5)
	bset	#$7,$6(a5)
	bset	#$7,$7(a5)
	bset	#$7,$8(a5)
	bra.w	.l_16a48
.l_1698e:
	btst	#$0,$3a(a4)
	beq.b	.l_169b0
	bset	#$7,(a5)
	bset	#$7,$3(a5)
	bset	#$7,$6(a5)
	bset	#$7,$7(a5)
	bra.w	.l_16a34
.l_169b0:
	moveq	#0,d6
	bsr.w	Get_move_targets
	tst.w	d0
	bpl.b	.l_169c0
	bset	#$7,$3(a5)
.l_169c0:
	clr.w	B_58958
	moveq	#0,d0
	move.b	$1f(a4),d0
	add.w	$96(a4),d0
	ble.b	.l_16a24
	tst.b	$25(a4)
	beq.b	.l_16a1a
	lea.l	$1aa(a4),a0
	cmpi.b	#$5,$1(a0)
	bne.b	.l_16a1a
	tst.b	$2(a0)
	beq.b	.l_16a06
	tst.b	$27(a4)
	beq.b	.l_16a24
	lea.l	$1fa(a4),a1
	cmpi.b	#$6,$1(a1)
	bne.b	.l_16a24
	move.b	$2(a0),d0
	cmp.b	$f(a1),d0
	bne.b	.l_16a24
.l_16a06:
	move.w	#$1,B_58958
	moveq	#0,d6
	bsr.w	Get_melee_targets
	tst.w	d0
	bpl.b	.l_16a2a
	bra.b	.l_16a24
.l_16a1a:
	moveq	#0,d6
	bsr.w	Get_melee_targets
	tst.w	d0
	bpl.b	.l_16a2a
.l_16a24:
	bset	#$7,$6(a5)
.l_16a2a:
	cmpi.w	#$4,d3
	beq.b	.l_16a34
	bset	#$7,(a5)
.l_16a34:
	btst	#$0,$3b(a4)
	bne.b	.l_16a42
	tst.b	$1a(a4)
	bne.b	.l_16a48
.l_16a42:
	bset	#$7,$8(a5)
.l_16a48:
	jsr	Update_status_block
	rts
T_16a50:
	tst.b	B_58aae
	beq.b	.l_16a62
	movea.l	Off_screen,a6
	bsr.w	T_15f8c
.l_16a62:
	rts
; Resets the actions for the next round and chooses the actions of members which can't act on their own.
Prepare_party_actions:
	lea.l	B_58924,a5
	moveq	#5,d7
.l_16a6c:
	move.w	(a5),d0
	beq.b	.l_16ab0
	cmpi.w	#$1,d0
	beq.b	.l_16aae
	cmpi.w	#$2,d0
	beq.b	.l_16ab0
	cmpi.w	#$3,d0
	beq.b	.l_16a90
	cmpi.w	#$4,d0
	beq.b	.l_16a8c
	clr.w	(a5)
	bra.b	.l_16ab0
.l_16a8c:
	clr.w	(a5)
	bra.b	.l_16ab0
.l_16a90:
	move.w	$2(a5),d0
	move.w	$4(a5),d1
	mulu.w	#$6,d1
	add.w	d1,d0
	lsl.w	#$2,d0
	lea.l	B_58a0e,a3
	tst.l	(a3,d0.w)
	beq.b	.l_16aae
	bra.b	.l_16ab0
.l_16aae:
	clr.w	(a5)
.l_16ab0:
	addq.l	#$8,a5
	dbra	d7,.l_16a6c
	lea.l	B_58924,a0
	lea.l	Chard_ptrs,a1
	moveq	#1,d5
	moveq	#5,d7
T_16ac6:
	move.l	(a1)+,d0
	beq.w	T_16b5e
	movea.l	d0,a2
	move.w	d5,d0
	bsr.w	T_1642a
	move.b	$3a(a2),d6
	move.b	$3b(a2),d4
	btst	#$2,d6
	bne.b	.l_16b00
	tst.w	d1
	beq.b	T_16b5e
	btst	#$0,d6
	bne.b	.l_16b0c
	btst	#$2,d4
	bne.b	T_16b5a
	btst	#$3,d4
	bne.b	Panic_action
	btst	#$1,d4
	bne.b	.l_16b06
	bra.b	T_16b5e
.l_16b00:
	move.w	#$7,(a0)
	bra.b	T_16b5e
.l_16b06:
	bsr.w	Mad_action
	bra.b	T_16b5e
.l_16b0c:
	move.w	#$6,(a0)
	bra.b	T_16b5e
; Panicking members flee from the back row or move back.
Panic_action:
	move.w	d5,d0
	bsr.w	T_1642a
	tst.w	d1
	beq.b	T_16b5e
	cmpi.w	#$4,d1
	beq.b	.l_16b54
	tst.l	$18(a3)
	beq.b	.l_16b44
	subq.w	#$1,d0
	bmi.b	.l_16b32
	tst.l	$14(a3)
	beq.b	.l_16b44
.l_16b32:
	addq.w	#$2,d0
	cmpi.w	#$6,d0
	beq.b	.l_16b40
	tst.l	$1c(a3)
	beq.b	.l_16b44
.l_16b40:
	clr.w	(a0)
	bra.b	T_16b5e
.l_16b44:
	move.w	#$1,(a0)
	move.w	d0,$2(a0)
	move.w	#$4,$4(a0)
	bra.b	T_16b5e
.l_16b54:
	move.w	#$2,(a0)
	bra.b	T_16b5e
T_16b5a:
	move.w	#$5,(a0)
T_16b5e:
	addq.l	#$8,a0
	dbra	d7,T_16ac6
T_16b64:
	movem.l	d0/d7/a0-a1,-(a7)
	tst.b	Battling
	beq.b	.l_16b8a
	lea.l	B_58924,a0
	lea.l	Char_status_icons,a1
	moveq	#5,d7
.l_16b7e:
	move.w	(a0),d0
	move.b	.l_16b90(pc,d0.w),(a1)+
	addq.l	#$8,a0
	dbra	d7,.l_16b7e
.l_16b8a:
	movem.l	(a7)+,d0/d7/a0-a1
	rts
.l_16b90:
	dc.b	$03,$06,$05,$02,$04,$11,$0a,$0c
; Mad members attack, flee or move randomly.
Mad_action:
	move.w	d5,d0
	bsr.w	T_1642a
	movea.l	$2(a4),a4
	move.w	d0,d2
	move.w	d1,d3
	jsr	Random
	lsr.w	#$1,d0
	ext.l	d0
	move.l	d0,d1
	divu.w	#$25,d0
	swap	d0
	btst	#$0,d0
	bne.b	T_16bf8
	cmpi.w	#$4,d3
	bne.b	.l_16bd0
	btst	#$2,d0
	bne.b	.l_16bd0
	move.w	#$2,(a0)
	rts
.l_16bd0:
	divu.w	#$5,d1
	swap	d1
	move.w	d1,d4
	moveq	#0,d6
.l_16bda:
	bsr.w	Get_move_targets
	tst.w	d0
	bmi.b	T_16bf4
	dbra	d4,.l_16bda
	move.w	#$1,(a0)
	move.w	d0,$2(a0)
	move.w	d1,$4(a0)
	rts
T_16bf4:
	clr.w	(a0)
	rts
T_16bf8:
	moveq	#0,d0
	move.b	$1f(a4),d0
	add.w	$96(a4),d0
	ble.b	T_16bf4
	tst.b	$25(a4)
	beq.b	.l_16c16
	lea.l	$1aa(a4),a2
	cmpi.b	#$5,$1(a2)
	beq.b	T_16bf4
.l_16c16:
	moveq	#0,d6
	bsr.w	Get_melee_targets
	tst.w	d0
	bmi.b	T_16bf4
	movea.l	a0,a2
	move.w	#$3,(a2)+
	move.w	d0,(a2)+
	move.w	d1,(a2)+
	clr.w	(a2)+
	rts
T_16c2e:
	tst.b	Monster_advantage
	bne.w	T_16cc0
	move.w	#$0,Draw_Cicon
	jsr	My_vsync
	move.w	Active_member,d0
	beq.b	T_16cc0
	jsr	Init_RText
	bsr.w	T_1642a
	movea.l	$2(a4),a4
	lea.l	$f0(a4),a0
	jsr	Add_ASCII_2_RText
	lea.l	D_2e438,a0
	jsr	Add_ASCII_2_RText
	lea.l	D_4a180,a1
	moveq	#0,d0
	jsr	Add_encoded_2_RText
	jsr	T_0707a
	jsr	Exit_RText
	jsr	Switch_screen
	jsr	Copy_screen
	move.l	#T_160ec,B_58920
	move.l	#T_16d38,B_58954
.l_16cac:
	btst	#$1,Mouse_button_state
	bne.b	.l_16cac
	lea.l	D_2d336,a0
	bsr.w	Push_Module
T_16cc0:
	rts
T_16cc2:
	sf.b	B_58aaa
	lea.l	T_16d98,a0
	jsr	Push_MA
	rts
T_16cd6:
	st.b	B_58aaa
	movea.l	Off_screen,a6
	jsr	Erase_text_window
	jsr	Switch_screen
	jsr	Copy_screen
	move.l	#Blink_markers,B_58920
	jsr	Pop_MA
	rts
T_16d06:
	move.w	Mouse_X,d0
	move.w	Mouse_Y,d1
	subi.w	#$d0,d0
	subi.w	#$30,d1
	lsr.w	#$4,d0
	lsr.w	#$4,d1
	cmpi.w	#$5,d0
	bgt.b	.l_16d36
	cmpi.w	#$4,d1
	bgt.b	.l_16d36
	move.w	d0,d4
	move.w	d1,d5
	movea.l	B_58954,a0
	jmp	(a0)
.l_16d36:
	rts
T_16d38:
	move.w	Active_member,d0
	beq.b	.l_16d88
	bsr.w	T_1642a
	move.w	d0,d2
	move.w	d1,d3
	cmp.w	d0,d4
	bne.b	.l_16d50
	cmp.w	d1,d5
	beq.b	.l_16d88
.l_16d50:
	moveq	#0,d6
.l_16d52:
	bsr.w	Get_move_targets
	tst.w	d0
	bmi.b	.l_16d8c
	cmp.w	d0,d4
	bne.b	.l_16d52
	cmp.w	d1,d5
	bne.b	.l_16d52
	move.w	Active_member,d0
	subq.w	#$1,d0
	lea.l	Char_status_icons,a0
	move.b	#$6,(a0,d0.w)
	lsl.w	#$3,d0
	lea.l	B_58924,a0
	adda.w	d0,a0
	move.w	#$1,(a0)+
	move.w	d4,(a0)+
	move.w	d5,(a0)+
.l_16d88:
	bsr.w	Pop_Module
.l_16d8c:
	btst	#$1,Mouse_button_state
	bne.b	.l_16d8c
	rts
T_16d98:
	dc.b	$00,$d0,$01,$2f,$00,$31,$00,$80
T_16da0:
	tst.b	Monster_advantage
	bne.w	T_16cc0
	move.w	#$0,Draw_Cicon
	jsr	My_vsync
	move.w	Active_member,d0
	beq.b	.l_16ddc
	subq.w	#$1,d0
	lea.l	Char_status_icons,a0
	move.b	#$5,(a0,d0.w)
	lsl.w	#$3,d0
	lea.l	B_58924,a0
	adda.w	d0,a0
	move.w	#$2,(a0)
.l_16ddc:
	rts
T_16dde:
	tst.b	Monster_advantage
	bne.w	T_16cc0
	move.w	#$0,Draw_Cicon
	jsr	My_vsync
	move.w	Active_member,d0
	beq.b	.l_16e48
	jsr	Init_RText
	bsr.w	T_1642a
	movea.l	$2(a4),a4
	lea.l	$f0(a4),a0
	jsr	Add_ASCII_2_RText
	lea.l	D_2e438,a0
	jsr	Add_ASCII_2_RText
	lea.l	D_4a180,a1
	moveq	#1,d0
	jsr	Add_encoded_2_RText
	jsr	T_0707a
	jsr	Exit_RText
	jsr	Switch_screen
	jsr	Copy_screen
.l_16e48:
	move.l	#T_1624a,B_58920
	move.l	#.l_16e72,B_58954
.l_16e5c:
	btst	#$1,Mouse_button_state
	bne.b	.l_16e5c
	lea.l	D_2d336,a0
	bsr.w	Push_Module
	rts
.l_16e72:
	move.w	Active_member,d0
	beq.b	.l_16ec8
	bsr.w	T_1642a
	move.w	d0,d2
	move.w	d1,d3
	cmp.w	d0,d4
	bne.b	.l_16e8a
	cmp.w	d1,d5
	beq.b	.l_16ec8
.l_16e8a:
	moveq	#0,d6
.l_16e8c:
	bsr.w	Get_melee_targets
	tst.w	d0
	bmi.b	.l_16ecc
	cmp.w	d0,d4
	bne.b	.l_16e8c
	cmp.w	d1,d5
	bne.b	.l_16e8c
	move.w	Active_member,d0
	subq.w	#$1,d0
	lea.l	Char_status_icons,a0
	move.b	#$2,(a0,d0.w)
	lsl.w	#$3,d0
	lea.l	B_58924,a0
	adda.w	d0,a0
	move.w	#$3,(a0)+
	move.w	d4,(a0)+
	move.w	d5,(a0)+
	move.w	B_58958,(a0)+
.l_16ec8:
	bsr.w	Pop_Module
.l_16ecc:
	btst	#$1,Mouse_button_state
	bne.b	.l_16ecc
	rts
T_16ed8:
	tst.b	Monster_advantage
	bne.w	T_16cc0
	move.w	#$0,Draw_Cicon
	jsr	My_vsync
	move.w	Active_member,d0
	beq.b	.l_16f12
	subq.w	#$1,d0
	lea.l	Char_status_icons,a0
	move.b	#$3,(a0,d0.w)
	lsl.w	#$3,d0
	lea.l	B_58924,a0
	adda.w	d0,a0
	clr.w	(a0)
.l_16f12:
	rts
T_16f14:
	tst.b	Monster_advantage
	bne.w	T_16cc0
	move.w	#$0,Draw_Cicon
	jsr	My_vsync
	bsr.w	T_13772
	bsr.w	T_16b64
	rts
; Chooses the actions of the monsters (before the party actions are added).
Monster_actions:
	tst.b	Monster_advantage
	bne.w	T_16cc0
	move.w	#$0,Draw_Cicon
	jsr	My_vsync
	clr.w	B_589e0
	lea.l	B_58a0e,a0
	moveq	#17,d7
.l_16f5c:
	move.l	(a0)+,d0
	beq.b	.l_16f66
	movea.l	d0,a1
	clr.w	$6(a1)
.l_16f66:
	dbra	d7,.l_16f5c
	bsr.w	Choose_particle_path
	movea.l	Off_screen,a6
	move.l	B_58920,-(a7)
	clr.l	B_58920
	bsr.w	T_15f8c
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	B_589c2,a0
	bsr.w	T_15d6c
	lea.l	B_58a3e,a0
	moveq	#5,d7
.l_16fa2:
	tst.l	(a0)+
	bne.b	.l_16fb2
	dbra	d7,.l_16fa2
	move.w	#$ffff,B_589d4
.l_16fb2:
	clr.l	B_58962
	move.l	#$2d0,d0
	jsr	Allocate_memory
	move.l	a1,B_5895a
	lea.l	$f0(a1),a5
	movea.l	a1,a4
	lea.l	B_58a0e,a1
	moveq	#0,d6
	moveq	#0,d4
	moveq	#0,d5
	moveq	#17,d7
; Morale, retreat, advance, spells and attacks of a monster.
Choose_monster_action:
	clr.w	B_589de
	move.l	(a1)+,d0
	beq.w	T_17256
	movea.l	d0,a2
	movea.l	$2(a2),a3
	moveq	#0,d0
	moveq	#0,d1
	move.w	$4e(a3),d0
	move.w	$a2(a3),d1
	add.l	d1,d0
	move.l	d0,(a4)+
	move.l	a5,(a4)+
	move.b	#$1,(a5)+
	clr.b	(a5)+
	move.b	d4,(a5)+
	move.b	d5,(a5)+
	movea.l	a5,a0
	addq.l	#$8,a5
	tst.b	Party_advantage
	bne.w	T_1724e
	btst	#$0,$2e(a2)
	bne.w	Monster_attack
	btst	#$2,$2f(a2)
	bne.w	T_1724e
	btst	#$3,$2f(a2)
	bne.b	Monster_retreat
	movem.l	a0-a1,-(a7)
	movea.l	a3,a1
	lea.l	B_589b0,a0
	bsr.w	T_15daa
	move.w	d0,d1
	lea.l	B_589c2,a0
	bsr.w	T_15daa
	movem.l	(a7)+,a0-a1
	moveq	#0,d2
	move.b	$41(a3),d2
	mulu.w	#$64,d0
	divu.w	d1,d0
	neg.w	d0
	addi.w	#$64,d0
	cmp.w	d0,d2
	bgt.b	T_17088
; Monsters flee from the back row and move back otherwise.
Monster_retreat:
	move.w	#$ffff,B_589de
	tst.w	d5
	bne.b	.l_17080
	move.w	#$2,(a0)+
	bra.w	T_17252
.l_17080:
	move.w	d4,d0
	move.w	d5,d1
	subq.w	#$1,d1
	bra.b	Monster_move_to_row
T_17088:
	move.w	d5,d1
	moveq	#2,d0
	tst.w	B_589d4
	bne.b	.l_1709a
	sub.b	$42(a3),d0
	ext.w	d0
.l_1709a:
	sub.w	d5,d0
	beq.b	Monster_attack
	bmi.b	.l_170a4
	addq.w	#$1,d1
	bra.b	.l_170a6
.l_170a4:
	subq.w	#$1,d1
.l_170a6:
	move.w	d4,d0
; The monster moves to a row: to the same column or one beside it.
Monster_move_to_row:
	lea.l	B_58a0e,a6
	move.w	d1,d2
	mulu.w	#$6,d2
	add.w	d0,d2
	lsl.w	#$2,d2
	adda.w	d2,a6
	tst.l	(a6)
	beq.b	.l_170d6
	subq.w	#$1,d0
	bmi.b	.l_170c8
	tst.l	-$4(a6)
	beq.b	.l_170d6
.l_170c8:
	addq.w	#$2,d0
	cmpi.w	#$6,d0
	beq.b	.l_170ee
	tst.l	$4(a6)
	bne.b	.l_170ee
.l_170d6:
	lea.l	B_58962,a6
	bset	d0,(a6,d1.w)
	bne.b	.l_170ee
	move.w	#$1,(a0)+
	move.w	d0,(a0)+
	move.w	d1,(a0)+
	bra.w	T_17252
.l_170ee:
	tst.w	B_589de
	bne.w	T_17248
; Spells, ranged attacks or melee attacks of a monster.
Monster_attack:
	btst	#$0,$2f(a2)
	bne.b	.l_1714a
	move.w	B_589dc,d0
	cmpi.w	#$19,d0
	bge.b	.l_1714a
	jsr	Random
	lsr.w	#$1,d0
	ext.l	d0
	divu.w	#$19,d0
	swap	d0
	lea.l	$100(a3),a6
	adda.w	d0,a6
	moveq	#0,d2
	move.b	(a6),d2
	beq.b	.l_1714a
	moveq	#0,d3
	move.b	$19(a6),d3
	moveq	#0,d0
	move.b	$3f(a3),d0
	jsr	Probe
	bmi.b	.l_1714a
	move.w	#$4,(a0)+
	move.w	d2,(a0)+
	move.w	d3,(a0)+
	clr.w	(a0)+
	bra.w	T_17252
.l_1714a:
	btst	#$0,$2e(a2)
	bne.w	T_1724e
	move.l	a1,-(a7)
	tst.b	$1b(a2)
	beq.b	.l_171a0
	lea.l	$b0(a2),a6
	cmpi.b	#$5,$1(a6)
	bne.b	.l_171a0
	tst.b	$1d(a2)
	beq.b	.l_1719a
	lea.l	$100(a2),a1
	cmpi.b	#$6,$1(a1)
	bne.b	.l_1719a
	move.b	$2(a6),d0
	cmp.b	$f(a1),d0
	bne.b	.l_1719a
	bsr.w	Random_party_target
	move.w	#$3,(a0)+
	move.w	d0,(a0)+
	move.w	d1,(a0)+
	move.w	#$1,(a0)+
	movea.l	(a7)+,a1
	bra.w	T_17252
.l_1719a:
	movea.l	(a7)+,a1
	bra.w	Monster_retreat
.l_171a0:
	movea.l	(a7)+,a1
	cmpi.w	#$2,d5
	bne.w	T_17248
	move.w	d4,d0
	move.w	d5,d1
	addq.w	#$1,d1
	move.w	d1,d2
	mulu.w	#$6,d2
	add.w	d0,d2
	lsl.w	#$2,d2
	lea.l	B_58a0e,a6
	adda.w	d2,a6
	tst.l	(a6)
	bne.b	.l_1723c
	subq.w	#$1,d0
	bmi.b	.l_171d0
	tst.l	-$4(a6)
	bne.b	.l_1723c
.l_171d0:
	addq.w	#$2,d0
	cmpi.w	#$6,d0
	beq.b	.l_171de
	tst.l	$4(a6)
	bne.b	.l_1723c
.l_171de:
	move.l	a6,-(a7)
	move.w	d4,d0
	beq.b	.l_17206
	subq.w	#$1,d0
.l_171e6:
	tst.l	-(a6)
	bne.b	.l_171f0
	dbra	d0,.l_171e6
	bra.b	.l_17206
.l_171f0:
	move.w	d4,d0
	subq.w	#$1,d0
	tst.l	-$8(a1)
	bne.b	.l_17206
	lea.l	B_58962,a6
	bset	d0,(a6,d5.w)
	beq.b	.l_17230
.l_17206:
	movea.l	(a7)+,a6
	moveq	#4,d0
	sub.w	d4,d0
	bmi.b	T_17248
	addq.l	#$4,a6
.l_17210:
	tst.l	(a6)+
	bne.b	.l_1721a
	dbra	d0,.l_17210
	bra.b	T_17248
.l_1721a:
	move.w	d4,d0
	addq.w	#$1,d0
	tst.l	(a1)
	bne.b	T_17248
	lea.l	B_58962,a6
	bset	d0,(a6,d5.w)
	beq.b	.l_17232
	bra.b	T_17248
.l_17230:
	movea.l	(a7)+,a6
.l_17232:
	move.w	#$1,(a0)+
	move.w	d0,(a0)+
	move.w	d5,(a0)+
	bra.b	T_17252
.l_1723c:
	move.w	#$3,(a0)+
	move.w	d0,(a0)+
	move.w	d1,(a0)+
	clr.w	(a0)+
	bra.b	T_17252
T_17248:
	move.w	#$0,(a0)+
	bra.b	T_17252
T_1724e:
	move.w	#$5,(a0)+
T_17252:
	move.l	a3,(a5)+
	addq.w	#$1,d6
T_17256:
	addq.w	#$1,d4
	cmpi.w	#$6,d4
	bne.b	.l_17262
	moveq	#0,d4
	addq.w	#$1,d5
.l_17262:
	dbra	d7,Choose_monster_action
	clr.b	Party_advantage
	lea.l	B_58924,a0
	moveq	#11,d7
.l_17274:
	move.l	(a1)+,d0
	beq.b	.l_172ac
	movea.l	d0,a2
	movea.l	$2(a2),a3
	moveq	#0,d0
	moveq	#0,d1
	move.w	$4e(a3),d0
	move.w	$a2(a3),d1
	add.l	d1,d0
	move.l	d0,(a4)+
	move.l	a5,(a4)+
	move.w	$8(a2),d0
	clr.b	(a5)+
	move.b	d0,(a5)+
	move.b	d4,(a5)+
	move.b	d5,(a5)+
	subq.w	#$1,d0
	lsl.w	#$3,d0
	move.l	(a0,d0.w),(a5)+
	move.l	$4(a0,d0.w),(a5)+
	move.l	a3,(a5)+
	addq.w	#$1,d6
.l_172ac:
	addq.w	#$1,d4
	cmpi.w	#$6,d4
	bne.b	.l_172b8
	moveq	#0,d4
	addq.w	#$1,d5
.l_172b8:
	dbra	d7,.l_17274
	move.w	d6,B_5895e
	move.w	d6,-(a7)
	movea.l	B_5895a,a0
	move.w	d6,d7
	cmpi.w	#$1,d7
	ble.b	.l_172d6
	bsr.w	Sort_action_list
.l_172d6:
	move.w	(a7)+,d6
	movea.l	Off_screen,a6
	subq.w	#$1,d6
	move.w	d6,d0
	lsl.w	#$3,d0
	movea.l	B_5895a,a5
	adda.w	d0,a5
	sf.b	B_58aac
; Executes the actions of a round, the fastest participant first.
Execute_round:
	movem.l	d6/a4-a5,-(a7)
	bsr.w	Choose_particle_path
	movea.l	$4(a5),a4
	moveq	#0,d0
	moveq	#0,d1
	move.b	$2(a4),d0
	move.b	$3(a4),d1
	mulu.w	#$6,d1
	add.w	d1,d0
	lsl.w	#$2,d0
	lea.l	B_58a0e,a0
	adda.w	d0,a0
	tst.l	(a0)
	beq.b	Remove_dead_participants
	tst.b	(a4)
	beq.b	.l_1732e
	movea.l	(a0),a0
	move.b	$2e(a0),d0
	move.b	$2f(a0),d1
	bra.b	Set_success_factor
.l_1732e:
	movea.l	$c(a4),a0
	move.b	$3a(a0),d0
	move.b	$3b(a0),d1
; Diseases, irritation and blindness lower the chance to hit.
Set_success_factor:
	moveq	#100,d2
	btst	#$3,d0
	beq.b	.l_17344
	lsr.w	#$1,d2
.l_17344:
	btst	#$0,d1
	beq.b	.l_17352
	mulu.w	#$4b,d2
	divu.w	#$64,d2
.l_17352:
	btst	#$4,d1
	beq.b	.l_1735a
	lsr.w	#$2,d2
.l_1735a:
	move.w	d2,B_589d8
	move.w	$4(a4),d2
	lsl.w	#$2,d2
	lea.l	T_175fc(pc),a0
	movea.l	(a0,d2.w),a0
	jsr	(a0)
	tst.w	d0
	bne.b	Remove_dead_participants
	bsr.w	T_17b08
	movea.l	Off_screen,a6
	jsr	Erase_text_window
	jsr	Switch_screen
	jsr	Copy_screen
; Dead monsters and dead or petrified party members leave the battle field.
Remove_dead_participants:
	lea.l	B_58a0e,a0
	moveq	#17,d7
.l_17398:
	move.l	(a0)+,d0
	beq.b	.l_173d0
	movea.l	d0,a1
	btst	#$5,$2e(a1)
	beq.b	.l_173d0
	clr.l	-$4(a0)
	movea.l	$2(a1),a2
	move.w	B_58966,d0
	lea.l	B_58968,a3
	lsl.w	#$2,d0
	move.l	a1,(a3,d0.w)
	addq.w	#$1,B_58966
	move.w	$c6(a2),d0
	add.w	d0,B_589d6
.l_173d0:
	dbra	d7,.l_17398
	lea.l	B_58924,a3
	moveq	#11,d7
.l_173dc:
	move.l	(a0)+,d0
	beq.b	.l_17416
	movea.l	d0,a1
	movea.l	$2(a1),a2
	btst	#$2,$3a(a2)
	beq.b	.l_1740a
	clr.l	-$4(a0)
	move.w	$8(a1),d0
	lsl.w	#$3,d0
	move.w	#$7,(a3,d0.w)
	bsr.w	T_16b64
	bset	#$7,$3b(a2)
	bra.b	.l_17416
.l_1740a:
	btst	#$5,$3a(a2)
	beq.b	.l_17416
	clr.l	-$4(a0)
.l_17416:
	dbra	d7,.l_173dc
	movea.l	Current_active_char_data,a0
	move.w	$3a(a0),d0
	andi.w	#$e480,d0
	beq.b	Check_party_left
	jsr	Check_party_alive
; The battle ends if no party member is left on the battle field.
Check_party_left:
	lea.l	B_589c2,a0
	bsr.w	T_15d6c
	moveq	#2,d7
	moveq	#0,d0
.l_1743e:
	tst.l	(a0)
	beq.b	.l_17446
	add.w	$4(a0),d0
.l_17446:
	addq.l	#$6,a0
	dbra	d7,.l_1743e
	tst.w	d0
	bne.b	.l_1745a
	bsr.w	Pop_Module
	st.b	B_58aac
.l_1745a:
	movem.l	(a7)+,d6/a4-a5
	subq.l	#$8,a5
	tst.b	B_58aac
	bne.b	.l_17488
	dbra	d6,Execute_round
	addq.w	#$1,B_589dc
	movea.l	Off_screen,a6
	bsr.w	T_15f8c
	jsr	Switch_screen
	jsr	Copy_screen
.l_17488:
	movea.l	B_5895a,a0
	jsr	Free_memory
	move.w	#$ffff,B_589e0
	move.l	(a7)+,B_58920
.l_174a2:
	btst	#$1,Mouse_button_state
	bne.b	.l_174a2
	clr.w	B_5891c
	move.w	#$1,B_589da
; Moves are not kept. If the front row of the party is empty, the back row moves to the front.
End_of_round:
	lea.l	B_58924,a0
	moveq	#5,d7
.l_174c2:
	cmpi.w	#$1,(a0)
	bne.b	.l_174ca
	clr.w	(a0)
.l_174ca:
	addq.l	#$8,a0
	dbra	d7,.l_174c2
	tst.b	B_58aac
	bne.w	.l_17568
	lea.l	B_58a56,a0
	moveq	#5,d7
.l_174e2:
	tst.l	(a0)+
	bne.b	.l_1755e
	dbra	d7,.l_174e2
	moveq	#5,d7
	moveq	#0,d6
.l_174ee:
	tst.l	(a0)+
	beq.b	.l_174f4
	addq.w	#$1,d6
.l_174f4:
	dbra	d7,.l_174ee
	cmpi.w	#$1,d6
	bgt.b	.l_17506
	tst.b	B_58aad
	beq.b	.l_17556
.l_17506:
	lea.l	B_58a56,a0
	lea.l	$18(a0),a1
	moveq	#5,d7
.l_17512:
	move.l	(a1),(a0)+
	clr.l	(a1)+
	dbra	d7,.l_17512
	movea.l	Off_screen,a6
	jsr	Init_RText
	lea.l	D_4a180,a1
	moveq	#11,d0
	jsr	Add_encoded_2_RText
	jsr	T_0707a
	jsr	Exit_RText
	bsr.w	T_15f8c
	jsr	Switch_screen
	jsr	Copy_screen
	bsr.w	T_18668
	bra.b	.l_1755e
.l_17556:
	st.b	B_58aad
	bra.b	.l_17564
.l_1755e:
	sf.b	B_58aad
.l_17564:
	bsr.w	.l_1756a
.l_17568:
	rts
.l_1756a:
	movem.l	d0-d3/d6-d7/a0-a1/a6,-(a7)
	lea.l	D_33a60,a0
	lea.l	Spell_1_duration,a1
	movea.l	Off_screen,a6
	move.w	#$10,d0
	move.w	#$b1,d1
	move.w	#$bf,d2
	move.w	#$c0,d3
	moveq	#2,d6
	jsr	Draw_box
	moveq	#5,d7
.l_1759a:
	tst.w	(a1)+
	beq.b	.l_175a4
	jsr	Put_unmasked_block
.l_175a4:
	addi.w	#$10,d0
	lea.l	$80(a0),a0
	dbra	d7,.l_1759a
	jsr	Switch_screen
	jsr	Copy_screen
	movem.l	(a7)+,d0-d3/d6-d7/a0-a1/a6
	rts
; A random cell of a party member.
Random_party_target:
	jsr	Random
	lea.l	B_58a56,a1
.l_175ce:
	andi.l	#$fff,d0
	divu.w	#$c,d0
	swap	d0
	move.w	d0,d1
	lsl.w	#$2,d1
	tst.l	(a1,d1.w)
	bne.b	.l_175e8
	addq.w	#$1,d0
	bra.b	.l_175ce
.l_175e8:
	adda.w	d1,a1
	andi.l	#$fff,d0
	divu.w	#$6,d0
	move.w	d0,d1
	swap	d0
	addq.w	#$3,d1
	rts
T_175fc:
	dc.l	.l_1761c
	dc.l	T_17624
	dc.l	Flee
	dc.l	Execute_attacks
	dc.l	T_17b2a
	dc.l	T_17620
	dc.l	T_17620
	dc.l	T_17620
.l_1761c:
	moveq	#-1,d0
	rts
T_17620:
	moveq	#-1,d0
	rts
T_17624:
	btst	#$0,d0
	bne.b	T_17620
	btst	#$2,d1
	bne.b	T_17620
	moveq	#0,d0
	moveq	#0,d1
	move.b	$2(a4),d0
	move.b	$3(a4),d1
	mulu.w	#$6,d1
	add.w	d1,d0
	lsl.w	#$2,d0
	move.w	$6(a4),d2
	move.w	$8(a4),d3
	mulu.w	#$6,d3
	add.w	d3,d2
	lsl.w	#$2,d2
	lea.l	B_58a0e,a1
	tst.l	(a1,d2.w)
	beq.b	.l_1766e
	lea.l	D_2f0af,a1
	jsr	DI_Error
	bra.b	.l_17684
.l_1766e:
	dc.b	$23,$b1,$00,$00,$20,$00,$42,$b1,$00,$00,$2c,$79
	dc.l	Off_screen
	dc.b	$70,$04,$61,$00,$0a,$f4
.l_17684:
	moveq	#0,d0
	rts
; Dexterity and luck against a random value below 150.
Flee:
	btst	#$0,d0
	bne.b	T_17620
	btst	#$2,d1
	bne.b	T_17620
	movea.l	$c(a4),a0
	move.w	$4c(a0),d0
	add.w	$a0(a0),d0
	add.w	$54(a0),d0
	add.w	$a8(a0),d0
	mulu.w	B_589d8,d2
	divu.w	#$64,d2
	tst.w	d0
	bmi.b	.l_17722
	cmpi.w	#$96,d0
	bpl.b	.l_176d2
	move.w	d0,d1
	jsr	Random
	lsr.w	#$1,d0
	ext.l	d0
	divu.w	#$96,d0
	swap	d0
	cmp.w	d0,d1
	bmi.b	.l_17722
.l_176d2:
	moveq	#0,d0
	moveq	#0,d1
	move.b	$2(a4),d0
	move.b	$3(a4),d1
	mulu.w	#$6,d1
	add.w	d1,d0
	lsl.w	#$2,d0
	lea.l	B_58a0e,a1
	adda.w	d0,a1
	movea.l	(a1),a2
	tst.b	(a4)
	beq.b	.l_17706
	move.w	$c6(a0),d0
	add.w	d0,B_589d6
	bset	#$7,$2f(a2)
	bra.b	.l_17712
.l_17706:
	dc.b	$08,$e8,$00,$07,$00,$3b,$52,$79
	dc.l	B_58ab0
.l_17712:
	clr.l	(a1)
	movea.l	Off_screen,a6
	moveq	#5,d0
	bsr.w	T_18176
	bra.b	.l_1772e
.l_17722:
	dc.b	$2c,$79
	dc.l	Off_screen
	dc.b	$70,$06,$61,$00,$0a,$4a
.l_1772e:
	moveq	#0,d0
	rts
; Executes the attacks of a participant (attacks per round, doubled by haste).
Execute_attacks:
	btst	#$0,d0
	bne.w	T_17620
	btst	#$3,d1
	bne.w	T_17620
	btst	#$2,d1
	bne.w	T_17620
	movea.l	Off_screen,a6
	move.w	$6(a4),d0
	move.w	$8(a4),d1
	move.w	d1,d2
	mulu.w	#$6,d2
	add.w	d0,d2
	lsl.w	#$2,d2
	lea.l	B_58a0e,a1
	tst.l	(a1,d2.w)
	beq.w	T_17a08
	bsr.w	T_18242
	movea.l	a0,a5
	movea.l	$c(a4),a0
	movea.l	$c(a5),a1
	moveq	#0,d0
	move.b	$43(a0),d0
	bne.b	.l_1779c
	movem.l	a0-a1,-(a7)
	lea.l	D_2f0d7,a1
	jsr	DI_Error
	movem.l	(a7)+,a0-a1
	moveq	#1,d0
.l_1779c:
	tst.b	(a4)
	bne.b	.l_177ae
	move.b	$1(a4),d1
	bclr	d1,B_58831
	beq.b	.l_177ae
	add.w	d0,d0
.l_177ae:
	move.w	d0,B_58960
	move.b	$20(a0),d0
	cmp.b	$40(a1),d0
	blt.w	T_179ac
	bra.b	Attack_once
T_177c2:
	dc.b	$61,$00,$03,$44,$2c,$79
	dc.l	Off_screen
	dc.b	$4e,$b9
	dc.l	Erase_text_window
	dc.b	$4e,$b9
	dc.l	Switch_screen
	dc.b	$4e,$b9
	dc.l	Copy_screen
; One attack: hit, parry, damage and the ammunition of ranged weapons.
Attack_once:
	tst.b	(a4)
	beq.b	.l_177e6
	bsr.w	Start_attack_animation
.l_177e6:
	moveq	#0,d0
	move.b	$6(a0),d0
	add.w	$b0(a0),d0
	tst.b	(a4)
	bne.b	.l_177fc
	add.w	Spell_3_data,d0
	lsr.w	#$1,d0
.l_177fc:
	add.w	d0,d0
	jsr	T_07c70
	bmi.w	T_179c2
	tst.w	$4(a5)
	bne.b	.l_1782c
	moveq	#0,d0
	move.b	$7(a1),d0
	add.w	$b2(a1),d0
	tst.b	(a5)
	bne.b	.l_17822
	add.w	Spell_2_data,d0
.l_17822:
	jsr	Probe
	bpl.w	T_179d8
.l_1782c:
	moveq	#0,d0
	move.b	$1f(a0),d0
	add.w	$96(a0),d0
	move.w	$48(a0),d2
	add.w	$9c(a0),d2
	ext.l	d2
	divs.w	#$19,d2
	add.w	d0,d2
	jsr	Random
	lsr.w	#$1,d0
	ext.l	d0
	divu.w	d2,d0
	swap	d0
	move.w	d0,d4
	moveq	#0,d0
	move.b	$1e(a1),d0
	add.w	$94(a1),d0
	moveq	#0,d2
	move.b	$21(a1),d2
	add.w	d2,d0
	move.w	$50(a1),d2
	add.w	$a4(a1),d2
	ext.l	d2
	divs.w	#$19,d2
	add.w	d0,d2
	jsr	Random
	lsr.w	#$1,d0
	ext.l	d0
	divu.w	d2,d0
	swap	d0
	sub.w	d0,d4
	ble.w	T_179f2
	movem.l	a0-a1,-(a7)
	jsr	Init_RText
	lea.l	$f0(a0),a0
	jsr	Add_ASCII_2_RText
	lea.l	D_2e432,a0
	jsr	Add_ASCII_2_RText
	lea.l	D_4a180,a1
	moveq	#2,d0
	jsr	Add_encoded_2_RText
	movem.l	(a7),a0-a1
	lea.l	$f0(a1),a0
	jsr	Add_ASCII_2_RText
	lea.l	D_2e432,a0
	jsr	Add_ASCII_2_RText
	lea.l	D_4a180,a1
	moveq	#3,d0
	jsr	Add_encoded_2_RText
	lea.l	D_2e432,a0
	jsr	Add_ASCII_2_RText
	move.w	d4,d0
	moveq	#4,d7
	lea.l	Number_buffer,a0
	movea.l	a0,a3
	bsr.w	LConvert_number
	move.b	#$20,(a3)+
	clr.b	(a3)
	jsr	Add_ASCII_2_RText
	lea.l	D_4a180,a1
	moveq	#9,d0
	jsr	Add_encoded_2_RText
	jsr	T_0707a
	jsr	Exit_RText
	movem.l	(a7)+,a0-a1
	tst.b	(a5)
	bne.b	.l_1796e
	bclr	#$2,$3b(a1)
	moveq	#0,d0
	move.b	$1(a5),d0
	move.w	d4,d1
	bsr.w	T_160ce
	jsr	Do_damage
	tst.w	$86(a1)
	bgt.w	T_17a22
	moveq	#0,d0
	moveq	#0,d1
	move.b	$2(a5),d0
	move.b	$3(a5),d1
	mulu.w	#$6,d1
	add.w	d1,d0
	lsl.w	#$2,d0
	lea.l	B_58a0e,a2
	adda.w	d0,a2
	clr.l	(a2)
	bra.w	T_17a1a
.l_1796e:
	moveq	#0,d0
	moveq	#0,d1
	move.b	$2(a5),d0
	move.b	$3(a5),d1
	mulu.w	#$6,d1
	add.w	d1,d0
	lsl.w	#$2,d0
	lea.l	B_58a0e,a2
	adda.w	d0,a2
	movea.l	(a2),a3
	bclr	#$2,$2f(a3)
	move.w	d4,$12(a3)
	move.w	#$64,$10(a3)
	sub.w	d4,$30(a3)
	bgt.w	T_17a22
	bset	#$5,$2e(a3)
	bra.b	T_17a1a
T_179ac:
	movem.l	a0-a1,-(a7)
	lea.l	Code0004Sys,a0
	moveq	#4,d0
	bsr.w	T_181b8
	movem.l	(a7)+,a0-a1
	bra.b	T_17a1a
T_179c2:
	movem.l	a0-a1,-(a7)
	lea.l	Code0004Sys,a0
	moveq	#0,d0
	bsr.w	T_181b8
	movem.l	(a7)+,a0-a1
	bra.b	T_17a22
T_179d8:
	movem.l	a0-a1,-(a7)
	exg.l	a5,a4
	lea.l	Code0004Sys,a0
	moveq	#1,d0
	bsr.w	T_181b8
	exg.l	a5,a4
	movem.l	(a7)+,a0-a1
	bra.b	T_17a22
T_179f2:
	movem.l	a0-a1,-(a7)
	lea.l	Code0004Sys,a0
	moveq	#3,d0
	bsr.w	T_181b8
	movem.l	(a7)+,a0-a1
	bra.b	T_17a22
T_17a08:
	dc.b	$20,$6c,$00,$0c,$48,$e7,$00,$c0,$70,$08,$61,$00,$07,$62,$4c,$df
	dc.b	$03,$00
T_17a1a:
	move.w	#$1,B_58960
T_17a22:
	tst.w	$a(a4)
	beq.w	.l_17afa
	tst.b	(a4)
	beq.b	.l_17a88
	moveq	#0,d0
	move.b	$2(a4),d0
	moveq	#0,d1
	move.b	$3(a4),d1
	mulu.w	#$6,d1
	add.w	d1,d0
	lsl.w	#$2,d0
	lea.l	B_58a0e,a6
	movea.l	(a6,d0.w),a6
	lea.l	$b0(a6),a3
	move.b	$2(a3),d0
	beq.w	.l_17afa
	clr.b	$1d(a6)
	lea.l	$21(a6),a2
	lea.l	$1a0(a6),a3
	moveq	#11,d7
.l_17a66:
	tst.b	(a2)
	beq.b	.l_17a7c
	cmp.b	$f(a3),d0
	bne.b	.l_17a7c
	subq.b	#$1,(a2)
	move.b	#$1,$1d(a6)
	bra.w	.l_17afa
.l_17a7c:
	addq.l	#$1,a2
	lea.l	$28(a3),a3
	dbra	d7,.l_17a66
	bra.b	.l_17af2
.l_17a88:
	lea.l	$1aa(a0),a3
	tst.b	$2(a3)
	beq.b	.l_17afa
	clr.b	$27(a0)
	lea.l	$1fa(a0),a3
	moveq	#0,d0
	move.w	$22(a3),d0
	sub.l	d0,$ec(a0)
	subq.b	#$1,$1c(a0)
	lea.l	$1aa(a0),a3
	move.b	$2(a3),d0
	lea.l	$2b(a0),a2
	lea.l	$29a(a0),a3
	moveq	#1,d1
	moveq	#11,d7
	tst.b	(a2)
	beq.b	.l_17ad4
	cmp.b	$f(a3),d0
	bne.b	.l_17ad4
	subq.b	#$1,(a2)
	move.b	#$1,$27(a0)
	addq.b	#$1,$1c(a0)
	bra.b	.l_17afa
.l_17ad4:
	dc.b	$52,$8a,$47,$eb,$00,$28,$52,$41,$51,$cf,$ff,$de,$45,$f9
	dc.l	B_58924
	dc.b	$70,$00,$10,$2c,$00,$01,$e7,$48,$42,$72,$00,$f8
.l_17af2:
	dc.b	$33,$fc,$00,$01
	dc.l	B_58960
.l_17afa:
	subq.w	#$1,B_58960
	bne.w	T_177c2
	moveq	#0,d0
	rts
T_17b08:
	movea.l	Off_screen,a6
	bsr.w	T_15f8c
	jsr	Update_status_block
	jsr	Switch_screen
	jsr	Copy_screen
	bsr.w	Wait_for_animation
	rts
T_17b2a:
	btst	#$0,d1
	bne.w	T_17620
	btst	#$3,d1
	bne.w	T_17620
	btst	#$2,d1
	bne.w	T_17620
; A spell of a participant or of an item.
Execute_spell_action:
	tst.b	(a4)
	bne.w	T_17cd6
	tst.w	$6(a4)
	bpl.b	.l_17b92
	movem.l	d0/a0,-(a7)
	movea.l	$c(a4),a0
	move.l	a0,B_5880e
	move.w	$8(a4),d0
	move.w	d0,B_5880c
	lea.l	$10a(a0),a0
	mulu.w	#$28,d0
	adda.w	d0,a0
	moveq	#0,d0
	move.b	$c(a0),d0
	move.w	d0,Selected_class
	move.b	$d(a0),d0
	move.w	d0,Selected_spell
	st.b	Magic_object_flag
	movem.l	(a7)+,d0/a0
	bra.b	Show_spell_result
.l_17b92:
	dc.b	$33,$ec,$00,$06
	dc.l	Selected_class
	dc.b	$33,$ec,$00,$08
	dc.l	Selected_spell
; The name of the spell is shown first, the result after the effects of the spell.
Show_spell_result:
	jsr	Init_RText
	movea.l	$c(a4),a0
	lea.l	$f0(a0),a0
	jsr	Add_ASCII_2_RText
	lea.l	Space,a0
	jsr	Add_ASCII_2_RText
	move.w	#$d,d0
	lea.l	Code0004Sys,a1
	jsr	Add_encoded_2_RText
	lea.l	D_48876,a1
	move.w	Selected_class,d0
	subq.w	#$1,d0
	mulu.w	#$3c,d0
	adda.w	d0,a1
	move.w	Selected_spell,d0
	add.w	d0,d0
	move.w	-$2(a1,d0.w),d0
	jsr	Find_word
	lea.l	Number_buffer,a1
	moveq	#0,d0
	move.b	(a0)+,d0
	subq.w	#$1,d0
	bra.b	T_17c08
T_17c06:
	dc.b	$12,$d8
T_17c08:
	dbra	d0,T_17c06
	move.b	#$20,(a1)+
	clr.b	(a1)
	lea.l	Number_buffer,a0
	jsr	Add_ASCII_2_RText
	jsr	T_0707a
	jsr	Exit_RText
	jsr	Switch_screen
	jsr	Copy_screen
	bsr.w	T_18668
	moveq	#0,d0
	move.b	$1(a4),d0
	move.w	d0,B_58ab8
	bsr.w	Cast_combat_spell
	sf.b	Magic_object_flag
	tst.b	B_5882f
	bmi.b	.l_17c96
	jsr	Init_RText
	movea.l	$c(a4),a0
	lea.l	$f0(a0),a0
	jsr	Add_ASCII_2_RText
	lea.l	Space,a0
	jsr	Add_ASCII_2_RText
	move.w	#$5,d0
	lea.l	Code0004Sys,a1
	jsr	Add_encoded_2_RText
	jsr	T_0707a
	jsr	Exit_RText
	bra.b	.l_17cd2
.l_17c96:
	dc.b	$4e,$b9
	dc.l	Init_RText
	dc.b	$20,$6c,$00,$0c,$41,$e8,$00,$f0,$4e,$b9
	dc.l	Add_ASCII_2_RText
	dc.b	$41,$f9
	dc.l	Space
	dc.b	$4e,$b9
	dc.l	Add_ASCII_2_RText
	dc.b	$30,$3c,$00,$06,$43,$f9
	dc.l	Code0004Sys
	dc.b	$4e,$b9
	dc.l	Add_encoded_2_RText
	dc.b	$4e,$b9
	dc.l	T_0707a
	dc.b	$4e,$b9
	dc.l	Exit_RText
.l_17cd2:
	moveq	#0,d0
	rts
T_17cd6:
	moveq	#0,d0
	moveq	#0,d1
	move.b	$2(a4),d0
	move.b	$3(a4),d1
	mulu.w	#$6,d1
	add.w	d1,d0
	lsl.w	#$2,d0
	lea.l	B_58a0e,a5
	movea.l	(a5,d0.w),a5
	movea.l	$c(a4),a3
	bsr.w	Start_attack_animation
	move.w	$6(a4),Selected_class
	move.w	$8(a4),Selected_spell
	move.l	a3,B_58abe
	move.l	a5,B_58ac2
	moveq	#10,d0
	bsr.w	T_18176
	jsr	Switch_screen
	jsr	Copy_screen
	bsr.w	T_18668
	st.b	B_58ab7
	bsr.w	Cast_combat_spell
	sf.b	B_58ab7
	moveq	#0,d0
	rts
T_17d42:
	movem.l	d0-d1/a0-a1,-(a7)
	move.w	#$1,B_58ac6
	bsr.w	Random_party_target
	lea.l	B_58ac8,a0
	movea.l	(a1),a1
	move.l	$2(a1),(a0)+
	move.w	$8(a1),(a0)+
	movem.l	(a7)+,d0-d1/a0-a1
	rts
T_17d68:
	movem.l	d0/d6-d7/a0-a2,-(a7)
	jsr	Random
	lsr.w	#$7,d0
	lea.l	B_58a56,a0
	andi.w	#$1,d0
	beq.b	.l_17d84
	adda.w	#$18,a0
.l_17d84:
	lea.l	B_58ac8,a1
	moveq	#5,d7
	moveq	#0,d6
.l_17d8e:
	move.l	(a0)+,d0
	beq.b	.l_17d9e
	movea.l	d0,a2
	move.l	$2(a2),(a1)+
	move.w	$8(a2),(a1)+
	addq.w	#$1,d6
.l_17d9e:
	dbra	d7,.l_17d8e
	move.w	d6,B_58ac6
	movem.l	(a7)+,d0/d6-d7/a0-a2
	rts
T_17dae:
	movem.l	d0/d6-d7/a0-a2,-(a7)
	lea.l	B_58a56,a0
	lea.l	B_58ac8,a1
	moveq	#11,d7
	moveq	#0,d6
.l_17dc2:
	move.l	(a0)+,d0
	beq.b	.l_17dd2
	movea.l	d0,a2
	move.l	$2(a2),(a1)+
	move.w	$8(a2),(a1)+
	addq.w	#$1,d6
.l_17dd2:
	dbra	d7,.l_17dc2
	move.w	d6,B_58ac6
	movem.l	(a7)+,d0/d6-d7/a0-a2
	rts
T_17de2:
	move.w	Active_member,d0
	jsr	Init_RText
	bsr.w	T_1642a
	movea.l	$2(a4),a4
	lea.l	$f0(a4),a0
	jsr	Add_ASCII_2_RText
	lea.l	D_2e434,a0
	jsr	Add_ASCII_2_RText
	move.w	B_58e58,d0
	movea.l	B_58e5a,a1
	jsr	Add_encoded_2_RText
	jsr	T_0707a
	jsr	Exit_RText
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	B_58aec,a1
	move.w	Active_member,d0
	subq.w	#$1,d0
	mulu.w	#$92,d0
	clr.w	(a1,d0.w)
	move.l	#T_16160,B_58920
	move.l	#.l_17e9e,B_58954
.l_17e60:
	btst	#$1,Mouse_button_state
	bne.b	.l_17e60
	lea.l	D_2d336,a0
	bsr.w	Push_Module
.l_17e74:
	move.w	#$0,Draw_Cicon
	bsr.w	Input_handler
	movea.l	Module_sp,a0
	move.l	(a0),d0
	beq.b	.l_17e8e
	movea.l	d0,a0
	jsr	(a0)
.l_17e8e:
	jsr	Switch_screen
	tst.b	B_58aaa
	beq.b	.l_17e74
	rts
.l_17e9e:
	move.w	Active_member,d0
	beq.b	.l_17ef0
	bsr.w	T_1642a
	move.w	d0,d2
	move.w	d1,d3
	cmp.w	d0,d4
	bne.b	.l_17eb6
	cmp.w	d1,d5
	beq.b	.l_17ef0
.l_17eb6:
	cmpi.w	#$3,d5
	bge.b	.l_17ef4
	mulu.w	#$6,d5
	add.w	d4,d5
	lsl.w	#$2,d5
	lea.l	B_58a0e,a0
	adda.w	d5,a0
	move.l	(a0),d5
	beq.b	.l_17ef4
	movea.l	d5,a0
	lea.l	B_58aec,a1
	move.w	Active_member,d0
	subq.w	#$1,d0
	mulu.w	#$92,d0
	adda.w	d0,a1
	move.w	#$1,(a1)+
	move.l	$2(a0),(a1)+
	move.l	a0,(a1)+
.l_17ef0:
	bsr.w	Pop_Module
.l_17ef4:
	btst	#$1,Mouse_button_state
	bne.b	.l_17ef4
	rts
T_17f00:
	move.w	Active_member,d0
	jsr	Init_RText
	bsr.w	T_1642a
	movea.l	$2(a4),a4
	lea.l	$f0(a4),a0
	jsr	Add_ASCII_2_RText
	lea.l	D_2e434,a0
	jsr	Add_ASCII_2_RText
	move.w	B_58e58,d0
	movea.l	B_58e5a,a1
	jsr	Add_encoded_2_RText
	jsr	T_0707a
	jsr	Exit_RText
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	B_58aec,a1
	move.w	Active_member,d0
	subq.w	#$1,d0
	mulu.w	#$92,d0
	clr.w	(a1,d0.w)
	move.l	#T_161ae,B_58920
	move.l	#.l_17fbc,B_58954
.l_17f7e:
	btst	#$1,Mouse_button_state
	bne.b	.l_17f7e
	lea.l	D_2d336,a0
	bsr.w	Push_Module
.l_17f92:
	move.w	#$0,Draw_Cicon
	bsr.w	Input_handler
	movea.l	Module_sp,a0
	move.l	(a0),d0
	beq.b	.l_17fac
	movea.l	d0,a0
	jsr	(a0)
.l_17fac:
	jsr	Switch_screen
	tst.b	B_58aaa
	beq.b	.l_17f92
	rts
.l_17fbc:
	move.w	Active_member,d0
	beq.b	.l_18008
	bsr.w	T_1642a
	move.w	d0,d2
	move.w	d1,d3
	cmpi.w	#$3,d5
	blt.b	.l_1800c
	mulu.w	#$6,d5
	add.w	d4,d5
	lsl.w	#$2,d5
	lea.l	B_58a0e,a0
	adda.w	d5,a0
	move.l	(a0),d5
	beq.b	.l_1800c
	movea.l	d5,a0
	lea.l	B_58aec,a1
	move.w	Active_member,d0
	subq.w	#$1,d0
	mulu.w	#$92,d0
	adda.w	d0,a1
	move.w	#$1,(a1)+
	move.l	$2(a0),(a1)+
	move.w	$8(a0),(a1)+
.l_18008:
	bsr.w	Pop_Module
.l_1800c:
	btst	#$1,Mouse_button_state
	bne.b	.l_1800c
	rts
T_18018:
	move.w	Active_member,d0
	jsr	Init_RText
	bsr.w	T_1642a
	movea.l	$2(a4),a4
	lea.l	$f0(a4),a0
	jsr	Add_ASCII_2_RText
	lea.l	D_2e434,a0
	jsr	Add_ASCII_2_RText
	move.w	B_58e58,d0
	movea.l	B_58e5a,a1
	jsr	Add_encoded_2_RText
	jsr	T_0707a
	jsr	Exit_RText
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	B_58aec,a1
	move.w	Active_member,d0
	subq.w	#$1,d0
	mulu.w	#$92,d0
	clr.w	(a1,d0.w)
	move.l	#T_161e2,B_58920
	move.l	#.l_180d4,B_58954
.l_18096:
	btst	#$1,Mouse_button_state
	bne.b	.l_18096
	lea.l	D_2d336,a0
	bsr.w	Push_Module
.l_180aa:
	move.w	#$0,Draw_Cicon
	bsr.w	Input_handler
	movea.l	Module_sp,a0
	move.l	(a0),d0
	beq.b	.l_180c4
	movea.l	d0,a0
	jsr	(a0)
.l_180c4:
	jsr	Switch_screen
	tst.b	B_58aaa
	beq.b	.l_180aa
	rts
.l_180d4:
	move.w	Active_member,d0
	beq.b	.l_1812e
	bsr.w	T_1642a
	move.w	d0,d2
	move.w	d1,d3
	cmp.w	d0,d4
	bne.b	.l_180ec
	cmp.w	d1,d5
	beq.b	.l_1812e
.l_180ec:
	cmpi.w	#$3,d5
	bge.b	.l_18132
	mulu.w	#$18,d5
	lea.l	B_58a0e,a0
	adda.w	d5,a0
	lea.l	B_58aec,a1
	move.w	Active_member,d0
	subq.w	#$1,d0
	mulu.w	#$92,d0
	adda.w	d0,a1
	moveq	#0,d6
	moveq	#5,d7
	movea.l	a1,a2
	addq.l	#$2,a1
.l_1811a:
	move.l	(a0)+,d5
	beq.b	.l_18128
	movea.l	d5,a3
	move.l	$2(a3),(a1)+
	move.l	a3,(a1)+
	addq.w	#$1,d6
.l_18128:
	dbra	d7,.l_1811a
	move.w	d6,(a2)
.l_1812e:
	bsr.w	Pop_Module
.l_18132:
	btst	#$1,Mouse_button_state
	bne.b	.l_18132
	rts
T_1813e:
	lea.l	B_58aec,a0
	move.w	Active_member,d0
	subq.w	#$1,d0
	mulu.w	#$92,d0
	adda.w	d0,a0
	lea.l	$2(a0),a1
	lea.l	B_58a0e,a2
	moveq	#0,d6
	moveq	#17,d7
.l_18160:
	move.l	(a2)+,d0
	beq.b	.l_1816e
	movea.l	d0,a3
	move.l	$2(a3),(a1)+
	move.l	a3,(a1)+
	addq.w	#$1,d6
.l_1816e:
	dbra	d7,.l_18160
	move.w	d6,(a0)
	rts
T_18176:
	movem.l	a0-a1,-(a7)
	jsr	Init_RText
	movea.l	$c(a4),a0
	lea.l	$f0(a0),a0
	jsr	Add_ASCII_2_RText
	lea.l	D_2e432,a0
	jsr	Add_ASCII_2_RText
	lea.l	D_4a180,a1
	jsr	Add_encoded_2_RText
	jsr	T_0707a
	jsr	Exit_RText
	movem.l	(a7)+,a0-a1
	rts
T_181b8:
	movem.l	d0/a0,-(a7)
	jsr	Init_RText
	movea.l	$c(a4),a0
	lea.l	$f0(a0),a0
	jsr	Add_ASCII_2_RText
	lea.l	D_2e432,a0
	jsr	Add_ASCII_2_RText
	movem.l	(a7)+,d0/a1
	jsr	Add_encoded_2_RText
	jsr	T_0707a
	jsr	Exit_RText
	rts
T_181f4:
	movem.l	a0-a1,-(a7)
	jsr	Init_RText
	lea.l	$f0(a0),a0
	jsr	Add_ASCII_2_RText
	lea.l	D_2e432,a0
	jsr	Add_ASCII_2_RText
	lea.l	D_4a180,a1
	jsr	Add_encoded_2_RText
	jsr	T_0707a
	jsr	Exit_RText
	jsr	Switch_screen
	jsr	Copy_screen
	bsr.w	T_18668
	movem.l	(a7)+,a0-a1
	rts
T_18242:
	movem.l	d7/a1,-(a7)
	movea.l	B_5895a,a0
	move.w	B_5895e,d7
	subq.w	#$1,d7
.l_18254:
	movea.l	$4(a0),a1
	cmp.b	$2(a1),d0
	bne.b	.l_18264
	cmp.b	$3(a1),d1
	beq.b	.l_18276
.l_18264:
	addq.l	#$8,a0
	dbra	d7,.l_18254
	lea.l	D_2f0fd,a1
	jsr	DI_Error
.l_18276:
	movea.l	a1,a0
	movem.l	(a7)+,d7/a1
	rts
; Stable bubble sort of the action list by the initiative (speed and its bonus).
Sort_action_list:
	lsl.w	#$3,d7
	lea.l	-$8(a0,d7.w),a1
	moveq	#8,d6
	movea.l	a0,a2
.l_18288:
	move.l	(a0),d0
	adda.l	d6,a0
	cmp.l	(a0),d0
	bgt.b	.l_18296
	cmpa.l	a0,a1
	bne.b	.l_18288
	bra.b	.l_182c0
.l_18296:
	move.l	(a0),d0
	move.l	$4(a0),d1
	movea.l	a0,a3
.l_1829e:
	suba.l	d6,a0
	cmpa.l	a2,a0
	blt.b	.l_182b2
	move.l	(a0),(a0,d6.l)
	move.l	$4(a0),$4(a0,d6.l)
	cmp.l	(a0),d0
	blt.b	.l_1829e
.l_182b2:
	move.l	d0,(a0,d6.l)
	move.l	d1,$4(a0,d6.l)
	movea.l	a3,a0
	cmpa.l	a0,a1
	bne.b	.l_18288
.l_182c0:
	rts
; Vertical blank handler of the battle (animations).
Combat_VBL:
	tst.b	B_58aae
	beq.w	.l_18368
	addq.w	#$1,B_5891e
	lea.l	B_58a0e,a0
	moveq	#17,d7
.l_182da:
	move.l	(a0)+,d0
	beq.b	.l_182f4
	movea.l	d0,a1
	tst.w	$10(a1)
	beq.b	.l_182f4
	subq.w	#$1,$10(a1)
	bne.b	.l_182f4
	move.w	#$2,B_58a0c
.l_182f4:
	dbra	d7,.l_182da
	moveq	#11,d7
.l_182fa:
	move.l	(a0)+,d0
	beq.b	.l_18314
	movea.l	d0,a1
	tst.w	$a(a1)
	beq.b	.l_18314
	subq.w	#$1,$a(a1)
	bne.b	.l_18314
	move.w	#$2,B_58a0c
.l_18314:
	dbra	d7,.l_182fa
	tst.w	B_589e0
	beq.b	.l_18368
	clr.w	B_589e4
	lea.l	B_58a0e,a0
	moveq	#17,d7
.l_1832e:
	move.l	(a0)+,d0
	beq.b	.l_18352
	movea.l	d0,a1
	tst.w	$14(a1)
	beq.b	.l_18352
	move.w	#$1,B_589e4
	addq.w	#$1,$16(a1)
	cmpi.w	#$60,$16(a1)
	bne.b	.l_18352
	clr.l	$14(a1)
.l_18352:
	dbra	d7,.l_1832e
	tst.w	B_589e0
	bpl.b	.l_18364
	bsr.w	Idle_animations
	rts
.l_18364:
	bsr.w	Attack_animation_step
.l_18368:
	rts
T_1836a:
	movem.l	d6-d7/a2,-(a7)
	lea.l	$22(a0),a2
	moveq	#20,d7
.l_18374:
	move.b	(a2)+,(a1)+
	dbra	d7,.l_18374
	clr.b	(a1)+
	move.w	$3a(a0),(a1)+
	move.w	$86(a0),(a1)+
	move.w	$8a(a0),(a1)+
	move.w	$90(a0),(a1)+
	move.w	$92(a0),(a1)+
	lea.l	$132(a0),a2
	moveq	#20,d7
.l_18396:
	moveq	#9,d6
.l_18398:
	move.l	(a2)+,(a1)+
	dbra	d6,.l_18398
	dbra	d7,.l_18396
	movem.l	(a7)+,d6-d7/a2
	rts
; A random path for the particles of the spell animations (per round).
Choose_particle_path:
	movem.l	d0-d1/a0,-(a7)
	jsr	Random
	lsr.w	#$1,d0
	ext.l	d0
	lea.l	D_2e0c8,a0
	move.w	(a0)+,d1
	divu.w	d1,d0
	swap	d0
	lsl.w	#$2,d0
	move.l	(a0,d0.w),B_58ab2
	movem.l	(a7)+,d0-d1/a0
	rts
T_183d2:
	jsr	Update_status_block
	movea.l	Off_screen,a6
	tst.w	B_58a0c
	beq.b	.l_183f0
	subq.w	#$1,B_58a0c
	bsr.w	T_15f86
.l_183f0:
	bsr.w	T_18416
	tst.w	d0
	bne.b	.l_18414
	clr.w	B_589e0
	jsr	Switch_screen
	jsr	Copy_screen
	bsr.w	Pop_Module
	st.b	B_58aaa
.l_18414:
	rts
T_18416:
	movea.l	Off_screen,a6
	movea.l	B_58912,a0
	moveq	#16,d0
	moveq	#49,d1
	moveq	#11,d6
	moveq	#112,d7
	jsr	Blot_unmasked_block
	lea.l	B_58a0e,a0
	lea.l	B_589e8,a1
	moveq	#17,d7
T_1843e:
	move.l	(a0)+,d0
	beq.b	Display_monsters
	movea.l	d0,a2
	move.w	$6(a2),d0
	move.b	d0,(a1)+
	move.w	$c(a2),d0
	move.b	d0,(a1)+
	bra.b	T_18456
; The monsters are drawn from the back row to the front row, their size depends on the row.
Display_monsters:
	move.w	#$ffff,(a1)+
T_18456:
	dbra	d7,T_1843e
	lea.l	B_58a0e,a3
	lea.l	T_185a8,a4
	lea.l	B_589e8,a5
	moveq	#2,d5
.l_1846e:
	move.w	d5,-(a7)
	moveq	#1,d5
	bsr.b	.l_18498
	moveq	#-1,d5
	bsr.b	.l_18498
	lea.l	$18(a3),a3
	lea.l	$24(a4),a4
	lea.l	$c(a5),a5
	move.w	(a7)+,d5
	dbra	d5,.l_1846e
	move.w	B_589e2,d0
	or.w	B_589e4,d0
	rts
.l_18498:
	movem.l	a3-a5,-(a7)
	moveq	#5,d7
T_1849e:
	movem.w	(a4)+,d0-d2
	move.l	(a3)+,d6
	beq.w	T_18594
	movea.l	d6,a2
	movem.w	d5/d7,-(a7)
	addi.w	#$10,d0
	addi.w	#$31,d1
	movea.l	$2(a2),a0
	moveq	#0,d3
	move.b	$3e(a0),d3
	subq.w	#$1,d3
	lsl.w	#$2,d3
	lea.l	T_18614,a0
	adda.w	d3,a0
	tst.b	$3(a0)
	bne.b	.l_184da
	tst.w	d5
	bmi.w	T_18590
	moveq	#0,d5
.l_184da:
	moveq	#0,d6
	bra.b	T_184e0
T_184de:
	add.b	(a0)+,d6
T_184e0:
	dbra	d2,T_184de
	moveq	#0,d3
	move.b	$1(a5),d3
	bne.b	Spell_animation_frame
	tst.w	d5
	bmi.w	T_18590
	move.b	(a5),d3
	add.w	d3,d3
	lea.l	T_185a0(pc),a0
	move.w	(a0,d3.w),d3
	bra.b	T_18506
; 6 particles fly around the center of the monster.
Spell_animation_frame:
	tst.w	d5
	bgt.w	T_18590
T_18506:
	add.w	d3,d6
	movea.l	$8(a2),a0
	lsl.w	#$2,d6
	adda.l	(a0,d6.w),a0
	move.w	(a0)+,d6
	move.w	(a0)+,d7
	move.w	d6,d3
	lsl.w	#$3,d3
	sub.w	d3,d0
	sub.w	d7,d1
	jsr	T_1c42e
	move.w	$14(a2),d2
	beq.b	T_18590
	subq.w	#$1,d2
	mulu.w	#$300,d2
	movea.l	B_5890c,a0
	adda.w	d2,a0
	move.w	$16(a2),d0
	lsr.w	#$2,d0
	mulu.w	#$12,d0
	movea.l	B_58ab2,a1
	adda.w	d0,a1
	movem.w	-$6(a4),d2-d3
	addq.w	#$8,d2
	addi.w	#$29,d3
	lsr.w	#$1,d7
	sub.w	d7,d3
	moveq	#5,d5
.l_1855c:
	move.b	(a1)+,d0
	move.b	(a1)+,d1
	ext.w	d0
	ext.w	d1
	add.w	d2,d0
	add.w	d3,d1
	moveq	#0,d4
	move.b	(a1)+,d4
	lsl.w	#$7,d4
	move.l	a0,-(a7)
	adda.w	d4,a0
	moveq	#16,d7
	move.w	#$a1,d6
	sub.w	d1,d6
	ble.b	.l_1858a
	cmp.w	d6,d7
	ble.b	.l_18582
	move.w	d6,d7
.l_18582:
	moveq	#1,d6
	jsr	T_1c42e
.l_1858a:
	movea.l	(a7)+,a0
	dbra	d5,.l_1855c
T_18590:
	movem.w	(a7)+,d5/d7
T_18594:
	addq.l	#$2,a5
	dbra	d7,T_1849e
	movem.l	(a7)+,a3-a5
	rts
T_185a0:
	dc.b	$00,$00,$00,$01,$00,$02,$00,$01
T_185a8:
	dc.b	$00,$36,$00,$46,$00,$00,$00,$44,$00,$46,$00,$00,$00,$52,$00,$46
	dc.b	$00,$00,$00,$5e,$00,$46,$00,$00,$00,$6c,$00,$46,$00,$00,$00,$7a
	dc.b	$00,$46,$00,$00,$00,$31,$00,$55,$00,$01,$00,$42,$00,$55,$00,$01
	dc.b	$00,$53,$00,$55,$00,$01,$00,$5d,$00,$55,$00,$01,$00,$6e,$00,$55
	dc.b	$00,$01,$00,$7f,$00,$55,$00,$01,$00,$28,$00,$6e,$00,$02,$00,$3c
	dc.b	$00,$6e,$00,$02,$00,$4e,$00,$6e,$00,$02,$00,$62,$00,$6e,$00,$02
	dc.b	$00,$74,$00,$6e,$00,$02,$00,$88,$00,$6e,$00,$02
T_18614:
	dc.b	$03,$03,$08,$ff,$08,$08,$08,$ff,$03,$03,$08,$00,$03,$03,$09,$00
	dc.b	$03,$03,$08,$00,$08,$08,$08,$00,$08,$08,$08,$00,$08,$08,$08,$00
	dc.b	$08,$08,$08,$00,$03,$03,$08,$00,$03,$03,$08,$00,$08,$08,$08,$ff
	dc.b	$03,$03,$08,$00,$08,$08,$08,$00,$08,$08,$08,$00,$03,$03,$08,$00
	dc.b	$03,$03,$08,$00,$08,$08,$08,$ff,$08,$08,$08,$00,$08,$08,$08,$00
	dc.b	$08,$08,$08,$00
T_18668:
	movem.l	d0-d7/a0-a6,-(a7)
	tst.b	B_58aab
	beq.b	.l_18696
	clr.w	B_5891e
.l_1867a:
	movea.l	Off_screen,a6
	bsr.w	T_15f86
	jsr	Switch_screen
	cmpi.w	#$32,B_5891e
	blt.b	.l_1867a
	bra.b	.l_186b2
.l_18696:
	movea.l	Off_screen,a6
	bsr.w	T_15f86
	jsr	Switch_screen
	jsr	Copy_screen
	jsr	Wait_4_user
.l_186b2:
	movem.l	(a7)+,d0-d7/a0-a6
	rts
T_186b8:
	movem.l	d0/a0,-(a7)
	lea.l	Char_status_icons,a0
	move.w	Active_member,d0
	subq.w	#$1,d0
	move.b	#$4,(a0,d0.w)
	lea.l	B_58924,a0
	lsl.w	#$3,d0
	adda.w	d0,a0
	move.w	#$4,(a0)+
	tst.b	Magic_object_flag
	beq.b	.l_186f6
	move.w	#$ffff,(a0)+
	move.b	Object_slot_number,d0
	ext.w	d0
	move.w	d0,(a0)+
	bra.b	.l_18702
.l_186f6:
	dc.b	$30,$f9
	dc.l	Selected_class
	dc.b	$30,$f9
	dc.l	Selected_spell
.l_18702:
	movem.l	(a7)+,d0/a0
	rts
T_18708:
	movem.l	d0/a0,-(a7)
	lea.l	B_58aec,a0
	move.w	Active_member,d0
	subq.w	#$1,d0
	mulu.w	#$92,d0
	adda.w	d0,a0
	tst.w	(a0)
	beq.b	.l_18728
	bsr.w	T_186b8
.l_18728:
	movem.l	(a7)+,d0/a0
	rts
; The spell of an item which was used in the inventory becomes the action of its owner.
Item_spell_action:
	movem.l	d0-d7/a0-a6,-(a7)
	tst.b	No_spell_selected
	beq.b	.l_18742
	sf.b	No_spell_selected
	bra.b	.l_18792
.l_18742:
	lea.l	D_484a4,a0
	move.w	Selected_class,d0
	mulu.w	#$78,d0
	adda.w	d0,a0
	move.w	Selected_spell,d0
	add.w	d0,d0
	add.w	d0,d0
	adda.w	d0,a0
	move.l	a0,B_58824
	lea.l	.l_1879c,a0
	move.w	Selected_class,d0
	add.w	d0,d0
	add.w	d0,d0
	move.l	-$4(a0,d0.w),d0
	beq.b	.l_18792
	movea.l	d0,a0
	move.w	Selected_spell,d0
	add.w	d0,d0
	add.w	d0,d0
	move.l	-$4(a0,d0.w),d0
	beq.b	.l_18792
	movea.l	d0,a0
	jsr	(a0)
.l_18792:
	bsr.w	T_16b64
	movem.l	(a7)+,d0-d7/a0-a6
	rts
.l_1879c:
	dc.l	.l_187b8
	dc.l	.l_18828
	dc.l	.l_18890
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.l	.l_188e8
.l_187b8:
	dc.l	T_18bfa
	dc.l	T_18bfa
	dc.l	T_18bfa
	dc.l	T_18bfa
	dc.l	T_18bfa
	dc.l	T_186b8
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.l	T_18ce2
	dc.l	T_18ce2
	dc.l	T_18ce2
	dc.l	T_18ce2
	dc.l	T_18ce2
	dc.l	T_186b8
	dc.l	T_18ce2
	dc.l	T_18ce2
	dc.l	T_18ce2
	dc.l	T_18ce2
	dc.l	T_18d9a
	dc.l	T_18e4c
	dc.l	T_18d9a
	dc.l	T_18d9a
	dc.l	T_18d9a
	dc.l	T_18edc
	dc.l	T_18ef6
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00
.l_18828:
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.l	T_186b8
	dc.l	T_186b8
	dc.l	T_186b8
	dc.l	T_186b8
	dc.l	T_186b8
	dc.l	T_186b8
	dc.l	T_186b8
	dc.l	T_186b8
	dc.l	T_186b8
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00
	dc.l	T_19000
	dc.l	T_186b8
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00
.l_18890:
	dc.l	T_19096
	dc.l	T_19096
	dc.l	T_19096
	dc.l	T_19096
	dc.l	T_19096
	dc.l	T_19096
	dc.l	T_19096
	dc.l	T_19096
	dc.l	T_19096
	dc.l	T_19096
	dc.l	T_19096
	dc.l	T_19096
	dc.l	T_19096
	dc.l	T_19096
	dc.l	T_19096
	dc.l	T_19096
	dc.l	T_19096
	dc.l	T_19096
	dc.l	T_19096
	dc.l	T_19096
	dc.l	T_19274
	dc.l	T_192e0
.l_188e8:
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.l	T_1945c
	dc.l	T_194d0
	dc.l	T_194d0
	dc.b	$00,$00,$00,$00
	dc.l	T_19580
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00
; Executes a spell in a battle (table of the spell classes behind it).
Cast_combat_spell:
	movem.l	d0-d7/a0-a6,-(a7)
	lea.l	D_484a4,a0
	move.w	Selected_class,d0
	mulu.w	#$78,d0
	adda.w	d0,a0
	move.w	Selected_spell,d0
	add.w	d0,d0
	add.w	d0,d0
	adda.w	d0,a0
	move.l	a0,B_58824
	lea.l	.l_1898e,a0
	move.w	Selected_class,d0
	add.w	d0,d0
	add.w	d0,d0
	move.l	-$4(a0,d0.w),d0
	beq.b	.l_18988
	movea.l	d0,a0
	move.w	Selected_spell,d0
	add.w	d0,d0
	add.w	d0,d0
	move.l	-$4(a0,d0.w),d0
	beq.b	.l_18988
	movea.l	d0,a0
	jsr	(a0)
.l_18988:
	movem.l	(a7)+,d0-d7/a0-a6
	rts
.l_1898e:
	dc.l	.l_189aa	; ori.b #$aa, d1
	dc.l	.l_18a1a	; ori.b #$1a, d1
	dc.l	.l_18a82	; ori.b #$82, d1
	ori.b	#$0,d0
	ori.b	#$0,d0
	ori.b	#$0,d0
	dc.l	.l_18ada	; ori.b #$da, d1
.l_189aa:
	dc.l	T_18c14	; ori.b #$14, d1
	dc.l	T_18c26	; ori.b #$26, d1
	dc.l	T_18c38	; ori.b #$38, d1
	dc.l	T_18c4a	; ori.b #$4a, d1
	dc.l	T_18c5c	; ori.b #$5c, d1
	dc.l	T_18ca0	; ori.b #$a0, d1
	ori.b	#$0,d0
	ori.b	#$0,d0
	ori.b	#$0,d0
	dc.l	T_18d14	; ori.b #$14, d1
	dc.l	T_18d14	; ori.b #$14, d1
	dc.l	T_18d14	; ori.b #$14, d1
	dc.l	T_18d14	; ori.b #$14, d1
	dc.l	T_18d14	; ori.b #$14, d1
	dc.l	T_18d66	; ori.b #$66, d1
	dc.l	T_18d14	; ori.b #$14, d1
	dc.l	T_18d14	; ori.b #$14, d1
	dc.l	T_18d14	; ori.b #$14, d1
	dc.l	T_18d14	; ori.b #$14, d1
	dc.l	Monster_resists	; ori.b #$ba, d1
	dc.l	T_18e66	; ori.b #$66, d1
	dc.l	Monster_resists	; ori.b #$ba, d1
	dc.l	Monster_resists	; ori.b #$ba, d1
	dc.l	Monster_resists	; ori.b #$ba, d1
	dc.l	T_18f10	; ori.b #$10, d1
	dc.l	T_18f10	; ori.b #$10, d1
	ori.b	#$0,d0
	ori.b	#$0,d0
.l_18a1a:
	ori.b	#$0,d0
	ori.b	#$0,d0
	ori.b	#$0,d0
	dc.l	T_18f6e	; ori.b #$6e, d1
	dc.l	T_18f6e	; ori.b #$6e, d1
	dc.l	T_18f6e	; ori.b #$6e, d1
	dc.l	T_18f9e	; ori.b #$9e, d1
	dc.l	T_18f9e	; ori.b #$9e, d1
	dc.l	T_18f9e	; ori.b #$9e, d1
	dc.l	T_18fce	; ori.b #$ce, d1
	dc.l	T_18fce	; ori.b #$ce, d1
	dc.l	T_18fce	; ori.b #$ce, d1
	ori.b	#$0,d0
	ori.b	#$0,d0
	ori.b	#$0,d0
	ori.b	#$0,d0
	ori.b	#$0,d0
	ori.b	#$0,d0
	ori.b	#$0,d0
	ori.b	#$0,d0
	ori.b	#$0,d0
	ori.b	#$0,d0
	dc.l	T_1901a	; ori.b #$1a, d1
	dc.l	T_19056	; ori.b #$56, d1
	ori.b	#$0,d0
	ori.b	#$0,d0
.l_18a82:
	dc.l	T_190e4	; ori.b #$e4, d1
	dc.l	T_190e4	; ori.b #$e4, d1
	dc.l	T_190e4	; ori.b #$e4, d1
	dc.l	T_190e4	; ori.b #$e4, d1
	dc.l	T_190e4	; ori.b #$e4, d1
	dc.l	T_190e4	; ori.b #$e4, d1
	dc.l	T_190e4	; ori.b #$e4, d1
	dc.l	T_190e4	; ori.b #$e4, d1
	dc.l	T_190e4	; ori.b #$e4, d1
	dc.l	T_190e4	; ori.b #$e4, d1
	dc.l	T_190e4	; ori.b #$e4, d1
	dc.l	T_190e4	; ori.b #$e4, d1
	dc.l	T_190e4	; ori.b #$e4, d1
	dc.l	T_190e4	; ori.b #$e4, d1
	dc.l	T_190e4	; ori.b #$e4, d1
	dc.l	T_190e4	; ori.b #$e4, d1
	dc.l	T_190e4	; ori.b #$e4, d1
	dc.l	T_190e4	; ori.b #$e4, d1
	dc.l	T_190e4	; ori.b #$e4, d1
	dc.l	T_190e4	; ori.b #$e4, d1
	dc.l	T_1928e	; ori.b #$8e, d1
	dc.l	T_192fa	; ori.b #$fa, d1
.l_18ada:
	dc.l	Monster_condition_spell	; ori.b #$5e, d1
	dc.l	Monster_condition_spell	; ori.b #$5e, d1
	dc.l	Monster_condition_spell	; ori.b #$5e, d1
	dc.l	Monster_condition_spell	; ori.b #$5e, d1
	dc.l	Monster_condition_spell	; ori.b #$5e, d1
	dc.l	Monster_condition_spell	; ori.b #$5e, d1
	dc.l	Monster_condition_spell	; ori.b #$5e, d1
	dc.l	Monster_sleep_spell	; ori.b #$f2, d1
	dc.l	Monster_condition_spell	; ori.b #$5e, d1
	dc.l	Monster_condition_spell	; ori.b #$5e, d1
	ori.b	#$0,d0
	ori.b	#$0,d0
	dc.l	T_19476	; ori.b #$76, d1
	dc.l	T_194ea	; ori.b #$ea, d1
	dc.l	T_1953e	; ori.b #$3e, d1
	ori.b	#$0,d0
	dc.l	T_1959a	; ori.b #$9a, d1
	ori.b	#$0,d0
	ori.b	#$0,d0
; Party spells use the spell points and probe the skill to use magic, spells of items always succeed.
Use_spell_points:
	movem.l	d0-d1/d7/a0-a1,-(a7)
	moveq	#-1,d7
	lea.l	Chard_ptrs,a0
	move.w	B_58ab8,d0
	add.w	d0,d0
	add.w	d0,d0
	move.l	-$4(a0,d0.w),B_58aba
	tst.b	Magic_object_flag
	beq.b	.l_18b94
	move.w	Active_member,B_5883e
	move.w	B_58ab8,d0
	movea.l	B_58aba,a0
	move.w	d0,B_58ab8
	move.l	a0,Current_active_char_data
	move.l	a0,B_5880e
	lea.l	B_5891c,a1
	lsl.w	#$3,d0
	adda.w	d0,a1
	move.w	$4(a1),B_5880c
	bsr.w	Remove_used_magic_item
	sf.b	B_5882f
	moveq	#0,d7
	bra.b	.l_18bcc
.l_18b94:
	dc.b	$22,$79
	dc.l	B_58aba
	dc.b	$20,$79
	dc.l	B_58824
	dc.b	$10,$28,$00,$01,$48,$80,$32,$29,$00,$8a,$92,$40,$6a,$02,$72,$00
	dc.b	$33,$41,$00,$8a,$70,$00,$10,$29,$00,$0f,$d0,$69,$00,$c2,$4e,$b9
	dc.l	Probe
	dc.b	$5b,$c7,$5b,$f9
	dc.l	B_5882f
.l_18bcc:
	tst.b	Magic_object_flag
	beq.b	.l_18bf2
	move.w	B_5883e,d0
	move.w	d0,Active_member
	lea.l	Chard_ptrs,a0
	add.w	d0,d0
	add.w	d0,d0
	move.l	-$4(a0,d0.w),Current_active_char_data
.l_18bf2:
	tst.b	d7
	movem.l	(a7)+,d0-d1/d7/a0-a1
	rts
T_18bfa:
	move.w	#$1,B_58e58
	move.l	#Code0007Sys,B_58e5a
	bsr.w	T_17f00
	bra.w	T_18708
T_18c14:
	jsr	Random
	mulu.w	#$5,d0
	swap	d0
	addq.w	#$1,d0
	bra.w	T_18c6c
T_18c26:
	jsr	Random
	mulu.w	#$8,d0
	swap	d0
	addq.w	#$2,d0
	bra.w	T_18c6c
T_18c38:
	jsr	Random
	mulu.w	#$10,d0
	swap	d0
	addq.w	#$4,d0
	bra.w	T_18c6c
T_18c4a:
	jsr	Random
	mulu.w	#$20,d0
	swap	d0
	addq.w	#$8,d0
	bra.w	T_18c6c
T_18c5c:
	dc.b	$4e,$b9
	dc.l	Random
	dc.b	$c0,$fc,$00,$40,$48,$40,$06,$40,$00,$10
T_18c6c:
	bsr.w	Use_spell_points
	bmi.b	.l_18c9e
	lea.l	B_58aee,a1
	move.w	B_58ab8,d1
	subq.w	#$1,d1
	mulu.w	#$92,d1
	adda.w	d1,a1
	movea.l	(a1),a0
	move.w	$3a(a0),d1
	andi.w	#$e080,d1
	bne.b	.l_18c9e
	bsr.w	Increase_LP
	move.w	$4(a1),d0
	bsr.w	Do_sparkle
.l_18c9e:
	rts
T_18ca0:
	bsr.w	Use_spell_points
	bmi.b	.l_18ce0
	lea.l	Chard_ptrs,a1
	moveq	#1,d7
.l_18cae:
	tst.l	(a1)
	beq.b	.l_18cd6
	movea.l	(a1),a0
	move.w	#$e080,d1
	and.w	$3a(a0),d1
	bne.b	.l_18cd6
	jsr	Random
	mulu.w	#$10,d0
	swap	d0
	addq.w	#$4,d0
	bsr.w	Increase_LP
	move.w	d7,d0
	bsr.w	Do_sparkle
.l_18cd6:
	addq.l	#$4,a1
	addq.w	#$1,d7
	cmpi.w	#$7,d7
	bmi.b	.l_18cae
.l_18ce0:
	rts
T_18ce2:
	move.w	Selected_spell,d0
	subi.w	#$a,d0
	move.b	.l_18d0a(pc,d0.w),d0
	ext.w	d0
	move.w	d0,B_58e58
	move.l	#Code0007Sys,B_58e5a
	bsr.w	T_17f00
	bra.w	T_18708
.l_18d0a:
	dc.b	$05,$06,$07,$08,$09,$ff,$0a,$0b,$0c,$0d
T_18d14:
	lea.l	B_58aee,a1
	move.w	B_58ab8,d1
	subq.w	#$1,d1
	mulu.w	#$92,d1
	adda.w	d1,a1
	movea.l	(a1),a0
	move.w	$3a(a0),d0
	andi.w	#$e080,d0
	bne.b	.l_18d5a
	bsr.w	Use_spell_points
	bmi.b	.l_18d5a
	move.w	Selected_spell,d0
	subi.w	#$a,d0
	move.b	.l_18d5c(pc,d0.w),d0
	move.w	$3a(a0),d1
	bclr	d0,d1
	move.w	d1,$3a(a0)
	move.w	$4(a1),d0
	bsr.w	Do_sparkle
.l_18d5a:
	rts
.l_18d5c:
	dc.b	$09,$08,$0b,$0c,$0a,$ff,$03,$00,$04,$01
T_18d66:
	bsr.w	Use_spell_points
	bmi.b	.l_18d98
	lea.l	Chard_ptrs,a0
	moveq	#1,d0
.l_18d74:
	tst.l	(a0)
	beq.b	.l_18d8e
	movea.l	(a0),a1
	move.w	$3a(a1),d1
	andi.w	#$e080,d1
	bne.b	.l_18d8e
	bclr	#$2,$3b(a1)
	bsr.w	Do_sparkle
.l_18d8e:
	addq.l	#$4,a0
	addq.w	#$1,d0
	cmpi.w	#$7,d0
	bmi.b	.l_18d74
.l_18d98:
	rts
T_18d9a:
	move.w	Selected_spell,d0
	subq.w	#$6,d0
	move.w	d0,B_58e58
	move.l	#Code0007Sys,B_58e5a
	bsr.w	T_17de2
	bra.w	T_18708
; Monsters resist with their anti-magic, some are immune to the condition spells.
Monster_resists:
	lea.l	B_58aee,a0
	move.w	B_58ab8,d1
	subq.w	#$1,d1
	mulu.w	#$92,d1
	adda.w	d1,a0
	movea.l	(a0)+,a1
	movea.l	(a0)+,a2
	move.w	$2e(a2),d0
	andi.w	#$e080,d0
	bne.b	.l_18e40
	bsr.w	Use_spell_points
	bmi.b	.l_18e40
	move.w	$56(a1),d0
	add.w	$aa(a1),d0
	jsr	Probe
	bmi.b	.l_18e00
	move.l	a0,-(a7)
	moveq	#12,d0
	movea.l	a1,a0
	bsr.w	T_181f4
	movea.l	(a7)+,a0
	bra.b	.l_18e40
.l_18e00:
	btst	#$2,$44(a1)
	beq.b	.l_18e16
	move.l	a0,-(a7)
	moveq	#13,d0
	movea.l	a1,a0
	bsr.w	T_181f4
	movea.l	(a7)+,a0
	bra.b	.l_18e40
.l_18e16:
	dc.b	$41,$f9
	dc.l	.l_18e42
	dc.b	$30,$39
	dc.l	Selected_spell
	dc.b	$04,$40,$00,$14,$d0,$40,$d0,$c0,$10,$18,$32,$2a,$00,$2e,$01,$c1
	dc.b	$35,$41,$00,$2e,$10,$10,$48,$80,$20,$4a,$61,$00,$08,$10
.l_18e40:
	rts
.l_18e42:
	dc.b	$08,$04,$ff,$ff,$03,$06,$00,$07,$04,$0e
T_18e4c:
	move.w	#$f,B_58e58
	move.l	#Code0007Sys,B_58e5a
	bsr.w	T_18018
	bra.w	T_18708
T_18e66:
	bsr.w	Use_spell_points
	bmi.b	T_18eda
	lea.l	B_58aec,a0
	move.w	B_58ab8,d0
	subq.w	#$1,d0
	mulu.w	#$92,d0
	adda.w	d0,a0
	move.w	(a0)+,d7
	bra.b	T_18ed6
T_18e84:
	movea.l	(a0)+,a1
	movea.l	(a0)+,a2
	move.w	$2e(a2),d0
	andi.w	#$e080,d0
	bne.b	T_18ed6
	move.w	$56(a1),d0
	add.w	$aa(a1),d0
	jsr	Probe
	bmi.b	.l_18eb0
	move.l	a0,-(a7)
	moveq	#12,d0
	movea.l	a1,a0
	bsr.w	T_181f4
	movea.l	(a7)+,a0
	bra.b	T_18ed6
.l_18eb0:
	btst	#$2,$44(a1)
	beq.b	.l_18ec6
	move.l	a0,-(a7)
	moveq	#13,d0
	movea.l	a1,a0
	bsr.w	T_181f4
	movea.l	(a7)+,a0
	bra.b	T_18ed6
.l_18ec6:
	dc.b	$08,$ea,$00,$02,$00,$2f,$70,$05,$c1,$4a,$61,$00,$07,$7c,$c1,$4a
T_18ed6:
	dbra	d7,T_18e84
T_18eda:
	rts
T_18edc:
	move.l	#Code0007Sys,B_58e5a
	move.w	#$13,B_58e58
	bsr.w	T_17de2
	bra.w	T_18708
T_18ef6:
	move.l	#Code0007Sys,B_58e5a
	move.w	#$14,B_58e58
	bsr.w	T_18018
	bra.w	T_18708
T_18f10:
	bsr.w	Use_spell_points
	bmi.b	T_18f6c
	lea.l	B_58aec,a0
	move.w	B_58ab8,d0
	subq.w	#$1,d0
	mulu.w	#$92,d0
	adda.w	d0,a0
	move.w	(a0)+,d7
	bra.b	T_18f68
T_18f2e:
	movea.l	(a0)+,a1
	movea.l	(a0)+,a2
	move.w	$2e(a2),d0
	andi.w	#$e080,d0
	bne.b	T_18f68
	btst	#$0,$44(a1)
	beq.b	T_18f68
	move.w	$56(a1),d0
	add.w	$aa(a1),d0
	jsr	Probe
	bmi.b	.l_18f62
	move.l	a0,-(a7)
	moveq	#12,d0
	movea.l	a1,a0
	bsr.w	T_181f4
	movea.l	(a7)+,a0
	bra.b	T_18f68
.l_18f62:
	dc.b	$08,$ea,$00,$05,$00,$2e
T_18f68:
	dbra	d7,T_18f2e
T_18f6c:
	rts
T_18f6e:
	bsr.w	Use_spell_points
	bmi.b	.l_18f90
	move.w	Selected_spell,d0
	subq.w	#$3,d0
	add.w	d0,d0
	add.w	d0,d0
	move.w	.l_18f92(pc,d0.w),Spell_2_data
	move.w	.l_18f94(pc,d0.w),Spell_2_duration
.l_18f90:
	rts
.l_18f92:
	dc.b	$00,$05
.l_18f94:
	dc.b	$00,$18,$00,$0a,$00,$60,$00,$0f,$00,$c0
T_18f9e:
	bsr.w	Use_spell_points
	bmi.b	.l_18fc0
	move.w	Selected_spell,d0
	subq.w	#$6,d0
	add.w	d0,d0
	add.w	d0,d0
	move.w	.l_18fc2(pc,d0.w),Spell_3_data
	move.w	.l_18fc4(pc,d0.w),Spell_3_duration
.l_18fc0:
	rts
.l_18fc2:
	dc.b	$00,$05
.l_18fc4:
	dc.b	$00,$18,$00,$0a,$00,$60,$00,$0f,$00,$c0
T_18fce:
	bsr.w	Use_spell_points
	bmi.b	.l_18ff2
	move.w	Selected_spell,d0
	subi.w	#$9,d0
	add.w	d0,d0
	add.w	d0,d0
	move.w	.l_18ff4(pc,d0.w),Spell_4_data
	move.w	.l_18ff6(pc,d0.w),Spell_4_duration
.l_18ff2:
	rts
.l_18ff4:
	dc.b	$00,$05
.l_18ff6:
	dc.b	$00,$18,$00,$0a,$00,$60,$00,$0f,$00,$c0
T_19000:
	move.l	#Code0007Sys,B_58e5a
	move.w	#$17,B_58e58
	bsr.w	T_17f00
	bra.w	T_18708
T_1901a:
	lea.l	B_58aee,a1
	move.w	B_58ab8,d1
	subq.w	#$1,d1
	mulu.w	#$92,d1
	adda.w	d1,a1
	movea.l	(a1),a0
	move.w	$3a(a0),d0
	andi.w	#$e080,d0
	bne.b	.l_19054
	bsr.w	Use_spell_points
	bmi.b	.l_19054
	move.w	$4(a1),d0
	bset	d0,B_58831
	bne.b	.l_19054
	move.w	$4(a1),d0
	bsr.w	Do_sparkle
.l_19054:
	rts
T_19056:
	bsr.w	Use_spell_points
	bmi.b	.l_19094
	lea.l	Chard_ptrs,a0
	moveq	#1,d0
	move.b	B_58831,d1
.l_1906a:
	tst.l	(a0)
	beq.b	.l_19084
	movea.l	(a0),a1
	move.w	$3a(a1),d2
	andi.w	#$e080,d2
	bne.b	.l_19084
	btst	d0,d1
	bne.b	.l_19084
	bset	d0,d1
	bsr.w	Do_sparkle
.l_19084:
	addq.l	#$4,a0
	addq.w	#$1,d0
	cmpi.w	#$7,d0
	bmi.b	.l_1906a
	move.b	d1,B_58831
.l_19094:
	rts
T_19096:
	movea.l	B_58824,a0
	move.b	$3(a0),d0
	btst	#$4,d0
	beq.b	.l_190ac
	bsr.w	T_1813e
	bra.b	.l_190e0
.l_190ac:
	btst	#$3,d0
	beq.b	.l_190ca
	move.w	#$1,B_58e58
	move.l	#Code0008Sys,B_58e5a
	bsr.w	T_18018
	bra.b	.l_190e0
.l_190ca:
	dc.b	$33,$fc,$00,$00
	dc.l	B_58e58
	dc.b	$23,$fc
	dc.l	Code0008Sys
	dc.l	B_58e5a
	dc.b	$61,$00,$ed,$04
.l_190e0:
	bra.w	T_18708
T_190e4:
	movea.l	B_58824,a0
	move.b	$3(a0),d0
	tst.b	B_58ab7
	beq.b	T_19134
	bsr.w	T_195e8
	bmi.b	T_1915e
	btst	#$4,d0
	beq.b	.l_19108
	bsr.w	T_17dae
	bra.b	.l_19118
.l_19108:
	btst	#$3,d0
	beq.b	.l_19114
	bsr.w	T_17d68
	bra.b	.l_19118
.l_19114:
	dc.b	$61,$00,$ec,$2c
.l_19118:
	lea.l	B_58ac8,a0
	move.w	B_58ac6,d6
	bra.b	T_1912e
T_19126:
	dc.b	$22,$58,$3e,$18,$61,$00,$00,$e4
T_1912e:
	dbra	d6,T_19126
	bra.b	T_1915e
T_19134:
	bsr.w	Use_spell_points
	bmi.b	T_1915e
	lea.l	B_58aec,a0
	move.w	B_58ab8,d0
	subq.w	#$1,d0
	mulu.w	#$92,d0
	adda.w	d0,a0
	move.w	(a0)+,d7
	bra.b	.l_1915a
	dc.b	$22,$58,$24,$58,$61,$00,$00,$08
.l_1915a:
	dc.b	$51,$cf,$ff,$f6
T_1915e:
	rts
; Damage spells, dissolve and magic arrows on monsters.
Damage_spell:
	movem.l	d0-d3/a0,-(a7)
	move.w	$2e(a2),d0
	andi.w	#$e080,d0
	bne.w	.l_1920a
	move.w	$56(a1),d0
	add.w	$aa(a1),d0
	jsr	Probe
	bmi.b	.l_19192
	movem.l	d0/a0,-(a7)
	moveq	#12,d0
	movea.l	a1,a0
	bsr.w	T_181f4
	movem.l	(a7)+,d0/a0
	bra.b	.l_1920a
.l_19192:
	movea.l	B_58824,a0
	move.b	(a0),d0
	rol.b	#$2,d0
	andi.w	#$3,d0
	lea.l	D_2e43c,a0
	move.b	(a0,d0.w),d0
	move.b	$45(a1),d1
	btst	d0,d1
	beq.b	.l_191c4
	movem.l	d0/a0,-(a7)
	moveq	#13,d0
	movea.l	a1,a0
	bsr.w	T_181f4
	movem.l	(a7)+,d0/a0
	bra.b	.l_1920a
.l_191c4:
	dc.b	$58,$40,$01,$01,$56,$f9
	dc.l	B_58ab6
	dc.b	$41,$f9
	dc.l	Spell_damage_table
	dc.b	$30,$39
	dc.l	Selected_spell
	dc.b	$c0,$fc,$00,$06,$d0,$c0,$4c,$90,$00,$0e,$94,$41,$4e,$b9
	dc.l	Random
	dc.b	$c0,$c2,$48,$40,$52,$40,$d2,$40,$4a,$39
	dc.l	B_58ab6
	dc.b	$67,$02,$d2,$41,$20,$4a,$61,$00,$04,$22,$30,$03,$61,$00,$04,$46
.l_1920a:
	movem.l	(a7)+,d0-d3/a0
	rts
; Black magic damage spells of monsters on the party.
Monster_damage_spell:
	movem.l	d0-d3/a0,-(a7)
	move.w	$56(a1),d0
	add.w	$aa(a1),d0
	add.w	Spell_4_data,d0
	jsr	Probe
	bmi.b	.l_1923c
	movem.l	d0/a0,-(a7)
	moveq	#12,d0
	movea.l	a1,a0
	bsr.w	T_181f4
	movem.l	(a7)+,d0/a0
	bra.b	.l_1926e
.l_1923c:
	dc.b	$41,$f9
	dc.l	Spell_damage_table
	dc.b	$30,$39
	dc.l	Selected_spell
	dc.b	$c0,$fc,$00,$06,$d0,$c0,$4c,$90,$00,$0e,$94,$41,$4e,$b9
	dc.l	Random
	dc.b	$c0,$c2,$48,$40,$52,$40,$d2,$40,$30,$07,$4e,$b9
	dc.l	Do_damage
	dc.b	$61,$00,$ce,$62
.l_1926e:
	movem.l	(a7)+,d0-d3/a0
	rts
T_19274:
	move.l	#Code0008Sys,B_58e5a
	move.w	#$2,B_58e58
	bsr.w	T_17de2
	bra.w	T_18708
T_1928e:
	bsr.w	Use_spell_points
	bmi.b	.l_192de
	lea.l	B_58aee,a0
	move.w	B_58ab8,d0
	subq.w	#$1,d0
	mulu.w	#$92,d0
	adda.w	d0,a0
	movea.l	(a0)+,a1
	movea.l	(a0)+,a2
	move.w	$2e(a2),d0
	andi.w	#$e080,d0
	bne.b	.l_192de
	move.w	$56(a1),d0
	add.w	$aa(a1),d0
	jsr	Probe
	bmi.b	.l_192d8
	movem.l	d0/a0,-(a7)
	moveq	#12,d0
	movea.l	a1,a0
	bsr.w	T_181f4
	movem.l	(a7)+,d0/a0
	bra.b	.l_192de
.l_192d8:
	dc.b	$08,$ea,$00,$05,$00,$2e
.l_192de:
	rts
T_192e0:
	move.l	#Code0008Sys,B_58e5a
	move.w	#$1,B_58e58
	bsr.w	T_18018
	bra.w	T_18708
T_192fa:
	bsr.w	Use_spell_points
	bmi.b	T_1935c
	lea.l	B_58aec,a0
	move.w	B_58ab8,d0
	subq.w	#$1,d0
	mulu.w	#$92,d0
	adda.w	d0,a0
	move.w	(a0)+,d7
	bra.b	T_19358
T_19318:
	movea.l	(a0)+,a1
	movea.l	(a0)+,a2
	move.w	$2e(a2),d0
	andi.w	#$e080,d0
	bne.b	T_19358
	move.w	$56(a1),d0
	add.w	$aa(a1),d0
	jsr	Probe
	bmi.b	.l_19348
	movem.l	d0/a0,-(a7)
	moveq	#12,d0
	movea.l	a1,a0
	bsr.w	T_181f4
	movem.l	(a7)+,d0/a0
	bra.b	T_19358
.l_19348:
	dc.b	$72,$08,$c1,$4a,$61,$00,$02,$d6,$70,$0a,$61,$00,$02,$fa,$c1,$4a
T_19358:
	dbra	d7,T_19318
T_1935c:
	rts
; Condition spells of monsters on a random party member.
Monster_condition_spell:
	bsr.w	T_195e8
	bmi.b	.l_193dc
	bsr.w	T_17d42
	tst.w	B_58ac6
	beq.b	.l_193dc
	lea.l	B_58ac8,a0
	movea.l	(a0),a1
	move.w	$56(a1),d0
	add.w	$aa(a1),d0
	add.w	Spell_4_data,d0
	jsr	Probe
	bmi.b	.l_193a0
	movem.l	d0/a0,-(a7)
	moveq	#12,d0
	movea.l	a1,a0
	bsr.w	T_181f4
	movem.l	(a7)+,d0/a0
	bra.b	.l_193dc
.l_193a0:
	dc.b	$45,$f9
	dc.l	.l_193dc
	dc.b	$30,$39
	dc.l	Selected_spell
	dc.b	$d0,$40,$d4,$c0,$10,$12,$32,$29,$00,$3a,$01,$c1,$33,$41,$00,$3a
	dc.b	$41,$f9
	dc.l	B_58ac8
	dc.b	$30,$28,$00,$04,$61,$00,$c5,$6e,$70,$00,$10,$2a,$00,$01,$20,$49
	dc.b	$61,$00,$ee,$20,$42,$79
	dc.l	B_5891c
.l_193dc:
	rts
	dc.b	$08,$0f,$09,$10,$0a,$11,$0b,$12,$0c,$13,$00,$14,$01,$15,$ff,$ff
	dc.b	$03,$17,$04,$18
; Sleep on the whole party.
Monster_sleep_spell:
	bsr.w	T_195e8
	bmi.b	T_1945a
	bsr.w	T_17dae
	lea.l	B_58ac8,a0
	move.w	B_58ac6,d7
	bra.b	T_19456
T_1940a:
	movea.l	(a0),a1
	move.w	$56(a1),d0
	add.w	$aa(a1),d0
	add.w	Spell_4_data,d0
	jsr	Probe
	bmi.b	.l_19434
	movem.l	d0/a0,-(a7)
	moveq	#12,d0
	movea.l	a1,a0
	bsr.w	T_181f4
	movem.l	(a7)+,d0/a0
	bra.b	.l_19454
.l_19434:
	dc.b	$08,$e9,$00,$02,$00,$3b,$30,$28,$00,$04,$61,$00,$c4,$f6,$2f,$08
	dc.b	$70,$16,$20,$49,$61,$00,$ed,$aa,$20,$5f,$42,$79
	dc.l	B_5891c
.l_19454:
	dc.b	$5c,$88
T_19456:
	dbra	d7,T_1940a
T_1945a:
	rts
T_1945c:
	move.l	#Code0008Sys,B_58e5a
	move.w	#$4,B_58e58
	bsr.w	T_17de2
	bra.w	T_18708
T_19476:
	bsr.w	Use_spell_points
	bmi.b	.l_194ce
	lea.l	B_58aee,a0
	move.w	B_58ab8,d0
	subq.w	#$1,d0
	mulu.w	#$92,d0
	adda.w	d0,a0
	movea.l	(a0)+,a1
	movea.l	(a0)+,a2
	move.w	$2e(a2),d0
	andi.w	#$e080,d0
	bne.b	.l_194ce
	btst	#$1,$44(a1)
	beq.b	.l_194ce
	move.w	$56(a1),d0
	add.w	$aa(a1),d0
	jsr	Probe
	bpl.b	.l_194c8
	movem.l	d0/a0,-(a7)
	moveq	#12,d0
	movea.l	a1,a0
	bsr.w	T_181f4
	movem.l	(a7)+,d0/a0
	bra.b	.l_194ce
.l_194c8:
	dc.b	$08,$ea,$00,$05,$00,$2e
.l_194ce:
	rts
T_194d0:
	move.w	#$5,B_58e58
	move.l	#Code0008Sys,B_58e5a
	bsr.w	T_17f00
	bra.w	T_18708
T_194ea:
	bsr.w	Use_spell_points
	bmi.b	.l_1953c
	lea.l	B_58aee,a1
	move.w	B_58ab8,d1
	subq.w	#$1,d1
	mulu.w	#$92,d1
	adda.w	d1,a1
	movea.l	(a1),a0
	move.w	$3a(a0),d1
	andi.w	#$e080,d1
	bne.b	.l_1953c
	jsr	Random
	mulu.w	#$19,d0
	swap	d0
	addq.w	#$1,d0
	add.w	$8a(a0),d0
	move.w	$8c(a0),d1
	add.w	$9a(a0),d1
	cmp.w	d1,d0
	bpl.b	.l_19530
	move.w	d0,d1
.l_19530:
	move.w	d1,$8a(a0)
	move.w	$4(a1),d0
	bsr.w	Do_sparkle
.l_1953c:
	rts
T_1953e:
	bsr.w	Use_spell_points
	bmi.b	.l_1957e
	lea.l	B_58aee,a1
	move.w	B_58ab8,d1
	subq.w	#$1,d1
	mulu.w	#$92,d1
	adda.w	d1,a1
	movea.l	(a1),a0
	move.w	$3a(a0),d1
	andi.w	#$e080,d1
	bne.b	.l_1957e
	move.w	$8c(a0),d0
	add.w	$9a(a0),d0
	cmp.w	$8a(a0),d0
	bmi.b	.l_1957e
	move.w	d0,$8a(a0)
	move.w	$4(a1),d0
	bsr.w	Do_sparkle
.l_1957e:
	rts
T_19580:
	move.l	#Code0008Sys,B_58e5a
	move.w	#$7,B_58e58
	bsr.w	T_17f00
	bra.w	T_18708
T_1959a:
	bsr.w	Use_spell_points
	bmi.b	.l_195e6
	lea.l	B_58aee,a1
	move.w	B_58ab8,d1
	subq.w	#$1,d1
	mulu.w	#$92,d1
	adda.w	d1,a1
	movea.l	(a1),a0
	move.w	$3a(a0),d1
	andi.w	#$e080,d1
	bne.b	.l_195e6
	move.w	$58(a0),d1
	jsr	Random
	mulu.w	#$a,d0
	swap	d0
	addq.w	#$1,d0
	sub.w	d0,d1
	cmpi.w	#$f,d1
	bmi.b	.l_195e6
	move.w	d1,$58(a0)
	move.w	$4(a1),d0
	bsr.w	Do_sparkle
.l_195e6:
	rts
T_195e8:
	movem.l	d0/a0-a1,-(a7)
	movea.l	B_58824,a0
	movea.l	B_58ac2,a1
	move.b	$1(a0),d0
	ext.w	d0
	sub.w	d0,$32(a1)
	movea.l	B_58abe,a1
	moveq	#0,d0
	move.b	$f(a1),d0
	add.w	$c2(a1),d0
	jsr	Probe
	smi.b	B_5882f
	movem.l	(a7)+,d0/a0-a1
	rts
	move.l	d2,-(a7)
	bclr	#$2,$2f(a0)
	move.w	d1,$12(a0)
	move.w	#$64,$10(a0)
	move.w	$30(a0),d2
	sub.w	d1,d2
	bgt.b	.l_19646
	ori.w	#$2000,$2e(a0)
	moveq	#0,d2
.l_19646:
	move.w	d2,$30(a0)
	move.l	(a7)+,d2
	rts
; Starts the particle animation of a spell (96 VBL).
Start_spell_animation:
	move.w	d0,$14(a0)
	clr.w	$16(a0)
	move.w	#$1,B_589e2
	rts
; Clears irritation, sleep, panic and the fled flag, removes the group from the map, loot and experience.
End_of_combat:
	sf.b	Battling
	jsr	Set_spell_area
	move.w	B_57a62,d0
	beq.b	.l_196ac
	move.w	d0,d1
	add.w	d0,d0
	add.w	d0,d0
	lea.l	Chard_ptrs,a0
	move.l	-$4(a0,d0.w),d0
	beq.b	.l_196ac
	movea.l	d0,a0
	move.w	$3a(a0),d0
	andi.w	#$e406,d0
	bne.b	.l_196ac
	move.w	d1,Active_member
	lea.l	Chard_ptrs,a0
	add.w	d1,d1
	add.w	d1,d1
	move.l	-$4(a0,d1.w),Current_active_char_data
	bra.b	.l_196c2
.l_196ac:
	movea.l	Current_active_char_data,a0
	move.w	$3a(a0),d0
	andi.w	#$e406,d0
	beq.b	.l_196c2
	jsr	Check_party_alive
.l_196c2:
	tst.w	B_58e5e
	beq.b	.l_196d8
	jsr	T_01f98
	sf.b	B_58e74
	bra.b	.l_19746
.l_196d8:
	tst.b	B_58e74
	beq.b	.l_196f4
	movea.l	Event_data_ptr,a5
	jsr	Save_event
	sf.b	B_58e74
	bra.b	.l_1972a
.l_196f4:
	move.w	B_58e60,d0
	move.l	CD_value,d1
	bset	d0,d1
	move.l	d1,CD_value
	move.w	Map_nr,d1
	subq.w	#$1,d1
	mulu.w	#$18,d1
	add.w	d0,d1
	addq.w	#$1,d1
	lea.l	CD,a0
	move.w	d1,d0
	lsr.w	#$3,d0
	andi.w	#$7,d1
	bset	d1,(a0,d0.w)
.l_1972a:
	tst.w	B_58966
	bne.b	.l_1973a
	tst.w	B_589d6
	beq.b	.l_19746
.l_1973a:
	lea.l	D_2d3a0,a0
	jmp	Push_Module
.l_19746:
	bsr.w	T_19752
	jsr	Init_display
	rts
T_19752:
	movem.l	d0/d7/a0,-(a7)
	lea.l	Chard_ptrs,a0
	moveq	#5,d7
.l_1975e:
	tst.l	(a0)
	beq.b	.l_19770
	movea.l	(a0),a1
	move.w	$3a(a1),d0
	andi.w	#$ff72,d0
	move.w	d0,$3a(a1)
.l_19770:
	addq.l	#$4,a0
	dbra	d7,.l_1975e
	movem.l	(a7)+,d0/d7/a0
	rts
T_1977c:
	jsr	T_0025a
	lea.l	B_58968,a0
	moveq	#0,d0
	moveq	#0,d1
	move.w	B_58966,d7
	bra.b	T_1979e
T_19794:
	movea.l	(a0)+,a1
	add.w	$34(a1),d0
	add.w	$36(a1),d1
T_1979e:
	dbra	d7,T_19794
	move.w	d0,B_58e6e
	move.w	d1,B_58e70
	lea.l	B_58968,a0
	moveq	#0,d0
	move.w	B_58966,d7
	bra.b	T_197d0
T_197be:
	movea.l	(a0)+,a1
	lea.l	$18(a1),a1
	moveq	#20,d6
.l_197c6:
	tst.b	(a1)+
	beq.b	.l_197cc
	addq.w	#$1,d0
.l_197cc:
	dbra	d6,.l_197c6
T_197d0:
	dbra	d7,T_197be
	tst.w	d0
	bne.b	.l_197e0
	move.w	d0,B_58e6c
	bra.b	.l_1985c
.l_197e0:
	addq.w	#$5,d0
	divu.w	#$6,d0
	cmpi.w	#$2,d0
	bpl.b	.l_197ee
	moveq	#2,d0
.l_197ee:
	mulu.w	#$6,d0
	move.w	d0,B_58e6c
	jsr	Allocate_memory
	move.l	a1,B_58e62
	movea.l	a1,a2
	lea.l	-$c(a2,d0.w),a0
	clr.l	(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
	mulu.w	#$28,d0
	jsr	Allocate_memory
	move.l	a1,B_58e66
	lea.l	B_58968,a0
	moveq	#0,d0
	move.w	B_58966,d7
	subq.w	#$1,d7
.l_19830:
	movea.l	(a0)+,a3
	lea.l	$38(a3),a4
	lea.l	$18(a3),a3
	moveq	#20,d6
.l_1983c:
	tst.b	(a3)
	beq.b	.l_1984e
	move.b	(a3),(a2)+
	moveq	#19,d5
.l_19844:
	move.w	(a4)+,(a1)+
	dbra	d5,.l_19844
	lea.l	-$28(a4),a4
.l_1984e:
	addq.l	#$1,a3
	lea.l	$28(a4),a4
	dbra	d6,.l_1983c
	dbra	d7,.l_19830
.l_1985c:
	moveq	#21,d0
	lea.l	D_260c0,a0
	jsr	Load_80x80_picture
	jsr	T_00208
	bsr.w	T_199cc
	lea.l	Chard_ptrs,a0
	moveq	#0,d2
	moveq	#5,d7
.l_1987e:
	tst.l	(a0)
	beq.b	.l_19890
	movea.l	(a0),a1
	move.w	$3a(a1),d0
	andi.w	#$e080,d0
	bne.b	.l_19890
	addq.w	#$1,d2
.l_19890:
	addq.l	#$4,a0
	dbra	d7,.l_1987e
	tst.w	d2
	beq.w	.l_1995e
	moveq	#0,d6
	move.w	B_589d6,d6
	divu.w	d2,d6
	ext.l	d6
	lea.l	Chard_ptrs,a0
	moveq	#5,d7
.l_198b0:
	tst.l	(a0)
	beq.b	.l_198c4
	movea.l	(a0),a1
	move.w	$3a(a1),d0
	andi.w	#$e080,d0
	bne.b	.l_198c4
	add.l	d6,$cc(a1)
.l_198c4:
	addq.l	#$4,a0
	dbra	d7,.l_198b0
	lea.l	Lay3_PA,a0
	jsr	Push_PA
	lea.l	Lay3_PlusMes,a0
	jsr	Push_MA
	jsr	Init_RText
	lea.l	Code0004Sys,a1
	move.w	#$e,d0
	jsr	Add_encoded_2_RText
	lea.l	Number_buffer,a0
	movea.l	a0,a3
	move.l	d6,d0
	moveq	#4,d7
	jsr	LConvert_number
	jsr	Add_ASCII_2_RText
	lea.l	D_26128,a0
	jsr	Add_ASCII_2_RText
	jsr	T_0707a
	jsr	Exit_RText
	jsr	Switch_screen
	jsr	Copy_screen
	jsr	Wait_4_user
	movea.l	Off_screen,a6
	jsr	Erase_text_window
	jsr	Switch_screen
	jsr	Copy_screen
	jsr	Pop_MA
	jsr	Pop_PA
.l_1995e:
	move.l	#Lay3_PlusMes,PlusMes_info
	move.l	#Code0008Sys,Textfile_ptr
	movea.l	Off_screen,a6
	move.w	#$11,d0
	jsr	Hash_message
	jsr	Switch_screen
	jsr	Copy_screen
	bra.w	T_19752
T_19992:
	movea.l	B_58a86,a0
	jsr	Free_memory
	tst.w	B_58e6c
	beq.b	.l_199be
	movea.l	B_58e62,a0
	jsr	Free_memory
	movea.l	B_58e66,a0
	jsr	Free_memory
.l_199be:
	movea.l	Pic80_ptr,a0
	jsr	Free_memory
	rts
T_199cc:
	move.l	#Lay3_PlusMes,PlusMes_info
	movea.l	Off_screen,a6
	moveq	#3,d0
	jsr	Show_layout
	tst.w	B_58e6c
	beq.b	.l_19a0e
	move.w	#$0,B_58e6a
	move.l	B_58e66,Itemdata_ptr
	move.l	B_58e62,Itemslots_ptr
	jsr	Show_objects_LAY3
.l_19a0e:
	moveq	#15,d0
	jsr	IG_Set_ink
	moveq	#2,d0
	jsr	IG_Set_paper
	tst.w	B_58e6e
	sne.b	B_58e72
	beq.b	.l_19a44
	move.w	#$70,d0
	move.w	#$71,d1
	move.w	#$40,d2
	lea.l	Gold_txt,a0
	jsr	Print_centered_string
.l_19a44:
	tst.w	B_58e70
	sne.b	B_58e73
	beq.b	.l_19a6a
	move.w	#$f0,d0
	move.w	#$71,d1
	move.w	#$40,d2
	lea.l	Food_txt,a0
	jsr	Print_centered_string
.l_19a6a:
	jsr	Display_80x80_picture
	lea.l	D_2e4ba,a0
	bsr.w	T_19b38
	move.l	a0,Control_list_ptr
	jsr	Show_control_icons
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	Lay3_L2,a0
	jsr	Set_layout_data
	jmp	Fadein_lay3
T_19aa4:
	movea.l	Off_screen,a6
	jsr	Update_status_block
	lea.l	D_2e4ba,a0
	lea.l	T_19b38,a1
	jsr	Update_control_icons
	moveq	#15,d0
	jsr	IG_Set_ink
	moveq	#2,d0
	jsr	IG_Set_paper
	tst.b	B_58e72
	beq.b	.l_19b04
	move.w	B_58e6e,d0
	moveq	#48,d1
	moveq	#5,d7
	lea.l	GoldDis_text,a0
	movea.l	a0,a3
	jsr	RConvert_number
	move.w	#$70,d0
	move.w	#$79,d1
	move.w	#$40,d2
	jsr	Print_centered_string
.l_19b04:
	tst.b	B_58e73
	beq.b	.l_19b36
	move.w	B_58e70,d0
	moveq	#48,d1
	moveq	#4,d7
	lea.l	D_2610f,a0
	movea.l	a0,a3
	jsr	RConvert_number
	move.w	#$f0,d0
	move.w	#$79,d1
	move.w	#$40,d2
	jsr	Print_centered_string
.l_19b36:
	rts
T_19b38:
	movea.l	a0,a1
	moveq	#8,d7
.l_19b3c:
	bclr	#$7,(a1)+
	dbra	d7,.l_19b3c
	tst.w	B_58e6e
	bne.b	.l_19b58
	bset	#$7,$4(a0)
	bset	#$7,$5(a0)
.l_19b58:
	tst.w	B_58e70
	bne.b	.l_19b6c
	bset	#$7,$7(a0)
	bset	#$7,$8(a0)
.l_19b6c:
	tst.w	B_58e6c
	beq.b	T_19b90
	movea.l	B_58e62,a1
	move.b	(a1)+,d0
	move.w	B_58e6c,d7
	subq.w	#$1,d7
	bra.b	T_19b88
T_19b86:
	or.b	(a1)+,d0
T_19b88:
	dbra	d7,T_19b86
	tst.b	d0
	bne.b	T_19baa
T_19b90:
	bset	#$7,$0(a0)
	bset	#$7,$1(a0)
	bset	#$7,$3(a0)
	bset	#$7,$6(a0)
	bra.b	T_19be8
T_19baa:
	cmpi.w	#$c,B_58e6c
	bne.b	.l_19bc0
	bset	#$7,$3(a0)
	bset	#$7,$6(a0)
.l_19bc0:
	tst.w	B_58e6a
	bne.b	.l_19bce
	bset	#$7,$3(a0)
.l_19bce:
	move.w	B_58e6a,d0
	addq.w	#$1,d0
	mulu.w	#$6,d0
	cmp.w	B_58e6c,d0
	bmi.b	T_19be8
	bset	#$7,$6(a0)
T_19be8:
	rts
T_19bea:
	tst.w	B_58e6c
	beq.b	.l_19c34
	tst.b	d0
	beq.b	.l_19c34
	movea.l	Itemdata_ptr,a0
	movea.l	Itemslots_ptr,a1
	ext.w	d0
	tst.b	-$1(a1,d0.w)
	beq.b	.l_19c34
	mulu.w	#$28,d0
	lea.l	-$28(a0,d0.w),a0
	cmpi.b	#$11,$1(a0)
	beq.b	.l_19c34
	move.w	$26(a0),d0
	cmp.w	Object_name_nr,d0
	beq.b	.l_19c34
	move.w	d0,Object_name_nr
	move.b	#$2,Print_objname_flag
.l_19c34:
	rts
T_19c36:
	tst.w	B_58e6c
	beq.b	.l_19c5a
	tst.b	d0
	beq.b	.l_19c52
	move.l	#$ffff00,d1
	and.l	d0,d1
	cmpi.l	#$20200,d1
	beq.b	.l_19c5a
.l_19c52:
	move.b	#$2,Erase_objname_flag
.l_19c5a:
	rts
T_19c5c:
	btst	#$1,Mouse_button_state
	bne.b	T_19c5c
	move.w	#$0,Draw_Cicon
	jsr	My_vsync
	movea.l	B_58e62,a2
	movea.l	B_58e66,a3
	moveq	#0,d6
	move.w	B_58e6c,d7
	bra.b	T_19d08
T_19c8a:
	tst.b	(a2)+
	beq.b	T_19d04
	btst	#$1,$18(a3)
	bne.b	T_19d04
	tst.w	d6
	bne.b	.l_19cd4
	addq.w	#$1,d6
	lea.l	Lay3_PA,a0
	jsr	Push_PA
	lea.l	Lay3_PlusMes,a0
	jsr	Push_MA
	jsr	Init_RText
	lea.l	Code0004Sys,a1
	moveq	#12,d0
	jsr	Add_encoded_2_RText
	lea.l	D_2e4b8,a0
	jsr	Add_ASCII_2_RText
.l_19cd4:
	move.w	$26(a3),d0
	jsr	Find_word
	lea.l	Number_buffer,a1
	moveq	#0,d0
	move.b	(a0)+,d0
	subq.w	#$1,d0
	bra.b	T_19cee
T_19cec:
	move.b	(a0)+,(a1)+
T_19cee:
	dbra	d0,T_19cec
	move.b	#$d,(a1)+
	clr.b	(a1)
	lea.l	Number_buffer,a0
	jsr	Add_ASCII_2_RText
T_19d04:
	lea.l	$28(a3),a3
T_19d08:
	dbra	d7,T_19c8a
	tst.w	d6
	beq.b	.l_19d54
	jsr	T_0707a
	jsr	Switch_screen
	jsr	Copy_screen
	jsr	Exit_RText
	jsr	Wait_4_user
	movea.l	Off_screen,a6
	jsr	Erase_text_window
	jsr	Switch_screen
	jsr	Copy_screen
	jsr	Pop_MA
	jsr	Pop_PA
	bra.b	.l_19d66
.l_19d54:
	jsr	Exit_display
	jsr	Pop_Module
	jsr	Init_display
.l_19d66:
	rts
T_19d68:
	move.w	#$0,Draw_Cicon
	jsr	My_vsync
.l_19d76:
	btst	#$1,Mouse_button_state
	bne.b	.l_19d76
	subq.w	#$6,B_58e6a
	bra.w	T_19fec
T_19d8a:
	move.w	#$0,Draw_Cicon
	jsr	My_vsync
.l_19d98:
	btst	#$1,Mouse_button_state
	bne.b	.l_19d98
	addq.w	#$6,B_58e6a
	bra.w	T_19fec
T_19dac:
	moveq	#0,d0
	move.w	B_58e6e,d0
	jsr	Divide_gold
	move.w	d0,B_58e6e
	move.w	#$0,Draw_Cicon
	jsr	My_vsync
.l_19dce:
	btst	#$1,Mouse_button_state
	bne.b	.l_19dce
	rts
T_19dda:
	move.w	#$70,Mesmin_X
	move.w	#$3f,Mesmin_Y
	move.w	#$c0,Mesmin_Wd
	move.l	#Code0001Sys,Textfile_ptr
	movea.l	Off_screen,a6
	move.w	#$6,d0
	jsr	Minus_message
	jsr	Switch_screen
	jsr	Copy_screen
.l_19e18:
	btst	#$1,Mouse_button_state
	bne.b	.l_19e18
	moveq	#0,d0
	move.w	B_58e6e,d0
	move.l	d0,Original_number
	clr.l	ItemW_nr
	lea.l	D_2d44c,a0
	jsr	Push_Module
	rts
T_19e44:
	move.l	ItemW_nr,d0
	beq.b	.l_19e86
	move.w	d0,d1
	mulu.w	#$a,d0
	suba.l	a0,a0
	bsr.w	Scan_4_gold_victims
	bne.b	.l_19e66
	move.w	#$5,d0
	jsr	Plus_message
	bra.b	.l_19e86
.l_19e66:
	bsr.w	Show_transfer_victims
	move.l	#.l_19e92,TIVS_Ptr
	lea.l	TIVS2_Mod,a0
	move.w	#$19,$2c(a0)
	jsr	Push_Module
.l_19e86:
	btst	#$1,Mouse_button_state
	bne.b	.l_19e86
	rts
.l_19e92:
	move.l	ItemW_nr,d0
	add.w	d0,$90(a0)
	sub.w	d0,B_58e6e
	mulu.w	#$a,d0
	add.l	d0,$ec(a0)
	rts
T_19eac:
	moveq	#0,d0
	move.w	B_58e70,d0
	jsr	T_0cbec
	move.w	d0,B_58e70
.l_19ec0:
	btst	#$1,Mouse_button_state
	bne.b	.l_19ec0
	rts
T_19ecc:
	move.w	#$70,Mesmin_X
	move.w	#$3f,Mesmin_Y
	move.w	#$c0,Mesmin_Wd
	move.l	#Code0001Sys,Textfile_ptr
	movea.l	Off_screen,a6
	move.w	#$7,d0
	jsr	Minus_message
	jsr	Switch_screen
	jsr	Copy_screen
.l_19f0a:
	btst	#$1,Mouse_button_state
	bne.b	.l_19f0a
	moveq	#0,d0
	move.w	B_58e70,d0
	move.l	d0,Original_number
	clr.l	ItemW_nr
	lea.l	D_2d4a0,a0
	jsr	Push_Module
	rts
T_19f36:
	move.l	ItemW_nr,d0
	beq.w	.l_19fd0
	mulu.w	#$fa,d0
	lea.l	Chard_ptrs,a1
	lea.l	Char_status_icons,a4
	moveq	#0,d6
	moveq	#1,d7
.l_19f54:
	tst.l	(a1)
	beq.b	.l_19f82
	movea.l	(a1),a2
	move.w	$48(a2),d1
	add.w	$9c(a2),d1
	mulu.w	#$3e8,d1
	sub.l	$ec(a2),d1
	cmp.l	d0,d1
	bmi.b	.l_19f82
	move.w	$92(a2),d1
	add.w	d0,d1
	bvs.b	.l_19f82
	move.w	#$e402,d1
	and.w	$3a(a2),d1
	bne.b	.l_19f82
	bset	d7,d6
.l_19f82:
	addq.l	#$4,a1
	addq.w	#$1,d7
	cmpi.w	#$7,d7
	bmi.b	.l_19f54
	bmi.b	.l_19f54
	move.w	d5,Transferring
	move.w	d6,Transfer_victims
	tst.w	d6
	bne.b	.l_19fb0
	move.w	#$5,d0
	jsr	Plus_message
	jsr	Pop_Module
	bra.b	.l_19fd0
.l_19fb0:
	bsr.w	Show_transfer_victims
	move.l	#.l_19fd2,TIVS_Ptr
	lea.l	TIVS2_Mod,a0
	move.w	#$1a,$2c(a0)
	jsr	Push_Module
.l_19fd0:
	rts
.l_19fd2:
	move.l	ItemW_nr,d0
	add.w	d0,$92(a0)
	sub.w	d0,B_58e70
	mulu.w	#$fa,d0
	add.l	d0,$ec(a0)
	rts
T_19fec:
	movea.l	B_58e62,a0
	move.w	B_58e6a,d0
	adda.w	d0,a0
	move.l	a0,Itemslots_ptr
	movea.l	B_58e66,a0
	mulu.w	#$28,d0
	adda.w	d0,a0
	move.l	a0,Itemdata_ptr
	movea.l	Off_screen,a6
	jsr	Show_objects_LAY3
	jsr	Switch_screen
	jsr	Copy_screen
	rts
T_1a02c:
	movem.l	d0-d7/a0-a6,-(a7)
	move.w	d0,B_58e78
	lea.l	D_2cfde,a0
	jsr	Push_Module
.l_1a042:
	jsr	Input_handler
	jsr	Switch_screen
	tst.b	Abort_list
	beq.b	.l_1a042
	movem.l	(a7)+,d0-d7/a0-a6
	rts
T_1a05c:
	move.w	#$30,d0
	move.w	#$3c,d1
	moveq	#12,d2
	moveq	#5,d3
	moveq	#1,d6
	lea.l	D_2fcd6,a0
	jsr	Open_window
	move.w	d0,B_58e76
	lea.l	D_2e7c2,a0
	jsr	Push_PA
	movea.l	Off_screen,a6
	jsr	Init_RText
	lea.l	Code0008Sys,a1
	move.w	#$a,d0
	jsr	Add_encoded_2_RText
	lea.l	D_2e4e8,a0
	move.w	B_58e78,d0
	addi.w	#$41,d0
	move.b	d0,(a0)
	jsr	Add_ASCII_2_RText
	move.w	#$b,d0
	jsr	Add_encoded_2_RText
	jsr	T_0707a
	jsr	Exit_RText
	moveq	#2,d6
	moveq	#16,d7
	move.w	#$b0,d0
	move.w	#$6c,d1
	lea.l	D_3ba60,a0
	jsr	Blot_unmasked_block
	jsr	Switch_screen
	jsr	Copy_screen
	rts
T_1a0f8:
	move.w	B_58e76,d0
	jsr	Close_window
	jsr	Pop_PA
	rts
T_1a10c:
	movem.l	d0-d7/a0-a6,-(a7)
	sf.b	B_58e7a
	move.l	#Code0008Sys,Textfile_ptr
	move.w	#$d,ReqText_nr
	move.l	#.l_1a166,ReqDo_ptr
	lea.l	Req_Mod,a0
	jsr	Push_Module
.l_1a13e:
	jsr	Input_handler
	jsr	Switch_screen
	tst.b	Abort_list
	beq.b	.l_1a13e
	tst.b	B_58e7a
	bne.b	.l_1a160
	jmp	Exit_all
.l_1a160:
	movem.l	(a7)+,d0-d7/a0-a6
	rts
.l_1a166:
	st.b	B_58e7a
	rts
T_1a16e:
	movem.l	d0-d7/a0-a6,-(a7)
	lea.l	D_2d02c,a0
	jsr	Push_Module
.l_1a17e:
	jsr	Input_handler
	jsr	Switch_screen
	tst.b	Abort_list
	beq.b	.l_1a17e
	movem.l	(a7)+,d0-d7/a0-a6
	rts
T_1a198:
	move.w	#$30,d0
	move.w	#$3c,d1
	moveq	#12,d2
	moveq	#5,d3
	moveq	#1,d6
	lea.l	D_2fcd6,a0
	jsr	Open_window
	move.w	d0,B_58e76
	lea.l	D_2e7c2,a0
	jsr	Push_PA
	movea.l	Off_screen,a6
	jsr	Init_RText
	lea.l	Code0008Sys,a1
	move.w	#$c,d0
	jsr	Add_encoded_2_RText
	jsr	T_0707a
	jsr	Exit_RText
	moveq	#2,d6
	moveq	#16,d7
	move.w	#$b0,d0
	move.w	#$6c,d1
	lea.l	D_3ba60,a0
	jsr	Blot_unmasked_block
	jsr	Switch_screen
	jsr	Copy_screen
	rts
T_1a212:
	jsr	Exit_display
	cmpi.b	#$2,Current_map_type
	bmi.b	.l_1a234
	jsr	T_0025a
	jsr	T_0f614
	jsr	T_00208
.l_1a234:
	jsr	T_1c0e8
	jsr	T_1c1aa
	movea.l	Screen_base,a6
	lea.l	D_2f122,a0
	jsr	DI_Print
	lea.l	D_2f145,a0
	jsr	DI_Print
	lea.l	D_2f16a,a0
	jsr	DI_Print
	jsr	DI_Carriage_return
	lea.l	Chard_ptrs,a1
	lea.l	B_58e7c,a2
	lea.l	Screen,a3
	moveq	#5,d7
T_1a284:
	tst.l	(a1)
	beq.b	T_1a29c
	movea.l	(a1),a0
	bsr.w	T_1a46e
	move.l	a3,(a2)+
	move.l	d0,(a2)+
	lsr.w	#$1,d0
	bra.b	T_1a298
T_1a296:
	move.w	(a0)+,(a3)+
T_1a298:
	dbra	d0,T_1a296
T_1a29c:
	addq.l	#$4,a1
	dbra	d7,T_1a284
	move.l	a3,B_58eac
	movea.l	Modifications_ptr,a0
	move.w	Nr_of_modifications,d7
	bra.b	T_1a2ba
T_1a2b6:
	move.l	(a0)+,(a3)+
	move.w	(a0)+,(a3)+
T_1a2ba:
	dbra	d7,T_1a2b6
	lea.l	Char_damage,a0
	moveq	#14,d7
.l_1a2c6:
	clr.w	(a0)+
	dbra	d7,.l_1a2c6
	lea.l	XActive_member,a0
	move.w	#$2a,d7
.l_1a2d6:
	clr.w	(a0)+
	dbra	d7,.l_1a2d6
	sf.b	First
	sf.b	Which_CIL
	sf.b	Battling
	sf.b	Party_invisible
	sf.b	Stygian
	move.l	#PA_Stack,PA_sp
	move.l	#B_5d8b2,MA_sp
	move.l	#B_5d0c4,Object_sp
	move.l	#D_51c84,Mptr_sp
	move.l	#B_584f8,Module_sp
	lea.l	Window_list,a0
	clr.l	(a0)+
	clr.l	(a0)+
	lea.l	B_5ceb0,a7
	clr.l	D_2746e
	clr.l	D_29096
	clr.l	D_2bfea
	clr.l	D_281f6
	clr.l	D_28188
	moveq	#0,d0
	jsr	Play_song
	lea.l	D_2fcfa,a0
	jsr	Push_Root
	jsr	T_1d278
	lea.l	D_2e7ae,a0
	jsr	Push_PA
	move.l	#$200,d0
	mulu.w	#$6,d0
	addq.l	#$2,d0
	jsr	Allocate_memory
	move.l	a1,Modifications_ptr
	movea.l	B_58eac,a0
	move.w	Nr_of_modifications,d7
	bra.b	T_1a3aa
T_1a3a6:
	move.l	(a0)+,(a1)+
	move.w	(a0)+,(a1)+
T_1a3aa:
	dbra	d7,T_1a3a6
	clr.w	(a1)
	lea.l	Chard_ptrs,a0
	lea.l	B_58e7c,a2
	moveq	#5,d7
T_1a3be:
	tst.l	(a0)
	beq.b	T_1a3dc
	move.l	$4(a2),d0
	jsr	Allocate_memory
	move.l	a1,(a0)
	movea.l	(a2),a3
	lsr.w	#$1,d0
	bra.b	T_1a3d6
T_1a3d4:
	move.w	(a3)+,(a1)+
T_1a3d6:
	dbra	d0,T_1a3d4
	addq.l	#$8,a2
T_1a3dc:
	addq.l	#$4,a0
	dbra	d7,T_1a3be
	lea.l	Chard_ptrs,a0
	move.w	Active_member,d0
	add.w	d0,d0
	add.w	d0,d0
	move.l	-$4(a0,d0.w),Current_active_char_data
	move.w	Travel_mode,d0
	jsr	Set_new_travel_mode
	lea.l	D_2f18f,a0
	jsr	DI_Print
	jsr	Wait_4_key
	jsr	T_1c15e
	move.b	#$0,Mouse_flag
	movea.l	Off_screen,a6
	jsr	Clear_screen
	jsr	Show_status_block
	jsr	Switch_screen
	jsr	Copy_screen
	jsr	Update_status_block
	jsr	Switch_screen
	jsr	Copy_screen
	jsr	DoAutoIcon
	jsr	T_00194
	jsr	Init_map
	jmp	Main_loop
T_1a46e:
	movem.l	a1-a2,-(a7)
	lea.l	Memory_list,a1
	movea.l	Memlist_end,a2
	bra.b	T_1a496
T_1a480:
	btst	#$7,$8(a1)
	bne.b	.l_1a492
	cmpa.l	(a1),a0
	bne.b	.l_1a492
	move.l	$4(a1),d0
	bra.b	T_1a49c
.l_1a492:
	lea.l	$c(a1),a1
T_1a496:
	cmpa.l	a2,a1
	bmi.b	T_1a480
	moveq	#0,d0
T_1a49c:
	movem.l	(a7)+,a1-a2
	rts
