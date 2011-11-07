.file	"../tests2/diplodocus-div0.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1, %r9d
	movl %r9d, %eax
	imull %r9d, %eax
	cltd
	idivl %r9d
	movl %r9d, %r8d
	addl %r9d, %r8d
	subl %eax, %r8d
	movl %r8d, %edx
	andl %r9d, %edx
	movl $-1, %r8d
	xorl %r9d, %r8d
	movl %r9d, %ecx
	xorl %r8d, %ecx
	movl %edx, %r8d
	orl %ecx, %r8d
	movl %r9d, %eax
	cltd
	idivl %r9d
	movl %edx, %r9d
	movl %r8d, %eax
	cltd
	idivl %r9d
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
