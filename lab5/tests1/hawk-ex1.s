.file	"../tests1/hawk-ex1.l4"
.globl _c0_main
_c0_main:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
.main_0:
	movq $1, %rdi
	movq $8, %rsi
	callq calloc
	movq %rax, %r9
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl $0, %ecx
	subl $3, %ecx
	movslq %ecx, %rdi
	movq $4, %rsi
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, (%r8)
	movq $0, %r8
	addq %r8, %r9
	movq (%r9), %r8
	movl $0, %r9d
	imull $4, %r9d
	movslq %r9d, %r9
	addq %r9, %r8
	movl $27, (%r8)
	movl $0, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
