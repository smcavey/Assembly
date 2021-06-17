; this program reads from keyboard then prints
; nasm -felf64 readthenprint.asm && ld readthenprint.o && ./a.out
	section	.text
	global	_start
_start:
	mov	rsi, buffer			; move buffer into rsi
	mov	r8, 0				; original buffer size 0
	mov	r9, 0				; end of line flag
read:
	mov	rax, 0				; rax register holds syscall, 0 for read keyboard
	mov	rdi, 0				; rdi register holds file handle, 0 for stdin
	mov	rdx, 1				; rdx holds num of bytes of buffer
	syscall					; invoke syscall to read
	jmp	keepReading			; go to keepReading for next char
keepReading:
	inc	rsi				; inc buffer
	inc	r8				; inc size of buffer
	mov	r9b, byte [rsi-1]		; move last byte char into r9
	cmp	r9, 0xA				; compare last char with newline
	je	print				; if last char is newline then print
	jmp	read				; read next byte
print:
	mov	rax, 1				; rax register holds syscall, 1 for write
	mov	rdi, 1				; rdi register holds file handle, 1 for stdout
	mov	rsi, buffer			; move buffer into rsi
	mov	rdx, bufferlen			; move bufferlen into rdx
	syscall					; invoke syscall to write
	mov	rax, 60				; rax register holds syscall, 60 for exit
	xor	rdi, rdi			; invoke syscall to exit
	syscall
section		.bss
	buffer		resb 	bufferlen
	bufferlen	equ 	64
