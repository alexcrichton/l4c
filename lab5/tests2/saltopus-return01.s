.file	"../tests2/saltopus-return01.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $43, %r9d
	movl $8, %edx
	movl $5, %eax
	movl %eax, %r8d
	subl %edx, %r8d
	cltd
	idivl %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
