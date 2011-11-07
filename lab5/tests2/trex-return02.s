.file	"../tests2/trex-return02.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1337, %r9d
	movl $1000, %r8d
	movl %r9d, %eax
	cltd
	idivl %r8d
	movl %eax, %r8d
	movl $1000, %ecx
	movl %r9d, %eax
	cltd
	idivl %ecx
	movl %edx, %ecx
	movl $100, %r9d
	movl %ecx, %eax
	cltd
	idivl %r9d
	movl %eax, %esi
	movl $100, %r9d
	movl %ecx, %eax
	cltd
	idivl %r9d
	movl %edx, %edi
	movl $10, %r9d
	movl %edi, %eax
	cltd
	idivl %r9d
	movl %eax, %r9d
	movl $10, %ecx
	movl %edi, %eax
	cltd
	idivl %ecx
	movl %edx, %ecx
	movl %ecx, %edx
	imull $1000, %r8d
	movl %esi, %ecx
	imull $100, %ecx
	addl %ecx, %r8d
	imull $10, %r9d
	addl %r9d, %r8d
	movl %r8d, %eax
	addl %edx, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
