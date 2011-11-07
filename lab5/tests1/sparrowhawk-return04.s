.file	"../tests1/sparrowhawk-return04.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $2147483647, %r9d
	addl $1, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
