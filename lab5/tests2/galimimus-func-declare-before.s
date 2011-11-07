.file	"../tests2/galimimus-func-declare-before.l3"
.globl _c0_main
_c0_foo:
	addq $-8, %rsp
.foo_0:
	movl $0, %eax
	addq $8, %rsp
	ret
_c0_bar:
	addq $-8, %rsp
.bar_0:
	callq _c0_foo
	addq $8, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	callq _c0_bar
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
