.file	"../tests2/dilophosaurus-random.l4"
.globl _c0_main
_c0_random:
	addq $-8, %rsp
	movq %rdi, %r9
.random_0:
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl (%r8), %edi
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl (%r8), %esi
	movq $0, %r8
	movq %r9, %rdx
	addq %r8, %rdx
	movl %edi, %r8d
	andl $65535, %r8d
	movl $36969, %ecx
	imull %r8d, %ecx
	movl %esi, %r8d
	sarl $16, %r8d
	movl %ecx, (%rdx)
	addl %r8d, (%rdx)
	movq $4, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl (%r8), %edi
	movq $4, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl (%r8), %esi
	movq $4, %r8
	movq %r9, %rdx
	addq %r8, %rdx
	movl %edi, %r8d
	andl $65535, %r8d
	movl $18000, %ecx
	imull %r8d, %ecx
	movl %esi, %r8d
	sarl $16, %r8d
	movl %ecx, (%rdx)
	addl %r8d, (%rdx)
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl (%r8), %ecx
	movq $4, %r8
	addq %r8, %r9
	movl (%r9), %r8d
	movl %ecx, %r9d
	sall $16, %r9d
	movl %r9d, %eax
	addl %r8d, %eax
	addq $8, %rsp
	ret
_c0_is_sorted:
	addq $-8, %rsp
	movq %rdi, %r9
	movl %esi, %eax
.is_sorted_0:
	movl $1, %r8d
.is_sorted_9:
	movl %r8d, %edi
.is_sorted_1:
	movl $1, %ecx
	movl %edi, %r8d
	cmpl %eax, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .is_sorted_7
.is_sorted_2:
	movl %edi, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl (%r8), %esi
	movl %edi, %r8d
	subl $1, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl (%r8), %edx
	movl $1, %ecx
	movl %esi, %r8d
	cmpl %edx, %r8d
	setle %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .is_sorted_5
.is_sorted_3:
	movl $0, %eax
	addq $8, %rsp
	ret
.is_sorted_5:
.is_sorted_6:
	movl %edi, %r8d
	addl $1, %r8d
.is_sorted_8:
	movl %r8d, %edi
	jmp .is_sorted_1
.is_sorted_7:
	movl $1, %eax
	addq $8, %rsp
	ret
_c0_swap:
	addq $-8, %rsp
	movq %rdi, %r9
	movl %esi, %r8d
	movl %edx, %edi
.swap_0:
	movl %r8d, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movl (%rcx), %ecx
	movl %ecx, %esi
	movl %edi, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movl (%rcx), %edx
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl %edx, (%r8)
	movl %edi, %r8d
	imull $4, %r8d
	movslq %r8d, %r8
	addq %r8, %r9
	movl %esi, (%r9)
	movl $0, %eax
	addq $8, %rsp
	ret
_c0_bubbleSort:
	addq $-56, %rsp
	movq %rbp, 8(%rsp)
	movq %r15, 16(%rsp)
	movq %r14, 24(%rsp)
	movq %r13, 32(%rsp)
	movq %r12, 40(%rsp)
	movq %rbx, 48(%rsp)
	movq %rdi, %r9
	movl %esi, %r8d
.bubbleSort_0:
	movl $0, %ecx
.bubbleSort_11:
	movl %ecx, %r13d
.bubbleSort_1:
	movl $1, %esi
	movl %r13d, %ecx
	cmpl %r8d, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .bubbleSort_9
.bubbleSort_2:
	movl %r8d, %ecx
	subl $1, %ecx
.bubbleSort_13:
	movl %ecx, %ebx
.bubbleSort_3:
	movl $1, %ecx
	movl %r13d, %esi
	cmpl %ebx, %esi
	setl %sil
	movzbl %sil, %esi
	cmpl %esi, %ecx
	jnz .bubbleSort_8
.bubbleSort_4:
	movl %ebx, %ecx
	imull $4, %ecx
	movslq %ecx, %rsi
	movq %r9, %rcx
	addq %rsi, %rcx
	movl (%rcx), %ecx
	movl %ebx, %esi
	subl $1, %esi
	imull $4, %esi
	movslq %esi, %rdi
	movq %r9, %rsi
	addq %rdi, %rsi
	movl (%rsi), %r12d
	movl $1, %edi
	movl %ecx, %esi
	cmpl %r12d, %esi
	setl %sil
	movzbl %sil, %esi
	cmpl %esi, %edi
	jnz .bubbleSort_6
.bubbleSort_5:
	movq %r9, %rdi
	movl %ebx, %esi
	subl $1, %esi
	movl %ebx, %edx
	movq %rcx, %rbp
	movq %r8, %r15
	movq %r9, %r14
	callq _c0_swap
	movq %rbp, %rcx
	movq %r15, %r8
	movq %r14, %r9
	movslq %eax, %rdi
.bubbleSort_15:
	movl %eax, %esi
	movq %rdi, %r14
.bubbleSort_7:
	movl %ebx, %edi
	subl $1, %edi
.bubbleSort_12:
	movl %esi, %edx
	movq %r14, %rax
	movl %edi, %ebx
	jmp .bubbleSort_3
.bubbleSort_6:
.bubbleSort_14:
	movl %edx, %esi
	movq %rax, %r14
	jmp .bubbleSort_7
.bubbleSort_8:
	movl %r13d, %ecx
	addl $1, %ecx
.bubbleSort_10:
	movl %ecx, %r13d
	jmp .bubbleSort_1
.bubbleSort_9:
	movl $0, %eax
	movq 8(%rsp), %rbp
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
_c0_main:
	addq $-40, %rsp
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
.main_0:
	movq $100, %rdi
	movq $4, %rsi
	callq calloc
	movq %rax, %r9
	movq $1, %rdi
	movq $8, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movq %rax, %r8
	movq $0, %rdx
	movq %r8, %rcx
	addq %rdx, %rcx
	movl $100, (%rcx)
	movq $4, %rdx
	movq %r8, %rcx
	addq %rdx, %rcx
	movl $42, (%rcx)
	movl $0, %ecx
.main_5:
.main_1:
	movl $1, %edi
	movl $100, %esi
	movl %ecx, %edx
	cmpl %esi, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %edi
	jnz .main_3
.main_2:
	movq %r8, %rdi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_random
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl %ecx, %edx
	imull $4, %edx
	movslq %edx, %rsi
	movq %r9, %rdx
	addq %rsi, %rdx
	movl %eax, (%rdx)
	addl $1, %ecx
.main_4:
	jmp .main_1
.main_3:
	movq %r9, %rdi
	movl $100, %esi
	movq %r9, %rbx
	callq _c0_bubbleSort
	movq %rbx, %r9
	movq %r9, %rdi
	movl $100, %esi
	callq _c0_is_sorted
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.ident	"15-411 L4 reference compiler"
