.file	"../tests0/qsort.l4"
.globl _c0_main
_c0_qsort:
	addq $-40, %rsp
	movq %r14, 8(%rsp)
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
	movq %rdi, %r9
	movl %edx, %r8d
.qsort_0:
	movl $1, %edx
	movl %r8d, %ecx
	cmpl %esi, %ecx
	setle %cl
	movzbl %cl, %ecx
	cmpl %ecx, %edx
	jnz .qsort_3
.qsort_1:
	movl $0, %eax
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.qsort_3:
.qsort_4:
	movl %esi, %edx
	movl %r8d, %edi
	movl %r8d, %ecx
	imull $4, %ecx
	movslq %ecx, %rcx
	movq %r9, %rax
	addq %rcx, %rax
	movl (%rax), %ecx
	movl %ecx, %r14d
.qsort_12:
	movl %edi, %ecx
	movl %edx, %r13d
.qsort_5:
	movl $1, %edi
	movl %r13d, %edx
	cmpl %ecx, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %edi
	jnz .qsort_10
.qsort_6:
	movl %r13d, %edx
	imull $4, %edx
	movslq %edx, %rdi
	movq %r9, %rdx
	addq %rdi, %rdx
	movl (%rdx), %edx
	movl $1, %edi
	cmpl %r14d, %edx
	setle %dl
	movzbl %dl, %edx
	cmpl %edx, %edi
	jnz .qsort_8
.qsort_7:
	movl %r13d, %edx
	addl $1, %edx
.qsort_14:
	movl %ecx, %edi
.qsort_9:
.qsort_11:
	movl %edi, %ecx
	movl %edx, %r13d
	jmp .qsort_5
.qsort_8:
	movl %r13d, %edx
	imull $4, %edx
	movslq %edx, %rdi
	movq %r9, %rdx
	addq %rdi, %rdx
	movl (%rdx), %r12d
	movl %ecx, %edx
	imull $4, %edx
	movslq %edx, %rdi
	movq %r9, %rdx
	addq %rdi, %rdx
	movl %r12d, (%rdx)
	movl %ecx, %ebx
	subl $1, %ebx
	movl %ebx, %edx
	imull $4, %edx
	movslq %edx, %rdi
	movq %r9, %rdx
	addq %rdi, %rdx
	movl (%rdx), %eax
	movl %r13d, %edx
	imull $4, %edx
	movslq %edx, %rdi
	movq %r9, %rdx
	addq %rdi, %rdx
	movl %eax, (%rdx)
.qsort_13:
	movl %ebx, %edi
	movl %r13d, %edx
	jmp .qsort_9
.qsort_10:
	movl %ecx, %edx
	imull $4, %edx
	movslq %edx, %rdi
	movq %r9, %rdx
	addq %rdi, %rdx
	movl %r14d, (%rdx)
	movq %r9, %rdi
	movl %r13d, %edx
	subl $1, %edx
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_qsort
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movq %r9, %rdi
	movl %ecx, %esi
	addl $1, %esi
	movl %r8d, %edx
	callq _c0_qsort
	movl $0, %eax
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
_c0_is_sorted:
	addq $-8, %rsp
.is_sorted_0:
	movl $0, %r8d
.is_sorted_9:
	movl %r8d, %edx
.is_sorted_1:
	movl $1, %ecx
	movl %edx, %r8d
	cmpl %esi, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .is_sorted_7
.is_sorted_2:
	movl %edx, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl (%r8), %r8d
	movl $1, %ecx
	cmpl %edx, %r8d
	setne %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .is_sorted_5
.is_sorted_3:
	movl $0, %eax
	addq $8, %rsp
	ret
.is_sorted_5:
.is_sorted_6:
	movl %edx, %r8d
	addl $1, %r8d
.is_sorted_8:
	movl %r8d, %edx
	jmp .is_sorted_1
.is_sorted_7:
	movl $1, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
.main_0:
	movl $938, %r9d
	movl $2, %r8d
	imull %r9d, %r8d
	movslq %r8d, %rdi
	movq $4, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movq %rax, %r8
	movl $0, %ecx
.main_5:
	movl %ecx, %edi
.main_1:
	movl $1, %esi
	movl $2, %ecx
	imull %r9d, %ecx
	movl %ecx, %edx
	subl $1, %edx
	movl %edi, %ecx
	cmpl %edx, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .main_3
.main_2:
	movl %edi, %ecx
	imull $4, %ecx
	movslq %ecx, %rcx
	movq %r8, %rdx
	addq %rcx, %rdx
	movl %edi, (%rdx)
	movl %edi, %ecx
	addl $1, %ecx
	imull $4, %ecx
	movslq %ecx, %rcx
	movq %r8, %rsi
	addq %rcx, %rsi
	movl $2, %edx
	imull %r9d, %edx
	movl %edi, %ecx
	addl $1, %ecx
	movl %edx, (%rsi)
	subl %ecx, (%rsi)
	movl %edi, %ecx
	addl $2, %ecx
.main_4:
	movl %ecx, %edi
	jmp .main_1
.main_3:
	movq %r8, %rdi
	movl $0, %esi
	movl $2, %ecx
	imull %r9d, %ecx
	movl %ecx, %edx
	subl $1, %edx
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_qsort
	movq %r12, %r8
	movq %rbx, %r9
	movq %r8, %rdi
	movl $2, %esi
	imull %r9d, %esi
	callq _c0_is_sorted
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
