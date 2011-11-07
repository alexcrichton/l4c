.file	"../tests1/falcon-return08.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1, %r9d
	andl $1, %r9d
	andl $3, %r9d
	andl $5, %r9d
	andl $241, %r9d
	movl %r9d, %eax
	xorl $1, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
