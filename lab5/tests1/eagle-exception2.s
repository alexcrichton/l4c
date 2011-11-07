.file	"../tests1/eagle-exception2.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $4, %eax
	movl $8, %r9d
	movl $2, %r8d
	imull %eax, %r8d
	subl %r8d, %r9d
	cltd
	idivl %r9d
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
