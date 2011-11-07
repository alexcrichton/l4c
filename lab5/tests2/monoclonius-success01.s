.file	"../tests2/monoclonius-success01.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1, %r9d
	sall $31, %r9d
	movl %r9d, %eax
	sarl $31, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
