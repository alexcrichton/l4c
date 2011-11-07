.file	"../tests2/apatosaurus-return03.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1, %edx
	movl $5, %esi
	movl $4, %r9d
	movl $20, %eax
	movl %edx, %r8d
	addl %edx, %r8d
	imull %esi, %r9d
	cltd
	idivl %r9d
	movl %eax, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
