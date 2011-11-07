.file	"../tests2/iguanadon-return01.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $4, %r8d
	movl $9, %ecx
	movl $3, %edx
	movl $7, %r9d
	addl %ecx, %r8d
	addl %edx, %r8d
	movl %r8d, %eax
	addl %r9d, %eax
	movl $4, %r9d
	cltd
	idivl %r9d
	movl %eax, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
