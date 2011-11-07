.file	"../tests1/kite-init.l4"
.globl _c0_main
_c0_init:
	addq $-8, %rsp
.init_0:
	movq %rdi, %r9
	movl $314, (%r9)
	movl $0, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movq $1, %rdi
	movq $4, %rsi
	callq calloc
	movq %rax, %r9
	movq %r9, %rdi
	movq %r9, %rbx
	callq _c0_init
	movq %rbx, %r9
	movl (%r9), %r9d
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
