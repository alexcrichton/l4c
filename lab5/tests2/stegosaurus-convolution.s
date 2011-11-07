.file	"../tests2/stegosaurus-convolution.l4"
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
	movl $10, %r9d
	movl $3, %r8d
	movslq %r9d, %rdi
	movq $4, %rsi
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, %rdx
	movslq %r8d, %rdi
	movq $4, %rsi
	movq %rdx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r13, %rdx
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, %rcx
	movl %r9d, %esi
	addl %r8d, %esi
	subl $1, %esi
	movslq %esi, %rdi
	movq $4, %rsi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, %rsi
	movl $0, %edi
	imull $4, %edi
	movslq %edi, %rax
	movq %rdx, %rdi
	addq %rax, %rdi
	movl $0, (%rdi)
	movl $1, %edi
	imull $4, %edi
	movslq %edi, %rax
	movq %rdx, %rdi
	addq %rax, %rdi
	movl $0, (%rdi)
	subl $1, (%rdi)
	movl $2, %edi
	imull $4, %edi
	movslq %edi, %rax
	movq %rdx, %rdi
	addq %rax, %rdi
	movl $1, (%rdi)
	movl $3, %edi
	imull $4, %edi
	movslq %edi, %rdi
	movq %rdx, %rax
	addq %rdi, %rax
	movl $4, (%rax)
	movl $4, %edi
	imull $4, %edi
	movslq %edi, %rdi
	movq %rdx, %rax
	addq %rdi, %rax
	movl $5, (%rax)
	movl $5, %edi
	imull $4, %edi
	movslq %edi, %rax
	movq %rdx, %rdi
	addq %rax, %rdi
	movl $8, (%rdi)
	movl $6, %edi
	imull $4, %edi
	movslq %edi, %rax
	movq %rdx, %rdi
	addq %rax, %rdi
	movl $0, (%rdi)
	movl $7, %edi
	imull $4, %edi
	movslq %edi, %rax
	movq %rdx, %rdi
	addq %rax, %rdi
	movl $0, (%rdi)
	subl $6, (%rdi)
	movl $8, %edi
	imull $4, %edi
	movslq %edi, %rax
	movq %rdx, %rdi
	addq %rax, %rdi
	movl $0, (%rdi)
	subl $4, (%rdi)
	movl $9, %edi
	imull $4, %edi
	movslq %edi, %rax
	movq %rdx, %rdi
	addq %rax, %rdi
	movl $2, (%rdi)
	movl $0, %edi
	imull $4, %edi
	movslq %edi, %rax
	movq %rcx, %rdi
	addq %rax, %rdi
	movl $1, (%rdi)
	movl $1, %edi
	imull $4, %edi
	movslq %edi, %rdi
	movq %rcx, %rax
	addq %rdi, %rax
	movl $0, (%rax)
	movl $2, %edi
	imull $4, %edi
	movslq %edi, %rax
	movq %rcx, %rdi
	addq %rax, %rdi
	movl $2, (%rdi)
	movl $0, %edi
.main_14:
	movl %edi, %r12d
.main_1:
	movl $1, %ebx
	movl %r9d, %edi
	addl %r8d, %edi
	movl %edi, %eax
	subl $1, %eax
	movl %r12d, %edi
	cmpl %eax, %edi
	setl %dil
	movzbl %dil, %edi
	cmpl %edi, %ebx
	jnz .main_3
.main_2:
	movl %r12d, %edi
	imull $4, %edi
	movslq %edi, %rax
	movq %rsi, %rdi
	addq %rax, %rdi
	movl $0, (%rdi)
	movl %r12d, %edi
	addl $1, %edi
.main_13:
	movl %edi, %r12d
	jmp .main_1
.main_3:
	movl $0, %edi
.main_16:
	movl %edi, %r15d
.main_4:
	movl $1, %eax
	movl %r15d, %edi
	cmpl %r9d, %edi
	setl %dil
	movzbl %dil, %edi
	cmpl %edi, %eax
	jnz .main_9
.main_5:
	movl $0, %edi
.main_18:
	movl %edi, %r14d
.main_6:
	movl $1, %eax
	movl %r14d, %edi
	cmpl %r8d, %edi
	setl %dil
	movzbl %dil, %edi
	cmpl %edi, %eax
	jnz .main_8
.main_7:
	movl %r15d, %edi
	imull $4, %edi
	movslq %edi, %rax
	movq %rdx, %rdi
	addq %rax, %rdi
	movl (%rdi), %r13d
	movl %r14d, %edi
	imull $4, %edi
	movslq %edi, %rax
	movq %rcx, %rdi
	addq %rax, %rdi
	movl (%rdi), %r12d
	movl %r15d, %edi
	addl %r14d, %edi
	imull $4, %edi
	movslq %edi, %rdi
	movq %rsi, %rbx
	addq %rdi, %rbx
	movl %r15d, %edi
	addl %r14d, %edi
	imull $4, %edi
	movslq %edi, %rax
	movq %rsi, %rdi
	addq %rax, %rdi
	movl (%rdi), %eax
	movl %r13d, %edi
	imull %r12d, %edi
	movl %eax, (%rbx)
	addl %edi, (%rbx)
	movl %r14d, %edi
	addl $1, %edi
.main_17:
	movl %edi, %r14d
	jmp .main_6
.main_8:
	movl %r15d, %edi
	addl $1, %edi
.main_15:
	movl %edi, %r15d
	jmp .main_4
.main_9:
	movl $0, %eax
	movl $24, %edx
	movl $0, %ecx
.main_20:
	movl %edx, %edi
	movl %ecx, %edx
.main_10:
	movl $1, %r12d
	movl %r9d, %ecx
	addl %r8d, %ecx
	movl %ecx, %ebx
	subl $1, %ebx
	movl %edx, %ecx
	cmpl %ebx, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %r12d
	jnz .main_12
.main_11:
	movl %edx, %ecx
	imull $4, %ecx
	movslq %ecx, %rbx
	movq %rsi, %rcx
	addq %rbx, %rcx
	movl (%rcx), %ecx
	movl %ecx, %ebx
	movl %edi, %ecx
	sall %cl, %ebx
	movl %eax, %ecx
	xorl %ebx, %ecx
	movl $0, %eax
	cmpl %eax, %edi
	jz .ternary_true1
	subl $8, %edi
	jmp .ternary_end2
.ternary_true1:
	movl $24, %edi
.ternary_end2:
	movl %edi, %ebx
	movl %edx, %edi
	imull $4, %edi
	movslq %edi, %rax
	movq %rsi, %rdi
	addq %rax, %rdi
	movl (%rdi), %edi
	movq %rsi, %rbp
	movq %rdx, %r15
	movq %rcx, %r14
	movq %r8, %r13
	movq %r9, %r12
	callq printint
	movq %rbp, %rsi
	movq %r15, %rdx
	movq %r14, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movl $10, %edi
	movq %rsi, %rbp
	movq %rdx, %r15
	movq %rcx, %r14
	movq %r8, %r13
	movq %r9, %r12
	callq printchar
	movq %rbp, %rsi
	movq %r15, %rdx
	movq %r14, %rcx
	movq %r13, %r8
	movq %r12, %r9
	addl $1, %edx
.main_19:
	movl %ebx, %edi
	movl %ecx, %eax
	jmp .main_10
.main_12:
	movq 8(%rsp), %rbp
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
.ident	"15-411 L4 reference compiler"
