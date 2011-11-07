.file	"../tests1/sparrowhawk-linkedlist2.l4"
.globl _c0_main
_c0_insert:
	addq $-40, %rsp
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
	movq %rdi, %r9
	movl %esi, %r8d
	movq %rdx, %rcx
.insert_0:
	movq $1, %rdi
	movq $16, %rsi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	imull $4, %r8d
	movslq %r8d, %r8
	addq %r8, %r9
	movl (%r9), %edx
	movq $0, %r8
	movq %rax, %r9
	addq %r8, %r9
	movl %edx, (%r9)
	movq $8, %r8
	movq %rax, %r9
	addq %r8, %r9
	movq %rcx, (%r9)
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
_c0_sum:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.sum_0:
	movl $1, %r8d
	movq $0, %rcx
	movq %rdi, %r9
	cmpq %rcx, %r9
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %r8d
	jnz .sum_3
.sum_1:
	movl $0, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.sum_3:
.sum_4:
	movq $0, %r8
	movq %rdi, %r9
	addq %r8, %r9
	movl (%r9), %r9d
	movq $8, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movq %r8, %rdi
	movq %r9, %rbx
	callq _c0_sum
	movq %rbx, %r9
	addl %eax, %r9d
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
.main_0:
	movq $5, %rdi
	movq $4, %rsi
	callq calloc
	movq %rax, %r9
	movq $0, %rdx
	movl $0, %r8d
.main_8:
	movl %r8d, %edi
.main_1:
	movl $1, %esi
	movl $5, %r8d
	movl %edi, %ecx
	cmpl %r8d, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .main_3
.main_2:
	movl %edi, %r8d
	imull $4, %r8d
	movslq %r8d, %r8
	movq %r9, %rcx
	addq %r8, %rcx
	movl %edi, (%rcx)
	movl %edi, %r8d
	addl $1, %r8d
.main_7:
	movl %r8d, %edi
	jmp .main_1
.main_3:
	movl $0, %r8d
.main_10:
	movq %rdx, %rdi
.main_4:
	movl $1, %esi
	movl $5, %edx
	movl %r8d, %ecx
	cmpl %edx, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .main_6
.main_5:
	movq %r9, %rsi
	movl %r8d, %edx
	movq %rdi, %rcx
	movq %rsi, %rdi
	movl %edx, %esi
	movq %rcx, %rdx
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, %rcx
	addl $1, %r8d
.main_9:
	movq %rcx, %rdi
	jmp .main_4
.main_6:
	callq _c0_sum
	movl %eax, %r9d
	movl %r9d, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
