.file	"../tests1/kite-exception1.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %r9d
	movl $1, %eax
	cltd
	idivl %r9d
	movl %eax, %r8d
	movl $2, %r9d
	imull %r8d, %r9d
	movl $3, %r8d
	subl %r9d, %r8d
	movl $0, %r9d
	subl %r8d, %r9d
	movl $0, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
