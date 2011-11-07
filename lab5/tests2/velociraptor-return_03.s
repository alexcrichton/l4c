.file	"../tests2/velociraptor-return_03.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1, %ecx
	movl $2, %r9d
	movl $4, %r8d
	movl %ecx, %esi
	orl %r9d, %esi
	orl %r8d, %r9d
	movl %r9d, %ecx
	xorl %esi, %ecx
	movl %r8d, %edx
	xorl %ecx, %edx
	movl %esi, %r8d
	addl %r9d, %r8d
	movl %r8d, %ecx
	addl %edx, %ecx
	movl %esi, %r8d
	sall %cl, %r8d
	movl %r8d, %ecx
	xorl %edx, %ecx
	sall %cl, %r9d
	movl %r9d, %eax
	xorl %edx, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
