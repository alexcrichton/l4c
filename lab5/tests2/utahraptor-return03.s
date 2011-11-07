.file	"../tests2/utahraptor-return03.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $16, %r9d
	movl %r9d, %eax
	imull $2, %eax
	movl $4, %r8d
	cltd
	idivl %r8d
	movl %eax, %r8d
	movl $2, %ecx
	movl %r9d, %eax
	cltd
	idivl %ecx
	addl %edx, %r8d
	movl %r8d, %ecx
	addl $3, %ecx
	movl %r9d, %r8d
	subl $10, %r8d
	movl %ecx, %eax
	movl %r8d, %ecx
	sall %cl, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
