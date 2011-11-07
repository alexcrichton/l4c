.file	"../tests2/saltopus-8queens_better.l4"
.globl _c0_main
_c0_abs:
	addq $-8, %rsp
.abs_0:
	movl $1, %ecx
	movl $0, %r8d
	cmpl %edi, %r8d
	setle %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .abs_3
.abs_1:
	movl %edi, %eax
	addq $8, %rsp
	ret
.abs_3:
.abs_4:
	movl $0, %eax
	subl %edi, %eax
	addq $8, %rsp
	ret
_c0_safe:
	addq $-56, %rsp
	movq %r15, 16(%rsp)
	movq %r14, 24(%rsp)
	movq %r13, 32(%rsp)
	movq %r12, 40(%rsp)
	movq %rbx, 48(%rsp)
	movl %edi, %r9d
	movl %esi, %r8d
	movq %rdx, %rsi
.safe_0:
	movl $0, %ecx
.safe_13:
.safe_1:
	movl $1, %eax
	movl $8, %edi
	movl %ecx, %edx
	cmpl %edi, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %eax
	jnz .safe_11
.safe_2:
	movl $1, %edi
	movl %r8d, %edx
	cmpl %ecx, %edx
	setle %dl
	movzbl %dl, %edx
	cmpl %edx, %edi
	jnz .safe_5
.safe_3:
	jmp .safe_11
.safe_5:
.safe_6:
	movl %ecx, %edx
	imull $4, %edx
	movslq %edx, %rdi
	movq %rsi, %rdx
	addq %rdi, %rdx
	movl (%rdx), %edx
	cmpl %r9d, %edx
	jz .ternary_true1
	movl %ecx, %edx
	imull $4, %edx
	movslq %edx, %rdi
	movq %rsi, %rdx
	addq %rdi, %rdx
	movl (%rdx), %edx
	movl %edx, %edi
	subl %r9d, %edi
	movq %rsi, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_abs
	movq %r14, %rsi
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %edx
	movl %ecx, %edi
	subl %r8d, %edi
	movq %rsi, %r15
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_abs
	movq %r15, %rsi
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	cmpl %eax, %edx
	sete %dl
	movzbl %dl, %edx
	jmp .ternary_end2
.ternary_true1:
	movl $1, %edx
.ternary_end2:
	movl $1, %edi
	cmpl %edx, %edi
	jnz .safe_9
.safe_7:
	movl $0, %eax
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
.safe_9:
.safe_10:
	addl $1, %ecx
.safe_12:
	jmp .safe_1
.safe_11:
	movl $1, %eax
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
	jmp .safe_11
_c0_try:
	addq $-40, %rsp
	movq %r14, 8(%rsp)
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
	movl %edi, %r9d
	movq %rsi, %r8
.try_0:
	movl $0, %esi
	movl $1, %edx
	movl $8, %ecx
	movl %r9d, %edi
	cmpl %ecx, %edi
	sete %dil
	movzbl %dil, %edi
	cmpl %edi, %edx
	jnz .try_3
.try_1:
	movl $1, %eax
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.try_3:
.try_4:
	movl $0, %edx
.try_12:
	movl %esi, %ecx
	movl %edx, %ebx
.try_5:
	movl $1, %edi
	movl $8, %esi
	movl %ebx, %edx
	cmpl %esi, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %edi
	jnz .try_10
.try_6:
	movl %ebx, %edi
	movl %r9d, %esi
	movq %r8, %rdx
	movq %rcx, %r14
	movq %r8, %r13
	movq %r9, %r12
	callq _c0_safe
	movq %r14, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movl $1, %edx
	cmpl %eax, %edx
	jnz .try_8
.try_7:
	movl %r9d, %edx
	imull $4, %edx
	movslq %edx, %rsi
	movq %r8, %rdx
	addq %rsi, %rdx
	movl %ebx, (%rdx)
	movl %r9d, %edi
	addl $1, %edi
	movq %r8, %rsi
	movq %rcx, %r14
	movq %r8, %r13
	movq %r9, %r12
	callq _c0_try
	movq %r14, %rcx
	movq %r13, %r8
	movq %r12, %r9
	addl %eax, %ecx
.try_14:
	movl %ecx, %esi
.try_9:
	movl %ebx, %edx
	addl $1, %edx
.try_11:
	movl %esi, %ecx
	movl %edx, %ebx
	jmp .try_5
.try_8:
.try_13:
	movl %ecx, %esi
	jmp .try_9
.try_10:
	movl %ecx, %eax
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
_c0_t:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movl %edi, %r9d
.t_0:
	movq $8, %rdi
	movq $4, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movl %r9d, %r8d
.t_5:
	movl %r8d, %esi
.t_1:
	movl $1, %r8d
	movl $8, %edx
	movl %esi, %ecx
	cmpl %edx, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %r8d
	jnz .t_3
.t_2:
	movl %esi, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movl $0, (%r8)
	subl $1, (%r8)
	movl %esi, %r8d
	addl $1, %r8d
.t_4:
	movl %r8d, %esi
	jmp .t_1
.t_3:
	movl %r9d, %edi
	movq %rax, %rsi
	callq _c0_try
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %r9d
	movl %r9d, %edi
	callq _c0_t
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
