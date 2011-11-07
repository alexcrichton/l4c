.file	"../tests1/kestrel-fun5.l3"
.globl _c0_main
_c0_sum_factors:
	addq $-8, %rsp
	movl %edi, %r9d
.sum_factors_0:
	movl $0, %ecx
	movl $1, %r8d
.sum_factors_8:
.sum_factors_1:
	movl $1, %esi
	movl %r8d, %edx
	cmpl %r9d, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %esi
	jnz .sum_factors_6
.sum_factors_2:
	movl %r9d, %eax
	cltd
	idivl %r8d
	movl $1, %edi
	movl $0, %esi
	cmpl %esi, %edx
	sete %dl
	movzbl %dl, %edx
	cmpl %edx, %edi
	jnz .sum_factors_4
.sum_factors_3:
	addl %r8d, %ecx
.sum_factors_10:
	movl %ecx, %edx
.sum_factors_5:
	addl $1, %r8d
.sum_factors_7:
	movl %edx, %ecx
	jmp .sum_factors_1
.sum_factors_4:
.sum_factors_9:
	movl %ecx, %edx
	jmp .sum_factors_5
.sum_factors_6:
	movl %ecx, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-40, %rsp
	movq %r14, 8(%rsp)
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
.main_0:
	movl $1, %r9d
.main_12:
.main_1:
	movl $1, %r8d
	movl $1, %ecx
	cmpl %ecx, %r8d
	jnz .main_10
.main_2:
	movl $1, %r8d
.main_14:
	movl %r8d, %edx
.main_3:
	movl $1, %ecx
	movl %edx, %r8d
	cmpl %r9d, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .main_9
.main_4:
	movl %r9d, %edi
	movq %rdx, %r12
	movq %r9, %rbx
	callq _c0_sum_factors
	movq %r12, %rdx
	movq %rbx, %r9
	movl %eax, %r8d
	movl %r8d, %ecx
	movl %edx, %edi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_sum_factors
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %ebx
	movl %ebx, %eax
	cmpl %edx, %ecx
	jz .ternary_true1
	movl $0, %edi
	jmp .ternary_end2
.ternary_true1:
	movl %eax, %edi
	cmpl %r9d, %edi
	sete %dil
	movzbl %dil, %edi
.ternary_end2:
	movl $1, %esi
	cmpl %edi, %esi
	jnz .main_7
.main_5:
	movl %r9d, %eax
	addl %edx, %eax
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.main_7:
.main_8:
	addl $1, %edx
.main_13:
	jmp .main_3
.main_9:
	addl $1, %r9d
.main_11:
	jmp .main_1
.main_10:
	movl $0, %eax
	subl $1, %eax
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.ident	"15-411 L4 reference compiler"
