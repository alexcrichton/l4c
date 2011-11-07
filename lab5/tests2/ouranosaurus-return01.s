.file	"../tests2/ouranosaurus-return01.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $80, %eax
	movl $3, %r9d
	cltd
	idivl %r9d
	movl %eax, %r9d
	imull $4, %r9d
	movl %r9d, %r8d
	subl $4, %r8d
	movl $0, %r9d
	subl $17, %r9d
	movl %r8d, %eax
	addl %r9d, %eax
	movl $10, %r9d
	cltd
	idivl %r9d
	movl %edx, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
