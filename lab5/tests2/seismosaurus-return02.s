.file	"../tests2/seismosaurus-return02.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $42, %r9d
	movl $2, %eax
	imull %r9d, %eax
	cltd
	idivl %r9d
	movl %eax, %r8d
	subl $2, %r8d
	addl %r9d, %r8d
	movl %r8d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
