.file	"../tests1/hobby-exception2.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $8, %eax
	movl $0, %r9d
	cltd
	idivl %r9d
	movl %edx, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
