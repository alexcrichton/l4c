.file	"../tests1/goshawk-return04.l1"
.globl _c0_main
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movl $0, %r9d
	movl %r9d, %r8d
	addl $1, %r8d
	movl %r8d, %ecx
	imull $22, %ecx
	movl $3, %r8d
	movl %ecx, %eax
	cltd
	idivl %r8d
	movl %eax, %esi
	movl $4, %r8d
	movl %esi, %eax
	cltd
	idivl %r8d
	movl %edx, %r8d
	subl $5, %r8d
	addl %r8d, %edx
	imull %edx, %r8d
	movl $0, %edi
	subl $33, %edi
	imull %edi, %r8d
	movl %edx, %ebx
	subl $70, %ebx
	subl %ebx, %r8d
	movl %ebx, %eax
	cltd
	idivl %r8d
	movl %r8d, %edi
	addl $6, %edi
	movl %edx, %r8d
	subl %edi, %r8d
	movl %r8d, %eax
	subl $7, %eax
	movl %edi, %r8d
	imull %eax, %r8d
	imull $8, %r8d
	movl $9, %edi
	cltd
	idivl %edi
	movl %r8d, %eax
	cltd
	idivl %ecx
	movl %edx, %r8d
	addl $11, %r8d
	subl $12, %r8d
	movl %r8d, %eax
	imull $13, %eax
	movl $14, %r8d
	cltd
	idivl %r8d
	movl $12, %r8d
	cltd
	idivl %r8d
	addl %ebx, %r9d
	movl %ecx, %r8d
	imull %esi, %r8d
	subl %r8d, %r9d
	imull %r9d, %r8d
	movl %r8d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
