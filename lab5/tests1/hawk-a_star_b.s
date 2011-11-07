.file	"../tests1/hawk-a_star_b.l4"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movq $1, %rdi
	movq $4, %rsi
	callq calloc
	movq %rax, %r9
	movl $100, (%r9)
	movq %rax, %r9
	movl (%r9), %r9d
	movq %rax, %r8
	movl (%r8), %ecx
	movl %r9d, %r8d
	imull %ecx, %r8d
	movq %rax, %r8
	movl (%r8), %eax
	cltd
	idivl %r9d
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
