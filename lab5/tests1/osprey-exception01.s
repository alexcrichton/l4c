.file	"../tests1/osprey-exception01.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $3, %r9d
	addl $4, %r9d
	movl $7, %r8d
	subl $0, %r8d
	movl $18, %eax
	movl $4, %ecx
	cltd
	idivl %ecx
	movl %eax, %edx
	movl $6, %ecx
	imull $2, %ecx
	movl %ecx, %eax
	addl %edx, %eax
	subl %r8d, %r9d
	cltd
	idivl %r9d
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
