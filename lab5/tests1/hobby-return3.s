.file	"../tests1/hobby-return3.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $22, %r9d
	addl $1, %r9d
	movl $77, %r8d
	movl $9, %ecx
	movl %r8d, %eax
	subl %ecx, %eax
	cltd
	idivl %r9d
	movl %edx, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
