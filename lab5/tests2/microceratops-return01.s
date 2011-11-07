.file	"../tests2/microceratops-return01.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1, %eax
	movl %eax, %r9d
	movl $1, %r8d
	cltd
	idivl %r8d
	movl %eax, %ecx
	movl %r8d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
