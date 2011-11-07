.file	"../tests1/eagle-return01.l3"
.globl _c0_main
_c0_inc:
	addq $-8, %rsp
.inc_0:
	movl %edi, %eax
	addl $1, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1, %edi
	callq _c0_inc
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
