.file	"../tests2/diplodocus-error-lvalue-postfix.l4"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movq $1, %rdi
	movq $4, %rsi
	callq calloc
	movq %rax, %r9
	movl $5, (%r9)
	movq %rax, %r8
	movq %rax, %r9
	movl (%r9), %r9d
	movl %r9d, (%r8)
	addl $1, (%r8)
	movq %rax, %r9
	movl (%r9), %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
