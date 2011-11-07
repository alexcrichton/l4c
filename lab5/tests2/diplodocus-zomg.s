.file	"../tests2/diplodocus-zomg.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $99, %r8d
	movl $1, %r9d
	movl %r8d, %ecx
	sall $16, %ecx
	movl %r9d, %r8d
	sall $4, %r8d
	movl %ecx, %r9d
	movl %r8d, %ecx
	sarl %cl, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
