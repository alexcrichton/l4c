.file	"../tests0/mmult.l4"
.globl _c0_main
_c0_mmult:
	addq $-56, %rsp
	movq %rbp, 8(%rsp)
	movq %r15, 16(%rsp)
	movq %r14, 24(%rsp)
	movq %r13, 32(%rsp)
	movq %r12, 40(%rsp)
	movq %rbx, 48(%rsp)
	movl %ecx, %ebp
.mmult_0:
	movl $0, %ecx
.mmult_11:
	movl %ecx, %r15d
.mmult_1:
	movl $1, %eax
	movl %r15d, %ecx
	cmpl %ebp, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %eax
	jnz .mmult_9
.mmult_2:
	movl $0, %ecx
.mmult_13:
	movl %ecx, %r14d
.mmult_3:
	movl $1, %eax
	movl %r14d, %ecx
	cmpl %ebp, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %eax
	jnz .mmult_8
.mmult_4:
	movl $0, %ebx
	movl $0, %eax
.mmult_15:
	movl %r8d, %r13d
	movl %r9d, %ecx
	movl %ebx, %r12d
	movl %eax, %ebx
.mmult_5:
	movl $1, %r8d
	movl %ebx, %r9d
	cmpl %ebp, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %r8d
	jnz .mmult_7
.mmult_6:
	movl %r14d, %r8d
	imull %ebp, %r8d
	movl %ebx, %r9d
	addl %r8d, %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq %rdi, %r9
	addq %r8, %r9
	movl (%r9), %eax
	movl %ebx, %r8d
	imull %ebp, %r8d
	movl %r15d, %r9d
	addl %r8d, %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq %rsi, %r9
	addq %r8, %r9
	movl (%r9), %ecx
	movl %eax, %r9d
	imull %ecx, %r9d
	movl %r12d, %r8d
	addl %r9d, %r8d
	movl %ebx, %r9d
	addl $1, %r9d
.mmult_14:
	movl %ecx, %r13d
	movl %eax, %ecx
	movl %r8d, %r12d
	movl %r9d, %ebx
	jmp .mmult_5
.mmult_7:
	movl %r14d, %r8d
	imull %ebp, %r8d
	movl %r15d, %r9d
	addl %r8d, %r9d
	imull $4, %r9d
	movslq %r9d, %r9
	movq %rdx, %r8
	addq %r9, %r8
	movl %r12d, (%r8)
	movl %r14d, %eax
	addl $1, %eax
.mmult_12:
	movl %r13d, %r8d
	movl %ecx, %r9d
	movl %eax, %r14d
	jmp .mmult_3
.mmult_8:
	movl %r15d, %ecx
	addl $1, %ecx
.mmult_10:
	movl %ecx, %r15d
	jmp .mmult_1
.mmult_9:
	movl $0, %eax
	movq 8(%rsp), %rbp
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
_c0_init:
	addq $-8, %rsp
	movq %rdi, %r9
	movl %edx, %eax
.init_0:
	movl $0, %ecx
.init_5:
	movl %ecx, %edi
.init_1:
	movl $1, %edx
	movl %eax, %ecx
	imull %eax, %ecx
	movl %edi, %r8d
	cmpl %ecx, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .init_3
.init_2:
	movl %edi, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl %esi, (%r8)
	movl %esi, %ecx
	addl $1, %ecx
	movl %edi, %r8d
	addl $1, %r8d
.init_4:
	movl %r8d, %edi
	movl %ecx, %esi
	jmp .init_1
.init_3:
	movl $0, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-40, %rsp
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
.main_0:
	movl $3, %r9d
	movl %r9d, %r8d
	imull %r9d, %r8d
	movslq %r8d, %rdi
	movq $4, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movq %rax, %rcx
	movq %rcx, %rdi
	movl $1, %esi
	movl %r9d, %edx
	movq %rcx, %r12
	movq %r9, %rbx
	callq _c0_init
	movq %r12, %rcx
	movq %rbx, %r9
	movl %r9d, %r8d
	imull %r9d, %r8d
	movslq %r8d, %rdi
	movq $4, %rsi
	movq %rcx, %r12
	movq %r9, %rbx
	callq calloc
	movq %r12, %rcx
	movq %rbx, %r9
	movq %rax, %rbx
	movq %rbx, %rdi
	movl %r9d, %r8d
	imull %r9d, %r8d
	movl %r8d, %esi
	addl $1, %esi
	movl %r9d, %edx
	movq %rcx, %r13
	movq %r9, %r12
	callq _c0_init
	movq %r13, %rcx
	movq %r12, %r9
	movl %r9d, %r8d
	imull %r9d, %r8d
	movslq %r8d, %rdi
	movq $4, %rsi
	movq %rcx, %r13
	movq %r9, %r12
	callq calloc
	movq %r13, %rcx
	movq %r12, %r9
	movq %rax, %r8
	movq %rcx, %rdi
	movq %rbx, %rsi
	movq %r8, %rdx
	movl %r9d, %ecx
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_mmult
	movq %r12, %r8
	movq %rbx, %r9
	movl %r9d, %ecx
	imull %r9d, %ecx
	movl %ecx, %r9d
	subl $1, %r9d
	imull $4, %r9d
	movslq %r9d, %rcx
	movq %r8, %r9
	addq %rcx, %r9
	movl (%r9), %r9d
	movl %r9d, %eax
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.ident	"15-411 L4 reference compiler"
