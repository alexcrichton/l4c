.file	"../tests2/vulcanodon-return01.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $42, %r9d
	addl $5, %r9d
	imull $2, %r9d
	movl %r9d, %eax
	subl $10, %eax
	movl $2, %r9d
	cltd
	idivl %r9d
	movl %eax, %r8d
	movl $13, %r9d
	addl $29, %r9d
	addl %r8d, %r9d
	subl %r8d, %r9d
	subl $10, %r9d
	addl $10, %r9d
	movl %r9d, %eax
	imull $5, %eax
	movl $5, %r9d
	cltd
	idivl %r9d
	movl %eax, %r9d
	movl $5, %r8d
	imull $4, %r8d
	subl $10, %r8d
	movl %r8d, %eax
	addl $22, %eax
	movl $32, %r8d
	cltd
	idivl %r8d
	imull %eax, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
