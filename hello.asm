; this program prints hello world
; nasm -felf64 hello.asm && ld hello.o && ./a.out
	section	.text
	global	_start
_start:
	mov	rax,1			; rax register holds syscall, 1 for write
	mov	rdi,1			; rdi register holds file handle, 1 for stdout
	mov	rsi,message		; rsi register holds string literal
	mov	rdx,len			; rdx register holds num of bytes of message
	syscall				; invoke syscall to write
	mov	rax,60			; rax register holds syscall, 60 for exit
	xor	rdi,rdi			; set rdi return code to 0
	syscall				; invoke syscall to exit
section		.data
	message db "Hello, World!",0xA	; message to be printed followed by ascii new line
	len	equ $ - message		; size of message
