.file	"../tests1/merlin-exception-neg-access.l4"
.globl _c0_main
_c0_pow:
	addq $-8, %rsp
	movl %edi, %r9d
	movl %esi, %edi
.pow_0:
	movl $1, %ecx
	movl $0, %r8d
.pow_5:
	movl %r8d, %esi
	movl %ecx, %edx
.pow_1:
	movl $1, %ecx
	movl %esi, %r8d
	cmpl %edi, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .pow_3
.pow_2:
	movl %edx, %ecx
	imull %r9d, %ecx
	movl %esi, %r8d
	addl $1, %r8d
.pow_4:
	movl %r8d, %esi
	movl %ecx, %edx
	jmp .pow_1
.pow_3:
	movl %edx, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-40, %rsp
	movq %r14, 8(%rsp)
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
.main_0:
	movl $1000, %r9d
	movq $1000, %rdi
	movq $4, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movq %rax, %r8
	movl %r9d, %ecx
.main_8:
	movl %ecx, %edx
.main_1:
	movl $1, %esi
	movl $0, %ecx
	cmpl %edx, %ecx
	setle %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .main_6
.main_2:
	movl %r9d, %ecx
.main_10:
.main_3:
	movl $1, %edi
	movl $0, %esi
	cmpl %ecx, %esi
	setle %sil
	movzbl %sil, %esi
	cmpl %esi, %edi
	jnz .main_5
.main_4:
	movl %edx, %edi
	movl %ecx, %esi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_pow
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %esi
	imull $4, %esi
	movslq %esi, %rdi
	movq %r8, %rsi
	addq %rdi, %rsi
	movl %edx, (%rsi)
	addl %ecx, (%rsi)
	subl $1, %ecx
.main_9:
	jmp .main_3
.main_5:
	movl %edx, %ecx
	subl $1, %ecx
.main_7:
	movl %ecx, %edx
	jmp .main_1
.main_6:
	movl $0, %r9d
	imull $4, %r9d
	movslq %r9d, %rcx
	movq %r8, %r9
	addq %rcx, %r9
	movl (%r9), %r9d
	movl %r9d, %eax
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.ident	"15-411 L4 reference compiler"
