.file	"../tests2/allosaurus-correct0.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $3, %ecx
	movl $5, %r8d
	movl %ecx, %r9d
	addl %r8d, %r9d
	subl %ecx, %r9d
	movl %r9d, %eax
	imull $7, %eax
	movl $6, %r9d
	cltd
	idivl %r9d
	movl $2, %r9d
	cltd
	idivl %r9d
	movl %edx, %ecx
	movl $3, %r9d
	imull $4, %r9d
	movl $2, %r8d
	addl %r9d, %r8d
	movl %ecx, %r9d
	addl %r8d, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
