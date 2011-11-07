.file	"../tests1/eagle-return2.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $6, %eax
	movl $0, %r8d
	subl $8, %r8d
	movl $0, %r9d
	addl %r8d, %r9d
	movl $3, %r8d
	cltd
	idivl %r8d
	movl %eax, %r8d
	movl %r9d, %eax
	cltd
	idivl %r8d
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
