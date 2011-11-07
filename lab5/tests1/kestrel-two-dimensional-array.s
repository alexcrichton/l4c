.file	"../tests1/kestrel-two-dimensional-array.l4"
.globl _c0_main
_c0_f:
	addq $-8, %rsp
.f_0:
	movl $0, %r8d
	imull $8, %r8d
	movslq %r8d, %r8
	movq %rdi, %r9
	addq %r8, %r9
	movq (%r9), %rcx
	movl $0, %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq %rcx, %r9
	addq %r8, %r9
	movl (%r9), %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movq $1, %rdi
	movq $8, %rsi
	callq calloc
	movq %rax, %r9
	movq $1, %rdi
	movq $4, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movl $0, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movl $42, (%r8)
	movl $0, %r8d
	imull $8, %r8d
	movslq %r8d, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq %rax, (%r8)
	movq %r9, %rdi
	callq _c0_f
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
