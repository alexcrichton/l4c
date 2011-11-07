.file	"../tests1/condor-mbm_return1.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1, %r9d
	movl %r9d, %r8d
	addl %r9d, %r8d
	movl %r8d, %r9d
	addl %r8d, %r9d
	movl %r9d, %r8d
	addl %r9d, %r8d
	movl %r8d, %eax
	addl %r8d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
