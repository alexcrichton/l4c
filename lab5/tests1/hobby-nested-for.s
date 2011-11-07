.file	"../tests1/hobby-nested-for.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %r9d
	movl $0, %r8d
.main_11:
	movl %r9d, %edx
	movl %r8d, %edi
.main_1:
	movl $1, %ecx
	movl $10, %r8d
	movl %edi, %r9d
	cmpl %r8d, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_9
.main_2:
	movl $0, %r9d
.main_13:
	movl %edx, %esi
	movl %r9d, %edx
.main_3:
	movl $1, %ecx
	movl $6, %r8d
	movl %edx, %r9d
	cmpl %r8d, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_5
.main_4:
	movl %esi, %r8d
	addl $1, %r8d
	movl %edx, %r9d
	addl $1, %r9d
.main_12:
	movl %r8d, %esi
	movl %r9d, %edx
	jmp .main_3
.main_5:
	movl $0, %r9d
.main_15:
	movl %r9d, %edx
.main_6:
	movl $1, %ecx
	movl $5, %r8d
	movl %edx, %r9d
	cmpl %r8d, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_8
.main_7:
	movl %esi, %r8d
	imull $2, %r8d
	movl %edx, %r9d
	addl $1, %r9d
.main_14:
	movl %r8d, %esi
	movl %r9d, %edx
	jmp .main_6
.main_8:
	movl %esi, %r8d
	subl $50, %r8d
	movl %edi, %r9d
	addl $1, %r9d
.main_10:
	movl %r8d, %edx
	movl %r9d, %edi
	jmp .main_1
.main_9:
	movl %edx, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
