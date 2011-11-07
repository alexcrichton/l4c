.file	"../tests1/lammergeier-overflow.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $-2147483648, %r9d
	addl $-2147483648, %r9d
	movl $1, %eax
	cltd
	idivl %r9d
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
