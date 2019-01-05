section .text

global b_bzero

; RDI, RSI, RDX, RCX, R8, R9

; rdi is memory pointer
; rsi is len
b_bzero:
	cmp rdi, 0
	jz .finished
	mov rdx, rsi ; len
	mov rcx, rdi ; ptr

.large:
	cmp rdx, 8
	jle .medium
	mov qword[rcx], 0x0
	add rcx, 8
	sub rdx, 8
	jmp .large

.medium:
	cmp rdx, 4
	jle .small
	mov dword[rcx], 0x0
	add rcx, 4
	sub rdx, 4
	jmp .medium

.small:
	cmp rdx, 2
	jle .one
	mov word[rcx], 0x0
	add rcx, 2
	sub rdx, 2
	jmp .small

.one:
	cmp rdx, 0
	je .finished
	mov byte[rcx], 0x0
	inc rcx
	dec rdx
	jmp .small

.finished:
	ret
