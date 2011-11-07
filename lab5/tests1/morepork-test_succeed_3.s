.file	"../tests1/morepork-test_succeed_3.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %r9d
	subl $1, %r9d
	movl $2, %r9d
	addl $2, %r9d
	movl $7, %r9d
	subl $2, %r9d
	movl $5, %r9d
	imull $3, %r9d
	movl $9, %eax
	movl $3, %r9d
	cltd
	idivl %r9d
	movl %eax, %r9d
	movl $14, %eax
	movl $5, %r8d
	cltd
	idivl %r8d
	movl %edx, %r8d
	addl $4, %r9d
	movl %r8d, %eax
	subl $3, %eax
	movl %r9d, %r8d
	imull $0, %r8d
	movl $1, %r9d
	cltd
	idivl %r9d
	movl $3, %r9d
	movl %r8d, %eax
	cltd
	idivl %r9d
	movl $1, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
