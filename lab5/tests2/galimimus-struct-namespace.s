.file	"../tests2/galimimus-struct-namespace.l4"
.globl _c0_main
_c0_foo:
	addq $-8, %rsp
.foo_0:
	movl $42, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movq $1, %rdi
	movq $8, %rsi
	callq calloc
	movq $1, %rdi
	movq $4, %rsi
	callq calloc
	callq _c0_foo
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
