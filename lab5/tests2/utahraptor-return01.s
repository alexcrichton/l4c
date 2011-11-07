.file	"../tests2/utahraptor-return01.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $10, %r9d
	movl $5, %r8d
	sall $4, %r8d
	sarl $3, %r8d
	andl %r9d, %r8d
	orl %r9d, %r8d
	xorl %r9d, %r8d
	movl %r8d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
