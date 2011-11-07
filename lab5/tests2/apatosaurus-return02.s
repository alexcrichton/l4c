.file	"../tests2/apatosaurus-return02.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1, %eax
	movl $2, %r8d
	movl $5, %esi
	movl $4, %edi
	movl $20, %ecx
	movl $3, %r9d
	movl %eax, %edx
	addl %eax, %edx
	addl %edx, %r8d
	movl %esi, %edx
	subl %r8d, %edx
	movl %edi, %r8d
	imull %edx, %r8d
	movl %ecx, %eax
	cltd
	idivl %r8d
	cltd
	idivl %r9d
	movl %edx, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
