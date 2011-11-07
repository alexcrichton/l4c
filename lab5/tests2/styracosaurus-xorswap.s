.file	"../tests2/styracosaurus-xorswap.l3"
.globl _c0_main
_c0_xorswap:
	addq $-8, %rsp
.xorswap_0:
	movl %edi, %r9d
	xorl %esi, %r9d
	movl %esi, %r8d
	xorl %r9d, %r8d
	xorl %r8d, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $3, %r9d
	movl $5, %r8d
	movl %r9d, %ecx
	sall %cl, %r8d
	movl %r9d, %edi
	movl %r8d, %esi
	callq _c0_xorswap
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
