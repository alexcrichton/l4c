.file	"../tests2/galimimus-struct-arrow-precedence.l4"
.globl _c0_main
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
	movq $0, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movl $7, (%r8)
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq $0, %rcx
	addq %rcx, %r8
	movq %rax, (%r8)
	movq $0, %r8
	addq %r8, %r9
	movq $0, %r8
	addq %r8, %r9
	movq (%r9), %r9
	movq $0, %r8
	addq %r8, %r9
	movl (%r9), %r9d
	movl $2, %r8d
	imull %r9d, %r8d
	movl $3, %r9d
	imull $8, %r9d
	addl %r9d, %r8d
	movl %r8d, %eax
	addl $4, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
