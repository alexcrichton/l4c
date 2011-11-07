.file	"../tests1/falcon-return07.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1, %r9d
	movl $16, %eax
	movl $256, %edi
	movl $4096, %esi
	movl $65536, %edx
	movl $1048576, %r8d
	movl $16777216, %ecx
	xorl $8, %r8d
	xorl %r9d, %r8d
	movl %r8d, %r9d
	xorl %eax, %r9d
	xorl $2, %r9d
	xorl $20, %r9d
	xorl %edi, %r9d
	orl %esi, %r9d
	andl $-1, %r9d
	xorl %edx, %r9d
	movl %r9d, %eax
	xorl %ecx, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
