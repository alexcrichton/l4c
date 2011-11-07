.file	"../tests1/goshawk-return02.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %r9d
	addl $1337, %r9d
	subl $42, %r9d
	movl %r9d, %eax
	imull $2, %eax
	movl $4, %r9d
	cltd
	idivl %r9d
	movl $67, %r9d
	cltd
	idivl %r9d
	movl %edx, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
