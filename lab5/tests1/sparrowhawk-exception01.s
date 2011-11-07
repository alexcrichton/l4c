.file	"../tests1/sparrowhawk-exception01.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $4, %r9d
	movl $6, %r8d
	movl %r9d, %eax
	cltd
	idivl %r8d
	movl %eax, %r8d
	movl %r9d, %eax
	cltd
	idivl %r8d
	movl %eax, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
