.file	"../tests1/hawk-findmax.l4"
.globl _c0_main
_c0_intmax:
	addq $-8, %rsp
.intmax_0:
	cmpl %edi, %esi
	jl .ternary_true1
	movl %esi, %r8d
	jmp .ternary_end2
.ternary_true1:
	movl %edi, %r8d
.ternary_end2:
	cmpl %r8d, %edx
	jl .ternary_true3
	movl %edx, %r9d
	jmp .ternary_end4
.ternary_true3:
	movl %r8d, %r9d
.ternary_end4:
	movl %r9d, %eax
	addq $8, %rsp
	ret
_c0_findmax:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
	movq %rdi, %r9
.findmax_0:
	movl $1, %ecx
	movq $0, %r8
	movq %r9, %rdx
	cmpq %r8, %rdx
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .findmax_3
.findmax_1:
	movl $0, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.findmax_3:
.findmax_4:
	movq $8, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movq %r8, %rdi
	movq %r9, %rbx
	callq _c0_findmax
	movq %rbx, %r9
	movl %eax, %r8d
	movq $16, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movq (%rcx), %rcx
	movq %rcx, %rdi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_findmax
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %edx
	movq $0, %rcx
	addq %rcx, %r9
	movl (%r9), %r9d
	movl %r9d, %edi
	movl %r8d, %esi
	callq _c0_intmax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_main:
	addq $-40, %rsp
	movq %r14, 8(%rsp)
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
.main_0:
	movq $1, %rdi
	movq $24, %rsi
	callq calloc
	movq %rax, %r9
	movq $1, %rdi
	movq $24, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movq %rax, %rcx
	movq $1, %rdi
	movq $24, %rsi
	movq %rcx, %r12
	movq %r9, %rbx
	callq calloc
	movq %r12, %rcx
	movq %rbx, %r9
	movq %rax, %r8
	movq $1, %rdi
	movq $24, %rsi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, %rdx
	movq $1, %rdi
	movq $24, %rsi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movq $0, %rdi
	movq %rax, %rsi
	addq %rdi, %rsi
	movl $5, (%rsi)
	movq $8, %rdi
	movq %rax, %rsi
	addq %rdi, %rsi
	movq $0, (%rsi)
	movq $16, %rdi
	movq %rax, %rsi
	addq %rdi, %rsi
	movq $0, (%rsi)
	movq $0, %rdi
	movq %rdx, %rsi
	addq %rdi, %rsi
	movl $27, (%rsi)
	movq $8, %rdi
	movq %rdx, %rsi
	addq %rdi, %rsi
	movq %rax, (%rsi)
	movq $16, %rdi
	movq %rdx, %rsi
	addq %rdi, %rsi
	movq $0, (%rsi)
	movq $0, %rdi
	movq %r8, %rsi
	addq %rdi, %rsi
	movl $3, (%rsi)
	movq $8, %rdi
	movq %r8, %rsi
	addq %rdi, %rsi
	movq %rdx, (%rsi)
	movq $16, %rsi
	movq %r8, %rdx
	addq %rsi, %rdx
	movq $0, (%rdx)
	movq $0, %rsi
	movq %rcx, %rdx
	addq %rsi, %rdx
	movl $9, (%rdx)
	movq $8, %rsi
	movq %rcx, %rdx
	addq %rsi, %rdx
	movq $0, (%rdx)
	movq $16, %rsi
	movq %rcx, %rdx
	addq %rsi, %rdx
	movq $0, (%rdx)
	movq $0, %rdx
	movq %r9, %rsi
	addq %rdx, %rsi
	movl $6, (%rsi)
	movq $8, %rdx
	movq %r9, %rsi
	addq %rdx, %rsi
	movq %rcx, (%rsi)
	movq $16, %rcx
	movq %r9, %rdx
	addq %rcx, %rdx
	movq %r8, (%rdx)
	movq %r9, %rdi
	callq _c0_findmax
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.ident	"15-411 L4 reference compiler"
