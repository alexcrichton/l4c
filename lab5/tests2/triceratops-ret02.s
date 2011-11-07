.file	"../tests2/triceratops-ret02.l4"
.globl _c0_main
_c0_test:
	addq $-8, %rsp
.test_0:
	movl $0, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movq $4, %rdi
	movq $4, %rsi
	callq calloc
	movq %rax, %r9
	movq %r9, %rdi
	movq $0, %rsi
	movq $0, %rdx
	movq %r9, %rbx
	callq _c0_test
	movq %rbx, %r9
	movl $0, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl (%r8), %esi
	movl $1, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl (%r8), %edx
	movl $2, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl (%r8), %ecx
	movl $3, %r8d
	imull $4, %r8d
	movslq %r8d, %r8
	addq %r8, %r9
	movl (%r9), %r9d
	movl %esi, %r8d
	addl %edx, %r8d
	addl %ecx, %r8d
	movl %r8d, %eax
	addl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
