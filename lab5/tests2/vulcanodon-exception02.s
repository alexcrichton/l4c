.file	"../tests2/vulcanodon-exception02.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $10, %eax
	movl $2, %r9d
	cltd
	idivl %r9d
	movl $6, %r9d
	cltd
	idivl %r9d
	movl %eax, %r9d
	imull $10, %r9d
	addl $12, %r9d
	movl $12, %eax
	cltd
	idivl %r9d
	movl $2, %r9d
	cltd
	idivl %r9d
	movl %eax, %r9d
	movl $12, %eax
	cltd
	idivl %r9d
	movl %eax, %r9d
	movl %r9d, %eax
	addl $10, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
