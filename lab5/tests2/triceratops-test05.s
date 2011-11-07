.file	"../tests2/triceratops-test05.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %r9d
.main_12:
	movl %r9d, %esi
.main_1:
	movl $1, %ecx
	movl $10, %r8d
	movl %esi, %r9d
	cmpl %r8d, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_10
.main_2:
	movl $0, %r9d
.main_14:
	movl %r9d, %ecx
.main_3:
	movl $1, %r8d
	movl $1, %r9d
	cmpl %r9d, %r8d
	jnz .main_9
.main_4:
	movl %ecx, %edx
	addl $1, %edx
	movl $0, %ecx
.main_5:
	movl $1, %r8d
	movl $1, %r9d
	cmpl %r9d, %r8d
	jnz .main_8
.main_6:
	movl %ecx, %r9d
	addl $1, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.main_8:
	movl %edx, %r9d
	addl $0, %r9d
.main_13:
	movl %r9d, %ecx
	jmp .main_3
.main_9:
	movl %esi, %r9d
	addl $1, %r9d
.main_11:
	movl %r9d, %esi
	jmp .main_1
.main_10:
	movl $0, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
