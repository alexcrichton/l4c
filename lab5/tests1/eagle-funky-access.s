.file	"../tests1/eagle-funky-access.l4"
.globl _c0_main
_c0_main:
	addq $-40, %rsp
	movq %r14, 8(%rsp)
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
.main_0:
	movq $1, %rdi
	movq $4, %rsi
	callq calloc
	movq %rax, %r9
	movq $1, %rdi
	movq $4, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movq %rax, %rcx
	movq $1, %rdi
	movq $4, %rsi
	movq %rcx, %r12
	movq %r9, %rbx
	callq calloc
	movq %r12, %rcx
	movq %rbx, %r9
	movq %rax, %r8
	movq $1, %rdi
	movq $4, %rsi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, %rdx
	movq $3, %rdi
	movq $4, %rsi
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
	movq %r9, %rsi
	addq %rdi, %rsi
	movl $1, (%rsi)
	movq $0, %rdi
	movq %rcx, %rsi
	addq %rdi, %rsi
	movl $2, (%rsi)
	movq $0, %rdi
	movq %r8, %rsi
	addq %rdi, %rsi
	movl $3, (%rsi)
	movq $0, %rsi
	addq %rsi, %rdx
	movl $4, (%rdx)
	movq $0, %rdx
	addq %rdx, %r8
	movl (%r8), %esi
	movl $0, %r8d
	imull $4, %r8d
	movslq %r8d, %rdx
	movq %rax, %r8
	addq %rdx, %r8
	movq $0, %rdx
	addq %rdx, %r8
	movl %esi, (%r8)
	jmp .ternary_true1
	movq %rcx, %r8
	jmp .ternary_end2
.ternary_true1:
	movq %r9, %r8
.ternary_end2:
	movq $0, %rcx
	addq %rcx, %r8
	movl (%r8), %edx
	movl $1, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movq $0, %rcx
	addq %rcx, %r8
	movl %edx, (%r8)
	movl $0, %r8d
.main_5:
	movl %r8d, %edi
.main_1:
	movl $1, %edx
	movl $2, %ecx
	movl %edi, %r8d
	cmpl %ecx, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_3
.main_2:
	movl %edi, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movq $0, %rcx
	addq %rcx, %r8
	movl (%r8), %esi
	movl %edi, %r8d
	addl $1, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movq $0, %rcx
	addq %rcx, %r8
	movl (%r8), %edx
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl %esi, (%r8)
	addl %edx, (%r8)
	jmp .ternary_true3
	movl %edi, %r8d
	addl $1, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	jmp .ternary_end4
.ternary_true3:
	movl %edi, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rax, %r8
	addq %rcx, %r8
.ternary_end4:
	movq $0, %rcx
	addq %rcx, %r8
	movl (%r8), %ecx
	movq $0, %rdx
	movq %r9, %r8
	addq %rdx, %r8
	movl %ecx, (%r8)
	movl %edi, %r8d
	addl $1, %r8d
.main_4:
	movl %r8d, %edi
	jmp .main_1
.main_3:
	movl $4, %eax
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.ident	"15-411 L4 reference compiler"
