.file	"../tests2/trex-sums.l4"
.globl _c0_main
_c0_inl:
	addq $-40, %rsp
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
	movl %edi, %r9d
.inl_0:
	movq $1, %rdi
	movq $24, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movq %rax, %r8
	movq $0, %rcx
	movq %r8, %rdx
	addq %rcx, %rdx
	movl $1, (%rdx)
	movq $8, %rdx
	movq %r8, %rcx
	addq %rdx, %rcx
	movq $1, %rdi
	movq $4, %rsi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, (%rcx)
	movq $8, %rcx
	movq %r8, %rdx
	addq %rcx, %rdx
	movq (%rdx), %rcx
	movl %r9d, (%rcx)
	movq %r8, %rax
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
_c0_inr:
	addq $-40, %rsp
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
	movl %edi, %r9d
.inr_0:
	movq $1, %rdi
	movq $24, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movq %rax, %r8
	movq $0, %rcx
	movq %r8, %rdx
	addq %rcx, %rdx
	movl $0, (%rdx)
	movq $16, %rdx
	movq %r8, %rcx
	addq %rdx, %rcx
	movq $1, %rdi
	movq $4, %rsi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, (%rcx)
	movq $16, %rcx
	movq %r8, %rdx
	addq %rcx, %rdx
	movq (%rdx), %rcx
	movl %r9d, (%rcx)
	movq %r8, %rax
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
_c0_equals:
	addq $-8, %rsp
	movq %rdi, %r9
	movq %rsi, %rdi
.equals_0:
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl (%r8), %esi
	movq $0, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl (%r8), %edx
	movl $1, %ecx
	movl %esi, %r8d
	cmpl %edx, %r8d
	setne %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .equals_3
.equals_1:
	movl $0, %eax
	addq $8, %rsp
	ret
.equals_3:
.equals_4:
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl (%r8), %ecx
	movl $1, %r8d
	cmpl %ecx, %r8d
	jnz .equals_6
.equals_5:
	movq $8, %r8
	addq %r8, %r9
	movq (%r9), %r9
	movl (%r9), %ecx
	movq $8, %r8
	movq %rdi, %r9
	addq %r8, %r9
	movq (%r9), %r9
	movl (%r9), %r8d
	movl %ecx, %eax
	cmpl %r8d, %eax
	sete %al
	movzbl %al, %eax
	addq $8, %rsp
	ret
.equals_6:
	movq $16, %r8
	addq %r8, %r9
	movq (%r9), %r9
	movl (%r9), %ecx
	movq $16, %r8
	movq %rdi, %r9
	addq %r8, %r9
	movq (%r9), %r9
	movl (%r9), %r8d
	movl %ecx, %eax
	cmpl %r8d, %eax
	sete %al
	movzbl %al, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movl $5, %edi
	callq _c0_inl
	movq %rax, %r9
	movl $5, %edi
	movq %r9, %rbx
	callq _c0_inl
	movq %rbx, %r9
	movq %rax, %rcx
	movq %r9, %rdi
	movq %rcx, %rsi
	callq _c0_equals
	cmpl $0, %eax
	jnz .ternary_true1
	movl $0, %r9d
	jmp .ternary_end2
.ternary_true1:
	movl $1, %r9d
.ternary_end2:
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
