.file	"../tests2/vulcanodon-return02.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %r9d
	addl $37, %r9d
	subl $12, %r9d
	movl %r9d, %eax
	imull $3, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
