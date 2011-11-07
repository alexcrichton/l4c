.file	"../tests1/hobby-alloc-array-absurdity.l4"
.globl _c0_main
_c0_main:
	addq $-40, %rsp
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
.main_0:
	movq $10, %rdi
	movq $4, %rsi
	callq calloc
	movq %rax, %r9
	movq $10, %rdi
	movq $8, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movq %rax, %rcx
	movq $10, %rdi
	movq $8, %rsi
	movq %rcx, %r12
	movq %r9, %rbx
	callq calloc
	movq %r12, %rcx
	movq %rbx, %r9
	movq %rax, %r8
	movq $10, %rdi
	movq $8, %rsi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $1, %edx
	imull $4, %edx
	movslq %edx, %rsi
	movq %r9, %rdx
	addq %rsi, %rdx
	movl $5, (%rdx)
	movl $2, %edx
	imull $8, %edx
	movslq %edx, %rsi
	movq %rcx, %rdx
	addq %rsi, %rdx
	movq %r9, (%rdx)
	movl $3, %r9d
	imull $8, %r9d
	movslq %r9d, %rdx
	movq %r8, %r9
	addq %rdx, %r9
	movq %rcx, (%r9)
	movl $4, %r9d
	imull $8, %r9d
	movslq %r9d, %rcx
	movq %rax, %r9
	addq %rcx, %r9
	movq %r8, (%r9)
	movl $4, %r9d
	imull $8, %r9d
	movslq %r9d, %r8
	movq %rax, %r9
	addq %r8, %r9
	movq (%r9), %rcx
	movl $3, %r9d
	imull $8, %r9d
	movslq %r9d, %r8
	movq %rcx, %r9
	addq %r8, %r9
	movq (%r9), %rcx
	movl $2, %r9d
	imull $8, %r9d
	movslq %r9d, %r8
	movq %rcx, %r9
	addq %r8, %r9
	movq (%r9), %r8
	movl $1, %r9d
	imull $4, %r9d
	movslq %r9d, %r9
	addq %r9, %r8
	movl (%r8), %r9d
	movl %r9d, %eax
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.ident	"15-411 L4 reference compiler"
