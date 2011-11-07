.file	"../tests2/ouranosaurus-exceptions01.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $3, %r9d
	movl $1, %eax
	movl $2, %r8d
	cltd
	idivl %r8d
	movl %eax, %r8d
	movl %r9d, %eax
	cltd
	idivl %r8d
	movl %eax, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
