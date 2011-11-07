.file	"../tests1/hawk-loopdeloop.l2"
.globl _c0_main
_c0_main:
	addq $-40, %rsp
	movq %r14, 8(%rsp)
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
.main_0:
	movl $0, %esi
	movl $1, %edx
	movl $0, %ecx
	movl $0, %r8d
.main_18:
	movl %ecx, %r13d
	movl %edx, %edi
	movl %r8d, %r14d
.main_1:
	movl $1, %edx
	movl $10, %ecx
	movl %r14d, %r8d
	cmpl %ecx, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_9
.main_2:
	movl $10, %r8d
.main_20:
	movl %edi, %r12d
	movl %esi, %ebx
	movl %r8d, %eax
.main_3:
	movl $1, %ecx
	movl $0, %r8d
	cmpl %eax, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .main_8
.main_4:
	movl $1800000000, %edi
	movl $1, %ecx
	movl %ebx, %r8d
	cmpl %edi, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .main_6
.main_5:
	movl %r12d, %ecx
	movl %ebx, %r8d
	addl %r12d, %r8d
	movl %ecx, %r9d
.main_22:
	movl %ecx, %esi
	movl %r8d, %edx
	movl %r9d, %ecx
.main_7:
	movl %eax, %r8d
	subl $1, %r8d
	movl %ecx, %r9d
.main_19:
	movl %r9d, %r13d
	movl %esi, %r9d
	movl %edx, %r12d
	movl %ecx, %ebx
	movl %r8d, %eax
	jmp .main_3
.main_6:
.main_21:
	movl %r9d, %esi
	movl %r12d, %edx
	movl %ebx, %ecx
	jmp .main_7
.main_8:
	movl %r14d, %r8d
	addl $1, %r8d
.main_17:
	movl %r12d, %edi
	movl %ebx, %esi
	movl %r8d, %r14d
	jmp .main_1
.main_9:
	movl $0, %ecx
	movl $1, %r8d
	movl $0, %r9d
.main_24:
	movl %r8d, %eax
	movl %ecx, %edi
	movl %r9d, %esi
.main_10:
	movl $1, %ecx
	movl $46, %r8d
	movl %esi, %r9d
	cmpl %r8d, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_12
.main_11:
	movl %eax, %edx
	movl %edi, %ecx
	addl %eax, %ecx
	movl %edx, %r8d
	movl %esi, %r9d
	addl $1, %r9d
.main_23:
	movl %ecx, %eax
	movl %r8d, %edi
	movl %r9d, %esi
	jmp .main_10
.main_12:
	movl %edi, %ecx
	movl $1, %r8d
	movl %r13d, %r9d
	cmpl %ecx, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %r8d
	jnz .main_14
.main_13:
	movl $0, %eax
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.main_14:
	movl $1, %eax
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.ident	"15-411 L4 reference compiler"
