.file	"../tests1/sparrowhawk-lotsofstructs.l4"
.globl _c0_main
_c0_main:
	addq $-40, %rsp
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
.main_0:
	movq $1, %rdi
	movq $16, %rsi
	callq calloc
	movq %rax, %r9
	movq $1, %rdi
	movq $16, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movq %rax, %rcx
	movq $1, %rdi
	movq $16, %rsi
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
	movq $0, %rsi
	movq %rax, %rdx
	addq %rsi, %rdx
	movl $1, (%rdx)
	movq $0, %rsi
	movq %r8, %rdx
	addq %rsi, %rdx
	movl $1, (%rdx)
	movq $0, %rsi
	movq %rcx, %rdx
	addq %rsi, %rdx
	movl $1, (%rdx)
	movq $0, %rsi
	movq %r9, %rdx
	addq %rsi, %rdx
	movl $1, (%rdx)
	movq $8, %rsi
	movq %r9, %rdx
	addq %rsi, %rdx
	movq %rcx, (%rdx)
	movq $8, %rdx
	addq %rdx, %rcx
	movq %r8, (%rcx)
	movq $8, %rcx
	addq %rcx, %r8
	movq %rax, (%r8)
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl (%r8), %esi
	movq $8, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movq $0, %rcx
	addq %rcx, %r8
	movl (%r8), %edx
	movq $8, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movq $8, %rcx
	addq %rcx, %r8
	movq (%r8), %r8
	movq $0, %rcx
	addq %rcx, %r8
	movl (%r8), %ecx
	movq $8, %r8
	addq %r8, %r9
	movq (%r9), %r9
	movq $8, %r8
	addq %r8, %r9
	movq (%r9), %r9
	movq $8, %r8
	addq %r8, %r9
	movq (%r9), %r9
	movq $0, %r8
	addq %r8, %r9
	movl (%r9), %r8d
	movl %esi, %r9d
	addl %edx, %r9d
	addl %ecx, %r9d
	movl %r9d, %eax
	addl %r8d, %eax
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.ident	"15-411 L4 reference compiler"
