.file	"../tests2/ankylosaurus-return06.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1, %r9d
.main_9:
	movl %r9d, %ecx
.main_1:
	movl $1, %r8d
	movl $1, %r9d
	cmpl %r9d, %r8d
	jnz .main_11
.main_2:
	movl %ecx, %edx
	sall $1, %edx
	movl $1, %ecx
	movl $0, %r8d
	movl %edx, %r9d
	cmpl %r8d, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_5
.main_3:
	jmp .main_10
.main_5:
.main_6:
.main_8:
	movl %edx, %ecx
	jmp .main_1
.main_11:
	movl %ecx, %r9d
.main_7:
	movl %r9d, %eax
	addq $8, %rsp
	ret
.main_10:
	movl %edx, %r9d
	jmp .main_7
.ident	"15-411 L4 reference compiler"
