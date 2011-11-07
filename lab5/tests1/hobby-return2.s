.file	"../tests1/hobby-return2.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %r8d
	subl $1, %r8d
	movl $7, %r9d
	movl $29, %ecx
	movl %r8d, %eax
	imull %ecx, %eax
	cltd
	idivl %r9d
	movl %eax, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
