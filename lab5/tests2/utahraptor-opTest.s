.file	"../tests2/utahraptor-opTest.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %r9d
	addl $2, %r9d
	imull $4, %r9d
	movl $0, %eax
	subl %r9d, %eax
	movl $2, %r8d
	cltd
	idivl %r8d
	movl %eax, %r8d
	movl %r8d, %eax
	subl $5, %eax
	addl $7, %r9d
	imull $10, %r9d
	movl $13, %r8d
	cltd
	idivl %r8d
	movl %eax, %r8d
	subl $20, %r8d
	movl $18, %ecx
	movl %r9d, %eax
	cltd
	idivl %ecx
	movl %edx, %r9d
	movl %r8d, %eax
	cltd
	idivl %r9d
	movl %edx, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
