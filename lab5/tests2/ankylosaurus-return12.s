.file	"../tests2/ankylosaurus-return12.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1, %r9d
	movl $0, %ecx
	xorl %ecx, %r9d
	movl %r9d, %r8d
	xorl %ecx, %r8d
	xorl %r8d, %r9d
	movl %r8d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
