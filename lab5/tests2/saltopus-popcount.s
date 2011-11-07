.file	"../tests2/saltopus-popcount.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $309634783, %r9d
	movl %r9d, %r8d
	sarl $1, %r8d
	andl $1431655765, %r8d
	subl %r8d, %r9d
	movl %r9d, %ecx
	andl $858993459, %ecx
	sarl $2, %r9d
	movl %r9d, %r8d
	andl $858993459, %r8d
	movl %ecx, %r9d
	addl %r8d, %r9d
	movl %r9d, %r8d
	sarl $4, %r8d
	addl %r8d, %r9d
	andl $252645135, %r9d
	movl %r9d, %r8d
	sarl $8, %r8d
	addl %r8d, %r9d
	movl %r9d, %r8d
	sarl $16, %r8d
	addl %r8d, %r9d
	movl %r9d, %eax
	andl $63, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
