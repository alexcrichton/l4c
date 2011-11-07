.file	"../tests2/stegosaurus-return01.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $4, %r9d
	movl $6, %r8d
	movl %r9d, %eax
	cltd
	idivl %r8d
	movl %eax, %ecx
	movl %r8d, %eax
	cltd
	idivl %r9d
	movl %edx, %r8d
	movl %ecx, %r9d
	imull $8, %r9d
	addl %r8d, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
