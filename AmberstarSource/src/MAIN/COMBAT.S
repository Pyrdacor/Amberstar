; MAIN/COMBAT.ASM (original module, merged with the disassembly of the shipped program)

	section	text


; ---- Combat_ModInit (original source: MAIN/COMBAT.ASM) - the shipped program differs, its code follows, not assembled:
;Combat_ModInit:
;             jmp       Init_display

Combat_ModInit:
	sf.b	B_5bae0
	jsr	T_00194
	moveq	#16,d0
	jsr	Play_song
	lea.l	D_30f4c,a0
	jsr	Push_PA
	tst.b	Party_advantage
	beq.b	.l_15986
	tst.b	Monster_advantage
	beq.b	.l_15986
	clr.b	Party_advantage
	clr.b	Monster_advantage
.l_15986:
	clr.w	B_5ba06
	clr.w	B_5ba08
	clr.w	B_5b998
	move.w	#$ffff,B_5ba12
	clr.w	B_5ba14
	clr.w	B_5ba16
	clr.w	B_5ba18
	clr.w	B_5bae2
	clr.w	B_5be90
	sf.b	B_5badf
	bsr.w	Choose_particle_path
	lea.l	T_15bad,a0
	jsr	Load_file
	move.l	a0,B_5b93a
	lea.l	T_15bb9,a0
	jsr	Load_file
	move.l	a0,B_5b93e
	lea.l	.l_15b84,a0
	move.w	comback_nr,d0
	jsr	Load_subfile
	move.l	a0,B_5b944
	lea.l	.l_15b92,a0
	move.w	B_5b94c,d0
	jsr	Load_subfile
	move.l	a0,B_5b948
	bsr.w	T_15bc8
	lea.l	B_5ba40,a0
	moveq	#29,d7
.l_15a28:
	clr.l	(a0)+
	dbra	d7,.l_15a28
	movea.l	B_5b948,a0
	lea.l	$6(a0),a0
	moveq	#0,d0
	moveq	#0,d2
	moveq	#2,d7
.l_15a3e:
	move.b	(a0)+,d1
	lsl.w	#$2,d1
	moveq	#5,d6
.l_15a44:
	add.b	d1,d1
	addx.w	d2,d0
	dbra	d6,.l_15a44
	dbra	d7,.l_15a3e
	mulu.w	#$380,d0
	moveq	#0,d1
	lea.l	Chard_ptrs,a2
	moveq	#5,d7
.l_15a5e:
	tst.l	(a2)+
	beq.b	.l_15a64
	addq.w	#$1,d1
.l_15a64:
	dbra	d7,.l_15a5e
	mulu.w	#$e,d1
	add.l	d1,d0
	jsr	Allocate_memory
	movea.l	a1,a4
	move.l	a4,B_5bab8
	lea.l	B_5ba70,a5
	movea.l	B_5b948,a0
	lea.l	$6(a0),a1
	moveq	#2,d7
.l_15a8e:
	pea.l	-$18(a5)
	move.b	(a1)+,d1
	move.w	(a0)+,d0
	beq.b	.l_15ad2
	tst.b	d1
	beq.b	.l_15ad2
	bsr.w	T_15dd4
	moveq	#5,d6
	lsl.b	#$2,d1
.l_15aa4:
	add.b	d1,d1
	bcc.b	.l_15acc
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
	bsr.w	T_1836c
	movea.l	a1,a4
	movem.l	(a7)+,a0-a1
.l_15acc:
	addq.l	#$4,a5
	dbra	d6,.l_15aa4
.l_15ad2:
	movea.l	(a7)+,a5
	dbra	d7,.l_15a8e
	lea.l	B_5b9e2,a0
	bsr.w	T_15d6e
	lea.l	B_5eed0,a3
	lea.l	B_5ba88,a5
	lea.l	Chard_ptrs,a2
	moveq	#1,d6
	moveq	#5,d7
.l_15af8:
	moveq	#0,d0
	move.b	(a3)+,d0
	move.l	(a2)+,d1
	beq.b	.l_15b30
	lsl.w	#$2,d0
	tst.l	(a5,d0.w)
	beq.b	.l_15b14
	lea.l	D_31fa2,a1
	jsr	DI_Error
.l_15b14:
	movea.l	d1,a0
	move.b	$3a(a0),d2
	andi.w	#$e4,d2
	bne.b	.l_15b30
	move.l	a4,(a5,d0.w)
	move.w	#$ff00,(a4)+
	move.l	d1,(a4)+
	clr.w	(a4)+
	move.w	d6,(a4)+
	clr.l	(a4)+
.l_15b30:
	addq.w	#$1,d6
	dbra	d7,.l_15af8
	move.w	#$ffff,B_5b94e
	move.w	#$1,B_5ba0c
	clr.w	B_5ba0e
	moveq	#0,d0
	moveq	#3,d1
	tst.b	Monster_advantage
	beq.b	.l_15b5c
	moveq	#5,d0
	moveq	#0,d1
.l_15b5c:
	lea.l	B_5b956,a0
	lea.l	Char_status_icons,a1
	moveq	#5,d7
.l_15b6a:
	move.w	d0,(a0)
	addq.l	#$8,a0
	move.b	d1,(a1)+
	dbra	d7,.l_15b6a
	st.b	B_5bae0
	jsr	T_00208
	bra.w	Combat_DisInit
.l_15b84:
	dc.b	$0f,$63,$6f,$6d,$5f,$62,$61,$63,$6b,$2e,$61,$6d,$62,$00
.l_15b92:
	dc.b	$0c,$6d,$6f,$6e,$5f,$64,$61,$74,$61,$2e,$61,$6d,$62,$00
T_15ba0:
	dc.b	$10,$6d,$6f,$6e,$5f,$67,$66,$78,$2e,$61,$6d,$62,$00
T_15bad:
	dc.b	$13,$54,$41,$43,$54,$49,$43,$2e,$49,$43,$4e,$00
T_15bb9:
	dc.b	$14,$46,$5f,$54,$5f,$41,$4e,$49,$4d,$2e,$49,$43,$4e,$00,$00
T_15bc8:
	movem.l	d0-d7/a0-a6,-(a7)
	lea.l	Chard_filename,a3
	movea.l	a0,a4
	lea.l	B_5babc,a5
	move.w	(a4)+,d0
	move.w	d0,(a5)
	bne.b	.l_15bea
	clr.l	$2(a5)
	clr.l	$6(a5)
	bra.b	.l_15bf6
.l_15bea:
	movea.l	a3,a0
	jsr	Load_subfile
	move.l	a0,$2(a5)
.l_15bf6:
	lea.l	$a(a5),a5
	move.w	(a4)+,d0
	move.w	d0,(a5)
	bne.b	.l_15c0a
	clr.l	$2(a5)
	clr.l	$6(a5)
	bra.b	.l_15c24
.l_15c0a:
	cmp.w	-$a(a5),d0
	bne.b	.l_15c18
	move.l	-$8(a5),$2(a5)
	bra.b	.l_15c24
.l_15c18:
	movea.l	a3,a0
	jsr	Load_subfile
	move.l	a0,$2(a5)
.l_15c24:
	lea.l	$a(a5),a5
	move.w	(a4)+,d0
	move.w	d0,(a5)
	bne.b	.l_15c38
	clr.l	$2(a5)
	clr.l	$6(a5)
	bra.b	.l_15c60
.l_15c38:
	cmp.w	-$14(a5),d0
	bne.b	.l_15c46
	move.l	-$12(a5),$2(a5)
	bra.b	.l_15c60
.l_15c46:
	cmp.w	-$a(a5),d0
	bne.b	.l_15c54
	move.l	-$8(a5),$2(a5)
	bra.b	.l_15c60
.l_15c54:
	movea.l	a3,a0
	jsr	Load_subfile
	move.l	a0,$2(a5)
.l_15c60:
	lea.l	T_15ba0,a3
	lea.l	B_5babc,a5
	tst.w	(a5)
	beq.b	.l_15c86
	movea.l	$2(a5),a0
	moveq	#0,d0
	move.b	$3e(a0),d0
	movea.l	a3,a0
	jsr	Load_subfile
	move.l	a0,$6(a5)
.l_15c86:
	lea.l	$a(a5),a5
	tst.w	(a5)
	beq.b	.l_15cba
	movea.l	$2(a5),a0
	moveq	#0,d0
	move.b	$3e(a0),d0
	movea.l	-$8(a5),a1
	moveq	#0,d1
	move.b	$3e(a1),d1
	cmp.w	d0,d1
	bne.b	.l_15cae
	move.l	-$4(a5),$6(a5)
	bra.b	.l_15cba
.l_15cae:
	movea.l	a3,a0
	jsr	Load_subfile
	move.l	a0,$6(a5)
.l_15cba:
	lea.l	$a(a5),a5
	tst.w	(a5)
	beq.b	.l_15d04
	movea.l	$2(a5),a0
	moveq	#0,d0
	move.b	$3e(a0),d0
	movea.l	-$12(a5),a1
	moveq	#0,d1
	move.b	$3e(a1),d1
	cmp.w	d0,d1
	bne.b	.l_15ce2
	move.l	-$e(a5),$6(a5)
	bra.b	.l_15d04
.l_15ce2:
	movea.l	-$8(a5),a1
	moveq	#0,d1
	move.b	$3e(a1),d1
	cmp.w	d0,d1
	bne.b	.l_15cf8
	move.l	-$4(a5),$6(a5)
	bra.b	.l_15d04
.l_15cf8:
	movea.l	a3,a0
	jsr	Load_subfile
	move.l	a0,$6(a5)
.l_15d04:
	movem.l	(a7)+,d0-d7/a0-a6
	rts
T_15d0a:
	tst.b	B_5badd
	bne.b	.l_15d20
	bset	#$7,$4(a0)
	bclr	#$7,$5(a0)
	bra.b	.l_15d2c
.l_15d20:
	bclr	#$7,$4(a0)
	bset	#$7,$5(a0)
.l_15d2c:
	rts
T_15d2e:
	btst	#$1,Mouse_button_state
	bne.b	T_15d2e
	move.w	#$0,Draw_Cicon
	jsr	My_vsync
	sf.b	B_5badd
	rts
T_15d4e:
	btst	#$1,Mouse_button_state
	bne.b	T_15d4e
	move.w	#$0,Draw_Cicon
	jsr	My_vsync
	st.b	B_5badd
	rts
T_15d6e:
	movem.l	d0-d7/a0-a3,-(a7)
	movea.l	a0,a1
	moveq	#8,d7
.l_15d76:
	clr.w	(a1)+
	dbra	d7,.l_15d76
	lea.l	B_5ba40,a1
	moveq	#17,d7
.l_15d84:
	move.l	(a1)+,d0
	beq.b	.l_15da2
	movea.l	d0,a2
	movea.l	$2(a2),a2
	movea.l	a0,a3
.l_15d90:
	tst.l	(a3)
	beq.b	.l_15d9c
	cmpa.l	(a3),a2
	beq.b	.l_15d9e
	addq.l	#$6,a3
	bra.b	.l_15d90
.l_15d9c:
	move.l	a2,(a3)
.l_15d9e:
	addq.w	#$1,$4(a3)
.l_15da2:
	dbra	d7,.l_15d84
	movem.l	(a7)+,d0-d7/a0-a3
	rts
T_15dac:
	movem.l	d7/a0-a1,-(a7)
	moveq	#2,d7
.l_15db2:
	cmpa.l	(a0),a1
	beq.b	.l_15dca
	addq.l	#$6,a0
	dbra	d7,.l_15db2
	lea.l	D_31fe5,a1
	jsr	DI_Error
	moveq	#0,d0
.l_15dca:
	move.w	$4(a0),d0
	movem.l	(a7)+,d7/a0-a1
	rts
T_15dd4:
	move.w	d7,-(a7)
	moveq	#2,d7
	lea.l	B_5babc,a2
.l_15dde:
	cmp.w	(a2)+,d0
	beq.b	.l_15df4
	addq.l	#$8,a2
	dbra	d7,.l_15dde
	lea.l	D_3200d,a1
	jsr	DI_Error
.l_15df4:
	movea.l	$4(a2),a3
	movea.l	(a2),a2
	move.w	(a7)+,d7
	rts

; ---- Combat_ModExit (original source: MAIN/COMBAT.ASM) - the shipped program differs, its code follows, not assembled:
;Combat_ModExit:
;             jsr       Exit_display
;             jmp       Pop_Module

Combat_ModExit:
	bsr.w	Combat_DisExit
	sf.b	B_5bae0
	movea.l	B_5b93a,a0
	jsr	Free_memory
	movea.l	B_5b93e,a0
	jsr	Free_memory
	movea.l	B_5b944,a0
	jsr	Free_memory
	movea.l	B_5b948,a0
	jsr	Free_memory
	lea.l	B_5babc,a4
	moveq	#2,d7
.l_15e40:
	move.l	$2(a4),d0
	beq.b	.l_15e68
	movea.l	d0,a0
	jsr	Free_memory
	movea.l	a4,a0
	move.w	d7,d6
	move.l	$2(a4),d0
.l_15e56:
	cmp.l	$2(a0),d0
	bne.b	.l_15e60
	clr.l	$2(a0)
.l_15e60:
	adda.w	#$a,a0
	dbra	d6,.l_15e56
.l_15e68:
	adda.w	#$a,a4
	dbra	d7,.l_15e40
	lea.l	B_5babc,a4
	moveq	#2,d7
.l_15e78:
	move.l	$6(a4),d0
	beq.b	.l_15ea0
	movea.l	d0,a0
	jsr	Free_memory
	movea.l	a4,a0
	move.w	d7,d6
	move.l	$6(a4),d0
.l_15e8e:
	cmp.l	$6(a0),d0
	bne.b	.l_15e98
	clr.l	$6(a0)
.l_15e98:
	adda.w	#$a,a0
	dbra	d6,.l_15e8e
.l_15ea0:
	adda.w	#$a,a4
	dbra	d7,.l_15e78
	jsr	Set_map_music
	jsr	Pop_PA
	rts

; ---- Combat_DisInit (original source: MAIN/COMBAT.ASM) - the shipped program differs, its code follows, not assembled:
;Combat_DisInit:
;             DIAG_ON
;             PRINT     "Insert combat screen here..."
;             jsr       Wait_4_key
;             DIAG_OFF
;             rts

Combat_DisInit:
	move.w	#$10,Mesmin_X
	move.w	#$b1,Mesmin_Y
	move.w	#$b0,Mesmin_Wd
	move.l	#Code0004Sys,Textfile_ptr
	move.l	#D_30f44,PlusMes_info
	movea.l	Off_screen,a6
	moveq	#4,d0
	jsr	Show_layout
	lea.l	D_30f58,a0
	bsr.w	T_15d0a
	move.l	a0,Control_list_ptr
	jsr	Show_control_icons
	move.l	#Blink_markers,B_5b952
	bsr.w	T_15f8e
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	D_30ffa,a0
	jsr	Set_layout_data
	move.w	comback_nr,d0
	lea.l	D_30f9e,a0
	lea.l	D_30fa0,a1
	mulu.w	#$6,d0
	adda.w	d0,a1
	move.l	(a1)+,(a0)+
	move.w	(a1)+,(a0)+
	lea.l	D_30f86,a1
	lea.l	Subfade1,a2
.l_15f54:
	lea.l	D_3100c,a0
	jsr	Update_HBL
	jsr	My_vsync
	jsr	My_vsync
	lea.l	D_31030,a0
	jsr	Fade_pal
	bne.b	.l_15f54
	lea.l	D_3100c,a0
	jsr	Update_HBL
	rts
T_15f88:
	movem.l	d0-d7/a0-a6,-(a7)
	bra.b	T_15f96
T_15f8e:
	movem.l	d0-d7/a0-a6,-(a7)
	bsr.w	T_18418
T_15f96:
	lea.l	$1f08(a6),a1
	move.l	#$10001,d0
	moveq	#-1,d1
	moveq	#4,d7
.l_15fa4:
	moveq	#14,d6
.l_15fa6:
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
	dbra	d6,.l_15fa6
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
	dbra	d7,.l_15fa4
	lea.l	B_5ba40,a4
	moveq	#0,d4
	moveq	#0,d5
	moveq	#29,d7
.l_15ff2:
	move.l	(a4)+,d0
	beq.b	.l_16030
	movea.l	d0,a0
	moveq	#0,d2
	cmpi.b	#$ff,(a0)
	bne.b	.l_1600a
	movea.l	$2(a0),a2
	move.b	$5(a2),d2
	bra.b	.l_16016
.l_1600a:
	movea.l	$2(a0),a2
	move.b	$3e(a2),d2
	addi.w	#$9,d2
.l_16016:
	move.w	d4,d0
	move.w	d5,d1
	mulu.w	#$3,d2
	move.w	$6(a0),d3
	add.w	d3,d3
	lea.l	.l_16054(pc),a2
	add.w	(a2,d3.w),d2
	bsr.w	T_1646c
.l_16030:
	addq.w	#$1,d4
	cmpi.w	#$6,d4
	bne.b	.l_1603c
	moveq	#0,d4
	addq.w	#$1,d5
.l_1603c:
	dbra	d7,.l_15ff2
	move.l	B_5b952,d0
	beq.b	.l_1604c
	movea.l	d0,a0
	jsr	(a0)
.l_1604c:
	bsr.b	Show_damage
	movem.l	(a7)+,d0-d7/a0-a6
	rts
.l_16054:
	dc.b	$00,$00,$00,$01,$00,$02,$00,$01
; Shows the damage of a participant in its tactical cell (monsters for 100 VBL, party members for 70 VBL).
Show_damage:
	movem.l	d0-d2/d4-d5/d7/a0/a4,-(a7)
	lea.l	B_5ba40,a4
	moveq	#0,d4
	moveq	#57,d5
	moveq	#17,d7
.l_1606c:
	move.l	(a4)+,d0
	beq.b	.l_16088
	movea.l	d0,a0
	tst.w	$10(a0)
	beq.b	.l_16088
	move.w	$12(a0),d2
	move.w	d4,d0
	addi.w	#$d,d0
	move.w	d5,d1
	bsr.w	Draw_damage_digits
.l_16088:
	addq.w	#$1,d4
	cmpi.w	#$6,d4
	bne.b	.l_16096
	moveq	#0,d4
	addi.w	#$10,d5
.l_16096:
	dbra	d7,.l_1606c
	moveq	#11,d7
.l_1609c:
	move.l	(a4)+,d0
	beq.b	.l_160b8
	movea.l	d0,a0
	tst.w	$a(a0)
	beq.b	.l_160b8
	move.w	$c(a0),d2
	move.w	d4,d0
	addi.w	#$d,d0
	move.w	d5,d1
	bsr.w	Draw_damage_digits
.l_160b8:
	addq.w	#$1,d4
	cmpi.w	#$6,d4
	bne.b	.l_160c6
	moveq	#0,d4
	addi.w	#$10,d5
.l_160c6:
	dbra	d7,.l_1609c
	movem.l	(a7)+,d0-d2/d4-d5/d7/a0/a4
	rts
T_160d0:
	movem.l	d0-d2/a3-a4,-(a7)
	move.w	d1,d2
	bsr.w	T_1642c
	tst.w	d1
	beq.b	.l_160e8
	move.w	#$46,$a(a4)
	move.w	d2,$c(a4)
.l_160e8:
	movem.l	(a7)+,d0-d2/a3-a4
	rts
T_160ee:
	move.w	Active_member,d0
	beq.b	.l_16160
	bsr.w	T_1642c
	movem.w	d0-d1,-(a7)
	moveq	#10,d2
	bsr.w	Draw_grid_frame
	movem.w	(a7)+,d2-d3
	move.w	B_5b950,d0
	btst	#$4,d0
	bne.b	.l_1612a
	moveq	#0,d6
.l_16116:
	bsr.w	Get_move_targets
	tst.w	d0
	bmi.b	.l_16160
	move.w	d2,-(a7)
	moveq	#9,d2
	bsr.w	Draw_cell_frame
	move.w	(a7)+,d2
	bra.b	.l_16116
.l_1612a:
	moveq	#1,d7
	lea.l	B_5b956,a0
	movem.w	(a0),d0-d2
	cmpi.w	#$1,d0
	bne.b	.l_16156
	move.w	d1,d0
	move.w	d2,d1
	cmp.w	Active_member,d7
	beq.b	.l_16150
	moveq	#6,d2
	bsr.w	Draw_cell_cross
	bra.b	.l_16156
.l_16150:
	dc.b	$74,$06,$61,$00,$04,$24
.l_16156:
	dc.b	$50,$88,$52,$47,$0c,$47,$00,$07,$66,$d2
.l_16160:
	rts
T_16162:
	move.w	Active_member,d0
	beq.b	.l_161ae
	bsr.w	T_1642c
	movem.w	d0-d1,-(a7)
	moveq	#10,d2
	bsr.w	Draw_grid_frame
	movem.w	(a7)+,d2-d3
	move.w	B_5b950,d0
	btst	#$4,d0
	bne.b	.l_161ae
	moveq	#0,d0
	moveq	#0,d1
	moveq	#17,d7
	lea.l	B_5ba40,a0
.l_16194:
	tst.l	(a0)+
	beq.b	.l_1619e
	moveq	#1,d2
	bsr.w	Draw_cell_frame
.l_1619e:
	addq.w	#$1,d0
	cmpi.w	#$6,d0
	bne.b	.l_161aa
	moveq	#0,d0
	addq.w	#$1,d1
.l_161aa:
	dbra	d7,.l_16194
.l_161ae:
	rts
T_161b0:
	move.w	B_5b950,d0
	btst	#$4,d0
	bne.b	.l_161e2
	moveq	#0,d0
	moveq	#3,d1
	moveq	#11,d7
	lea.l	B_5ba88,a0
.l_161c8:
	tst.l	(a0)+
	beq.b	.l_161d2
	moveq	#1,d2
	bsr.w	Draw_cell_frame
.l_161d2:
	addq.w	#$1,d0
	cmpi.w	#$6,d0
	bne.b	.l_161de
	moveq	#0,d0
	addq.w	#$1,d1
.l_161de:
	dbra	d7,.l_161c8
.l_161e2:
	rts
T_161e4:
	move.w	Active_member,d0
	beq.b	.l_1624a
	bsr.w	T_1642c
	movem.w	d0-d1,-(a7)
	moveq	#10,d2
	bsr.w	Draw_grid_frame
	movem.w	(a7)+,d2-d3
	move.w	B_5b950,d0
	btst	#$4,d0
	bne.b	.l_1624a
	moveq	#0,d0
	move.w	Mouse_Y,d1
	subi.w	#$30,d1
	bmi.b	.l_1624a
	lsr.w	#$4,d1
	cmpi.w	#$3,d1
	bge.b	.l_1624a
	moveq	#5,d7
	lea.l	B_5ba40,a0
	move.w	d1,d2
	mulu.w	#$18,d2
	adda.w	d2,a0
.l_16230:
	tst.l	(a0)+
	beq.b	.l_1623a
	moveq	#1,d2
	bsr.w	Draw_cell_frame
.l_1623a:
	addq.w	#$1,d0
	cmpi.w	#$6,d0
	bne.b	.l_16246
	moveq	#0,d0
	addq.w	#$1,d1
.l_16246:
	dbra	d7,.l_16230
.l_1624a:
	rts
T_1624c:
	move.w	Active_member,d0
	beq.b	.l_162aa
	bsr.w	T_1642c
	movem.w	d0-d1,-(a7)
	moveq	#10,d2
	bsr.w	Draw_grid_frame
	movem.w	(a7)+,d2-d3
	move.w	B_5b950,d0
	btst	#$4,d0
	bne.b	.l_16288
	moveq	#0,d6
.l_16274:
	bsr.w	Get_melee_targets
	tst.w	d0
	bmi.b	.l_162aa
	move.w	d2,-(a7)
	moveq	#1,d2
	bsr.w	Draw_cell_frame
	move.w	(a7)+,d2
	bra.b	.l_16274
.l_16288:
	dc.b	$41,$f9
	dc.l	B_5b956
	dc.b	$30,$39
	dc.l	Active_member
	dc.b	$53,$40,$e7,$48,$d0,$c0,$0c,$58,$00,$03,$66,$0a,$30,$18,$32,$18
	dc.b	$74,$05,$61,$00,$02,$d0
.l_162aa:
	rts
; The free neighbour cells in the party rows which no other member wants to move to.
Get_move_targets:
	movem.l	d4-d5/a0,-(a7)
	move.w	Active_member,d5
	neg.w	d5
	addq.w	#$6,d5
.l_162ba:
	cmpi.w	#$8,d6
	beq.b	.l_16324
	move.w	d6,d4
	lsl.w	#$2,d4
	movem.w	.l_1632c(pc,d4.w),d0-d1
	add.w	d2,d0
	bmi.b	.l_16320
	add.w	d3,d1
	cmpi.w	#$5,d0
	bgt.b	.l_16320
	cmpi.w	#$4,d1
	bgt.b	.l_16320
	cmpi.w	#$3,d1
	blt.b	.l_16320
	lea.l	B_5ba40,a0
	move.w	d1,d4
	mulu.w	#$6,d4
	add.w	d0,d4
	lsl.w	#$2,d4
	tst.l	(a0,d4.w)
	bne.b	.l_16320
	addq.w	#$1,d6
	lea.l	B_5b956,a0
	moveq	#5,d4
.l_16302:
	cmp.w	d5,d4
	beq.b	.l_16318
	cmpi.w	#$1,(a0)
	bne.b	.l_16318
	cmp.w	$2(a0),d0
	bne.b	.l_16318
	cmp.w	$4(a0),d1
	beq.b	.l_162ba
.l_16318:
	addq.l	#$8,a0
	dbra	d4,.l_16302
	bra.b	.l_16326
.l_16320:
	addq.w	#$1,d6
	bra.b	.l_162ba
.l_16324:
	moveq	#-1,d0
.l_16326:
	movem.l	(a7)+,d4-d5/a0
	rts
.l_1632c:
	dc.b	$ff,$ff,$ff,$ff,$00,$00,$ff,$ff,$00,$01,$ff,$ff,$ff,$ff,$00,$00
	dc.b	$00,$01,$00,$00,$ff,$ff,$00,$01,$00,$00,$00,$01,$00,$01,$00,$01
; Melee attacks only from the front row against the cell in front or diagonal in front. Ranged weapons reach every monster.
Get_melee_targets:
	tst.w	B_5b98a
	bne.b	.l_163ac
	movem.l	d4/a0,-(a7)
.l_16358:
	cmpi.w	#$3,d6
	beq.b	.l_16398
	move.w	d6,d4
	lsl.w	#$2,d4
	movem.w	.l_163a0(pc,d4.w),d0-d1
	add.w	d2,d0
	bmi.b	.l_16394
	add.w	d3,d1
	cmpi.w	#$5,d0
	bgt.b	.l_16394
	cmpi.w	#$2,d1
	bne.b	.l_16394
	lea.l	B_5ba40,a0
	move.w	d1,d4
	mulu.w	#$6,d4
	add.w	d0,d4
	lsl.w	#$2,d4
	tst.l	(a0,d4.w)
	beq.b	.l_16394
	addq.w	#$1,d6
	bra.b	.l_1639a
.l_16394:
	addq.w	#$1,d6
	bra.b	.l_16358
.l_16398:
	moveq	#-1,d0
.l_1639a:
	movem.l	(a7)+,d4/a0
	rts
.l_163a0:
	dc.b	$00,$00,$ff,$ff,$ff,$ff,$ff,$ff,$00,$01,$ff,$ff
.l_163ac:
	movem.l	d4/a0,-(a7)
	lea.l	B_5ba40,a0
	move.w	d6,d0
	lsl.w	#$2,d0
	adda.w	d0,a0
.l_163bc:
	cmpi.w	#$12,d6
	beq.b	.l_163da
	move.w	d6,d1
	ext.l	d1
	divu.w	#$6,d1
	move.l	d1,d0
	swap	d0
	tst.l	(a0)+
	beq.b	.l_163d6
	addq.w	#$1,d6
	bra.b	.l_163dc
.l_163d6:
	addq.w	#$1,d6
	bra.b	.l_163bc
.l_163da:
	moveq	#-1,d0
.l_163dc:
	movem.l	(a7)+,d4/a0
	rts
; The markers on the tactical battle field blink.
Blink_markers:
	move.w	B_5b950,d0
	btst	#$4,d0
	bne.b	.l_1642a
	move.w	Active_member,d0
	beq.b	.l_1642a
	bsr.b	T_1642c
	moveq	#9,d2
	bsr.w	Draw_grid_frame
	lea.l	B_5b956,a0
	move.w	Active_member,d0
	subq.w	#$1,d0
	lsl.w	#$3,d0
	adda.w	d0,a0
	move.w	(a0)+,d0
	cmpi.w	#$1,d0
	beq.b	.l_16420
	cmpi.w	#$3,d0
	beq.b	.l_16420
	bra.b	.l_1642a
.l_16420:
	dc.b	$30,$18,$32,$18,$74,$06,$61,$00,$01,$50
.l_1642a:
	rts
T_1642c:
	movem.l	d2-d7/a0-a1,-(a7)
	lea.l	B_5ba88,a0
	move.w	d0,d2
	moveq	#0,d0
	moveq	#3,d1
	moveq	#11,d7
.l_1643e:
	move.l	(a0)+,d3
	beq.b	.l_1644a
	movea.l	d3,a1
	cmp.w	$8(a1),d2
	beq.b	.l_16460
.l_1644a:
	addq.w	#$1,d0
	cmpi.w	#$6,d0
	bne.b	.l_16456
	moveq	#0,d0
	addq.w	#$1,d1
.l_16456:
	dbra	d7,.l_1643e
	moveq	#0,d0
	moveq	#0,d1
	move.l	a1,d3
.l_16460:
	movea.l	d3,a4
	lea.l	-$4(a0),a3
	movem.l	(a7)+,d2-d7/a0-a1
	rts
T_1646c:
	movem.l	d0-d2/a0,-(a7)
	lsl.w	#$7,d2
	movea.l	B_5b93a,a0
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
	lea.l	.l_164ec,a0
	lsl.w	#$4,d2
	moveq	#16,d7
.l_164b6:
	move.w	d2,d3
	move.l	(a0)+,d0
	move.l	d0,d1
	not.l	d1
	moveq	#3,d4
.l_164c0:
	add.b	d3,d3
	bcc.b	.l_164d0
	or.w	d0,-(a1)
	swap	d0
	or.w	d0,-$8(a1)
	swap	d0
	bra.b	.l_164da
.l_164d0:
	dc.b	$c3,$61,$48,$41,$c3,$69,$ff,$f8,$48,$41
.l_164da:
	dbra	d4,.l_164c0
	lea.l	$a8(a1),a1
	dbra	d7,.l_164b6
	movem.l	(a7)+,d0-d7/a0-a6
	rts
.l_164ec:
	dc.b	$00,$01,$ff,$ff,$00,$01,$00,$01,$00,$01,$00,$01,$00,$01,$00,$01
	dc.b	$00,$01,$00,$01,$00,$01,$00,$01,$00,$01,$00,$01,$00,$01,$00,$01
	dc.b	$00,$01,$00,$01,$00,$01,$00,$01,$00,$01,$00,$01,$00,$01,$00,$01
	dc.b	$00,$01,$00,$01,$00,$01,$00,$01,$00,$01,$00,$01,$00,$01,$00,$01
	dc.b	$00,$01,$ff,$ff
T_16530:
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
	bra.b	T_16582
; A frame inside of a cell.
Draw_cell_frame:
	movem.l	d0-d7/a0-a6,-(a7)
	lea.l	T_16530,a0
T_16582:
	lsl.w	#$4,d1
	addi.w	#$31,d1
	mulu.w	#$a0,d1
	addi.w	#$d,d0
	lsl.w	#$3,d0
	add.w	d1,d0
	lea.l	$8(a6,d0.w),a1
	lsl.w	#$4,d2
	moveq	#14,d7
.l_1659c:
	move.w	d2,d3
	move.w	(a0)+,d0
	move.w	d0,d1
	not.w	d1
	moveq	#3,d4
.l_165a6:
	add.b	d3,d3
	bcc.b	.l_165ae
	or.w	d0,-(a1)
	bra.b	.l_165b0
.l_165ae:
	dc.b	$c3,$61
.l_165b0:
	dbra	d4,.l_165a6
	lea.l	$a8(a1),a1
	dbra	d7,.l_1659c
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
	lea.l	T_16646,a0
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
T_1660a:
	moveq	#0,d0
	move.b	(a0)+,d0
	lsl.w	#$8,d0
	moveq	#0,d1
	move.b	(a1)+,d1
T_16614:
	lsl.w	#$3,d1
	or.w	d1,d0
T_16618:
	moveq	#0,d1
	move.b	(a2)+,d1
	lsr.w	#$2,d1
	or.w	d1,d0
	move.w	d0,d1
	not.w	d1
	or.w	d0,(a5)+
T_16626:
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
	dbra	d2,T_1660a
	movem.l	(a7)+,d0-d2/a0-a2/a5
	rts
T_16646:
	bra.b	T_16618
	adda.w	(a0),a0
	bra.b	T_1667c
	moveq	#48,d0
	move.w	$30(a0,a6.w),d0
	bra.b	T_16614
	dc.w	$f0e0
	movea.w	-(a0),a0
	move.w	-(a0),(a0)+
	movea.l	-(a0),a0
	adda.w	-$10(a0,d3.w),a0
	mulu.w	-(a0),d0
	move.w	-(a0),(a0)+
	bra.b	T_16626
	dc.b	$e0,$d0,$60,$f0,$30,$60,$c0,$c0,$60,$d0,$60,$d0,$60,$60,$b0,$70
	dc.b	$30,$60
; While the actions are chosen, random participants show their frames (not stunned or sleeping ones).
Idle_animations:
	movem.l	d0/d6-d7/a0/a4,-(a7)
T_1667c:
	move.w	B_5b950,d5
	andi.w	#$7,d5
	bne.b	.l_166d4
	jsr	Random
	andi.w	#$f,d0
	move.w	d0,d6
	lea.l	B_5ba40,a4
	moveq	#29,d7
.l_1669c:
	move.l	(a4)+,d0
	beq.b	.l_166d0
	movea.l	d0,a0
	tst.w	$6(a0)
	beq.b	.l_166b2
	addq.w	#$1,$6(a0)
	andi.w	#$3,$6(a0)
.l_166b2:
	subq.w	#$1,d6
	move.w	$2e(a1),d0
	andi.w	#$104,d0
	bne.b	.l_166d0
	andi.w	#$f,d6
	bne.b	.l_166d0
	tst.w	$6(a0)
	bne.b	.l_166d0
	move.w	#$1,$6(a0)
.l_166d0:
	dbra	d7,.l_1669c
.l_166d4:
	movem.l	(a7)+,d0/d6-d7/a0/a4
	rts
; Next frame of the attack animation of a monster.
Attack_animation_step:
	movem.l	d0/d6-d7/a0/a4,-(a7)
	subq.w	#$1,B_5ba18
	bgt.b	.l_16760
	move.w	#$6,B_5ba18
	tst.b	B_5badd
	beq.b	.l_166fe
	move.w	#$4,B_5ba18
.l_166fe:
	lea.l	T_18616,a3
	lea.l	B_5ba40,a4
	lea.l	T_185aa,a5
	moveq	#0,d6
	moveq	#17,d7
.l_16714:
	move.l	(a4)+,d0
	beq.b	.l_16754
	movea.l	d0,a0
	move.w	$e(a0),d0
	beq.b	.l_16754
	moveq	#-1,d6
	add.w	d0,$c(a0)
	bne.b	.l_1672e
	clr.w	$e(a0)
	bra.b	.l_16754
.l_1672e:
	movea.l	$2(a0),a1
	moveq	#0,d1
	move.b	$3e(a1),d1
	subq.w	#$1,d1
	lsl.w	#$2,d1
	add.w	$4(a5),d1
	move.b	(a3,d1.w),d1
	cmp.w	$c(a0),d1
	bne.b	.l_16754
	subq.w	#$1,$c(a0)
	neg.w	d0
	move.w	d0,$e(a0)
.l_16754:
	addq.l	#$6,a5
	dbra	d7,.l_16714
	move.w	d6,B_5ba14
.l_16760:
	movem.l	(a7)+,d0/d6-d7/a0/a4
	rts
; A monster which attacks or casts a spell shows the frames 1 to count-1 and back to 0.
Start_attack_animation:
	movem.l	d0-d1/a0,-(a7)
	moveq	#0,d0
	moveq	#0,d1
	move.b	$2(a4),d0
	move.b	$3(a4),d1
	lea.l	B_5ba40,a0
	mulu.w	#$6,d1
	add.w	d1,d0
	lsl.w	#$2,d0
	movea.l	(a0,d0.w),a0
	move.w	#$1,$e(a0)
	clr.w	B_5ba12
	move.w	#$1,B_5ba14
	move.w	#$6,B_5ba18
	movem.l	(a7)+,d0-d1/a0
	rts
; The next action waits until the animation is finished.
Wait_for_animation:
	movem.l	d0-d7/a0-a6,-(a7)
	tst.w	B_5ba14
	beq.b	T_16808
	sf.b	B_5badc
	lea.l	D_304fa,a0
	bsr.w	Push_Module
	move.w	#$1,B_5ba12
.l_167ce:
	move.w	#$0,Draw_Cicon
	bsr.w	Input_handler
	movea.l	Module_sp,a0
	move.l	(a0),d0
	beq.b	.l_167e8
	movea.l	d0,a0
	jsr	(a0)
.l_167e8:
	jsr	Switch_screen
	tst.b	B_5badc
	beq.b	.l_167ce
	tst.b	B_5badd
	bne.b	T_16802
T_167fe:
	bsr.w	T_1866a
T_16802:
	movem.l	(a7)+,d0-d7/a0-a6
	rts
T_16808:
	tst.b	B_5badd
	beq.b	T_167fe
	clr.w	B_5b950
.l_16816:
	jsr	My_vsync
	movea.l	Off_screen,a6
	bsr.w	T_15f88
	jsr	Switch_screen
	cmpi.w	#$32,B_5b950
	blt.b	.l_16816
	bra.b	T_16802

; ---- Combat_DisExit (original source: MAIN/COMBAT.ASM) - the shipped program differs, its code follows, not assembled:
;Combat_DisExit:
;             rts

Combat_DisExit:
	lea.l	Void,a1
	lea.l	Subfade1,a2
.l_16844:
	lea.l	D_3100c,a0
	jsr	Update_HBL
	jsr	My_vsync
	jsr	My_vsync
	lea.l	D_31030,a0
	jsr	Fade_pal
	bne.b	.l_16844
	lea.l	D_3100c,a0
	jsr	Update_HBL
	rts
T_16878:
	move.w	Mouse_X,d0
	move.w	Mouse_Y,d1
	subi.w	#$d0,d0
	bmi.b	.l_168c8
	subi.w	#$30,d1
	bmi.b	.l_168c8
	lsr.w	#$4,d0
	lsr.w	#$4,d1
	cmpi.w	#$5,d0
	bgt.b	.l_168c8
	cmpi.w	#$3,d1
	blt.b	.l_168c8
	cmpi.w	#$4,d1
	bgt.b	.l_168c8
	mulu.w	#$6,d1
	add.w	d1,d0
	lsl.w	#$2,d0
	lea.l	B_5ba40,a0
	move.l	(a0,d0.w),d0
	beq.b	.l_168c8
	movea.l	d0,a0
	move.w	$8(a0),d0
	lsl.w	#$8,d0
	jsr	Member_left
.l_168c8:
	rts

; ---- Combat_DisUpd (original source: MAIN/COMBAT.ASM) - the shipped program differs, its code follows, not assembled:
;Combat_DisUpd:
;             rts

Combat_DisUpd:
	lea.l	D_30f58,a0
	lea.l	T_15d0a,a1
	jsr	Update_control_icons
	tst.b	Monster_advantage
	beq.b	.l_168f8
	clr.b	Monster_advantage
	bsr.w	Monster_actions
	tst.b	B_5bade
	bne.w	.l_16a4a
.l_168f8:
	tst.w	B_5ba0c
	beq.b	.l_1690a
	clr.w	B_5ba0c
	bsr.w	Prepare_party_actions
.l_1690a:
	movea.l	Off_screen,a6
	move.w	Active_member,d0
	cmp.w	B_5b94e,d0
	beq.w	.l_16a4a
	move.w	d0,B_5b94e
	movea.l	Control_list_ptr,a5
	move.b	#$2,CIL_update
	andi.l	#$7f7f7f7f,(a5)
	andi.w	#$7f7f,$6(a5)
	andi.b	#$7f,$8(a5)
	move.w	Active_member,d0
	bsr.w	T_1642c
	move.w	d0,d2
	move.w	d1,d3
	movea.l	$2(a4),a4
	btst	#$2,$3b(a4)
	bne.b	.l_16970
	btst	#$1,$3b(a4)
	bne.b	.l_16970
	btst	#$3,$3b(a4)
	beq.b	.l_16990
.l_16970:
	bset	#$7,(a5)
	bset	#$7,$3(a5)
	bset	#$7,$6(a5)
	bset	#$7,$7(a5)
	bset	#$7,$8(a5)
	bra.w	.l_16a4a
.l_16990:
	btst	#$0,$3a(a4)
	beq.b	.l_169b2
	bset	#$7,(a5)
	bset	#$7,$3(a5)
	bset	#$7,$6(a5)
	bset	#$7,$7(a5)
	bra.w	.l_16a36
.l_169b2:
	moveq	#0,d6
	bsr.w	Get_move_targets
	tst.w	d0
	bpl.b	.l_169c2
	bset	#$7,$3(a5)
.l_169c2:
	clr.w	B_5b98a
	moveq	#0,d0
	move.b	$1f(a4),d0
	add.w	$96(a4),d0
	ble.b	.l_16a26
	tst.b	$25(a4)
	beq.b	.l_16a1c
	lea.l	$1aa(a4),a0
	cmpi.b	#$5,$1(a0)
	bne.b	.l_16a1c
	tst.b	$2(a0)
	beq.b	.l_16a08
	tst.b	$27(a4)
	beq.b	.l_16a26
	lea.l	$1fa(a4),a1
	cmpi.b	#$6,$1(a1)
	bne.b	.l_16a26
	move.b	$2(a0),d0
	cmp.b	$f(a1),d0
	bne.b	.l_16a26
.l_16a08:
	move.w	#$1,B_5b98a
	moveq	#0,d6
	bsr.w	Get_melee_targets
	tst.w	d0
	bpl.b	.l_16a2c
	bra.b	.l_16a26
.l_16a1c:
	moveq	#0,d6
	bsr.w	Get_melee_targets
	tst.w	d0
	bpl.b	.l_16a2c
.l_16a26:
	bset	#$7,$6(a5)
.l_16a2c:
	cmpi.w	#$4,d3
	beq.b	.l_16a36
	bset	#$7,(a5)
.l_16a36:
	btst	#$0,$3b(a4)
	bne.b	.l_16a44
	tst.b	$1a(a4)
	bne.b	.l_16a4a
.l_16a44:
	bset	#$7,$8(a5)
.l_16a4a:
	jsr	Update_status_block
	rts
T_16a52:
	tst.b	B_5bae0
	beq.b	.l_16a64
	movea.l	Off_screen,a6
	bsr.w	T_15f8e
.l_16a64:
	rts
; Resets the actions for the next round and chooses the actions of members which can't act on their own.
Prepare_party_actions:
	lea.l	B_5b956,a5
	moveq	#5,d7
.l_16a6e:
	move.w	(a5),d0
	beq.b	.l_16ab2
	cmpi.w	#$1,d0
	beq.b	.l_16ab0
	cmpi.w	#$2,d0
	beq.b	.l_16ab2
	cmpi.w	#$3,d0
	beq.b	.l_16a92
	cmpi.w	#$4,d0
	beq.b	.l_16a8e
	clr.w	(a5)
	bra.b	.l_16ab2
.l_16a8e:
	clr.w	(a5)
	bra.b	.l_16ab2
.l_16a92:
	move.w	$2(a5),d0
	move.w	$4(a5),d1
	mulu.w	#$6,d1
	add.w	d1,d0
	lsl.w	#$2,d0
	lea.l	B_5ba40,a3
	tst.l	(a3,d0.w)
	beq.b	.l_16ab0
	bra.b	.l_16ab2
.l_16ab0:
	clr.w	(a5)
.l_16ab2:
	addq.l	#$8,a5
	dbra	d7,.l_16a6e
	lea.l	B_5b956,a0
	lea.l	Chard_ptrs,a1
	moveq	#1,d5
	moveq	#5,d7
T_16ac8:
	move.l	(a1)+,d0
	beq.w	T_16b60
	movea.l	d0,a2
	move.w	d5,d0
	bsr.w	T_1642c
	move.b	$3a(a2),d6
	move.b	$3b(a2),d4
	btst	#$2,d6
	bne.b	.l_16b02
	tst.w	d1
	beq.b	T_16b60
	btst	#$0,d6
	bne.b	.l_16b0e
	btst	#$2,d4
	bne.b	T_16b5c
	btst	#$3,d4
	bne.b	Panic_action
	btst	#$1,d4
	bne.b	.l_16b08
	bra.b	T_16b60
.l_16b02:
	move.w	#$7,(a0)
	bra.b	T_16b60
.l_16b08:
	bsr.w	Mad_action
	bra.b	T_16b60
.l_16b0e:
	move.w	#$6,(a0)
	bra.b	T_16b60
; Panicking members flee from the back row or move back.
Panic_action:
	move.w	d5,d0
	bsr.w	T_1642c
	tst.w	d1
	beq.b	T_16b60
	cmpi.w	#$4,d1
	beq.b	.l_16b56
	tst.l	$18(a3)
	beq.b	.l_16b46
	subq.w	#$1,d0
	bmi.b	.l_16b34
	tst.l	$14(a3)
	beq.b	.l_16b46
.l_16b34:
	addq.w	#$2,d0
	cmpi.w	#$6,d0
	beq.b	.l_16b42
	tst.l	$1c(a3)
	beq.b	.l_16b46
.l_16b42:
	clr.w	(a0)
	bra.b	T_16b60
.l_16b46:
	move.w	#$1,(a0)
	move.w	d0,$2(a0)
	move.w	#$4,$4(a0)
	bra.b	T_16b60
.l_16b56:
	move.w	#$2,(a0)
	bra.b	T_16b60
T_16b5c:
	move.w	#$5,(a0)
T_16b60:
	addq.l	#$8,a0
	dbra	d7,T_16ac8
T_16b66:
	movem.l	d0/d7/a0-a1,-(a7)
	tst.b	Battling
	beq.b	.l_16b8c
	lea.l	B_5b956,a0
	lea.l	Char_status_icons,a1
	moveq	#5,d7
.l_16b80:
	move.w	(a0),d0
	move.b	.l_16b92(pc,d0.w),(a1)+
	addq.l	#$8,a0
	dbra	d7,.l_16b80
.l_16b8c:
	movem.l	(a7)+,d0/d7/a0-a1
	rts
.l_16b92:
	dc.b	$03,$06,$05,$02,$04,$11,$0a,$0c
; Mad members attack, flee or move randomly.
Mad_action:
	move.w	d5,d0
	bsr.w	T_1642c
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
	bne.b	T_16bfa
	cmpi.w	#$4,d3
	bne.b	.l_16bd2
	btst	#$2,d0
	bne.b	.l_16bd2
	move.w	#$2,(a0)
	rts
.l_16bd2:
	divu.w	#$5,d1
	swap	d1
	move.w	d1,d4
	moveq	#0,d6
.l_16bdc:
	bsr.w	Get_move_targets
	tst.w	d0
	bmi.b	T_16bf6
	dbra	d4,.l_16bdc
	move.w	#$1,(a0)
	move.w	d0,$2(a0)
	move.w	d1,$4(a0)
	rts
T_16bf6:
	clr.w	(a0)
	rts
T_16bfa:
	moveq	#0,d0
	move.b	$1f(a4),d0
	add.w	$96(a4),d0
	ble.b	T_16bf6
	tst.b	$25(a4)
	beq.b	.l_16c18
	lea.l	$1aa(a4),a2
	cmpi.b	#$5,$1(a2)
	beq.b	T_16bf6
.l_16c18:
	moveq	#0,d6
	bsr.w	Get_melee_targets
	tst.w	d0
	bmi.b	T_16bf6
	movea.l	a0,a2
	move.w	#$3,(a2)+
	move.w	d0,(a2)+
	move.w	d1,(a2)+
	clr.w	(a2)+
	rts
T_16c30:
	tst.b	Monster_advantage
	bne.w	T_16cc2
	move.w	#$0,Draw_Cicon
	jsr	My_vsync
	move.w	Active_member,d0
	beq.b	T_16cc2
	jsr	Init_RText
	bsr.w	T_1642c
	movea.l	$2(a4),a4
	lea.l	$f0(a4),a0
	jsr	Add_ASCII_2_RText
	lea.l	D_313c2,a0
	jsr	Add_ASCII_2_RText
	lea.l	D_4d19e,a1
	moveq	#0,d0
	jsr	Add_encoded_2_RText
	jsr	T_0707a
	jsr	Exit_RText
	jsr	Switch_screen
	jsr	Copy_screen
	move.l	#T_160ee,B_5b952
	move.l	#T_16d3a,B_5b986
.l_16cae:
	btst	#$1,Mouse_button_state
	bne.b	.l_16cae
	lea.l	D_302a4,a0
	bsr.w	Push_Module
T_16cc2:
	rts
T_16cc4:
	sf.b	B_5badc
	lea.l	T_16d9a,a0
	jsr	Push_MA
	rts
T_16cd8:
	st.b	B_5badc
	movea.l	Off_screen,a6
	jsr	Erase_text_window
	jsr	Switch_screen
	jsr	Copy_screen
	move.l	#Blink_markers,B_5b952
	jsr	Pop_MA
	rts
T_16d08:
	move.w	Mouse_X,d0
	move.w	Mouse_Y,d1
	subi.w	#$d0,d0
	subi.w	#$30,d1
	lsr.w	#$4,d0
	lsr.w	#$4,d1
	cmpi.w	#$5,d0
	bgt.b	.l_16d38
	cmpi.w	#$4,d1
	bgt.b	.l_16d38
	move.w	d0,d4
	move.w	d1,d5
	movea.l	B_5b986,a0
	jmp	(a0)
.l_16d38:
	rts
T_16d3a:
	move.w	Active_member,d0
	beq.b	.l_16d8a
	bsr.w	T_1642c
	move.w	d0,d2
	move.w	d1,d3
	cmp.w	d0,d4
	bne.b	.l_16d52
	cmp.w	d1,d5
	beq.b	.l_16d8a
.l_16d52:
	moveq	#0,d6
.l_16d54:
	bsr.w	Get_move_targets
	tst.w	d0
	bmi.b	.l_16d8e
	cmp.w	d0,d4
	bne.b	.l_16d54
	cmp.w	d1,d5
	bne.b	.l_16d54
	move.w	Active_member,d0
	subq.w	#$1,d0
	lea.l	Char_status_icons,a0
	move.b	#$6,(a0,d0.w)
	lsl.w	#$3,d0
	lea.l	B_5b956,a0
	adda.w	d0,a0
	move.w	#$1,(a0)+
	move.w	d4,(a0)+
	move.w	d5,(a0)+
.l_16d8a:
	bsr.w	Pop_Module
.l_16d8e:
	btst	#$1,Mouse_button_state
	bne.b	.l_16d8e
	rts
T_16d9a:
	dc.b	$00,$d0,$01,$2f,$00,$31,$00,$80
T_16da2:
	tst.b	Monster_advantage
	bne.w	T_16cc2
	move.w	#$0,Draw_Cicon
	jsr	My_vsync
	move.w	Active_member,d0
	beq.b	.l_16dde
	subq.w	#$1,d0
	lea.l	Char_status_icons,a0
	move.b	#$5,(a0,d0.w)
	lsl.w	#$3,d0
	lea.l	B_5b956,a0
	adda.w	d0,a0
	move.w	#$2,(a0)
.l_16dde:
	rts
T_16de0:
	tst.b	Monster_advantage
	bne.w	T_16cc2
	move.w	#$0,Draw_Cicon
	jsr	My_vsync
	move.w	Active_member,d0
	beq.b	.l_16e4a
	jsr	Init_RText
	bsr.w	T_1642c
	movea.l	$2(a4),a4
	lea.l	$f0(a4),a0
	jsr	Add_ASCII_2_RText
	lea.l	D_313c2,a0
	jsr	Add_ASCII_2_RText
	lea.l	D_4d19e,a1
	moveq	#1,d0
	jsr	Add_encoded_2_RText
	jsr	T_0707a
	jsr	Exit_RText
	jsr	Switch_screen
	jsr	Copy_screen
.l_16e4a:
	move.l	#T_1624c,B_5b952
	move.l	#.l_16e74,B_5b986
.l_16e5e:
	btst	#$1,Mouse_button_state
	bne.b	.l_16e5e
	lea.l	D_302a4,a0
	bsr.w	Push_Module
	rts
.l_16e74:
	move.w	Active_member,d0
	beq.b	.l_16eca
	bsr.w	T_1642c
	move.w	d0,d2
	move.w	d1,d3
	cmp.w	d0,d4
	bne.b	.l_16e8c
	cmp.w	d1,d5
	beq.b	.l_16eca
.l_16e8c:
	moveq	#0,d6
.l_16e8e:
	bsr.w	Get_melee_targets
	tst.w	d0
	bmi.b	.l_16ece
	cmp.w	d0,d4
	bne.b	.l_16e8e
	cmp.w	d1,d5
	bne.b	.l_16e8e
	move.w	Active_member,d0
	subq.w	#$1,d0
	lea.l	Char_status_icons,a0
	move.b	#$2,(a0,d0.w)
	lsl.w	#$3,d0
	lea.l	B_5b956,a0
	adda.w	d0,a0
	move.w	#$3,(a0)+
	move.w	d4,(a0)+
	move.w	d5,(a0)+
	move.w	B_5b98a,(a0)+
.l_16eca:
	bsr.w	Pop_Module
.l_16ece:
	btst	#$1,Mouse_button_state
	bne.b	.l_16ece
	rts
T_16eda:
	tst.b	Monster_advantage
	bne.w	T_16cc2
	move.w	#$0,Draw_Cicon
	jsr	My_vsync
	move.w	Active_member,d0
	beq.b	.l_16f14
	subq.w	#$1,d0
	lea.l	Char_status_icons,a0
	move.b	#$3,(a0,d0.w)
	lsl.w	#$3,d0
	lea.l	B_5b956,a0
	adda.w	d0,a0
	clr.w	(a0)
.l_16f14:
	rts
T_16f16:
	tst.b	Monster_advantage
	bne.w	T_16cc2
	move.w	#$0,Draw_Cicon
	jsr	My_vsync
	bsr.w	Cast_spell
	bsr.w	T_16b66
	rts
; Chooses the actions of the monsters (before the party actions are added).
Monster_actions:
	tst.b	Monster_advantage
	bne.w	T_16cc2
	move.w	#$0,Draw_Cicon
	jsr	My_vsync
	clr.w	B_5ba12
	lea.l	B_5ba40,a0
	moveq	#17,d7
.l_16f5e:
	move.l	(a0)+,d0
	beq.b	.l_16f68
	movea.l	d0,a1
	clr.w	$6(a1)
.l_16f68:
	dbra	d7,.l_16f5e
	bsr.w	Choose_particle_path
	movea.l	Off_screen,a6
	move.l	B_5b952,-(a7)
	clr.l	B_5b952
	bsr.w	T_15f8e
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	B_5b9f4,a0
	bsr.w	T_15d6e
	lea.l	B_5ba70,a0
	moveq	#5,d7
.l_16fa4:
	tst.l	(a0)+
	bne.b	.l_16fb4
	dbra	d7,.l_16fa4
	move.w	#$ffff,B_5ba06
.l_16fb4:
	clr.l	B_5b994
	move.l	#$2d0,d0
	jsr	Allocate_memory
	move.l	a1,B_5b98c
	lea.l	$f0(a1),a5
	movea.l	a1,a4
	lea.l	B_5ba40,a1
	moveq	#0,d6
	moveq	#0,d4
	moveq	#0,d5
	moveq	#17,d7
; Morale, retreat, advance, spells and attacks of a monster.
Choose_monster_action:
	clr.w	B_5ba10
	move.l	(a1)+,d0
	beq.w	T_17258
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
	bne.w	T_17250
	btst	#$0,$2e(a2)
	bne.w	Monster_attack
	btst	#$2,$2f(a2)
	bne.w	T_17250
	btst	#$3,$2f(a2)
	bne.b	Monster_retreat
	movem.l	a0-a1,-(a7)
	movea.l	a3,a1
	lea.l	B_5b9e2,a0
	bsr.w	T_15dac
	move.w	d0,d1
	lea.l	B_5b9f4,a0
	bsr.w	T_15dac
	movem.l	(a7)+,a0-a1
	moveq	#0,d2
	move.b	$41(a3),d2
	mulu.w	#$64,d0
	divu.w	d1,d0
	neg.w	d0
	addi.w	#$64,d0
	cmp.w	d0,d2
	bgt.b	T_1708a
; Monsters flee from the back row and move back otherwise.
Monster_retreat:
	move.w	#$ffff,B_5ba10
	tst.w	d5
	bne.b	.l_17082
	move.w	#$2,(a0)+
	bra.w	T_17254
.l_17082:
	move.w	d4,d0
	move.w	d5,d1
	subq.w	#$1,d1
	bra.b	Monster_move_to_row
T_1708a:
	move.w	d5,d1
	moveq	#2,d0
	tst.w	B_5ba06
	bne.b	.l_1709c
	sub.b	$42(a3),d0
	ext.w	d0
.l_1709c:
	sub.w	d5,d0
	beq.b	Monster_attack
	bmi.b	.l_170a6
	addq.w	#$1,d1
	bra.b	.l_170a8
.l_170a6:
	subq.w	#$1,d1
.l_170a8:
	move.w	d4,d0
; The monster moves to a row: to the same column or one beside it.
Monster_move_to_row:
	lea.l	B_5ba40,a6
	move.w	d1,d2
	mulu.w	#$6,d2
	add.w	d0,d2
	lsl.w	#$2,d2
	adda.w	d2,a6
	tst.l	(a6)
	beq.b	.l_170d8
	subq.w	#$1,d0
	bmi.b	.l_170ca
	tst.l	-$4(a6)
	beq.b	.l_170d8
.l_170ca:
	addq.w	#$2,d0
	cmpi.w	#$6,d0
	beq.b	.l_170f0
	tst.l	$4(a6)
	bne.b	.l_170f0
.l_170d8:
	lea.l	B_5b994,a6
	bset	d0,(a6,d1.w)
	bne.b	.l_170f0
	move.w	#$1,(a0)+
	move.w	d0,(a0)+
	move.w	d1,(a0)+
	bra.w	T_17254
.l_170f0:
	tst.w	B_5ba10
	bne.w	T_1724a
; Spells, ranged attacks or melee attacks of a monster.
Monster_attack:
	btst	#$0,$2f(a2)
	bne.b	.l_1714c
	move.w	B_5ba0e,d0
	cmpi.w	#$19,d0
	bge.b	.l_1714c
	jsr	Random
	lsr.w	#$1,d0
	ext.l	d0
	divu.w	#$19,d0
	swap	d0
	lea.l	$100(a3),a6
	adda.w	d0,a6
	moveq	#0,d2
	move.b	(a6),d2
	beq.b	.l_1714c
	moveq	#0,d3
	move.b	$19(a6),d3
	moveq	#0,d0
	move.b	$3f(a3),d0
	jsr	Probe
	bmi.b	.l_1714c
	move.w	#$4,(a0)+
	move.w	d2,(a0)+
	move.w	d3,(a0)+
	clr.w	(a0)+
	bra.w	T_17254
.l_1714c:
	btst	#$0,$2e(a2)
	bne.w	T_17250
	move.l	a1,-(a7)
	tst.b	$1b(a2)
	beq.b	.l_171a2
	lea.l	$b0(a2),a6
	cmpi.b	#$5,$1(a6)
	bne.b	.l_171a2
	tst.b	$1d(a2)
	beq.b	.l_1719c
	lea.l	$100(a2),a1
	cmpi.b	#$6,$1(a1)
	bne.b	.l_1719c
	move.b	$2(a6),d0
	cmp.b	$f(a1),d0
	bne.b	.l_1719c
	bsr.w	Random_party_target
	move.w	#$3,(a0)+
	move.w	d0,(a0)+
	move.w	d1,(a0)+
	move.w	#$1,(a0)+
	movea.l	(a7)+,a1
	bra.w	T_17254
.l_1719c:
	movea.l	(a7)+,a1
	bra.w	Monster_retreat
.l_171a2:
	movea.l	(a7)+,a1
	cmpi.w	#$2,d5
	bne.w	T_1724a
	move.w	d4,d0
	move.w	d5,d1
	addq.w	#$1,d1
	move.w	d1,d2
	mulu.w	#$6,d2
	add.w	d0,d2
	lsl.w	#$2,d2
	lea.l	B_5ba40,a6
	adda.w	d2,a6
	tst.l	(a6)
	bne.b	.l_1723e
	subq.w	#$1,d0
	bmi.b	.l_171d2
	tst.l	-$4(a6)
	bne.b	.l_1723e
.l_171d2:
	addq.w	#$2,d0
	cmpi.w	#$6,d0
	beq.b	.l_171e0
	tst.l	$4(a6)
	bne.b	.l_1723e
.l_171e0:
	move.l	a6,-(a7)
	move.w	d4,d0
	beq.b	.l_17208
	subq.w	#$1,d0
.l_171e8:
	tst.l	-(a6)
	bne.b	.l_171f2
	dbra	d0,.l_171e8
	bra.b	.l_17208
.l_171f2:
	move.w	d4,d0
	subq.w	#$1,d0
	tst.l	-$8(a1)
	bne.b	.l_17208
	lea.l	B_5b994,a6
	bset	d0,(a6,d5.w)
	beq.b	.l_17232
.l_17208:
	movea.l	(a7)+,a6
	moveq	#4,d0
	sub.w	d4,d0
	bmi.b	T_1724a
	addq.l	#$4,a6
.l_17212:
	tst.l	(a6)+
	bne.b	.l_1721c
	dbra	d0,.l_17212
	bra.b	T_1724a
.l_1721c:
	move.w	d4,d0
	addq.w	#$1,d0
	tst.l	(a1)
	bne.b	T_1724a
	lea.l	B_5b994,a6
	bset	d0,(a6,d5.w)
	beq.b	.l_17234
	bra.b	T_1724a
.l_17232:
	movea.l	(a7)+,a6
.l_17234:
	move.w	#$1,(a0)+
	move.w	d0,(a0)+
	move.w	d5,(a0)+
	bra.b	T_17254
.l_1723e:
	move.w	#$3,(a0)+
	move.w	d0,(a0)+
	move.w	d1,(a0)+
	clr.w	(a0)+
	bra.b	T_17254
T_1724a:
	move.w	#$0,(a0)+
	bra.b	T_17254
T_17250:
	move.w	#$5,(a0)+
T_17254:
	move.l	a3,(a5)+
	addq.w	#$1,d6
T_17258:
	addq.w	#$1,d4
	cmpi.w	#$6,d4
	bne.b	.l_17264
	moveq	#0,d4
	addq.w	#$1,d5
.l_17264:
	dbra	d7,Choose_monster_action
	clr.b	Party_advantage
	lea.l	B_5b956,a0
	moveq	#11,d7
.l_17276:
	move.l	(a1)+,d0
	beq.b	.l_172ae
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
.l_172ae:
	addq.w	#$1,d4
	cmpi.w	#$6,d4
	bne.b	.l_172ba
	moveq	#0,d4
	addq.w	#$1,d5
.l_172ba:
	dbra	d7,.l_17276
	move.w	d6,B_5b990
	move.w	d6,-(a7)
	movea.l	B_5b98c,a0
	move.w	d6,d7
	cmpi.w	#$1,d7
	ble.b	.l_172d8
	bsr.w	Sort_action_list
.l_172d8:
	move.w	(a7)+,d6
	movea.l	Off_screen,a6
	subq.w	#$1,d6
	move.w	d6,d0
	lsl.w	#$3,d0
	movea.l	B_5b98c,a5
	adda.w	d0,a5
	sf.b	B_5bade
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
	lea.l	B_5ba40,a0
	adda.w	d0,a0
	tst.l	(a0)
	beq.b	Remove_dead_participants
	tst.b	(a4)
	beq.b	.l_17330
	movea.l	(a0),a0
	move.b	$2e(a0),d0
	move.b	$2f(a0),d1
	bra.b	Set_success_factor
.l_17330:
	movea.l	$c(a4),a0
	move.b	Body_conditions(a0),d0
	move.b	Mind_conditions(a0),d1
; Diseases, irritation and blindness lower the chance to hit.
Set_success_factor:
	moveq	#100,d2
	btst	#$3,d0
	beq.b	.l_17346
	lsr.w	#$1,d2
.l_17346:
	btst	#$0,d1
	beq.b	.l_17354
	mulu.w	#$4b,d2
	divu.w	#$64,d2
.l_17354:
	btst	#$4,d1
	beq.b	.l_1735c
	lsr.w	#$2,d2
.l_1735c:
	move.w	d2,B_5ba0a
	move.w	$4(a4),d2
	lsl.w	#$2,d2
	lea.l	T_175fe(pc),a0
	movea.l	(a0,d2.w),a0
	jsr	(a0)
	tst.w	d0
	bne.b	Remove_dead_participants
	bsr.w	T_17b0a
	movea.l	Off_screen,a6
	jsr	Erase_text_window
	jsr	Switch_screen
	jsr	Copy_screen
; Dead monsters and dead or petrified party members leave the battle field.
Remove_dead_participants:
	lea.l	B_5ba40,a0
	moveq	#17,d7
.l_1739a:
	move.l	(a0)+,d0
	beq.b	.l_173d2
	movea.l	d0,a1
	btst	#$5,$2e(a1)
	beq.b	.l_173d2
	clr.l	-$4(a0)
	movea.l	$2(a1),a2
	move.w	B_5b998,d0
	lea.l	B_5b99a,a3
	lsl.w	#$2,d0
	move.l	a1,(a3,d0.w)
	addq.w	#$1,B_5b998
	move.w	$c6(a2),d0
	add.w	d0,B_5ba08
.l_173d2:
	dbra	d7,.l_1739a
	lea.l	B_5b956,a3
	moveq	#11,d7
.l_173de:
	move.l	(a0)+,d0
	beq.b	.l_17418
	movea.l	d0,a1
	movea.l	$2(a1),a2
	btst	#$2,$3a(a2)
	beq.b	.l_1740c
	clr.l	-$4(a0)
	move.w	$8(a1),d0
	lsl.w	#$3,d0
	move.w	#$7,(a3,d0.w)
	bsr.w	T_16b66
	bset	#$7,$3b(a2)
	bra.b	.l_17418
.l_1740c:
	btst	#$5,$3a(a2)
	beq.b	.l_17418
	clr.l	-$4(a0)
.l_17418:
	dbra	d7,.l_173de
	movea.l	Current_active_char_data,a0
	move.w	Body_conditions(a0),d0
	andi.w	#$e480,d0
	beq.b	Check_party_left
	jsr	Check_party_alive
; The battle ends if no party member is left on the battle field.
Check_party_left:
	lea.l	B_5b9f4,a0
	bsr.w	T_15d6e
	moveq	#2,d7
	moveq	#0,d0
.l_17440:
	tst.l	(a0)
	beq.b	.l_17448
	add.w	$4(a0),d0
.l_17448:
	addq.l	#$6,a0
	dbra	d7,.l_17440
	tst.w	d0
	bne.b	.l_1745c
	bsr.w	Pop_Module
	st.b	B_5bade
.l_1745c:
	movem.l	(a7)+,d6/a4-a5
	subq.l	#$8,a5
	tst.b	B_5bade
	bne.b	.l_1748a
	dbra	d6,Execute_round
	addq.w	#$1,B_5ba0e
	movea.l	Off_screen,a6
	bsr.w	T_15f8e
	jsr	Switch_screen
	jsr	Copy_screen
.l_1748a:
	movea.l	B_5b98c,a0
	jsr	Free_memory
	move.w	#$ffff,B_5ba12
	move.l	(a7)+,B_5b952
.l_174a4:
	btst	#$1,Mouse_button_state
	bne.b	.l_174a4
	clr.w	B_5b94e
	move.w	#$1,B_5ba0c
; Moves are not kept. If the front row of the party is empty, the back row moves to the front.
End_of_round:
	lea.l	B_5b956,a0
	moveq	#5,d7
.l_174c4:
	cmpi.w	#$1,(a0)
	bne.b	.l_174cc
	clr.w	(a0)
.l_174cc:
	addq.l	#$8,a0
	dbra	d7,.l_174c4
	tst.b	B_5bade
	bne.w	.l_1756a
	lea.l	B_5ba88,a0
	moveq	#5,d7
.l_174e4:
	tst.l	(a0)+
	bne.b	.l_17560
	dbra	d7,.l_174e4
	moveq	#5,d7
	moveq	#0,d6
.l_174f0:
	tst.l	(a0)+
	beq.b	.l_174f6
	addq.w	#$1,d6
.l_174f6:
	dbra	d7,.l_174f0
	cmpi.w	#$1,d6
	bgt.b	.l_17508
	tst.b	B_5badf
	beq.b	.l_17558
.l_17508:
	lea.l	B_5ba88,a0
	lea.l	$18(a0),a1
	moveq	#5,d7
.l_17514:
	move.l	(a1),(a0)+
	clr.l	(a1)+
	dbra	d7,.l_17514
	movea.l	Off_screen,a6
	jsr	Init_RText
	lea.l	D_4d19e,a1
	moveq	#11,d0
	jsr	Add_encoded_2_RText
	jsr	T_0707a
	jsr	Exit_RText
	bsr.w	T_15f8e
	jsr	Switch_screen
	jsr	Copy_screen
	bsr.w	T_1866a
	bra.b	.l_17560
.l_17558:
	st.b	B_5badf
	bra.b	.l_17566
.l_17560:
	sf.b	B_5badf
.l_17566:
	bsr.w	.l_1756c
.l_1756a:
	rts
.l_1756c:
	movem.l	d0-d3/d6-d7/a0-a1/a6,-(a7)
	lea.l	D_369ea,a0
	lea.l	Spell_1_duration,a1
	movea.l	Off_screen,a6
	move.w	#$10,d0
	move.w	#$b1,d1
	move.w	#$bf,d2
	move.w	#$c0,d3
	moveq	#2,d6
	jsr	Draw_box
	moveq	#5,d7
.l_1759c:
	tst.w	(a1)+
	beq.b	.l_175a6
	jsr	Put_unmasked_block
.l_175a6:
	addi.w	#$10,d0
	lea.l	$80(a0),a0
	dbra	d7,.l_1759c
	jsr	Switch_screen
	jsr	Copy_screen
	movem.l	(a7)+,d0-d3/d6-d7/a0-a1/a6
	rts
; A random cell of a party member.
Random_party_target:
	jsr	Random
	lea.l	B_5ba88,a1
.l_175d0:
	andi.l	#$fff,d0
	divu.w	#$c,d0
	swap	d0
	move.w	d0,d1
	lsl.w	#$2,d1
	tst.l	(a1,d1.w)
	bne.b	.l_175ea
	addq.w	#$1,d0
	bra.b	.l_175d0
.l_175ea:
	adda.w	d1,a1
	andi.l	#$fff,d0
	divu.w	#$6,d0
	move.w	d0,d1
	swap	d0
	addq.w	#$3,d1
	rts
T_175fe:
	dc.l	.l_1761e
	dc.l	T_17626
	dc.l	Flee
	dc.l	Execute_attacks
	dc.l	T_17b2c
	dc.l	T_17622
	dc.l	T_17622
	dc.l	T_17622
.l_1761e:
	moveq	#-1,d0
	rts
T_17622:
	moveq	#-1,d0
	rts
T_17626:
	btst	#$0,d0
	bne.b	T_17622
	btst	#$2,d1
	bne.b	T_17622
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
	lea.l	B_5ba40,a1
	tst.l	(a1,d2.w)
	beq.b	.l_17670
	lea.l	D_32039,a1
	jsr	DI_Error
	bra.b	.l_17686
.l_17670:
	dc.b	$23,$b1,$00,$00,$20,$00,$42,$b1,$00,$00,$2c,$79
	dc.l	Off_screen
	dc.b	$70,$04,$61,$00,$0a,$f4
.l_17686:
	moveq	#0,d0
	rts
; Dexterity and luck against a random value below 150.
Flee:
	btst	#$0,d0
	bne.b	T_17622
	btst	#$2,d1
	bne.b	T_17622
	movea.l	$c(a4),a0
	move.w	Attr_3_normal(a0),d0
	add.w	Attr_3_normal_magic(a0),d0
	add.w	Attr_7_normal(a0),d0
	add.w	Attr_7_normal_magic(a0),d0
	mulu.w	B_5ba0a,d2
	divu.w	#$64,d2
	tst.w	d0
	bmi.b	.l_17724
	cmpi.w	#$96,d0
	bpl.b	.l_176d4
	move.w	d0,d1
	jsr	Random
	lsr.w	#$1,d0
	ext.l	d0
	divu.w	#$96,d0
	swap	d0
	cmp.w	d0,d1
	bmi.b	.l_17724
.l_176d4:
	moveq	#0,d0
	moveq	#0,d1
	move.b	$2(a4),d0
	move.b	$3(a4),d1
	mulu.w	#$6,d1
	add.w	d1,d0
	lsl.w	#$2,d0
	lea.l	B_5ba40,a1
	adda.w	d0,a1
	movea.l	(a1),a2
	tst.b	(a4)
	beq.b	.l_17708
	move.w	Battle_experience(a0),d0
	add.w	d0,B_5ba08
	bset	#$7,$2f(a2)
	bra.b	.l_17714
.l_17708:
	dc.b	$08,$e8,$00,$07,$00,$3b,$52,$79
	dc.l	B_5bae2
.l_17714:
	clr.l	(a1)
	movea.l	Off_screen,a6
	moveq	#5,d0
	bsr.w	T_18178
	bra.b	.l_17730
.l_17724:
	dc.b	$2c,$79
	dc.l	Off_screen
	dc.b	$70,$06,$61,$00,$0a,$4a
.l_17730:
	moveq	#0,d0
	rts
; Executes the attacks of a participant (attacks per round, doubled by haste).
Execute_attacks:
	btst	#$0,d0
	bne.w	T_17622
	btst	#$3,d1
	bne.w	T_17622
	btst	#$2,d1
	bne.w	T_17622
	movea.l	Off_screen,a6
	move.w	$6(a4),d0
	move.w	$8(a4),d1
	move.w	d1,d2
	mulu.w	#$6,d2
	add.w	d0,d2
	lsl.w	#$2,d2
	lea.l	B_5ba40,a1
	tst.l	(a1,d2.w)
	beq.w	T_17a0a
	bsr.w	T_18244
	movea.l	a0,a5
	movea.l	$c(a4),a0
	movea.l	$c(a5),a1
	moveq	#0,d0
	move.b	Attacks_per_round(a0),d0
	bne.b	.l_1779e
	movem.l	a0-a1,-(a7)
	lea.l	D_32061,a1
	jsr	DI_Error
	movem.l	(a7)+,a0-a1
	moveq	#1,d0
.l_1779e:
	tst.b	(a4)
	bne.b	.l_177b0
	move.b	$1(a4),d1
	bclr	d1,B_5b863
	beq.b	.l_177b0
	add.w	d0,d0
.l_177b0:
	move.w	d0,B_5b992
	move.b	Magic_bonus_weapon(a0),d0
	cmp.b	Magic_bonus_to_hit(a1),d0
	blt.w	T_179ae
	bra.b	Attack_once
T_177c4:
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
	beq.b	.l_177e8
	bsr.w	Start_attack_animation
.l_177e8:
	moveq	#0,d0
	move.b	Skill_1(a0),d0
	add.w	Skill_1_normal_magic(a0),d0
	tst.b	(a4)
	bne.b	.l_177fe
	add.w	Spell_3_data,d0
	lsr.w	#$1,d0
.l_177fe:
	add.w	d0,d0
	jsr	T_07c70
	bmi.w	T_179c4
	tst.w	$4(a5)
	bne.b	.l_1782e
	moveq	#0,d0
	move.b	Skill_2(a1),d0
	add.w	Skill_2_normal_magic(a1),d0
	tst.b	(a5)
	bne.b	.l_17824
	add.w	Spell_2_data,d0
.l_17824:
	jsr	Probe
	bpl.w	T_179da
.l_1782e:
	moveq	#0,d0
	move.b	Damage(a0),d0
	add.w	Damage_magic(a0),d0
	move.w	Attr_1_normal(a0),d2
	add.w	Attr_1_normal_magic(a0),d2
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
	move.b	Protection(a1),d0
	add.w	Protection_magic(a1),d0
	moveq	#0,d2
	move.b	Magic_bonus_armour(a1),d2
	add.w	d2,d0
	move.w	Attr_5_normal(a1),d2
	add.w	Attr_5_normal_magic(a1),d2
	ext.l	d2
	divs.w	#$19,d2
	add.w	d0,d2
	jsr	Random
	lsr.w	#$1,d0
	ext.l	d0
	divu.w	d2,d0
	swap	d0
	sub.w	d0,d4
	ble.w	T_179f4
	movem.l	a0-a1,-(a7)
	jsr	Init_RText
	lea.l	Char_name(a0),a0
	jsr	Add_ASCII_2_RText
	lea.l	D_313bc,a0
	jsr	Add_ASCII_2_RText
	lea.l	D_4d19e,a1
	moveq	#2,d0
	jsr	Add_encoded_2_RText
	movem.l	(a7),a0-a1
	lea.l	Char_name(a1),a0
	jsr	Add_ASCII_2_RText
	lea.l	D_313bc,a0
	jsr	Add_ASCII_2_RText
	lea.l	D_4d19e,a1
	moveq	#3,d0
	jsr	Add_encoded_2_RText
	lea.l	D_313bc,a0
	jsr	Add_ASCII_2_RText
	move.w	d4,d0
	moveq	#4,d7
	lea.l	Number_buffer,a0
	movea.l	a0,a3
	bsr.w	LConvert_number
	move.b	#$20,(a3)+
	clr.b	(a3)
	jsr	Add_ASCII_2_RText
	lea.l	D_4d19e,a1
	moveq	#9,d0
	jsr	Add_encoded_2_RText
	jsr	T_0707a
	jsr	Exit_RText
	movem.l	(a7)+,a0-a1
	tst.b	(a5)
	bne.b	.l_17970
	bclr	#$2,Mind_conditions(a1)
	moveq	#0,d0
	move.b	$1(a5),d0
	move.w	d4,d1
	bsr.w	T_160d0
	jsr	Do_damage
	tst.w	Life_points_normal(a1)
	bgt.w	T_17a24
	moveq	#0,d0
	moveq	#0,d1
	move.b	$2(a5),d0
	move.b	$3(a5),d1
	mulu.w	#$6,d1
	add.w	d1,d0
	lsl.w	#$2,d0
	lea.l	B_5ba40,a2
	adda.w	d0,a2
	clr.l	(a2)
	bra.w	T_17a1c
.l_17970:
	moveq	#0,d0
	moveq	#0,d1
	move.b	$2(a5),d0
	move.b	$3(a5),d1
	mulu.w	#$6,d1
	add.w	d1,d0
	lsl.w	#$2,d0
	lea.l	B_5ba40,a2
	adda.w	d0,a2
	movea.l	(a2),a3
	bclr	#$2,$2f(a3)
	move.w	d4,$12(a3)
	move.w	#$64,$10(a3)
	sub.w	d4,$30(a3)
	bgt.w	T_17a24
	bset	#$5,$2e(a3)
	bra.b	T_17a1c
T_179ae:
	movem.l	a0-a1,-(a7)
	lea.l	Code0004Sys,a0
	moveq	#4,d0
	bsr.w	T_181ba
	movem.l	(a7)+,a0-a1
	bra.b	T_17a1c
T_179c4:
	movem.l	a0-a1,-(a7)
	lea.l	Code0004Sys,a0
	moveq	#0,d0
	bsr.w	T_181ba
	movem.l	(a7)+,a0-a1
	bra.b	T_17a24
T_179da:
	movem.l	a0-a1,-(a7)
	exg.l	a5,a4
	lea.l	Code0004Sys,a0
	moveq	#1,d0
	bsr.w	T_181ba
	exg.l	a5,a4
	movem.l	(a7)+,a0-a1
	bra.b	T_17a24
T_179f4:
	movem.l	a0-a1,-(a7)
	lea.l	Code0004Sys,a0
	moveq	#3,d0
	bsr.w	T_181ba
	movem.l	(a7)+,a0-a1
	bra.b	T_17a24
T_17a0a:
	dc.b	$20,$6c,$00,$0c,$48,$e7,$00,$c0,$70,$08,$61,$00,$07,$62,$4c,$df
	dc.b	$03,$00
T_17a1c:
	move.w	#$1,B_5b992
T_17a24:
	tst.w	$a(a4)
	beq.w	.l_17afc
	tst.b	(a4)
	beq.b	.l_17a8a
	moveq	#0,d0
	move.b	$2(a4),d0
	moveq	#0,d1
	move.b	$3(a4),d1
	mulu.w	#$6,d1
	add.w	d1,d0
	lsl.w	#$2,d0
	lea.l	B_5ba40,a6
	movea.l	(a6,d0.w),a6
	lea.l	$b0(a6),a3
	move.b	$2(a3),d0
	beq.w	.l_17afc
	clr.b	$1d(a6)
	lea.l	$21(a6),a2
	lea.l	$1a0(a6),a3
	moveq	#11,d7
.l_17a68:
	tst.b	(a2)
	beq.b	.l_17a7e
	cmp.b	$f(a3),d0
	bne.b	.l_17a7e
	subq.b	#$1,(a2)
	move.b	#$1,$1d(a6)
	bra.w	.l_17afc
.l_17a7e:
	addq.l	#$1,a2
	lea.l	$28(a3),a3
	dbra	d7,.l_17a68
	bra.b	.l_17af4
.l_17a8a:
	lea.l	$1aa(a0),a3
	tst.b	$2(a3)
	beq.b	.l_17afc
	clr.b	Left_hand_place_counter(a0)
	lea.l	$1fa(a0),a3
	moveq	#0,d0
	move.w	$22(a3),d0
	sub.l	d0,Weight_normal(a0)
	subq.b	#$1,Hands_occupied(a0)
	lea.l	$1aa(a0),a3
	move.b	$2(a3),d0
	lea.l	$2b(a0),a2
	lea.l	$29a(a0),a3
	moveq	#1,d1
	moveq	#11,d7
	tst.b	(a2)
	beq.b	.l_17ad6
	cmp.b	$f(a3),d0
	bne.b	.l_17ad6
	subq.b	#$1,(a2)
	move.b	#$1,Left_hand_place_counter(a0)
	addq.b	#$1,Hands_occupied(a0)
	bra.b	.l_17afc
.l_17ad6:
	dc.b	$52,$8a,$47,$eb,$00,$28,$52,$41,$51,$cf,$ff,$de,$45,$f9
	dc.l	B_5b956
	dc.b	$70,$00,$10,$2c,$00,$01,$e7,$48,$42,$72,$00,$f8
.l_17af4:
	dc.b	$33,$fc,$00,$01
	dc.l	B_5b992
.l_17afc:
	subq.w	#$1,B_5b992
	bne.w	T_177c4
	moveq	#0,d0
	rts
T_17b0a:
	movea.l	Off_screen,a6
	bsr.w	T_15f8e
	jsr	Update_status_block
	jsr	Switch_screen
	jsr	Copy_screen
	bsr.w	Wait_for_animation
	rts
T_17b2c:
	btst	#$0,d1
	bne.w	T_17622
	btst	#$3,d1
	bne.w	T_17622
	btst	#$2,d1
	bne.w	T_17622
; A spell of a participant or of an item.
Execute_spell_action:
	tst.b	(a4)
	bne.w	T_17cd8
	tst.w	$6(a4)
	bpl.b	.l_17b94
	movem.l	d0/a0,-(a7)
	movea.l	$c(a4),a0
	move.l	a0,B_5b840
	move.w	$8(a4),d0
	move.w	d0,B_5b83e
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
.l_17b94:
	dc.b	$33,$ec,$00,$06
	dc.l	Selected_class
	dc.b	$33,$ec,$00,$08
	dc.l	Selected_spell
; The name of the spell is shown first, the result after the effects of the spell.
Show_spell_result:
	jsr	Init_RText
	movea.l	$c(a4),a0
	lea.l	Char_name(a0),a0
	jsr	Add_ASCII_2_RText
	lea.l	Space,a0
	jsr	Add_ASCII_2_RText
	move.w	#$d,d0
	lea.l	Code0004Sys,a1
	jsr	Add_encoded_2_RText
	lea.l	D_4b800,a1
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
	bra.b	T_17c0a
T_17c08:
	dc.b	$12,$d8
T_17c0a:
	dbra	d0,T_17c08
	move.b	#$20,(a1)+
	clr.b	(a1)
	lea.l	Number_buffer,a0
	jsr	Add_ASCII_2_RText
	jsr	T_0707a
	jsr	Exit_RText
	jsr	Switch_screen
	jsr	Copy_screen
	bsr.w	T_1866a
	moveq	#0,d0
	move.b	$1(a4),d0
	move.w	d0,B_5baea
	bsr.w	Cast_combat_spell
	sf.b	Magic_object_flag
	tst.b	B_5b861
	bmi.b	.l_17c98
	jsr	Init_RText
	movea.l	$c(a4),a0
	lea.l	Char_name(a0),a0
	jsr	Add_ASCII_2_RText
	lea.l	Space,a0
	jsr	Add_ASCII_2_RText
	move.w	#$5,d0
	lea.l	Code0004Sys,a1
	jsr	Add_encoded_2_RText
	jsr	T_0707a
	jsr	Exit_RText
	bra.b	.l_17cd4
.l_17c98:
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
.l_17cd4:
	moveq	#0,d0
	rts
T_17cd8:
	moveq	#0,d0
	moveq	#0,d1
	move.b	$2(a4),d0
	move.b	$3(a4),d1
	mulu.w	#$6,d1
	add.w	d1,d0
	lsl.w	#$2,d0
	lea.l	B_5ba40,a5
	movea.l	(a5,d0.w),a5
	movea.l	$c(a4),a3
	bsr.w	Start_attack_animation
	move.w	$6(a4),Selected_class
	move.w	$8(a4),Selected_spell
	move.l	a3,B_5baf0
	move.l	a5,B_5baf4
	moveq	#10,d0
	bsr.w	T_18178
	jsr	Switch_screen
	jsr	Copy_screen
	bsr.w	T_1866a
	st.b	B_5bae9
	bsr.w	Cast_combat_spell
	sf.b	B_5bae9
	moveq	#0,d0
	rts
T_17d44:
	movem.l	d0-d1/a0-a1,-(a7)
	move.w	#$1,B_5baf8
	bsr.w	Random_party_target
	lea.l	B_5bafa,a0
	movea.l	(a1),a1
	move.l	$2(a1),(a0)+
	move.w	$8(a1),(a0)+
	movem.l	(a7)+,d0-d1/a0-a1
	rts
T_17d6a:
	movem.l	d0/d6-d7/a0-a2,-(a7)
	jsr	Random
	lsr.w	#$7,d0
	lea.l	B_5ba88,a0
	andi.w	#$1,d0
	beq.b	.l_17d86
	adda.w	#$18,a0
.l_17d86:
	lea.l	B_5bafa,a1
	moveq	#5,d7
	moveq	#0,d6
.l_17d90:
	move.l	(a0)+,d0
	beq.b	.l_17da0
	movea.l	d0,a2
	move.l	$2(a2),(a1)+
	move.w	$8(a2),(a1)+
	addq.w	#$1,d6
.l_17da0:
	dbra	d7,.l_17d90
	move.w	d6,B_5baf8
	movem.l	(a7)+,d0/d6-d7/a0-a2
	rts
T_17db0:
	movem.l	d0/d6-d7/a0-a2,-(a7)
	lea.l	B_5ba88,a0
	lea.l	B_5bafa,a1
	moveq	#11,d7
	moveq	#0,d6
.l_17dc4:
	move.l	(a0)+,d0
	beq.b	.l_17dd4
	movea.l	d0,a2
	move.l	$2(a2),(a1)+
	move.w	$8(a2),(a1)+
	addq.w	#$1,d6
.l_17dd4:
	dbra	d7,.l_17dc4
	move.w	d6,B_5baf8
	movem.l	(a7)+,d0/d6-d7/a0-a2
	rts
T_17de4:
	move.w	Active_member,d0
	jsr	Init_RText
	bsr.w	T_1642c
	movea.l	$2(a4),a4
	lea.l	$f0(a4),a0
	jsr	Add_ASCII_2_RText
	lea.l	D_313be,a0
	jsr	Add_ASCII_2_RText
	move.w	B_5be8a,d0
	movea.l	B_5be8c,a1
	jsr	Add_encoded_2_RText
	jsr	T_0707a
	jsr	Exit_RText
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	B_5bb1e,a1
	move.w	Active_member,d0
	subq.w	#$1,d0
	mulu.w	#$92,d0
	clr.w	(a1,d0.w)
	move.l	#T_16162,B_5b952
	move.l	#.l_17ea0,B_5b986
.l_17e62:
	btst	#$1,Mouse_button_state
	bne.b	.l_17e62
	lea.l	D_302a4,a0
	bsr.w	Push_Module
.l_17e76:
	move.w	#$0,Draw_Cicon
	bsr.w	Input_handler
	movea.l	Module_sp,a0
	move.l	(a0),d0
	beq.b	.l_17e90
	movea.l	d0,a0
	jsr	(a0)
.l_17e90:
	jsr	Switch_screen
	tst.b	B_5badc
	beq.b	.l_17e76
	rts
.l_17ea0:
	move.w	Active_member,d0
	beq.b	.l_17ef2
	bsr.w	T_1642c
	move.w	d0,d2
	move.w	d1,d3
	cmp.w	d0,d4
	bne.b	.l_17eb8
	cmp.w	d1,d5
	beq.b	.l_17ef2
.l_17eb8:
	cmpi.w	#$3,d5
	bge.b	.l_17ef6
	mulu.w	#$6,d5
	add.w	d4,d5
	lsl.w	#$2,d5
	lea.l	B_5ba40,a0
	adda.w	d5,a0
	move.l	(a0),d5
	beq.b	.l_17ef6
	movea.l	d5,a0
	lea.l	B_5bb1e,a1
	move.w	Active_member,d0
	subq.w	#$1,d0
	mulu.w	#$92,d0
	adda.w	d0,a1
	move.w	#$1,(a1)+
	move.l	$2(a0),(a1)+
	move.l	a0,(a1)+
.l_17ef2:
	bsr.w	Pop_Module
.l_17ef6:
	btst	#$1,Mouse_button_state
	bne.b	.l_17ef6
	rts
T_17f02:
	move.w	Active_member,d0
	jsr	Init_RText
	bsr.w	T_1642c
	movea.l	$2(a4),a4
	lea.l	$f0(a4),a0
	jsr	Add_ASCII_2_RText
	lea.l	D_313be,a0
	jsr	Add_ASCII_2_RText
	move.w	B_5be8a,d0
	movea.l	B_5be8c,a1
	jsr	Add_encoded_2_RText
	jsr	T_0707a
	jsr	Exit_RText
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	B_5bb1e,a1
	move.w	Active_member,d0
	subq.w	#$1,d0
	mulu.w	#$92,d0
	clr.w	(a1,d0.w)
	move.l	#T_161b0,B_5b952
	move.l	#.l_17fbe,B_5b986
.l_17f80:
	btst	#$1,Mouse_button_state
	bne.b	.l_17f80
	lea.l	D_302a4,a0
	bsr.w	Push_Module
.l_17f94:
	move.w	#$0,Draw_Cicon
	bsr.w	Input_handler
	movea.l	Module_sp,a0
	move.l	(a0),d0
	beq.b	.l_17fae
	movea.l	d0,a0
	jsr	(a0)
.l_17fae:
	jsr	Switch_screen
	tst.b	B_5badc
	beq.b	.l_17f94
	rts
.l_17fbe:
	move.w	Active_member,d0
	beq.b	.l_1800a
	bsr.w	T_1642c
	move.w	d0,d2
	move.w	d1,d3
	cmpi.w	#$3,d5
	blt.b	.l_1800e
	mulu.w	#$6,d5
	add.w	d4,d5
	lsl.w	#$2,d5
	lea.l	B_5ba40,a0
	adda.w	d5,a0
	move.l	(a0),d5
	beq.b	.l_1800e
	movea.l	d5,a0
	lea.l	B_5bb1e,a1
	move.w	Active_member,d0
	subq.w	#$1,d0
	mulu.w	#$92,d0
	adda.w	d0,a1
	move.w	#$1,(a1)+
	move.l	$2(a0),(a1)+
	move.w	$8(a0),(a1)+
.l_1800a:
	bsr.w	Pop_Module
.l_1800e:
	btst	#$1,Mouse_button_state
	bne.b	.l_1800e
	rts
T_1801a:
	move.w	Active_member,d0
	jsr	Init_RText
	bsr.w	T_1642c
	movea.l	$2(a4),a4
	lea.l	$f0(a4),a0
	jsr	Add_ASCII_2_RText
	lea.l	D_313be,a0
	jsr	Add_ASCII_2_RText
	move.w	B_5be8a,d0
	movea.l	B_5be8c,a1
	jsr	Add_encoded_2_RText
	jsr	T_0707a
	jsr	Exit_RText
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	B_5bb1e,a1
	move.w	Active_member,d0
	subq.w	#$1,d0
	mulu.w	#$92,d0
	clr.w	(a1,d0.w)
	move.l	#T_161e4,B_5b952
	move.l	#.l_180d6,B_5b986
.l_18098:
	btst	#$1,Mouse_button_state
	bne.b	.l_18098
	lea.l	D_302a4,a0
	bsr.w	Push_Module
.l_180ac:
	move.w	#$0,Draw_Cicon
	bsr.w	Input_handler
	movea.l	Module_sp,a0
	move.l	(a0),d0
	beq.b	.l_180c6
	movea.l	d0,a0
	jsr	(a0)
.l_180c6:
	jsr	Switch_screen
	tst.b	B_5badc
	beq.b	.l_180ac
	rts
.l_180d6:
	move.w	Active_member,d0
	beq.b	.l_18130
	bsr.w	T_1642c
	move.w	d0,d2
	move.w	d1,d3
	cmp.w	d0,d4
	bne.b	.l_180ee
	cmp.w	d1,d5
	beq.b	.l_18130
.l_180ee:
	cmpi.w	#$3,d5
	bge.b	.l_18134
	mulu.w	#$18,d5
	lea.l	B_5ba40,a0
	adda.w	d5,a0
	lea.l	B_5bb1e,a1
	move.w	Active_member,d0
	subq.w	#$1,d0
	mulu.w	#$92,d0
	adda.w	d0,a1
	moveq	#0,d6
	moveq	#5,d7
	movea.l	a1,a2
	addq.l	#$2,a1
.l_1811c:
	move.l	(a0)+,d5
	beq.b	.l_1812a
	movea.l	d5,a3
	move.l	$2(a3),(a1)+
	move.l	a3,(a1)+
	addq.w	#$1,d6
.l_1812a:
	dbra	d7,.l_1811c
	move.w	d6,(a2)
.l_18130:
	bsr.w	Pop_Module
.l_18134:
	btst	#$1,Mouse_button_state
	bne.b	.l_18134
	rts
T_18140:
	lea.l	B_5bb1e,a0
	move.w	Active_member,d0
	subq.w	#$1,d0
	mulu.w	#$92,d0
	adda.w	d0,a0
	lea.l	$2(a0),a1
	lea.l	B_5ba40,a2
	moveq	#0,d6
	moveq	#17,d7
.l_18162:
	move.l	(a2)+,d0
	beq.b	.l_18170
	movea.l	d0,a3
	move.l	$2(a3),(a1)+
	move.l	a3,(a1)+
	addq.w	#$1,d6
.l_18170:
	dbra	d7,.l_18162
	move.w	d6,(a0)
	rts
T_18178:
	movem.l	a0-a1,-(a7)
	jsr	Init_RText
	movea.l	$c(a4),a0
	lea.l	Char_name(a0),a0
	jsr	Add_ASCII_2_RText
	lea.l	D_313bc,a0
	jsr	Add_ASCII_2_RText
	lea.l	D_4d19e,a1
	jsr	Add_encoded_2_RText
	jsr	T_0707a
	jsr	Exit_RText
	movem.l	(a7)+,a0-a1
	rts
T_181ba:
	movem.l	d0/a0,-(a7)
	jsr	Init_RText
	movea.l	$c(a4),a0
	lea.l	Char_name(a0),a0
	jsr	Add_ASCII_2_RText
	lea.l	D_313bc,a0
	jsr	Add_ASCII_2_RText
	movem.l	(a7)+,d0/a1
	jsr	Add_encoded_2_RText
	jsr	T_0707a
	jsr	Exit_RText
	rts
T_181f6:
	movem.l	a0-a1,-(a7)
	jsr	Init_RText
	lea.l	$f0(a0),a0
	jsr	Add_ASCII_2_RText
	lea.l	D_313bc,a0
	jsr	Add_ASCII_2_RText
	lea.l	D_4d19e,a1
	jsr	Add_encoded_2_RText
	jsr	T_0707a
	jsr	Exit_RText
	jsr	Switch_screen
	jsr	Copy_screen
	bsr.w	T_1866a
	movem.l	(a7)+,a0-a1
	rts
T_18244:
	movem.l	d7/a1,-(a7)
	movea.l	B_5b98c,a0
	move.w	B_5b990,d7
	subq.w	#$1,d7
.l_18256:
	movea.l	$4(a0),a1
	cmp.b	$2(a1),d0
	bne.b	.l_18266
	cmp.b	$3(a1),d1
	beq.b	.l_18278
.l_18266:
	addq.l	#$8,a0
	dbra	d7,.l_18256
	lea.l	D_32087,a1
	jsr	DI_Error
.l_18278:
	movea.l	a1,a0
	movem.l	(a7)+,d7/a1
	rts
; Stable bubble sort of the action list by the initiative (speed and its bonus).
Sort_action_list:
	lsl.w	#$3,d7
	lea.l	-$8(a0,d7.w),a1
	moveq	#8,d6
	movea.l	a0,a2
.l_1828a:
	move.l	(a0),d0
	adda.l	d6,a0
	cmp.l	(a0),d0
	bgt.b	.l_18298
	cmpa.l	a0,a1
	bne.b	.l_1828a
	bra.b	.l_182c2
.l_18298:
	move.l	(a0),d0
	move.l	$4(a0),d1
	movea.l	a0,a3
.l_182a0:
	suba.l	d6,a0
	cmpa.l	a2,a0
	blt.b	.l_182b4
	move.l	(a0),(a0,d6.l)
	move.l	$4(a0),$4(a0,d6.l)
	cmp.l	(a0),d0
	blt.b	.l_182a0
.l_182b4:
	move.l	d0,(a0,d6.l)
	move.l	d1,$4(a0,d6.l)
	movea.l	a3,a0
	cmpa.l	a0,a1
	bne.b	.l_1828a
.l_182c2:
	rts
; Vertical blank handler of the battle (animations).
Combat_VBL:
	tst.b	B_5bae0
	beq.w	.l_1836a
	addq.w	#$1,B_5b950
	lea.l	B_5ba40,a0
	moveq	#17,d7
.l_182dc:
	move.l	(a0)+,d0
	beq.b	.l_182f6
	movea.l	d0,a1
	tst.w	$10(a1)
	beq.b	.l_182f6
	subq.w	#$1,$10(a1)
	bne.b	.l_182f6
	move.w	#$2,B_5ba3e
.l_182f6:
	dbra	d7,.l_182dc
	moveq	#11,d7
.l_182fc:
	move.l	(a0)+,d0
	beq.b	.l_18316
	movea.l	d0,a1
	tst.w	$a(a1)
	beq.b	.l_18316
	subq.w	#$1,$a(a1)
	bne.b	.l_18316
	move.w	#$2,B_5ba3e
.l_18316:
	dbra	d7,.l_182fc
	tst.w	B_5ba12
	beq.b	.l_1836a
	clr.w	B_5ba16
	lea.l	B_5ba40,a0
	moveq	#17,d7
.l_18330:
	move.l	(a0)+,d0
	beq.b	.l_18354
	movea.l	d0,a1
	tst.w	$14(a1)
	beq.b	.l_18354
	move.w	#$1,B_5ba16
	addq.w	#$1,$16(a1)
	cmpi.w	#$60,$16(a1)
	bne.b	.l_18354
	clr.l	$14(a1)
.l_18354:
	dbra	d7,.l_18330
	tst.w	B_5ba12
	bpl.b	.l_18366
	bsr.w	Idle_animations
	rts
.l_18366:
	bsr.w	Attack_animation_step
.l_1836a:
	rts
T_1836c:
	movem.l	d6-d7/a2,-(a7)
	lea.l	$22(a0),a2
	moveq	#20,d7
.l_18376:
	move.b	(a2)+,(a1)+
	dbra	d7,.l_18376
	clr.b	(a1)+
	move.w	$3a(a0),(a1)+
	move.w	$86(a0),(a1)+
	move.w	$8a(a0),(a1)+
	move.w	$90(a0),(a1)+
	move.w	$92(a0),(a1)+
	lea.l	$132(a0),a2
	moveq	#20,d7
.l_18398:
	moveq	#9,d6
.l_1839a:
	move.l	(a2)+,(a1)+
	dbra	d6,.l_1839a
	dbra	d7,.l_18398
	movem.l	(a7)+,d6-d7/a2
	rts
; A random path for the particles of the spell animations (per round).
Choose_particle_path:
	movem.l	d0-d1/a0,-(a7)
	jsr	Random
	lsr.w	#$1,d0
	ext.l	d0
	lea.l	D_31052,a0
	move.w	(a0)+,d1
	divu.w	d1,d0
	swap	d0
	lsl.w	#$2,d0
	move.l	(a0,d0.w),B_5bae4
	movem.l	(a7)+,d0-d1/a0
	rts
T_183d4:
	jsr	Update_status_block
	movea.l	Off_screen,a6
	tst.w	B_5ba3e
	beq.b	.l_183f2
	subq.w	#$1,B_5ba3e
	bsr.w	T_15f88
.l_183f2:
	bsr.w	T_18418
	tst.w	d0
	bne.b	.l_18416
	clr.w	B_5ba12
	jsr	Switch_screen
	jsr	Copy_screen
	bsr.w	Pop_Module
	st.b	B_5badc
.l_18416:
	rts
T_18418:
	movea.l	Off_screen,a6
	movea.l	B_5b944,a0
	moveq	#16,d0
	moveq	#49,d1
	moveq	#11,d6
	moveq	#112,d7
	jsr	Blot_unmasked_block
	lea.l	B_5ba40,a0
	lea.l	B_5ba1a,a1
	moveq	#17,d7
T_18440:
	move.l	(a0)+,d0
	beq.b	Display_monsters
	movea.l	d0,a2
	move.w	$6(a2),d0
	move.b	d0,(a1)+
	move.w	$c(a2),d0
	move.b	d0,(a1)+
	bra.b	T_18458
; The monsters are drawn from the back row to the front row, their size depends on the row.
Display_monsters:
	move.w	#$ffff,(a1)+
T_18458:
	dbra	d7,T_18440
	lea.l	B_5ba40,a3
	lea.l	T_185aa,a4
	lea.l	B_5ba1a,a5
	moveq	#2,d5
.l_18470:
	move.w	d5,-(a7)
	moveq	#1,d5
	bsr.b	.l_1849a
	moveq	#-1,d5
	bsr.b	.l_1849a
	lea.l	$18(a3),a3
	lea.l	$24(a4),a4
	lea.l	$c(a5),a5
	move.w	(a7)+,d5
	dbra	d5,.l_18470
	move.w	B_5ba14,d0
	or.w	B_5ba16,d0
	rts
.l_1849a:
	movem.l	a3-a5,-(a7)
	moveq	#5,d7
T_184a0:
	movem.w	(a4)+,d0-d2
	move.l	(a3)+,d6
	beq.w	T_18596
	movea.l	d6,a2
	movem.w	d5/d7,-(a7)
	addi.w	#$10,d0
	addi.w	#$31,d1
	movea.l	$2(a2),a0
	moveq	#0,d3
	move.b	$3e(a0),d3
	subq.w	#$1,d3
	lsl.w	#$2,d3
	lea.l	T_18616,a0
	adda.w	d3,a0
	tst.b	$3(a0)
	bne.b	.l_184dc
	tst.w	d5
	bmi.w	T_18592
	moveq	#0,d5
.l_184dc:
	moveq	#0,d6
	bra.b	T_184e2
T_184e0:
	add.b	(a0)+,d6
T_184e2:
	dbra	d2,T_184e0
	moveq	#0,d3
	move.b	$1(a5),d3
	bne.b	Spell_animation_frame
	tst.w	d5
	bmi.w	T_18592
	move.b	(a5),d3
	add.w	d3,d3
	lea.l	T_185a2(pc),a0
	move.w	(a0,d3.w),d3
	bra.b	T_18508
; 6 particles fly around the center of the monster.
Spell_animation_frame:
	tst.w	d5
	bgt.w	T_18592
T_18508:
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
	jsr	T_1c430
	move.w	$14(a2),d2
	beq.b	T_18592
	subq.w	#$1,d2
	mulu.w	#$300,d2
	movea.l	B_5b93e,a0
	adda.w	d2,a0
	move.w	$16(a2),d0
	lsr.w	#$2,d0
	mulu.w	#$12,d0
	movea.l	B_5bae4,a1
	adda.w	d0,a1
	movem.w	-$6(a4),d2-d3
	addq.w	#$8,d2
	addi.w	#$29,d3
	lsr.w	#$1,d7
	sub.w	d7,d3
	moveq	#5,d5
.l_1855e:
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
	ble.b	.l_1858c
	cmp.w	d6,d7
	ble.b	.l_18584
	move.w	d6,d7
.l_18584:
	moveq	#1,d6
	jsr	T_1c430
.l_1858c:
	movea.l	(a7)+,a0
	dbra	d5,.l_1855e
T_18592:
	movem.w	(a7)+,d5/d7
T_18596:
	addq.l	#$2,a5
	dbra	d7,T_184a0
	movem.l	(a7)+,a3-a5
	rts
T_185a2:
	dc.b	$00,$00,$00,$01,$00,$02,$00,$01
T_185aa:
	dc.b	$00,$36,$00,$46,$00,$00,$00,$44,$00,$46,$00,$00,$00,$52,$00,$46
	dc.b	$00,$00,$00,$5e,$00,$46,$00,$00,$00,$6c,$00,$46,$00,$00,$00,$7a
	dc.b	$00,$46,$00,$00,$00,$31,$00,$55,$00,$01,$00,$42,$00,$55,$00,$01
	dc.b	$00,$53,$00,$55,$00,$01,$00,$5d,$00,$55,$00,$01,$00,$6e,$00,$55
	dc.b	$00,$01,$00,$7f,$00,$55,$00,$01,$00,$28,$00,$6e,$00,$02,$00,$3c
	dc.b	$00,$6e,$00,$02,$00,$4e,$00,$6e,$00,$02,$00,$62,$00,$6e,$00,$02
	dc.b	$00,$74,$00,$6e,$00,$02,$00,$88,$00,$6e,$00,$02
T_18616:
	dc.b	$03,$03,$08,$ff,$08,$08,$08,$ff,$03,$03,$08,$00,$03,$03,$09,$00
	dc.b	$03,$03,$08,$00,$08,$08,$08,$00,$08,$08,$08,$00,$08,$08,$08,$00
	dc.b	$08,$08,$08,$00,$03,$03,$08,$00,$03,$03,$08,$00,$08,$08,$08,$ff
	dc.b	$03,$03,$08,$00,$08,$08,$08,$00,$08,$08,$08,$00,$03,$03,$08,$00
	dc.b	$03,$03,$08,$00,$08,$08,$08,$ff,$08,$08,$08,$00,$08,$08,$08,$00
	dc.b	$08,$08,$08,$00
T_1866a:
	movem.l	d0-d7/a0-a6,-(a7)
	tst.b	B_5badd
	beq.b	.l_18698
	clr.w	B_5b950
.l_1867c:
	movea.l	Off_screen,a6
	bsr.w	T_15f88
	jsr	Switch_screen
	cmpi.w	#$32,B_5b950
	blt.b	.l_1867c
	bra.b	.l_186b4
.l_18698:
	movea.l	Off_screen,a6
	bsr.w	T_15f88
	jsr	Switch_screen
	jsr	Copy_screen
	jsr	Wait_4_user
.l_186b4:
	movem.l	(a7)+,d0-d7/a0-a6
	rts
T_186ba:
	movem.l	d0/a0,-(a7)
	lea.l	Char_status_icons,a0
	move.w	Active_member,d0
	subq.w	#$1,d0
	move.b	#$4,(a0,d0.w)
	lea.l	B_5b956,a0
	lsl.w	#$3,d0
	adda.w	d0,a0
	move.w	#$4,(a0)+
	tst.b	Magic_object_flag
	beq.b	.l_186f8
	move.w	#$ffff,(a0)+
	move.b	Object_slot_number,d0
	ext.w	d0
	move.w	d0,(a0)+
	bra.b	.l_18704
.l_186f8:
	dc.b	$30,$f9
	dc.l	Selected_class
	dc.b	$30,$f9
	dc.l	Selected_spell
.l_18704:
	movem.l	(a7)+,d0/a0
	rts
T_1870a:
	movem.l	d0/a0,-(a7)
	lea.l	B_5bb1e,a0
	move.w	Active_member,d0
	subq.w	#$1,d0
	mulu.w	#$92,d0
	adda.w	d0,a0
	tst.w	(a0)
	beq.b	.l_1872a
	bsr.w	T_186ba
.l_1872a:
	movem.l	(a7)+,d0/a0
	rts
; The spell of an item which was used in the inventory becomes the action of its owner.
Item_spell_action:
	movem.l	d0-d7/a0-a6,-(a7)
	tst.b	No_spell_selected
	beq.b	.l_18744
	sf.b	No_spell_selected
	bra.b	.l_18794
.l_18744:
	lea.l	D_4b42e,a0
	move.w	Selected_class,d0
	mulu.w	#$78,d0
	adda.w	d0,a0
	move.w	Selected_spell,d0
	add.w	d0,d0
	add.w	d0,d0
	adda.w	d0,a0
	move.l	a0,B_5b856
	lea.l	.l_1879e,a0
	move.w	Selected_class,d0
	add.w	d0,d0
	add.w	d0,d0
	move.l	-$4(a0,d0.w),d0
	beq.b	.l_18794
	movea.l	d0,a0
	move.w	Selected_spell,d0
	add.w	d0,d0
	add.w	d0,d0
	move.l	-$4(a0,d0.w),d0
	beq.b	.l_18794
	movea.l	d0,a0
	jsr	(a0)
.l_18794:
	bsr.w	T_16b66
	movem.l	(a7)+,d0-d7/a0-a6
	rts
.l_1879e:
	dc.l	.l_187ba
	dc.l	.l_1882a
	dc.l	.l_18892
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.l	.l_188ea
.l_187ba:
	dc.l	T_18bfc
	dc.l	T_18bfc
	dc.l	T_18bfc
	dc.l	T_18bfc
	dc.l	T_18bfc
	dc.l	T_186ba
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.l	T_18ce4
	dc.l	T_18ce4
	dc.l	T_18ce4
	dc.l	T_18ce4
	dc.l	T_18ce4
	dc.l	T_186ba
	dc.l	T_18ce4
	dc.l	T_18ce4
	dc.l	T_18ce4
	dc.l	T_18ce4
	dc.l	T_18d9c
	dc.l	T_18e4e
	dc.l	T_18d9c
	dc.l	T_18d9c
	dc.l	T_18d9c
	dc.l	T_18ede
	dc.l	T_18ef8
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00
.l_1882a:
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.l	T_186ba
	dc.l	T_186ba
	dc.l	T_186ba
	dc.l	T_186ba
	dc.l	T_186ba
	dc.l	T_186ba
	dc.l	T_186ba
	dc.l	T_186ba
	dc.l	T_186ba
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00
	dc.l	T_19002
	dc.l	T_186ba
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00
.l_18892:
	dc.l	T_19098
	dc.l	T_19098
	dc.l	T_19098
	dc.l	T_19098
	dc.l	T_19098
	dc.l	T_19098
	dc.l	T_19098
	dc.l	T_19098
	dc.l	T_19098
	dc.l	T_19098
	dc.l	T_19098
	dc.l	T_19098
	dc.l	T_19098
	dc.l	T_19098
	dc.l	T_19098
	dc.l	T_19098
	dc.l	T_19098
	dc.l	T_19098
	dc.l	T_19098
	dc.l	T_19098
	dc.l	T_19276
	dc.l	T_192e2
.l_188ea:
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.l	T_1945e
	dc.l	T_194d2
	dc.l	T_194d2
	dc.b	$00,$00,$00,$00
	dc.l	T_19582
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00
; Executes a spell in a battle (table of the spell classes behind it).
Cast_combat_spell:
	movem.l	d0-d7/a0-a6,-(a7)
	lea.l	D_4b42e,a0
	move.w	Selected_class,d0
	mulu.w	#$78,d0
	adda.w	d0,a0
	move.w	Selected_spell,d0
	add.w	d0,d0
	add.w	d0,d0
	adda.w	d0,a0
	move.l	a0,B_5b856
	lea.l	.l_18990,a0
	move.w	Selected_class,d0
	add.w	d0,d0
	add.w	d0,d0
	move.l	-$4(a0,d0.w),d0
	beq.b	.l_1898a
	movea.l	d0,a0
	move.w	Selected_spell,d0
	add.w	d0,d0
	add.w	d0,d0
	move.l	-$4(a0,d0.w),d0
	beq.b	.l_1898a
	movea.l	d0,a0
	jsr	(a0)
.l_1898a:
	movem.l	(a7)+,d0-d7/a0-a6
	rts
.l_18990:
	dc.l	.l_189ac	; ori.b #$ac, d1
	dc.l	.l_18a1c	; ori.b #$1c, d1
	dc.l	.l_18a84	; ori.b #$84, d1
	ori.b	#$0,d0
	ori.b	#$0,d0
	ori.b	#$0,d0
	dc.l	.l_18adc	; ori.b #$dc, d1
.l_189ac:
	dc.l	T_18c16	; ori.b #$16, d1
	dc.l	T_18c28	; ori.b #$28, d1
	dc.l	T_18c3a	; ori.b #$3a, d1
	dc.l	T_18c4c	; ori.b #$4c, d1
	dc.l	T_18c5e	; ori.b #$5e, d1
	dc.l	T_18ca2	; ori.b #$a2, d1
	ori.b	#$0,d0
	ori.b	#$0,d0
	ori.b	#$0,d0
	dc.l	T_18d16	; ori.b #$16, d1
	dc.l	T_18d16	; ori.b #$16, d1
	dc.l	T_18d16	; ori.b #$16, d1
	dc.l	T_18d16	; ori.b #$16, d1
	dc.l	T_18d16	; ori.b #$16, d1
	dc.l	T_18d68	; ori.b #$68, d1
	dc.l	T_18d16	; ori.b #$16, d1
	dc.l	T_18d16	; ori.b #$16, d1
	dc.l	T_18d16	; ori.b #$16, d1
	dc.l	T_18d16	; ori.b #$16, d1
	dc.l	Monster_resists	; ori.b #$bc, d1
	dc.l	T_18e68	; ori.b #$68, d1
	dc.l	Monster_resists	; ori.b #$bc, d1
	dc.l	Monster_resists	; ori.b #$bc, d1
	dc.l	Monster_resists	; ori.b #$bc, d1
	dc.l	T_18f12	; ori.b #$12, d1
	dc.l	T_18f12	; ori.b #$12, d1
	ori.b	#$0,d0
	ori.b	#$0,d0
.l_18a1c:
	ori.b	#$0,d0
	ori.b	#$0,d0
	ori.b	#$0,d0
	dc.l	T_18f70	; ori.b #$70, d1
	dc.l	T_18f70	; ori.b #$70, d1
	dc.l	T_18f70	; ori.b #$70, d1
	dc.l	T_18fa0	; ori.b #$a0, d1
	dc.l	T_18fa0	; ori.b #$a0, d1
	dc.l	T_18fa0	; ori.b #$a0, d1
	dc.l	T_18fd0	; ori.b #$d0, d1
	dc.l	T_18fd0	; ori.b #$d0, d1
	dc.l	T_18fd0	; ori.b #$d0, d1
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
	dc.l	T_1901c	; ori.b #$1c, d1
	dc.l	T_19058	; ori.b #$58, d1
	ori.b	#$0,d0
	ori.b	#$0,d0
.l_18a84:
	dc.l	T_190e6	; ori.b #$e6, d1
	dc.l	T_190e6	; ori.b #$e6, d1
	dc.l	T_190e6	; ori.b #$e6, d1
	dc.l	T_190e6	; ori.b #$e6, d1
	dc.l	T_190e6	; ori.b #$e6, d1
	dc.l	T_190e6	; ori.b #$e6, d1
	dc.l	T_190e6	; ori.b #$e6, d1
	dc.l	T_190e6	; ori.b #$e6, d1
	dc.l	T_190e6	; ori.b #$e6, d1
	dc.l	T_190e6	; ori.b #$e6, d1
	dc.l	T_190e6	; ori.b #$e6, d1
	dc.l	T_190e6	; ori.b #$e6, d1
	dc.l	T_190e6	; ori.b #$e6, d1
	dc.l	T_190e6	; ori.b #$e6, d1
	dc.l	T_190e6	; ori.b #$e6, d1
	dc.l	T_190e6	; ori.b #$e6, d1
	dc.l	T_190e6	; ori.b #$e6, d1
	dc.l	T_190e6	; ori.b #$e6, d1
	dc.l	T_190e6	; ori.b #$e6, d1
	dc.l	T_190e6	; ori.b #$e6, d1
	dc.l	T_19290	; ori.b #$90, d1
	dc.l	T_192fc	; ori.b #$fc, d1
.l_18adc:
	dc.l	Monster_condition_spell	; ori.b #$60, d1
	dc.l	Monster_condition_spell	; ori.b #$60, d1
	dc.l	Monster_condition_spell	; ori.b #$60, d1
	dc.l	Monster_condition_spell	; ori.b #$60, d1
	dc.l	Monster_condition_spell	; ori.b #$60, d1
	dc.l	Monster_condition_spell	; ori.b #$60, d1
	dc.l	Monster_condition_spell	; ori.b #$60, d1
	dc.l	Monster_sleep_spell	; ori.b #$f4, d1
	dc.l	Monster_condition_spell	; ori.b #$60, d1
	dc.l	Monster_condition_spell	; ori.b #$60, d1
	ori.b	#$0,d0
	ori.b	#$0,d0
	dc.l	T_19478	; ori.b #$78, d1
	dc.l	T_194ec	; ori.b #$ec, d1
	dc.l	T_19540	; ori.b #$40, d1
	ori.b	#$0,d0
	dc.l	T_1959c	; ori.b #$9c, d1
	ori.b	#$0,d0
	ori.b	#$0,d0
; Party spells use the spell points and probe the skill to use magic, spells of items always succeed.
Use_spell_points:
	movem.l	d0-d1/d7/a0-a1,-(a7)
	moveq	#-1,d7
	lea.l	Chard_ptrs,a0
	move.w	B_5baea,d0
	add.w	d0,d0
	add.w	d0,d0
	move.l	-$4(a0,d0.w),B_5baec
	tst.b	Magic_object_flag
	beq.b	.l_18b96
	move.w	Active_member,B_5b870
	move.w	B_5baea,d0
	movea.l	B_5baec,a0
	move.w	d0,B_5baea
	move.l	a0,Current_active_char_data
	move.l	a0,B_5b840
	lea.l	B_5b94e,a1
	lsl.w	#$3,d0
	adda.w	d0,a1
	move.w	$4(a1),B_5b83e
	bsr.w	Remove_used_magic_item
	sf.b	B_5b861
	moveq	#0,d7
	bra.b	.l_18bce
.l_18b96:
	dc.b	$22,$79
	dc.l	B_5baec
	dc.b	$20,$79
	dc.l	B_5b856
	dc.b	$10,$28,$00,$01,$48,$80,$32,$29,$00,$8a,$92,$40,$6a,$02,$72,$00
	dc.b	$33,$41,$00,$8a,$70,$00,$10,$29,$00,$0f,$d0,$69,$00,$c2,$4e,$b9
	dc.l	Probe
	dc.b	$5b,$c7,$5b,$f9
	dc.l	B_5b861
.l_18bce:
	tst.b	Magic_object_flag
	beq.b	.l_18bf4
	move.w	B_5b870,d0
	move.w	d0,Active_member
	lea.l	Chard_ptrs,a0
	add.w	d0,d0
	add.w	d0,d0
	move.l	-$4(a0,d0.w),Current_active_char_data
.l_18bf4:
	tst.b	d7
	movem.l	(a7)+,d0-d1/d7/a0-a1
	rts
T_18bfc:
	move.w	#$1,B_5be8a
	move.l	#Code0007Sys,B_5be8c
	bsr.w	T_17f02
	bra.w	T_1870a
T_18c16:
	jsr	Random
	mulu.w	#$5,d0
	swap	d0
	addq.w	#$1,d0
	bra.w	T_18c6e
T_18c28:
	jsr	Random
	mulu.w	#$8,d0
	swap	d0
	addq.w	#$2,d0
	bra.w	T_18c6e
T_18c3a:
	jsr	Random
	mulu.w	#$10,d0
	swap	d0
	addq.w	#$4,d0
	bra.w	T_18c6e
T_18c4c:
	jsr	Random
	mulu.w	#$20,d0
	swap	d0
	addq.w	#$8,d0
	bra.w	T_18c6e
T_18c5e:
	dc.b	$4e,$b9
	dc.l	Random
	dc.b	$c0,$fc,$00,$40,$48,$40,$06,$40,$00,$10
T_18c6e:
	bsr.w	Use_spell_points
	bmi.b	.l_18ca0
	lea.l	B_5bb20,a1
	move.w	B_5baea,d1
	subq.w	#$1,d1
	mulu.w	#$92,d1
	adda.w	d1,a1
	movea.l	(a1),a0
	move.w	$3a(a0),d1
	andi.w	#$e080,d1
	bne.b	.l_18ca0
	bsr.w	Increase_LP
	move.w	$4(a1),d0
	bsr.w	Do_sparkle
.l_18ca0:
	rts
T_18ca2:
	bsr.w	Use_spell_points
	bmi.b	.l_18ce2
	lea.l	Chard_ptrs,a1
	moveq	#1,d7
.l_18cb0:
	tst.l	(a1)
	beq.b	.l_18cd8
	movea.l	(a1),a0
	move.w	#$e080,d1
	and.w	Body_conditions(a0),d1
	bne.b	.l_18cd8
	jsr	Random
	mulu.w	#$10,d0
	swap	d0
	addq.w	#$4,d0
	bsr.w	Increase_LP
	move.w	d7,d0
	bsr.w	Do_sparkle
.l_18cd8:
	addq.l	#$4,a1
	addq.w	#$1,d7
	cmpi.w	#$7,d7
	bmi.b	.l_18cb0
.l_18ce2:
	rts
T_18ce4:
	move.w	Selected_spell,d0
	subi.w	#$a,d0
	move.b	.l_18d0c(pc,d0.w),d0
	ext.w	d0
	move.w	d0,B_5be8a
	move.l	#Code0007Sys,B_5be8c
	bsr.w	T_17f02
	bra.w	T_1870a
.l_18d0c:
	dc.b	$05,$06,$07,$08,$09,$ff,$0a,$0b,$0c,$0d
T_18d16:
	lea.l	B_5bb20,a1
	move.w	B_5baea,d1
	subq.w	#$1,d1
	mulu.w	#$92,d1
	adda.w	d1,a1
	movea.l	(a1),a0
	move.w	$3a(a0),d0
	andi.w	#$e080,d0
	bne.b	.l_18d5c
	bsr.w	Use_spell_points
	bmi.b	.l_18d5c
	move.w	Selected_spell,d0
	subi.w	#$a,d0
	move.b	.l_18d5e(pc,d0.w),d0
	move.w	$3a(a0),d1
	bclr	d0,d1
	move.w	d1,$3a(a0)
	move.w	$4(a1),d0
	bsr.w	Do_sparkle
.l_18d5c:
	rts
.l_18d5e:
	dc.b	$09,$08,$0b,$0c,$0a,$ff,$03,$00,$04,$01
T_18d68:
	bsr.w	Use_spell_points
	bmi.b	.l_18d9a
	lea.l	Chard_ptrs,a0
	moveq	#1,d0
.l_18d76:
	tst.l	(a0)
	beq.b	.l_18d90
	movea.l	(a0),a1
	move.w	$3a(a1),d1
	andi.w	#$e080,d1
	bne.b	.l_18d90
	bclr	#$2,$3b(a1)
	bsr.w	Do_sparkle
.l_18d90:
	addq.l	#$4,a0
	addq.w	#$1,d0
	cmpi.w	#$7,d0
	bmi.b	.l_18d76
.l_18d9a:
	rts
T_18d9c:
	move.w	Selected_spell,d0
	subq.w	#$6,d0
	move.w	d0,B_5be8a
	move.l	#Code0007Sys,B_5be8c
	bsr.w	T_17de4
	bra.w	T_1870a
; Monsters resist with their anti-magic, some are immune to the condition spells.
Monster_resists:
	lea.l	B_5bb20,a0
	move.w	B_5baea,d1
	subq.w	#$1,d1
	mulu.w	#$92,d1
	adda.w	d1,a0
	movea.l	(a0)+,a1
	movea.l	(a0)+,a2
	move.w	$2e(a2),d0
	andi.w	#$e080,d0
	bne.b	.l_18e42
	bsr.w	Use_spell_points
	bmi.b	.l_18e42
	move.w	$56(a1),d0
	add.w	$aa(a1),d0
	jsr	Probe
	bmi.b	.l_18e02
	move.l	a0,-(a7)
	moveq	#12,d0
	movea.l	a1,a0
	bsr.w	T_181f6
	movea.l	(a7)+,a0
	bra.b	.l_18e42
.l_18e02:
	btst	#$2,$44(a1)
	beq.b	.l_18e18
	move.l	a0,-(a7)
	moveq	#13,d0
	movea.l	a1,a0
	bsr.w	T_181f6
	movea.l	(a7)+,a0
	bra.b	.l_18e42
.l_18e18:
	dc.b	$41,$f9
	dc.l	.l_18e44
	dc.b	$30,$39
	dc.l	Selected_spell
	dc.b	$04,$40,$00,$14,$d0,$40,$d0,$c0,$10,$18,$32,$2a,$00,$2e,$01,$c1
	dc.b	$35,$41,$00,$2e,$10,$10,$48,$80,$20,$4a,$61,$00,$08,$10
.l_18e42:
	rts
.l_18e44:
	dc.b	$08,$04,$ff,$ff,$03,$06,$00,$07,$04,$0e
T_18e4e:
	move.w	#$f,B_5be8a
	move.l	#Code0007Sys,B_5be8c
	bsr.w	T_1801a
	bra.w	T_1870a
T_18e68:
	bsr.w	Use_spell_points
	bmi.b	T_18edc
	lea.l	B_5bb1e,a0
	move.w	B_5baea,d0
	subq.w	#$1,d0
	mulu.w	#$92,d0
	adda.w	d0,a0
	move.w	(a0)+,d7
	bra.b	T_18ed8
T_18e86:
	movea.l	(a0)+,a1
	movea.l	(a0)+,a2
	move.w	$2e(a2),d0
	andi.w	#$e080,d0
	bne.b	T_18ed8
	move.w	$56(a1),d0
	add.w	$aa(a1),d0
	jsr	Probe
	bmi.b	.l_18eb2
	move.l	a0,-(a7)
	moveq	#12,d0
	movea.l	a1,a0
	bsr.w	T_181f6
	movea.l	(a7)+,a0
	bra.b	T_18ed8
.l_18eb2:
	btst	#$2,$44(a1)
	beq.b	.l_18ec8
	move.l	a0,-(a7)
	moveq	#13,d0
	movea.l	a1,a0
	bsr.w	T_181f6
	movea.l	(a7)+,a0
	bra.b	T_18ed8
.l_18ec8:
	dc.b	$08,$ea,$00,$02,$00,$2f,$70,$05,$c1,$4a,$61,$00,$07,$7c,$c1,$4a
T_18ed8:
	dbra	d7,T_18e86
T_18edc:
	rts
T_18ede:
	move.l	#Code0007Sys,B_5be8c
	move.w	#$13,B_5be8a
	bsr.w	T_17de4
	bra.w	T_1870a
T_18ef8:
	move.l	#Code0007Sys,B_5be8c
	move.w	#$14,B_5be8a
	bsr.w	T_1801a
	bra.w	T_1870a
T_18f12:
	bsr.w	Use_spell_points
	bmi.b	T_18f6e
	lea.l	B_5bb1e,a0
	move.w	B_5baea,d0
	subq.w	#$1,d0
	mulu.w	#$92,d0
	adda.w	d0,a0
	move.w	(a0)+,d7
	bra.b	T_18f6a
T_18f30:
	movea.l	(a0)+,a1
	movea.l	(a0)+,a2
	move.w	$2e(a2),d0
	andi.w	#$e080,d0
	bne.b	T_18f6a
	btst	#$0,$44(a1)
	beq.b	T_18f6a
	move.w	$56(a1),d0
	add.w	$aa(a1),d0
	jsr	Probe
	bmi.b	.l_18f64
	move.l	a0,-(a7)
	moveq	#12,d0
	movea.l	a1,a0
	bsr.w	T_181f6
	movea.l	(a7)+,a0
	bra.b	T_18f6a
.l_18f64:
	dc.b	$08,$ea,$00,$05,$00,$2e
T_18f6a:
	dbra	d7,T_18f30
T_18f6e:
	rts
T_18f70:
	bsr.w	Use_spell_points
	bmi.b	.l_18f92
	move.w	Selected_spell,d0
	subq.w	#$3,d0
	add.w	d0,d0
	add.w	d0,d0
	move.w	.l_18f94(pc,d0.w),Spell_2_data
	move.w	.l_18f96(pc,d0.w),Spell_2_duration
.l_18f92:
	rts
.l_18f94:
	dc.b	$00,$05
.l_18f96:
	dc.b	$00,$18,$00,$0a,$00,$60,$00,$0f,$00,$c0
T_18fa0:
	bsr.w	Use_spell_points
	bmi.b	.l_18fc2
	move.w	Selected_spell,d0
	subq.w	#$6,d0
	add.w	d0,d0
	add.w	d0,d0
	move.w	.l_18fc4(pc,d0.w),Spell_3_data
	move.w	.l_18fc6(pc,d0.w),Spell_3_duration
.l_18fc2:
	rts
.l_18fc4:
	dc.b	$00,$05
.l_18fc6:
	dc.b	$00,$18,$00,$0a,$00,$60,$00,$0f,$00,$c0
T_18fd0:
	bsr.w	Use_spell_points
	bmi.b	.l_18ff4
	move.w	Selected_spell,d0
	subi.w	#$9,d0
	add.w	d0,d0
	add.w	d0,d0
	move.w	.l_18ff6(pc,d0.w),Spell_4_data
	move.w	.l_18ff8(pc,d0.w),Spell_4_duration
.l_18ff4:
	rts
.l_18ff6:
	dc.b	$00,$05
.l_18ff8:
	dc.b	$00,$18,$00,$0a,$00,$60,$00,$0f,$00,$c0
T_19002:
	move.l	#Code0007Sys,B_5be8c
	move.w	#$17,B_5be8a
	bsr.w	T_17f02
	bra.w	T_1870a
T_1901c:
	lea.l	B_5bb20,a1
	move.w	B_5baea,d1
	subq.w	#$1,d1
	mulu.w	#$92,d1
	adda.w	d1,a1
	movea.l	(a1),a0
	move.w	$3a(a0),d0
	andi.w	#$e080,d0
	bne.b	.l_19056
	bsr.w	Use_spell_points
	bmi.b	.l_19056
	move.w	$4(a1),d0
	bset	d0,B_5b863
	bne.b	.l_19056
	move.w	$4(a1),d0
	bsr.w	Do_sparkle
.l_19056:
	rts
T_19058:
	bsr.w	Use_spell_points
	bmi.b	.l_19096
	lea.l	Chard_ptrs,a0
	moveq	#1,d0
	move.b	B_5b863,d1
.l_1906c:
	tst.l	(a0)
	beq.b	.l_19086
	movea.l	(a0),a1
	move.w	$3a(a1),d2
	andi.w	#$e080,d2
	bne.b	.l_19086
	btst	d0,d1
	bne.b	.l_19086
	bset	d0,d1
	bsr.w	Do_sparkle
.l_19086:
	addq.l	#$4,a0
	addq.w	#$1,d0
	cmpi.w	#$7,d0
	bmi.b	.l_1906c
	move.b	d1,B_5b863
.l_19096:
	rts
T_19098:
	movea.l	B_5b856,a0
	move.b	$3(a0),d0
	btst	#$4,d0
	beq.b	.l_190ae
	bsr.w	T_18140
	bra.b	.l_190e2
.l_190ae:
	btst	#$3,d0
	beq.b	.l_190cc
	move.w	#$1,B_5be8a
	move.l	#Code0008Sys,B_5be8c
	bsr.w	T_1801a
	bra.b	.l_190e2
.l_190cc:
	dc.b	$33,$fc,$00,$00
	dc.l	B_5be8a
	dc.b	$23,$fc
	dc.l	Code0008Sys
	dc.l	B_5be8c
	dc.b	$61,$00,$ed,$04
.l_190e2:
	bra.w	T_1870a
T_190e6:
	movea.l	B_5b856,a0
	move.b	$3(a0),d0
	tst.b	B_5bae9
	beq.b	T_19136
	bsr.w	T_195ea
	bmi.b	T_19160
	btst	#$4,d0
	beq.b	.l_1910a
	bsr.w	T_17db0
	bra.b	.l_1911a
.l_1910a:
	btst	#$3,d0
	beq.b	.l_19116
	bsr.w	T_17d6a
	bra.b	.l_1911a
.l_19116:
	dc.b	$61,$00,$ec,$2c
.l_1911a:
	lea.l	B_5bafa,a0
	move.w	B_5baf8,d6
	bra.b	T_19130
T_19128:
	dc.b	$22,$58,$3e,$18,$61,$00,$00,$e4
T_19130:
	dbra	d6,T_19128
	bra.b	T_19160
T_19136:
	bsr.w	Use_spell_points
	bmi.b	T_19160
	lea.l	B_5bb1e,a0
	move.w	B_5baea,d0
	subq.w	#$1,d0
	mulu.w	#$92,d0
	adda.w	d0,a0
	move.w	(a0)+,d7
	bra.b	.l_1915c
	dc.b	$22,$58,$24,$58,$61,$00,$00,$08
.l_1915c:
	dc.b	$51,$cf,$ff,$f6
T_19160:
	rts
; Damage spells, dissolve and magic arrows on monsters.
Damage_spell:
	movem.l	d0-d3/a0,-(a7)
	move.w	$2e(a2),d0
	andi.w	#$e080,d0
	bne.w	.l_1920c
	move.w	$56(a1),d0
	add.w	$aa(a1),d0
	jsr	Probe
	bmi.b	.l_19194
	movem.l	d0/a0,-(a7)
	moveq	#12,d0
	movea.l	a1,a0
	bsr.w	T_181f6
	movem.l	(a7)+,d0/a0
	bra.b	.l_1920c
.l_19194:
	movea.l	B_5b856,a0
	move.b	(a0),d0
	rol.b	#$2,d0
	andi.w	#$3,d0
	lea.l	D_313c6,a0
	move.b	(a0,d0.w),d0
	move.b	$45(a1),d1
	btst	d0,d1
	beq.b	.l_191c6
	movem.l	d0/a0,-(a7)
	moveq	#13,d0
	movea.l	a1,a0
	bsr.w	T_181f6
	movem.l	(a7)+,d0/a0
	bra.b	.l_1920c
.l_191c6:
	dc.b	$58,$40,$01,$01,$56,$f9
	dc.l	B_5bae8
	dc.b	$41,$f9
	dc.l	Spell_damage_table
	dc.b	$30,$39
	dc.l	Selected_spell
	dc.b	$c0,$fc,$00,$06,$d0,$c0,$4c,$90,$00,$0e,$94,$41,$4e,$b9
	dc.l	Random
	dc.b	$c0,$c2,$48,$40,$52,$40,$d2,$40,$4a,$39
	dc.l	B_5bae8
	dc.b	$67,$02,$d2,$41,$20,$4a,$61,$00,$04,$22,$30,$03,$61,$00,$04,$46
.l_1920c:
	movem.l	(a7)+,d0-d3/a0
	rts
; Black magic damage spells of monsters on the party.
Monster_damage_spell:
	movem.l	d0-d3/a0,-(a7)
	move.w	$56(a1),d0
	add.w	$aa(a1),d0
	add.w	Spell_4_data,d0
	jsr	Probe
	bmi.b	.l_1923e
	movem.l	d0/a0,-(a7)
	moveq	#12,d0
	movea.l	a1,a0
	bsr.w	T_181f6
	movem.l	(a7)+,d0/a0
	bra.b	.l_19270
.l_1923e:
	dc.b	$41,$f9
	dc.l	Spell_damage_table
	dc.b	$30,$39
	dc.l	Selected_spell
	dc.b	$c0,$fc,$00,$06,$d0,$c0,$4c,$90,$00,$0e,$94,$41,$4e,$b9
	dc.l	Random
	dc.b	$c0,$c2,$48,$40,$52,$40,$d2,$40,$30,$07,$4e,$b9
	dc.l	Do_damage
	dc.b	$61,$00,$ce,$62
.l_19270:
	movem.l	(a7)+,d0-d3/a0
	rts
T_19276:
	move.l	#Code0008Sys,B_5be8c
	move.w	#$2,B_5be8a
	bsr.w	T_17de4
	bra.w	T_1870a
T_19290:
	bsr.w	Use_spell_points
	bmi.b	.l_192e0
	lea.l	B_5bb20,a0
	move.w	B_5baea,d0
	subq.w	#$1,d0
	mulu.w	#$92,d0
	adda.w	d0,a0
	movea.l	(a0)+,a1
	movea.l	(a0)+,a2
	move.w	$2e(a2),d0
	andi.w	#$e080,d0
	bne.b	.l_192e0
	move.w	$56(a1),d0
	add.w	$aa(a1),d0
	jsr	Probe
	bmi.b	.l_192da
	movem.l	d0/a0,-(a7)
	moveq	#12,d0
	movea.l	a1,a0
	bsr.w	T_181f6
	movem.l	(a7)+,d0/a0
	bra.b	.l_192e0
.l_192da:
	dc.b	$08,$ea,$00,$05,$00,$2e
.l_192e0:
	rts
T_192e2:
	move.l	#Code0008Sys,B_5be8c
	move.w	#$1,B_5be8a
	bsr.w	T_1801a
	bra.w	T_1870a
T_192fc:
	bsr.w	Use_spell_points
	bmi.b	T_1935e
	lea.l	B_5bb1e,a0
	move.w	B_5baea,d0
	subq.w	#$1,d0
	mulu.w	#$92,d0
	adda.w	d0,a0
	move.w	(a0)+,d7
	bra.b	T_1935a
T_1931a:
	movea.l	(a0)+,a1
	movea.l	(a0)+,a2
	move.w	$2e(a2),d0
	andi.w	#$e080,d0
	bne.b	T_1935a
	move.w	$56(a1),d0
	add.w	$aa(a1),d0
	jsr	Probe
	bmi.b	.l_1934a
	movem.l	d0/a0,-(a7)
	moveq	#12,d0
	movea.l	a1,a0
	bsr.w	T_181f6
	movem.l	(a7)+,d0/a0
	bra.b	T_1935a
.l_1934a:
	dc.b	$72,$08,$c1,$4a,$61,$00,$02,$d6,$70,$0a,$61,$00,$02,$fa,$c1,$4a
T_1935a:
	dbra	d7,T_1931a
T_1935e:
	rts
; Condition spells of monsters on a random party member.
Monster_condition_spell:
	bsr.w	T_195ea
	bmi.b	.l_193de
	bsr.w	T_17d44
	tst.w	B_5baf8
	beq.b	.l_193de
	lea.l	B_5bafa,a0
	movea.l	(a0),a1
	move.w	$56(a1),d0
	add.w	$aa(a1),d0
	add.w	Spell_4_data,d0
	jsr	Probe
	bmi.b	.l_193a2
	movem.l	d0/a0,-(a7)
	moveq	#12,d0
	movea.l	a1,a0
	bsr.w	T_181f6
	movem.l	(a7)+,d0/a0
	bra.b	.l_193de
.l_193a2:
	dc.b	$45,$f9
	dc.l	.l_193de
	dc.b	$30,$39
	dc.l	Selected_spell
	dc.b	$d0,$40,$d4,$c0,$10,$12,$32,$29,$00,$3a,$01,$c1,$33,$41,$00,$3a
	dc.b	$41,$f9
	dc.l	B_5bafa
	dc.b	$30,$28,$00,$04,$61,$00,$c5,$6e,$70,$00,$10,$2a,$00,$01,$20,$49
	dc.b	$61,$00,$ee,$20,$42,$79
	dc.l	B_5b94e
.l_193de:
	rts
	dc.b	$08,$0f,$09,$10,$0a,$11,$0b,$12,$0c,$13,$00,$14,$01,$15,$ff,$ff
	dc.b	$03,$17,$04,$18
; Sleep on the whole party.
Monster_sleep_spell:
	bsr.w	T_195ea
	bmi.b	T_1945c
	bsr.w	T_17db0
	lea.l	B_5bafa,a0
	move.w	B_5baf8,d7
	bra.b	T_19458
T_1940c:
	movea.l	(a0),a1
	move.w	$56(a1),d0
	add.w	$aa(a1),d0
	add.w	Spell_4_data,d0
	jsr	Probe
	bmi.b	.l_19436
	movem.l	d0/a0,-(a7)
	moveq	#12,d0
	movea.l	a1,a0
	bsr.w	T_181f6
	movem.l	(a7)+,d0/a0
	bra.b	.l_19456
.l_19436:
	dc.b	$08,$e9,$00,$02,$00,$3b,$30,$28,$00,$04,$61,$00,$c4,$f6,$2f,$08
	dc.b	$70,$16,$20,$49,$61,$00,$ed,$aa,$20,$5f,$42,$79
	dc.l	B_5b94e
.l_19456:
	dc.b	$5c,$88
T_19458:
	dbra	d7,T_1940c
T_1945c:
	rts
T_1945e:
	move.l	#Code0008Sys,B_5be8c
	move.w	#$4,B_5be8a
	bsr.w	T_17de4
	bra.w	T_1870a
T_19478:
	bsr.w	Use_spell_points
	bmi.b	.l_194d0
	lea.l	B_5bb20,a0
	move.w	B_5baea,d0
	subq.w	#$1,d0
	mulu.w	#$92,d0
	adda.w	d0,a0
	movea.l	(a0)+,a1
	movea.l	(a0)+,a2
	move.w	$2e(a2),d0
	andi.w	#$e080,d0
	bne.b	.l_194d0
	btst	#$1,$44(a1)
	beq.b	.l_194d0
	move.w	$56(a1),d0
	add.w	$aa(a1),d0
	jsr	Probe
	bpl.b	.l_194ca
	movem.l	d0/a0,-(a7)
	moveq	#12,d0
	movea.l	a1,a0
	bsr.w	T_181f6
	movem.l	(a7)+,d0/a0
	bra.b	.l_194d0
.l_194ca:
	dc.b	$08,$ea,$00,$05,$00,$2e
.l_194d0:
	rts
T_194d2:
	move.w	#$5,B_5be8a
	move.l	#Code0008Sys,B_5be8c
	bsr.w	T_17f02
	bra.w	T_1870a
T_194ec:
	bsr.w	Use_spell_points
	bmi.b	.l_1953e
	lea.l	B_5bb20,a1
	move.w	B_5baea,d1
	subq.w	#$1,d1
	mulu.w	#$92,d1
	adda.w	d1,a1
	movea.l	(a1),a0
	move.w	$3a(a0),d1
	andi.w	#$e080,d1
	bne.b	.l_1953e
	jsr	Random
	mulu.w	#$19,d0
	swap	d0
	addq.w	#$1,d0
	add.w	$8a(a0),d0
	move.w	$8c(a0),d1
	add.w	$9a(a0),d1
	cmp.w	d1,d0
	bpl.b	.l_19532
	move.w	d0,d1
.l_19532:
	move.w	d1,$8a(a0)
	move.w	$4(a1),d0
	bsr.w	Do_sparkle
.l_1953e:
	rts
T_19540:
	bsr.w	Use_spell_points
	bmi.b	.l_19580
	lea.l	B_5bb20,a1
	move.w	B_5baea,d1
	subq.w	#$1,d1
	mulu.w	#$92,d1
	adda.w	d1,a1
	movea.l	(a1),a0
	move.w	$3a(a0),d1
	andi.w	#$e080,d1
	bne.b	.l_19580
	move.w	$8c(a0),d0
	add.w	$9a(a0),d0
	cmp.w	$8a(a0),d0
	bmi.b	.l_19580
	move.w	d0,$8a(a0)
	move.w	$4(a1),d0
	bsr.w	Do_sparkle
.l_19580:
	rts
T_19582:
	move.l	#Code0008Sys,B_5be8c
	move.w	#$7,B_5be8a
	bsr.w	T_17f02
	bra.w	T_1870a
T_1959c:
	bsr.w	Use_spell_points
	bmi.b	.l_195e8
	lea.l	B_5bb20,a1
	move.w	B_5baea,d1
	subq.w	#$1,d1
	mulu.w	#$92,d1
	adda.w	d1,a1
	movea.l	(a1),a0
	move.w	$3a(a0),d1
	andi.w	#$e080,d1
	bne.b	.l_195e8
	move.w	$58(a0),d1
	jsr	Random
	mulu.w	#$a,d0
	swap	d0
	addq.w	#$1,d0
	sub.w	d0,d1
	cmpi.w	#$f,d1
	bmi.b	.l_195e8
	move.w	d1,$58(a0)
	move.w	$4(a1),d0
	bsr.w	Do_sparkle
.l_195e8:
	rts
T_195ea:
	movem.l	d0/a0-a1,-(a7)
	movea.l	B_5b856,a0
	movea.l	B_5baf4,a1
	move.b	$1(a0),d0
	ext.w	d0
	sub.w	d0,$32(a1)
	movea.l	B_5baf0,a1
	moveq	#0,d0
	move.b	$f(a1),d0
	add.w	$c2(a1),d0
	jsr	Probe
	smi.b	B_5b861
	movem.l	(a7)+,d0/a0-a1
	rts
	move.l	d2,-(a7)
	bclr	#$2,$2f(a0)
	move.w	d1,$12(a0)
	move.w	#$64,$10(a0)
	move.w	$30(a0),d2
	sub.w	d1,d2
	bgt.b	.l_19648
	ori.w	#$2000,$2e(a0)
	moveq	#0,d2
.l_19648:
	move.w	d2,$30(a0)
	move.l	(a7)+,d2
	rts
; Starts the particle animation of a spell (96 VBL).
Start_spell_animation:
	move.w	d0,$14(a0)
	clr.w	$16(a0)
	move.w	#$1,B_5ba14
	rts
; Clears irritation, sleep, panic and the fled flag, removes the group from the map, loot and experience.
End_of_combat:
	sf.b	Battling
	jsr	Set_spell_area
	move.w	B_5aa94,d0
	beq.b	.l_196ae
	move.w	d0,d1
	add.w	d0,d0
	add.w	d0,d0
	lea.l	Chard_ptrs,a0
	move.l	-$4(a0,d0.w),d0
	beq.b	.l_196ae
	movea.l	d0,a0
	move.w	$3a(a0),d0
	andi.w	#$e406,d0
	bne.b	.l_196ae
	move.w	d1,Active_member
	lea.l	Chard_ptrs,a0
	add.w	d1,d1
	add.w	d1,d1
	move.l	-$4(a0,d1.w),Current_active_char_data
	bra.b	.l_196c4
.l_196ae:
	movea.l	Current_active_char_data,a0
	move.w	Body_conditions(a0),d0
	andi.w	#$e406,d0
	beq.b	.l_196c4
	jsr	Check_party_alive
.l_196c4:
	tst.w	B_5be90
	beq.b	.l_196da
	jsr	Restore_coords
	sf.b	B_5bea6
	bra.b	.l_19748
.l_196da:
	tst.b	B_5bea6
	beq.b	.l_196f6
	movea.l	Event_data_ptr,a5
	jsr	Save_event
	sf.b	B_5bea6
	bra.b	.l_1972c
.l_196f6:
	move.w	B_5be92,d0
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
.l_1972c:
	tst.w	B_5b998
	bne.b	.l_1973c
	tst.w	B_5ba08
	beq.b	.l_19748
.l_1973c:
	lea.l	D_3030e,a0
	jmp	Push_Module
.l_19748:
	bsr.w	T_19754
	jsr	Init_display
	rts
T_19754:
	movem.l	d0/d7/a0,-(a7)
	lea.l	Chard_ptrs,a0
	moveq	#5,d7
.l_19760:
	tst.l	(a0)
	beq.b	.l_19772
	movea.l	(a0),a1
	move.w	Body_conditions(a1),d0
	andi.w	#$ff72,d0
	move.w	d0,Body_conditions(a1)
.l_19772:
	addq.l	#$4,a0
	dbra	d7,.l_19760
	movem.l	(a7)+,d0/d7/a0
	rts
T_1977e:
	jsr	T_0025a
	lea.l	B_5b99a,a0
	moveq	#0,d0
	moveq	#0,d1
	move.w	B_5b998,d7
	bra.b	T_197a0
T_19796:
	movea.l	(a0)+,a1
	add.w	$34(a1),d0
	add.w	$36(a1),d1
T_197a0:
	dbra	d7,T_19796
	move.w	d0,B_5bea0
	move.w	d1,B_5bea2
	lea.l	B_5b99a,a0
	moveq	#0,d0
	move.w	B_5b998,d7
	bra.b	T_197d2
T_197c0:
	movea.l	(a0)+,a1
	lea.l	$18(a1),a1
	moveq	#20,d6
.l_197c8:
	tst.b	(a1)+
	beq.b	.l_197ce
	addq.w	#$1,d0
.l_197ce:
	dbra	d6,.l_197c8
T_197d2:
	dbra	d7,T_197c0
	tst.w	d0
	bne.b	.l_197e2
	move.w	d0,B_5be9e
	bra.b	.l_1985e
.l_197e2:
	addq.w	#$5,d0
	divu.w	#$6,d0
	cmpi.w	#$2,d0
	bpl.b	.l_197f0
	moveq	#2,d0
.l_197f0:
	mulu.w	#$6,d0
	move.w	d0,B_5be9e
	jsr	Allocate_memory
	move.l	a1,B_5be94
	movea.l	a1,a2
	lea.l	-$c(a2,d0.w),a0
	clr.l	(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
	mulu.w	#$28,d0
	jsr	Allocate_memory
	move.l	a1,B_5be98
	lea.l	B_5b99a,a0
	moveq	#0,d0
	move.w	B_5b998,d7
	subq.w	#$1,d7
.l_19832:
	movea.l	(a0)+,a3
	lea.l	$38(a3),a4
	lea.l	$18(a3),a3
	moveq	#20,d6
.l_1983e:
	tst.b	(a3)
	beq.b	.l_19850
	move.b	(a3),(a2)+
	moveq	#19,d5
.l_19846:
	move.w	(a4)+,(a1)+
	dbra	d5,.l_19846
	lea.l	-$28(a4),a4
.l_19850:
	addq.l	#$1,a3
	lea.l	$28(a4),a4
	dbra	d6,.l_1983e
	dbra	d7,.l_19832
.l_1985e:
	moveq	#21,d0
	lea.l	D_2902e,a0
	jsr	Load_80x80_picture
	jsr	T_00208
	bsr.w	T_199ce
	lea.l	Chard_ptrs,a0
	moveq	#0,d2
	moveq	#5,d7
.l_19880:
	tst.l	(a0)
	beq.b	.l_19892
	movea.l	(a0),a1
	move.w	Body_conditions(a1),d0
	andi.w	#$e080,d0
	bne.b	.l_19892
	addq.w	#$1,d2
.l_19892:
	addq.l	#$4,a0
	dbra	d7,.l_19880
	tst.w	d2
	beq.w	.l_19960
	moveq	#0,d6
	move.w	B_5ba08,d6
	divu.w	d2,d6
	ext.l	d6
	lea.l	Chard_ptrs,a0
	moveq	#5,d7
.l_198b2:
	tst.l	(a0)
	beq.b	.l_198c6
	movea.l	(a0),a1
	move.w	Body_conditions(a1),d0
	andi.w	#$e080,d0
	bne.b	.l_198c6
	add.l	d6,Experience_points(a1)
.l_198c6:
	addq.l	#$4,a0
	dbra	d7,.l_198b2
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
	lea.l	D_29096,a0
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
.l_19960:
	move.l	#Lay3_PlusMes,PlusMes_info
	move.l	#Code0008Sys,Textfile_ptr
	movea.l	Off_screen,a6
	move.w	#$11,d0
	jsr	Hash_message
	jsr	Switch_screen
	jsr	Copy_screen
	bra.w	T_19754
T_19994:
	movea.l	B_5bab8,a0
	jsr	Free_memory
	tst.w	B_5be9e
	beq.b	.l_199c0
	movea.l	B_5be94,a0
	jsr	Free_memory
	movea.l	B_5be98,a0
	jsr	Free_memory
.l_199c0:
	movea.l	Pic80_ptr,a0
	jsr	Free_memory
	rts
T_199ce:
	move.l	#Lay3_PlusMes,PlusMes_info
	movea.l	Off_screen,a6
	moveq	#3,d0
	jsr	Show_layout
	tst.w	B_5be9e
	beq.b	.l_19a10
	move.w	#$0,B_5be9c
	move.l	B_5be98,Itemdata_ptr
	move.l	B_5be94,Itemslots_ptr
	jsr	Show_objects_LAY3
.l_19a10:
	moveq	#15,d0
	jsr	IG_Set_ink
	moveq	#2,d0
	jsr	IG_Set_paper
	tst.w	B_5bea0
	sne.b	B_5bea4
	beq.b	.l_19a46
	move.w	#$70,d0
	move.w	#$71,d1
	move.w	#$40,d2
	lea.l	Gold_txt,a0
	jsr	Print_centered_string
.l_19a46:
	tst.w	B_5bea2
	sne.b	B_5bea5
	beq.b	.l_19a6c
	move.w	#$f0,d0
	move.w	#$71,d1
	move.w	#$40,d2
	lea.l	Food_txt,a0
	jsr	Print_centered_string
.l_19a6c:
	jsr	Display_80x80_picture
	lea.l	D_31444,a0
	bsr.w	T_19b3a
	move.l	a0,Control_list_ptr
	jsr	Show_control_icons
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	Lay3_L2,a0
	jsr	Set_layout_data
	jmp	Fadein_lay3
T_19aa6:
	movea.l	Off_screen,a6
	jsr	Update_status_block
	lea.l	D_31444,a0
	lea.l	T_19b3a,a1
	jsr	Update_control_icons
	moveq	#15,d0
	jsr	IG_Set_ink
	moveq	#2,d0
	jsr	IG_Set_paper
	tst.b	B_5bea4
	beq.b	.l_19b06
	move.w	B_5bea0,d0
	moveq	#48,d1
	moveq	#5,d7
	lea.l	GoldDis_text,a0
	movea.l	a0,a3
	jsr	RConvert_number
	move.w	#$70,d0
	move.w	#$79,d1
	move.w	#$40,d2
	jsr	Print_centered_string
.l_19b06:
	tst.b	B_5bea5
	beq.b	.l_19b38
	move.w	B_5bea2,d0
	moveq	#48,d1
	moveq	#4,d7
	lea.l	D_2907d,a0
	movea.l	a0,a3
	jsr	RConvert_number
	move.w	#$f0,d0
	move.w	#$79,d1
	move.w	#$40,d2
	jsr	Print_centered_string
.l_19b38:
	rts
T_19b3a:
	movea.l	a0,a1
	moveq	#8,d7
.l_19b3e:
	bclr	#$7,(a1)+
	dbra	d7,.l_19b3e
	tst.w	B_5bea0
	bne.b	.l_19b5a
	bset	#$7,$4(a0)
	bset	#$7,$5(a0)
.l_19b5a:
	tst.w	B_5bea2
	bne.b	.l_19b6e
	bset	#$7,$7(a0)
	bset	#$7,$8(a0)
.l_19b6e:
	tst.w	B_5be9e
	beq.b	T_19b92
	movea.l	B_5be94,a1
	move.b	(a1)+,d0
	move.w	B_5be9e,d7
	subq.w	#$1,d7
	bra.b	T_19b8a
T_19b88:
	or.b	(a1)+,d0
T_19b8a:
	dbra	d7,T_19b88
	tst.b	d0
	bne.b	T_19bac
T_19b92:
	bset	#$7,$0(a0)
	bset	#$7,$1(a0)
	bset	#$7,$3(a0)
	bset	#$7,$6(a0)
	bra.b	T_19bea
T_19bac:
	cmpi.w	#$c,B_5be9e
	bne.b	.l_19bc2
	bset	#$7,$3(a0)
	bset	#$7,$6(a0)
.l_19bc2:
	tst.w	B_5be9c
	bne.b	.l_19bd0
	bset	#$7,$3(a0)
.l_19bd0:
	move.w	B_5be9c,d0
	addq.w	#$1,d0
	mulu.w	#$6,d0
	cmp.w	B_5be9e,d0
	bmi.b	T_19bea
	bset	#$7,$6(a0)
T_19bea:
	rts
T_19bec:
	tst.w	B_5be9e
	beq.b	.l_19c36
	tst.b	d0
	beq.b	.l_19c36
	movea.l	Itemdata_ptr,a0
	movea.l	Itemslots_ptr,a1
	ext.w	d0
	tst.b	-$1(a1,d0.w)
	beq.b	.l_19c36
	mulu.w	#$28,d0
	lea.l	-$28(a0,d0.w),a0
	cmpi.b	#$11,$1(a0)
	beq.b	.l_19c36
	move.w	$26(a0),d0
	cmp.w	Object_name_nr,d0
	beq.b	.l_19c36
	move.w	d0,Object_name_nr
	move.b	#$2,Print_objname_flag
.l_19c36:
	rts
T_19c38:
	tst.w	B_5be9e
	beq.b	.l_19c5c
	tst.b	d0
	beq.b	.l_19c54
	move.l	#$ffff00,d1
	and.l	d0,d1
	cmpi.l	#$20200,d1
	beq.b	.l_19c5c
.l_19c54:
	move.b	#$2,Erase_objname_flag
.l_19c5c:
	rts
T_19c5e:
	btst	#$1,Mouse_button_state
	bne.b	T_19c5e
	move.w	#$0,Draw_Cicon
	jsr	My_vsync
	movea.l	B_5be94,a2
	movea.l	B_5be98,a3
	moveq	#0,d6
	move.w	B_5be9e,d7
	bra.b	T_19d0a
T_19c8c:
	tst.b	(a2)+
	beq.b	T_19d06
	btst	#$1,$18(a3)
	bne.b	T_19d06
	tst.w	d6
	bne.b	.l_19cd6
	addq.w	#$1,d6
	lea.l	Lay3_PA,a0
	jsr	Push_PA
	lea.l	Lay3_PlusMes,a0
	jsr	Push_MA
	jsr	Init_RText
	lea.l	Code0004Sys,a1
	moveq	#12,d0
	jsr	Add_encoded_2_RText
	lea.l	D_31442,a0
	jsr	Add_ASCII_2_RText
.l_19cd6:
	move.w	$26(a3),d0
	jsr	Find_word
	lea.l	Number_buffer,a1
	moveq	#0,d0
	move.b	(a0)+,d0
	subq.w	#$1,d0
	bra.b	T_19cf0
T_19cee:
	move.b	(a0)+,(a1)+
T_19cf0:
	dbra	d0,T_19cee
	move.b	#$d,(a1)+
	clr.b	(a1)
	lea.l	Number_buffer,a0
	jsr	Add_ASCII_2_RText
T_19d06:
	lea.l	$28(a3),a3
T_19d0a:
	dbra	d7,T_19c8c
	tst.w	d6
	beq.b	.l_19d56
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
	bra.b	.l_19d68
.l_19d56:
	jsr	Exit_display
	jsr	Pop_Module
	jsr	Init_display
.l_19d68:
	rts
T_19d6a:
	move.w	#$0,Draw_Cicon
	jsr	My_vsync
.l_19d78:
	btst	#$1,Mouse_button_state
	bne.b	.l_19d78
	subq.w	#$6,B_5be9c
	bra.w	T_19fee
T_19d8c:
	move.w	#$0,Draw_Cicon
	jsr	My_vsync
.l_19d9a:
	btst	#$1,Mouse_button_state
	bne.b	.l_19d9a
	addq.w	#$6,B_5be9c
	bra.w	T_19fee
T_19dae:
	moveq	#0,d0
	move.w	B_5bea0,d0
	jsr	Divide_gold
	move.w	d0,B_5bea0
	move.w	#$0,Draw_Cicon
	jsr	My_vsync
.l_19dd0:
	btst	#$1,Mouse_button_state
	bne.b	.l_19dd0
	rts
T_19ddc:
	move.w	#$70,Mesmin_X
	move.w	#$3f,Mesmin_Y
	move.w	#$c0,Mesmin_Wd
	move.l	#Code0001Sys,Textfile_ptr
	movea.l	Off_screen,a6
	move.w	#$6,d0
	jsr	Minus_message
	jsr	Switch_screen
	jsr	Copy_screen
.l_19e1a:
	btst	#$1,Mouse_button_state
	bne.b	.l_19e1a
	moveq	#0,d0
	move.w	B_5bea0,d0
	move.l	d0,Original_number
	clr.l	ItemW_nr
	lea.l	D_303ba,a0
	jsr	Push_Module
	rts
T_19e46:
	move.l	ItemW_nr,d0
	beq.b	.l_19e88
	move.w	d0,d1
	mulu.w	#$a,d0
	suba.l	a0,a0
	bsr.w	Scan_4_gold_victims
	bne.b	.l_19e68
	move.w	#$5,d0
	jsr	Plus_message
	bra.b	.l_19e88
.l_19e68:
	bsr.w	Show_transfer_victims
	move.l	#.l_19e94,TIVS_Ptr
	lea.l	TIVS2_Mod,a0
	move.w	#$19,$2c(a0)
	jsr	Push_Module
.l_19e88:
	btst	#$1,Mouse_button_state
	bne.b	.l_19e88
	rts
.l_19e94:
	move.l	ItemW_nr,d0
	add.w	d0,$90(a0)
	sub.w	d0,B_5bea0
	mulu.w	#$a,d0
	add.l	d0,$ec(a0)
	rts
T_19eae:
	moveq	#0,d0
	move.w	B_5bea2,d0
	jsr	T_0cbee
	move.w	d0,B_5bea2
.l_19ec2:
	btst	#$1,Mouse_button_state
	bne.b	.l_19ec2
	rts
T_19ece:
	move.w	#$70,Mesmin_X
	move.w	#$3f,Mesmin_Y
	move.w	#$c0,Mesmin_Wd
	move.l	#Code0001Sys,Textfile_ptr
	movea.l	Off_screen,a6
	move.w	#$7,d0
	jsr	Minus_message
	jsr	Switch_screen
	jsr	Copy_screen
.l_19f0c:
	btst	#$1,Mouse_button_state
	bne.b	.l_19f0c
	moveq	#0,d0
	move.w	B_5bea2,d0
	move.l	d0,Original_number
	clr.l	ItemW_nr
	lea.l	D_3040e,a0
	jsr	Push_Module
	rts
T_19f38:
	move.l	ItemW_nr,d0
	beq.w	.l_19fd2
	mulu.w	#$fa,d0
	lea.l	Chard_ptrs,a1
	lea.l	Char_status_icons,a4
	moveq	#0,d6
	moveq	#1,d7
.l_19f56:
	tst.l	(a1)
	beq.b	.l_19f84
	movea.l	(a1),a2
	move.w	Attr_1_normal(a2),d1
	add.w	Attr_1_normal_magic(a2),d1
	mulu.w	#$3e8,d1
	sub.l	Weight_normal(a2),d1
	cmp.l	d0,d1
	bmi.b	.l_19f84
	move.w	Food_rations(a2),d1
	add.w	d0,d1
	bvs.b	.l_19f84
	move.w	#$e402,d1
	and.w	Body_conditions(a2),d1
	bne.b	.l_19f84
	bset	d7,d6
.l_19f84:
	addq.l	#$4,a1
	addq.w	#$1,d7
	cmpi.w	#$7,d7
	bmi.b	.l_19f56
	bmi.b	.l_19f56
	move.w	d5,Transferring
	move.w	d6,Transfer_victims
	tst.w	d6
	bne.b	.l_19fb2
	move.w	#$5,d0
	jsr	Plus_message
	jsr	Pop_Module
	bra.b	.l_19fd2
.l_19fb2:
	bsr.w	Show_transfer_victims
	move.l	#.l_19fd4,TIVS_Ptr
	lea.l	TIVS2_Mod,a0
	move.w	#$1a,$2c(a0)
	jsr	Push_Module
.l_19fd2:
	rts
.l_19fd4:
	move.l	ItemW_nr,d0
	add.w	d0,$92(a0)
	sub.w	d0,B_5bea2
	mulu.w	#$fa,d0
	add.l	d0,$ec(a0)
	rts
T_19fee:
	movea.l	B_5be94,a0
	move.w	B_5be9c,d0
	adda.w	d0,a0
	move.l	a0,Itemslots_ptr
	movea.l	B_5be98,a0
	mulu.w	#$28,d0
	adda.w	d0,a0
	move.l	a0,Itemdata_ptr
	movea.l	Off_screen,a6
	jsr	Show_objects_LAY3
	jsr	Switch_screen
	jsr	Copy_screen
	rts
T_1a02e:
	movem.l	d0-d7/a0-a6,-(a7)
	move.w	d0,B_5beaa
	lea.l	D_2ff4c,a0
	jsr	Push_Module
.l_1a044:
	jsr	Input_handler
	jsr	Switch_screen
	tst.b	Abort_list
	beq.b	.l_1a044
	movem.l	(a7)+,d0-d7/a0-a6
	rts
T_1a05e:
	move.w	#$30,d0
	move.w	#$3c,d1
	moveq	#12,d2
	moveq	#5,d3
	moveq	#1,d6
	lea.l	D_32c60,a0
	jsr	Open_window
	move.w	d0,B_5bea8
	lea.l	D_3174c,a0
	jsr	Push_PA
	movea.l	Off_screen,a6
	jsr	Init_RText
	lea.l	Code0008Sys,a1
	move.w	#$a,d0
	jsr	Add_encoded_2_RText
	lea.l	D_31472,a0
	move.w	B_5beaa,d0
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
	lea.l	D_3e9ea,a0
	jsr	Blot_unmasked_block
	jsr	Switch_screen
	jsr	Copy_screen
	rts
T_1a0fa:
	move.w	B_5bea8,d0
	jsr	Close_window
	jsr	Pop_PA
	rts
T_1a10e:
	movem.l	d0-d7/a0-a6,-(a7)
	sf.b	B_5beac
	move.l	#Code0008Sys,Textfile_ptr
	move.w	#$d,ReqText_nr
	move.l	#.l_1a168,ReqDo_ptr
	lea.l	Req_Mod,a0
	jsr	Push_Module
.l_1a140:
	jsr	Input_handler
	jsr	Switch_screen
	tst.b	Abort_list
	beq.b	.l_1a140
	tst.b	B_5beac
	bne.b	.l_1a162
	jmp	Exit_program
.l_1a162:
	movem.l	(a7)+,d0-d7/a0-a6
	rts
.l_1a168:
	st.b	B_5beac
	rts
T_1a170:
	movem.l	d0-d7/a0-a6,-(a7)
	lea.l	D_2ff9a,a0
	jsr	Push_Module
.l_1a180:
	jsr	Input_handler
	jsr	Switch_screen
	tst.b	Abort_list
	beq.b	.l_1a180
	movem.l	(a7)+,d0-d7/a0-a6
	rts
T_1a19a:
	move.w	#$30,d0
	move.w	#$3c,d1
	moveq	#12,d2
	moveq	#5,d3
	moveq	#1,d6
	lea.l	D_32c60,a0
	jsr	Open_window
	move.w	d0,B_5bea8
	lea.l	D_3174c,a0
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
	lea.l	D_3e9ea,a0
	jsr	Blot_unmasked_block
	jsr	Switch_screen
	jsr	Copy_screen
	rts
T_1a214:
	jsr	Exit_display
	cmpi.b	#$2,Current_map_type
	bmi.b	.l_1a236
	jsr	T_0025a
	jsr	Save_automap
	jsr	T_00208
.l_1a236:
	jsr	ON_Diag_screen
	jsr	DI_Cursor_home
	movea.l	Screen_base,a6
	lea.l	D_320ac,a0
	jsr	DI_Print
	lea.l	D_320cf,a0
	jsr	DI_Print
	lea.l	D_320f4,a0
	jsr	DI_Print
	jsr	DI_Carriage_return
	lea.l	Chard_ptrs,a1
	lea.l	B_5beae,a2
	lea.l	Screen,a3
	moveq	#5,d7
T_1a286:
	tst.l	(a1)
	beq.b	T_1a29e
	movea.l	(a1),a0
	bsr.w	T_1a470
	move.l	a3,(a2)+
	move.l	d0,(a2)+
	lsr.w	#$1,d0
	bra.b	T_1a29a
T_1a298:
	move.w	(a0)+,(a3)+
T_1a29a:
	dbra	d0,T_1a298
T_1a29e:
	addq.l	#$4,a1
	dbra	d7,T_1a286
	move.l	a3,B_5bede
	movea.l	Modifications_ptr,a0
	move.w	Nr_of_modifications,d7
	bra.b	T_1a2bc
T_1a2b8:
	move.l	(a0)+,(a3)+
	move.w	(a0)+,(a3)+
T_1a2bc:
	dbra	d7,T_1a2b8
	lea.l	Char_damage,a0
	moveq	#14,d7
.l_1a2c8:
	clr.w	(a0)+
	dbra	d7,.l_1a2c8
	lea.l	XActive_member,a0
	move.w	#$2a,d7
.l_1a2d8:
	clr.w	(a0)+
	dbra	d7,.l_1a2d8
	sf.b	First
	sf.b	Which_CIL
	sf.b	Battling
	sf.b	Party_invisible
	sf.b	Stygian
	move.l	#PA_Stack,PA_sp
	move.l	#MA_Stack,MA_sp
	move.l	#B_600f6,Object_sp
	move.l	#D_54cb6,Mptr_sp
	move.l	#B_5b52a,Module_sp
	lea.l	Window_list,a0
	clr.l	(a0)+
	clr.l	(a0)+
	lea.l	B_5fee2,a7
	clr.l	D_2a3dc
	clr.l	D_2c004
	clr.l	D_2ef58
	clr.l	D_2b164
	clr.l	D_2b0f6
	moveq	#0,d0
	jsr	Play_song
	lea.l	Main_root,a0
	jsr	Push_Root
	jsr	T_1d27a
	lea.l	D_31738,a0
	jsr	Push_PA
	move.l	#$200,d0
	mulu.w	#$6,d0
	addq.l	#$2,d0
	jsr	Allocate_memory
	move.l	a1,Modifications_ptr
	movea.l	B_5bede,a0
	move.w	Nr_of_modifications,d7
	bra.b	T_1a3ac
T_1a3a8:
	move.l	(a0)+,(a1)+
	move.w	(a0)+,(a1)+
T_1a3ac:
	dbra	d7,T_1a3a8
	clr.w	(a1)
	lea.l	Chard_ptrs,a0
	lea.l	B_5beae,a2
	moveq	#5,d7
T_1a3c0:
	tst.l	(a0)
	beq.b	T_1a3de
	move.l	$4(a2),d0
	jsr	Allocate_memory
	move.l	a1,(a0)
	movea.l	(a2),a3
	lsr.w	#$1,d0
	bra.b	T_1a3d8
T_1a3d6:
	move.w	(a3)+,(a1)+
T_1a3d8:
	dbra	d0,T_1a3d6
	addq.l	#$8,a2
T_1a3de:
	addq.l	#$4,a0
	dbra	d7,T_1a3c0
	lea.l	Chard_ptrs,a0
	move.w	Active_member,d0
	add.w	d0,d0
	add.w	d0,d0
	move.l	-$4(a0,d0.w),Current_active_char_data
	move.w	Travel_mode,d0
	jsr	Set_new_travel_mode
	lea.l	D_32119,a0
	jsr	DI_Print
	jsr	Wait_4_key
	jsr	OFF_Diag_screen
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
T_1a470:
	movem.l	a1-a2,-(a7)
	lea.l	Memory_list,a1
	movea.l	Memlist_end,a2
	bra.b	T_1a498
T_1a482:
	btst	#$7,$8(a1)
	bne.b	.l_1a494
	cmpa.l	(a1),a0
	bne.b	.l_1a494
	move.l	$4(a1),d0
	bra.b	T_1a49e
.l_1a494:
	lea.l	$c(a1),a1
T_1a498:
	cmpa.l	a2,a1
	bmi.b	T_1a482
	moveq	#0,d0
T_1a49e:
	movem.l	(a7)+,a1-a2
	rts
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

; ---- Push_Root (original source: LAYOUT/OBJFIND.ASM) - the shipped program differs, its code follows, not assembled:
;Push_Root:
;             move.l    a1,-(sp)
;             movea.l   Object_sp,a1
;             addq.l    #4,a1                ; Increase object sp
;             cmpa.l    #End_of_object_stack,a1
;             bmi.s     .Not_full
;             ERROR     "[ Push_Root ] : Object stack overflow !!!"
;             bra.s     .Exit
;.Not_full:   move.l    a0,(a1)              ; Push root
;             move.l    a1,Object_sp
;.Exit:       movea.l   (sp)+,a1
;             rts

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

; ---- Pop_Root (original source: LAYOUT/OBJFIND.ASM) - the shipped program differs, its code follows, not assembled:
;Pop_Root:
;             move.l    a1,-(sp)
;             movea.l   Object_sp,a1
;             cmpa.l    #Object_stack,a1
;             bpl.s     .Not_empty
;             ERROR     "[ Pop_Root ] : Object stack underflow !!!"
;             bra.s     .Exit
;.Not_empty:  subq.l    #4,a1                ; Decrease sp
;             move.l    a1,Object_sp
;.Exit:       movea.l   (sp)+,a1
;             rts

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

; ---- Open_window (original source: LAYOUT/WINDOWS.ASM) - the shipped program differs, its code follows, not assembled:
;Open_window:
;             movem.l   d1-d7/a0-a2/a6,-(sp)
;             jsr       Mouse_off
;; ------------- Allocate memory for window data & drawing buffer -----
;             move.w    d2,d4                ; Calculate size of window
;             mulu.w    d3,d4                ; data
;             lsl.l     #7,d4
;             addi.l    #Wind_back,d4
;             move.w    d0,-(sp)             ; Make buffer
;             move.l    d4,d0
;             jsr       Allocate_memory
;             lea.l     (a1),a2
;             move.w    (sp)+,d0
;; ------------- Enter window data ------------------------------------
;             move.w    d0,Wind_X(a2)        ; Enter size & position
;             move.w    d1,Wind_Y(a2)
;             move.w    d2,Wind_width(a2)
;             move.w    d3,Wind_height(a2)
;             move.l    a0,Wind_branch(a2)
;             moveq.l   #16,d4               ; Calculate window area
;             add.w     d0,d4
;             move.w    d4,Wind_area(a2)     ; Minimum X
;             moveq.l   #-2,d5
;             add.w     d2,d5
;             lsl.w     #4,d5
;             add.w     d5,d4
;             subq.w    #1,d4
;             move.w    d4,Wind_area+2(a2)   ; Maximum X
;             moveq.l   #16,d4
;             add.w     d1,d4
;             move.w    d4,Wind_area+4(a2)   ; Minimum Y
;             moveq.l   #-2,d5
;             add.w     d3,d5
;             lsl.w     #4,d5
;             add.w     d5,d4
;             subq.w    #1,d4
;             move.w    d4,Wind_area+6(a2)   ; Maximum Y
;             tst.w     d6                   ; Get window icon base
;             bne.s     .Light
;             moveq.l   #3,d6                ; Dark window
;             lea.l     Wind1_icons,a1
;             bra.s     .Continue
;.Light:      moveq.l   #2,d6                ; Light window
;             lea.l     Wind2_icons,a1
;.Continue:
;; ------------- REGISTER CONTENTS ------------------------------------
;;   d0 - Leftmost X-coordinate of window (.w)
;;   d1 -  Topmost Y-coordinate of window (.w)
;;   d2 -  Width of window (.w)
;;   d3 - Height of window (.w)
;;   d6 - Window colour (.w)
;;   a1 - Pointer to window icons (.l)
;;   a2 - Pointer to window data (.l)
;
;; ------------- Save background --------------------------------------
;             move.w    d6,-(sp)
;             move.w    d2,d6
;             move.w    d3,d7
;             lsl.w     #4,d7
;             subq.w    #8,d7
;             lea.l     Wind_back(a2),a0
;             movea.l   Screen_base,a6
;             jsr       Get2_block
;             move.w    (sp)+,d6
;             jsr       Copy_screen
;; ------------- Draw border of window --------------------------------
;             lea.l     (a1),a0
;             movea.l   Off_screen,a6
;             subq.w    #4,d2                ; Adjust counters
;             subq.w    #4,d3
;             move.w    d0,d4                ; Save coordinates
;             move.w    d1,d5
;             jsr       Put_masked_block     ; Draw first column
;             addi.w    #16,d1
;             lea.l     128(a0),a0
;             jsr       Put_masked_block
;             addi.w    #16,d1
;             lea.l     128(a0),a0
;             jsr       Draw_vertical_border
;             jsr       Put_masked_block
;             addi.w    #16,d1
;             lea.l     128(a0),a0
;             jsr       Put_masked_block
;             addi.w    #16,d0               ; Draw second column
;             exg.l     d1,d5
;             lea.l     128(a0),a0
;             jsr       Put_masked_block
;             exg.l     d1,d5
;             lea.l     128(a0),a0
;             jsr       Put_masked_block
;             addi.w    #16,d0               ; Draw middle columns
;             exg.l     d1,d5
;             lea.l     128(a0),a0
;             jsr       Draw_horizontal_border
;             move.w    d4,d0
;             addi.w    #32,d0
;             exg.l     d1,d5
;             jsr       Draw_horizontal_border
;             exg.l     d1,d5                ; Draw penultimate column
;             jsr       Put_masked_block
;             exg.l     d1,d5
;             lea.l     128(a0),a0
;             jsr       Put_masked_block
;             addi.w    #16,d0               ; Draw last column
;             exg.l     d1,d5
;             lea.l     128(a0),a0
;             jsr       Put_masked_block
;             addi.w    #16,d1
;             lea.l     128(a0),a0
;             jsr       Put_masked_block
;             addi.w    #16,d1
;             lea.l     128(a0),a0
;             jsr       Draw_vertical_border
;             jsr       Put_masked_block
;             addi.w    #16,d1
;             lea.l     128(a0),a0
;             jsr       Put_masked_block
;; ------------- Fill window ------------------------------------------
;             move.w    Wind_X(a2),d0        ; Get first coordinate pair
;             move.w    Wind_Y(a2),d1
;             addi.w    #16,d0
;             addi.w    #16,d1
;             addq.w    #2,d2                ; Calculate second coordinate
;             addq.w    #2,d3                ; pair
;             lsl.w     #4,d2
;             lsl.w     #4,d3
;             add.w     d0,d2
;             add.w     d1,d3
;             subq.w    #1,d2
;             subq.w    #1,d3
;             jsr       Draw_box
;             jsr       Switch_screen        ; Display window
;             jsr       Copy_screen
;; ------------- Various installations --------------------------------
;             lea.l     Wind_area(a2),a0     ; No macro !!
;             jsr       Push_MA
;             move.l    Wind_branch(a2),d0   ; Translate & install branch
;             beq.s     .Zero
;             movea.l   d0,a0
;             moveq.l   #16,d0
;             moveq.l   #16,d1
;             add.w     Wind_X(a2),d0
;             add.w     Wind_Y(a2),d1
;             jsr       Translate_object_branch
;             jsr       Push_Root
;; ------------- Insert window in list --------------------------------
;.Zero:       lea.l     Window_list,a0       ; Find window handle
;             moveq.l   #Max_windows-1,d7
;.Loop:       tst.l     (a0)+                ; Free slot ?
;             dbeq      d7,.Loop
;             tst.w     d7                   ; Found one ?
;             bpl.s     .No_error
;             ERROR     "[ Open_window ] : No more windows can be opened !!!"
;             bra.s     .Exit
;.No_error:   move.l    a2,-(a0)             ; Insert pointer in slot
;             suba.l    #Window_list,a0
;             move.l    a0,d0
;             lsr.w     #2,d0
;; ------------- Exit -------------------------------------------------
;.Exit:       jsr       Mouse_on
;             movem.l   (sp)+,d1-d7/a0-a2/a6
;             rts

Open_window:
	movem.l	d1-d7/a0-a2/a6,-(a7)
	jsr	Mouse_off
	move.w	d2,d4
	mulu.w	d3,d4
	lsl.l	#$7,d4
	addi.l	#$14,d4
	move.w	d0,-(a7)
	move.l	d4,d0
	jsr	Allocate_memory
	lea.l	(a1),a2
	move.w	(a7)+,d0
	move.w	d0,$0(a2)
	move.w	d1,$2(a2)
	move.w	d2,$4(a2)
	move.w	d3,$6(a2)
	move.l	a0,$10(a2)
	moveq	#16,d4
	add.w	d0,d4
	move.w	d4,$8(a2)
	moveq	#-2,d5
	add.w	d2,d5
	lsl.w	#$4,d5
	add.w	d5,d4
	subq.w	#$1,d4
	move.w	d4,$a(a2)
	moveq	#16,d4
	add.w	d1,d4
	move.w	d4,$c(a2)
	moveq	#-2,d5
	add.w	d3,d5
	lsl.w	#$4,d5
	add.w	d5,d4
	subq.w	#$1,d4
	move.w	d4,$e(a2)
	tst.w	d6
	bne.b	.l_1a634
	moveq	#3,d6
	lea.l	D_33432,a1
	bra.b	.l_1a63c
.l_1a634:
	moveq	#2,d6
	lea.l	D_33c32,a1
.l_1a63c:
	move.w	d6,-(a7)
	move.w	d2,d6
	move.w	d3,d7
	lsl.w	#$4,d7
	subq.w	#$8,d7
	lea.l	$14(a2),a0
	movea.l	Screen_base,a6
	jsr	Get2_block
	move.w	(a7)+,d6
	tst.l	(a1)
	jsr	Copy_screen
	tst.l	(a1)
	movea.l	a1,a0
	movea.l	Off_screen,a6
	subq.w	#$4,d2
	subq.w	#$4,d3
	move.w	d0,d4
	move.w	d1,d5
	jsr	Put_masked_block
	addi.w	#$10,d1
	lea.l	$80(a0),a0
	jsr	Put_masked_block
	addi.w	#$10,d1
	lea.l	$80(a0),a0
	bsr.w	Draw_vertical_border
	jsr	Put_masked_block
	addi.w	#$10,d1
	lea.l	$80(a0),a0
	jsr	Put_masked_block
	addi.w	#$10,d0
	exg.l	d5,d1
	lea.l	$80(a0),a0
	jsr	Put_masked_block
	exg.l	d5,d1
	lea.l	$80(a0),a0
	jsr	Put_masked_block
	addi.w	#$10,d0
	exg.l	d5,d1
	lea.l	$80(a0),a0
	bsr.w	Draw_horizontal_border
	move.w	d4,d0
	addi.w	#$20,d0
	exg.l	d5,d1
	bsr.w	Draw_horizontal_border
	exg.l	d5,d1
	jsr	Put_masked_block
	exg.l	d5,d1
	lea.l	$80(a0),a0
	jsr	Put_masked_block
	addi.w	#$10,d0
	exg.l	d5,d1
	lea.l	$80(a0),a0
	jsr	Put_masked_block
	addi.w	#$10,d1
	lea.l	$80(a0),a0
	jsr	Put_masked_block
	addi.w	#$10,d1
	lea.l	$80(a0),a0
	bsr.w	Draw_vertical_border
	jsr	Put_masked_block
	addi.w	#$10,d1
	lea.l	$80(a0),a0
	jsr	Put_masked_block
	move.w	$0(a2),d0
	move.w	$2(a2),d1
	addi.w	#$10,d0
	addi.w	#$10,d1
	addq.w	#$2,d2
	addq.w	#$2,d3
	lsl.w	#$4,d2
	lsl.w	#$4,d3
	add.w	d0,d2
	add.w	d1,d3
	subq.w	#$1,d2
	subq.w	#$1,d3
	jsr	Draw_box
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	$8(a2),a0
	jsr	Push_MA
	move.l	$10(a2),d0
	beq.b	.l_1a78a
	movea.l	d0,a0
	moveq	#16,d0
	moveq	#16,d1
	add.w	$0(a2),d0
	add.w	$2(a2),d1
	jsr	Translate_object_branch
	jsr	Push_Root
.l_1a78a:
	lea.l	Window_list,a0
	moveq	#1,d7
.l_1a792:
	tst.l	(a0)+
	dbeq	d7,.l_1a792
	tst.w	d7
	bpl.b	.l_1a7aa
	lea.l	D_34432,a1
	jsr	DI_Error
	bra.b	.l_1a7b6
.l_1a7aa:
	move.l	a2,-(a0)
	suba.l	#Window_list,a0
	move.l	a0,d0
	lsr.w	#$2,d0
.l_1a7b6:
	jsr	Mouse_on
	movem.l	(a7)+,d1-d7/a0-a2/a6
	rts
; ---- Draw_horizontal_border (original source: LAYOUT/WINDOWS.ASM)
Draw_horizontal_border:
	move.l	d2,-(sp)
	bra.s	.Entry
.Loop:
	jsr	Put_masked_block
	addi.w	#16,d0
.Entry:
	dbra	d2,.Loop
	lea.l	128(a0),a0
	move.l	(sp)+,d2
	rts	
; ---- Draw_vertical_border (original source: LAYOUT/WINDOWS.ASM)
Draw_vertical_border:
	move.l	d3,-(sp)
	bra.s	.Entry
.Loop:
	jsr	Put_masked_block
	addi.w	#16,d1
.Entry:
	dbra	d3,.Loop
	lea.l	128(a0),a0
	move.l	(sp)+,d3
	rts	

; ---- Close_window (original source: LAYOUT/WINDOWS.ASM) - the shipped program differs, its code follows, not assembled:
;Close_window:
;             movem.l   d0/d1/d6/d7/a0/a1/a6,-(sp)
;             jsr       Mouse_off
;             lea.l     Window_list,a0       ; Get pointer to window data
;             lsl.w     #2,d0
;             adda.w    d0,a0
;             tst.l     (a0)
;             bne.s     .Ok
;             ERROR     "[ Close_window ] :  Illegal window handle !!!"
;             bra       .Exit
;.Ok:         movea.l   (a0),a1              ; Get pointer
;             clr.l     (a0)                 ; Clear slot
;; ------------- Restore background -----------------------------------
;             move.w    Wind_X(a1),d0
;             move.w    Wind_Y(a1),d1
;             move.w    Wind_width(a1),d6
;             move.w    Wind_height(a1),d7
;             lsl.w     #4,d7
;             subq.w    #8,d7
;             lea.l     Wind_back(a1),a0
;             movea.l   Off_screen,a6
;             jsr       Blot_unmasked_block
;             jsr       Switch_screen
;             jsr       Copy_screen
;; ------------- Various de-installations -----------------------------
;             Pop       MA
;             move.l    Wind_branch(a1),d0   ; Remove & de-translate branch
;             beq.s     .Zero
;             Pop       Root
;             movea.l   d0,a0
;             moveq.l   #16,d0
;             moveq.l   #16,d1
;             add.w     Wind_X(a1),d0
;             add.w     Wind_Y(a1),d1
;             neg.w     d0
;             neg.w     d1
;             jsr       Translate_object_branch
;.Zero:       lea.l     (a1),a0              ; Free memory block
;             jsr       Free_memory
;.Exit:       jsr       Mouse_on
;             movem.l   (sp)+,d0/d1/d6/d7/a0/a1/a6
;             rts

Close_window:
	movem.l	d0-d1/d6-d7/a0-a1/a6,-(a7)
	jsr	Mouse_off
	lea.l	Window_list,a0
	lsl.w	#$2,d0
	adda.w	d0,a0
	tst.l	(a0)
	bne.b	.l_1a81c
	lea.l	D_34467,a1
	jsr	DI_Error
	bra.b	.l_1a882
.l_1a81c:
	movea.l	(a0),a1
	clr.l	(a0)
	move.w	$0(a1),d0
	move.w	$2(a1),d1
	move.w	$4(a1),d6
	move.w	$6(a1),d7
	lsl.w	#$4,d7
	subq.w	#$8,d7
	lea.l	$14(a1),a0
	movea.l	Off_screen,a6
	jsr	Blot_unmasked_block
	jsr	Switch_screen
	jsr	Copy_screen
	jsr	Pop_MA
	move.l	$10(a1),d0
	beq.b	.l_1a87a
	jsr	Pop_Root
	movea.l	d0,a0
	moveq	#16,d0
	moveq	#16,d1
	add.w	$0(a1),d0
	add.w	$2(a1),d1
	neg.w	d0
	neg.w	d1
	jsr	Translate_object_branch
.l_1a87a:
	lea.l	(a1),a0
	jsr	Free_memory
.l_1a882:
	jsr	Mouse_on
	movem.l	(a7)+,d0-d1/d6-d7/a0-a1/a6
	rts
; Jump table of the COSO music player by Jochen Hippel: +0 start song d0 of the module a0 (0 stops), +4 sound effect d0 (not used), +8 play (timer interrupt), +12 set the volume reduction, +16 mute.
Coso_player:
	bra.w	Coso_start_song
	bra.w	Coso_sound_effect
; Called by the timer interrupt (My_timer_D, 50 times per second).
Coso_interrupt:
	bra.w	Coso_play
	bra.w	.l_1a8ae
	bra.w	.l_1a8a2
.l_1a8a2:
	pea.l	(a0)
	lea.l	Coso_mute(pc),a0
	move.b	d0,(a0)
	movea.l	(a7)+,a0
	rts
.l_1a8ae:
	pea.l	(a0)
	lea.l	Coso_volume_reduction(pc),a0
	move.w	d0,(a0)+
	movea.l	(a7)+,a0
	rts
; Starts the song d0 of the module a0 (0 stops the music), all registers are restored.
Coso_start_song:
	movem.l	d0-d7/a0-a5,-(a7)
	move.w	d1,d2
	bsr.b	Coso_init_song
	movem.l	(a7)+,d0-d7/a0-a5
	rts
; Starts the sound effect d0 (4 bytes per effect), all registers are restored. Amberstar does not call it.
Coso_sound_effect:
	movem.l	d0-d7/a0-a5,-(a7)
	lea.l	T_1b63a(pc),a0
	bsr.b	Coso_init_module
	movea.l	T_1b526(pc),a1
	add.w	d0,d0
	add.w	d0,d0
	adda.w	d0,a1
	lea.l	T_1b52c(pc),a5
	move.w	(a1)+,(a5)
	moveq	#0,d0
	move.w	(a1)+,d0
	bsr.w	Coso_start_effect
	movem.l	(a7)+,d0-d7/a0-a5
	rts
; Song d0 (6 bytes per song: first and last position, speed) or stop.
Coso_init_song:
	bsr.b	Coso_init_module
	tst.w	d0
	beq.b	.l_1a910
	subq.w	#$1,d0
	movea.l	T_1b522(pc),a1
	mulu.w	#$6,d0
	adda.w	d0,a1
	move.w	(a1)+,d0
	move.w	(a1)+,d1
	lea.l	T_1b438(pc),a5
	move.w	(a1),(a5)
	bra.w	Coso_init_positions
.l_1a910:
	andi.b	#$f0,$fffffa1d.w
	lea.l	T_1b43a(pc),a0
	st.b	(a0)
	bra.w	Coso_play
; Pointers to the parts of the module a0 (offsets at 4-$1c). "MMME" at $20 marks the newer format.
Coso_init_module:
	lea.l	T_1b537(pc),a1
	sf.b	(a1)
	cmpi.l	#$4d4d4d45,$20(a0)
	bne.b	.l_1a934
	move.b	#$1,(a1)
.l_1a934:
	lea.l	Coso_module(pc),a5
	move.l	a0,(a5)
	movea.l	$4(a0),a1
	adda.l	a0,a1
	lea.l	T_1b514(pc),a5
	move.l	a1,(a5)
	movea.l	$8(a0),a1
	adda.l	a0,a1
	lea.l	T_1b518(pc),a5
	move.l	a1,(a5)
	movea.l	$c(a0),a1
	adda.l	a0,a1
	lea.l	T_1b510(pc),a5
	move.l	a1,(a5)
	movea.l	$10(a0),a1
	adda.l	a0,a1
	lea.l	T_1b51c(pc),a5
	move.l	a1,(a5)
	movea.l	$14(a0),a1
	adda.l	a0,a1
	lea.l	T_1b522(pc),a5
	move.l	a1,(a5)+
	movea.l	$18(a0),a1
	adda.l	a0,a1
	move.l	a1,(a5)+
	movea.l	$1c(a0),a1
	adda.l	a0,a1
	lea.l	T_1b532(pc),a5
	move.l	a1,(a5)+
	lea.l	T_1b42a(pc),a5
	st.b	(a5)
	lea.l	T_1b52a(pc),a5
	move.w	#$2,(a5)
	rts
T_1a99a:
	rts
; Converts the samples of a "MARCHI" module once (d0 = mode) and sets the sample interrupt.
Coso_init_samples:
	lea.l	Coso_sample_mode(pc),a0
	move.b	d0,(a0)
	movea.l	T_1b532(pc),a0
	cmpi.l	#$4d415243,$f8(a0)
	bne.b	T_1a99a
	cmpi.l	#$48492020,$f4(a0)
	beq.b	T_1a99a
	move.l	#$48492020,$f4(a0)
	tst.b	d0
	beq.b	.l_1aa0c
	lea.l	Coso_saved_MFP(pc),a1
	tst.l	(a1)
	bne.b	.l_1aa0c
	move.w	sr,-(a7)
	move.w	#$2700,sr
	move.l	$110.w,(a1)+
	move.b	$fffffa09.w,(a1)+
	move.b	$fffffa0d.w,(a1)+
	move.b	$fffffa15.w,(a1)+
	move.b	$fffffa17.w,(a1)+
	move.b	$fffffa1d.w,(a1)+
	andi.b	#$f0,$fffffa1d.w
	bset	#$4,$fffffa09.w
	bset	#$4,$fffffa0d.w
	bset	#$4,$fffffa15.w
	bclr	#$3,$fffffa17.w
	move.w	(a7)+,sr
.l_1aa0c:
	lea.l	$100(a0),a1
	movea.l	$fc(a0),a2
	adda.l	a0,a2
	tst.b	d0
	bne.b	.l_1aa32
	moveq	#0,d7
	move.w	#$30,d7
.l_1aa20:
	cmpa.l	a1,a2
	beq.b	T_1aa6e
	move.b	(a1),d2
	ext.w	d2
	muls.w	d7,d2
	divs.w	#$3f,d2
	move.b	d2,(a1)+
	bra.b	.l_1aa20
.l_1aa32:
	cmp.b	#$1,d0
	beq.b	T_1aa70
.l_1aa38:
	eori.b	#$80,(a1)+
	cmpa.l	a2,a1
	blt.b	.l_1aa38
	movea.w	#$8800,a0
	move.b	#$7,(a0)
	move.b	(a0),d0
	ori.b	#$c0,d0
	move.b	d0,$2(a0)
	move.b	#$e,(a0)
	move.b	(a0),d0
	ori.b	#$20,d0
	move.b	d0,$2(a0)
	lea.l	Coso_sample_interrupt(pc),a0
T_1aa64:
	move.l	a0,$110.w
	move.b	#$66,$fffffa25.w
T_1aa6e:
	rts
T_1aa70:
	move.b	(a1),d0
	eori.b	#$80,d0
	lsr.w	#$4,d0
	andi.w	#$f,d0
	move.b	.l_1aa8a(pc,d0.w),(a1)+
	cmpa.l	a2,a1
	blt.b	T_1aa70
	lea.l	Coso_sample_interrupt(pc),a0
	bra.b	T_1aa64
.l_1aa8a:
	dc.b	$00,$07,$09,$0a,$0b,$0c,$0c,$0d,$0d,$0d,$0e,$0e,$0e,$0f,$0f,$0f
; The vector $110 and the MFP registers before the samples were set up.
Coso_saved_MFP:
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
; move.b (a6)+,$ffff8832.w / rte (written as data).
Coso_sample_interrupt:
	dc.b	$11,$de,$88,$32,$4e,$73
; One step of the music: the 3 channels and the sound effect, then the YM2149 registers are written.
Coso_play:
	lea.l	Coso_YM_registers(pc),a5
	lea.l	Coso_speed_counter(pc),a4
	tst.b	$4(a4)
	beq.b	.l_1aafa
	tst.b	$5(a4)
	bne.b	.l_1aaf8
	st.b	$5(a4)
	moveq	#0,d0
	move.b	d0,$12(a5)
	move.b	d0,$16(a5)
	move.b	d0,$22(a5)
	move.b	d0,$26(a5)
	move.b	d0,$2a(a5)
	move.b	Coso_mute(pc),d4
	bne.b	.l_1aaf8
	move.w	sr,-(a7)
	move.w	#$2700,sr
	movem.l	$10(a5),d0-d6
	movem.l	d0-d6,$ffff8830.w
	bsr.w	Coso_select_register
	move.w	(a7)+,sr
.l_1aaf8:
	rts
.l_1aafa:
	lea.l	T_1b42e(pc),a4
	lea.l	Coso_channel_A(pc),a0
	bsr.w	Coso_channel_frame
	move.w	d0,-(a7)
	move.b	(a7)+,$6(a5)
	move.b	d0,$2(a5)
	move.b	d1,$22(a5)
	lea.l	Coso_channel_B(pc),a0
	bsr.w	Coso_channel_frame
	move.w	d0,-(a7)
	move.b	(a7)+,$e(a5)
	move.b	d0,$a(a5)
	move.b	d1,$26(a5)
	lea.l	Coso_channel_C(pc),a0
	bsr.w	Coso_channel_frame
	move.w	d0,-(a7)
	move.b	(a7)+,$16(a5)
	move.b	d0,$12(a5)
	move.b	d1,$2a(a5)
	move.w	$4(a4),d0
	beq.b	.l_1ab84
	move.w	d0,-(a7)
	lea.l	Coso_effect_channel(pc),a0
	bsr.w	Coso_channel_frame
	movea.l	$4(a0),a1
	adda.w	$16(a0),a1
	cmpi.b	#$e1,(a1)
	bne.b	.l_1ab62
	clr.w	$4(a4)
.l_1ab62:
	move.w	(a7)+,d7
	lea.l	Coso_effect_registers(pc),a1
	add.w	d7,d7
	add.w	d7,d7
	adda.w	d7,a1
	moveq	#0,d6
	move.b	(a1)+,d6
	move.w	d0,-(a7)
	move.b	d0,(a5,d6.w)
	move.b	(a1)+,d6
	move.b	(a7)+,(a5,d6.w)
	move.b	(a1)+,d6
	move.b	d1,(a5,d6.w)
.l_1ab84:
	move.w	sr,-(a7)
	move.w	#$2700,sr
	move.b	#$7,$ffff8830.w
	move.b	$ffff8830.w,d6
	andi.w	#$c0,d6
	bsr.w	Coso_select_register
	move.w	(a7)+,sr
	move.b	(a4)+,d7
	or.b	d6,d7
	move.b	d7,$1e(a5)
	move.b	(a4)+,$1a(a5)
	move.b	Coso_mute(pc),d0
	bne.b	.l_1ac10
	move.b	Coso_sample_mode(pc),d0
	bne.b	.l_1abc2
	btst	#$0,$ffff8901.w
	bne.b	.l_1abcc
	bra.w	.l_1ac06
.l_1abc2:
	move.b	$fffffa1d.w,d0
	andi.w	#$f,d0
	beq.b	.l_1ac06
.l_1abcc:
	movem.l	(a5)+,d0-d7/a0-a1
	clr.w	d4
	clr.w	d5
	bclr	#$a,d7
	bset	#$d,d7
	move.w	sr,-(a7)
	move.w	#$2700,sr
	movem.l	d0-d7/a0-a1,$ffff8840.w
	moveq	#10,d0
	move.b	Coso_sample_mode(pc),d1
	cmp.b	#$2,d1
	bne.b	.l_1abfe
	clr.w	$2(a5)
	move.l	(a5)+,$ffff8840.w
	addq.w	#$5,d0
.l_1abfe:
	move.b	d0,$ffff8840.w
	move.w	(a7)+,sr
	bra.b	.l_1ac10
.l_1ac06:
	movem.l	(a5),d0-d7/a0-a2
	movem.l	d0-d7/a0-a2,$ffff8840.w
.l_1ac10:
	lea.l	Coso_speed_counter(pc),a5
	subq.w	#$1,(a5)+
	bne.b	T_1ac38
	move.w	(a5),-(a5)
	moveq	#0,d5
	moveq	#0,d4
	lea.l	Coso_channel_A(pc),a0
	bsr.w	Coso_channel_sequence
	st.b	d4
	lea.l	Coso_channel_B(pc),a0
	bsr.w	Coso_channel_sequence
	lea.l	Coso_channel_C(pc),a0
	bsr.w	Coso_channel_sequence
T_1ac38:
	rts
; Next note of a channel when its duration is over.
Coso_channel_sequence:
	subq.b	#$1,$1a(a0)
	bpl.b	T_1ac38
	move.b	$1b(a0),$1a(a0)
.l_1ac46:
	movea.l	$c(a0),a1
.l_1ac4a:
	move.b	(a1)+,d0
	cmp.b	#$ff,d0
	bne.w	.l_1acd4
	movea.l	$0(a0),a2
	adda.w	$14(a0),a2
	tst.b	d4
	bne.b	.l_1ac7c
	subq.w	#$1,$1c(a0)
	bpl.b	.l_1ac7c
	move.w	T_1b50e(pc),$1c(a0)
	move.w	d5,$14(a0)
	move.w	d5,$48(a0)
	move.w	d5,$7c(a0)
	movea.l	$0(a0),a2
.l_1ac7c:
	moveq	#0,d1
	move.b	(a2),d1
	move.b	$1(a2),$21(a0)
	move.b	$2(a2),$20(a0)
	move.b	$3(a2),d0
	move.b	d0,d2
	andi.w	#$f0,d2
	cmp.w	#$f0,d2
	bne.b	.l_1aca8
	move.b	d0,d2
	andi.b	#$f,d2
	move.b	d2,$30(a0)
	bra.b	.l_1acb8
.l_1aca8:
	cmp.b	#$e0,d2
	bne.b	.l_1acb8
	move.b	d0,d2
	andi.w	#$f,d2
	move.w	d2,$2(a5)
.l_1acb8:
	add.w	d1,d1
	movea.l	T_1b510(pc),a3
	movea.w	(a3,d1.w),a3
	adda.l	Coso_module(pc),a3
	move.l	a3,$c(a0)
	addi.w	#$c,$14(a0)
	bra.w	.l_1ac46
.l_1acd4:
	cmp.b	#$fe,d0
	bne.b	.l_1ace6
	move.b	(a1),$1b(a0)
	move.b	(a1)+,$1a(a0)
	bra.w	.l_1ac4a
.l_1ace6:
	cmp.b	#$fd,d0
	bne.b	.l_1acfa
	move.b	(a1),$1b(a0)
	move.b	(a1)+,$1a(a0)
	move.l	a1,$c(a0)
	rts
.l_1acfa:
	move.b	d0,$1e(a0)
	move.b	(a1)+,d1
	move.b	d1,$1f(a0)
	andi.w	#$e0,d1
	beq.b	.l_1ad0e
	move.b	(a1)+,$2c(a0)
.l_1ad0e:
	move.l	a1,$c(a0)
	move.l	d5,$10(a0)
	tst.b	d0
	bmi.b	.l_1ad88
	move.b	$1f(a0),d1
	move.b	d1,d0
	andi.w	#$1f,d1
	add.b	$20(a0),d1
	movea.l	T_1b518(pc),a2
	add.w	d1,d1
	movea.w	(a2,d1.w),a2
	adda.l	Coso_module(pc),a2
	move.w	d5,$16(a0)
	move.b	(a2),$23(a0)
	move.b	(a2)+,$22(a0)
	moveq	#0,d1
	move.b	(a2)+,d1
	move.b	(a2)+,$27(a0)
	move.b	#$40,$2b(a0)
	move.b	(a2),$28(a0)
	move.b	(a2)+,$29(a0)
	move.b	(a2)+,$2a(a0)
	move.l	a2,$4(a0)
	andi.b	#$40,d0
	beq.b	.l_1ad6a
	move.b	$2c(a0),d1
.l_1ad6a:
	movea.l	T_1b514(pc),a2
	add.w	d1,d1
	movea.w	(a2,d1.w),a2
	adda.l	Coso_module(pc),a2
	move.l	a2,$8(a0)
	move.w	d5,$18(a0)
	move.b	d5,$25(a0)
	move.b	d5,$24(a0)
.l_1ad88:
	rts
; Initialises the channels for the positions d0 to d1 (12 bytes per position).
Coso_init_positions:
	movem.l	d0-d1,-(a7)
	move.w	d2,d0
	bsr.w	Coso_init_samples
	movem.l	(a7)+,d0-d1
	andi.b	#$f0,$fffffa1d.w
	move.l	d0,d7
	move.l	d1,d6
	sub.l	d0,d1
	addq.l	#$1,d6
	mulu.w	#$c,d7
	mulu.w	#$c,d6
	lea.l	T_1b50e(pc),a0
	move.w	d1,(a0)
	moveq	#2,d0
	lea.l	Coso_channel_A(pc),a0
	lea.l	T_1b3e2(pc),a1
	lea.l	T_1b3ea(pc),a2
.l_1adc2:
	move.l	a1,$8(a0)
	clr.w	$18(a0)
	move.l	a1,$4(a0)
	clr.w	$16(a0)
	sf.b	$1e(a0)
	sf.b	$1f(a0)
	sf.b	$26(a0)
	sf.b	$2f(a0)
	move.b	#$1,$23(a0)
	move.b	#$1,$22(a0)
	sf.b	$24(a0)
	sf.b	$25(a0)
	sf.b	$27(a0)
	sf.b	$28(a0)
	sf.b	$29(a0)
	sf.b	$2a(a0)
	sf.b	$2c(a0)
	sf.b	$2d(a0)
	move.b	(a2),d3
	andi.w	#$f,d3
	add.w	d3,d3
	add.w	d3,d3
	move.b	(a2)+,$2e(a0)
	movea.l	T_1b51c(pc),a3
	adda.l	d7,a3
	adda.w	d3,a3
	move.l	a3,$0(a0)
	move.w	#$c,$14(a0)
	move.w	T_1b50e(pc),$1c(a0)
	moveq	#0,d1
	move.b	(a3)+,d1
	add.w	d1,d1
	movea.l	T_1b510(pc),a4
	movea.w	(a4,d1.w),a4
	adda.l	Coso_module(pc),a4
	move.l	a4,$c(a0)
	clr.w	$1a(a0)
	move.b	#$2,$32(a0)
	move.b	(a3)+,$21(a0)
	sf.b	$33(a0)
	move.b	(a3)+,$20(a0)
	sf.b	$31(a0)
	sf.b	$30(a0)
	move.b	(a3)+,d1
	move.b	d1,d2
	andi.w	#$f0,d1
	cmp.w	#$f0,d1
	bne.b	.l_1ae7c
	sub.b	d1,d2
	move.b	d2,$30(a0)
.l_1ae7c:
	clr.l	$10(a0)
	lea.l	$34(a0),a0
	dbra	d0,.l_1adc2
	lea.l	Coso_speed_counter(pc),a0
	move.w	#$1,(a0)
	clr.w	$4(a0)
	rts
; The sound effect is played on the effect channel.
Coso_start_effect:
	move.w	T_1b52c(pc),d2
	move.w	T_1b52a(pc),d1
	tst.w	d2
	beq.w	.l_1af2c
	lea.l	Coso_effect_channel(pc),a0
	lea.l	T_1b42e(pc),a5
	move.b	d2,$1e(a0)
	move.b	d1,$2e(a0)
	sf.b	$21(a0)
	moveq	#0,d5
	andi.w	#$ff,d0
	movea.l	T_1b518(pc),a2
	add.w	d0,d0
	movea.w	(a2,d0.w),a2
	adda.l	Coso_module(pc),a2
	move.w	d5,$16(a0)
	move.b	(a2),$23(a0)
	move.b	(a2)+,$22(a0)
	move.b	(a2)+,d0
	andi.w	#$ff,d0
	move.b	(a2)+,$27(a0)
	move.b	#$40,$2b(a0)
	move.b	(a2),$28(a0)
	move.b	(a2)+,$29(a0)
	move.b	(a2)+,$2a(a0)
	move.l	a2,$4(a0)
	movea.l	T_1b514(pc),a2
	add.w	d0,d0
	movea.w	(a2,d0.w),a2
	adda.l	Coso_module(pc),a2
	move.l	a2,$8(a0)
	move.w	d5,$18(a0)
	sf.b	$24(a0)
	sf.b	$33(a0)
	sf.b	$25(a0)
	clr.l	$10(a0)
	sf.b	$30(a0)
	sf.b	$2c(a0)
	addq.w	#$1,d1
	move.w	d1,$4(a5)
.l_1af2c:
	rts
; Period (d0) and volume (d1) of a channel for this step.
Coso_channel_frame:
	moveq	#0,d7
	move.b	d7,$2d(a0)
	tst.b	$25(a0)
	beq.b	.l_1af42
	subq.b	#$1,$25(a0)
	bra.w	T_1b13a
.l_1af42:
	movea.l	$8(a0),a1
	adda.w	$18(a0),a1
	move.b	(a1)+,d0
	moveq	#0,d1
	move.b	d0,d1
	subi.w	#$e0,d1
	bmi.w	.l_1b132
	add.w	d1,d1
	move.w	.l_1af62(pc,d1.w),d1
	jmp	.l_1af62(pc,d1.w)
.l_1af62:
	dc.b	$00,$fe,$01,$10,$01,$1a,$01,$2c,$01,$3c,$01,$4c,$01,$5a,$01,$68
	dc.b	$01,$88,$01,$94,$01,$be,$00,$f2,$00,$1c,$00,$c0,$70,$00,$10,$19
	dc.b	$12,$19,$14,$19,$24,$7a,$05,$aa,$0c,$aa,$4d,$41,$52,$43,$00,$f8
	dc.b	$66,$00,$00,$86,$d0,$40,$d0,$40,$d0,$40,$36,$72,$00,$00,$d7,$ca
	dc.b	$16,$3a,$05,$94,$67,$36,$2c,$4b,$40,$e7,$46,$fc,$27,$00,$34,$7c
	dc.b	$88,$00,$20,$3c,$04,$00,$05,$00,$01,$ca,$00,$00,$14,$bc,$00,$07
	dc.b	$10,$12,$08,$c0,$00,$05,$08,$80,$00,$02,$15,$40,$00,$02,$61,$00
	dc.b	$03,$f4,$46,$df,$00,$38,$00,$01,$fa,$1d,$60,$3c,$22,$0b,$74,$00
	dc.b	$34,$32,$00,$08,$d4,$8a,$04,$82,$00,$00,$00,$77,$02,$01,$00,$fe
	dc.b	$02,$02,$00,$fe,$34,$7c,$89,$00,$42,$52,$03,$8a,$00,$05,$05,$8a
	dc.b	$00,$11,$48,$41,$48,$42,$35,$41,$00,$02,$35,$42,$00,$0e,$35,$7c
	dc.b	$00,$80,$00,$20,$34,$bc,$00,$01,$58,$68,$00,$18,$60,$00,$ff,$2a
	dc.b	$10,$3a,$05,$14,$67,$24,$45,$fa,$fa,$70,$4a,$92,$67,$1c,$02,$38
	dc.b	$00,$f0,$fa,$1d,$40,$e7,$46,$fc,$27,$00,$11,$fc,$00,$0a,$88,$10
	dc.b	$51,$f8,$88,$12,$61,$00,$03,$7e,$46,$df,$52,$68,$00,$18,$60,$00
	dc.b	$fe,$f8,$11,$59,$00,$33,$54,$68,$00,$18,$60,$00,$fe,$ec,$70,$00
	dc.b	$10,$19,$31,$40,$00,$18,$22,$68,$00,$08,$d3,$c0,$60,$00,$fe,$da
	dc.b	$11,$69,$ff,$fe,$00,$26,$60,$00,$00,$c0,$31,$47,$00,$16,$11,$7c
	dc.b	$00,$01,$00,$22,$52,$68,$00,$18,$60,$00,$fe,$be,$11,$59,$00,$27
	dc.b	$11,$59,$00,$28,$56,$68,$00,$18,$60,$00,$fe,$ae,$11,$47,$00,$32
	dc.b	$11,$59,$00,$2d,$54,$68,$00,$18,$60,$00,$fe,$9e,$11,$7c,$00,$01
	dc.b	$00,$32,$52,$68,$00,$18,$60,$00,$fe,$90,$11,$7c,$00,$02,$00,$32
	dc.b	$52,$68,$00,$18,$60,$00,$fe,$82,$12,$3c,$00,$00,$12,$19,$22,$7a
	dc.b	$04,$46,$d2,$41,$32,$72,$10,$00,$d3,$fa,$04,$52,$21,$49,$00,$08
	dc.b	$31,$47,$00,$18,$60,$00,$fe,$62,$11,$59,$00,$25,$54,$68,$00,$18
	dc.b	$60,$00,$fe,$40,$36,$7c,$88,$70,$40,$e7,$46,$fc,$27,$00,$16,$bc
	dc.b	$00,$0b,$17,$59,$00,$02,$20,$3c,$0c,$00,$0d,$0a,$01,$cb,$00,$08
	dc.b	$61,$00,$02,$b2,$46,$df,$54,$68,$00,$18,$60,$00,$fe,$2c,$11,$7c
	dc.b	$00,$20,$00,$1f,$11,$59,$00,$2c,$54,$68,$00,$18,$60,$00,$fe,$1a
.l_1b132:
	move.b	d0,$26(a0)
	addq.w	#$1,$18(a0)
T_1b13a:
	tst.b	$24(a0)
	beq.b	.l_1b146
	subq.b	#$1,$24(a0)
	bra.b	T_1b1ae
.l_1b146:
	subq.b	#$1,$22(a0)
	bne.b	T_1b1ae
	move.b	$23(a0),$22(a0)
	movea.l	$4(a0),a1
	adda.w	$16(a0),a1
T_1b15a:
	moveq	#0,d1
	move.b	(a1)+,d0
	move.b	d0,d1
	subi.w	#$e0,d1
	bmi.b	T_1b1a6
	add.w	d1,d1
	move.w	.l_1b170(pc,d1.w),d1
	jmp	T_1b180+2(pc,d1.w)
.l_1b170:
	ori.b	#$12,d0
	ori.b	#$0,d0
	ori.b	#$0,d0
	ori.b	#$0,d0
T_1b180:
	dc.w	$001a,$7200	; ori.b #$0, (a2)+
	move.b	(a1)+,d1
	subq.w	#$5,d1
	move.w	d1,$16(a0)
	movea.l	$4(a0),a1
	adda.w	d1,a1
	bra.b	T_1b15a
	move.b	-$2(a1),$2f(a0)
	bra.b	T_1b1ae
	addq.w	#$2,$16(a0)
	move.b	(a1),$24(a0)
	bra.b	T_1b13a
T_1b1a6:
	move.b	d0,$2f(a0)
	addq.w	#$1,$16(a0)
T_1b1ae:
	move.b	$26(a0),d0
	bmi.b	.l_1b1bc
	add.b	$1e(a0),d0
	add.b	$21(a0),d0
.l_1b1bc:
	andi.w	#$7f,d0
	lea.l	Coso_period_table(pc),a1
	add.w	d0,d0
	move.w	d0,d1
	move.w	(a1,d0.w),d0
	move.b	$2e(a0),d3
	move.b	$32(a0),d2
	bne.b	.l_1b1de
	bclr	d3,(a4)
	addq.w	#$3,d3
	bclr	d3,(a4)
	bra.b	.l_1b20c
.l_1b1de:
	cmp.b	#$1,d2
	bne.b	.l_1b206
	bset	d3,(a4)
	addq.w	#$3,d3
	bclr	d3,(a4)
	move.b	$1e(a0),$2d(a0)
	move.b	$26(a0),d4
	bpl.b	.l_1b200
	andi.b	#$7f,d4
	move.b	d4,$2d(a0)
	bra.b	.l_1b20c
.l_1b200:
	add.b	d4,$2d(a0)
	bra.b	.l_1b20c
.l_1b206:
	bclr	d3,(a4)
	addq.w	#$3,d3
	bset	d3,(a4)
.l_1b20c:
	tst.b	$2d(a0)
	beq.b	.l_1b220
	move.b	$2d(a0),d3
	not.b	d3
	andi.b	#$1f,d3
	move.b	d3,$1(a4)
.l_1b220:
	move.b	T_1b537(pc),d2
	beq.w	.l_1b31c
	tst.b	$2a(a0)
	beq.b	.l_1b234
	subq.b	#$1,$2a(a0)
	bra.b	.l_1b280
.l_1b234:
	moveq	#0,d1
	moveq	#0,d2
	moveq	#0,d3
	move.b	$29(a0),d1
	move.b	$28(a0),d2
	move.w	d2,d5
	add.w	d5,d5
	move.b	$27(a0),d3
	move.b	$2b(a0),d4
	btst	#$5,d4
	beq.b	.l_1b260
	sub.w	d3,d1
	bpl.b	.l_1b26c
	moveq	#0,d1
	bchg	#$5,d4
	bra.b	.l_1b26c
.l_1b260:
	add.w	d3,d1
	cmp.w	d5,d1
	ble.b	.l_1b26c
	move.w	d5,d1
	bchg	#$5,d4
.l_1b26c:
	move.b	d1,$29(a0)
	move.b	d4,$2b(a0)
	sub.w	d2,d1
	ext.l	d1
	muls.w	d0,d1
	asr.l	#$8,d1
	asr.l	#$2,d1
	add.w	d1,d0
.l_1b280:
	btst	#$5,$1f(a0)
	beq.b	.l_1b2a4
	moveq	#0,d1
	move.b	$2c(a0),d1
	ext.w	d1
	ext.l	d1
	move.l	$10(a0),d2
	add.l	d1,d2
	move.l	d2,$10(a0)
	muls.w	d0,d2
	asr.l	#$8,d2
	asr.w	#$2,d2
	sub.w	d2,d0
.l_1b2a4:
	move.b	$2f(a0),d1
	sub.b	$30(a0),d1
	sub.w	Coso_volume_reduction(pc),d1
	sub.b	$31(a0),d1
	bpl.b	.l_1b2b8
	moveq	#0,d1
.l_1b2b8:
	move.b	$33(a0),d7
	beq.b	.l_1b31a
	movea.w	#$8830,a3
	move.w	d0,d2
	btst	#$7,d7
	beq.b	.l_1b2e0
	move.w	sr,-(a7)
	move.w	#$2700,sr
	move.l	#$c000d0a,d4
	movep.l	d4,$8(a3)
	bsr.w	Coso_select_register
	move.w	(a7)+,sr
.l_1b2e0:
	btst	#$1,d7
	beq.b	.l_1b2e8
	sub.w	d0,d0
.l_1b2e8:
	btst	#$3,d7
	beq.b	.l_1b2f4
	move.w	d2,d7
	lsr.w	#$3,d7
	bra.b	.l_1b300
.l_1b2f4:
	btst	#$2,d7
	bne.b	.l_1b2fc
	lsr.w	#$1,d7
.l_1b2fc:
	move.w	d2,d7
	lsr.w	#$4,d7
.l_1b300:
	move.w	sr,-(a7)
	move.w	#$2700,sr
	move.b	#$b,(a3)
	move.b	d7,$a(a3)
	move.b	Coso_sample_mode(pc),d3
	beq.b	.l_1b318
	bsr.w	Coso_select_register
.l_1b318:
	move.w	(a7)+,sr
.l_1b31a:
	rts
.l_1b31c:
	tst.b	$2a(a0)
	beq.b	.l_1b328
	subq.b	#$1,$2a(a0)
	bra.b	.l_1b38e
.l_1b328:
	move.b	d1,d5
	move.b	$2b(a0),d6
	move.b	$28(a0),d4
	bmi.b	.l_1b338
	add.b	d4,d4
	bra.b	.l_1b33c
.l_1b338:
	andi.b	#$7f,d4
.l_1b33c:
	move.b	$29(a0),d1
	tst.b	d6
	bpl.b	.l_1b348
	btst	d7,d6
	bne.b	.l_1b36e
.l_1b348:
	btst	#$5,d6
	bne.b	.l_1b35c
	sub.b	$27(a0),d1
	bcc.b	.l_1b36a
	bset	#$5,d6
	moveq	#0,d1
	bra.b	.l_1b36a
.l_1b35c:
	add.b	$27(a0),d1
	cmp.b	d4,d1
	bcs.b	.l_1b36a
	bclr	#$5,d6
	move.b	d4,d1
.l_1b36a:
	move.b	d1,$29(a0)
.l_1b36e:
	lsr.b	#$1,d4
	sub.b	d4,d1
	bcc.b	.l_1b378
	subi.w	#$100,d1
.l_1b378:
	addi.b	#$a0,d5
	bcs.b	.l_1b386
.l_1b37e:
	add.w	d1,d1
	addi.b	#$18,d5
	bcc.b	.l_1b37e
.l_1b386:
	add.w	d1,d0
	bchg	d7,d6
	move.b	d6,$2b(a0)
.l_1b38e:
	btst	#$5,$1f(a0)
	beq.b	.l_1b3b0
	moveq	#0,d1
	move.b	$2c(a0),d1
	ext.w	d1
	swap	d1
	asr.l	#$4,d1
	move.l	$10(a0),d2
	add.l	d1,d2
	move.l	d2,$10(a0)
	swap	d2
	sub.w	d2,d0
.l_1b3b0:
	move.b	$2f(a0),d1
	sub.b	$30(a0),d1
	sub.w	Coso_volume_reduction(pc),d1
	sub.b	$31(a0),d1
	bpl.b	.l_1b3c4
	moveq	#0,d1
.l_1b3c4:
	rts
; Selects the YM2149 register 10 (15 in sample mode 2).
Coso_select_register:
	move.w	d0,-(a7)
	move.l	d1,-(a7)
	moveq	#10,d1
	move.b	Coso_sample_mode(pc),d0
	cmp.b	#$2,d0
	bne.b	.l_1b3d8
	addq.w	#$5,d1
.l_1b3d8:
	move.b	d1,$ffff8800.w
	move.l	(a7)+,d1
	move.w	(a7)+,d0
	rts
T_1b3e2:
	dc.b	$01,$00,$00,$00,$00,$00,$00,$e1
T_1b3ea:
	dc.b	$00,$01,$02,$00
; The YM2149 registers 0-10 as pairs of register and value, written with movem to the mirrors of $ffff8800.
Coso_YM_registers:
	dc.b	$00,$00,$00,$00,$01,$00,$00,$00,$02,$00,$00,$00,$03,$00,$00,$00
	dc.b	$04,$00,$00,$00,$05,$00,$00,$00,$06,$00,$00,$00,$07,$00,$ff,$00
	dc.b	$08,$00,$00,$00,$09,$00,$00,$00,$0a,$00,$00,$00
; Offsets of the registers in Coso_YM_registers of the channel which plays the sound effect.
Coso_effect_registers:
	dc.b	$00,$00,$00,$00,$02,$06,$22,$00,$0a,$0e,$26,$00,$12,$16,$2a,$00
T_1b42a:
	dc.b	$00,$00
; Is subtracted from the volume of each channel (Coso_player+12).
Coso_volume_reduction:
	dc.b	$00,$00
T_1b42e:
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00
; Steps until the next notes, followed by the speed of the song.
Coso_speed_counter:
	dc.b	$00,$04
T_1b438:
	dc.b	$00,$04
T_1b43a:
	dc.b	$ff,$00
; State of a channel (52 bytes).
Coso_channel_A:
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00
Coso_channel_B:
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00
Coso_channel_C:
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00
Coso_effect_channel:
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$40
T_1b50e:
	dc.b	$00,$00
T_1b510:
	dc.b	$00,$00,$00,$00
T_1b514:
	dc.b	$00,$00,$00,$00
T_1b518:
	dc.b	$00,$00,$00,$00
T_1b51c:
	dc.b	$00,$00,$00,$00,$00,$00
T_1b522:
	dc.b	$00,$00,$00,$00
T_1b526:
	dc.b	$00,$00,$00,$00
T_1b52a:
	dc.b	$00,$00
T_1b52c:
	dc.b	$00,$00
; The module which is played.
Coso_module:
	dc.b	$00,$00,$00,$00
T_1b532:
	dc.b	$00,$00,$00,$00
; If set, the YM2149 registers are not written (Coso_player+16).
Coso_mute:
	dc.b	$00
T_1b537:
	dc.b	$00
; $ff: no samples, otherwise the mode d0 of Coso_init_samples.
Coso_sample_mode:
	dc.b	$ff,$00
; YM2149 periods of the notes.
Coso_period_table:
	dc.b	$0e,$ee,$0e,$17,$0d,$4d,$0c,$8e,$0b,$d9,$0b,$2f,$0a,$8e,$09,$f7
	dc.b	$09,$67,$08,$e0,$08,$61,$07,$e8,$07,$77,$07,$0b,$06,$a6,$06,$47
	dc.b	$05,$ec,$05,$97,$05,$47,$04,$fb,$04,$b3,$04,$70,$04,$30,$03,$f4
	dc.b	$03,$bb,$03,$85,$03,$53,$03,$23,$02,$f6,$02,$cb,$02,$a3,$02,$7d
	dc.b	$02,$59,$02,$38,$02,$18,$01,$fa,$01,$dd,$01,$c2,$01,$a9,$01,$91
	dc.b	$01,$7b,$01,$65,$01,$51,$01,$3e,$01,$2c,$01,$1c,$01,$0c,$00,$fd
	dc.b	$00,$ee,$00,$e1,$00,$d4,$00,$c8,$00,$bd,$00,$b2,$00,$a8,$00,$9f
	dc.b	$00,$96,$00,$8e,$00,$86,$00,$7e,$00,$77,$00,$70,$00,$6a,$00,$64
	dc.b	$00,$5e,$00,$59,$00,$54,$00,$4f,$00,$4b,$00,$47,$00,$43,$00,$3f
	dc.b	$00,$3b,$00,$38,$00,$35,$00,$32,$00,$2f,$00,$2c,$00,$2a,$00,$27
	dc.b	$00,$25,$00,$23,$00,$21,$00,$1f,$00,$1d,$00,$1c,$00,$1a,$00,$19
	dc.b	$00,$17,$00,$16,$00,$15,$00,$13,$00,$12,$00,$11,$00,$10,$00,$0f
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
T_1b63a:
	dc.b	$00,$00,$00,$00
