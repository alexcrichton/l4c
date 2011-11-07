.file	"../tests1/sparrowhawk-linkedlist3.l4"
.globl _c0_main
_c0_length:
	addq $-8, %rsp
.length_0:
	movq $8, %r8
	movq %rdi, %r9
	addq %r8, %r9
	movq (%r9), %r9
	movq %r9, %rdi
	callq _c0_length
	movl $1, %r9d
	addl %eax, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-24, %rsp
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
	movq $8, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq %rax, (%r8)
	movq $8, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movq %r9, (%r8)
	movq %r9, %rdi
	callq _c0_length
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
