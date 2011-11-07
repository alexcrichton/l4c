.file	"../tests1/harrier-return_3.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $10, %r8d
	movl %r8d, %r9d
	addl $1, %r9d
	movl %r8d, %eax
	imull %r9d, %eax
	movl $2, %r9d
	cltd
	idivl %r9d
	movl %eax, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
