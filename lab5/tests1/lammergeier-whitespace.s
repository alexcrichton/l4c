.file	"../tests1/lammergeier-whitespace.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %r9d
	movl $1, %esi
	movl $2, %edx
	movl $3, %r8d
	addl %edx, %r8d
	movl $4, %ecx
	addl %edx, %r9d
	addl %ecx, %r8d
	addl %r8d, %r9d
	movl %r9d, %eax
	addl %esi, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
