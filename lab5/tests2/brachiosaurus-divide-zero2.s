.file	"../tests2/brachiosaurus-divide-zero2.l1"
.globl _c0_main
_c0_main:
	addq $-40, %rsp
	movq %r14, 8(%rsp)
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
.main_0:
	movl $1, %eax
	movl $1, %r9d
	movl $1, %r12d
	movl $1, %r8d
	movl $1, %edi
	movl $1, %r13d
	movl $1, %r14d
	movl $1, %ecx
	movl $0, %esi
	movl $1, %ebx
	cltd
	idivl %r9d
	movl %r12d, %eax
	cltd
	idivl %r8d
	movl %r14d, %eax
	cltd
	idivl %r13d
	movl %ecx, %eax
	cltd
	idivl %esi
	movl %esi, %eax
	cltd
	idivl %ebx
	movl $0, %r9d
	movl %edi, %eax
	cltd
	idivl %r9d
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.ident	"15-411 L4 reference compiler"
