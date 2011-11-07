.file	"../tests1/osprey-exception02.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $5, %eax
	movl $2, %r9d
	cltd
	idivl %r9d
	movl %eax, %r8d
	movl $8, %eax
	movl $1, %r9d
	cltd
	idivl %r9d
	movl %edx, %r9d
	movl %r8d, %eax
	cltd
	idivl %r9d
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
