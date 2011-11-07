.file	"../tests1/gyrfalcon-exception01.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $80, %eax
	movl $40, %r9d
	movl $2, %r8d
	imull %r9d, %r8d
	movl %eax, %r9d
	subl %r8d, %r9d
	cltd
	idivl %r9d
	movl %eax, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
