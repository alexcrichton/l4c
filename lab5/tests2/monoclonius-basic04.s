.file	"../tests2/monoclonius-basic04.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $32, %eax
	movl $2, %r9d
	cltd
	idivl %r9d
	cltd
	idivl %r9d
	cltd
	idivl %r9d
	cltd
	idivl %r9d
	cltd
	idivl %r9d
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
