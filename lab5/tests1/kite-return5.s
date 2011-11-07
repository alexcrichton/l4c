.file	"../tests1/kite-return5.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1, %eax
	movl $2, %r9d
	cltd
	idivl %r9d
	movl $3, %r9d
	cltd
	idivl %r9d
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
