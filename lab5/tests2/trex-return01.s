.file	"../tests2/trex-return01.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1, %esi
	movl $2, %eax
	movl $3, %r8d
	movl %esi, %r9d
	addl %eax, %r9d
	movl %r9d, %edx
	imull %r8d, %edx
	movl %r8d, %r9d
	addl %esi, %r9d
	movl %r9d, %r8d
	imull %edx, %r8d
	movl %esi, %r9d
	addl %r8d, %r9d
	movl $2, %r8d
	cltd
	idivl %r8d
	subl %eax, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
