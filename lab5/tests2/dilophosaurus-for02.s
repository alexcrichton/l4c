.file	"../tests2/dilophosaurus-for02.l2"
.globl _c0_main
_c0_main:
	addq $-56, %rsp
	movq %rbp, 8(%rsp)
	movq %r15, 16(%rsp)
	movq %r14, 24(%rsp)
	movq %r13, 32(%rsp)
	movq %r12, 40(%rsp)
	movq %rbx, 48(%rsp)
.main_0:
	movl $3, %r13d
	movl $0, %ecx
	movl $1, %r8d
.main_28:
	movl %r8d, %r12d
	movl %ecx, %edx
.main_1:
	movl $1, %ecx
	movl %r12d, %r8d
	cmpl %r13d, %r8d
	setle %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .main_13
.main_2:
	movl $1, %r8d
.main_31:
	movl %r8d, %edi
	movl %edx, %esi
.main_3:
	movl $1, %ecx
	movl %edi, %r8d
	cmpl %r13d, %r8d
	setle %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .main_12
.main_4:
	movl $5, %r8d
.main_33:
	movl %r8d, %r14d
.main_5:
	movl $1, %edx
	movl $15, %ecx
	movl %r14d, %r8d
	cmpl %ecx, %r8d
	setle %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_7
.main_6:
	movl %r14d, %r8d
	addl $1, %r8d
.main_32:
	movl %r8d, %r14d
	jmp .main_5
.main_7:
	movl %r12d, %r8d
	imull %edi, %r8d
	movl %esi, %r15d
	addl %r8d, %r15d
	movl $1, %ecx
	movl %r12d, %r8d
	cmpl %edi, %r8d
	setne %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .main_10
.main_8:
	movl %edi, %ebp
	addl $1, %ebp
	jmp .main_30
.main_10:
.main_11:
	movl %r12d, %r8d
	imull %edi, %r8d
	movl %r15d, %ecx
	addl %r8d, %ecx
	movl %edi, %r8d
	addl $1, %r8d
.main_29:
	movl %r8d, %edi
	movl %ecx, %esi
	jmp .main_3
.main_12:
	movl %r12d, %r8d
	addl $1, %r8d
.main_27:
	movl %r8d, %r12d
	movl %esi, %edx
	jmp .main_1
.main_13:
	movl $1, %r8d
.main_35:
	movl %r8d, %ebx
.main_14:
	movl $1, %ecx
	movl %ebx, %r8d
	cmpl %r13d, %r8d
	setle %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .main_26
.main_15:
	movl $1, %r8d
.main_38:
	movl %r9d, %edi
	movl %r8d, %eax
.main_16:
	movl $1, %ecx
	movl %eax, %r8d
	cmpl %r13d, %r8d
	setle %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .main_25
.main_17:
	movl $15, %r8d
.main_40:
	movl %r8d, %edi
.main_18:
	movl $1, %ecx
	movl $1, %r8d
	cmpl %edi, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .main_20
.main_19:
	movl %edi, %r8d
	subl $1, %r8d
.main_39:
	movl %r8d, %edi
	jmp .main_18
.main_20:
	movl %ebx, %r8d
	imull %eax, %r8d
	movl %edx, %esi
	addl %r8d, %esi
	movl %eax, %edx
	addl %edi, %edx
	movl $1, %ecx
	movl %ebx, %r8d
	addl $1, %r8d
	cmpl %edx, %r8d
	setne %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .main_23
.main_21:
	jmp .main_37
.main_23:
.main_24:
	movl %edx, %r8d
	subl $1, %r8d
	movl %ebx, %ecx
	imull %r8d, %ecx
	movl %esi, %r8d
	addl %ecx, %r8d
.main_36:
	movl %edx, %eax
	movl %r8d, %edx
	jmp .main_16
.main_25:
	movl %ebx, %r8d
	addl $1, %r8d
.main_34:
	movl %edi, %r9d
	movl %r8d, %ebx
	jmp .main_14
.main_26:
	movl %edx, %eax
	movq 8(%rsp), %rbp
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
.main_37:
	movl %edx, %eax
	movl %esi, %edx
	jmp .main_16
.main_30:
	movl %ebp, %edi
	movl %r15d, %esi
	jmp .main_3
.ident	"15-411 L4 reference compiler"
