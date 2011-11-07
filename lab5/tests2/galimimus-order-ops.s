.file	"../tests2/galimimus-order-ops.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $8, %r9d
	movl $2, %r8d
	addl %r9d, %r8d
	movl %r8d, %eax
	sall $1, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
