.file	"../tests2/saltopus-mangle.l3"
.globl _c0_main
_c0__l3_main:
	addq $-8, %rsp
._l3_main_0:
	movl $6, %eax
	imull %edi, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $7, %edi
	callq _c0__l3_main
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
