.file	"../tests1/gyrfalcon-return01.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $2, %r9d
	movl %r9d, %r8d
	imull %r9d, %r8d
	movl %r8d, %r9d
	imull %r8d, %r9d
	movl %r9d, %r8d
	imull %r9d, %r8d
	movl $0, %edx
	subl $1, %edx
	movl %r8d, %ecx
	imull %edx, %ecx
	movl %ecx, %eax
	cltd
	idivl %r9d
	movl %edx, %r8d
	movl %ecx, %eax
	cltd
	idivl %r9d
	movl %r8d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
