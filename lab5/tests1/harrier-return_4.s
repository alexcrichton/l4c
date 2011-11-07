.file	"../tests1/harrier-return_4.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $43, %r8d
	movl $2, %r9d
	addl %r9d, %r8d
	movl %r8d, %eax
	cltd
	idivl %r9d
	movl %edx, %r9d
	movl %r8d, %eax
	cltd
	idivl %r9d
	movl %eax, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
