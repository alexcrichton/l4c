.file	"../tests1/gyrfalcon-exception03.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $2, %eax
	movl $5, %r9d
	cltd
	idivl %r9d
	movl %eax, %r8d
	movl %r9d, %eax
	cltd
	idivl %r8d
	movl %edx, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
