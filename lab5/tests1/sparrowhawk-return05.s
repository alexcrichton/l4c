.file	"../tests1/sparrowhawk-return05.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $55, %r9d
	movl $42, %r8d
	addl %r9d, %r8d
	movl %r8d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
