.file	"../tests2/styracosaurus-simple1.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $3, %r9d
	movl $5, %r8d
	movl %r9d, %ecx
	sall %cl, %r8d
	xorl %r8d, %r9d
	xorl %r9d, %r8d
	xorl %r8d, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
