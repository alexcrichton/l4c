.file	"../tests1/condor-nfh_return.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1, %r9d
	movl $1, %ecx
	movl %ecx, %r8d
	addl %r9d, %r8d
	movl %r8d, %edx
	addl %ecx, %edx
	movl %edx, %ecx
	addl %r8d, %ecx
	movl %ecx, %r8d
	addl %edx, %r8d
	movl %r8d, %r9d
	addl %ecx, %r9d
	movl %r9d, %ecx
	addl %r8d, %ecx
	movl %ecx, %r8d
	addl %r9d, %r8d
	movl %r8d, %r9d
	addl %ecx, %r9d
	addl %r8d, %r9d
	addl %edx, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
