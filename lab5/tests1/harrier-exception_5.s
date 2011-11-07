.file	"../tests1/harrier-exception_5.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $42, %eax
	movl $2, %r9d
	movl $2, %r8d
	cltd
	idivl %r8d
	movl %edx, %r8d
	movl %r9d, %eax
	cltd
	idivl %r8d
	movl %edx, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
