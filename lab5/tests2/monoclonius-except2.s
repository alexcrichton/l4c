.file	"../tests2/monoclonius-except2.l4"
.globl _c0_main
_c0_compute:
	addq $-8, %rsp
.compute_0:
	movq %rdi, %r9
	movq $0, (%r9)
	movq %rsi, %r9
	movq $0, (%r9)
	movl $1, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-40, %rsp
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
.main_0:
	movq $1, %rdi
	movq $8, %rsi
	callq calloc
	movq %rax, %r9
	movq $1, %rdi
	movq $8, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movq %rax, %rcx
	movq %r9, %r8
	movq $1, %rdi
	movq $4, %rsi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, (%r8)
	movq %rcx, %r8
	movq $1, %rdi
	movq $4, %rsi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, (%r8)
	movq %r9, %rdi
	movq %rcx, %rsi
	movq %rcx, %r12
	movq %r9, %rbx
	callq _c0_compute
	movq %r12, %rcx
	movq %rbx, %r9
	movq (%r9), %r9
	movl (%r9), %r8d
	movq %rcx, %r9
	movq (%r9), %r9
	movl (%r9), %r9d
	movl %r8d, %eax
	addl %r9d, %eax
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.ident	"15-411 L4 reference compiler"
