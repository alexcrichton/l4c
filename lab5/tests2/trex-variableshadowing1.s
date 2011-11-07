.file	"../tests2/trex-variableshadowing1.l3"
.globl _c0_main
_c0_x:
	addq $-8, %rsp
.x_0:
	movl %edi, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1, %edi
	callq _c0_x
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
