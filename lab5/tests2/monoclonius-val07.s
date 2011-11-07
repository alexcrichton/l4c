.file	"../tests2/monoclonius-val07.l3"
.globl _c0_main
_c0_foo:
	addq $-8, %rsp
.foo_0:
	movl $20, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movl $100, %r8d
	movq %r8, %rbx
	callq _c0_foo
	movq %rbx, %r8
	movl %eax, %r9d
	movl %r8d, %eax
	cltd
	idivl %r9d
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
