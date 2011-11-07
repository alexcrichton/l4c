.file	"../tests2/stegosaurus-return03.l1"
.globl _c0_main
_c0_main:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
.main_0:
	movl $2, %r9d
	movl $22, %r8d
	movl $0, %ebx
	movl $1, %ecx
	movl $17, %esi
	movl $4, %eax
	movl $2, %edi
	cltd
	idivl %edi
	movl %eax, %edx
	movl $3, %edi
	imull $5, %edi
	movl %edi, %eax
	addl %edx, %eax
	movl %r9d, %edi
	addl %eax, %edi
	movl %edi, %r9d
	subl $8, %r9d
	movl %r8d, %eax
	cltd
	idivl %r9d
	movl %eax, %r12d
	movl $2, %eax
	cltd
	idivl %r12d
	movl %ebx, %r9d
	subl %eax, %r9d
	movl %r9d, %edx
	addl $7, %edx
	movl %ecx, %r8d
	imull %edx, %r8d
	movl %edi, %ecx
	subl %r12d, %ecx
	subl %r8d, %ecx
	addl %r9d, %ecx
	movl %esi, %eax
	cltd
	idivl %ecx
	movl %edx, %ecx
	movl %edi, %edx
	addl %r12d, %edx
	addl %r9d, %edx
	movl %r8d, %r9d
	imull %ecx, %r9d
	movl %edx, %eax
	addl %r9d, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
