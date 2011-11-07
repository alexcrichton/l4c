.file	"../tests2/ankylosaurus-return08.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1, %r9d
	movl $-1, %r8d
	xorl %r9d, %r8d
	addl $1, %r8d
	movl $1, %edx
	movl $0, %ecx
	cmpl %ecx, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_3
.main_1:
	movl $10, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.main_3:
.main_4:
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
