.file	"../tests2/saltopus-bitbang.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $7, %r9d
	movl $-1, %r8d
	xorl %r9d, %r8d
	addl $1, %r8d
	orl %r8d, %r9d
	sarl $31, %r9d
	movl %r9d, %eax
	addl $1, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
