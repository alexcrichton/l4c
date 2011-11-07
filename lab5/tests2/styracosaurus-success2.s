.file	"../tests2/styracosaurus-success2.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $5, %r9d
	movl $10, %r8d
	addl $1, %r8d
	imull %r8d, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
