.file	"../tests1/osprey-return01.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1, %r9d
	imull $1, %r9d
	imull $1, %r9d
	imull $1, %r9d
	imull $1, %r9d
	movl %r9d, %r8d
	addl %r9d, %r8d
	addl %r9d, %r8d
	addl %r9d, %r8d
	movl %r8d, %ecx
	addl %r9d, %ecx
	movl %ecx, %r8d
	subl %ecx, %r8d
	subl %ecx, %r8d
	subl %ecx, %r8d
	movl %r8d, %eax
	subl %ecx, %eax
	cltd
	idivl %r9d
	cltd
	idivl %r9d
	cltd
	idivl %r9d
	cltd
	idivl %r9d
	movl %eax, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
