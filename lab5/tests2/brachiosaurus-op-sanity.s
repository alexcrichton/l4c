.file	"../tests2/brachiosaurus-op-sanity.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %r9d
	movl $2, %r8d
	movl %r8d, %edx
	andl %r9d, %edx
	movl %r9d, %ecx
	sall $2, %ecx
	movl %ecx, %esi
	sarl $5, %esi
	movl %r8d, %ecx
	xorl %esi, %ecx
	movl %edx, %esi
	orl %ecx, %esi
	movl $3, %eax
	movl $4, %ecx
	cltd
	idivl %ecx
	movl $0, %ecx
	addl %r9d, %r8d
	movl %r8d, %r9d
	cmpl %edx, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	movl %ecx, %r8d
	cmpl %r9d, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	movl $1, %r9d
	xorl %r8d, %r9d
	movl %esi, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
