.file	"../tests1/goshawk-return07.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1966182434, %r9d
	movl $-1, %ecx
	xorl $0, %ecx
	movl %r9d, %r8d
	xorl %ecx, %r8d
	movl %r8d, %eax
	andl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
