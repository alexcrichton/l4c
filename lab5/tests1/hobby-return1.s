.file	"../tests1/hobby-return1.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $5, %r9d
	movl $3, %edx
	movl $2, %ecx
	movl $0, %r8d
	imull %edx, %r9d
	addl %ecx, %r9d
	movl %r9d, %eax
	subl %r8d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
