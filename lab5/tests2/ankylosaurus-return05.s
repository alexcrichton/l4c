.file	"../tests2/ankylosaurus-return05.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1, %r9d
.main_5:
	movl %r9d, %ecx
.main_1:
	movl $1, %r8d
	movl $0, %r9d
	cmpl %ecx, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %r8d
	jnz .main_3
.main_2:
	movl %ecx, %r9d
	sall $1, %r9d
.main_4:
	movl %r9d, %ecx
	jmp .main_1
.main_3:
	movl %ecx, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
