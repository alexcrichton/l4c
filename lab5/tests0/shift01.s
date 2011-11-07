.file	"../tests0/shift01.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1, %ecx
	movl %ecx, %r9d
	sall %cl, %r9d
	sall $33, %r9d
	movl %r9d, %r8d
	sarl $1, %r8d
	movl $-1, %r9d
	xorl %r8d, %r9d
	sarl $33, %r9d
	movl %r9d, %r8d
	orl $1, %r8d
	movl $1, %r9d
	sall $31, %r9d
	movl %r8d, %ecx
	andl %r9d, %ecx
	movl $1, %r9d
	sall $31, %r9d
	movl %r9d, %r8d
	sarl $31, %r8d
	movl %ecx, %r9d
	xorl %r8d, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
