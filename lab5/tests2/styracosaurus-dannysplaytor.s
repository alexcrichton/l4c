.file	"../tests2/styracosaurus-dannysplaytor.l4"
.globl _c0_main
_c0_rotate_left:
	addq $-8, %rsp
.rotate_left_0:
	movl $1, %edx
	movq $0, %rcx
	movq %rdi, %r8
	cmpq %rcx, %r8
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .rotate_left_3
.rotate_left_1:
	movq %rdi, %rax
	addq $8, %rsp
	ret
.rotate_left_3:
.rotate_left_4:
	movq $16, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movl $1, %edx
	movq $0, %rcx
	cmpq %rcx, %r8
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .rotate_left_7
.rotate_left_5:
	movq %rdi, %rax
	addq $8, %rsp
	ret
.rotate_left_7:
.rotate_left_8:
	movq $16, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movq %r8, %rsi
	movq $8, %rcx
	movq %rsi, %r8
	addq %rcx, %r8
	movq (%r8), %rdx
	movq $16, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movq %rdx, (%r8)
	movq $8, %rcx
	movq %rsi, %r8
	addq %rcx, %r8
	movq %rdi, (%r8)
	movq $0, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movq (%r8), %rdx
	movq $0, %rcx
	movq %rsi, %r8
	addq %rcx, %r8
	movq %rdx, (%r8)
	movq $0, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movq (%r8), %rcx
	movq $0, %r8
	cmpq %r8, %rcx
	jnz .ternary_true1
	movl $0, %ecx
	jmp .ternary_end2
.ternary_true1:
	movq $0, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movq $16, %rcx
	addq %rcx, %r8
	movq (%r8), %r8
	cmpq %rdi, %r8
	sete %cl
	movzbl %cl, %ecx
.ternary_end2:
	movl $1, %r8d
	cmpl %ecx, %r8d
	jnz .rotate_left_10
.rotate_left_9:
	movq $0, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movq $16, %rcx
	addq %rcx, %r8
	movq %rsi, (%r8)
.rotate_left_11:
	movq $0, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movq (%r8), %rcx
	movq $0, %r8
	cmpq %r8, %rcx
	jnz .ternary_true3
	movl $0, %ecx
	jmp .ternary_end4
.ternary_true3:
	movq $0, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movq $8, %rcx
	addq %rcx, %r8
	movq (%r8), %r8
	cmpq %rdi, %r8
	sete %cl
	movzbl %cl, %ecx
.ternary_end4:
	movl $1, %r8d
	cmpl %ecx, %r8d
	jnz .rotate_left_13
.rotate_left_12:
	movq $0, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movq $8, %rcx
	addq %rcx, %r8
	movq %rsi, (%r8)
.rotate_left_14:
	movq $0, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movq %rsi, (%r8)
	movq $16, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movl $1, %edx
	movq $0, %rcx
	cmpq %rcx, %r8
	setne %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .rotate_left_16
.rotate_left_15:
	movq $16, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movq $0, %rcx
	addq %rcx, %r8
	movq %rdi, (%r8)
.rotate_left_17:
	movq %rsi, %rax
	addq $8, %rsp
	ret
.rotate_left_16:
	jmp .rotate_left_17
.rotate_left_13:
	jmp .rotate_left_14
.rotate_left_10:
	jmp .rotate_left_11
_c0_rotate_right:
	addq $-8, %rsp
.rotate_right_0:
	movl $1, %edx
	movq $0, %rcx
	movq %rdi, %r8
	cmpq %rcx, %r8
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .rotate_right_3
.rotate_right_1:
	movq %rdi, %rax
	addq $8, %rsp
	ret
.rotate_right_3:
.rotate_right_4:
	movq $8, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movl $1, %edx
	movq $0, %rcx
	cmpq %rcx, %r8
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .rotate_right_7
.rotate_right_5:
	movq %rdi, %rax
	addq $8, %rsp
	ret
.rotate_right_7:
.rotate_right_8:
	movq $8, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movq %r8, %rsi
	movq $16, %rcx
	movq %rsi, %r8
	addq %rcx, %r8
	movq (%r8), %rdx
	movq $8, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movq %rdx, (%r8)
	movq $16, %rcx
	movq %rsi, %r8
	addq %rcx, %r8
	movq %rdi, (%r8)
	movq $0, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movq (%r8), %rdx
	movq $0, %rcx
	movq %rsi, %r8
	addq %rcx, %r8
	movq %rdx, (%r8)
	movq $0, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movq (%r8), %rcx
	movq $0, %r8
	cmpq %r8, %rcx
	jnz .ternary_true5
	movl $0, %ecx
	jmp .ternary_end6
.ternary_true5:
	movq $0, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movq $16, %rcx
	addq %rcx, %r8
	movq (%r8), %r8
	cmpq %rdi, %r8
	sete %cl
	movzbl %cl, %ecx
.ternary_end6:
	movl $1, %r8d
	cmpl %ecx, %r8d
	jnz .rotate_right_10
.rotate_right_9:
	movq $0, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movq $16, %rcx
	addq %rcx, %r8
	movq %rsi, (%r8)
.rotate_right_11:
	movq $0, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movq (%r8), %rcx
	movq $0, %r8
	cmpq %r8, %rcx
	jnz .ternary_true7
	movl $0, %ecx
	jmp .ternary_end8
.ternary_true7:
	movq $0, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movq $8, %rcx
	addq %rcx, %r8
	movq (%r8), %r8
	cmpq %rdi, %r8
	sete %cl
	movzbl %cl, %ecx
.ternary_end8:
	movl $1, %r8d
	cmpl %ecx, %r8d
	jnz .rotate_right_13
.rotate_right_12:
	movq $0, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movq $8, %rcx
	addq %rcx, %r8
	movq %rsi, (%r8)
.rotate_right_14:
	movq $0, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movq %rsi, (%r8)
	movq $8, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movl $1, %edx
	movq $0, %rcx
	cmpq %rcx, %r8
	setne %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .rotate_right_16
.rotate_right_15:
	movq $8, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movq $0, %rcx
	addq %rcx, %r8
	movq %rdi, (%r8)
.rotate_right_17:
	movq %rsi, %rax
	addq $8, %rsp
	ret
.rotate_right_16:
	jmp .rotate_right_17
.rotate_right_13:
	jmp .rotate_right_14
.rotate_right_10:
	jmp .rotate_right_11
_c0_splay:
	addq $-40, %rsp
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
	movq %rdi, %r9
.splay_0:
	movl $1, %edx
	movq $0, %rcx
	movq %r9, %r8
	cmpq %rcx, %r8
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .splay_3
.splay_1:
	movq %r9, %rax
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.splay_3:
.splay_4:
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movl $1, %edx
	movq $0, %rcx
	cmpq %rcx, %r8
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .splay_6
.splay_5:
	movq %r9, %rax
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.splay_6:
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movq $0, %rcx
	addq %rcx, %r8
	movq (%r8), %r8
	movl $1, %edx
	movq $0, %rcx
	cmpq %rcx, %r8
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .splay_15
.splay_7:
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movq $8, %rcx
	addq %rcx, %r8
	movq (%r8), %rcx
	movl $1, %edx
	movq %r9, %r8
	cmpq %rcx, %r8
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .splay_9
.splay_8:
	movq $0, %r8
	addq %r8, %r9
	movq (%r9), %r9
	movq %r9, %rdi
	callq _c0_rotate_right
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.splay_9:
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movq $16, %rcx
	addq %rcx, %r8
	movq (%r8), %rdx
	movl $1, %ecx
	movq %r9, %r8
	cmpq %rdx, %r8
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .splay_12
.splay_10:
	movq $0, %r8
	addq %r8, %r9
	movq (%r9), %r9
	movq %r9, %rdi
	callq _c0_rotate_left
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.splay_12:
.splay_14:
.splay_27:
.splay_30:
.splay_31:
	movq %r9, %rdi
	callq _c0_splay
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.splay_15:
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movq %r8, %rcx
	movq $0, %rdx
	movq %rcx, %r8
	addq %rdx, %r8
	movq (%r8), %r8
	movq $8, %rsi
	movq %rcx, %rdx
	addq %rsi, %rdx
	movq (%rdx), %rdx
	cmpq %rdx, %r9
	jz .ternary_true9
	movl $0, %esi
	jmp .ternary_end10
.ternary_true9:
	movq $8, %rsi
	movq %r8, %rdx
	addq %rsi, %rdx
	movq (%rdx), %rsi
	movq %rcx, %rdx
	cmpq %rsi, %rdx
	sete %sil
	movzbl %sil, %esi
.ternary_end10:
	movl $1, %edx
	cmpl %esi, %edx
	jnz .splay_16
.splay_25:
	movq %r8, %rdi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_rotate_right
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movq %rcx, %rdi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_rotate_right
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
.splay_28:
	jmp .splay_30
.splay_16:
	movq $16, %rsi
	movq %rcx, %rdx
	addq %rsi, %rdx
	movq (%rdx), %rdx
	cmpq %rdx, %r9
	jz .ternary_true11
	movl $0, %esi
	jmp .ternary_end12
.ternary_true11:
	movq $16, %rsi
	movq %r8, %rdx
	addq %rsi, %rdx
	movq (%rdx), %rsi
	movq %rcx, %rdx
	cmpq %rsi, %rdx
	sete %sil
	movzbl %sil, %esi
.ternary_end12:
	movl $1, %edx
	cmpl %esi, %edx
	jnz .splay_17
.splay_23:
	movq %r8, %rdi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_rotate_left
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movq %rcx, %rdi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_rotate_left
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
.splay_26:
	jmp .splay_28
.splay_17:
	movq $16, %rsi
	movq %rcx, %rdx
	addq %rsi, %rdx
	movq (%rdx), %rdx
	cmpq %rdx, %r9
	jz .ternary_true13
	movl $0, %esi
	jmp .ternary_end14
.ternary_true13:
	movq $8, %rsi
	movq %r8, %rdx
	addq %rsi, %rdx
	movq (%rdx), %rsi
	movq %rcx, %rdx
	cmpq %rsi, %rdx
	sete %sil
	movzbl %sil, %esi
.ternary_end14:
	movl $1, %edx
	cmpl %esi, %edx
	jnz .splay_18
.splay_21:
	movq %rcx, %rdi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_rotate_left
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movq %r8, %rdi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_rotate_right
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
.splay_24:
	jmp .splay_26
.splay_18:
	movq $8, %rsi
	movq %rcx, %rdx
	addq %rsi, %rdx
	movq (%rdx), %rdx
	cmpq %rdx, %r9
	jz .ternary_true15
	movl $0, %esi
	jmp .ternary_end16
.ternary_true15:
	movq $16, %rsi
	movq %r8, %rdx
	addq %rsi, %rdx
	movq (%rdx), %rsi
	movq %rcx, %rdx
	cmpq %rsi, %rdx
	sete %sil
	movzbl %sil, %esi
.ternary_end16:
	movl $1, %edx
	cmpl %esi, %edx
	jnz .splay_20
.splay_19:
	movq %rcx, %rdi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_rotate_right
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movq %r8, %rdi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_rotate_left
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
.splay_22:
	jmp .splay_24
.splay_20:
	jmp .splay_22
_c0_merge:
	addq $-8, %rsp
	movq %rdi, %r9
.merge_0:
	movq %rsi, %rdi
	movl $1, %edx
	movq $0, %r8
	movq %rsi, %rcx
	cmpq %r8, %rcx
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .merge_3
.merge_1:
	movq %r9, %rax
	addq $8, %rsp
	ret
.merge_3:
.merge_4:
	movl $1, %edx
	movq $0, %r8
	movq %r9, %rcx
	cmpq %r8, %rcx
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .merge_7
.merge_5:
	movq %rsi, %rax
	addq $8, %rsp
	ret
.merge_7:
.merge_8:
	movq $24, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl (%r8), %esi
	movq $24, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl (%r8), %edx
	movl $1, %r8d
	movl %esi, %ecx
	cmpl %edx, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %r8d
	jnz .merge_14
.merge_9:
	movq $16, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movl $1, %edx
	movq $0, %rcx
	cmpq %rcx, %r8
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .merge_11
.merge_10:
	movq $16, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movq %r9, (%r8)
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq %rdi, (%r8)
	movq %r9, %rdi
	callq _c0_splay
	addq $8, %rsp
	ret
.merge_11:
	movq $16, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movq (%r8), %rcx
	movq %r9, %rdi
	movq %rcx, %rsi
	callq _c0_merge
	addq $8, %rsp
	ret
.merge_14:
	movq $8, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movl $1, %edx
	movq $0, %rcx
	cmpq %rcx, %r8
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .merge_16
.merge_15:
	movq $8, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movq %r9, (%r8)
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq %rdi, (%r8)
	movq %r9, %rdi
	callq _c0_splay
	addq $8, %rsp
	ret
.merge_16:
	movq $8, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movq (%r8), %rcx
	movq %r9, %rdi
	movq %rcx, %rsi
	callq _c0_merge
	addq $8, %rsp
	ret
_c0_insert:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
	movl %edi, %r9d
	movq %rsi, %r8
.insert_0:
	movq $1, %rdi
	movq $28, %rsi
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r12, %r8
	movq %rbx, %r9
	movq $24, %rdx
	movq %rax, %rcx
	addq %rdx, %rcx
	movl %r9d, (%rcx)
	movq %rax, %rdi
	movq %r8, %rsi
	callq _c0_merge
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_height:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movq %rdi, %r9
.height_0:
	movl $1, %edx
	movq $0, %r8
	movq %r9, %rcx
	cmpq %r8, %rcx
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .height_3
.height_1:
	movl $0, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.height_3:
.height_4:
	movq $8, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movq %r8, %rdi
	movq %r9, %rbx
	callq _c0_height
	movq %rbx, %r9
	movl %eax, %r8d
	movq $16, %rcx
	addq %rcx, %r9
	movq (%r9), %r9
	movq %r9, %rdi
	movq %r8, %rbx
	callq _c0_height
	movq %rbx, %r8
	movl %eax, %r9d
	cmpl %r8d, %r9d
	jl .ternary_true17
	addl $1, %r9d
	jmp .ternary_end18
.ternary_true17:
	movl %r8d, %r9d
	addl $1, %r9d
.ternary_end18:
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movq $0, %r9
	movl $0, %ecx
.main_5:
	movq %r9, %r8
	movl %ecx, %r9d
.main_1:
	movl $1, %esi
	movl $100000, %edx
	movl %r9d, %ecx
	cmpl %edx, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .main_3
.main_2:
	movl %r9d, %eax
	addl $17, %eax
	movl $28, %ecx
	cltd
	idivl %ecx
	movl %edx, %ecx
	movl %r9d, %eax
	addl $3, %eax
	movl $13, %esi
	cltd
	idivl %esi
	movl %edx, %esi
	movl %r9d, %eax
	addl $21, %eax
	movl $75, %edi
	cltd
	idivl %edi
	addl %esi, %ecx
	addl %edx, %ecx
	movl %ecx, %edi
	movq %r8, %rsi
	movq %r9, %rbx
	callq _c0_insert
	movq %rbx, %r9
	movq %rax, %r8
	addl $1, %r9d
.main_4:
	jmp .main_1
.main_3:
	movq %r8, %rdi
	callq _c0_height
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
