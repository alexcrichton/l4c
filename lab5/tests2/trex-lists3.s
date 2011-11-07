.file	"../tests2/trex-lists3.l4"
.globl _c0_main
_c0_f:
	addq $-8, %rsp
.f_0:
	movl %edi, %eax
	addl %esi, %eax
	addq $8, %rsp
	ret
_c0_fold:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.fold_0:
	movl $1, %edx
	movq $0, %rcx
	movq %rdi, %r9
	cmpq %rcx, %r9
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %edx
	jnz .fold_2
.fold_1:
	movl %esi, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.fold_2:
	movq $8, %r9
	movq %rdi, %rcx
	addq %r9, %rcx
	movq (%rcx), %r9
	movq $0, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl (%r8), %r8d
	movl %r8d, %edi
	movq %r9, %rbx
	callq _c0_f
	movq %rbx, %r9
	movq %r9, %rdi
	movl %eax, %esi
	callq _c0_fold
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
	movq $0, %rcx
	movq %r9, %rdx
	addq %rcx, %rdx
	movl $1, (%rdx)
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
	movq $0, (%rcx)
	movq %r9, %rdi
	movl $0, %esi
	callq _c0_fold
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
