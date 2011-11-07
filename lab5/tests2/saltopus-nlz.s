.file	"../tests2/saltopus-nlz.l2"
.globl _c0_main
_c0_main:
	addq $-56, %rsp
	movq %r15, 16(%rsp)
	movq %r14, 24(%rsp)
	movq %r13, 32(%rsp)
	movq %r12, 40(%rsp)
	movq %rbx, 48(%rsp)
.main_0:
	movl $4342338, %r9d
	movl $32, %r15d
	movl %r9d, %esi
	sarl $16, %esi
	movl $1, %edx
	movl $0, %ecx
	movl %esi, %r8d
	cmpl %ecx, %r8d
	setne %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_2
.main_1:
	movl %r15d, %ecx
	subl $16, %ecx
	movl %esi, %r8d
.main_18:
	movl %ecx, %r14d
	movl %r8d, %r13d
.main_3:
	movl %r13d, %esi
	sarl $8, %esi
	movl $1, %edx
	movl $0, %ecx
	movl %esi, %r8d
	cmpl %ecx, %r8d
	setne %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_5
.main_4:
	movl %r14d, %ecx
	subl $8, %ecx
	movl %esi, %r8d
.main_20:
	movl %ecx, %r12d
	movl %r8d, %ebx
.main_6:
	movl %ebx, %esi
	sarl $4, %esi
	movl $1, %edx
	movl $0, %ecx
	movl %esi, %r8d
	cmpl %ecx, %r8d
	setne %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_8
.main_7:
	movl %r12d, %ecx
	subl $4, %ecx
	movl %esi, %r8d
.main_22:
	movl %ecx, %eax
	movl %r8d, %edi
.main_9:
	movl %edi, %esi
	sarl $2, %esi
	movl $1, %edx
	movl $0, %ecx
	movl %esi, %r8d
	cmpl %ecx, %r8d
	setne %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_11
.main_10:
	movl %eax, %r8d
	subl $2, %r8d
	movl %esi, %r9d
.main_24:
	movl %r8d, %esi
	movl %r9d, %edx
.main_12:
	movl %edx, %r9d
	sarl $1, %r9d
	movl $1, %ecx
	movl $0, %r8d
	cmpl %r8d, %r9d
	setne %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_15
.main_13:
	movl %esi, %eax
	subl $2, %eax
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
.main_15:
.main_16:
	movl %esi, %eax
	subl %edx, %eax
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
.main_11:
.main_23:
	movl %eax, %esi
	movl %edi, %edx
	jmp .main_12
.main_8:
.main_21:
	movl %r12d, %eax
	movl %ebx, %edi
	jmp .main_9
.main_5:
.main_19:
	movl %r14d, %r12d
	movl %r13d, %ebx
	jmp .main_6
.main_2:
.main_17:
	movl %r15d, %r14d
	movl %r9d, %r13d
	jmp .main_3
.ident	"15-411 L4 reference compiler"
