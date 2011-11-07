.file	"../tests2/diplodocus-callmain.l3"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	callq _c0_foo
	movl $2, %eax
	addq $8, %rsp
	ret
_c0_foo:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.foo_0:
	callq _c0_main
	movl %eax, %r9d
	movq %r9, %rbx
	callq _c0_main
	movq %rbx, %r9
	addl %eax, %r9d
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
