.file	"../tests0/exception04.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %eax
	subl $-2147483648, %eax
	movl $0, %r9d
	subl $1, %r9d
	cltd
	idivl %r9d
	movl %edx, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
