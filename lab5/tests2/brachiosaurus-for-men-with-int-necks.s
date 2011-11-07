.file	"../tests2/brachiosaurus-for-men-with-int-necks.l2"
.globl _c0_main
_c0_main:
	addq $-88, %rsp
	movq %rbp, 16(%rsp)
	movq %r15, 24(%rsp)
	movq %r14, 32(%rsp)
	movq %r13, 40(%rsp)
	movq %r12, 48(%rsp)
	movq %rbx, 56(%rsp)
.main_0:
	movl $0, %ecx
	movl $0, %r8d
.main_27:
	movl %ecx, 64(%rsp)
	movl %r8d, %ebp
.main_1:
	movl $1, %edx
	movl $16, %ecx
	movl %ebp, %r8d
	cmpl %ecx, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_24
.main_2:
	movl $1, %edx
	movl %ebp, %r8d
	andl $1, %r8d
	movl $0, %ecx
	cmpl %ecx, %r8d
	setne %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_5
.main_3:
	movl %ebp, 68(%rsp)
	addl $1, 68(%rsp)
	jmp .main_26
.main_5:
.main_6:
	movl $0, %ecx
	movl $0, %r8d
.main_29:
	movl 72(%rsp), %ebx
	movl 76(%rsp), %edi
	movl %ecx, %r15d
	movl 80(%rsp), %eax
	movl 84(%rsp), %esi
	movl %r8d, %r14d
.main_7:
	movl $1, %edx
	movl $16, %ecx
	movl %r14d, %r8d
	cmpl %ecx, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_23
.main_8:
	movl $0, %ecx
	movl $0, %r8d
.main_31:
	movl %ebx, %edi
	movl %ecx, %r13d
	movl %r8d, %r12d
.main_9:
	movl $1, %edx
	movl $16, %ecx
	movl %r12d, %r8d
	cmpl %ecx, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_36
.main_10:
	movl $0, %ecx
	movl $0, %r8d
.main_34:
	movl %ecx, %ebx
	movl %r8d, %eax
.main_11:
	movl $1, %edx
	movl $16, %ecx
	movl %eax, %r8d
	cmpl %ecx, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_17
.main_12:
	movl $1, %edx
	movl %eax, %r8d
	andl $3, %r8d
	movl $0, %ecx
	cmpl %ecx, %r8d
	setne %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_15
.main_13:
	movl %eax, %r9d
	addl $1, %r9d
	jmp .main_33
.main_15:
.main_16:
	movl %ebx, %ecx
	addl %eax, %ecx
	movl %eax, %r8d
	addl $1, %r8d
.main_32:
	movl %ecx, %ebx
	movl %r8d, %eax
	jmp .main_11
.main_17:
	movl %r13d, %esi
	addl %ebx, %esi
	movl $1, %edx
	movl $7, %ecx
	movl %r12d, %r8d
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_20
.main_18:
	jmp .main_35
.main_20:
.main_21:
	movl %r12d, %r8d
	addl $1, %r8d
.main_30:
	movl %ebx, %edi
	movl %esi, %r13d
	movl %r8d, %r12d
	jmp .main_9
.main_36:
	movl %r13d, %esi
	movl %eax, %edx
.main_22:
	movl %r12d, %r8d
	addl %esi, %r8d
	addl $1, %r8d
	movl %r15d, %ecx
	addl %r8d, %ecx
	movl %r14d, %r8d
	addl $1, %r8d
.main_28:
	movl %edi, %ebx
	movl %esi, %edi
	movl %ecx, %r15d
	movl %edx, %eax
	movl %r12d, %esi
	movl %r8d, %r14d
	jmp .main_7
.main_23:
	movl %r14d, %r8d
	imull %r15d, %r8d
	movl 64(%rsp), %ecx
	addl %r8d, %ecx
	movl %ebp, %r8d
	addl $1, %r8d
.main_25:
	movl %ebx, 72(%rsp)
	movl %edi, 76(%rsp)
	movl %ecx, 64(%rsp)
	movl %eax, 80(%rsp)
	movl %esi, 84(%rsp)
	movl %r8d, %ebp
	jmp .main_1
.main_24:
	movl 64(%rsp), %eax
	movq 16(%rsp), %rbp
	movq 24(%rsp), %r15
	movq 32(%rsp), %r14
	movq 40(%rsp), %r13
	movq 48(%rsp), %r12
	movq 56(%rsp), %rbx
	addq $88, %rsp
	ret
.main_35:
	movl %ebx, %edi
	movl %eax, %edx
	jmp .main_22
.main_33:
	movl %r9d, %eax
	jmp .main_11
.main_26:
	movl 68(%rsp), %ebp
	jmp .main_1
.ident	"15-411 L4 reference compiler"
