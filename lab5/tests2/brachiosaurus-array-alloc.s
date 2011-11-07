.file	"../tests2/brachiosaurus-array-alloc.l4"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movq $2, %rdi
	movq $4, %rsi
	callq calloc
	movl $1, %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq %rax, %r9
	addq %r8, %r9
	movl (%r9), %r9d
	movl %r9d, %eax
	addl $1, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
