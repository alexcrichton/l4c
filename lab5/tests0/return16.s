.file	"../tests0/return16.l3"
.globl _c0_main
_c0_foo:
	addq $-8, %rsp
.foo_0:
	movl %edi, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %edi
	callq _c0_foo
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
