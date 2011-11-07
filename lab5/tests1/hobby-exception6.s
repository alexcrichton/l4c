.file	"../tests1/hobby-exception6.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %r9d
	subl $-2147483648, %r9d
	movl $0, %r8d
	subl $1, %r8d
	movl %r9d, %eax
	cltd
	idivl %r8d
	movl %eax, %ecx
	movl %r9d, %eax
	cltd
	idivl %r8d
	movl %ecx, %eax
	addl %edx, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
