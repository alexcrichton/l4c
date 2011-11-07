.file	"../tests2/galimimus-mod-zero.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $9, %eax
	movl $0, %r9d
	subl $1, %r9d
	movl %r9d, %r8d
	sarl $1, %r8d
	movl $-1, %r9d
	xorl %r8d, %r9d
	cltd
	idivl %r9d
	movl %edx, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
