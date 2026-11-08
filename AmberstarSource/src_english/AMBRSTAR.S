; Amberstar (Atari ST) - main program AMBRSTAR.68K
; Build file: includes the modules in the order of
; the program (TEST.ASM includes them in this order, the other parts are linked behind it).

	include	"CONSTANTS.I"

	include	"MAIN/TEST.S"
	include	"MAIN/STATUS.S"
	include	"MAIN/MAP/MAP.S"
	include	"MAIN/MAP/2DMAP.S"
	include	"MAIN/MAP/3DMAP.S"
	include	"MAIN/MAP/2DWILD.S"
	include	"MAIN/MAP/2DCITY.S"
	include	"MAIN/MAP/3DDUNGEO.S"
	include	"MAIN/MAP/3DCITY.S"
	include	"MAIN/MAP/SHADOW.S"
	include	"MAIN/PERSONS.S"
	include	"MAIN/TIME.S"
	include	"LAYOUT/LAYOUT.S"
	include	"MAIN/WORDS.S"
	include	"MAIN/EVENTS.S"
	include	"MAIN/WSELW.S"
	include	"MAIN/PLACES.S"
	include	"MAIN/EYE.S"
	include	"MAIN/MODCON.S"
	include	"MAIN/MODULES.S"
	include	"MAIN/INVENT.S"
	include	"MAIN/MAGIC.S"
	include	"MAIN/COMBAT.S"
	include	"LAYOUT/OBJFIND.S"
	include	"LAYOUT/WINDOWS.S"
	include	"LAYOUT/GRAPHICS.S"
	include	"NUCLEUS/AMBRFILE.S"
	include	"NUCLEUS/COLOFADE.S"
	include	"NUCLEUS/DIAGNOST.S"
	include	"NUCLEUS/GFXROUTS.S"
	include	"NUCLEUS/HBI.S"
	include	"NUCLEUS/INTROUTS.S"
	include	"NUCLEUS/KBDROUTS.S"
	include	"NUCLEUS/MEMORY.S"
	include	"NUCLEUS/NUMERIC.S"
	include	"NUCLEUS/SCREEN.S"
	include	"NUCLEUS/TEXTPUT.S"

	section	text

T_019d4	equ	Status_F0+20
T_03299	equ	Display_element+77
T_03298	equ	Display_element+76
T_032a5	equ	OD_Table+11
T_03a1c	equ	Blot_mirrored_unmasked_block+88
T_07c84	equ	Probe+4
T_0acf0	equ	Exit_PLACES+130
T_0ddf0	equ	Make_area_MOUTH+60
T_0edd0	equ	Do_results+78
Transfer_food	equ	Equip_item+86
T_12ed8	equ	Equip_item+182
T_12f1c	equ	Equip_item+250
T_12ff8	equ	Equip_item+470
T_1304e	equ	Equip_item+556
T_1cbce	equ	Old_mkb+2
T_1cbd8	equ	Old_timer_C+2
T_1cc20	equ	Old_vbi+2
SpellClass_ptrs	equ	T_138ba+1
