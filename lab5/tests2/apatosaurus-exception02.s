.file	"../tests2/apatosaurus-exception02.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1, %edx
	movl $2, %ecx
	movl $3, %r8d
	movl %r8d, %r9d
	imull %r8d, %r9d
	movl %ecx, %r8d
	imull %r9d, %r8d
	addl %edx, %r8d
	movl %edx, %r9d
	addl %r8d, %r9d
	movl $0, %r8d
	subl $1, %r8d
	movl $0, %eax
	subl $-2147483648, %eax
	cltd
	idivl %r8d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
