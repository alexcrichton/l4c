.file	"../tests2/galimimus-div-zero.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $-559038737, %r9d
	movl $9, %eax
	movl $-1, %ecx
	xorl %r9d, %ecx
	andl %ecx, %r9d
	cltd
	idivl %r9d
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
