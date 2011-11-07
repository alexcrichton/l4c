.file	"../tests1/merlin-meta2.l3"
.globl _c0_main
_c0_main:
	addq $-168, %rsp
	movq %rbp, 88(%rsp)
	movq %r15, 96(%rsp)
	movq %r14, 104(%rsp)
	movq %r13, 112(%rsp)
	movq %r12, 120(%rsp)
	movq %rbx, 128(%rsp)
.main_0:
	movl $4, %ebx
	movl $9, %r12d
	movl %ebx, 136(%rsp)
	xorl %r12d, 136(%rsp)
	movl 136(%rsp), %r9d
	imull $9, %r9d
	movl $8, %eax
	cltd
	idivl %r9d
	movl %eax, 140(%rsp)
	movl 140(%rsp), %eax
	cltd
	idivl %r9d
	movl %eax, %r8d
	imull %ebx, %r8d
	movl %r8d, %r14d
	subl $1, %r14d
	movl $39, %ebp
	movl %ebp, %edi
	movl 140(%rsp), %r8d
	imull $0, %r8d
	movl %r8d, 144(%rsp)
	subl $4, 144(%rsp)
	movl $66666, 148(%rsp)
	subl $999999, 148(%rsp)
	movl $4444444, %esi
	addl $22222, %esi
	movl $1, %r8d
	addl $0, %r8d
	movl %r8d, %r13d
	addl $1, %r13d
	movl 148(%rsp), %eax
	cltd
	idivl %esi
	cltd
	idivl %r13d
	movl %eax, %r15d
	movl 136(%rsp), %r8d
	imull %r9d, %r8d
	subl 140(%rsp), %r8d
	addl $3, %r8d
	movl %r8d, 152(%rsp)
	subl %ebx, 152(%rsp)
	movl $3, %r8d
	movl 144(%rsp), %eax
	cltd
	idivl %r8d
	movl 152(%rsp), %ecx
	sall $3, %ecx
	movl %ecx, 156(%rsp)
	andl %edx, 156(%rsp)
	movl %ebx, 160(%rsp)
	subl $3, 160(%rsp)
	movl %ebx, 164(%rsp)
	movl %r12d, %eax
	movl 136(%rsp), %edx
	movl %r9d, %ecx
	movl 140(%rsp), %r8d
	movl %r14d, %r9d
	movl %ebp, 0(%rsp)
	movl %edi, 8(%rsp)
	movl 144(%rsp), %r10d
	movl %r10d, 16(%rsp)
	movl 148(%rsp), %r10d
	movl %r10d, 24(%rsp)
	movl %esi, 32(%rsp)
	movl %r13d, 40(%rsp)
	movl %r15d, 48(%rsp)
	movl 152(%rsp), %r10d
	movl %r10d, 56(%rsp)
	movl 156(%rsp), %r10d
	movl %r10d, 64(%rsp)
	movl 164(%rsp), %edi
	movl %eax, %esi
	callq _c0_use_a_bunch_of_vars
	movl %eax, %r9d
	movl %r15d, %eax
	imull %r9d, %eax
	cltd
	idivl 148(%rsp)
	movl %edx, %eax
	cltd
	idivl 156(%rsp)
	movl %r12d, %r8d
	imull %ebp, %r8d
	movl %ebx, %ecx
	addl %r8d, %ecx
	movl %ecx, %r8d
	subl %r14d, %r8d
	addl 136(%rsp), %r8d
	subl %r13d, %r8d
	addl %eax, %r8d
	movl %r8d, %eax
	addl 160(%rsp), %eax
	movq 88(%rsp), %rbp
	movq 96(%rsp), %r15
	movq 104(%rsp), %r14
	movq 112(%rsp), %r13
	movq 120(%rsp), %r12
	movq 128(%rsp), %rbx
	addq $168, %rsp
	ret
_c0_use_a_bunch_of_vars:
	addq $-56, %rsp
	movq %r15, 16(%rsp)
	movq %r14, 24(%rsp)
	movq %r13, 32(%rsp)
	movq %r12, 40(%rsp)
	movq %rbx, 48(%rsp)
	movl %r9d, %r14d
	movl 64(%rsp), %r15d
	movl 72(%rsp), %ebx
	movl 80(%rsp), %r13d
	movl 88(%rsp), %r12d
	movl 128(%rsp), %ecx
.use_a_bunch_of_vars_0:
	movl $1, %r8d
	movl $2, %eax
	movl $3, %edi
	movl $4, %esi
	movl $99, %edx
	movl $98, %r9d
	addl %eax, %r8d
	subl %edi, %r8d
	addl %esi, %r8d
	subl %edx, %r8d
	addl %r9d, %r8d
	movl %r8d, %r9d
	subl %r13d, %r9d
	addl %r14d, %r9d
	subl %ebx, %r9d
	addl %r15d, %r9d
	movl %esi, %r8d
	imull %r12d, %r8d
	subl %r8d, %r9d
	movl %r9d, %eax
	sall %cl, %eax
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
.ident	"15-411 L4 reference compiler"
