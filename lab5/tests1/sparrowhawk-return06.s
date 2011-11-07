.file	"../tests1/sparrowhawk-return06.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $32, %r9d
	movl %r9d, %eax
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
	movl %eax, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
