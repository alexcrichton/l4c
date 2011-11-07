.file	"../tests0/eval-order-assign.l4"
.globl _c0_main
_c0_foo:
	addq $-8, %rsp
.foo_0:
	movq %rdi, %rcx
	movq %rdi, %r8
	movl (%r8), %r8d
	movl %r8d, (%rcx)
	addl $1, (%rcx)
	movq %rdi, %rax
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
	movq %r9, %r8
	movl (%r8), %r8d
	movq %r9, %rdi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_foo
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, %rcx
	movl (%rcx), %edx
	movq %r9, %rcx
	movl %r8d, (%rcx)
	addl %edx, (%rcx)
	movl (%r9), %r9d
	movl %r9d, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
