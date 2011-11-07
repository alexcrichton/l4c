.file	"../tests2/monoclonius-val03.l3"
.globl _c0_main
_c0_foo:
	addq $-8, %rsp
.foo_0:
	callq _c0_main
	addq $8, %rsp
	ret
_c0_hello:
	addq $-8, %rsp
.hello_0:
	movl %edi, %eax
	imull %edi, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $5, %edi
	callq _c0_hello
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
