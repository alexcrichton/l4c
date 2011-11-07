.file	"../tests2/styracosaurus-success1.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $42, %eax
	movl $6, %r9d
	cltd
	idivl %r9d
	movl %eax, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
