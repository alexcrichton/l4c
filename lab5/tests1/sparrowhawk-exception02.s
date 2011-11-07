.file	"../tests1/sparrowhawk-exception02.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $2147483647, %r8d
	movl $0, %r9d
	subl %r8d, %r9d
	movl %r9d, %eax
	subl $1, %eax
	movl $0, %r9d
	subl $1, %r9d
	cltd
	idivl %r9d
	movl %edx, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
