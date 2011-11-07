.file	"../tests2/diplodocus-passbyvalue.l3"
.globl _c0_main
_c0_foo:
	addq $-8, %rsp
.foo_0:
	movl %edi, %r9d
	addl $1, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movl $1, %r9d
	movl %r9d, %edi
	movq %r9, %rbx
	callq _c0_foo
	movq %rbx, %r9
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
