.file	"../tests2/dilophosaurus-return01.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %r9d
	subl $3, %r9d
	subl $5, %r9d
	movl $0, %r8d
	subl $1, %r8d
	imull %r8d, %r9d
	movl $1, %r8d
	addl $1, %r8d
	movl %r9d, %ecx
	subl %r8d, %ecx
	movl $2, %r9d
	imull $2, %r9d
	movl %r9d, %r8d
	subl $1, %r8d
	movl %ecx, %r9d
	imull %r8d, %r9d
	movl $3, %r8d
	subl $2, %r8d
	imull %r8d, %r9d
	movl $2, %r8d
	addl %r9d, %r8d
	movl $1, %r9d
	addl %r8d, %r9d
	movl %r8d, %eax
	imull %r9d, %eax
	movl $0, %r9d
	subl %r8d, %r9d
	movl %r9d, %r8d
	addl $1, %r8d
	movl $0, %r9d
	subl %r8d, %r9d
	movl $0, %r8d
	subl $1, %r8d
	subl %r8d, %r9d
	cltd
	idivl %r9d
	movl %eax, %edx
	movl $0, %ecx
	subl $1, %ecx
	movl $0, %r9d
	subl $1, %r9d
	movl $0, %r8d
	subl $1, %r8d
	imull %r8d, %r9d
	addl %r9d, %ecx
	movl $0, %r8d
	subl $1, %r8d
	movl $1, %r9d
	subl %r8d, %r9d
	imull %edx, %r9d
	movl %ecx, %eax
	addl %r9d, %eax
	movl $43, %r9d
	cltd
	idivl %r9d
	movl %edx, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
