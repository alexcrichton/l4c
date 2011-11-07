.file	"../tests1/eagle-div3.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $6, %r9d
	movl %r9d, %eax
	addl $2, %eax
	movl $2, %r9d
	addl $1, %r9d
	cltd
	idivl %r9d
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
