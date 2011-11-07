.file	"../tests1/sparrowhawk-return02.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $8, %r9d
	movl $4, %r8d
	movl %r9d, %eax
	cltd
	idivl %r8d
	movl %r9d, %ecx
	addl %r8d, %ecx
	movl %r9d, %r8d
	addl %ecx, %r8d
	movl %r9d, %eax
	addl %r8d, %eax
	cltd
	idivl %r8d
	movl %r8d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
