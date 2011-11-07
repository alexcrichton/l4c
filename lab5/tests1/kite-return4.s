.file	"../tests1/kite-return4.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %r9d
	subl $1, %r9d
	movl $0, %eax
	addl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
