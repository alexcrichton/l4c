.file	"../tests1/goshawk-exception04.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $2, %r9d
	imull $2, %r9d
	imull $2, %r9d
	imull $2, %r9d
	imull $2, %r9d
	imull $2, %r9d
	imull $2, %r9d
	imull $2, %r9d
	imull $2, %r9d
	imull $2, %r9d
	imull $2, %r9d
	imull $2, %r9d
	imull $2, %r9d
	imull $2, %r9d
	imull $2, %r9d
	imull $2, %r9d
	imull $2, %r9d
	imull $2, %r9d
	imull $2, %r9d
	imull $2, %r9d
	imull $2, %r9d
	imull $2, %r9d
	imull $2, %r9d
	imull $2, %r9d
	imull $2, %r9d
	imull $2, %r9d
	imull $2, %r9d
	imull $2, %r9d
	imull $2, %r9d
	imull $2, %r9d
	movl %r9d, %r8d
	imull $2, %r8d
	movl $0, %r9d
	subl $1, %r9d
	movl %r8d, %eax
	imull %r9d, %eax
	movl $0, %r9d
	subl $1, %r9d
	cltd
	idivl %r9d
	movl %edx, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
