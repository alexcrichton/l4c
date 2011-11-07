.file	"../tests1/eagle-arg-munching.l3"
.globl _c0_main
_c0_bar:
	addq $-104, %rsp
	movq %rbp, 8(%rsp)
	movq %r15, 16(%rsp)
	movq %r14, 24(%rsp)
	movq %r13, 32(%rsp)
	movq %r12, 40(%rsp)
	movq %rbx, 48(%rsp)
	movl %edx, %ebx
	movl %r9d, 56(%rsp)
	movl 112(%rsp), %r10d
	movl %r10d, 60(%rsp)
	movl 120(%rsp), %r9d
	movl 128(%rsp), %r13d
	movl 136(%rsp), %r14d
.bar_0:
	movl $1, %r15d
	movl $2, 64(%rsp)
	movl $3, 68(%rsp)
	movl $5, %r12d
	movl $5, %eax
	movl $6, %edx
	movl $7, 72(%rsp)
	movl $8, 76(%rsp)
	movl $9, 80(%rsp)
	movl $10, 84(%rsp)
	movl $11, 88(%rsp)
	movl $12, %ebp
	addl %edi, %ebp
	addl %esi, 88(%rsp)
	addl %ebx, 84(%rsp)
	addl %ecx, 80(%rsp)
	addl %r8d, 76(%rsp)
	movl 56(%rsp), %r10d
	addl %r10d, 72(%rsp)
	movl %edx, 92(%rsp)
	movl 60(%rsp), %r10d
	addl %r10d, 92(%rsp)
	movl %eax, 96(%rsp)
	addl %r9d, 96(%rsp)
	movl %r12d, 100(%rsp)
	addl %r13d, 100(%rsp)
	movl 68(%rsp), %r12d
	addl %r14d, %r12d
	movl 64(%rsp), %eax
	cltd
	idivl %r12d
	cltd
	idivl 100(%rsp)
	movl %edx, %eax
	imull 96(%rsp), %eax
	cltd
	idivl 92(%rsp)
	movl %edi, %edx
	addl %esi, %edx
	addl %ebx, %edx
	addl %ecx, %edx
	movl %edx, %ecx
	addl %r8d, %ecx
	movl %ecx, %r8d
	addl 56(%rsp), %r8d
	addl 60(%rsp), %r8d
	addl %r9d, %r8d
	movl %r8d, %r9d
	addl %r13d, %r9d
	movl %r14d, %r8d
	imull %r15d, %r8d
	addl %r8d, %r9d
	addl %eax, %r9d
	movl 72(%rsp), %r8d
	imull 76(%rsp), %r8d
	addl %r8d, %r9d
	addl 80(%rsp), %r9d
	movl %r9d, %r8d
	subl 84(%rsp), %r8d
	movl 88(%rsp), %r9d
	imull %ebp, %r9d
	movl %r8d, %eax
	subl %r9d, %eax
	movq 8(%rsp), %rbp
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $104, %rsp
	ret
_c0_foo:
	addq $-72, %rsp
	movq %r13, 48(%rsp)
	movq %r12, 56(%rsp)
	movq %rbx, 64(%rsp)
	movl 80(%rsp), %r12d
	movl 88(%rsp), %ebx
	movl 96(%rsp), %eax
	movl 104(%rsp), %r13d
.foo_0:
	movl %r12d, 0(%rsp)
	movl %ebx, 8(%rsp)
	movl %eax, 16(%rsp)
	movl %r13d, 24(%rsp)
	callq _c0_bar
	movq 48(%rsp), %r13
	movq 56(%rsp), %r12
	movq 64(%rsp), %rbx
	addq $72, %rsp
	ret
_c0_main:
	addq $-40, %rsp
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
	movl $0, 24(%rsp)
	callq _c0_foo
	addq $40, %rsp
	ret
.ident	"15-411 L4 reference compiler"
