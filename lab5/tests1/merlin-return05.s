.file	"../tests1/merlin-return05.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $10, %r9d
	movl $0, %ecx
	movl $0, %r8d
.main_8:
	movl %ecx, %edx
	movl %r8d, %esi
.main_1:
	movl $1, %ecx
	movl %esi, %r8d
	cmpl %r9d, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .main_3
.main_2:
	movl %edx, %ecx
	addl $2, %ecx
	movl %esi, %r8d
	addl $1, %r8d
.main_7:
	movl %ecx, %edx
	movl %r8d, %esi
	jmp .main_1
.main_3:
.main_10:
	movl %esi, %ecx
.main_4:
	movl $1, %r8d
	movl $0, %r9d
	cmpl %ecx, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %r8d
	jnz .main_6
.main_5:
	movl %edx, %r8d
	addl $7, %r8d
	movl %ecx, %r9d
	subl $1, %r9d
.main_9:
	movl %r8d, %edx
	movl %r9d, %ecx
	jmp .main_4
.main_6:
	movl %edx, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
