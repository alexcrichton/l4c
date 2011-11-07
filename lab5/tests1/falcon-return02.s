.file	"../tests1/falcon-return02.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $5, %r9d
	movl $0, %r8d
	subl %r9d, %r8d
	imull $5, %r8d
	addl $4, %r8d
	movl %r8d, %eax
	addl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
