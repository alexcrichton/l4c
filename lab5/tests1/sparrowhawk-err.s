.file	"../tests1/sparrowhawk-err.l4"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movq $10, %rdi
	movq $4, %rsi
	callq calloc
	movl $0, %r9d
	subl $100, %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq %rax, %r9
	addq %r8, %r9
	movl $5, (%r9)
	movl $0, %r9d
	subl $100, %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq %rax, %r9
	addq %r8, %r9
	movl (%r9), %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
