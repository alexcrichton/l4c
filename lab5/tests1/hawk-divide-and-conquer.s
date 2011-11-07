.file	"../tests1/hawk-divide-and-conquer.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %r9d
	movl $5, %r8d
	movl %r8d, %eax
	cltd
	idivl %r9d
	movl %r8d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
