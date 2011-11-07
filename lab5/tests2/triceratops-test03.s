.file	"../tests2/triceratops-test03.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %r9d
.main_1:
	movl $1, %edx
	movl $0, %r8d
	movl $1, %ecx
	cmpl %ecx, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_15
.main_2:
	movl %r9d, %r8d
	addl $10, %r8d
.main_13:
	movl %r8d, %esi
.main_3:
	movl $1, %edx
	movl $1, %r8d
	movl $0, %ecx
	cmpl %ecx, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_9
.main_4:
	subl $10, %esi
.main_5:
	movl $1, %edx
	movl $1, %r8d
	addl $1, %r8d
	movl $2, %ecx
	cmpl %ecx, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_8
.main_6:
	movl $0, %eax
	addq $8, %rsp
	ret
.main_8:
.main_12:
	jmp .main_3
.main_9:
	jmp .main_14
.main_15:
.main_11:
	movl %r9d, %eax
	addq $8, %rsp
	ret
.main_14:
	movl %esi, %r9d
	jmp .main_11
.ident	"15-411 L4 reference compiler"
