.file	"../tests1/hobby-return6.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $6, %r8d
	movl $3, %esi
	movl $7, %r9d
	movl %esi, %ecx
	subl %r9d, %ecx
	addl %ecx, %r8d
	movl %r9d, %ecx
	imull %r9d, %ecx
	movl %ecx, %edx
	addl $6, %edx
	movl %esi, %ecx
	subl %edx, %ecx
	movl %r8d, %eax
	cltd
	idivl %ecx
	imull %eax, %r9d
	movl %r9d, %eax
	cltd
	idivl %ecx
	movl %edx, %r9d
	addl $1, %r9d
	movl %r8d, %eax
	cltd
	idivl %r9d
	movl %ecx, %r9d
	addl %eax, %r9d
	subl $1, %r9d
	cltd
	idivl %r9d
	movl %edx, %r9d
	movl %r9d, %eax
	addl $2, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
