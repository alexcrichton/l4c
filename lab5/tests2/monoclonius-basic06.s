.file	"../tests2/monoclonius-basic06.l1"
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
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
