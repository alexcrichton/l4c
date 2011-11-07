.file	"../tests1/merlin-meta1.l3"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $4, %r9d
	movl $9, %r8d
	movl %r9d, %esi
	xorl %r8d, %esi
	movl %esi, %ecx
	imull $9, %ecx
	movl $8, %eax
	cltd
	idivl %ecx
	cltd
	idivl %ecx
	movl %eax, %ecx
	imull %r9d, %ecx
	movl %ecx, %edx
	subl $1, %edx
	movl $39, %ecx
	imull %ecx, %r8d
	addl %r8d, %r9d
	subl %edx, %r9d
	movl %r9d, %eax
	addl %esi, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
