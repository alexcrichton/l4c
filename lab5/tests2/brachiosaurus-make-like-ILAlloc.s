.file	"../tests2/brachiosaurus-make-like-ILAlloc.l3"
.globl _c0_main
_c0_div:
	addq $-8, %rsp
.div_0:
	movl $1, %eax
	movl $0, %r9d
	cltd
	idivl %r9d
	addq $8, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	callq _c0_div
	movl $0, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
