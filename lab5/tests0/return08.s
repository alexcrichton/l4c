.file	"../tests0/return08.l3"
.globl _c0_main
_c0_foo:
	addq $-8, %rsp
.foo_0:
	movl $1, %r8d
	cmpl %esi, %r8d
	jnz .foo_2
.foo_1:
	movl %edi, %eax
	addq $8, %rsp
	ret
.foo_2:
	movl $10, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %edi
	movl $1, %esi
	callq _c0_foo
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
