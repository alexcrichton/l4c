.file	"../tests2/brachiosaurus-stress-func4.l3"
.globl _c0_main
_c0_l:
	addq $-8, %rsp
.l_0:
	movl $2, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1, %eax
	movl $0, %r9d
	cltd
	idivl %r9d
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
