.file	"../tests1/lammergeier-swampert.l4"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movq $1, %rdi
	movq $8, %rsi
	callq calloc
	movq $0, %r8
	movq %rax, %r9
	addq %r8, %r9
	movq (%r9), %rcx
	movq $0, %r8
	movq %rax, %r9
	addq %r8, %r9
	movq (%r9), %r9
	movl (%r9), %r8d
	movq %rcx, %r9
	movl %r8d, (%r9)
	movl $0, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
