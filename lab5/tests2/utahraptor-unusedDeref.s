.file	"../tests2/utahraptor-unusedDeref.l4"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movq $0, %r9
	movl (%r9), %r9d
	movl $0, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
