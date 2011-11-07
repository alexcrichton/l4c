.file	"../tests2/trex-lists4.l4"
.globl _c0_main
_c0_max:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.max_0:
	movl $1, %r8d
	movq $0, %rcx
	movq %rdi, %r9
	cmpq %rcx, %r9
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %r8d
	jnz .max_3
.max_1:
	movl $0, %eax
	subl $1, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.max_3:
.max_4:
	movq $8, %r8
	movq %rdi, %r9
	addq %r8, %r9
	movq (%r9), %r8
	movl $1, %r9d
	movq $0, %rcx
	cmpq %rcx, %r8
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %r9d
	jnz .max_7
.max_5:
	movq $0, %r8
	movq %rdi, %r9
	addq %r8, %r9
	movl (%r9), %r9d
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.max_7:
.max_8:
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
	callq _c0_max
	movq %rbx, %r9
	movl %eax, %r8d
	cmpl %r9d, %r8d
	jl .ternary_true1
	jmp .ternary_end2
.ternary_true1:
	movl %r9d, %r8d
.ternary_end2:
	movl %r8d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
.main_0:
	movq $1, %rdi
	movq $16, %rsi
	callq calloc
	movq %rax, %r9
	movq $1, %rdi
	movq $16, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movq %rax, %r8
	movq $1, %rdi
	movq $16, %rsi
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r12, %r8
	movq %rbx, %r9
	movq $0, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movl $1, (%rcx)
	movq $8, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movq %r8, (%rcx)
	movq $0, %rdx
	movq %r8, %rcx
	addq %rdx, %rcx
	movl $2, (%rcx)
	movq $8, %rcx
	addq %rcx, %r8
	movq %rax, (%r8)
	movq $0, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movl $3, (%r8)
	movq $8, %r8
	movq %rax, %rcx
	addq %r8, %rcx
	movq %rax, (%rcx)
	movq %r9, %rdi
	callq _c0_max
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
