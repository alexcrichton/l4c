.file	"../tests1/eagle-exception.l3"
.globl _c0_main
_c0_div:
	addq $-72, %rsp
	movq %rbp, 16(%rsp)
	movq %r15, 24(%rsp)
	movq %r14, 32(%rsp)
	movq %r13, 40(%rsp)
	movq %r12, 48(%rsp)
	movq %rbx, 56(%rsp)
	movl %r9d, %ebx
	movl 80(%rsp), %r10d
	movl %r10d, 64(%rsp)
	movl 88(%rsp), %ebp
	movl 96(%rsp), %r15d
	movl 104(%rsp), %r14d
	movl 112(%rsp), %r13d
	movl 120(%rsp), %r12d
	movl 128(%rsp), %r10d
	movl %r10d, 68(%rsp)
	movl 136(%rsp), %eax
.div_0:
	movl %edi, %r9d
	addl %esi, %r9d
	subl %edx, %r9d
	subl %ecx, %r9d
	addl %r8d, %r9d
	addl %ebx, %r9d
	movl %r9d, %r8d
	subl 64(%rsp), %r8d
	movl %ebp, %r9d
	addl %r15d, %r9d
	subl %r14d, %r9d
	subl %r13d, %r9d
	addl %r12d, %r9d
	addl 68(%rsp), %r9d
	subl %eax, %r9d
	movl %r8d, %eax
	cltd
	idivl %r9d
	movq 16(%rsp), %rbp
	movq 24(%rsp), %r15
	movq 32(%rsp), %r14
	movq 40(%rsp), %r13
	movq 48(%rsp), %r12
	movq 56(%rsp), %rbx
	addq $72, %rsp
	ret
_c0_main:
	addq $-72, %rsp
.main_0:
	movl $1, %edi
	movl $2, %esi
	movl $3, %edx
	movl $4, %ecx
	movl $5, %r8d
	movl $6, %r9d
	movl $7, 0(%rsp)
	movl $8, 8(%rsp)
	movl $9, 16(%rsp)
	movl $10, 24(%rsp)
	movl $11, 32(%rsp)
	movl $12, 40(%rsp)
	movl $13, 48(%rsp)
	movl $21, 56(%rsp)
	callq _c0_div
	addq $72, %rsp
	ret
.ident	"15-411 L4 reference compiler"
