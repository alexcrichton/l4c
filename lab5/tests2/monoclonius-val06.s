.file	"../tests2/monoclonius-val06.l3"
.globl _c0_main
_c0_foo:
	addq $-8, %rsp
.foo_0:
	movl $5, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
.main_0:
	movl $1, %edi
	callq _c0_foo
	movl %eax, %r9d
	movl $2, %edi
	movq %r9, %rbx
	callq _c0_foo
	movq %rbx, %r9
	movl %eax, %r8d
	movl $3, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_foo
	movq %r12, %r8
	movq %rbx, %r9
	imull %r8d, %r9d
	imull %eax, %r9d
	movl %r9d, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
