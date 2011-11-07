.file	"../tests2/styracosaurus-swap.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $65535, %r9d
	movl $305419896, %r8d
	movl %r8d, %edx
	andl %r9d, %edx
	movl $-1, %ecx
	xorl %r9d, %ecx
	andl %ecx, %r8d
	movl %edx, %ecx
	sall $16, %ecx
	sarl $16, %r8d
	andl %r9d, %r8d
	movl %ecx, %r9d
	orl %r8d, %r9d
	movl $1, %ecx
	movl $1450709556, %r8d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_2
.main_1:
	movl $0, %eax
	addq $8, %rsp
	ret
.main_2:
	movl $0, %eax
	subl $1, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
