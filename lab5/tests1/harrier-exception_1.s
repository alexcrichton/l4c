.file	"../tests1/harrier-exception_1.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $2147483643, %eax
	movl $0, %r9d
	cltd
	idivl %r9d
	movl %eax, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
