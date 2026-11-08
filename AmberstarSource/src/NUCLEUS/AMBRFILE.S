; NUCLEUS/AMBRFILE.ASM (original module, merged with the disassembly of the shipped program)

	section	text


; ---- Init_file (original source: NUCLEUS/AMBRFILE.ASM) - the shipped program differs, its code follows, not assembled:
;Init_file:
;             movem.l   d0-d2/a0-a2,-(sp)
;             START_TIMER_C
;             D_SETPATH                      #Amberfile_path ; Set Amberfile path
;             tst.l     d0                   ; Succesful ?
;             beq.s     .Ok
;             ERROR     "[ Init_file ] :  Amberfile folder wasn't found !!!"
;             bra.s     .Exit
;.Ok:         F_GETDTA  ; Get DTA address
;             move.l    d0,DTA_ptr
;.Exit:       STOP_TIMER_C
;             movem.l   (sp)+,d0-d2/a0-a2
;             rts

; Also checks the drive and masks an MFP interrupt.
Init_file:
	movem.l	d0-d7/a0-a6,-(a7)
	move.w	sr,-(a7)
	ori.w	#$700,sr
	ori.b	#$20,$fffffa09.w
	move.w	(a7)+,sr
	move.w	#$f,d0
	jsr	Push_Mptr
	move.w	#$19,-(a7)
	trap	#$1
	addq.l	#$2,a7
	cmpi.w	#$2,d0
	spl.b	B_60123
	bpl.b	.l_1b688
	cmpi.w	#$2,$4a6.w
	seq.b	B_60124
	move.w	#$0,-(a7)
	move.w	#$e,-(a7)
	trap	#$1
	addq.l	#$4,a7
	bra.b	.l_1b6a8
.l_1b688:
	move.l	#Amberfile_path,-(a7)
	move.w	#$3b,-(a7)
	trap	#$1
	addq.l	#$6,a7
	tst.l	d0
	bpl.b	.l_1b6a8
	lea.l	D_54982,a1
	jsr	DI_Error
	bra.b	.l_1b6ca
.l_1b6a8:
	move.w	#$2f,-(a7)
	trap	#$1
	addq.l	#$2,a7
	move.l	d0,DTA_ptr
	move.w	sr,-(a7)
	ori.w	#$700,sr
	andi.b	#$df,$fffffa09.w
	move.w	(a7)+,sr
	jsr	Pop_Mptr
.l_1b6ca:
	movem.l	(a7)+,d0-d7/a0-a6
	rts
T_1b6d0:
	cmpi.w	#$fff3,d0
	bne.b	.l_1b6de
	jsr	T_1a170
	bra.b	.l_1b6e4
.l_1b6de:
	jsr	T_1a10e
.l_1b6e4:
	rts
; Checks the drive / disk change (new in the shipped program).
Check_disk:
	movem.l	d0-d7/a0-a6,-(a7)
	tst.b	B_60123
	bne.w	T_1b782
	moveq	#0,d0
	move.b	(a0),d0
	lea.l	D_5494f,a0
	moveq	#0,d7
	move.b	-$1(a0,d0.w),d7
T_1b704:
	move.w	#$8,-(a7)
	move.l	#D_54965,-(a7)
	move.w	#$4e,-(a7)
	trap	#$1
	addq.l	#$8,a7
	tst.l	d0
	bmi.b	.l_1b72c
	movea.l	DTA_ptr,a0
	move.b	$24(a0),d0
	subi.b	#$41,d0
	cmp.b	d0,d7
	beq.b	T_1b782
.l_1b72c:
	tst.b	B_60124
	bne.b	T_1b73e
T_1b734:
	move.w	d7,d0
	jsr	T_1a02e
	bra.b	T_1b704
T_1b73e:
	move.b	B_60122,d0
	eori.b	#$1,d0
	move.b	d0,B_60122
	ext.w	d0
	move.w	d0,-(a7)
	move.w	#$e,-(a7)
	trap	#$1
	addq.l	#$4,a7
	move.w	#$8,-(a7)
	move.l	#D_54965,-(a7)
	move.w	#$4e,-(a7)
	trap	#$1
	addq.l	#$8,a7
	tst.l	d0
	bmi.b	T_1b734
	movea.l	DTA_ptr,a0
	move.b	$24(a0),d0
	subi.b	#$41,d0
	cmp.b	d0,d7
	bne.b	T_1b734
T_1b782:
	movem.l	(a7)+,d0-d7/a0-a6
	rts

; ---- Load_file (original source: NUCLEUS/AMBRFILE.ASM) - the shipped program differs, its code follows, not assembled:
;Load_file:
;             movem.l   d0-d3/d7/a1-a3,-(sp)
;; ------------- Check if the file has already been loaded ------------
;             lea.l     1(a0),a3             ; Protect filename
;             move.b    (a0)+,d0
;             beq.s     .Skip
;             moveq.l   #0,d1
;             jsr       Reallocate_memory
;             cmpa.l    #0,a0                ; Already present ?
;             bne       .Exit2
;; ------------- Get file length --------------------------------------
;.Skip:       START_TIMER_C
;             Push      Mptr,#15             ; Disk pointer
;             F_SFIRST  #0,a3                ; Fill DTA
;             movea.l   DTA_ptr,a0           ; Get length of file
;             move.l    26(a0),d3
;
;; ------------- REGISTER CONTENTS ------------------------------------
;;  d3 - File length (.l)
;;  a3 - Pointer to filename (.l)
;
;             move.b    -1(a3),d0            ; Allocate file memory
;             move.l    d3,d1
;             moveq.l   #0,d2
;             jsr       File_allocate
;             exg.l     a1,a3                ; Protect buffer address
;             F_OPEN    #0,a1                ; Open file
;             tst.l     d0                   ; Succesful ?
;             bpl.s     .Ok
;             XERROR    "[ Load_file ] : Could not open file !!!",(a1)
;             bra       .Exit
;.Ok:         move.w    d0,d7                ; Protect handle
;             F_READ    a3,d3,d7             ; Read file
;             move.l    d0,Read_bytes
;             F_CLOSE   d7                   ; Close file
;             movea.l   a3,a0                ; Copy to output register
;.Exit:       Pop       Mptr
;             STOP_TIMER_C
;.Exit2:      movem.l   (sp)+,d0-d3/d7/a1-a3
;             rts

Load_file:
	movem.l	d0-d7/a1-a6,-(a7)
	moveq	#0,d6
	movea.l	a0,a5
	move.b	(a0)+,d0
	beq.b	.l_1b7a6
	moveq	#0,d1
	jsr	Reallocate_memory
	cmpa.l	#$0,a0
	bne.w	.l_1b864
.l_1b7a6:
	move.w	sr,-(a7)
	ori.w	#$700,sr
	ori.b	#$20,$fffffa09.w
	move.w	(a7)+,sr
	move.w	#$f,d0
	jsr	Push_Mptr
	movea.l	a5,a0
	bsr.w	Check_disk
	movea.l	a5,a0
	addq.l	#$1,a0
	move.w	#$0,-(a7)
	move.l	a0,-(a7)
	move.w	#$4e,-(a7)
	trap	#$1
	addq.l	#$8,a7
	tst.l	d0
	bpl.b	.l_1b7e2
	bsr.w	T_1b6d0
	bra.w	.l_1b86a
.l_1b7e2:
	movea.l	DTA_ptr,a0
	move.l	$1a(a0),d7
	move.b	(a5),d0
	move.l	d7,d1
	moveq	#0,d2
	jsr	File_allocate
	movea.l	a1,a4
	movea.l	a5,a0
	addq.l	#$1,a0
	move.w	#$0,-(a7)
	move.l	a0,-(a7)
	move.w	#$3d,-(a7)
	trap	#$1
	addq.l	#$8,a7
	tst.l	d0
	bpl.b	.l_1b816
	bsr.w	T_1b6d0
	bra.b	.l_1b86a
.l_1b816:
	move.w	d0,d6
	movea.l	a4,a0
	move.l	a0,-(a7)
	move.l	d7,-(a7)
	move.w	d6,-(a7)
	move.w	#$3f,-(a7)
	trap	#$1
	lea.l	$c(a7),a7
	tst.l	d0
	bpl.b	.l_1b834
	bsr.w	T_1b6d0
	bra.b	.l_1b86a
.l_1b834:
	move.l	d0,B_60126
	move.w	d6,-(a7)
	move.w	#$3e,-(a7)
	trap	#$1
	addq.l	#$4,a7
	tst.l	d0
	bpl.b	.l_1b84e
	bsr.w	T_1b6d0
	bra.b	.l_1b86a
.l_1b84e:
	jsr	Pop_Mptr
	move.w	sr,-(a7)
	ori.w	#$700,sr
	andi.b	#$df,$fffffa09.w
	move.w	(a7)+,sr
	movea.l	a4,a0
.l_1b864:
	movem.l	(a7)+,d0-d7/a1-a6
	rts
.l_1b86a:
	tst.w	d6
	beq.b	.l_1b878
	move.w	d6,-(a7)
	move.w	#$3e,-(a7)
	trap	#$1
	addq.l	#$4,a7
.l_1b878:
	jsr	Pop_Mptr
	move.w	sr,-(a7)
	ori.w	#$700,sr
	andi.b	#$df,$fffffa09.w
	move.w	(a7)+,sr
	movem.l	(a7)+,d0-d7/a1-a6
	bra.w	Load_file

; ---- Save_file (original source: NUCLEUS/AMBRFILE.ASM) - the shipped program differs, its code follows, not assembled:
;Save_file:
;             movem.l   d0-d2/d6/d7/a0-a3,-(sp)
;             move.l    d0,d7                ; Protect file length
;             movea.l   a0,a3
;             Push      Mptr,#15             ; Disk pointer
;             START_TIMER_C
;             F_CREATE  #0,a0                ; Create file
;             tst.l     d0
;             bpl.s     .Ok1
;             XERROR    "[ Save_file ] : Could not create file !!!",(a3)
;             bra       .Exit
;.Ok1:        move.l    d0,d6                ; Protect handle
;             F_WRITE   a1,d7,d6             ; Write file
;             tst.l     d0
;             bpl.s     .Ok2
;             XERROR    "[ Save_file ] : Could not write file !!! Disk full ?",(a3)
;             bra       .Exit
;.Ok2:        F_CLOSE   d6                   ; Close file
;.Exit:       STOP_TIMER_C
;             Pop       Mptr
;             movem.l   (sp)+,d0-d2/d6/d7/a0-a3
;             rts

Save_file:
	movem.l	d0-d7/a0-a6,-(a7)
	moveq	#0,d6
	move.l	d0,d7
	movea.l	a0,a5
	movea.l	a1,a4
	move.w	sr,-(a7)
	ori.w	#$700,sr
	ori.b	#$20,$fffffa09.w
	move.w	(a7)+,sr
	move.w	#$f,d0
	jsr	Push_Mptr
	movea.l	a5,a0
	bsr.w	Check_disk
	movea.l	a5,a0
	addq.l	#$1,a0
	move.w	#$0,-(a7)
	move.l	a0,-(a7)
	move.w	#$3c,-(a7)
	trap	#$1
	addq.l	#$8,a7
	tst.l	d0
	bpl.b	.l_1b8da
	bsr.w	T_1b6d0
	bra.b	.l_1b938
.l_1b8da:
	move.l	d0,d6
	movea.l	a4,a0
	move.l	a0,-(a7)
	move.l	d7,-(a7)
	move.w	d6,-(a7)
	move.w	#$40,-(a7)
	trap	#$1
	lea.l	$c(a7),a7
	tst.l	d0
	bpl.b	.l_1b8f8
	bsr.w	T_1b6d0
	bra.b	.l_1b938
.l_1b8f8:
	cmp.l	d7,d0
	beq.b	.l_1b90a
	lea.l	D_549b6,a1
	jsr	DI_Error
	bra.b	.l_1b938
.l_1b90a:
	move.w	d6,-(a7)
	move.w	#$3e,-(a7)
	trap	#$1
	addq.l	#$4,a7
	tst.l	d0
	bpl.b	.l_1b91e
	bsr.w	T_1b6d0
	bra.b	.l_1b938
.l_1b91e:
	move.w	sr,-(a7)
	ori.w	#$700,sr
	andi.b	#$df,$fffffa09.w
	move.w	(a7)+,sr
	jsr	Pop_Mptr
	movem.l	(a7)+,d0-d7/a0-a6
	rts
.l_1b938:
	tst.w	d6
	beq.b	.l_1b946
	move.w	d6,-(a7)
	move.w	#$3e,-(a7)
	trap	#$1
	addq.l	#$4,a7
.l_1b946:
	move.w	sr,-(a7)
	ori.w	#$700,sr
	andi.b	#$df,$fffffa09.w
	move.w	(a7)+,sr
	jsr	Pop_Mptr
	movem.l	(a7)+,d0-d7/a0-a6
	bra.w	Save_file

; ---- Exist_file (original source: NUCLEUS/AMBRFILE.ASM) - the shipped program differs, its code follows, not assembled:
;Exist_file:
;             movem.l   d0-d2/a0-a2,-(sp)
;             addq.l    #1,a0                ; Skip file type
;             START_TIMER_C                  ; Fill DTA
;             F_SFIRST  #0,a0
;             STOP_TIMER_C
;             cmpi.l    #-33,d0              ; Well ?
;             movem.l   (sp)+,d0-d2/a0-a2
;             rts

Exist_file:
	movem.l	d0-d7/a0-a6,-(a7)
	moveq	#0,d6
	movea.l	a0,a5
	move.w	sr,-(a7)
	ori.w	#$700,sr
	ori.b	#$20,$fffffa09.w
	move.w	(a7)+,sr
	move.w	#$f,d0
	jsr	Push_Mptr
	movea.l	a5,a0
	bsr.w	Check_disk
	movea.l	a5,a0
	addq.l	#$1,a0
	move.w	#$0,-(a7)
	move.l	a0,-(a7)
	move.w	#$4e,-(a7)
	trap	#$1
	addq.l	#$8,a7
	move.w	sr,-(a7)
	ori.w	#$700,sr
	andi.b	#$df,$fffffa09.w
	move.w	(a7)+,sr
	jsr	Pop_Mptr
	cmpi.l	#$ffffffdf,d0
	movem.l	(a7)+,d0-d7/a0-a6
	rts
	movem.l	d1-d7/a0-a6,-(a7)
	move.l	d0,d7
	move.w	sr,-(a7)
	ori.w	#$700,sr
	ori.b	#$20,$fffffa09.w
	move.w	(a7)+,sr
	move.w	#$f,d0
	jsr	Push_Mptr
.l_1b9d8:
	lea.l	B_6045c,a5
	move.w	d7,-(a7)
	move.l	a5,-(a7)
	move.w	#$36,-(a7)
	trap	#$1
	addq.l	#$8,a7
	tst.l	d0
	beq.b	.l_1b9f6
	jsr	T_1a10e
	bra.b	.l_1b9d8
.l_1b9f6:
	move.w	sr,-(a7)
	ori.w	#$700,sr
	andi.b	#$df,$fffffa09.w
	move.w	(a7)+,sr
	jsr	Pop_Mptr
	move.l	(a5),d0
	move.l	$8(a5),d1
	move.l	$c(a5),d2
	mulu.w	d2,d0
	mulu.w	d1,d0
	movem.l	(a7)+,d1-d7/a0-a6
	rts

; ---- Load_subfile (original source: NUCLEUS/AMBRFILE.ASM) - the shipped program differs, its code follows, not assembled:
;Load_subfile:
;             movem.l   d0-d7/a1-a4,-(sp)
;             subq.w    #1,d0
;             bpl.s     .Ok_0
;             XERROR    "[ Load_subfile ] : Zero not allowed !!!",1(a0)
;             bra       .Exit2
;; ------------- Check if the file has already been loaded ------------
;.Ok_0:       move.w    d0,d1
;             move.b    (a0)+,d0
;             movea.l   a0,a4                ; Protect filename
;             jsr       Reallocate_memory
;             cmpa.l    #0,a0                ; Already present ?
;             bne       .Exit2
;             move.w    d1,d6
;; ------------- Open the Amberfile -----------------------------------
;             START_TIMER_C
;             Push      Mptr,#15             ; Disk pointer
;             movea.l   a4,a0                ; Open file
;             F_OPEN    #0,a0
;             tst.l     d0                   ; Succesful ?
;             bpl.s     .Ok_1
;             XERROR    "[ Load_subfile ] : Could not open Amberfile !!!",(a4)
;             bra       .Exit
;.Ok_1:       move.w    d0,d7                ; Protect handle
;; ------------- Read the Amberfile header ----------------------------
;             F_READ    #Header_buffer,#6,d7 ; Read header
;             cmpi.l    #"AMBR",Header_buffer      ; Is it an Amberfile ?
;             beq.s     .Ok_2
;             cmpi.l    #"AMPC",Header_buffer      ; Is it packed ?
;             beq.s     .Ok_2
;             XERROR    "[ Load_subfile ] : This is not an Amberfile !!!",(a4)
;             bra       .Exit
;.Ok_2:       move.w    Header_buffer+4,d5   ; Load number of subfiles
;             cmp.w     d5,d6                ; Legal input ?
;             bmi.s     .Ok_3
;             XERROR    "[ Load_subfile ] : Illegal input !!!",(a4)
;             bra       .Exit
;.Ok_3:
;; ------------- REGISTER CONTENTS ------------------------------------
;;  d5 - Number of subfiles in current Amberfile (.w)
;;  d6 - Number of desired subfile (.w)
;;  d7 - Handle of current Amberfile (.w)
;;  a4 - Pointer to filename (.l)
;
;; ------------- Read all subfile lengths -----------------------------
;             ext.l     d5
;             lsl.l     #2,d5
;             lea.l     Subfile_lengths,a3   ; Read ALL subfile lengths
;             F_READ    a3,d5,d7
;             addq.l    #6,d5                ; Length of header
;             move.w    d6,d0
;             bra.s     .Entry
;.Loop:       add.l     (a3)+,d5             ; Add subfile length
;.Entry:      dbra      d0,.Loop             ; Next subfile
;
;             cmpi.l    #"AMBR",Header_buffer      ; Packed or unpacked ?
;             bne       .Packed
;
;; ------------- REGISTER CONTENTS ------------------------------------
;;  d5 - Offset to desired subfile (.l)
;;  d6 - Number of desired subfile (.l)
;;  d7 - Handle of current Amberfile (.w)
;;  a3 - Pointer to length of desired subfile (.l)
;;  a4 - Pointer to filename (.l)
;
;             move.b    -1(a4),d0            ; Allocate file memory
;             move.l    (a3),d1
;             move.w    d6,d2
;             jsr       File_allocate
;             move.l    (a3),d4              ; Load length of subfile
;             movea.l   a1,a3                ; Protect buffer pointer
;             F_SEEK    #0,d7,d5             ; Seek file pointer
;             F_READ    a3,d4,d7             ; Read subfile
;             move.l    d0,Read_bytes
;             bra       .Exit
;.Packed:
;             F_SEEK    #0,d7,d5             ; Read header
;             F_READ    #Header_buffer,#8,d7
;             F_SEEK    #1,d7,#-8
;             move.b    -1(a4),d0            ; Allocate file memory
;             move.l    Header_buffer+4,d1
;             andi.l    #$00ffffff,d1
;             addi.l    #Safety_factor,d1
;             move.w    d6,d2
;             jsr       File_allocate
;             move.l    (a3),d4              ; Load length of subfile
;             movea.l   a1,a3                ; Protect buffer pointer
;             F_READ    a3,d4,d7             ; Read subfile
;             movea.l   a3,a0                ; Unpack
;             jsr       Decompress
;             move.l    Header_buffer+4,d0   ; Return unused memory
;             andi.l    #$00ffffff,d0
;             move.l    d0,Read_bytes
;             jsr       Shrink_memory
;.Exit:       F_CLOSE   d7
;             Pop       Mptr
;             STOP_TIMER_C
;             movea.l   a3,a0
;.Exit2:      movem.l   (sp)+,d0-d7/a1-a4
;             rts

Load_subfile:
	movem.l	d0-d7/a1-a6,-(a7)
	subq.w	#$1,d0
	bpl.b	.l_1ba36
	lea.l	D_549d5,a1
	jsr	DI_Error
	bra.w	T_1bc42
.l_1ba36:
	moveq	#0,d6
	move.w	d0,d5
	movea.l	a0,a5
	move.b	(a0)+,d0
	move.w	d5,d1
	jsr	Reallocate_memory
	cmpa.l	#$0,a0
	bne.w	T_1bc42
	move.w	sr,-(a7)
	ori.w	#$700,sr
	ori.b	#$20,$fffffa09.w
	move.w	(a7)+,sr
	move.w	#$f,d0
	jsr	Push_Mptr
	movea.l	a5,a0
	bsr.w	Check_disk
	movea.l	a5,a0
	addq.l	#$1,a0
	move.w	#$0,-(a7)
	move.l	a0,-(a7)
	move.w	#$3d,-(a7)
	trap	#$1
	addq.l	#$8,a7
	tst.l	d0
	bpl.b	.l_1ba8c
	bsr.w	T_1b6d0
	bra.w	T_1bc48
.l_1ba8c:
	move.w	d0,d6
	move.l	#B_60136,-(a7)
	move.l	#$326,-(a7)
	move.w	d6,-(a7)
	move.w	#$3f,-(a7)
	trap	#$1
	lea.l	$c(a7),a7
	tst.l	d0
	bpl.b	.l_1bab2
	bsr.w	T_1b6d0
	bra.w	T_1bc48
.l_1bab2:
	cmpi.l	#$414d4252,B_60136
	beq.b	.l_1bada
	cmpi.l	#$414d5043,B_60136
	beq.b	.l_1bada
	lea.l	D_549fe,a1
	jsr	DI_Error
	bra.w	T_1bc42
.l_1bada:
	move.w	B_6013a,d4
	cmp.w	d4,d5
	bmi.b	.l_1baf4
	lea.l	D_54a2f,a1
	jsr	DI_Error
	bra.w	T_1bc42
.l_1baf4:
	ext.l	d4
	lsl.l	#$2,d4
	addq.l	#$6,d4
	lea.l	B_6013c,a0
	move.w	d5,d0
	bra.b	T_1bb06
T_1bb04:
	add.l	(a0)+,d4
T_1bb06:
	dbra	d0,T_1bb04
	move.l	(a0),d7
	cmpi.l	#$414d4252,B_60136
	bne.b	.l_1bb6c
	move.b	(a5),d0
	move.l	d7,d1
	move.w	d5,d2
	jsr	File_allocate
	movea.l	a1,a4
	move.w	#$0,-(a7)
	move.w	d6,-(a7)
	move.l	d4,-(a7)
	move.w	#$42,-(a7)
	trap	#$1
	lea.l	$a(a7),a7
	tst.l	d0
	bpl.b	.l_1bb44
	bsr.w	T_1b6d0
	bra.w	T_1bc48
.l_1bb44:
	movea.l	a4,a0
	move.l	a0,-(a7)
	move.l	d7,-(a7)
	move.w	d6,-(a7)
	move.w	#$3f,-(a7)
	trap	#$1
	lea.l	$c(a7),a7
	tst.l	d0
	bpl.b	.l_1bb62
	bsr.w	T_1b6d0
	bra.w	T_1bc48
.l_1bb62:
	move.l	d0,B_60126
	bra.w	.l_1bc18
.l_1bb6c:
	move.w	#$0,-(a7)
	move.w	d6,-(a7)
	move.l	d4,-(a7)
	move.w	#$42,-(a7)
	trap	#$1
	lea.l	$a(a7),a7
	tst.l	d0
	bpl.b	.l_1bb8a
	bsr.w	T_1b6d0
	bra.w	T_1bc48
.l_1bb8a:
	move.l	#B_6012e,-(a7)
	move.l	#$8,-(a7)
	move.w	d6,-(a7)
	move.w	#$3f,-(a7)
	trap	#$1
	lea.l	$c(a7),a7
	tst.l	d0
	bpl.b	.l_1bbae
	bsr.w	T_1b6d0
	bra.w	T_1bc48
.l_1bbae:
	move.b	(a5),d0
	move.l	B_60132,d1
	andi.l	#$ffffff,d1
	addi.l	#$800,d1
	move.w	d5,d2
	jsr	File_allocate
	movea.l	a1,a4
	movea.l	a4,a0
	move.l	B_6012e,(a0)+
	move.l	B_60132,(a0)+
	move.l	d7,d0
	subq.l	#$8,d0
	move.l	a0,-(a7)
	move.l	d0,-(a7)
	move.w	d6,-(a7)
	move.w	#$3f,-(a7)
	trap	#$1
	lea.l	$c(a7),a7
	tst.l	d0
	bpl.b	.l_1bbf8
	bsr.w	T_1b6d0
	bra.b	T_1bc48
.l_1bbf8:
	movea.l	a4,a0
	bsr.w	Decompress
	movea.l	a4,a0
	move.l	B_60132,d0
	andi.l	#$ffffff,d0
	move.l	d0,B_60126
	jsr	Shrink_memory
.l_1bc18:
	move.w	d6,-(a7)
	move.w	#$3e,-(a7)
	trap	#$1
	addq.l	#$4,a7
	tst.l	d0
	bpl.b	.l_1bc2c
	bsr.w	T_1b6d0
	bra.b	T_1bc48
.l_1bc2c:
	jsr	Pop_Mptr
	move.w	sr,-(a7)
	ori.w	#$700,sr
	andi.b	#$df,$fffffa09.w
	move.w	(a7)+,sr
	movea.l	a4,a0
T_1bc42:
	movem.l	(a7)+,d0-d7/a1-a6
	rts
T_1bc48:
	tst.w	d6
	beq.b	.l_1bc56
	move.w	d6,-(a7)
	move.w	#$3e,-(a7)
	trap	#$1
	addq.l	#$4,a7
.l_1bc56:
	jsr	Pop_Mptr
	move.w	sr,-(a7)
	ori.w	#$700,sr
	andi.b	#$df,$fffffa09.w
	move.w	(a7)+,sr
	movem.l	(a7)+,d0-d7/a1-a6
	bra.w	Load_subfile

; ---- Save_subfile (original source: NUCLEUS/AMBRFILE.ASM) - the shipped program differs, its code follows, not assembled:
;Save_subfile:
;             movem.l   d0-d7/a0-a5,-(sp)
;             subq.w    #1,d0
;             bpl.s     .Ok_0
;             XERROR    "[ Save_subfile ] : Zero not allowed !!!",1(a0)
;             bra       .Exit2
;.Ok_0:       move.w    d0,d6                ; Protect stuff
;             lea.l     1(a0),a4
;             movea.l   a1,a5
;; ------------- Open the Amberfile -----------------------------------
;             START_TIMER_C
;             Push      Mptr,#15             ; Disk pointer
;             F_OPEN    #2,a4                ; Open file
;             tst.l     d0                   ; Succesful ?
;             bpl.s     .Ok_1
;             XERROR    "[ Save_subfile ] : Could not open Amberfile !!!",(a4)
;             bra       .Exit
;.Ok_1:       move.w    d0,d7                ; Protect handle
;; ------------- Read the Amberfile header ----------------------------
;             F_READ    #Header_buffer,#6,d7 ; Read header
;             cmpi.l    #"AMBR",Header_buffer      ; Is it an Amberfile ?
;             beq.s     .Ok_2
;             XERROR    "[ Save_subfile ] : This is not an unpacked Amberfile !!!",(a4)
;             bra       .Exit
;.Ok_2:       move.w    Header_buffer+4,d5   ; Load number of subfiles
;             cmp.w     d5,d6                ; Legal input ?
;             bmi.s     .Ok_3
;             XERROR    "[ Save_subfile ] : Illegal input !!!",(a4)
;             bra       .Exit
;
;; ------------- REGISTER CONTENTS ------------------------------------
;;  d5 - Number of subfiles in current Amberfile (.w)
;;  d6 - Number of desired subfile (.w)
;;  d7 - Handle of current Amberfile (.w)
;;  a4 - Pointer to filename (.l)
;;  a5 - Pointer to buffer with file (.l)
;
;; ------------- Read all subfile lengths -----------------------------
;.Ok_3:       ext.l     d5
;             lsl.l     #2,d5
;             lea.l     Subfile_lengths,a3   ; Read ALL subfile lengths
;             F_READ    a3,d5,d7
;             addq.l    #6,d5                ; Length of header
;             move.w    d6,d0
;             bra.s     .Entry
;.Loop:       add.l     (a3)+,d5             ; Add subfile length
;.Entry:      dbra      d0,.Loop             ; Next subfile
;
;; ------------- REGISTER CONTENTS ------------------------------------
;;  d5 - Offset to desired subfile (.l)
;;  d6 - Number of desired subfile (.l)
;;  d7 - Handle of current Amberfile (.w)
;;  a3 - Pointer to length of desired subfile (.l)
;;  a4 - Pointer to filename (.l)
;;  a5 - Pointer to buffer with file (.l)
;
;             move.l    (a3),d4              ; Load length of subfile
;             F_SEEK    #0,d7,d5             ; Seek file pointer
;             F_WRITE   a5,d4,d7             ; Write subfile
;             tst.l     d0
;             bpl.s     .Exit
;             XERROR    "[ Save_subfile ] : Could not write file !!! Disk full ?",(a4)
;.Exit:       F_CLOSE   d7
;             Pop       Mptr
;             STOP_TIMER_C
;.Exit2:      movem.l   (sp)+,d0-d7/a0-a5
;             rts

Save_subfile:
	movem.l	d0-d7/a0-a6,-(a7)
	subq.w	#$1,d0
	bpl.b	.l_1bc8a
	lea.l	D_54a55,a1
	jsr	DI_Error
	bra.w	T_1bdb4
.l_1bc8a:
	moveq	#0,d6
	move.w	d0,d5
	movea.l	a0,a5
	movea.l	a1,a4
	move.w	sr,-(a7)
	ori.w	#$700,sr
	ori.b	#$20,$fffffa09.w
	move.w	(a7)+,sr
	move.w	#$f,d0
	jsr	Push_Mptr
	movea.l	a5,a0
	bsr.w	Check_disk
	movea.l	a5,a0
	addq.l	#$1,a0
	move.w	#$2,-(a7)
	move.l	a0,-(a7)
	move.w	#$3d,-(a7)
	trap	#$1
	addq.l	#$8,a7
	tst.l	d0
	bpl.b	.l_1bcce
	bsr.w	T_1b6d0
	bra.w	T_1bdba
.l_1bcce:
	move.w	d0,d6
	move.l	#B_60136,-(a7)
	move.l	#$326,-(a7)
	move.w	d6,-(a7)
	move.w	#$3f,-(a7)
	trap	#$1
	lea.l	$c(a7),a7
	tst.l	d0
	bpl.b	.l_1bcf4
	bsr.w	T_1b6d0
	bra.w	T_1bdba
.l_1bcf4:
	cmpi.l	#$414d4252,B_60136
	beq.b	.l_1bd10
	lea.l	D_54a7e,a1
	jsr	DI_Error
	bra.w	T_1bdb4
.l_1bd10:
	move.w	B_6013a,d4
	cmp.w	d4,d5
	bmi.b	.l_1bd2a
	lea.l	D_54ab8,a1
	jsr	DI_Error
	bra.w	T_1bdb4
.l_1bd2a:
	ext.l	d4
	lsl.l	#$2,d4
	addq.l	#$6,d4
	lea.l	B_6013c,a0
	move.w	d5,d0
	bra.b	T_1bd3c
T_1bd3a:
	add.l	(a0)+,d4
T_1bd3c:
	dbra	d0,T_1bd3a
	move.l	(a0),d7
	move.w	#$0,-(a7)
	move.w	d6,-(a7)
	move.l	d4,-(a7)
	move.w	#$42,-(a7)
	trap	#$1
	lea.l	$a(a7),a7
	tst.l	d0
	bpl.b	.l_1bd5e
	bsr.w	T_1b6d0
	bra.b	T_1bdba
.l_1bd5e:
	movea.l	a4,a0
	move.l	a0,-(a7)
	move.l	d7,-(a7)
	move.w	d6,-(a7)
	move.w	#$40,-(a7)
	trap	#$1
	lea.l	$c(a7),a7
	tst.l	d0
	bpl.b	.l_1bd7a
	bsr.w	T_1b6d0
	bra.b	T_1bdba
.l_1bd7a:
	cmp.l	d7,d0
	beq.b	.l_1bd8c
	lea.l	D_54ade,a1
	jsr	DI_Error
	bra.b	T_1bdba
.l_1bd8c:
	move.w	d6,-(a7)
	move.w	#$3e,-(a7)
	trap	#$1
	addq.l	#$4,a7
	tst.l	d0
	bpl.b	.l_1bda0
	bsr.w	T_1b6d0
	bra.b	T_1bdba
.l_1bda0:
	jsr	Pop_Mptr
	move.w	sr,-(a7)
	ori.w	#$700,sr
	andi.b	#$df,$fffffa09.w
	move.w	(a7)+,sr
T_1bdb4:
	movem.l	(a7)+,d0-d7/a0-a6
	rts
T_1bdba:
	tst.w	d6
	beq.b	.l_1bdc8
	move.w	d6,-(a7)
	move.w	#$3e,-(a7)
	trap	#$1
	addq.l	#$4,a7
.l_1bdc8:
	jsr	Pop_Mptr
	move.w	sr,-(a7)
	ori.w	#$700,sr
	andi.b	#$df,$fffffa09.w
	move.w	(a7)+,sr
	movem.l	(a7)+,d0-d7/a0-a6
	bra.w	Save_subfile
; ---- Decompress (original source: NUCLEUS/AMBRFILE.ASM)
Decompress:
	movem.l	d0-d7/a0-a6,-(sp)
	move.l	#Safety_factor,d0
	bsr.w	.Do_it
	movem.l	(sp)+,d0-d7/a0-a6
	rts	
.Do_it:
; .IBYTES 'EXPANDER.IMG'
	even	

; ---- XError (original source: NUCLEUS/AMBRFILE.ASM) - the shipped program differs, its code follows, not assembled:
;XError:
;             movem.l   d0-d7/a0-a6,-(sp)    ; Save registers
;             jsr       ON_Diag_screen       ; Diagnostic screen setup
;             jsr       DI_Cursor_home
;             movea.l   Screen_base,a6
;             lea.l     Error_msg1,a0        ; Print
;             jsr       DI_Print
;             movea.l   a1,a0
;             jsr       DI_Print
;             lea.l     XError_msg,a0
;             jsr       DI_Print
;             movea.l   a2,a0
;             jsr       DI_Print
;             lea.l     Error_msg2,a0
;             jsr       DI_Print
;             jsr       Wait_4_key
;             cmpi.b    #"x",d0              ; Exit on 'x'
;             bne.s     .Exit
;             illegal
;.Exit:       jsr       OFF_Diag_screen      ; Exit diagnostic screen
;             movem.l   (sp)+,d0-d7/a0-a6    ; Restore registers
;             rts
;
;             .SECTION 4,DATA
;Error_msg1:  .DC.b 3,2,1," !!! An ERROR has occurred !!! ",13,13,2,3,1,0
;Error_msg2:  .DC.b 13,13,3,2,1," Press any key to continue...  ",2,0
;XError_msg:  .DC.b 13,"Filename : ",0

T_1bdf8:
	lea.l	.l_1be16(pc),a2
	move.l	a0,$2(a2)
	move.l	d0,$e(a2)
	movea.l	a0,a1
	jsr	(a2)
	lea.l	.l_1be16(pc),a2
	movea.l	$2(a2),a0
	move.l	$6(a2),d0
	rts
.l_1be16:
	bra.b	T_1be3c
T_1be18:
	dc.b	$00,$00,$00,$00
T_1be1c:
	dc.b	$00,$00,$00,$00
T_1be20:
	dc.b	$00,$00,$00,$00
T_1be24:
	dc.b	$00,$00,$64,$00
T_1be28:
	dc.b	$00,$00,$00,$00,$08,$00,$3c,$00,$3c,$00,$00,$00,$00,$00,$03,$00
	dc.b	$00,$00,$00,$00
T_1be3c:
	lea.l	T_1be20(pc),a0
	move.l	(a1)+,(a0)
.l_1be42:
	beq.b	.l_1be5c
	moveq	#0,d0
	move.b	(a1),d0
	add.w	d0,d0
	move.w	T_1be28(pc,d0.w),d0
	bsr.b	.l_1be5e
	movea.l	T_1be18(pc),a1
	lea.l	T_1be20(pc),a0
	subq.b	#$1,(a0)
	bra.b	.l_1be42
.l_1be5c:
	rts
.l_1be5e:
	lea.l	T_1be1c(pc),a0
	move.l	(a1),d1
	andi.l	#$ffffff,d1
	move.l	d1,(a0)
	move.l	$4(a1),d2
	addq.l	#$8,d2
	add.l	d0,d2
	movea.l	T_1be18(pc),a0
	adda.l	T_1be24(pc),a0
	adda.l	d1,a0
	adda.l	d2,a1
.l_1be80:
	move.l	-(a1),-(a0)
	move.l	-(a1),-(a0)
	subq.l	#$8,d2
	bpl.b	.l_1be80
	suba.l	d2,a0
	movea.l	T_1be18(pc),a1
	cmpi.b	#$6,(a0)
	bne.w	.l_1bedc
	move.l	(a0)+,d0
	andi.l	#$ffffff,d0
	add.l	a1,d0
	addq.l	#$4,a0
	move.l	#$80,d1
.l_1bea8:
	add.b	d1,d1
	bne.b	.l_1beb0
	move.b	(a0)+,d1
	addx.b	d1,d1
.l_1beb0:
	bcc.b	.l_1beba
	move.b	(a0)+,(a1)+
	cmpa.l	d0,a1
	blt.b	.l_1bea8
	rts
.l_1beba:
	moveq	#0,d3
	move.b	(a0)+,d3
	move.b	d3,d2
	andi.w	#$f,d2
	lsl.w	#$4,d3
	move.b	(a0)+,d3
	movea.l	a1,a2
	suba.l	d3,a2
	move.b	(a2)+,(a1)+
	move.b	(a2)+,(a1)+
.l_1bed0:
	move.b	(a2)+,(a1)+
	dbra	d2,.l_1bed0
	cmpa.l	d0,a1
	blt.b	.l_1bea8
	rts
.l_1bedc:
	rts

	section	data

Amberfile_path:
	dc.b	$5c,$41,$4d,$42,$52,$53,$54,$41,$52,$5c,$41,$4d,$42,$52,$46,$49
	dc.b	$4c,$45,$5c,$00,$00
D_54982:
	dc.b	$5b,$20,$49,$6e,$69,$74,$5f,$66,$69,$6c,$65,$20,$5d,$20,$3a,$20
	dc.b	$20,$41,$6d,$62,$65,$72,$73,$74,$61,$72,$20,$66,$6f,$6c,$64,$65
	dc.b	$72,$20,$77,$61,$73,$6e,$27,$74,$20,$66,$6f,$75,$6e,$64,$20,$21
	dc.b	$21,$21,$0d,$00
D_549b6:
	dc.b	$5b,$20,$53,$61,$76,$65,$5f,$66,$69,$6c,$65,$20,$5d,$20,$3a,$20
	dc.b	$44,$69,$73,$6b,$20,$66,$75,$6c,$6c,$20,$21,$21,$21,$0d,$00
D_549d5:
	dc.b	$5b,$20,$4c,$6f,$61,$64,$5f,$73,$75,$62,$66,$69,$6c,$65,$20,$5d
	dc.b	$20,$3a,$20,$5a,$65,$72,$6f,$20,$6e,$6f,$74,$20,$61,$6c,$6c,$6f
	dc.b	$77,$65,$64,$20,$21,$21,$21,$0d,$00
D_549fe:
	dc.b	$5b,$20,$4c,$6f,$61,$64,$5f,$73,$75,$62,$66,$69,$6c,$65,$20,$5d
	dc.b	$20,$3a,$20,$54,$68,$69,$73,$20,$69,$73,$20,$6e,$6f,$74,$20,$61
	dc.b	$6e,$20,$41,$6d,$62,$65,$72,$66,$69,$6c,$65,$20,$21,$21,$21,$0d
	dc.b	$00
D_54a2f:
	dc.b	$5b,$20,$4c,$6f,$61,$64,$5f,$73,$75,$62,$66,$69,$6c,$65,$20,$5d
	dc.b	$20,$3a,$20,$49,$6c,$6c,$65,$67,$61,$6c,$20,$69,$6e,$70,$75,$74
	dc.b	$20,$21,$21,$21,$0d,$00
D_54a55:
	dc.b	$5b,$20,$53,$61,$76,$65,$5f,$73,$75,$62,$66,$69,$6c,$65,$20,$5d
	dc.b	$20,$3a,$20,$5a,$65,$72,$6f,$20,$6e,$6f,$74,$20,$61,$6c,$6c,$6f
	dc.b	$77,$65,$64,$20,$21,$21,$21,$0d,$00
D_54a7e:
	dc.b	$5b,$20,$53,$61,$76,$65,$5f,$73,$75,$62,$66,$69,$6c,$65,$20,$5d
	dc.b	$20,$3a,$20,$54,$68,$69,$73,$20,$69,$73,$20,$6e,$6f,$74,$20,$61
	dc.b	$6e,$20,$75,$6e,$70,$61,$63,$6b,$65,$64,$20,$41,$6d,$62,$65,$72
	dc.b	$66,$69,$6c,$65,$20,$21,$21,$21,$0d,$00
D_54ab8:
	dc.b	$5b,$20,$53,$61,$76,$65,$5f,$73,$75,$62,$66,$69,$6c,$65,$20,$5d
	dc.b	$20,$3a,$20,$49,$6c,$6c,$65,$67,$61,$6c,$20,$69,$6e,$70,$75,$74
	dc.b	$20,$21,$21,$21,$0d,$00
D_54ade:
	dc.b	$5b,$20,$53,$61,$76,$65,$5f,$73,$75,$62,$66,$69,$6c,$65,$20,$5d
	dc.b	$20,$3a,$20,$44,$69,$73,$6b,$20,$66,$75,$6c,$6c,$20,$21,$21,$21
	dc.b	$0d,$00

	section	bss

DTA_ptr:
	ds.b	4
B_6012e:
	ds.b	4
B_60132:
	ds.b	4
B_60136:
	ds.b	4
B_6013a:
	ds.b	2
B_6013c:
	ds.b	800
B_6045c:
	ds.b	16
B_6046c:
	ds.b	1
B_6046d:
	ds.b	5
B_60472:
	ds.b	4
B_60476:
	ds.b	4
