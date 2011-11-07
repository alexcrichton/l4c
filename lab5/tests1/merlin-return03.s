.file	"../tests1/merlin-return03.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $3, %r9d
	movl $3, %r8d
	movl $0, %edi
	subl %r9d, %edi
	movl $1, %edx
	movl %r9d, %esi
	movl %r8d, %ecx
	sall %cl, %esi
	cmpl %esi, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	movl $1, %ecx
	xorl %r8d, %ecx
	cmpl %ecx, %edx
	jnz .main_2
.main_1:
	movl $0, %eax
	addq $8, %rsp
	ret
.main_2:
	movl %r9d, %r8d
	andl %edi, %r8d
	movl %r9d, %eax
	xorl %r8d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
