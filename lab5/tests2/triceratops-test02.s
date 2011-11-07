.file	"../tests2/triceratops-test02.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %r9d
	movl $10, %esi
.main_8:
	movl %r9d, %edx
.main_1:
	movl $1, %r8d
	movl %edx, %r9d
	cmpl %esi, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %r8d
	jnz .main_6
.main_2:
	movl $1, %ecx
	movl $9, %r8d
	movl %edx, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_4
.main_3:
	movl $10, %r9d
.main_10:
.main_5:
	addl $1, %r9d
.main_7:
	movl %r9d, %edx
	jmp .main_1
.main_4:
.main_9:
	movl %edx, %r9d
	jmp .main_5
.main_6:
	movl %edx, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
