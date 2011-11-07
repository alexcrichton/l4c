.file	"../tests1/hawk-pemdas.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $3, %eax
	imull $4, %eax
	movl $5, %r9d
	cltd
	idivl %r9d
	movl $1, %r9d
	addl $2, %r9d
	subl %eax, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
