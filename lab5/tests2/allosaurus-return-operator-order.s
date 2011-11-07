.file	"../tests2/allosaurus-return-operator-order.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $6, %eax
	movl $3, %r9d
	cltd
	idivl %r9d
	movl %eax, %ecx
	movl $1, %r9d
	addl $2, %r9d
	movl %r9d, %eax
	sall %cl, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
