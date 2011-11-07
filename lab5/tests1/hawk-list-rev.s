.file	"../tests1/hawk-list-rev.l4"
.globl _c0_main
_c0_reverse:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movq %rdi, %r9
.reverse_0:
	movq $0, %r8
	cmpq %r8, %r9
	jz .ternary_true1
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movq $0, %rcx
	cmpq %rcx, %r8
	sete %cl
	movzbl %cl, %ecx
	jmp .ternary_end2
.ternary_true1:
	movl $1, %ecx
.ternary_end2:
	movl $1, %r8d
	cmpl %ecx, %r8d
	jnz .reverse_3
.reverse_1:
	movq %r9, %rax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.reverse_3:
.reverse_4:
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movq %r8, %rdi
	movq %r9, %rbx
	callq _c0_reverse
	movq %rbx, %r9
	movq %rax, %rdi
	movq %rdi, %r8
.reverse_9:
	movq %r8, %rsi
.reverse_5:
	movq $0, %rcx
	movq %rsi, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movl $1, %edx
	movq $0, %rcx
	cmpq %rcx, %r8
	setne %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .reverse_7
.reverse_6:
	movq $0, %rcx
	movq %rsi, %r8
	addq %rcx, %r8
	movq (%r8), %r8
.reverse_8:
	movq %r8, %rsi
	jmp .reverse_5
.reverse_7:
	movq $0, %rcx
	movq %rsi, %r8
	addq %rcx, %r8
	movq %r9, (%r8)
	movq $0, %r8
	addq %r8, %r9
	movq $0, (%r9)
	movq %rdi, %rax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_main:
	addq $-56, %rsp
	movq %r15, 16(%rsp)
	movq %r14, 24(%rsp)
	movq %r13, 32(%rsp)
	movq %r12, 40(%rsp)
	movq %rbx, 48(%rsp)
.main_0:
	movq $1, %rdi
	movq $12, %rsi
	callq calloc
	movq %rax, %r9
	movq $1, %rdi
	movq $12, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movq %rax, %r8
	movq %r8, %r12
	movq %r9, %rbx
	callq readint
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %esi
	movq $8, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movl %esi, (%rcx)
	movq $8, %rdx
	movq %r8, %rcx
	addq %rdx, %rcx
	movl %esi, (%rcx)
	movq %r9, %rcx
.main_22:
	movq %rcx, %rdx
	movq %r8, %rbx
.main_1:
	movq %rdx, %r13
	movq %r9, %r12
	callq eof
	movq %r13, %rdx
	movq %r12, %r9
	movl $1, %esi
	movl $1, %ecx
	xorl %eax, %ecx
	cmpl %ecx, %esi
	jnz .main_3
.main_2:
	movq %rdx, %r13
	movq %r9, %r12
	callq readint
	movq %r13, %rdx
	movq %r12, %r9
	movl %eax, %r8d
	movq $0, %rsi
	movq %rdx, %rcx
	addq %rsi, %rcx
	movq $1, %rdi
	movq $12, %rsi
	movq %rdx, %r15
	movq %rcx, %r14
	movq %r8, %r13
	movq %r9, %r12
	callq calloc
	movq %r15, %rdx
	movq %r14, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movq %rax, (%rcx)
	movq $0, %rsi
	movq %rdx, %rcx
	addq %rsi, %rcx
	movq (%rcx), %rcx
	movq $8, %rsi
	movq %rcx, %rdx
	addq %rsi, %rdx
	movl %r8d, (%rdx)
	movq %rbx, %rdx
	movq $1, %rdi
	movq $12, %rsi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movq $0, %rdi
	movq %rax, %rsi
	addq %rdi, %rsi
	movq %rdx, (%rsi)
	movq $8, %rsi
	movq %rax, %rdx
	addq %rsi, %rdx
	movl %r8d, (%rdx)
.main_21:
	movq %rcx, %rdx
	movq %rax, %rbx
	jmp .main_1
.main_3:
	movq %r9, %rdi
	callq _c0_reverse
	movq %rax, %r9
	movl $0, %r8d
.main_24:
	movl %r8d, %eax
	movq %r9, %rdi
	movq %rbx, %rsi
.main_4:
	movq $0, %r8
	movq %rdi, %r9
	addq %r8, %r9
	movq (%r9), %r8
	movq $0, %r9
	cmpq %r9, %r8
	jnz .ternary_true3
	movl $0, %r8d
	jmp .ternary_end4
.ternary_true3:
	movq $0, %r8
	movq %rsi, %r9
	addq %r8, %r9
	movq (%r9), %r9
	movq $0, %r8
	cmpq %r8, %r9
	setne %r8b
	movzbl %r8b, %r8d
.ternary_end4:
	movl $1, %r9d
	cmpl %r8d, %r9d
	jnz .main_10
.main_5:
	movq $8, %r8
	movq %rdi, %r9
	addq %r8, %r9
	movl (%r9), %edx
	movq $8, %r8
	movq %rsi, %r9
	addq %r8, %r9
	movl (%r9), %ecx
	movl $1, %r8d
	movl %edx, %r9d
	cmpl %ecx, %r9d
	setne %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %r8d
	jnz .main_8
.main_6:
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
.main_8:
.main_9:
	movq $0, %r8
	movq %rdi, %r9
	addq %r8, %r9
	movq (%r9), %r9
	movq %r9, %rcx
	movq $0, %r8
	movq %rsi, %r9
	addq %r8, %r9
	movq (%r9), %r9
	movq %r9, %r8
	movl %eax, %r9d
	addl $1, %r9d
.main_23:
	movl %r9d, %eax
	movq %rcx, %rdi
	movq %r8, %rsi
	jmp .main_4
.main_10:
	movq $0, %r8
	movq %rdi, %r9
	addq %r8, %r9
	movq (%r9), %r9
	movl $1, %ecx
	movq $0, %r8
	cmpq %r8, %r9
	setne %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_13
.main_11:
	movl $1, %eax
	movl $0, %r9d
	cltd
	idivl %r9d
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
.main_13:
.main_14:
	movq $0, %r9
	movq %rsi, %r8
	addq %r9, %r8
	movq (%r8), %r9
	movl $1, %ecx
	movq $0, %r8
	cmpq %r8, %r9
	setne %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_19
.main_15:
.main_16:
	movl $1, %r9d
	movl $1, %r8d
	cmpl %r8d, %r9d
	jnz .main_18
.main_17:
	jmp .main_16
.main_18:
.main_20:
	movl $0, %eax
	subl $1, %eax
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
.main_19:
	jmp .main_20
.ident	"15-411 L4 reference compiler"
