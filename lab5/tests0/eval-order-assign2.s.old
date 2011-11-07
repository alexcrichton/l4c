.file	"../tests0/eval-order-assign2.l4"
.globl _c0_main
_c0_test:
	addq $-8, %rsp
.test_0:
	movq %rdi, %r8
	movq (%r8), %r8
	movq %rdi, %r9
	movq $0, (%r9)
	movq %r8, %rax
	addq $8, %rsp
	ret
_c0_main:
	addq $-40, %rsp
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
.main_0:
	movq $1, %rdi
	movq $4, %rsi
	callq calloc
	movq %rax, %r9
	movq $1, %rdi
	movq $8, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movq %rax, %r8
	movq %r8, %rcx
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
	movq %r8, %rdi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_test
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, %rcx
	movl (%rcx), %ecx
	movq (%r8), %r8
	movl (%r8), %edx
	movl %ecx, %r8d
	imull $4, %r8d
	movslq %r8d, %r8
	addq %r8, %r9
	movl %edx, (%r9)
	movl $0, %eax
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.ident	"15-411 L4 reference compiler"
