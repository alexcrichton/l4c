.file	"../tests1/hobby-check-shadowing.l3"
.globl _c0_main
_c0_foo:
	addq $-8, %rsp
.foo_0:
	movl $5, %r8d
	movl %edi, %r9d
	addl %esi, %r9d
	movl %r9d, %eax
	addl %r8d, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $13, %edi
	movl $4, %esi
	callq _c0_foo
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
