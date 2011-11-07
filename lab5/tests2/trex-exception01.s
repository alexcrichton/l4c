.file	"../tests2/trex-exception01.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1, %eax
	movl $0, %r9d
	cltd
	idivl %r9d
	movl %eax, %r9d
	movl $1, %eax
	cltd
	idivl %r9d
	movl %edx, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
