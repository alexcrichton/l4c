.file	"../tests1/hobby-struct-dots.l4"
.globl _c0_main
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movq $1, %rdi
	movq $32, %rsi
	callq calloc
	movq $0, %r8
	movq %rax, %r9
	addq %r8, %r9
	movq $0, %r8
	addq %r8, %r9
	movq $1, %rdi
	movq $12, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movq %rax, (%r9)
	movl $13, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
