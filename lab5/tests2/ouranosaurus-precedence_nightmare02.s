.file	"../tests2/ouranosaurus-precedence_nightmare02.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $13, %r9d
	movl $3, %r8d
	movl $5, %esi
	movl $48, %ecx
	movl $7, %eax
	cltd
	idivl %ecx
	movl %edx, %eax
	movl $2, %ecx
	cltd
	idivl %ecx
	imull %r8d, %r9d
	movl %r9d, %r8d
	addl %esi, %r8d
	movl $-1, %r9d
	xorl $-1, %r9d
	sarl $1, %r9d
	sall $3, %r9d
	movl %r8d, %ecx
	andl %r9d, %ecx
	movl %eax, %r8d
	imull $6, %r8d
	movl $0, %r9d
	subl $12, %r9d
	movl $44, %edx
	imull %r9d, %edx
	movl %r8d, %r9d
	subl %edx, %r9d
	movl %r9d, %r8d
	xorl $-559038737, %r8d
	movl %ecx, %eax
	orl %r8d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
