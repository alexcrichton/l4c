.file	"../tests0/for04.l2"
.globl _c0_main
_c0_main:
	addq $-40, %rsp
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
.main_0:
	movl $3, %r12d
	movl $0, %ecx
	movl $1, %r8d
.main_22:
	movl %r8d, %ebx
	movl %ecx, %edx
.main_1:
	movl $1, %ecx
	movl %ebx, %r8d
	cmpl %r12d, %r8d
	setle %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .main_10
.main_2:
	movl $1, %r8d
.main_25:
	movl %r8d, %esi
.main_3:
	movl $1, %ecx
	movl %esi, %r8d
	cmpl %r12d, %r8d
	setle %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .main_9
.main_4:
	movl %ebx, %r8d
	imull %esi, %r8d
	movl %edx, %r13d
	addl %r8d, %r13d
	movl $1, %ecx
	movl %ebx, %r8d
	cmpl %esi, %r8d
	setne %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .main_7
.main_5:
	movl %esi, %r9d
	addl $1, %r9d
	jmp .main_24
.main_7:
.main_8:
	movl %ebx, %r8d
	imull %esi, %r8d
	movl %r13d, %ecx
	addl %r8d, %ecx
	movl %esi, %r8d
	addl $1, %r8d
.main_23:
	movl %r8d, %esi
	movl %ecx, %edx
	jmp .main_3
.main_9:
	movl %ebx, %r8d
	addl $1, %r8d
.main_21:
	movl %r8d, %ebx
	jmp .main_1
.main_10:
	movl $1, %r8d
.main_27:
	movl %r8d, %eax
.main_11:
	movl $1, %ecx
	movl %eax, %r8d
	cmpl %r12d, %r8d
	setle %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .main_20
.main_12:
	movl $1, %r8d
.main_30:
	movl %r8d, %edi
.main_13:
	movl $1, %ecx
	movl %edi, %r8d
	cmpl %r12d, %r8d
	setle %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .main_19
.main_14:
	movl %eax, %r8d
	imull %edi, %r8d
	movl %edx, %esi
	addl %r8d, %esi
	movl %edi, %edx
	addl $1, %edx
	movl $1, %ecx
	movl %eax, %r8d
	addl $1, %r8d
	cmpl %edx, %r8d
	setne %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .main_17
.main_15:
	jmp .main_29
.main_17:
.main_18:
	movl %edx, %r8d
	subl $1, %r8d
	movl %eax, %ecx
	imull %r8d, %ecx
	movl %esi, %r8d
	addl %ecx, %r8d
.main_28:
	movl %edx, %edi
	movl %r8d, %edx
	jmp .main_13
.main_19:
	movl %eax, %r8d
	addl $1, %r8d
.main_26:
	movl %r8d, %eax
	jmp .main_11
.main_20:
	movl %edx, %eax
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.main_29:
	movl %edx, %edi
	movl %esi, %edx
	jmp .main_13
.main_24:
	movl %r9d, %esi
	movl %r13d, %edx
	jmp .main_3
.ident	"15-411 L4 reference compiler"
