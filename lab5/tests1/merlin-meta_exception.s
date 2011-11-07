.file	"../tests1/merlin-meta_exception.l3"
.globl _c0_main
_c0_main:
	addq $-168, %rsp
	movq %rbp, 84(%rsp)
	movq %r15, 92(%rsp)
	movq %r14, 100(%rsp)
	movq %r13, 108(%rsp)
	movq %r12, 116(%rsp)
	movq %rbx, 124(%rsp)
.main_0:
	movl $4, %ebx
	movl $9, %r12d
	movl $0, 132(%rsp)
	movl $0, %r13d
	movl $0, %ebp
	movl $0, 136(%rsp)
	movl $0, 140(%rsp)
	movl $0, %r14d
	movl $0, %r15d
	movl $66666, 144(%rsp)
	subl $999999, 144(%rsp)
	movl $4444444, %edi
	addl $22222, %edi
	movl $1, %r9d
	addl $0, %r9d
	movl %r9d, 148(%rsp)
	addl $1, 148(%rsp)
	movl $0, 152(%rsp)
	movl 132(%rsp), %r9d
	imull %r13d, %r9d
	subl %ebp, %r9d
	addl $3, %r9d
	movl %r9d, %esi
	subl %ebx, %esi
	movl $3, %r9d
	movl %r15d, %eax
	cltd
	idivl %r9d
	movl %esi, %r9d
	sall $3, %r9d
	movl %r9d, 156(%rsp)
	andl %edx, 156(%rsp)
	movl %ebx, 160(%rsp)
	subl $3, 160(%rsp)
	movl %ebx, 164(%rsp)
	movl %r12d, %eax
	movl 132(%rsp), %edx
	movl %r13d, %ecx
	movl %ebp, %r8d
	movl 136(%rsp), %r9d
	movl 140(%rsp), %r10d
	movl %r10d, 0(%rsp)
	movl %r14d, 8(%rsp)
	movl %r15d, 16(%rsp)
	movl 144(%rsp), %r10d
	movl %r10d, 24(%rsp)
	movl %edi, 32(%rsp)
	movl 148(%rsp), %r10d
	movl %r10d, 40(%rsp)
	movl 152(%rsp), %r10d
	movl %r10d, 48(%rsp)
	movl %esi, 56(%rsp)
	movl 156(%rsp), %r10d
	movl %r10d, 64(%rsp)
	movl 164(%rsp), %edi
	movl %eax, %esi
	callq _c0_use_a_bunch_of_vars
	movl %eax, %r9d
	movl 160(%rsp), %eax
	cltd
	idivl 132(%rsp)
	movl %r12d, %edx
	imull 140(%rsp), %edx
	movl %ebx, %r8d
	addl %edx, %r8d
	subl 136(%rsp), %r8d
	addl 132(%rsp), %r8d
	subl 148(%rsp), %r8d
	movl 152(%rsp), %edx
	imull %r9d, %edx
	movl %r8d, %r9d
	addl %edx, %r9d
	addl 144(%rsp), %r9d
	subl 156(%rsp), %r9d
	addl %eax, %r9d
	addl %r13d, %r9d
	addl %ebp, %r9d
	addl 136(%rsp), %r9d
	addl 140(%rsp), %r9d
	addl %r14d, %r9d
	addl %r15d, %r9d
	movl %r9d, %eax
	addl 152(%rsp), %eax
	movq 84(%rsp), %rbp
	movq 92(%rsp), %r15
	movq 100(%rsp), %r14
	movq 108(%rsp), %r13
	movq 116(%rsp), %r12
	movq 124(%rsp), %rbx
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
