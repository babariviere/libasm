section .text

global b_memset

; RDI, RSI, RDX, RCX, R8, R9

; rdi is memory pointer
; rsi is character
; rdx is len
b_memset:
	cmp rdi, 0
	jz .finished
	mov rax, rsi ; char
	mov rcx, rdi ; ptr

	; one small operation we may loose operations by feeding rax
	cmp rdx, 16
	jl .one
	
	; feed repeat characters inside rax for large write operation
	mov rcx, 0
.feed:
	cmp rcx, 7
	je .end_feed
	shl rax, 8
	or  ax, si
	inc rcx
	jmp .feed

.end_feed:
	mov rcx, rdi ; ptr

.large:
	cmp rdx, 8
	jle .medium
	mov qword[rcx], rax
	add rcx, 8
	sub rdx, 8
	jmp .large

.medium:
	cmp rdx, 4
	jle .small
	mov dword[rcx], eax
	add rcx, 4
	sub rdx, 4
	jmp .medium

.small:
	cmp rdx, 2
	jle .one
	mov word[rcx], ax
	add rcx, 2
	sub rdx, 2
	jmp .small

.one:
	cmp rdx, 0
	je .finished
	mov byte[rcx], al
	inc rcx
	dec rdx
	jmp .one

.finished:
	ret
