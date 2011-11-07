.file	"../tests1/merlin-typedef2.l3"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $15411, %edi
	callq _c0_f
	movl %eax, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
_c0_f:
	addq $-8, %rsp
.f_0:
	movl %edi, %r9d
	subl $1, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
