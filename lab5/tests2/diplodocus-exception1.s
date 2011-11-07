.file	"../tests2/diplodocus-exception1.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $2, %r9d
	movl $4, %eax
	movl $2, %ecx
	imull %r9d, %ecx
	movl %eax, %r9d
	subl %ecx, %r9d
	cltd
	idivl %r9d
	movl %eax, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
