; MAIN/MAGIC.ASM (original module, merged with the disassembly of the shipped program)

Do_magic:
	tst.b	Battling
	bne.b	T_137ec
	bsr.w	T_13852
	bra.b	T_13850
T_137ec:
	tst.b	Magic_object_flag
	beq.b	T_13826
	move.w	Active_member,B_5b870
	movea.l	Current_inventory_chardat_ptr,a1
	move.l	a1,Current_active_char_data
	lea.l	Chard_ptrs,a0
	moveq	#1,d0
	moveq	#5,d7
T_13814:
	cmpa.l	(a0)+,a1
	beq.b	T_13820
	addq.w	#$1,d0
	dbra	d7,T_13814
	moveq	#0,d0
T_13820:
	move.w	d0,Active_member
T_13826:
	bsr.w	T_18730
	tst.b	Magic_object_flag
	beq.b	T_13850
	move.w	B_5b870,d0
	move.w	d0,Active_member
	lea.l	Chard_ptrs,a0
	add.w	d0,d0
	add.w	d0,d0
	move.l	-$4(a0,d0.w),Current_active_char_data
T_13850:
	rts
T_13852:
	movem.l	d0-d7/a0-a6,-(a7)
	tst.b	No_spell_selected
	beq.b	T_13866
	sf.b	No_spell_selected
	bra.b	T_138b6
T_13866:
	lea.l	D_4b42e,a0
	move.w	Selected_class,d0
	mulu.w	#$78,d0
	adda.w	d0,a0
	move.w	Selected_spell,d0
	add.w	d0,d0
	add.w	d0,d0
	adda.w	d0,a0
	move.l	a0,B_5b856
	lea.l	T_138bc,a0
	move.w	Selected_class,d0
	add.w	d0,d0
	add.w	d0,d0
	move.l	-$4(a0,d0.w),d0
	beq.b	T_138b6
	movea.l	d0,a0
	move.w	Selected_spell,d0
	add.w	d0,d0
	add.w	d0,d0
	move.l	-$4(a0,d0.w),d0
	beq.b	T_138b6
	movea.l	d0,a0
	jsr	(a0)
T_138b6:
	movem.l	(a7)+,d0-d7/a0-a6
	rts
T_138bc:
	dc.l	T_138d8
	dc.l	T_13948
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.l	T_139b0
T_138d8:
	dc.l	Heal_1
	dc.l	Heal_2
	dc.l	Heal_3
	dc.l	Heal_4
	dc.l	Heal_5
	dc.l	T_13bd2
	dc.l	T_13c14
	dc.l	T_13c98
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
T_13948:
	dc.l	Light_1
	dc.l	Light_2
	dc.l	Light_3
	dc.l	Armour_1
	dc.l	Armour_2
	dc.l	Armour_3
	dc.l	Weapon_1
	dc.l	T_140c0
	dc.l	T_140d8
	dc.l	T_140f0
	dc.l	T_14108
	dc.l	T_14120
	dc.l	T_14138
	dc.l	T_14150
	dc.l	T_14168
	dc.l	T_14180
	dc.l	T_14198
	dc.l	T_141b0
	dc.l	Magic_sphere
	dc.l	T_14230
	dc.l	Identify
	dc.l	T_14434
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00
	dc.l	T_144de
	dc.l	T_145e6
T_139b0:
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.l	Map_view
	dc.b	$00,$00,$00,$00
	dc.l	Spellpts1
	dc.l	Spellpts2
	dc.l	T_14d9c
	dc.l	Youth
	dc.b	$00,$00,$00,$00
	dc.l	T_150aa
	dc.l	T_152fe
Handle_spell:
	movem.l	d0-d1/a0-a1,-(a7)
	tst.b	Magic_object_flag
	beq.b	T_13a74
	move.w	Active_member,B_5b870
	movea.l	Current_inventory_chardat_ptr,a1
	move.l	a1,Current_active_char_data
	lea.l	Chard_ptrs,a0
	moveq	#1,d0
	moveq	#5,d7
T_13a2c:
	cmpa.l	(a0)+,a1
	beq.b	T_13a38
	addq.w	#$1,d0
	dbra	d7,T_13a2c
	moveq	#0,d0
T_13a38:
	move.w	d0,Active_member
	tst.b	B_5b865
	beq.b	T_13a4e
	sf.b	B_5b865
	bra.b	T_13a6a
T_13a4e:
	move.l	Current_active_char_data,B_5b840
	move.b	Object_slot_number,d0
	ext.w	d0
	move.w	d0,B_5b83e
	bsr.w	T_12042
T_13a6a:
	sf.b	B_5b861
	moveq	#0,d0
	bra.b	T_13acc
T_13a74:
	movea.l	B_5b856,a0
	movea.l	Current_active_char_data,a1
	move.b	$1(a0),d0
	ext.w	d0
	move.w	$8a(a1),d1
	sub.w	d0,d1
	bpl.b	T_13a90
	moveq	#0,d1
T_13a90:
	move.w	d1,$8a(a1)
	moveq	#0,d0
	move.b	$f(a1),d0
	add.w	$c2(a1),d0
	jsr	Probe
	smi.b	B_5b861
	bpl.b	T_13acc
	movea.l	Textfile_ptr,a0
	move.l	#Code0006Sys,Textfile_ptr
	moveq	#24,d0
	jsr	T_0a220
	move.l	a0,Textfile_ptr
	moveq	#-1,d0
T_13acc:
	move.w	sr,-(a7)
	tst.b	Magic_object_flag
	beq.b	T_13af4
	move.w	B_5b870,d0
	move.w	d0,Active_member
	lea.l	Chard_ptrs,a0
	add.w	d0,d0
	add.w	d0,d0
	move.l	-$4(a0,d0.w),Current_active_char_data
T_13af4:
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
T_13bd2:
	bsr.w	Handle_spell
	bmi.b	T_13c12
	lea.l	Chard_ptrs,a1
	moveq	#1,d7
T_13be0:
	tst.l	(a1)
	beq.b	T_13c08
	movea.l	(a1),a0
	move.w	#$e000,d1
	and.w	$3a(a0),d1
	bne.b	T_13c08
	jsr	Random
	mulu.w	#$10,d0
	swap	d0
	addq.w	#$4,d0
	bsr.w	Increase_LP
	move.w	d7,d0
	bsr.w	Do_sparkle
T_13c08:
	addq.l	#$4,a1
	addq.w	#$1,d7
	cmpi.w	#$7,d7
	bmi.b	T_13be0
T_13c12:
	rts
T_13c14:
	movea.l	Textfile_ptr,a0
	move.l	#Code0007Sys,Textfile_ptr
	move.w	#$2,WText_nr
	lea.l	TxtW_Mod,a0
	bsr.w	Push_Module
	move.l	a0,Textfile_ptr
	lea.l	VictimSel_Mod,a0
	move.l	#T_13c4e,$28(a0)
	bra.w	Push_Module
T_13c4e:
	bsr.w	Pop_Module
	tst.b	Victim_selected
	beq.b	T_13c96
	movea.l	Victim_ptr,a0
	move.b	$3a(a0),d0
	btst	#$5,d0
	beq.b	T_13c96
	bclr	#$5,d0
	bsr.w	Handle_spell
	bmi.b	T_13c84
	move.b	d0,$3a(a0)
	move.w	Victim_nr,d0
	bsr.w	Resurrection
	bra.b	T_13c8c
T_13c84:
	dc.b	$08,$c0,$00,$06,$11,$40,$00,$3a
T_13c8c:
	move.w	Victim_nr,d0
	bsr.w	Do_sparkle
T_13c96:
	rts
T_13c98:
	movea.l	Textfile_ptr,a0
	move.l	#Code0007Sys,Textfile_ptr
	move.w	#$3,WText_nr
	lea.l	TxtW_Mod,a0
	bsr.w	Push_Module
	move.l	a0,Textfile_ptr
	lea.l	VictimSel_Mod,a0
	move.l	#T_13cd2,$28(a0)
	bra.w	Push_Module
T_13cd2:
	bsr.w	Pop_Module
	tst.b	Victim_selected
	beq.b	T_13d20
	movea.l	Victim_ptr,a0
	move.b	$3a(a0),d0
	btst	#$6,d0
	beq.b	T_13d20
	bclr	#$6,d0
	bsr.w	Handle_spell
	bmi.b	T_13d08
	move.b	d0,$3a(a0)
	move.w	Victim_nr,d0
	bsr.w	Resurrection
	bra.b	T_13d10
T_13d08:
	dc.b	$08,$c0,$00,$07,$11,$40,$00,$3a
T_13d10:
	move.w	Victim_nr,d0
	bsr.w	Do_sparkle
	jsr	Force_char_update
T_13d20:
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
	move.l	#T_13d5c,$28(a0)
	bra.w	Push_Module
T_13d5c:
	bsr.w	Pop_Module
	tst.b	Victim_selected
	beq.b	T_13d9a
	movea.l	Victim_ptr,a0
	move.b	$3a(a0),d0
	btst	#$7,d0
	beq.b	T_13d9a
	bsr.w	Handle_spell
	bmi.b	T_13d9a
	bclr	#$7,d0
	move.b	d0,$3a(a0)
	move.w	Victim_nr,d0
	bsr.w	Resurrection
	bsr.w	Do_sparkle
	jsr	Force_char_update
T_13d9a:
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
	bne.b	T_13f1c
	bsr.w	Inv2_DisExit
T_13f1c:
	rts
T_13f1e:
	btst	#$1,Mouse_button_state
	bne.b	T_13f1e
	tst.b	d0
	beq.w	T_13fc8
	move.b	d0,Object_slot_number
	ext.w	d0
	subq.w	#$1,d0
	movea.l	Current_inventory_chardat_ptr,a0
	lea.l	$22(a0),a1
	adda.w	d0,a1
	tst.b	(a1)
	beq.w	T_13fc8
	lea.l	$132(a0),a2
	mulu.w	#$28,d0
	adda.w	d0,a2
	btst	#$0,$18(a2)
	beq.b	T_13fc8
	bsr.w	Handle_spell
	bmi.b	T_13fb2
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
	lea.l	D_30bf0,a3
	add.w	d0,d0
	add.w	d0,d0
	move.w	$2(a3,d0.w),d1
	move.w	(a3,d0.w),d0
	bsr.w	Show_item_destruction
	moveq	#50,d0
	jsr	Delay
T_13fb2:
	bsr.w	Pop_Module
	jsr	Mouse_on
	tst.b	Magic_object_flag
	bne.b	T_13fc8
	bsr.w	Init_display
T_13fc8:
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
T_140c0:
	bsr.w	Handle_spell
	bmi.b	T_140d6
	move.w	#$a,Spell_3_data
	move.w	#$60,Spell_3_duration
T_140d6:
	rts
T_140d8:
	bsr.w	Handle_spell
	bmi.b	T_140ee
	move.w	#$f,Spell_3_data
	move.w	#$c0,Spell_3_duration
T_140ee:
	rts
T_140f0:
	bsr.w	Handle_spell
	bmi.b	T_14106
	move.w	#$5,Spell_4_data
	move.w	#$18,Spell_4_duration
T_14106:
	rts
T_14108:
	bsr.w	Handle_spell
	bmi.b	T_1411e
	move.w	#$a,Spell_4_data
	move.w	#$60,Spell_4_duration
T_1411e:
	rts
T_14120:
	bsr.w	Handle_spell
	bmi.b	T_14136
	move.w	#$f,Spell_4_data
	move.w	#$c0,Spell_4_duration
T_14136:
	rts
T_14138:
	bsr.w	Handle_spell
	bmi.b	T_1414e
	move.w	#$2,Spell_5_data
	move.w	#$18,Spell_5_duration
T_1414e:
	rts
T_14150:
	bsr.w	Handle_spell
	bmi.b	T_14166
	move.w	#$4,Spell_5_data
	move.w	#$60,Spell_5_duration
T_14166:
	rts
T_14168:
	bsr.w	Handle_spell
	bmi.b	T_1417e
	move.w	#$6,Spell_5_data
	move.w	#$c0,Spell_5_duration
T_1417e:
	rts
T_14180:
	bsr.w	Handle_spell
	bmi.b	T_14196
	move.w	#$0,Spell_6_data
	move.w	#$18,Spell_6_duration
T_14196:
	rts
T_14198:
	bsr.w	Handle_spell
	bmi.b	T_141ae
	move.w	#$0,Spell_6_data
	move.w	#$60,Spell_6_duration
T_141ae:
	rts
T_141b0:
	bsr.w	Handle_spell
	bmi.b	T_141c6
	move.w	#$0,Spell_6_data
	move.w	#$c0,Spell_6_duration
T_141c6:
	rts
Magic_sphere:
	bsr.w	Handle_spell
	bmi.b	T_1422e
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
T_1422e:
	rts
T_14230:
	bsr.w	Handle_spell
	bmi.b	T_14240
	lea.l	MagicCompass_Mod,a0
	bsr.w	Push_Module
T_14240:
	rts
MagicComp_DisInit:
	moveq	#48,d0
	moveq	#64,d1
	moveq	#4,d2
	moveq	#4,d3
	moveq	#1,d6
	suba.l	a0,a0
	jsr	Open_window
	move.w	d0,B_5b288
	lea.l	D_35eea,a0
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
	move.w	B_5b288,d0
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
T_14308:
	tst.b	Magic_object_flag
	beq.b	T_14320
	st.b	Fade_block
	move.l	Current_inventory_chardat_ptr,B_5b844
T_14320:
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
	lea.l	D_30cc8,a0
	jsr	Push_MA
	rts
T_1436e:
	btst	#$1,Mouse_button_state
	bne.b	T_1436e
	tst.b	d0
	beq.w	T_14432
	ext.w	d0
	addi.w	#$9,d0
	bra.b	T_14398
T_14386:
	btst	#$1,Mouse_button_state
	bne.b	T_14386
	tst.b	d0
	beq.w	T_14432
	ext.w	d0
T_14398:
	btst	#$1,Mouse_button_state
	bne.b	T_14398
	tst.b	d0
	beq.b	T_14422
	move.b	d0,B_5b864
	ext.w	d0
	subq.w	#$1,d0
	movea.l	Current_inventory_chardat_ptr,a0
	lea.l	$22(a0),a1
	adda.w	d0,a1
	tst.b	(a1)
	beq.b	T_14432
	lea.l	$132(a0),a2
	mulu.w	#$28,d0
	adda.w	d0,a2
	btst	#$7,$18(a2)
	bne.b	T_14432
	tst.b	Magic_object_flag
	beq.b	T_143e4
	bsr.w	T_14f02
	st.b	B_5b865
T_143e4:
	bsr.w	Handle_spell
	bmi.b	T_14432
	bset	#$7,$18(a2)
	moveq	#0,d0
	move.b	B_5b864,d0
	moveq	#0,d2
	move.b	(a2),d2
	bsr.w	T_1212a
	move.b	B_5b864,Object_slot_number
	lea.l	D_2b13c,a0
	move.l	#T_1441c,$28(a0)
	bra.w	Push_Module
T_1441c:
	dc.b	$42,$b9
	dc.l	D_2b164
T_14422:
	bsr.w	Pop_Module
	tst.b	Magic_object_flag
	bne.b	T_14432
	bsr.w	Init_display
T_14432:
	rts
T_14434:
	move.w	Map_Xcoord,d0
	move.w	Map_Ycoord,d1
	jsr	Find_event
	beq.b	T_1445e
	cmpi.b	#$5,(a5)
	bne.b	T_1445e
	tst.b	$3(a5)
	bne.b	T_1445e
	bsr.w	Handle_spell
	bmi.w	Exit_levitate
	bra.b	T_1449c
T_1445e:
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
T_1449c:
	tst.b	Magic_object_flag
	beq.b	Do_levitate
	bsr.w	Pop_Module
	bsr.w	T_10f3c
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
T_144de:
	cmpi.b	#$1,Current_map_type
	bne.b	T_14528
	bsr.w	Handle_spell
	bmi.b	T_14528
	move.w	View_direction,d0
	add.w	d0,d0
	add.w	d0,d0
	movea.l	T_1452a(pc,d0.w),a1
	move.w	Map_Xcoord,d0
	move.w	Map_Ycoord,d1
	movea.l	Map_pointer,a0
	jsr	(a1)
	move.w	d0,Map_Xcoord
	move.w	d1,Map_Ycoord
	jsr	Exit_map
	jsr	Init_map
T_14528:
	rts
T_1452a:
	dc.l	T_1453a
	dc.l	T_14556
	dc.l	T_14576
	dc.l	T_14596
T_1453a:
	subi.w	#$15,d1
T_1453e:
	addq.w	#$1,d1
	cmp.w	Map_Ycoord,d1
	beq.b	T_14554
	cmpi.w	#$1,d1
	bmi.b	T_1453e
	bsr.w	T_145b2
	bmi.b	T_1453e
T_14554:
	rts
T_14556:
	addi.w	#$15,d0
	move.w	Width_of_map,d2
T_14560:
	subq.w	#$1,d0
	cmp.w	Map_Xcoord,d0
	beq.b	T_14574
	cmp.w	d0,d2
	bmi.b	T_14560
	bsr.w	T_145b2
	bmi.b	T_14560
T_14574:
	rts
T_14576:
	addi.w	#$15,d1
	move.w	Height_of_map,d2
T_14580:
	subq.w	#$1,d1
	cmp.w	Map_Ycoord,d1
	beq.b	T_14594
	cmp.w	d1,d2
	bmi.b	T_14580
	bsr.w	T_145b2
	bmi.b	T_14580
T_14594:
	rts
T_14596:
	subi.w	#$15,d0
T_1459a:
	addq.w	#$1,d0
	cmp.w	Map_Xcoord,d0
	beq.b	T_145b0
	cmpi.w	#$1,d0
	bmi.b	T_1459a
	bsr.w	T_145b2
	bmi.b	T_1459a
T_145b0:
	rts
T_145b2:
	movem.l	d0-d1/a0,-(a7)
	subq.w	#$1,d0
	subq.w	#$1,d1
	mulu.w	Width_of_map,d1
	add.w	d1,d0
	move.b	(a0,d0.w),d0
	lea.l	T_145de(pc),a0
T_145ca:
	move.b	(a0)+,d1
	beq.b	T_145d6
	cmp.b	d0,d1
	bne.b	T_145ca
	moveq	#0,d0
	bra.b	T_145d8
T_145d6:
	dc.b	$70,$ff
T_145d8:
	movem.l	(a7)+,d0-d1/a0
	rts
T_145de:
	dc.b	$02,$03,$12,$13,$14,$15,$23,$00
T_145e6:
	cmpi.b	#$2,Current_map_type
	bpl.b	T_1460e
	bsr.w	Handle_spell
	bmi.b	T_1460e
	move.w	B_5c33e,d0
	addi.w	#$a,d0
	bvs.b	T_1460e
	move.w	d0,B_5c33e
	sf.b	D_1e1fc
T_1460e:
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
	lea.l	D_31730,a0
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
	bpl.b	T_14a52
	movea.l	Icondata_ptr,a0
	lea.l	$7d2(a0),a0
	bra.b	T_14a58
T_14a52:
	movea.l	Colpall_ptrs,a0
T_14a58:
	lea.l	Pal_buffer,a1
	jsr	IFF_pal_convert
	lea.l	Subfade1,a2
T_14a6a:
	lea.l	Hbl_2D_map,a0
	jsr	Update_HBL
	jsr	My_vsync
	jsr	My_vsync
	lea.l	Below_pal_2D,a0
	jsr	Fade_pal
	bne.b	T_14a6a
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
T_14d9c:
	movea.l	Textfile_ptr,a0
	move.l	#Code0006Sys,Textfile_ptr
	move.w	#$19,WText_nr
	lea.l	TxtW_Mod,a0
	bsr.w	Push_Module
	move.l	a0,Textfile_ptr
	lea.l	VictimSel_Mod,a0
	move.l	#T_14dd6,$28(a0)
	bra.w	Push_Module
T_14dd6:
	bsr.w	Pop_Module
	tst.b	Victim_selected
	beq.b	T_14dec
	lea.l	Gunk_Mod,a0
	bsr.w	Push_Module
T_14dec:
	rts
T_14dee:
	st.b	Fade_block
	move.l	Current_inventory_chardat_ptr,B_5b844
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
	lea.l	D_30cc8,a0
	jsr	Push_MA
	rts
T_14e4c:
	btst	#$1,Mouse_button_state
	bne.b	T_14e4c
	tst.b	d0
	beq.w	T_14f00
	ext.w	d0
	addi.w	#$9,d0
	bra.b	T_14e76
T_14e64:
	btst	#$1,Mouse_button_state
	bne.b	T_14e64
	tst.b	d0
	beq.w	T_14f00
	ext.w	d0
T_14e76:
	btst	#$1,Mouse_button_state
	bne.b	T_14e76
	move.b	d0,B_5b864
	subq.w	#$1,d0
	movea.l	Current_inventory_chardat_ptr,a0
	lea.l	$22(a0),a1
	adda.w	d0,a1
	tst.b	(a1)
	beq.b	T_14f00
	lea.l	$132(a0),a2
	mulu.w	#$28,d0
	adda.w	d0,a2
	cmpi.b	#$4,$1(a2)
	beq.b	T_14eb2
	cmpi.b	#$5,$1(a2)
	bne.b	T_14f00
T_14eb2:
	bsr.w	T_14f02
	jsr	Random
	mulu.w	#$4,d0
	swap	d0
	addq.w	#$1,d0
	moveq	#0,d1
	move.b	$11(a2),d1
	add.w	d0,d1
	cmpi.w	#$80,d1
	bmi.b	T_14ed4
	moveq	#127,d1
T_14ed4:
	move.b	d1,$11(a2)
	moveq	#0,d1
	move.b	$1f(a0),d1
	add.w	d0,d1
	cmpi.w	#$80,d1
	bmi.b	T_14ee8
	moveq	#127,d1
T_14ee8:
	move.b	d1,$1f(a0)
	moveq	#0,d0
	move.b	B_5b864,d0
	moveq	#0,d2
	move.b	(a2),d2
	bsr.w	T_1212a
	bsr.w	Pop_Module
T_14f00:
	rts
T_14f02:
	movem.l	d0-d1/a0-a2/a6,-(a7)
	movea.l	B_5b844,a0
	lea.l	$21(a0),a1
	lea.l	$10a(a0),a2
	move.b	Object_slot_number,d0
	ext.w	d0
	adda.w	d0,a1
	mulu.w	#$28,d0
	adda.w	d0,a2
	btst	#$2,$18(a2)
	bne.b	T_14f3c
	cmpi.b	#$ff,$e(a2)
	beq.w	T_14ff8
	subq.b	#$1,$e(a2)
	bne.b	T_14fb0
T_14f3c:
	moveq	#0,d0
	move.w	$22(a2),d0
	sub.l	d0,$ec(a0)
	subq.b	#$1,(a1)
	cmpi.b	#$a,Object_slot_number
	bpl.b	T_14fb0
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
	bne.b	T_14fac
	bsr.w	Negative_boni
	bra.b	T_14fb0
T_14fac:
	bsr.w	Positive_boni
T_14fb0:
	cmpa.l	Current_inventory_chardat_ptr,a0
	bne.b	T_14ff8
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
	bsr.w	T_1212a
	tst.b	(a1)
	bne.b	T_14ff8
	move.b	Object_slot_number,d0
	movea.l	Off_screen,a6
	bsr.w	INV2_Erase_object
	jsr	Switch_screen
	jsr	Copy_screen
T_14ff8:
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
	bpl.b	.c_1506c	; CHANGE: was "bmi.s .Exit"
	moveq	#15,d1	; CHANGE: added
.c_1506c:
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
T_150aa:
	tst.w	Travel_mode
	bne.b	T_150da
	bsr.w	Handle_spell
	bmi.b	T_150da
	tst.b	Magic_object_flag
	beq.b	T_150c8
	bsr.w	Pop_Module
	bsr.w	T_10f3c
T_150c8:
	lea.l	D_30462,a0
	bsr.w	Push_Module
	moveq	#5,d0
	jsr	Set_new_travel_mode
T_150da:
	rts
T_150dc:
	jsr	Switch_screen
	move.w	#$0,Draw_Cicon
	jsr	Switch_screen
	jsr	Mouse_off
	jsr	Copy_screen
	move.l	#$3180,d0
	jsr	Allocate_memory
	move.l	a1,B_5b85a
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
	lea.l	D_30df6,a0
	add.w	d0,d0
	adda.w	d0,a0
	move.w	(a0)+,d3
	move.w	(a0)+,d4
	moveq	#3,d5
	btst	#$0,d2
	beq.b	T_1515a
	addq.w	#$1,d5
T_1515a:
	add.w	d5,d5
	addq.w	#$1,d5
T_1515e:
	move.w	#$10,d0
	move.w	#$31,d1
	move.w	#$b,d6
	move.w	#$90,d7
	movea.l	B_5b85a,a0
	movea.l	Off_screen,a6
	jsr	Blot_unmasked_block
	move.w	d3,d0
	move.w	d4,d1
	bsr.w	T_152d4
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
	dbra	d5,T_1515e
	jsr	Copy_screen
	jsr	Mouse_on
	movea.l	B_5b85a,a0
	jsr	Free_memory
	bra.w	Pop_Module
T_151d2:
	jsr	Switch_screen
	move.w	#$0,Draw_Cicon
	jsr	Switch_screen
	jsr	Mouse_off
	jsr	Copy_screen
	move.l	#$3180,d0
	jsr	Allocate_memory
	move.l	a1,B_5b85a
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
	beq.b	T_1524a
	addq.w	#$1,d5
T_1524a:
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
T_15260:
	move.w	#$10,d0
	move.w	#$31,d1
	move.w	#$b,d6
	move.w	#$90,d7
	movea.l	B_5b85a,a0
	movea.l	Off_screen,a6
	jsr	Blot_unmasked_block
	move.w	d3,d0
	move.w	d4,d1
	bsr.w	T_152d4
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
	dbra	d5,T_15260
	jsr	Copy_screen
	jsr	Mouse_on
	movea.l	B_5b85a,a0
	jsr	Free_memory
	bra.w	Pop_Module
T_152d4:
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
T_152fe:
	bsr.w	Handle_spell
	bmi.b	T_1530e
	lea.l	D_307ce,a0
	bsr.w	Push_Module
T_1530e:
	rts
T_15310:
	move.w	#$10,d0
	move.w	#$40,d1
	move.w	#$e,d2
	move.w	#$7,d3
	moveq	#1,d6
	lea.l	D_32900,a0
	jsr	Open_window
	move.w	d0,B_5b854
	lea.l	D_30d1c,a0
	jsr	Push_PA
	bra.w	T_15372
T_15344:
	move.w	B_5b854,d0
	jsr	Close_window
	jsr	Pop_PA
	rts
T_15358:
	btst	#$1,Mouse_button_state
	bne.b	T_15358
	lsr.w	#$8,d0
	beq.b	T_15370
	jsr	T_00f12
	bsr.w	T_15372
T_15370:
	rts
T_15372:
	movea.l	Off_screen,a6
	lea.l	D_30e06,a1
	move.w	#$20,d2
	move.w	#$55,d3
	moveq	#1,d4
	move.w	B_5bee2,d5
	moveq	#9,d7
T_15390:
	move.w	d2,d0
	move.w	d3,d1
	jsr	IG_Set_cursor
	moveq	#15,d0
	cmp.w	d4,d5
	bne.b	T_153a2
	moveq	#1,d0
T_153a2:
	jsr	IG_Set_ink
	movea.l	(a1)+,a0
	jsr	IG_Print
	jsr	IG_Carriage_return
	addq.w	#$7,d3
	addq.w	#$1,d4
	dbra	d7,T_15390
	addi.w	#$60,d2
	move.w	#$55,d3
	moveq	#8,d7
T_153c8:
	move.w	d2,d0
	move.w	d3,d1
	jsr	IG_Set_cursor
	moveq	#15,d0
	cmp.w	d4,d5
	bne.b	T_153da
	moveq	#1,d0
T_153da:
	jsr	IG_Set_ink
	movea.l	(a1)+,a0
	jsr	IG_Print
	jsr	IG_Carriage_return
	addq.w	#$7,d3
	addq.w	#$1,d4
	dbra	d7,T_153c8
	jsr	Switch_screen
	jsr	Copy_screen
	rts
SCSelW_DisInit:
	move.w	#$10,d0
	move.w	#$40,d1
	move.w	#$a,d2
	move.w	#$5,d3
	moveq	#1,d6
	lea.l	D_32a68,a0
	jsr	Open_window
	move.w	d0,B_5b84a
	lea.l	D_30d28,a0
	jsr	Push_PA
	movea.l	Off_screen,a6
	moveq	#1,d1
	movea.l	Current_active_char_data,a0
	move.b	$1a(a0),d2
	lea.l	D_4b7f2,a1
	moveq	#6,d7
T_1544e:
	btst	d1,d2
	beq.b	T_15464
	move.w	(a1),d0
	bsr.w	Get_word
	lea.l	Line_buffer,a0
	jsr	IG_Print
T_15464:
	jsr	IG_Carriage_return
	addq.w	#$1,d1
	addq.l	#$2,a1
	dbra	d7,T_1544e
	jsr	Switch_screen
	jsr	Copy_screen
	rts
SCSelW_DisExit:
	move.w	B_5b84a,d0
	jsr	Close_window
	jsr	Pop_PA
	rts
T_15494:
	btst	#$1,Mouse_button_state
	bne.b	T_15494
	lsr.w	#$8,d0
	movea.l	Current_active_char_data,a0
	btst	d0,$1a(a0)
	beq.b	T_154d6
	move.w	d0,Selected_class
	bsr.w	Pop_Module
	lea.l	$d0(a0),a0
	add.w	d0,d0
	add.w	d0,d0
	tst.l	-$4(a0,d0.w)
	bne.b	T_154cc
	st.b	No_spell_selected
	bra.b	T_154d6
T_154cc:
	lea.l	SpSelW_Mod,a0
	bsr.w	Push_Module
T_154d6:
	rts
T_154d8:
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
	lea.l	D_4b4aa,a1
	move.w	Selected_class,d0
	subq.w	#$1,d0
	mulu.w	#$78,d0
	adda.w	d0,a1
	lea.l	$d0(a0),a0
	move.w	Selected_class,d0
	add.w	d0,d0
	add.w	d0,d0
	move.l	-$4(a0,d0.w),d3
	lea.l	D_30d0e,a0
	move.w	Selected_class,d7
	add.w	d7,d7
	move.w	-$2(a0,d7.w),d7
	lea.l	D_4b800,a2
	move.w	Selected_class,d0
	subq.w	#$1,d0
	mulu.w	#$3c,d0
	adda.w	d0,a2
	lea.l	Spell_table,a0
	bra.b	T_15596
T_15556:
	btst	d2,d3
	beq.b	T_15590
	addq.w	#$1,d1
	moveq	#0,d5
	move.b	(a1),d0
	btst	d4,d0
	bne.b	T_15568
	moveq	#1,d0
	bra.b	T_15588
T_15568:
	moveq	#0,d0
	move.b	$1(a1),d0
	beq.b	T_15574
	cmp.w	d0,d6
	bpl.b	T_15578
T_15574:
	moveq	#2,d0
	bra.b	T_15588
T_15578:
	moveq	#0,d5
	move.w	d6,d5
	divu.w	d0,d5
	cmpi.w	#$64,d5
	bmi.b	T_15586
	moveq	#99,d5
T_15586:
	moveq	#15,d0
T_15588:
	move.b	d0,(a0)+
	move.b	d2,(a0)+
	move.w	d5,(a0)+
	move.w	(a2),(a0)+
T_15590:
	addq.w	#$1,d2
	addq.l	#$4,a1
	addq.l	#$2,a2
T_15596:
	dbra	d7,T_15556
	move.w	d1,Nr_of_spells
	cmpi.w	#$11,d1
	smi.b	B_5b862
	moveq	#28,d0
	mulu.w	d1,d0
	jsr	Allocate_memory
	move.l	a1,Text_buffer
	movea.l	a1,a0
	lsr.w	#$2,d0
	subq.w	#$1,d0
	move.l	#$20202020,d1
T_155c6:
	move.l	d1,(a0)+
	dbra	d0,T_155c6
	lea.l	Spell_table,a2
	moveq	#32,d1
	moveq	#2,d7
	move.w	Nr_of_spells,d6
	bra.b	T_1561c
T_155de:
	movea.l	a1,a3
	move.b	#$1,(a3)+
	move.b	(a2),(a3)+
	move.w	$4(a2),d0
	jsr	Find_word
	moveq	#0,d0
	move.b	(a0)+,d0
	subq.w	#$1,d0
	bra.b	T_155fa
T_155f8:
	move.b	(a0)+,(a3)+
T_155fa:
	dbra	d0,T_155f8
	move.w	$2(a2),d0
	beq.b	T_15614
	lea.l	$17(a1),a3
	move.b	#$28,(a3)+
	bsr.w	RConvert_number
	move.b	#$29,(a3)
T_15614:
	lea.l	$1b(a1),a1
	clr.b	(a1)+
	addq.l	#$6,a2
T_1561c:
	dbra	d6,T_155de
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
	bra.b	T_156a0
T_15674:
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
T_156a0:
	dbra	d5,T_15674
	move.w	Nr_of_spells,d0
	mulu.w	#$7,d0
	move.w	d0,Height_of_buffer
	move.w	#$50,Width_of_buffer
	movea.l	a6,a0
	jsr	Free_memory
	movea.l	Text_buffer,a0
	jsr	Free_memory
	lea.l	D_30d34,a0
	jsr	Push_PA
	move.w	#$60,Adding
	moveq	#32,d0
	moveq	#40,d1
	moveq	#12,d2
	moveq	#10,d3
	moveq	#2,d4
	moveq	#1,d6
	lea.l	D_32af8,a0
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
	lea.l	D_3afea,a0
	jsr	Blot_unmasked_block
	addi.w	#$20,d0
	lea.l	D_3b0ea,a0
	jsr	Blot_unmasked_block
	addi.w	#$60,d0
	lea.l	D_3ccea,a0
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
	bra.w	T_15860	; CHANGE: was "jmp SpSel_UP"
; ---- SpSel_1Down (original source: MAIN/MAGIC.ASM)
SpSel_1Down:
	moveq.l	#1,d0
	bra.w	T_15884	; CHANGE: was "jmp SpSel_DOWN"
; ---- SpSel_8Up (original source: MAIN/MAGIC.ASM)
SpSel_8Up:
	moveq.l	#8,d0
	bra.w	T_15860	; CHANGE: was "jmp SpSel_UP"
T_15812:
	moveq	#8,d0
	bra.w	T_15884
T_15818:
	move.w	Adding,d0
	lsr.w	#$8,d0
	bsr.w	T_15860
	bra.w	Inc_adding
T_15828:
	move.w	Adding,d0
	lsr.w	#$8,d0
	bsr.w	T_15884
	bra.w	Inc_adding
T_15838:
	move.w	Adding,d0
	lsr.w	#$5,d0
	andi.w	#$fff8,d0
	bsr.w	T_15860
	bra.w	Inc_adding
T_1584c:
	move.w	Adding,d0
	lsr.w	#$5,d0
	andi.w	#$fff8,d0
	bsr.w	T_15884
	bra.w	Inc_adding
T_15860:
	tst.b	B_5b862
	bne.b	T_15882
	move.w	Spell_list_pos,d1
	sub.w	d0,d1
	bpl.b	T_1587c
	moveq	#0,d1
	move.w	#$60,Adding
T_1587c:
	move.w	d1,Spell_list_pos
T_15882:
	rts
T_15884:
	tst.b	B_5b862
	bne.b	T_158b8
	move.w	Spell_list_pos,d1
	add.w	d0,d1
	moveq	#16,d2
	add.w	d1,d2
	cmp.w	Nr_of_spells,d2
	bmi.b	T_158b2
	move.w	Nr_of_spells,d1
	subi.w	#$10,d1
	move.w	#$60,Adding
T_158b2:
	move.w	d1,Spell_list_pos
T_158b8:
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
