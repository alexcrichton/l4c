.file	"../tests2/microceratops-exception03.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1024, %r9d
	movl %r9d, %eax
	cltd
	idivl %r9d
	cltd
	idivl %r9d
	movl %eax, %r9d
	movl $5, %eax
	cltd
	idivl %r9d
	movl %edx, %r9d
	movl $1, %eax
	cltd
	idivl %r9d
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
