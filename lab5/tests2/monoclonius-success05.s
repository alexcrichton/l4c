.file	"../tests2/monoclonius-success05.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1, %ecx
	sall $24, %ecx
	movl $1, %eax
	sall %cl, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
