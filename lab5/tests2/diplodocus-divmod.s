.file	"../tests2/diplodocus-divmod.l3"
.globl _c0_main
_c0_d:
	addq $-8, %rsp
	movl %edi, %eax
.d_0:
	cltd
	idivl %esi
	addq $8, %rsp
	ret
_c0_m:
	addq $-8, %rsp
	movl %edi, %eax
.m_0:
	cltd
	idivl %esi
	movl %edx, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
.main_0:
	movl $6, %edi
	movl $3, %esi
	callq _c0_d
	movl %eax, %r9d
	movl $8, %eax
	movl $1, %r8d
	cltd
	idivl %r8d
	movl %eax, %edi
	movl $4, %esi
	movq %r9, %rbx
	callq _c0_d
	movq %rbx, %r9
	movl %eax, %r8d
	movl $9, %edi
	movl $5, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_m
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %ecx
	movl %r9d, %eax
	imull %r8d, %eax
	cltd
	idivl %ecx
	movl %edx, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
