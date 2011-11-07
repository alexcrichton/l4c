.file	"../tests2/galimimus-branch-return.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $2, %r9d
	movl $1, %ecx
	movl $0, %r8d
	cmpl %r9d, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .main_2
.main_1:
	movl $42, %eax
	addq $8, %rsp
	ret
.main_2:
	movl $0, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
