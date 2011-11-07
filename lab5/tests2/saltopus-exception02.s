.file	"../tests2/saltopus-exception02.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $34, %eax
	movl $7, %r9d
	cltd
	idivl %r9d
	movl %edx, %r8d
	movl %r9d, %eax
	cltd
	idivl %r8d
	movl %edx, %ecx
	movl %r8d, %eax
	cltd
	idivl %ecx
	movl %edx, %r9d
	movl %ecx, %eax
	cltd
	idivl %r9d
	movl %edx, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
