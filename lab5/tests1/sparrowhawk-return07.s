.file	"../tests1/sparrowhawk-return07.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1, %r9d
	movl $2, %ecx
	movl $3, %edx
	movl $4, %r8d
	addl %edx, %ecx
	imull %ecx, %r8d
	subl %r9d, %r8d
	movl %r8d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
