.file	"../tests2/styracosaurus-return01.l3"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $50, %r9d
	movl $50, %r8d
	movl %r9d, %eax
	addl %r8d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
