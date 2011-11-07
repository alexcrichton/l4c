.file	"../tests1/lammergeier-sceptile.l4"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movq $0, %r9
	movq %r9, %r8
	movl (%r8), %r8d
	movl %r8d, (%r9)
	movl $0, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
