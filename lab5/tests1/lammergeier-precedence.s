.file	"../tests1/lammergeier-precedence.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %r9d
	subl $1, %r9d
	movl $0, %ecx
	subl $2, %ecx
	movl %r9d, %eax
	imull %ecx, %eax
	movl $4, %r9d
	cltd
	idivl %r9d
	movl $3, %r9d
	cltd
	idivl %r9d
	movl $1, %r9d
	subl %edx, %r9d
	addl $2, %r9d
	movl $0, %r8d
	subl $3, %r8d
	subl %r8d, %r9d
	movl $0, %r8d
	subl $3, %r8d
	movl %r8d, %eax
	imull $4, %eax
	movl $3, %r8d
	cltd
	idivl %r8d
	imull $5, %eax
	movl $9, %r8d
	cltd
	idivl %r8d
	movl $11, %r8d
	cltd
	idivl %r8d
	movl %edx, %r8d
	addl $21, %r8d
	movl $2, %ecx
	movl $4, %eax
	movl $0, %edx
	subl %eax, %edx
	addl %edx, %ecx
	cltd
	idivl %r9d
	movl %edx, %r9d
	movl %ecx, %edx
	addl %r8d, %edx
	movl %edx, %r8d
	addl %ecx, %r8d
	movl $0, %ecx
	subl %r9d, %ecx
	movl %r8d, %eax
	addl %ecx, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
