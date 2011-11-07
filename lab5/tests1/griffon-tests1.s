.file	"../tests1/griffon-tests1.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1, %r9d
	movl $2, %edx
	movl $1, %r8d
	movl %r9d, %ecx
	addl %r8d, %ecx
	movl $2, %r8d
	movl %edx, %r9d
	addl %r8d, %r9d
	movl %r9d, %eax
	addl %ecx, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
