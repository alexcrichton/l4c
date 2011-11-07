.file	"../tests2/brachiosaurus-mult.l4"
.globl _c0_main
_c0_main:
	addq $-56, %rsp
	movq %r15, 16(%rsp)
	movq %r14, 24(%rsp)
	movq %r13, 32(%rsp)
	movq %r12, 40(%rsp)
	movq %rbx, 48(%rsp)
.main_0:
	movq $1, %rdi
	movq $4, %rsi
	callq calloc
	movq %rax, %r9
	movq $1, %rdi
	movq $4, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movq %rax, %rcx
	movq $1, %rdi
	movq $4, %rsi
	movq %rcx, %r12
	movq %r9, %rbx
	callq calloc
	movq %r12, %rcx
	movq %rbx, %r9
	movq %rax, %r8
	movq $1, %rdi
	movq $4, %rsi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, %rdx
	movq $1, %rdi
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
	movq %rax, %rbx
	movq $1, %rdi
	movq $4, %rsi
	movq %rdx, %r15
	movq %rcx, %r14
	movq %r8, %r13
	movq %r9, %r12
	callq calloc
	movq %r15, %rdx
	movq %r14, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movq %rax, %r12
	movq %r9, %rsi
	movl $1, (%rsi)
	movq %rcx, %rsi
	movl $2, (%rsi)
	movq %r8, %rsi
	movl $3, (%rsi)
	movq %rdx, %rsi
	movl $4, (%rsi)
	movq %rbx, %rsi
	movl $5, (%rsi)
	movq %r12, %rsi
	movl $6, (%rsi)
	movq %r9, %rsi
	movl (%rsi), %eax
	movl (%rcx), %edi
	movl (%r8), %esi
	movq %rdx, %r8
	movl (%r8), %ecx
	movq %rbx, %r8
	movl (%r8), %r8d
	movq %r12, %rdx
	movl (%rdx), %ebx
	movq %r9, %r12
	movl %eax, %edx
	imull %edi, %edx
	imull %esi, %edx
	imull %ecx, %edx
	movl %edx, %ecx
	imull %r8d, %ecx
	movl %ecx, (%r12)
	movl (%r12), %r11d
	imull %ebx, %r11d
	movl %r11d, (%r12)
	movl (%r9), %r9d
	movl %r9d, %eax
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
.ident	"15-411 L4 reference compiler"
