.file	"../tests2/monoclonius-except02.l3"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	callq _c0_main
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
