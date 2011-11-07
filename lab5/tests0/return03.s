.file	"../tests0/return03.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1, %r9d
	movl $1, %edx
	movl $0, %ecx
	movl %r9d, %r8d
	cmpl %ecx, %r8d
	setne %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_2
.main_1:
	movl %r9d, %eax
	addl $1, %eax
	addq $8, %rsp
	ret
.main_2:
	movl %r9d, %eax
	subl $1, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
