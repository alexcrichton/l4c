.file	"../tests1/kestrel-returnsimp2.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $63, %eax
	movl $9, %r9d
	cltd
	idivl %r9d
	movl %eax, %r8d
	movl %r8d, %r9d
	imull %r8d, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
