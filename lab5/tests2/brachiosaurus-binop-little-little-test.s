.file	"../tests2/brachiosaurus-binop-little-little-test.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %r9d
	movl $1, %r8d
	addl %r9d, %r8d
	movl %r8d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
