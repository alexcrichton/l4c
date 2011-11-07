.file	"../tests2/diplodocus-exception-stackfail.l3"
.globl _c0_main
_c0_gg:
	addq $-56, %rsp
	movq %r15, 16(%rsp)
	movq %r14, 24(%rsp)
	movq %r13, 32(%rsp)
	movq %r12, 40(%rsp)
	movq %rbx, 48(%rsp)
.gg_0:
	movl $1, %r9d
	movl $2, %r8d
	movl $3, %esi
	movl $4, %ecx
	movl $5, %edx
	movq %rsi, %r15
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_gg
	movq %r15, %rsi
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %edi
	addl %r9d, %edi
	movl %edi, %r9d
	addl %r8d, %r9d
	addl %esi, %r9d
	addl %ecx, %r9d
	movl %r9d, %eax
	addl %edx, %eax
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	callq _c0_gg
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
