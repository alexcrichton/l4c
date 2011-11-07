.file	"../tests2/trex-interesting01.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %r9d
	movl $0, %ecx
	movl $1, %r8d
	sall %cl, %r8d
	orl %r8d, %r9d
	movl $3, %ecx
	movl $1, %r8d
	sall %cl, %r8d
	movl %r9d, %edx
	orl %r8d, %edx
	movl $4, %ecx
	movl $1, %r9d
	sall %cl, %r9d
	movl %edx, %r8d
	orl %r9d, %r8d
	movl $5, %ecx
	movl $1, %r9d
	sall %cl, %r9d
	orl %r9d, %r8d
	movl $8, %ecx
	movl $1, %edx
	sall %cl, %edx
	movl %r8d, %r9d
	orl %edx, %r9d
	movl $10, %ecx
	movl $1, %r8d
	sall %cl, %r8d
	orl %r8d, %r9d
	movl $0, %ecx
	movl $1, %r8d
	sall %cl, %r8d
	orl %r8d, %r9d
	movl $1, %ecx
	movl $1, %edx
	sall %cl, %edx
	movl %r9d, %r8d
	orl %edx, %r8d
	movl $17, %ecx
	movl $1, %r9d
	sall %cl, %r9d
	orl %r9d, %r8d
	movl $1, %ecx
	movl $1, %r9d
	sall %cl, %r9d
	movl $-1, %ecx
	xorl %r9d, %ecx
	movl %r8d, %r9d
	andl %ecx, %r9d
	movl $17, %ecx
	movl $1, %r8d
	sall %cl, %r8d
	movl $-1, %ecx
	xorl %r8d, %ecx
	andl %ecx, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
