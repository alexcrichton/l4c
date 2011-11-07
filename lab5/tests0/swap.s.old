.file	"../tests0/swap.l4"
.globl _c0_main
_c0_swap:
	addq $-8, %rsp
.swap_0:
	movq %rdi, %r8
	movl (%r8), %r8d
	movl %r8d, %ecx
	movq %rsi, %r8
	movl (%r8), %r8d
	movq %rdi, %r9
	movl %r8d, (%r9)
	movq %rsi, %r9
	movl %ecx, (%r9)
	movl $0, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
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
	movq %rax, %r8
	movq %r9, %rcx
	movl $3, (%rcx)
	movq %r8, %rcx
	movl $7, (%rcx)
	movq %r9, %rdi
	movq %r8, %rsi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_swap
	movq %r12, %r8
	movq %rbx, %r9
	movl (%r9), %r9d
	movl (%r8), %r8d
	imull $10, %r9d
	movl %r9d, %eax
	addl %r8d, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
