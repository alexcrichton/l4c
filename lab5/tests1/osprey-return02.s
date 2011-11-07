.file	"../tests1/osprey-return02.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $34, %eax
	movl $6, %r9d
	cltd
	idivl %r9d
	movl %eax, %r8d
	imull $2, %r8d
	movl $2, %r9d
	subl %r8d, %r9d
	movl %r9d, %r8d
	subl $5, %r8d
	movl $1, %r9d
	addl %r8d, %r9d
	movl %r9d, %ecx
	addl $2, %ecx
	movl %ecx, %r9d
	subl $3, %r9d
	movl %r9d, %eax
	imull %ecx, %eax
	movl $3, %r9d
	cltd
	idivl %r9d
	movl $4, %r9d
	cltd
	idivl %r9d
	movl %edx, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
