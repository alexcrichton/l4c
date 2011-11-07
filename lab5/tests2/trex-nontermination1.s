.file	"../tests2/trex-nontermination1.l3"
.globl _c0_main
_c0_f:
	addq $-8, %rsp
.f_0:
	callq _c0_f
	addq $8, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	callq _c0_f
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
