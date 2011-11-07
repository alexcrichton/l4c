.file	"../tests1/merlin-apples.l3"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	callq _c0_apple
	addq $8, %rsp
	ret
_c0_apple:
	addq $-8, %rsp
.apple_0:
	movl $0, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
