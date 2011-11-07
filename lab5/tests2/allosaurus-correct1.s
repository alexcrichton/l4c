.file	"../tests2/allosaurus-correct1.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $4, %r9d
	movl %r9d, %ecx
	imull $3, %ecx
	movl %r9d, %r8d
	addl $3, %r8d
	movl %ecx, %r9d
	imull $2, %r9d
	addl $2, %r8d
	imull $1, %r9d
	addl $1, %r8d
	movl %r9d, %eax
	subl %r8d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
