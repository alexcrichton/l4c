.file	"../tests2/vulcanodon-exception03.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $10, %r8d
	movl $0, %r9d
.main_12:
	movl %r9d, %edi
	movl %r8d, %edx
.main_1:
	movl $1, %r9d
	movl $5, %ecx
	movl %edi, %r8d
	cmpl %ecx, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %r9d
	jnz .main_6
.main_2:
	movl $3, %r8d
	movl %edx, %r9d
	addl $1, %r9d
.main_14:
	movl %r8d, %esi
.main_3:
	movl $1, %edx
	movl $5, %ecx
	movl %esi, %r8d
	cmpl %ecx, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_5
.main_4:
	movl %r9d, %r8d
	subl $1, %r8d
	movl %esi, %r9d
	addl $1, %r9d
.main_13:
	movl %r9d, %esi
	movl %r8d, %r9d
	jmp .main_3
.main_5:
	movl %edi, %r8d
	addl $1, %r8d
.main_11:
	movl %r8d, %edi
	movl %r9d, %edx
	jmp .main_1
.main_6:
	movl $1, %ecx
	movl $5, %r8d
	movl %edx, %r9d
	cmpl %r8d, %r9d
	setne %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_8
.main_7:
	movl $0, %eax
	addq $8, %rsp
	ret
.main_8:
	movl $0, %eax
	movl $0, %r9d
	cltd
	idivl %r9d
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
