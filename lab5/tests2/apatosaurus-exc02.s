.file	"../tests2/apatosaurus-exc02.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $-2147483648, %r9d
	movl $-2147483648, %eax
	sarl $31, %r9d
	cltd
	idivl %r9d
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
