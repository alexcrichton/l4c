.file	"../tests2/galimimus-return02.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $2, %r9d
	movl $0, %r8d
	subl %r9d, %r8d
	movl $0, %ecx
	subl %r8d, %ecx
	movl $2, %eax
	imull %ecx, %eax
	movl $4, %ecx
	cltd
	idivl %ecx
	movl %eax, %esi
	movl $3, %ecx
	movl %r8d, %eax
	cltd
	idivl %ecx
	movl %edx, %r8d
	movl $1, %eax
	movl $3, %ecx
	cltd
	idivl %ecx
	movl %eax, %ecx
	movl $0, %eax
	subl $3, %eax
	movl $2, %edi
	cltd
	idivl %edi
	addl %esi, %r9d
	addl %r8d, %r9d
	addl %ecx, %r9d
	movl %r9d, %eax
	addl %edx, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
