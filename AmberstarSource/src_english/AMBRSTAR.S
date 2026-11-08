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
T_12c9e	equ	Transfer_gold+86
T_1cbce	equ	Old_mkb+2
T_1cc20	equ	Old_vbi+2
