.file	"../tests1/goshawk-return01.l1"
.globl _c0_main
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movl $5, %r9d
	movl %r9d, %r8d
	imull $13, %r8d
	movl %r8d, %eax
	addl $1, %eax
	movl $54, %r8d
	cltd
	idivl %r8d
	movl %eax, %edi
	movl %edi, %eax
	cltd
	idivl %r9d
	movl $2, %r8d
	imull %r9d, %r8d
	movl %r8d, %ecx
	subl %eax, %ecx
	movl $2, %edx
	imull %r9d, %edx
	movl %r9d, %r8d
	addl %edx, %r8d
	movl $4, %edx
	imull %edi, %edx
	subl %edx, %r8d
	movl %ecx, %eax
	imull %r8d, %eax
	movl %r9d, %r8d
	addl %edi, %r8d
	movl %r9d, %edx
	subl %edi, %edx
	imull %edx, %r8d
	cltd
	idivl %r8d
	movl %eax, %ecx
	movl $2, %edx
	imull %edi, %edx
	movl %r9d, %r8d
	addl %edx, %r8d
	movl $3, %edx
	imull %ecx, %edx
	addl %edx, %r8d
	movl %r9d, %esi
	addl %edi, %esi
	movl $4, %edx
	imull %esi, %edx
	movl %r8d, %esi
	addl %edx, %esi
	movl %r9d, %edx
	addl %ecx, %edx
	movl $5, %r8d
	imull %edx, %r8d
	movl %esi, %edx
	addl %r8d, %edx
	movl %edi, %r8d
	addl %ecx, %r8d
	movl $6, %eax
	imull %r8d, %eax
	movl %edx, %esi
	addl %eax, %esi
	movl %r9d, %r8d
	addl %ecx, %r8d
	movl $7, %edx
	imull %r8d, %edx
	movl %esi, %r8d
	addl %edx, %r8d
	movl %r9d, %edx
	subl %edi, %edx
	movl %edx, %esi
	subl %ecx, %esi
	movl %r9d, %edx
	imull %edi, %edx
	addl %edx, %esi
	movl %r9d, %edx
	imull %ecx, %edx
	addl %edx, %esi
	movl %edi, %edx
	imull %ecx, %edx
	movl %esi, %eax
	addl %edx, %eax
	movl %r9d, %edx
	imull %edi, %edx
	movl %edx, %esi
	imull %ecx, %esi
	movl %eax, %edx
	subl %esi, %edx
	movl %r8d, %esi
	imull %edx, %esi
	movl $42, %edx
	imull %r9d, %edx
	movl $1337, %r8d
	imull %edi, %r8d
	addl %r8d, %edx
	movl $-559038737, %r8d
	imull %ecx, %r8d
	movl %edx, %eax
	addl %r8d, %eax
	movl %r9d, %r8d
	imull %r9d, %r8d
	movl %edi, %edx
	imull %edi, %edx
	addl %edx, %r8d
	movl %ecx, %edx
	imull %ecx, %edx
	addl %edx, %r8d
	movl %esi, %edx
	imull %esi, %edx
	addl %edx, %r8d
	cltd
	idivl %r8d
	movl %eax, %ebx
	movl %r9d, %eax
	cltd
	idivl %edi
	cltd
	idivl %ecx
	cltd
	idivl %esi
	movl %r9d, %r8d
	imull %edi, %r8d
	imull %ecx, %r8d
	imull %esi, %r8d
	movl %r8d, %edx
	addl %eax, %edx
	movl %r9d, %r8d
	addl %edi, %r8d
	addl %ecx, %r8d
	addl %esi, %r8d
	addl $123456, %r8d
	movl %edx, %eax
	cltd
	idivl %r8d
	movl %eax, %r8d
	movl %ebx, %eax
	subl %r8d, %eax
	movl $3, %r8d
	imull %r9d, %r8d
	movl %r8d, %edx
	imull %edi, %edx
	movl $2, %r8d
	imull %edi, %r8d
	imull %ecx, %r8d
	subl %r8d, %edx
	movl $4, %r8d
	imull %ecx, %r8d
	imull %esi, %r8d
	addl %r8d, %edx
	movl %r9d, %r8d
	imull %r9d, %r8d
	movl %r8d, %r9d
	imull %edi, %r9d
	imull %edi, %r9d
	imull %ecx, %r9d
	imull %ecx, %r9d
	imull %esi, %r9d
	imull %esi, %r9d
	movl %edx, %r8d
	imull %r9d, %r8d
	movl %eax, %r9d
	addl %r8d, %r9d
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
