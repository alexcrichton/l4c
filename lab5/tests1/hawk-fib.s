.file	"../tests1/hawk-fib.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %r9d
	movl $1, %ecx
	movl %r9d, %r8d
	addl %ecx, %r8d
	movl %r8d, %r9d
	addl %ecx, %r9d
	movl %r9d, %eax
	addl %r8d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
