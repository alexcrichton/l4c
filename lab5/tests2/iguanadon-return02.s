.file	"../tests2/iguanadon-return02.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $5, %r9d
	addl $7, %r9d
	movl $3, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
