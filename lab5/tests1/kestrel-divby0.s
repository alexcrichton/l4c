.file	"../tests1/kestrel-divby0.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $42, %eax
	movl $0, %r9d
	cltd
	idivl %r9d
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
