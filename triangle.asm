; this program prints a triangle of *
; nasm -felf64 triangle.asm && ld triangle.o && ./a.out
	section	.text
	global	_start
_start:
	mov	rdx,output			; rdx register holds num of bytes of message
	mov	r8,1				; initial number of stars per line
	mov	r9,0				; number of stars written so far
lineGrow:
	mov	byte [rdx],"*"			; write a * to rdx register for current line
	inc	rdx				; increment rdx to next byte to accept next write
	inc	r9				; increment number of stars written for current line
	cmp	r8,r9				; check if we've written enough stars to line so far
	jne	lineGrow			; jump to lineGrow if r8 not equ r9
completeLineGrow:
	mov	byte [rdx],0xA			; write a new line to register
	inc	rdx				; increment rdx to next byte to accept next write
	inc	r8				; make next line 1 * longer
	mov	r9,0				; reset number of stars written per line to 0
	cmp	r8,halfWay			; check if we've grown enough and are ready to shrink
	jne	lineGrow			; jump to lineGrow if r8 not equ halfWay
lineShrink:
	mov	byte [rdx],"*"			; write a * to rdx register for current line
	inc	rdx				; increment rdx to next byte to accept next write
	inc	r9				; increment number of stars written for current line
	cmp	r8,r9				; check if we've written enough stars to line so far
	jne	lineShrink			; jump to lineShrink if r8 not equ r9
completeLineShrink:
	mov	byte [rdx],0xA			; write a new line to register
	inc	rdx				; incrememnt rdx to next byte to accept next write
	dec	r8				; make next line 1 * smaller
	mov	r9,0				; reset number of stars written per line to 0
	cmp	r8,lastLine			; check if we've written all our stars
	jne	lineShrink			; jump to line shrink if r8 not equ lastLine
done:
	mov	rax,1				; rax register holds syscall, 1 for write
	mov	rdi,1				; rdi register holds file handle, 1 for stdout
	mov	rsi,output			; rsi register holds pyramid
	mov	rdx,datasize			; rdx register holds num of bytes of pyramid
	syscall					; invoke syscall to write
	mov	rax,60				; rax register holds syscall, 60 for exit
	xor	rdi,rdi				; set rdi return code to 0
	syscall					; invoke syscall to exit
section		.bss
	output:		resb	datasize
	maxLines	equ	7
	halfWay		equ	4
	lastLine	equ	0
	datasize	equ	23
