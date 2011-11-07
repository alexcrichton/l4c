.file	"../tests1/kestrel-nope.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1, %eax
	movl $1, %r8d
	sall $25, %r8d
	movl $1, %r9d
	sall $57, %r9d
	movl %r8d, %ecx
	xorl %r9d, %ecx
	movl $1, %r8d
	sall %cl, %r8d
	movl $1, %r9d
	movl %r8d, %ecx
	sarl %cl, %r9d
	cltd
	idivl %r9d
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
