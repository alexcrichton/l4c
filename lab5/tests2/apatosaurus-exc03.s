.file	"../tests2/apatosaurus-exc03.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1, %r9d
	movl %r9d, %eax
	sall $31, %eax
	movl %eax, %r9d
	sarl $31, %r9d
	cltd
	idivl %r9d
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
