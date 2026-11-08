; MAIN/MAGIC.ASM (original module, merged with the disassembly of the shipped program)

	section	text

Do_magic:
	tst.b	Battling
	bne.b	.l_137ea
	bsr.w	.l_13850
	bra.b	.l_1384e
.l_137ea:
	tst.b	Magic_object_flag
	beq.b	.l_13824
	move.w	Active_member,B_5883e
	movea.l	Current_inventory_chardat_ptr,a1
	move.l	a1,Current_active_char_data
	lea.l	Chard_ptrs,a0
	moveq	#1,d0
	moveq	#5,d7
.l_13812:
	cmpa.l	(a0)+,a1
	beq.b	.l_1381e
	addq.w	#$1,d0
	dbra	d7,.l_13812
	moveq	#0,d0
.l_1381e:
	move.w	d0,Active_member
.l_13824:
	bsr.w	Item_spell_action
	tst.b	Magic_object_flag
	beq.b	.l_1384e
	move.w	B_5883e,d0
	move.w	d0,Active_member
	lea.l	Chard_ptrs,a0
	add.w	d0,d0
	add.w	d0,d0
	move.l	-$4(a0,d0.w),Current_active_char_data
.l_1384e:
	rts
.l_13850:
	movem.l	d0-d7/a0-a6,-(a7)
	tst.b	No_spell_selected
	beq.b	.l_13864
	sf.b	No_spell_selected
	bra.b	.l_138b4
.l_13864:
	lea.l	D_484a4,a0
	move.w	Selected_class,d0
	mulu.w	#$78,d0
	adda.w	d0,a0
	move.w	Selected_spell,d0
	add.w	d0,d0
	add.w	d0,d0
	adda.w	d0,a0
	move.l	a0,B_58824
	lea.l	.l_138ba,a0
	move.w	Selected_class,d0
	add.w	d0,d0
	add.w	d0,d0
	move.l	-$4(a0,d0.w),d0
	beq.b	.l_138b4
	movea.l	d0,a0
	move.w	Selected_spell,d0
	add.w	d0,d0
	add.w	d0,d0
	move.l	-$4(a0,d0.w),d0
	beq.b	.l_138b4
	movea.l	d0,a0
	jsr	(a0)
.l_138b4:
	movem.l	(a7)+,d0-d7/a0-a6
	rts
.l_138ba:
	dc.l	.l_138d6
	dc.l	.l_13946
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.l	.l_139ae
.l_138d6:
	dc.l	Heal_1
	dc.l	Heal_2
	dc.l	Heal_3
	dc.l	Heal_4
	dc.l	Heal_5
	dc.l	T_13bd0
	dc.l	T_13c12
	dc.l	T_13c96
	dc.l	Resurrect
	dc.l	Heal_diseased
	dc.l	Heal_aged
	dc.l	Heal_stoned
	dc.l	Heal_panic
	dc.l	Heal_irritated
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.l	Heal_blind
	dc.l	Heal_mad
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.l	Weapon_gunk
	dc.l	Create_food
.l_13946:
	dc.l	Light_1
	dc.l	Light_2
	dc.l	Light_3
	dc.l	Armour_1
	dc.l	Armour_2
	dc.l	Armour_3
	dc.l	Weapon_1
	dc.l	T_140be
	dc.l	T_140d6
	dc.l	T_140ee
	dc.l	T_14106
	dc.l	T_1411e
	dc.l	T_14136
	dc.l	T_1414e
	dc.l	T_14166
	dc.l	T_1417e
	dc.l	T_14196
	dc.l	T_141ae
	dc.l	Magic_sphere
	dc.l	T_1422e
	dc.l	Identify
	dc.l	T_14432
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00
	dc.l	T_144dc
	dc.l	T_145e4
.l_139ae:
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.l	Map_view
	dc.b	$00,$00,$00,$00
	dc.l	Spellpts1
	dc.l	Spellpts2
	dc.l	T_14d9a
	dc.l	Youth
	dc.b	$00,$00,$00,$00
	dc.l	T_150a8
	dc.l	T_152fc
Handle_spell:
	movem.l	d0-d1/a0-a1,-(a7)
	tst.b	Magic_object_flag
	beq.b	.l_13a72
	move.w	Active_member,B_5883e
	movea.l	Current_inventory_chardat_ptr,a1
	move.l	a1,Current_active_char_data
	lea.l	Chard_ptrs,a0
	moveq	#1,d0
	moveq	#5,d7
.l_13a2a:
	cmpa.l	(a0)+,a1
	beq.b	.l_13a36
	addq.w	#$1,d0
	dbra	d7,.l_13a2a
	moveq	#0,d0
.l_13a36:
	move.w	d0,Active_member
	tst.b	B_58833
	beq.b	.l_13a4c
	sf.b	B_58833
	bra.b	.l_13a68
.l_13a4c:
	move.l	Current_active_char_data,B_5880e
	move.b	Object_slot_number,d0
	ext.w	d0
	move.w	d0,B_5880c
	bsr.w	Remove_used_magic_item
.l_13a68:
	sf.b	B_5882f
	moveq	#0,d0
	bra.b	.l_13aca
.l_13a72:
	movea.l	B_58824,a0
	movea.l	Current_active_char_data,a1
	move.b	$1(a0),d0
	ext.w	d0
	move.w	$8a(a1),d1
	sub.w	d0,d1
	bpl.b	.l_13a8e
	moveq	#0,d1
.l_13a8e:
	move.w	d1,$8a(a1)
	moveq	#0,d0
	move.b	$f(a1),d0
	add.w	$c2(a1),d0
	jsr	Probe
	smi.b	B_5882f
	bpl.b	.l_13aca
	movea.l	Textfile_ptr,a0
	move.l	#Code0006Sys,Textfile_ptr
	moveq	#24,d0
	jsr	T_0a220
	move.l	a0,Textfile_ptr
	moveq	#-1,d0
.l_13aca:
	move.w	sr,-(a7)
	tst.b	Magic_object_flag
	beq.b	.l_13af2
	move.w	B_5883e,d0
	move.w	d0,Active_member
	lea.l	Chard_ptrs,a0
	add.w	d0,d0
	add.w	d0,d0
	move.l	-$4(a0,d0.w),Current_active_char_data
.l_13af2:
	move.w	(a7)+,sr
	movem.l	(a7)+,d0-d1/a0-a1
	rts
; ---- Heal_1 (original source: MAIN/MAGIC.ASM)
Heal_1:
	jsr	Random
	mulu.w	#5,d0
	swap.w	d0
	addq.w	#1,d0
	bra.w	Common_heal
; ---- Heal_2 (original source: MAIN/MAGIC.ASM)
Heal_2:
	jsr	Random
	mulu.w	#8,d0
	swap.w	d0
	addq.w	#2,d0
	bra.w	Common_heal
; ---- Heal_3 (original source: MAIN/MAGIC.ASM)
Heal_3:
	jsr	Random
	mulu.w	#16,d0
	swap.w	d0
	addq.w	#4,d0
	bra.w	Common_heal
; ---- Heal_4 (original source: MAIN/MAGIC.ASM)
Heal_4:
	jsr	Random
	mulu.w	#32,d0
	swap.w	d0
	addq.w	#8,d0
	bra.w	Common_heal
; ---- Heal_5 (original source: MAIN/MAGIC.ASM)
Heal_5:
	jsr	Random
	mulu.w	#64,d0
	swap.w	d0
	addi.w	#16,d0
; ---- Common_heal (original source: MAIN/MAGIC.ASM)
Common_heal:
	move.w	d0,Added_LP
	movea.l	Textfile_ptr,a0
	move.l	#Code0007Sys,Textfile_ptr
	move.w	#1,WText_nr
	lea.l	TxtW_Mod,a0
	bsr.w	Push_Module
	move.l	a0,Textfile_ptr
	lea.l	VictimSel_Mod,a0
	move.l	#.Continue,Return_ptr(a0)
	bra.w	Push_Module
.Continue:
	bsr.w	Pop_Module
	tst.b	Victim_selected
	beq.s	.Exit
	movea.l	Victim_ptr,a0
	move.w	Body_conditions(a0),d0
	andi.w	#$e000,d0
	bne.s	.Exit
	bsr.w	Handle_spell
	bmi.s	.Exit
	move.w	Added_LP,d0
	movea.l	Victim_ptr,a0
	bsr.w	Increase_LP
	move.w	Victim_nr,d0
	bsr.w	Do_sparkle
.Exit:
	rts	
T_13bd0:
	bsr.w	Handle_spell
	bmi.b	.l_13c10
	lea.l	Chard_ptrs,a1
	moveq	#1,d7
.l_13bde:
	tst.l	(a1)
	beq.b	.l_13c06
	movea.l	(a1),a0
	move.w	#$e000,d1
	and.w	$3a(a0),d1
	bne.b	.l_13c06
	jsr	Random
	mulu.w	#$10,d0
	swap	d0
	addq.w	#$4,d0
	bsr.w	Increase_LP
	move.w	d7,d0
	bsr.w	Do_sparkle
.l_13c06:
	addq.l	#$4,a1
	addq.w	#$1,d7
	cmpi.w	#$7,d7
	bmi.b	.l_13bde
.l_13c10:
	rts
T_13c12:
	movea.l	Textfile_ptr,a0
	move.l	#Code0007Sys,Textfile_ptr
	move.w	#$2,WText_nr
	lea.l	TxtW_Mod,a0
	bsr.w	Push_Module
	move.l	a0,Textfile_ptr
	lea.l	VictimSel_Mod,a0
	move.l	#.l_13c4c,$28(a0)
	bra.w	Push_Module
.l_13c4c:
	bsr.w	Pop_Module
	tst.b	Victim_selected
	beq.b	.l_13c94
	movea.l	Victim_ptr,a0
	move.b	$3a(a0),d0
	btst	#$5,d0
	beq.b	.l_13c94
	bclr	#$5,d0
	bsr.w	Handle_spell
	bmi.b	.l_13c82
	move.b	d0,$3a(a0)
	move.w	Victim_nr,d0
	bsr.w	Resurrection
	bra.b	.l_13c8a
.l_13c82:
	dc.b	$08,$c0,$00,$06,$11,$40,$00,$3a
.l_13c8a:
	move.w	Victim_nr,d0
	bsr.w	Do_sparkle
.l_13c94:
	rts
T_13c96:
	movea.l	Textfile_ptr,a0
	move.l	#Code0007Sys,Textfile_ptr
	move.w	#$3,WText_nr
	lea.l	TxtW_Mod,a0
	bsr.w	Push_Module
	move.l	a0,Textfile_ptr
	lea.l	VictimSel_Mod,a0
	move.l	#.l_13cd0,$28(a0)
	bra.w	Push_Module
.l_13cd0:
	bsr.w	Pop_Module
	tst.b	Victim_selected
	beq.b	.l_13d1e
	movea.l	Victim_ptr,a0
	move.b	$3a(a0),d0
	btst	#$6,d0
	beq.b	.l_13d1e
	bclr	#$6,d0
	bsr.w	Handle_spell
	bmi.b	.l_13d06
	move.b	d0,$3a(a0)
	move.w	Victim_nr,d0
	bsr.w	Resurrection
	bra.b	.l_13d0e
.l_13d06:
	dc.b	$08,$c0,$00,$07,$11,$40,$00,$3a
.l_13d0e:
	move.w	Victim_nr,d0
	bsr.w	Do_sparkle
	jsr	Force_char_update
.l_13d1e:
	rts
Resurrect:
Change_ashes:
	movea.l	Textfile_ptr,a0
	move.l	#Code0007Sys,Textfile_ptr
	move.w	#$4,WText_nr
	lea.l	TxtW_Mod,a0
	bsr.w	Push_Module
	move.l	a0,Textfile_ptr
	lea.l	VictimSel_Mod,a0
	move.l	#.l_13d5a,$28(a0)
	bra.w	Push_Module
.l_13d5a:
	bsr.w	Pop_Module
	tst.b	Victim_selected
	beq.b	.l_13d98
	movea.l	Victim_ptr,a0
	move.b	$3a(a0),d0
	btst	#$7,d0
	beq.b	.l_13d98
	bsr.w	Handle_spell
	bmi.b	.l_13d98
	bclr	#$7,d0
	move.b	d0,$3a(a0)
	move.w	Victim_nr,d0
	bsr.w	Resurrection
	bsr.w	Do_sparkle
	jsr	Force_char_update
.l_13d98:
	rts
; ---- Heal_diseased (original source: MAIN/MAGIC.ASM)
Heal_diseased:
	moveq	#5,d0	; CHANGE: was "moveq.l #7,d0"
	moveq	#9,d1	; CHANGE: was "moveq.l #11,d1"
	bra.w	Common_heal_condition
; ---- Heal_aged (original source: MAIN/MAGIC.ASM)
Heal_aged:
	moveq	#6,d0	; CHANGE: was "moveq.l #8,d0"
	moveq	#8,d1	; CHANGE: was "moveq.l #12,d1"
	bra.w	Common_heal_condition
; ---- Heal_stoned (original source: MAIN/MAGIC.ASM)
Heal_stoned:
	moveq	#7,d0	; CHANGE: was "moveq.l #9,d0"
	moveq	#11,d1	; CHANGE: was "moveq.l #10,d1"
	bra.w	Common_heal_condition
; ---- Heal_panic (original source: MAIN/MAGIC.ASM)
Heal_panic:
	moveq	#8,d0	; CHANGE: was "moveq.l #10,d0"
	moveq	#12,d1	; CHANGE: was "moveq.l #3,d1"
	bra.w	Common_heal_condition
; ---- Heal_irritated (original source: MAIN/MAGIC.ASM)
Heal_irritated:
	moveq	#9,d0	; CHANGE: was "moveq.l #11,d0"
	moveq	#10,d1	; CHANGE: was "moveq.l #0,d1"
	bra.w	Common_heal_condition
; ---- Heal_blind (original source: MAIN/MAGIC.ASM)
Heal_blind:
	moveq.l	#12,d0
	moveq.l	#4,d1
	bra.w	Common_heal_condition
; ---- Heal_mad (original source: MAIN/MAGIC.ASM)
Heal_mad:
	moveq.l	#13,d0
	moveq.l	#1,d1
; ---- Common_heal_condition (original source: MAIN/MAGIC.ASM)
Common_heal_condition:
	move.w	d1,Condition_nr
	movea.l	Textfile_ptr,a0
	move.l	#Code0007Sys,Textfile_ptr
	move.w	d0,WText_nr
	lea.l	TxtW_Mod,a0
	bsr.w	Push_Module
	move.l	a0,Textfile_ptr
	lea.l	VictimSel_Mod,a0
	move.l	#.Continue,Return_ptr(a0)
	bra.w	Push_Module
.Continue:
	bsr.w	Pop_Module
	tst.b	Victim_selected
	beq.s	.Exit
	movea.l	Victim_ptr,a0
	move.w	Body_conditions(a0),d0
	move.w	Condition_nr,d1
	btst	d1,d0
	beq.s	.Exit
	bsr.w	Handle_spell
	bmi.s	.Exit
	bclr	d1,d0
	move.w	d0,Body_conditions(a0)
	move.w	Victim_nr,d0
	bsr.w	Do_sparkle
.Exit:
	rts	
; ---- Weapon_gunk (original source: MAIN/MAGIC.ASM)
Remove_curse:
Weapon_gunk:
	movea.l	Textfile_ptr,a0
	move.l	#Code0007Sys,Textfile_ptr
	move.w	#$18,WText_nr	; CHANGE: was "move.w #21,WText_nr"
	lea.l	TxtW_Mod,a0
	bsr.w	Push_Module
	move.l	a0,Textfile_ptr
	lea.l	VictimSel_Mod,a0
	move.l	#.Continue,Return_ptr(a0)
	bra.w	Push_Module
.Continue:
	bsr.w	Pop_Module
	tst.b	Victim_selected
	beq.s	.Exit
	tst.b	Magic_object_flag
	bne.s	.Already
	bsr.w	Exit_display
.Already:
	lea.l	RemCurse2_Mod,a0	; CHANGE: was ".Already: Push Module,Gunk_Mod"
	bsr.w	Push_Module
.Exit:
	rts	
; ---- RemCurse2_DisInit (original source: MAIN/MAGIC.ASM)
Lore_DisInit:
Gunk_DisInit:
RemCurse2_DisInit:
	tst.b	Magic_object_flag
	sne	Fade_block
	move.l	Victim_ptr,Current_inventory_chardat_ptr
	bsr.w	Inv2_DisInit
	movea.l	Off_screen,a6
	move.l	#Code0007Sys,Textfile_ptr
	move.w	#21,d0
	jsr	Hash_message
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	RemCurse_MA,a0
	jsr	Push_MA
	rts	
RemCurse2_DisExit:
	jsr	Pop_MA
	movea.l	Off_screen,a6
	jsr	Erase_message_minus
	jsr	Switch_screen
	jsr	Copy_screen
	tst.b	Magic_object_flag
	bne.b	.l_13f1a
	bsr.w	Inv2_DisExit
.l_13f1a:
	rts
T_13f1c:
	btst	#$1,Mouse_button_state
	bne.b	T_13f1c
	tst.b	d0
	beq.w	.l_13fc6
	move.b	d0,Object_slot_number
	ext.w	d0
	subq.w	#$1,d0
	movea.l	Current_inventory_chardat_ptr,a0
	lea.l	$22(a0),a1
	adda.w	d0,a1
	tst.b	(a1)
	beq.w	.l_13fc6
	lea.l	$132(a0),a2
	mulu.w	#$28,d0
	adda.w	d0,a2
	btst	#$0,$18(a2)
	beq.b	.l_13fc6
	bsr.w	Handle_spell
	bmi.b	.l_13fb0
	jsr	Mouse_off
	moveq	#50,d0
	jsr	Delay
	clr.b	(a1)
	moveq	#0,d2
	move.w	$22(a2),d2
	sub.l	d2,$ec(a0)
	moveq	#0,d2
	moveq	#0,d3
	move.b	(a2),d2
	lea.l	Erase_icon,a3
	move.b	Object_slot_number,d0
	ext.w	d0
	move.b	-$1(a3,d0.w),d3
	lea.l	D_2dc66,a3
	add.w	d0,d0
	add.w	d0,d0
	move.w	$2(a3,d0.w),d1
	move.w	(a3,d0.w),d0
	bsr.w	Show_item_destruction
	moveq	#50,d0
	jsr	Delay
.l_13fb0:
	bsr.w	Pop_Module
	jsr	Mouse_on
	tst.b	Magic_object_flag
	bne.b	.l_13fc6
	bsr.w	Init_display
.l_13fc6:
	rts
; ---- Exit_RemCurse (original source: MAIN/MAGIC.ASM)
Exit_RemCurse:
	bsr.w	Pop_Module
	tst.b	Magic_object_flag
	bne.s	.Exit
	bsr.w	Init_display
.Exit:
	rts	
; ---- Create_food (original source: MAIN/MAGIC.ASM)
Create_food:
	bsr.w	Handle_spell
	bmi.s	.Exit
	lea.l	Chard_ptrs,a0
	moveq.l	#1,d0
	move.l	#Food_weight,d1
.Loop:
	tst.l	(a0)
	beq.s	.Next
	movea.l	(a0),a1	; CHANGE: added
	move.w	$3a(a1),d2	; CHANGE: was "move.w Body_conditions(a0),d1"
	andi.w	#$e000,d2	; CHANGE: was "andi.w #$e000,d1"
	bne.s	.Next
	addq.w	#$1,$92(a1)	; CHANGE: was "addq.w #1,Food_rations(a0)"
	add.l	d1,$ec(a1)	; CHANGE: was "add.l d1,Weight_normal(a0)"
	bsr.w	Do_sparkle	; CHANGE: added
.Next:
	addq.l	#4,a0
	addq.w	#1,d0
	cmpi.w	#6+1,d0
	bmi.s	.Loop
.Exit:
	rts	
; ---- Light_1 (original source: MAIN/MAGIC.ASM)
Light_1:
	bsr.w	Handle_spell
	bmi.s	.Exit
	move.w	#2,Spell_1_data
	move.w	#24,Spell_1_duration
.Exit:
	rts	
; ---- Light_2 (original source: MAIN/MAGIC.ASM)
Light_2:
	bsr.w	Handle_spell
	bmi.s	.Exit
	move.w	#4,Spell_1_data
	move.w	#96,Spell_1_duration
.Exit:
	rts	
; ---- Light_3 (original source: MAIN/MAGIC.ASM)
Light_3:
	bsr.w	Handle_spell
	bmi.s	.Exit
	move.w	#6,Spell_1_data
	move.w	#192,Spell_1_duration
.Exit:
	rts	
; ---- Armour_1 (original source: MAIN/MAGIC.ASM)
Armour_1:
	bsr.w	Handle_spell
	bmi.s	.Exit
	move.w	#5,Spell_2_data
	move.w	#24,Spell_2_duration
.Exit:
	rts	
; ---- Armour_2 (original source: MAIN/MAGIC.ASM)
Armour_2:
	bsr.w	Handle_spell
	bmi.s	.Exit
	move.w	#10,Spell_2_data
	move.w	#96,Spell_2_duration
.Exit:
	rts	
; ---- Armour_3 (original source: MAIN/MAGIC.ASM)
Armour_3:
	bsr.w	Handle_spell
	bmi.s	.Exit
	move.w	#15,Spell_2_data
	move.w	#192,Spell_2_duration
.Exit:
	rts	
; ---- Weapon_1 (original source: MAIN/MAGIC.ASM)
Weapon_1:
	bsr.w	Handle_spell
	bmi.s	.Exit
	move.w	#5,Spell_3_data
	move.w	#24,Spell_3_duration
.Exit:
	rts	
T_140be:
	bsr.w	Handle_spell
	bmi.b	.l_140d4
	move.w	#$a,Spell_3_data
	move.w	#$60,Spell_3_duration
.l_140d4:
	rts
T_140d6:
	bsr.w	Handle_spell
	bmi.b	.l_140ec
	move.w	#$f,Spell_3_data
	move.w	#$c0,Spell_3_duration
.l_140ec:
	rts
T_140ee:
	bsr.w	Handle_spell
	bmi.b	.l_14104
	move.w	#$5,Spell_4_data
	move.w	#$18,Spell_4_duration
.l_14104:
	rts
T_14106:
	bsr.w	Handle_spell
	bmi.b	.l_1411c
	move.w	#$a,Spell_4_data
	move.w	#$60,Spell_4_duration
.l_1411c:
	rts
T_1411e:
	bsr.w	Handle_spell
	bmi.b	.l_14134
	move.w	#$f,Spell_4_data
	move.w	#$c0,Spell_4_duration
.l_14134:
	rts
T_14136:
	bsr.w	Handle_spell
	bmi.b	.l_1414c
	move.w	#$2,Spell_5_data
	move.w	#$18,Spell_5_duration
.l_1414c:
	rts
T_1414e:
	bsr.w	Handle_spell
	bmi.b	.l_14164
	move.w	#$4,Spell_5_data
	move.w	#$60,Spell_5_duration
.l_14164:
	rts
T_14166:
	bsr.w	Handle_spell
	bmi.b	.l_1417c
	move.w	#$6,Spell_5_data
	move.w	#$c0,Spell_5_duration
.l_1417c:
	rts
T_1417e:
	bsr.w	Handle_spell
	bmi.b	.l_14194
	move.w	#$0,Spell_6_data
	move.w	#$18,Spell_6_duration
.l_14194:
	rts
T_14196:
	bsr.w	Handle_spell
	bmi.b	.l_141ac
	move.w	#$0,Spell_6_data
	move.w	#$60,Spell_6_duration
.l_141ac:
	rts
T_141ae:
	bsr.w	Handle_spell
	bmi.b	.l_141c4
	move.w	#$0,Spell_6_data
	move.w	#$c0,Spell_6_duration
.l_141c4:
	rts
Magic_sphere:
	bsr.w	Handle_spell
	bmi.b	.l_1422c
	move.w	#$6,Spell_1_data
	move.w	#$c0,Spell_1_duration
	move.w	#$f,Spell_2_data
	move.w	#$c0,Spell_2_duration
	move.w	#$f,Spell_3_data
	move.w	#$c0,Spell_3_duration
	move.w	#$f,Spell_4_data
	move.w	#$c0,Spell_4_duration
	move.w	#$6,Spell_5_data
	move.w	#$c0,Spell_5_duration
	move.w	#$0,Spell_6_data
	move.w	#$c0,Spell_6_duration
.l_1422c:
	rts
T_1422e:
	bsr.w	Handle_spell
	bmi.b	.l_1423e
	lea.l	MagicCompass_Mod,a0
	bsr.w	Push_Module
.l_1423e:
	rts
MagicComp_DisInit:
	moveq	#48,d0
	moveq	#64,d1
	moveq	#4,d2
	moveq	#4,d3
	moveq	#1,d6
	suba.l	a0,a0
	jsr	Open_window
	move.w	d0,B_58256
	lea.l	D_32f60,a0
	move.w	View_direction,d0
	lsl.w	#$8,d0
	add.w	d0,d0
	adda.w	d0,a0
	move.w	#$40,d0
	move.w	#$50,d1
	moveq	#2,d6
	moveq	#32,d7
	movea.l	Off_screen,a6
	jsr	Blot_unmasked_block
	jsr	Switch_screen
	jsr	Copy_screen
	rts
MagicComp_DisExit:
	btst	#$1,Mouse_button_state
	bne.b	MagicComp_DisExit
	move.w	B_58256,d0
	jsr	Close_window
	rts
; ---- Identify (original source: MAIN/MAGIC.ASM)
Identify:
	movea.l	Textfile_ptr,a0
	move.l	#Code0007Sys,Textfile_ptr
	move.w	#$19,WText_nr	; CHANGE: was "move.w #21,WText_nr"
	lea.l	TxtW_Mod,a0
	bsr.w	Push_Module
	move.l	a0,Textfile_ptr
	lea.l	VictimSel_Mod,a0
	move.l	#.Continue,Return_ptr(a0)
	bra.w	Push_Module
.Continue:
	bsr.w	Pop_Module
	tst.b	Victim_selected
	beq.s	.Exit
	tst.b	Magic_object_flag
	bne.s	.Already
	bsr.w	Exit_display
.Already:
	lea.l	Lore_Mod,a0
	bsr.w	Push_Module
.Exit:
	rts	
T_14306:
	tst.b	Magic_object_flag
	beq.b	.l_1431e
	st.b	Fade_block
	move.l	Current_inventory_chardat_ptr,B_58812
.l_1431e:
	move.l	Victim_ptr,Current_inventory_chardat_ptr
	bsr.w	Inv2_DisInit
	movea.l	Off_screen,a6
	movea.l	Textfile_ptr,a0
	move.l	#Code0007Sys,Textfile_ptr
	move.w	#$16,d0
	jsr	Hash_message
	move.l	a0,Textfile_ptr
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	D_2dd3e,a0
	jsr	Push_MA
	rts
T_1436c:
	btst	#$1,Mouse_button_state
	bne.b	T_1436c
	tst.b	d0
	beq.w	T_14430
	ext.w	d0
	addi.w	#$9,d0
	bra.b	T_14396
T_14384:
	btst	#$1,Mouse_button_state
	bne.b	T_14384
	tst.b	d0
	beq.w	T_14430
	ext.w	d0
T_14396:
	btst	#$1,Mouse_button_state
	bne.b	T_14396
	tst.b	d0
	beq.b	.l_14420
	move.b	d0,B_58832
	ext.w	d0
	subq.w	#$1,d0
	movea.l	Current_inventory_chardat_ptr,a0
	lea.l	$22(a0),a1
	adda.w	d0,a1
	tst.b	(a1)
	beq.b	T_14430
	lea.l	$132(a0),a2
	mulu.w	#$28,d0
	adda.w	d0,a2
	btst	#$7,$18(a2)
	bne.b	T_14430
	tst.b	Magic_object_flag
	beq.b	.l_143e2
	bsr.w	T_14f00
	st.b	B_58833
.l_143e2:
	bsr.w	Handle_spell
	bmi.b	T_14430
	bset	#$7,$18(a2)
	moveq	#0,d0
	move.b	B_58832,d0
	moveq	#0,d2
	move.b	(a2),d2
	bsr.w	Show_item_sparkle
	move.b	B_58832,Object_slot_number
	lea.l	D_281ce,a0
	move.l	#.l_1441a,$28(a0)
	bra.w	Push_Module
.l_1441a:
	dc.b	$42,$b9
	dc.l	D_281f6
.l_14420:
	bsr.w	Pop_Module
	tst.b	Magic_object_flag
	bne.b	T_14430
	bsr.w	Init_display
T_14430:
	rts
T_14432:
	move.w	Map_Xcoord,d0
	move.w	Map_Ycoord,d1
	jsr	Find_event
	beq.b	.l_1445c
	cmpi.b	#$5,(a5)
	bne.b	.l_1445c
	tst.b	$3(a5)
	bne.b	.l_1445c
	bsr.w	Handle_spell
	bmi.w	Exit_levitate
	bra.b	.l_1449a
.l_1445c:
	dc.b	$41,$f9
	dc.l	Dir_offset
	dc.b	$30,$39
	dc.l	View_direction
	dc.b	$d0,$40,$d0,$c0,$10,$18,$48,$80,$d0,$79
	dc.l	Map_Xcoord
	dc.b	$12,$10,$48,$81,$d2,$79
	dc.l	Map_Ycoord
	dc.b	$4e,$b9
	dc.l	Find_event
	dc.b	$67,$52,$0c,$15,$00,$05,$66,$4c,$4a,$2d,$00,$03,$67,$46,$61,$00
	dc.b	$f5,$68,$6b,$40
.l_1449a:
	tst.b	Magic_object_flag
	beq.b	Do_levitate
	bsr.w	Pop_Module
	bsr.w	T_10f3a
; ---- Do_levitate (original source: MAIN/MAGIC.ASM)
Do_levitate:
	jsr	Exit_map
	moveq.l	#0,d0
	move.b	1(a5),d0
	move.w	d0,Map_Xcoord
	move.b	2(a5),d0
	move.w	d0,Map_Ycoord
	move.w	6(a5),Map_nr
	jsr	Init_map
	jsr	Save_event
; ---- Exit_levitate (original source: MAIN/MAGIC.ASM)
Exit_levitate:
	rts	
T_144dc:
	cmpi.b	#$1,Current_map_type
	bne.b	.l_14526
	bsr.w	Handle_spell
	bmi.b	.l_14526
	move.w	View_direction,d0
	add.w	d0,d0
	add.w	d0,d0
	movea.l	.l_14528(pc,d0.w),a1
	move.w	Map_Xcoord,d0
	move.w	Map_Ycoord,d1
	movea.l	Map_pointer,a0
	jsr	(a1)
	move.w	d0,Map_Xcoord
	move.w	d1,Map_Ycoord
	jsr	Exit_map
	jsr	Init_map
.l_14526:
	rts
.l_14528:
	dc.l	.l_14538
	dc.l	.l_14554
	dc.l	.l_14574
	dc.l	.l_14594
.l_14538:
	subi.w	#$15,d1
.l_1453c:
	addq.w	#$1,d1
	cmp.w	Map_Ycoord,d1
	beq.b	.l_14552
	cmpi.w	#$1,d1
	bmi.b	.l_1453c
	bsr.w	.l_145b0
	bmi.b	.l_1453c
.l_14552:
	rts
.l_14554:
	addi.w	#$15,d0
	move.w	Width_of_map,d2
.l_1455e:
	subq.w	#$1,d0
	cmp.w	Map_Xcoord,d0
	beq.b	.l_14572
	cmp.w	d0,d2
	bmi.b	.l_1455e
	bsr.w	.l_145b0
	bmi.b	.l_1455e
.l_14572:
	rts
.l_14574:
	addi.w	#$15,d1
	move.w	Height_of_map,d2
.l_1457e:
	subq.w	#$1,d1
	cmp.w	Map_Ycoord,d1
	beq.b	.l_14592
	cmp.w	d1,d2
	bmi.b	.l_1457e
	bsr.w	.l_145b0
	bmi.b	.l_1457e
.l_14592:
	rts
.l_14594:
	subi.w	#$15,d0
.l_14598:
	addq.w	#$1,d0
	cmp.w	Map_Xcoord,d0
	beq.b	.l_145ae
	cmpi.w	#$1,d0
	bmi.b	.l_14598
	bsr.w	.l_145b0
	bmi.b	.l_14598
.l_145ae:
	rts
.l_145b0:
	movem.l	d0-d1/a0,-(a7)
	subq.w	#$1,d0
	subq.w	#$1,d1
	mulu.w	Width_of_map,d1
	add.w	d1,d0
	move.b	(a0,d0.w),d0
	lea.l	.l_145dc(pc),a0
.l_145c8:
	move.b	(a0)+,d1
	beq.b	.l_145d4
	cmp.b	d0,d1
	bne.b	.l_145c8
	moveq	#0,d0
	bra.b	.l_145d6
.l_145d4:
	dc.b	$70,$ff
.l_145d6:
	movem.l	(a7)+,d0-d1/a0
	rts
.l_145dc:
	dc.b	$02,$03,$12,$13,$14,$15,$23,$00
T_145e4:
	cmpi.b	#$2,Current_map_type
	bpl.b	.l_1460c
	bsr.w	Handle_spell
	bmi.b	.l_1460c
	move.w	B_5930c,d0
	addi.w	#$a,d0
	bvs.b	.l_1460c
	move.w	d0,B_5930c
	sf.b	D_1e1fa
.l_1460c:
	rts
; ---- Map_view (original source: MAIN/MAGIC.ASM)
Map_view:
	bsr.w	Handle_spell
	bmi.s	.Exit
	movea.l	Mapd_ptr,a0
	move.b	Map_special(a0),d0
	btst	#3,d0
	bne.s	.Do_it
	movea.l	Textfile_ptr,a0
	move.l	#Code0008Sys,Textfile_ptr
	move.w	#3,WText_nr
	lea.l	TxtW_Mod,a0
	bsr.w	Push_Module
	move.l	a0,Textfile_ptr
	bra.s	.Exit
.Do_it:
	tst.b	Magic_object_flag
	beq.s	.No
	bsr.w	Inv2_DisExit
	bra.s	.Skip
.No:
	bsr.w	Init_display
.Skip:
	lea.l	Minimap_Mod,a0
	bsr.w	Push_Module
.Exit:
	rts	
; ---- Minimap_DisUpd (original source: MAIN/MAGIC.ASM)
Minimap_DisUpd:
	jsr	Update_status_block
	tst.b	Minimap_update
	beq.s	.No_update
	movea.l	Off_screen,a6
	bsr.w	Display_minimap
	subq.b	#1,Minimap_update
.No_update:
	move.w	Map_Xcoord,d0
	move.w	Map_Ycoord,d1
	cmpi.b	#1,Current_map_type
	bne.s	.No_wild
	move.w	Quad_index,d2
	btst	#0,d2
	beq.s	.Zero
	addi.w	#Submap_width,d0
.Zero:
	btst	#1,d2
	beq.s	.No_wild
	addi.w	#Submap_height,d1
.No_wild:
	subq.w	#1,d0
	subq.w	#1,d1
; CHANGE: removed "move.w d0,d2"
; CHANGE: removed "move.w d1,d3"
; CHANGE: removed "lsr.w #3,d2"
; CHANGE: removed "lsr.w #3,d3"
; CHANGE: removed "sub.w Minimap_X,d2"
; CHANGE: removed "sub.w Minimap_Y,d3"
; CHANGE: removed "cmpi.w #12,d2"
; CHANGE: removed "bhi.s .Exit"
; CHANGE: removed "cmpi.w #10,d3"
; CHANGE: removed "bhi.s .Exit"
	move.w	Minimap_X,d2
	move.w	Minimap_Y,d3
	lsl.w	#3,d2
	lsl.w	#3,d3
	sub.w	d2,d0
	sub.w	d3,d1
	cmpi.w	#$57,d0	; CHANGE: added
	bhi.b	.Exit	; CHANGE: added
	cmpi.w	#$47,d1	; CHANGE: added
	bhi.b	.Exit	; CHANGE: added
	add.w	d0,d0
	add.w	d1,d1
	addi.w	#16,d0
	addi.w	#49,d1
	move.w	d0,d2
	move.w	d1,d3
	addq.w	#1,d2
	addq.w	#1,d3
	move.w	Minimap_colour,d6
	addq.w	#1,d6
	andi.w	#$f,d6
	move.w	d6,Minimap_colour
	movea.l	Off_screen,a6
	jsr	Draw_box
.Exit:
	rts	
; ---- Minimap_ModInit (original source: MAIN/MAGIC.ASM)
Minimap_ModInit:
	lea.l	Load_area,a0
	jsr	Push_MA
	move.w	#16,d0
	jsr	Push_Mptr
	lea.l	Minimap_CIL,a0
	moveq.l	#9-1,d7
.Loop:
	bclr	#7,(a0)+
	dbra	d7,.Loop
	lea.l	-9(a0),a0
	move.w	#0,Minimap_X
	move.w	#0,Minimap_Y
	cmpi.b	#1,Current_map_type
	bne.w	.No_wild
	move.w	#Submap_width,d0
	add.w	d0,d0
	cmpi.w	#8*11,d0
	bpl.s	.Ok1
	bset	#7,(a0)
	bset	#7,2(a0)
	bset	#7,3(a0)
	bset	#7,5(a0)
	bset	#7,6(a0)
	bset	#7,8(a0)
.Ok1:
	move.w	#Submap_height,d0
	add.w	d0,d0
	cmpi.w	#8*9,d0
	bpl.s	.Ok2
	bset	#7,0(a0)
	bset	#7,1(a0)
	bset	#7,2(a0)
	bset	#7,6(a0)
	bset	#7,7(a0)
	bset	#7,8(a0)
.Ok2:
	move.w	#Submap_width,d0
	add.w	d0,d0
	addq.w	#$7,d0	; CHANGE: was "addi.w #7,d0"
	lsr.w	#3,d0
	move.w	d0,Minimap_width
	move.w	#Submap_height,d1
	add.w	d1,d1
	addq.w	#$7,d1	; CHANGE: was "addi.w #7,d1"
	lsr.w	#3,d1
	move.w	d1,Minimap_height
	mulu.w	d1,d0
	lsl.l	#7,d0
	jsr	Allocate_memory
	move.l	a1,Minimap_ptr
	moveq.l	#0,d1
	lsr.w	#2,d0
	subq.w	#1,d0
.Clear1:
	move.l	d1,(a1)+
	dbra	d0,.Clear1
	lea.l	Quad_map,a3
	moveq.l	#0,d1
	moveq.l	#0,d4
	movea.l	(a3)+,a0
	bsr.w	.Do_it
	moveq.l	#0,d1
	move.w	#Submap_width,d4
	movea.l	(a3)+,a0
	bsr.w	.Do_it
	move.w	#Submap_height,d1
	moveq.l	#0,d4
	movea.l	(a3)+,a0
	bsr.w	.Do_it
	move.w	#Submap_height,d1
	move.w	#Submap_width,d4
	movea.l	(a3),a0
	bsr.w	.Do_it
	bra.w	.Exit
.Do_it:
	lea.l	Map_data(a0),a0
	movea.l	Icondata_ptr,a1
	lea.l	Map_icon_color(a1),a1
	moveq.l	#0,d2
	move.w	Size_of_map,d5
	move.w	Height_of_map,d7
	subq.w	#1,d7
.LoopY1:
	move.w	d4,d0
	move.w	Width_of_map,d6
	subq.w	#1,d6
.LoopX1:
	move.b	(a0),d2
	move.b	-1(a1,d2.w),d2
	bsr.w	Set1_minimap_element
	move.b	0(a0,d5.w),d2
	beq.s	.Next1
	move.b	-1(a1,d2.w),d2
	bsr.w	Set2_minimap_element
.Next1:
	addq.l	#1,a0
	addq.w	#1,d0
	dbra	d6,.LoopX1
	addq.w	#1,d1
	dbra	d7,.LoopY1
	rts	
.No_wild:
	move.w	Width_of_map,d0
	cmpi.w	#8*11,d0
	bpl.s	.Ok3
	bset	#7,(a0)
	bset	#7,2(a0)
	bset	#7,3(a0)
	bset	#7,5(a0)
	bset	#7,6(a0)
	bset	#7,8(a0)
.Ok3:
	move.w	Height_of_map,d0
	cmpi.w	#8*9,d0
	bpl.s	.Ok4
	bset	#7,0(a0)
	bset	#7,1(a0)
	bset	#7,2(a0)
	bset	#7,6(a0)
	bset	#7,7(a0)
	bset	#7,8(a0)
.Ok4:
	move.w	Width_of_map,d0
	addq.w	#7,d0
	lsr.w	#3,d0
	move.w	d0,Minimap_width
	move.w	Height_of_map,d1
	addq.w	#7,d1
	lsr.w	#3,d1
	move.w	d1,Minimap_height
	mulu.w	d1,d0
	lsl.l	#7,d0
	jsr	Allocate_memory
	move.l	a1,Minimap_ptr
	moveq.l	#0,d1
	lsr.w	#2,d0
	subq.w	#1,d0
.Clear2:
	move.l	d1,(a1)+
	dbra	d0,.Clear2
	cmpi.b	#2,Current_map_type
	bmi.s	.No_3D
	movea.l	Map_pointer,a0
	movea.l	Lab_IC_ptr,a1
	moveq.l	#0,d1
	moveq.l	#0,d2
	move.w	Height_of_map,d7
	subq.w	#1,d7
.LoopY2:
	moveq.l	#0,d0
	move.w	Width_of_map,d6
	subq.w	#1,d6
.LoopX2:
	move.b	(a0)+,d2
	move.b	-1(a1,d2.w),d2
	bsr.w	Set1_minimap_element
	addq.w	#1,d0
	dbra	d6,.LoopX2
	addq.w	#1,d1
	dbra	d7,.LoopY2
	bra.s	.Exit
.No_3D:
	movea.l	Map_pointer,a0
	movea.l	Icondata_ptr,a1
	lea.l	Map_icon_color(a1),a1
	moveq.l	#0,d1
	moveq.l	#0,d2
	move.w	Size_of_map,d5
	move.w	Height_of_map,d7
	subq.w	#1,d7
.LoopY3:
	moveq.l	#0,d0
	move.w	Width_of_map,d6
	subq.w	#1,d6
.LoopX3:
	move.b	(a0),d2
	move.b	-1(a1,d2.w),d2
	bsr.w	Set1_minimap_element
	move.b	0(a0,d5.w),d2
	beq.s	.Next3
	move.b	-1(a1,d2.w),d2
	bsr.w	Set2_minimap_element
.Next3:
	addq.l	#1,a0
	addq.w	#1,d0
	dbra	d6,.LoopX3
	addq.w	#1,d1
	dbra	d7,.LoopY3
.Exit:
	jsr	Pop_Mptr
	jsr	Pop_MA
	bra.w	Init_display
; ---- Minimap_ModExit (original source: MAIN/MAGIC.ASM)
Minimap_ModExit:
	movea.l	Minimap_ptr,a0
	jsr	Free_memory
	bra.w	Minimap_DisExit
Minimap_DisInit:
	lea.l	D_2e7a6,a0
	jsr	Push_MA
	movea.l	Off_screen,a6
	moveq	#11,d0
	jsr	Show_layout
	move.w	#$10,d0
	move.w	#$31,d1
	move.w	#$bf,d2
	move.w	#$c0,d3
	moveq	#0,d6
	jsr	Draw_box
	movea.l	Mapd_ptr,a5
	jsr	Print_headline
	move.b	#$2,Minimap_update
	move.l	#Minimap_CIL,Control_list_ptr
	jsr	Show_control_icons
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	Control_area,a0
	jsr	Set_layout_data
	cmpi.b	#$2,Current_map_type
	bpl.b	.l_14a50
	movea.l	Icondata_ptr,a0
	lea.l	$7d2(a0),a0
	bra.b	.l_14a56
.l_14a50:
	movea.l	Colpall_ptrs,a0
.l_14a56:
	lea.l	Pal_buffer,a1
	jsr	IFF_pal_convert
	lea.l	Subfade1,a2
.l_14a68:
	lea.l	Hbl_2D_map,a0
	jsr	Update_HBL
	jsr	My_vsync
	jsr	My_vsync
	lea.l	Below_pal_2D,a0
	jsr	Fade_pal
	bne.b	.l_14a68
	lea.l	Hbl_2D_map,a0
	jsr	Update_HBL
	rts
; ---- Minimap_DisExit (original source: MAIN/MAGIC.ASM)
Minimap_DisExit:
	lea.l	Void,a1
	lea.l	Subfade1,a2
.Again:
	lea.l	Hbl_2D_map,a0
	jsr	Update_HBL
	jsr	My_vsync
	jsr	My_vsync
	lea.l	Below_pal_2D,a0
	jsr	Fade_pal
	bne.s	.Again
	lea.l	Hbl_2D_map,a0
	jsr	Update_HBL
	jsr	Pop_MA
	rts	
; ---- Minimap_exit (original source: MAIN/MAGIC.ASM)
Minimap_exit:
	bsr.w	Pop_Module
	tst.b	Magic_object_flag
	beq.s	.No
	bsr.w	Pop_Module
.No:
	bsr.w	Init_display
.Exit:
	rts	
; ---- Minimap_up (original source: MAIN/MAGIC.ASM)
Minimap_up:
	move.w	Minimap_Y,d0
	subq.w	#1,d0
	bmi.s	.Exit
	move.w	d0,Minimap_Y
	move.b	#2,Minimap_update
.Exit:
	rts	
; ---- Minimap_left (original source: MAIN/MAGIC.ASM)
Minimap_left:
	move.w	Minimap_X,d0
	subq.w	#1,d0
	bmi.s	.Exit
	move.w	d0,Minimap_X
	move.b	#2,Minimap_update
.Exit:
	rts	
; ---- Minimap_right (original source: MAIN/MAGIC.ASM)
Minimap_right:
	move.w	Minimap_X,d0
	addq.w	#1,d0
	move.w	Minimap_width,d1
	subi.w	#11-1,d1
	cmp.w	d1,d0
	bpl.s	.Exit
	move.w	d0,Minimap_X
	move.b	#2,Minimap_update
.Exit:
	rts	
; ---- Minimap_down (original source: MAIN/MAGIC.ASM)
Minimap_down:
	move.w	Minimap_Y,d0
	addq.w	#1,d0
	move.w	Minimap_height,d1
	subq.w	#$8,d1	; CHANGE: was "subi.w #9-1,d1"
	cmp.w	d1,d0
	bpl.s	.Exit
	move.w	d0,Minimap_Y
	move.b	#2,Minimap_update
.Exit:
	rts	
; ---- Minimap_upleft (original source: MAIN/MAGIC.ASM)
Minimap_upleft:
	bsr.w	Minimap_up
	bra.w	Minimap_left
; ---- Minimap_upright (original source: MAIN/MAGIC.ASM)
Minimap_upright:
	bsr.w	Minimap_up
	bra.w	Minimap_right
; ---- Minimap_downleft (original source: MAIN/MAGIC.ASM)
Minimap_downleft:
	bsr.w	Minimap_down
	bra.w	Minimap_left
; ---- Minimap_downright (original source: MAIN/MAGIC.ASM)
Minimap_downright:
	bsr.w	Minimap_down
	bra.w	Minimap_right
; ---- Display_minimap (original source: MAIN/MAGIC.ASM)
Display_minimap:
	movem.l	d0-d2/d5-d7/a0,-(sp)
	moveq.l	#11,d6
	cmp.w	Minimap_width,d6
	bmi.s	.Ok1
	move.w	Minimap_width,d6
.Ok1:
	moveq.l	#9,d5
	cmp.w	Minimap_height,d5
	bmi.s	.Ok2
	move.w	Minimap_height,d5
.Ok2:
	movea.l	Minimap_ptr,a0
	move.w	Minimap_Y,d0
	mulu.w	Minimap_width,d0
	lsl.w	#7,d0
	adda.w	d0,a0
	move.w	Minimap_X,d0
	lsl.w	#3,d0
	adda.w	d0,a0
	moveq.l	#16,d0
	moveq.l	#49,d1
	move.w	Minimap_width,d2
	lsl.w	#3,d2
	lsl.w	#4,d5
	subq.w	#1,d5
	moveq.l	#1,d7
.Loop:
	jsr	Blot_unmasked_block
	addq.w	#1,d1
	adda.w	d2,a0
	dbra	d5,.Loop
	movem.l	(sp)+,d0-d2/d5-d7/a0
	rts	
; ---- Set1_minimap_element (original source: MAIN/MAGIC.ASM)
Set1_minimap_element:
	movem.l	d0-d3/d6/d7/a0,-(sp)
	movea.l	Minimap_ptr,a0
	move.w	Minimap_width,d6
	lsl.w	#3,d6
	move.w	d6,d3
	add.w	d3,d3
	mulu.w	d3,d1
	adda.w	d1,a0
	move.w	d0,d1
	andi.w	#$fff8,d0
	adda.w	d0,a0
	andi.w	#$7,d1
	add.w	d1,d1
	move.w	#$c000,d0
	lsr.w	d1,d0
	move.w	d0,d1
	not.w	d1
	moveq.l	#4-1,d7
.Loop:
	lsr.w	#1,d2
	bcc.s	.Clear
	or.w	d0,0(a0,d6.w)
	or.w	d0,(a0)+
	bra.s	.Next
.Clear:
	and.w	d1,0(a0,d6.w)
	and.w	d1,(a0)+
.Next:
	dbra	d7,.Loop
	movem.l	(sp)+,d0-d3/d6/d7/a0
	rts	
; ---- Set2_minimap_element (original source: MAIN/MAGIC.ASM)
Set2_minimap_element:
	movem.l	d0-d3/d6/d7/a0,-(sp)
	movea.l	Minimap_ptr,a0
	move.w	Minimap_width,d6
	lsl.w	#3,d6
	move.w	d6,d3
	add.w	d3,d3
	mulu.w	d3,d1
	adda.w	d1,a0
	move.w	d0,d1
	andi.w	#$fff8,d0
	adda.w	d0,a0
	andi.w	#$7,d1
	add.w	d1,d1
	move.w	#$8000,d0
	lsr.w	d1,d0
	move.w	d0,d1
	not.w	d1
	moveq.l	#4-1,d7
.Loop:
	lsr.w	#1,d2
	bcc.s	.Clear
	or.w	d0,0(a0,d6.w)
	ror.w	#1,d0
	or.w	d0,(a0)+
	rol.w	#1,d0
	bra.s	.Next
.Clear:
	and.w	d1,0(a0,d6.w)
	ror.w	#1,d1
	and.w	d1,(a0)+
	rol.w	#1,d1
.Next:
	dbra	d7,.Loop
	movem.l	(sp)+,d0-d3/d6/d7/a0
	rts	
; ---- Spellpts1 (original source: MAIN/MAGIC.ASM)
Spellpts1:
	movea.l	Textfile_ptr,a0
	move.l	#Code0008Sys,Textfile_ptr
	move.w	#5,WText_nr
	lea.l	TxtW_Mod,a0
	bsr.w	Push_Module
	move.l	a0,Textfile_ptr
	lea.l	VictimSel_Mod,a0
	move.l	#.Continue,Return_ptr(a0)
	bra.w	Push_Module
.Continue:
	bsr.w	Pop_Module
	tst.b	Victim_selected
	beq.s	.Exit
	bsr.w	Handle_spell
	bmi.s	.Exit
	movea.l	Victim_ptr,a0
	jsr	Random
	mulu.w	#25,d0
	swap.w	d0
	addq.w	#1,d0
	add.w	$8a(a0),d0	; CHANGE: was "add.w Power_points_normal(a0),d1"
	move.w	$8c(a0),d1	; CHANGE: was "move.w Power_points_max(a0),d0"
	add.w	$9a(a0),d1	; CHANGE: was "add.w Power_points_max_magic(a0),d0"
	cmp.w	d1,d0
	bpl.s	.Skip
	move.w	d0,d1
.Skip:
	move.w	d1,Power_points_normal(a0)
	move.w	Victim_nr,d0
	bsr.w	Do_sparkle
.Exit:
	rts	
; ---- Spellpts2 (original source: MAIN/MAGIC.ASM)
Spellpts2:
	movea.l	Textfile_ptr,a0
	move.l	#Code0008Sys,Textfile_ptr
	move.w	#5,WText_nr
	lea.l	TxtW_Mod,a0
	bsr.w	Push_Module
	move.l	a0,Textfile_ptr
	lea.l	VictimSel_Mod,a0
	move.l	#.Continue,Return_ptr(a0)
	bra.w	Push_Module
.Continue:
	bsr.w	Pop_Module
	tst.b	Victim_selected
	beq.s	.Exit
	bsr.w	Handle_spell
	bmi.s	.Exit
	movea.l	Victim_ptr,a0
	move.w	Power_points_max(a0),d0
	add.w	Power_points_max_magic(a0),d0
	cmp.w	Power_points_normal(a0),d0
	bmi.s	.Exit
	move.w	d0,Power_points_normal(a0)
	move.w	Victim_nr,d0
	bsr.w	Do_sparkle
.Exit:
	rts	
T_14d9a:
	movea.l	Textfile_ptr,a0
	move.l	#Code0006Sys,Textfile_ptr
	move.w	#$19,WText_nr
	lea.l	TxtW_Mod,a0
	bsr.w	Push_Module
	move.l	a0,Textfile_ptr
	lea.l	VictimSel_Mod,a0
	move.l	#.l_14dd4,$28(a0)
	bra.w	Push_Module
.l_14dd4:
	bsr.w	Pop_Module
	tst.b	Victim_selected
	beq.b	.l_14dea
	lea.l	Gunk_Mod,a0
	bsr.w	Push_Module
.l_14dea:
	rts
T_14dec:
	st.b	Fade_block
	move.l	Current_inventory_chardat_ptr,B_58812
	move.l	Victim_ptr,Current_inventory_chardat_ptr
	bsr.w	Inv2_DisInit
	movea.l	Off_screen,a6
	movea.l	Textfile_ptr,a0
	move.l	#Code0008Sys,Textfile_ptr
	move.w	#$6,d0
	jsr	Hash_message
	move.l	a0,Textfile_ptr
	jsr	Switch_screen
	jsr	Copy_screen
	lea.l	D_2dd3e,a0
	jsr	Push_MA
	rts
T_14e4a:
	btst	#$1,Mouse_button_state
	bne.b	T_14e4a
	tst.b	d0
	beq.w	T_14efe
	ext.w	d0
	addi.w	#$9,d0
	bra.b	T_14e74
T_14e62:
	btst	#$1,Mouse_button_state
	bne.b	T_14e62
	tst.b	d0
	beq.w	T_14efe
	ext.w	d0
T_14e74:
	btst	#$1,Mouse_button_state
	bne.b	T_14e74
	move.b	d0,B_58832
	subq.w	#$1,d0
	movea.l	Current_inventory_chardat_ptr,a0
	lea.l	$22(a0),a1
	adda.w	d0,a1
	tst.b	(a1)
	beq.b	T_14efe
	lea.l	$132(a0),a2
	mulu.w	#$28,d0
	adda.w	d0,a2
	cmpi.b	#$4,$1(a2)
	beq.b	.l_14eb0
	cmpi.b	#$5,$1(a2)
	bne.b	T_14efe
.l_14eb0:
	bsr.w	T_14f00
	jsr	Random
	mulu.w	#$4,d0
	swap	d0
	addq.w	#$1,d0
	moveq	#0,d1
	move.b	$11(a2),d1
	add.w	d0,d1
	cmpi.w	#$80,d1
	bmi.b	.l_14ed2
	moveq	#127,d1
.l_14ed2:
	move.b	d1,$11(a2)
	moveq	#0,d1
	move.b	$1f(a0),d1
	add.w	d0,d1
	cmpi.w	#$80,d1
	bmi.b	.l_14ee6
	moveq	#127,d1
.l_14ee6:
	move.b	d1,$1f(a0)
	moveq	#0,d0
	move.b	B_58832,d0
	moveq	#0,d2
	move.b	(a2),d2
	bsr.w	Show_item_sparkle
	bsr.w	Pop_Module
T_14efe:
	rts
T_14f00:
	movem.l	d0-d1/a0-a2/a6,-(a7)
	movea.l	B_58812,a0
	lea.l	$21(a0),a1
	lea.l	$10a(a0),a2
	move.b	Object_slot_number,d0
	ext.w	d0
	adda.w	d0,a1
	mulu.w	#$28,d0
	adda.w	d0,a2
	btst	#$2,$18(a2)
	bne.b	.l_14f3a
	cmpi.b	#$ff,$e(a2)
	beq.w	.l_14ff6
	subq.b	#$1,$e(a2)
	bne.b	.l_14fae
.l_14f3a:
	moveq	#0,d0
	move.w	$22(a2),d0
	sub.l	d0,$ec(a0)
	subq.b	#$1,(a1)
	cmpi.b	#$a,Object_slot_number
	bpl.b	.l_14fae
	move.b	$4(a2),d2
	sub.b	d2,$1c(a0)
	move.b	$5(a2),d2
	sub.b	d2,$1d(a0)
	move.b	$13(a2),d2
	sub.b	d2,$20(a0)
	move.b	$14(a2),d2
	sub.b	d2,$21(a0)
	lea.l	$ae(a0),a5
	move.b	$19(a2),d2
	ext.w	d2
	add.w	d2,d2
	adda.w	d2,a5
	move.b	$1b(a2),d2
	ext.w	d2
	add.w	d2,(a5)
	lea.l	$ae(a0),a5
	move.b	$1a(a2),d2
	ext.w	d2
	add.w	d2,d2
	adda.w	d2,a5
	move.b	$1c(a2),d2
	ext.w	d2
	add.w	d2,(a5)
	btst	#$0,$18(a2)
	bne.b	.l_14faa
	bsr.w	Negative_boni
	bra.b	.l_14fae
.l_14faa:
	bsr.w	Positive_boni
.l_14fae:
	cmpa.l	Current_inventory_chardat_ptr,a0
	bne.b	.l_14ff6
	lea.l	$21(a0),a1
	lea.l	$10a(a0),a2
	move.b	Object_slot_number,d0
	ext.w	d0
	adda.w	d0,a1
	moveq	#40,d1
	mulu.w	d0,d1
	adda.w	d1,a2
	moveq	#0,d2
	move.b	(a2),d2
	bsr.w	Show_item_sparkle
	tst.b	(a1)
	bne.b	.l_14ff6
	move.b	Object_slot_number,d0
	movea.l	Off_screen,a6
	bsr.w	INV2_Erase_object
	jsr	Switch_screen
	jsr	Copy_screen
.l_14ff6:
	movem.l	(a7)+,d0-d1/a0-a2/a6
	rts
; ---- Youth (original source: MAIN/MAGIC.ASM)
Youth:
	movea.l	Textfile_ptr,a0
	move.l	#Code0008Sys,Textfile_ptr
	move.w	#7,WText_nr
	lea.l	TxtW_Mod,a0
	bsr.w	Push_Module
	move.l	a0,Textfile_ptr
	lea.l	VictimSel_Mod,a0
	move.l	#.Continue,Return_ptr(a0)
	bra.w	Push_Module
.Continue:
	bsr.w	Pop_Module
	tst.b	Victim_selected
	beq.s	.Exit
	bsr.w	Handle_spell
	bmi.s	.Exit
	movea.l	Victim_ptr,a0
	move.w	Attr_9_normal(a0),d1
	jsr	Random
	mulu.w	#10,d0
	swap.w	d0
	addq.w	#1,d0
	sub.w	d0,d1
	cmpi.w	#15,d1
	bpl.b	.c_1506a	; CHANGE: was "bmi.s .Exit"
	moveq	#15,d1	; CHANGE: added
.c_1506a:
	move.w	d1,Attr_9_normal(a0)
	move.w	Victim_nr,d0
	bsr.w	Do_sparkle
	tst.b	Magic_object_flag	; CHANGE: added
	beq.b	.Exit	; CHANGE: added
	movea.l	Victim_ptr,a1	; CHANGE: added
	cmpa.l	Current_inventory_chardat_ptr,a1	; CHANGE: added
	bne.b	.Exit	; CHANGE: added
	moveq	#33,d7	; CHANGE: added
	movea.l	Off_screen,a6	; CHANGE: added
	bsr.w	Display_character	; CHANGE: added
	jsr	Switch_screen	; CHANGE: added
	jsr	Copy_screen	; CHANGE: added
.Exit:
	rts	
T_150a8:
	tst.w	Travel_mode
	bne.b	.l_150d8
	bsr.w	Handle_spell
	bmi.b	.l_150d8
	tst.b	Magic_object_flag
	beq.b	.l_150c6
	bsr.w	Pop_Module
	bsr.w	T_10f3a
.l_150c6:
	lea.l	D_2d4f4,a0
	bsr.w	Push_Module
	moveq	#5,d0
	jsr	Set_new_travel_mode
.l_150d8:
	rts
T_150da:
	jsr	Switch_screen
	move.w	#$0,Draw_Cicon
	jsr	Switch_screen
	jsr	Mouse_off
	jsr	Copy_screen
	move.l	#$3180,d0
	jsr	Allocate_memory
	move.l	a1,B_58828
	move.w	#$10,d0
	move.w	#$31,d1
	move.w	#$b,d6
	move.w	#$90,d7
	movea.l	a1,a0
	movea.l	Off_screen,a6
	jsr	Get2_block
	jsr	Random
	andi.w	#$3,d0
	move.w	d0,d2
	lea.l	Dir_offset,a1
	add.w	d0,d0
	adda.w	d0,a1
	lea.l	D_2de6c,a0
	add.w	d0,d0
	adda.w	d0,a0
	move.w	(a0)+,d3
	move.w	(a0)+,d4
	moveq	#3,d5
	btst	#$0,d2
	beq.b	.l_15158
	addq.w	#$1,d5
.l_15158:
	add.w	d5,d5
	addq.w	#$1,d5
.l_1515c:
	move.w	#$10,d0
	move.w	#$31,d1
	move.w	#$b,d6
	move.w	#$90,d7
	movea.l	B_58828,a0
	movea.l	Off_screen,a6
	jsr	Blot_unmasked_block
	move.w	d3,d0
	move.w	d4,d1
	bsr.w	T_152d2
	move.b	(a1),d0
	move.b	$1(a1),d1
	ext.w	d0
	ext.w	d1
	lsl.w	#$3,d0
	lsl.w	#$3,d1
	add.w	d0,d3
	add.w	d1,d4
	jsr	Switch_screen
	jsr	My_vsync
	jsr	My_vsync
	jsr	My_vsync
	dbra	d5,.l_1515c
	jsr	Copy_screen
	jsr	Mouse_on
	movea.l	B_58828,a0
	jsr	Free_memory
	bra.w	Pop_Module
T_151d0:
	jsr	Switch_screen
	move.w	#$0,Draw_Cicon
	jsr	Switch_screen
	jsr	Mouse_off
	jsr	Copy_screen
	move.l	#$3180,d0
	jsr	Allocate_memory
	move.l	a1,B_58828
	move.w	#$10,d0
	move.w	#$31,d1
	move.w	#$b,d6
	move.w	#$90,d7
	movea.l	a1,a0
	movea.l	Off_screen,a6
	jsr	Get2_block
	jsr	Random
	andi.w	#$3,d0
	move.w	d0,d2
	lea.l	Dir_offset,a1
	add.w	d0,d0
	adda.w	d0,a1
	move.w	#$60,d3
	move.w	#$71,d4
	moveq	#3,d5
	btst	#$0,d2
	beq.b	.l_15248
	addq.w	#$1,d5
.l_15248:
	add.w	d5,d5
	addq.w	#$1,d5
	move.b	(a1),d0
	move.b	$1(a1),d1
	ext.w	d0
	ext.w	d1
	lsl.w	#$3,d0
	lsl.w	#$3,d1
	add.w	d0,d3
	add.w	d1,d4
.l_1525e:
	move.w	#$10,d0
	move.w	#$31,d1
	move.w	#$b,d6
	move.w	#$90,d7
	movea.l	B_58828,a0
	movea.l	Off_screen,a6
	jsr	Blot_unmasked_block
	move.w	d3,d0
	move.w	d4,d1
	bsr.w	T_152d2
	move.b	(a1),d0
	move.b	$1(a1),d1
	ext.w	d0
	ext.w	d1
	lsl.w	#$3,d0
	lsl.w	#$3,d1
	add.w	d0,d3
	add.w	d1,d4
	jsr	Switch_screen
	jsr	My_vsync
	jsr	My_vsync
	jsr	My_vsync
	dbra	d5,.l_1525e
	jsr	Copy_screen
	jsr	Mouse_on
	movea.l	B_58828,a0
	jsr	Free_memory
	bra.w	Pop_Module
T_152d2:
	movem.l	d2/a0-a1,-(a7)
	movea.l	Icondata_ptr,a0
	lea.l	$fc(a0),a1
	lea.l	$1e2(a1),a1
	add.w	(a1),d2
	lea.l	$794(a0),a0
	mulu.w	#$86,d2
	adda.l	d2,a0
	jsr	Blit_masked_block
	movem.l	(a7)+,d2/a0-a1
	rts
T_152fc:
	bsr.w	Handle_spell
	bmi.b	.l_1530c
	lea.l	D_2d860,a0
	bsr.w	Push_Module
.l_1530c:
	rts
T_1530e:
	move.w	#$10,d0
	move.w	#$40,d1
	move.w	#$e,d2
	move.w	#$7,d3
	moveq	#1,d6
	lea.l	D_2f976,a0
	jsr	Open_window
	move.w	d0,B_58822
	lea.l	D_2dd92,a0
	jsr	Push_PA
	bra.w	T_15370
T_15342:
	move.w	B_58822,d0
	jsr	Close_window
	jsr	Pop_PA
	rts
T_15356:
	btst	#$1,Mouse_button_state
	bne.b	T_15356
	lsr.w	#$8,d0
	beq.b	.l_1536e
	jsr	Play_song
	bsr.w	T_15370
.l_1536e:
	rts
T_15370:
	movea.l	Off_screen,a6
	lea.l	D_2de7c,a1
	move.w	#$20,d2
	move.w	#$55,d3
	moveq	#1,d4
	move.w	Current_song,d5
	moveq	#9,d7
.l_1538e:
	move.w	d2,d0
	move.w	d3,d1
	jsr	IG_Set_cursor
	moveq	#15,d0
	cmp.w	d4,d5
	bne.b	.l_153a0
	moveq	#1,d0
.l_153a0:
	jsr	IG_Set_ink
	movea.l	(a1)+,a0
	jsr	IG_Print
	jsr	IG_Carriage_return
	addq.w	#$7,d3
	addq.w	#$1,d4
	dbra	d7,.l_1538e
	addi.w	#$60,d2
	move.w	#$55,d3
	moveq	#8,d7
.l_153c6:
	move.w	d2,d0
	move.w	d3,d1
	jsr	IG_Set_cursor
	moveq	#15,d0
	cmp.w	d4,d5
	bne.b	.l_153d8
	moveq	#1,d0
.l_153d8:
	jsr	IG_Set_ink
	movea.l	(a1)+,a0
	jsr	IG_Print
	jsr	IG_Carriage_return
	addq.w	#$7,d3
	addq.w	#$1,d4
	dbra	d7,.l_153c6
	jsr	Switch_screen
	jsr	Copy_screen
	rts
SCSelW_DisInit:
	move.w	#$10,d0
	move.w	#$40,d1
	move.w	#$a,d2
	move.w	#$5,d3
	moveq	#1,d6
	lea.l	D_2fade,a0
	jsr	Open_window
	move.w	d0,B_58818
	lea.l	D_2dd9e,a0
	jsr	Push_PA
	movea.l	Off_screen,a6
	moveq	#1,d1
	movea.l	Current_active_char_data,a0
	move.b	$1a(a0),d2
	lea.l	D_48868,a1
	moveq	#6,d7
.l_1544c:
	btst	d1,d2
	beq.b	.l_15462
	move.w	(a1),d0
	bsr.w	Get_word
	lea.l	Line_buffer,a0
	jsr	IG_Print
.l_15462:
	jsr	IG_Carriage_return
	addq.w	#$1,d1
	addq.l	#$2,a1
	dbra	d7,.l_1544c
	jsr	Switch_screen
	jsr	Copy_screen
	rts
SCSelW_DisExit:
	move.w	B_58818,d0
	jsr	Close_window
	jsr	Pop_PA
	rts
T_15492:
	btst	#$1,Mouse_button_state
	bne.b	T_15492
	lsr.w	#$8,d0
	movea.l	Current_active_char_data,a0
	btst	d0,$1a(a0)
	beq.b	.l_154d4
	move.w	d0,Selected_class
	bsr.w	Pop_Module
	lea.l	$d0(a0),a0
	add.w	d0,d0
	add.w	d0,d0
	tst.l	-$4(a0,d0.w)
	bne.b	.l_154ca
	st.b	No_spell_selected
	bra.b	.l_154d4
.l_154ca:
	lea.l	SpSelW_Mod,a0
	bsr.w	Push_Module
.l_154d4:
	rts
T_154d6:
	st.b	No_spell_selected
	bra.w	Pop_Module
SpSelW_ModInit:
	sf.b	No_spell_selected
	clr.w	Spell_list_pos
	movea.l	Current_active_char_data,a0
	moveq	#0,d1
	moveq	#1,d2
	move.w	Spell_area_type,d4
	move.w	$8a(a0),d6
	lea.l	D_48520,a1
	move.w	Selected_class,d0
	subq.w	#$1,d0
	mulu.w	#$78,d0
	adda.w	d0,a1
	lea.l	$d0(a0),a0
	move.w	Selected_class,d0
	add.w	d0,d0
	add.w	d0,d0
	move.l	-$4(a0,d0.w),d3
	lea.l	D_2dd84,a0
	move.w	Selected_class,d7
	add.w	d7,d7
	move.w	-$2(a0,d7.w),d7
	lea.l	D_48876,a2
	move.w	Selected_class,d0
	subq.w	#$1,d0
	mulu.w	#$3c,d0
	adda.w	d0,a2
	lea.l	Spell_table,a0
	bra.b	T_15594
T_15554:
	btst	d2,d3
	beq.b	.l_1558e
	addq.w	#$1,d1
	moveq	#0,d5
	move.b	(a1),d0
	btst	d4,d0
	bne.b	.l_15566
	moveq	#1,d0
	bra.b	.l_15586
.l_15566:
	moveq	#0,d0
	move.b	$1(a1),d0
	beq.b	.l_15572
	cmp.w	d0,d6
	bpl.b	.l_15576
.l_15572:
	moveq	#2,d0
	bra.b	.l_15586
.l_15576:
	moveq	#0,d5
	move.w	d6,d5
	divu.w	d0,d5
	cmpi.w	#$64,d5
	bmi.b	.l_15584
	moveq	#99,d5
.l_15584:
	moveq	#15,d0
.l_15586:
	move.b	d0,(a0)+
	move.b	d2,(a0)+
	move.w	d5,(a0)+
	move.w	(a2),(a0)+
.l_1558e:
	addq.w	#$1,d2
	addq.l	#$4,a1
	addq.l	#$2,a2
T_15594:
	dbra	d7,T_15554
	move.w	d1,Nr_of_spells
	cmpi.w	#$11,d1
	smi.b	B_58830
	moveq	#28,d0
	mulu.w	d1,d0
	jsr	Allocate_memory
	move.l	a1,Text_buffer
	movea.l	a1,a0
	lsr.w	#$2,d0
	subq.w	#$1,d0
	move.l	#$20202020,d1
.l_155c4:
	move.l	d1,(a0)+
	dbra	d0,.l_155c4
	lea.l	Spell_table,a2
	moveq	#32,d1
	moveq	#2,d7
	move.w	Nr_of_spells,d6
	bra.b	T_1561a
T_155dc:
	movea.l	a1,a3
	move.b	#$1,(a3)+
	move.b	(a2),(a3)+
	move.w	$4(a2),d0
	jsr	Find_word
	moveq	#0,d0
	move.b	(a0)+,d0
	subq.w	#$1,d0
	bra.b	T_155f8
T_155f6:
	move.b	(a0)+,(a3)+
T_155f8:
	dbra	d0,T_155f6
	move.w	$2(a2),d0
	beq.b	.l_15612
	lea.l	$17(a1),a3
	move.b	#$28,(a3)+
	bsr.w	RConvert_number
	move.b	#$29,(a3)
.l_15612:
	lea.l	$1b(a1),a1
	clr.b	(a1)+
	addq.l	#$6,a2
T_1561a:
	dbra	d6,T_155dc
	moveq	#-1,d0
	jsr	IG_Set_paper
	move.w	#$230,d0
	mulu.w	Nr_of_spells,d0
	jsr	Allocate_memory
	move.l	a1,Text_graphics_buffer
	move.l	#$460,d0
	jsr	Allocate_memory
	movea.l	a1,a6
	moveq	#0,d0
	moveq	#0,d1
	move.w	#$9f,d2
	moveq	#6,d3
	moveq	#3,d4
	move.w	Nr_of_spells,d5
	moveq	#10,d6
	moveq	#7,d7
	movea.l	Text_buffer,a0
	movea.l	Text_graphics_buffer,a1
	lea.l	$5.w,a2
	bra.b	T_1569e
T_15672:
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
	lea.l	$1c(a0),a0
	lea.l	$230(a1),a1
T_1569e:
	dbra	d5,T_15672
	move.w	Nr_of_spells,d0
	mulu.w	#$7,d0
	move.w	d0,Height_of_buffer
	move.w	#$50,Width_of_buffer
	movea.l	a6,a0
	jsr	Free_memory
	movea.l	Text_buffer,a0
	jsr	Free_memory
	lea.l	D_2ddaa,a0
	jsr	Push_PA
	move.w	#$60,Adding
	moveq	#32,d0
	moveq	#40,d1
	moveq	#12,d2
	moveq	#10,d3
	moveq	#2,d4
	moveq	#1,d6
	lea.l	D_2fb6e,a0
	jsr	Open_window
	move.w	d0,SpSelW_handle
	movea.l	Off_screen,a6
	moveq	#48,d0
	moveq	#56,d1
	move.w	d0,d2
	addi.w	#$9f,d2
	move.w	d1,d3
	addi.w	#$6f,d3
	moveq	#3,d6
	jsr	Draw_box
	moveq	#2,d6
	moveq	#16,d7
	move.w	#$30,d0
	move.w	#$a8,d1
	lea.l	D_38060,a0
	jsr	Blot_unmasked_block
	addi.w	#$20,d0
	lea.l	D_38160,a0
	jsr	Blot_unmasked_block
	addi.w	#$60,d0
	lea.l	D_39d60,a0
	jsr	Blot_unmasked_block
	jsr	Switch_screen
	jsr	Copy_screen
; ---- No_spells_known (original source: MAIN/MAGIC.ASM)
No_spells_known:
	rts	
; ---- SpSelW_DisUpd (original source: MAIN/MAGIC.ASM)
SpSelW_DisUpd:
	move.w	Spell_list_pos,d0
	mulu.w	#7,d0
	movea.l	PA_sp,a5
	movea.l	(a5),a5
	movea.l	Off_screen,a6
	jsr	Refresh_text_window
	jsr	Update_status_block	; CHANGE: added
	rts	
; ---- SpSelW_ModExit (original source: MAIN/MAGIC.ASM)
SpSelW_ModExit:
	jsr	Pop_PA
	movea.l	Text_graphics_buffer,a0
	jsr	Free_memory
	move.w	SpSelW_handle,d0
	jsr	Close_window
	rts	
; ---- SpellSelected (original source: MAIN/MAGIC.ASM)
SpellSelected:
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	lsr.w	#8,d0
	subq.w	#1,d0
	add.w	Spell_list_pos,d0
	cmp.w	Nr_of_spells,d0
	bpl.s	.Exit
	lea.l	Spell_table,a0
	mulu.w	#6,d0
	tst.w	2(a0,d0.w)
	beq.s	.Exit
	move.b	1(a0,d0.w),d0
	ext.w	d0
	move.w	d0,Selected_spell
	bsr.w	Pop_Module
.Exit:
	rts	
; ---- ExitSpellSelect (original source: MAIN/MAGIC.ASM)
ExitSpellSelect:
	st	No_spell_selected
	bsr.w	Pop_Module
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	rts	
; ---- SpSel_1Up (original source: MAIN/MAGIC.ASM)
SpSel_1Up:
	moveq.l	#1,d0
	bra.w	T_1585e	; CHANGE: was "jmp SpSel_UP"
; ---- SpSel_1Down (original source: MAIN/MAGIC.ASM)
SpSel_1Down:
	moveq.l	#1,d0
	bra.w	T_15882	; CHANGE: was "jmp SpSel_DOWN"
; ---- SpSel_8Up (original source: MAIN/MAGIC.ASM)
SpSel_8Up:
	moveq.l	#8,d0
	bra.w	T_1585e	; CHANGE: was "jmp SpSel_UP"
T_15810:
	moveq	#8,d0
	bra.w	T_15882
T_15816:
	move.w	Adding,d0
	lsr.w	#$8,d0
	bsr.w	T_1585e
	bra.w	Inc_adding
T_15826:
	move.w	Adding,d0
	lsr.w	#$8,d0
	bsr.w	T_15882
	bra.w	Inc_adding
T_15836:
	move.w	Adding,d0
	lsr.w	#$5,d0
	andi.w	#$fff8,d0
	bsr.w	T_1585e
	bra.w	Inc_adding
T_1584a:
	move.w	Adding,d0
	lsr.w	#$5,d0
	andi.w	#$fff8,d0
	bsr.w	T_15882
	bra.w	Inc_adding
T_1585e:
	tst.b	B_58830
	bne.b	.l_15880
	move.w	Spell_list_pos,d1
	sub.w	d0,d1
	bpl.b	.l_1587a
	moveq	#0,d1
	move.w	#$60,Adding
.l_1587a:
	move.w	d1,Spell_list_pos
.l_15880:
	rts
T_15882:
	tst.b	B_58830
	bne.b	.l_158b6
	move.w	Spell_list_pos,d1
	add.w	d0,d1
	moveq	#16,d2
	add.w	d1,d2
	cmp.w	Nr_of_spells,d2
	bmi.b	.l_158b0
	move.w	Nr_of_spells,d1
	subi.w	#$10,d1
	move.w	#$60,Adding
.l_158b0:
	move.w	d1,Spell_list_pos
.l_158b6:
	rts
; ---- VictimSel_ModInit (original source: MAIN/MAGIC.ASM)
VictimSel_ModInit:
	sf	Victim_selected
	lea.l	Load_area,a0
	jsr	Push_MA
	rts	
; ---- VictimSel_ModExit (original source: MAIN/MAGIC.ASM)
VictimSel_ModExit:
	jsr	Pop_MA
	rts	
; ---- Victim_clicked (original source: MAIN/MAGIC.ASM)
Victim_clicked:
	btst	#1,Mouse_button_state
	bne.s	*-8
; CHANGE: removed "Wait_4_unclick"
	andi.l	#$0000ff00,d0
	beq.s	.Exit
	lsr.w	#8,d0
	lea.l	Chard_ptrs-4,a0
	move.w	d0,d1
	add.w	d1,d1
	add.w	d1,d1
	adda.w	d1,a0
	tst.l	(a0)
	beq.s	.Exit
	move.w	d0,Victim_nr
	move.l	(a0),Victim_ptr
	st	Victim_selected
.Exit:
	bra.w	Pop_Module
; ---- Increase_LP (original source: MAIN/MAGIC.ASM)
Increase_LP:
	movem.l	d1/d2,-(sp)
	move.w	Life_points_normal(a0),d1
	move.w	Life_points_max(a0),d2
	add.w	Life_points_max_magic(a0),d2
	cmp.w	d2,d1
	bpl.s	.Exit
	add.w	d0,d1
	cmp.w	d2,d1
	bmi.s	.Ok
	move.w	d2,d1
.Ok:
	move.w	d1,Life_points_normal(a0)
.Exit:
	movem.l	(sp)+,d1/d2
	rts	
; ---- Do_sparkle (original source: MAIN/MAGIC.ASM)
Do_sparkle:
	move.l	a0,-(sp)
	lea.l	Magic_timers,a0
	move.b	#10,-1(a0,d0.w)
	movea.l	(sp)+,a0
	rts	

	section	bss

SpSelW_handle:
	ds.b	2
Selected_class:
	ds.b	2
Selected_spell:
	ds.b	2
Spell_area_type:
	ds.b	2
B_58822:
	ds.b	2
B_58824:
	ds.b	4
B_58828:
	ds.b	4
Victim_selected:
	ds.b	1
No_spell_selected:
	ds.b	1
Magic_object_flag:
	ds.b	1
B_5882f:
	ds.b	1
B_58830:
	ds.b	1
B_58831:
	ds.b	1
B_58832:
	ds.b	1
B_58833:
	ds.b	1
Victim_nr:
	ds.b	2
Victim_ptr:
	ds.b	4
Added_LP:
	ds.b	2
Condition_nr:
	ds.b	2
B_5883e:
	ds.b	2
Spell_table:
	ds.b	180
Spell_list_pos:
	ds.b	2
Nr_of_spells:
	ds.b	2
Minimap_X:
	ds.b	2
Minimap_Y:
	ds.b	2
Minimap_colour:
	ds.b	2
Minimap_height:
	ds.b	2
Minimap_width:
	ds.b	2
Minimap_ptr:
	ds.b	4
Minimap_update:
	ds.b	2
B_58908:
	ds.b	4
B_5890c:
	ds.b	4
B_58910:
	ds.b	2
B_58912:
	ds.b	4
B_58916:
	ds.b	4
B_5891a:
	ds.b	2
B_5891c:
	ds.b	2
B_5891e:
	ds.b	2
B_58920:
	ds.b	4
B_58924:
	ds.b	48
B_58954:
	ds.b	4
B_58958:
	ds.b	2
B_5895a:
	ds.b	4
B_5895e:
	ds.b	2
B_58960:
	ds.b	2
B_58962:
	ds.b	4
B_58966:
	ds.b	2
B_58968:
	ds.b	72
B_589b0:
	ds.b	18
B_589c2:
	ds.b	18
B_589d4:
	ds.b	2
B_589d6:
	ds.b	2
B_589d8:
	ds.b	2
B_589da:
	ds.b	2
B_589dc:
	ds.b	2
B_589de:
	ds.b	2
B_589e0:
	ds.b	2
B_589e2:
	ds.b	2
B_589e4:
	ds.b	2
B_589e6:
	ds.b	2
B_589e8:
	ds.b	36
B_58a0c:
	ds.b	2
B_58a0e:
	ds.b	48
B_58a3e:
	ds.b	24
B_58a56:
	ds.b	48
B_58a86:
	ds.b	4
B_58a8a:
	ds.b	30
Party_advantage:
	ds.b	1
Monster_advantage:
	ds.b	1
B_58aaa:
	ds.b	1
B_58aab:
	ds.b	1
B_58aac:
	ds.b	1
B_58aad:
	ds.b	1
B_58aae:
	ds.b	2
B_58ab0:
	ds.b	2
B_58ab2:
	ds.b	4
B_58ab6:
	ds.b	1
B_58ab7:
	ds.b	1
B_58ab8:
	ds.b	2
B_58aba:
	ds.b	4
B_58abe:
	ds.b	4
B_58ac2:
	ds.b	4
B_58ac6:
	ds.b	2
B_58ac8:
	ds.b	36
B_58aec:
	ds.b	2
B_58aee:
	ds.b	874
B_58e58:
	ds.b	2
B_58e5a:
	ds.b	4
B_58e5e:
	ds.b	2
B_58e60:
	ds.b	2
B_58e62:
	ds.b	4
B_58e66:
	ds.b	4
B_58e6a:
	ds.b	2
B_58e6c:
	ds.b	2
B_58e6e:
	ds.b	2
B_58e70:
	ds.b	2
B_58e72:
	ds.b	1
B_58e73:
	ds.b	1
B_58e74:
	ds.b	2
B_58e76:
	ds.b	2
B_58e78:
	ds.b	2
B_58e7a:
	ds.b	2
B_58e7c:
	ds.b	48
B_58eac:
	ds.b	4
; The song which is played (see Play_song).
Current_song:
	ds.b	2
Magic_anim_counter:
	ds.b	2
Char_damage:
	ds.b	12
B_58ec0:
	ds.b	1
B_58ec1:
	ds.b	5
Magic_timers:
	ds.b	6
Char_status_icons:
	ds.b	6
Current_active_char_data:
	ds.b	4
Nr_of_modifications:
	ds.b	2
Modifications_ptr:
	ds.b	1028
First:
	ds.b	1
B_592dd:
	ds.b	1
B_592de:
	ds.b	2
B_592e0:
	ds.b	2
ReqText_nr:
	ds.b	2
ReqDo_ptr:
	ds.b	4
B_592e8:
	ds.b	2
B_592ea:
	ds.b	32
B_5930a:
	ds.b	2
B_5930c:
	ds.b	6
B_59312:
	ds.b	6
Month:
	ds.b	2
Day:
	ds.b	2
Hour:
	ds.b	2
Minute:
	ds.b	2
Map_Xcoord:
	ds.b	2
Map_Ycoord:
	ds.b	2
View_direction:
	ds.b	1
B_59325:
	ds.b	1
Spell_1_duration:
	ds.b	2
Spell_2_duration:
	ds.b	2
Spell_3_duration:
	ds.b	2
Spell_4_duration:
	ds.b	2
Spell_5_duration:
	ds.b	2
Spell_6_duration:
	ds.b	2
Nr_members:
	ds.b	2
Active_member:
	ds.b	2
Travel_mode:
	ds.b	2
Special_item_flags:
	ds.b	1
B_59339:
	ds.b	1
Music_block:
	ds.b	2
Spell_1_data:
	ds.b	2
Spell_2_data:
	ds.b	2
Spell_3_data:
	ds.b	2
Spell_4_data:
	ds.b	2
Spell_5_data:
	ds.b	2
Spell_6_data:
	ds.b	2
Year:
	ds.b	2
Map_nr:
	ds.b	2
Member_1_nr:
	ds.b	2
B_5934e:
	ds.b	10
Nr_travelled_days:
	ds.b	2
Time_data_year:
	ds.b	2
Trans_T:
	ds.b	150
Quest:
	ds.b	32
B_59412:
	ds.b	4061
B_5a3ef:
	ds.b	3
CD:
	ds.b	1502
WD:
	ds.b	626
Chest:
	ds.b	1500
Chest_gold:
	ds.b	1988
B_5b9e2:
	ds.b	1212
B_5be9e:
	ds.b	6
B_5bea4:
	ds.b	4
B_5bea8:
	ds.b	4
B_5beac:
	ds.b	4100
B_5ceb0:
	ds.b	256
Icondata_ptr:
	ds.b	4
Labblock_ptrs:
	ds.b	200
Ceiling_ptr:
	ds.b	4
Floor_ptr:
	ds.b	4
Colpall_ptrs:
	ds.b	4
Mapd_ptr:
	ds.b	4
Dictionary_ptr:
	ds.b	4
Maptext_ptr:
	ds.b	4
Pic80_ptr:
	ds.b	4
Pic80pal_ptr:
	ds.b	4
Chestdata_ptr:
	ds.b	4
B_5d0a0:
	ds.b	4
B_5d0a4:
	ds.b	4
Waredat_ptr:
	ds.b	4
Codetxt_ptr:
	ds.b	4
Chard_ptrs:
	ds.b	4
B_5d0b4:
	ds.b	16
B_5d0c4:
	ds.b	4
B_5d0c8:
	ds.b	32
