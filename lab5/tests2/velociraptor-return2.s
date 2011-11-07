.file	"../tests2/velociraptor-return2.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $4, %eax
	movl $3, %r9d
	cltd
	idivl %r9d
	movl $1, %r8d
	addl $2, %r8d
	addl $3, %r8d
	addl %edx, %r8d
	movl $5, %eax
	movl $2, %r9d
	cltd
	idivl %r9d
	movl %eax, %r9d
	imull $7, %r9d
	movl %r9d, %ecx
	subl $1, %ecx
	movl $0, %edx
	subl $1, %edx
	movl $5, %r9d
	subl %edx, %r9d
	movl %ecx, %eax
	cltd
	idivl %r9d
	imull %eax, %r8d
	movl $4, %eax
	imull $3, %eax
	movl $2, %r9d
	cltd
	idivl %r9d
	movl $5, %r9d
	addl %eax, %r9d
	subl $1, %r9d
	movl %r8d, %eax
	cltd
	idivl %r9d
	movl %edx, %r9d
	movl $2, %r8d
	movl %r9d, %eax
	cltd
	idivl %r8d
	movl %eax, %r8d
	imull %ecx, %r8d
	addl %ecx, %r8d
	subl %r9d, %r8d
	movl $7, %eax
	movl $4, %r9d
	cltd
	idivl %r9d
	movl %edx, %r9d
	movl %r8d, %eax
	cltd
	idivl %r9d
	movl %edx, %r9d
	movl $3, %r8d
	imull %r9d, %r8d
	movl %r9d, %edx
	imull %r9d, %edx
	subl %edx, %r8d
	movl %ecx, %eax
	cltd
	idivl %r8d
	movl %eax, %r8d
	subl %r8d, %r9d
	movl $0, %ecx
	subl $1, %ecx
	imull %ecx, %r9d
	addl $2, %r9d
	movl %r9d, %eax
	subl %r8d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
