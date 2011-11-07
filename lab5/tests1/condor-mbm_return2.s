.file	"../tests1/condor-mbm_return2.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %r9d
	movl %r9d, %eax
	imull $0, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
