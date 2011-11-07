.file	"../tests2/diplodocus-return2.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $2, %r9d
	movl $2, %edx
	movl %r9d, %r8d
	addl %r9d, %r8d
	addl %r9d, %r8d
	movl %r8d, %ecx
	addl %r9d, %ecx
	movl %edx, %r9d
	imull %edx, %r9d
	movl %r9d, %r8d
	imull %edx, %r8d
	movl %ecx, %r9d
	subl %r8d, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
