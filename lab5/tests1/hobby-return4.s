.file	"../tests1/hobby-return4.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $43, %r9d
	movl $6, %r8d
	movl $5, %esi
	imull $2, %esi
	movl %r9d, %eax
	cltd
	idivl %r8d
	movl %eax, %ecx
	movl %r9d, %eax
	cltd
	idivl %r8d
	movl %edx, %r9d
	movl %ecx, %r8d
	addl %r9d, %r8d
	movl %r8d, %eax
	subl %esi, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
