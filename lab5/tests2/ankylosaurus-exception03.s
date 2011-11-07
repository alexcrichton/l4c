.file	"../tests2/ankylosaurus-exception03.l3"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1, %eax
	movl $0, %r9d
	cltd
	idivl %r9d
	imull $0, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
