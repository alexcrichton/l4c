.file	"../tests1/goshawk-exception01.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $34234, %eax
	movl $5, %r9d
	cltd
	idivl %r9d
	movl %eax, %ecx
	movl $111, %eax
	movl $3, %r9d
	cltd
	idivl %r9d
	movl $2, %r9d
	cltd
	idivl %r9d
	movl $4, %r9d
	cltd
	idivl %r9d
	movl $6543, %r8d
	movl $23434, %r9d
	subl %eax, %r9d
	movl %r8d, %eax
	cltd
	idivl %r9d
	movl %eax, %esi
	movl $4, %eax
	movl $6, %r9d
	cltd
	idivl %r9d
	movl %eax, %r9d
	movl $366356, %eax
	movl $67, %r8d
	cltd
	idivl %r8d
	movl $1, %r8d
	movl $5234, %edi
	subl %r9d, %edi
	movl %edi, %r9d
	addl $234, %r9d
	subl %eax, %r9d
	movl %r8d, %eax
	cltd
	idivl %r9d
	movl $24, %r9d
	imull $2, %r9d
	movl %r9d, %edx
	subl $14, %edx
	movl $423, %r9d
	subl %esi, %r9d
	imull %r9d, %ecx
	movl %edx, %r9d
	addl %ecx, %r9d
	subl %eax, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
