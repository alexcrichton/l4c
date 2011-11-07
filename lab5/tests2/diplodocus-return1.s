.file	"../tests2/diplodocus-return1.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $3, %r9d
	imull $3, %r9d
	movl $3, %r8d
	addl %r9d, %r8d
	movl %r8d, %r9d
	subl $7, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
