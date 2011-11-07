.file	"../tests2/galimimus-exception02.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %eax
	movl $1, %r9d
	cltd
	idivl %r9d
	movl %eax, %r9d
	movl $9, %eax
	cltd
	idivl %r9d
	movl %edx, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
