.file	"../tests2/triceratops-test07.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %r9d
.main_22:
	movl %r9d, %esi
.main_1:
	movl $1, %ecx
	movl $10, %r8d
	movl %esi, %r9d
	cmpl %r8d, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_20
.main_2:
	movl $0, %r9d
.main_23:
	movl %r9d, %edx
.main_3:
	movl $1, %ecx
	movl $10, %r8d
	movl %edx, %r9d
	cmpl %r8d, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_19
.main_4:
	movl %edx, %r9d
	addl $1, %r9d
	jmp .main_24
.main_19:
	movl %esi, %r9d
	addl $1, %r9d
.main_21:
	movl %r9d, %esi
	jmp .main_1
.main_20:
	movl $0, %eax
	addq $8, %rsp
	ret
.main_24:
	movl %r9d, %edx
	jmp .main_3
.ident	"15-411 L4 reference compiler"
