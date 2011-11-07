.file	"../tests2/diplodocus-multest.l4"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $5, %r9d
	movl %r9d, %r8d
	imull %r9d, %r8d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
