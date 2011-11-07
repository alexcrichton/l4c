.file	"../tests2/velociraptor-optimize-this.l4"
.globl _c0_main
_c0_main:
	addq $-72, %rsp
	movq %rbp, 8(%rsp)
	movq %r15, 16(%rsp)
	movq %r14, 24(%rsp)
	movq %r13, 32(%rsp)
	movq %r12, 40(%rsp)
	movq %rbx, 48(%rsp)
.main_0:
	movl $1, %r9d
	movl $2, 56(%rsp)
	movl $3, 60(%rsp)
	movl $4, 64(%rsp)
	movl $5, 68(%rsp)
	movl $6, %ebp
	movl $7, %r15d
	movl $0, %ecx
	movl $0, %r8d
.main_26:
	movl %r8d, %r14d
	movl %ecx, %r13d
.main_1:
	movl $1, %ecx
	movl %r14d, %r8d
	cmpl %r15d, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .main_24
.main_2:
	movl $1, %ecx
	movl %r14d, %r8d
	cmpl %r9d, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .main_4
.main_3:
	movl %r13d, %r8d
	addl $1, %r8d
.main_28:
	movl %r8d, %r12d
.main_5:
	movl $1, %ecx
	movl %r14d, %r8d
	cmpl 56(%rsp), %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .main_7
.main_6:
	movl %r12d, %r8d
	addl $1, %r8d
.main_30:
	movl %r8d, %ebx
.main_8:
	movl $1, %ecx
	movl %r14d, %r8d
	cmpl 60(%rsp), %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .main_10
.main_9:
	movl %ebx, %r8d
	addl $1, %r8d
.main_32:
	movl %r8d, %eax
.main_11:
	movl $1, %ecx
	movl %r14d, %r8d
	cmpl 64(%rsp), %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .main_13
.main_12:
	movl %eax, %r8d
	addl $1, %r8d
.main_34:
	movl %r8d, %edi
.main_14:
	movl $1, %ecx
	movl %r14d, %r8d
	cmpl 68(%rsp), %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .main_16
.main_15:
	movl %edi, %r8d
	addl $1, %r8d
.main_36:
	movl %r8d, %esi
.main_17:
	movl $1, %ecx
	movl %r14d, %r8d
	cmpl %ebp, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .main_19
.main_18:
	movl %esi, %r8d
	addl $1, %r8d
.main_38:
	movl %r8d, %edx
.main_20:
	movl $1, %ecx
	movl %r14d, %r8d
	cmpl %r15d, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .main_22
.main_21:
	movl %edx, %r8d
	addl $1, %r8d
.main_40:
	movl %r8d, %ecx
.main_23:
	movl %r14d, %r8d
	addl $1, %r8d
.main_25:
	movl %r8d, %r14d
	movl %ecx, %r13d
	jmp .main_1
.main_22:
.main_39:
	movl %edx, %ecx
	jmp .main_23
.main_19:
.main_37:
	movl %esi, %edx
	jmp .main_20
.main_16:
.main_35:
	movl %edi, %esi
	jmp .main_17
.main_13:
.main_33:
	movl %eax, %edi
	jmp .main_14
.main_10:
.main_31:
	movl %ebx, %eax
	jmp .main_11
.main_7:
.main_29:
	movl %r12d, %ebx
	jmp .main_8
.main_4:
.main_27:
	movl %r13d, %r12d
	jmp .main_5
.main_24:
	movl %r13d, %eax
	movq 8(%rsp), %rbp
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $72, %rsp
	ret
.ident	"15-411 L4 reference compiler"
