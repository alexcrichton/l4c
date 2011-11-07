.file	"../tests2/trex-indirection_exception.l4"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movq $1, %rdi
	movq $8, %rsi
	callq calloc
	movq %rax, %r9
	movq (%r9), %r9
	movq (%r9), %r9
	movq (%r9), %r9
	movq (%r9), %r9
	movq (%r9), %r9
	movq (%r9), %r9
	movq (%r9), %r9
	movq (%r9), %r9
	movq (%r9), %r9
	movl $1, (%r9)
	movq %rax, %r9
	movq (%r9), %r9
	movq (%r9), %r9
	movq (%r9), %r9
	movq (%r9), %r9
	movq (%r9), %r9
	movq (%r9), %r9
	movq (%r9), %r9
	movq (%r9), %r9
	movq (%r9), %r9
	movl (%r9), %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
