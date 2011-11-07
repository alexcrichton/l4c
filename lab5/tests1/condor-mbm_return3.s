.file	"../tests1/condor-mbm_return3.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $2, %r9d
	movl %r9d, %r8d
	addl $0, %r8d
	movl $2, %eax
	imull %r8d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
