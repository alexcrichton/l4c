.file	"../tests2/diplodocus-div02.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %r9d
	movl $5, %r8d
	movl %r9d, %eax
	cltd
	idivl %r8d
	movl $294, %r8d
	addl $5, %r8d
	movl %r8d, %eax
	cltd
	idivl %r8d
	movl $5, %r8d
	subl $5, %r8d
	movl %r9d, %eax
	cltd
	idivl %r8d
	movl %edx, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
