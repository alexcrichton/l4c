.file	"../tests2/iguanadon-exception02.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $5, %eax
	movl $0, %r9d
	cltd
	idivl %r9d
	movl %edx, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
