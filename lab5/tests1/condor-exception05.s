.file	"../tests1/condor-exception05.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %r8d
	subl $0, %r8d
	movl $0, %eax
	subl $0, %eax
	movl $0, %r9d
	subl %r8d, %r9d
	cltd
	idivl %r9d
	movl %edx, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
