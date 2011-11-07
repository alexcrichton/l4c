.file	"../tests2/diplodocus-alloc_test.l4"
.globl _c0_main
_c0_take_arr:
	addq $-8, %rsp
.take_arr_0:
	movl $0, %r8d
	imull $4, %r8d
	movslq %r8d, %r8
	movq %rdi, %r9
	addq %r8, %r9
	movl (%r9), %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movl $5, %r9d
	movl $2000, %eax
	cltd
	idivl %r9d
	movl %eax, %r8d
	addl $500, %r8d
	movslq %r8d, %rdi
	movq $4, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movq %rax, %r8
	movl $100, %eax
	cltd
	idivl %r9d
	movslq %eax, %rdi
	movq $4, %rsi
	movq %r8, %rbx
	callq calloc
	movq %rbx, %r8
	movl $0, %r9d
	imull $4, %r9d
	movslq %r9d, %rcx
	movq %rax, %r9
	addq %rcx, %r9
	movl $55, (%r9)
	movl $0, %r9d
	imull $4, %r9d
	movslq %r9d, %rcx
	movq %r8, %r9
	addq %rcx, %r9
	movl $1, (%r9)
	movq %rax, %rdi
	movq %r8, %rbx
	callq _c0_take_arr
	movq %rbx, %r8
	movq %r8, %rdi
	callq _c0_take_arr
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
