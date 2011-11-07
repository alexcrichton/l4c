.file	"../tests2/triceratops-return02.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $3, %r8d
	movl $0, %r9d
	subl $2, %r9d
	movl %r8d, %eax
	imull %r9d, %eax
	movl $0, %r9d
	subl $1, %r9d
	cltd
	idivl %r9d
	movl %eax, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
