.file	"../tests1/morepork-test_succeed_2.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $3, %r9d
	addl $7, %r9d
	movl $3, %r8d
	movl %r8d, %eax
	addl $3, %eax
	movl $2, %r8d
	cltd
	idivl %r8d
	subl %eax, %r9d
	movl $2, %eax
	movl $3, %r9d
	cltd
	idivl %r9d
	movl %edx, %r9d
	movl $4, %eax
	movl $1, %r8d
	cltd
	idivl %r8d
	addl %eax, %r9d
	movl $8, %r8d
	addl %r9d, %r8d
	movl $0, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
