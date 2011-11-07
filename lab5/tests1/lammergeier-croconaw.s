.file	"../tests1/lammergeier-croconaw.l3"
.globl _c0_main
_c0_foobar:
	addq $-8, %rsp
.foobar_0:
	movl $1, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	callq _c0_foobar
	movl %eax, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
