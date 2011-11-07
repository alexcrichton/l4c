.file	"../tests2/diplodocus-dec.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $2, %r9d
	movl %r9d, %r8d
	imull %r9d, %r8d
	movl %r8d, %esi
	addl %r9d, %esi
	movl $1, %edx
	movl %r8d, %ecx
	sall %cl, %edx
	addl %r8d, %r9d
	movl %r9d, %ecx
	addl %esi, %ecx
	movl %edx, %r9d
	sall %cl, %r9d
	movl %r9d, %eax
	sarl $16, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
