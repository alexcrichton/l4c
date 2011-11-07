.file	"../tests1/griffon-tests14.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %r9d
	movl $1, %r8d
	addl %r8d, %r9d
	movl $1, %r8d
	addl %r8d, %r9d
	movl $3, %r8d
	addl %r8d, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
