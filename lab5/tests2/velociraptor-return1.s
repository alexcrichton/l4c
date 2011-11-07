.file	"../tests2/velociraptor-return1.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $2, %r9d
	movl %r9d, %r8d
	imull $2, %r8d
	movl $3, %r9d
	addl %r8d, %r9d
	addl $5, %r9d
	movl %r8d, %eax
	addl %r9d, %eax
	movl $2, %r9d
	cltd
	idivl %r9d
	movl %eax, %r9d
	movl %r9d, %ecx
	subl $1, %ecx
	movl $0, %r9d
	movl %r9d, %r8d
	subl %ecx, %r8d
	movl $0, %eax
	subl %r8d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
