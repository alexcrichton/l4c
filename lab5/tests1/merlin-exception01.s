.file	"../tests1/merlin-exception01.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $2147483647, %ecx
	movl %ecx, %eax
	addl $1, %eax
	movl %ecx, %r9d
	addl $1, %r9d
	addl %ecx, %r9d
	cltd
	idivl %r9d
	movl %eax, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
