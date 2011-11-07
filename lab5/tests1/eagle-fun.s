.file	"../tests1/eagle-fun.l3"
.globl _c0_main
_c0_fun0:
	addq $-56, %rsp
	movq %rbp, 4(%rsp)
	movq %r15, 12(%rsp)
	movq %r14, 20(%rsp)
	movq %r13, 28(%rsp)
	movq %r12, 36(%rsp)
	movq %rbx, 44(%rsp)
	movl %ecx, %eax
	movl %r8d, %ecx
	movl %r9d, %r14d
	movl 64(%rsp), %ebp
	movl 72(%rsp), %r9d
	movl 80(%rsp), %ebx
	movl 88(%rsp), %r12d
.fun0_0:
	movl %edi, %r13d
	addl %esi, %r13d
	movl %esi, %r15d
	imull %edx, %r15d
	movl $4, %r8d
	cltd
	idivl %r8d
	movl %eax, 52(%rsp)
	movl $32, %r8d
	movl $8, %esi
	movl %ecx, %eax
	cltd
	idivl %esi
	movl %edx, %esi
	movl $10, %edi
	movl $1, %eax
	movl $9, %ecx
	cltd
	idivl %ecx
	movl $300, %edx
	imull $300, %edx
	movl %eax, %ecx
	imull $9, %ecx
	movl $3, %eax
	addl %ecx, %eax
	movl %eax, %ecx
	addl $0, %ecx
	sall %cl, %edx
	imull $4, %r12d
	movl %r14d, %ecx
	andl %ebp, %ecx
	xorl %ebx, %r9d
	orl %r9d, %ecx
	movl $0, %eax
	movl %r13d, %r9d
	addl %r15d, %r9d
	addl 52(%rsp), %r9d
	addl %r8d, %r9d
	addl %esi, %r9d
	addl %edi, %r9d
	addl %edx, %r9d
	addl %r12d, %r9d
	addl %ecx, %r9d
	addl %eax, %r9d
	movl %r9d, %eax
	movq 4(%rsp), %rbp
	movq 12(%rsp), %r15
	movq 20(%rsp), %r14
	movq 28(%rsp), %r13
	movq 36(%rsp), %r12
	movq 44(%rsp), %rbx
	addq $56, %rsp
	ret
_c0_fun1:
	addq $-104, %rsp
	movq %rbp, 48(%rsp)
	movq %r15, 56(%rsp)
	movq %r14, 64(%rsp)
	movq %r13, 72(%rsp)
	movq %r12, 80(%rsp)
	movq %rbx, 88(%rsp)
	movl %ecx, %eax
	movl %r8d, %ecx
	movl %r9d, %r14d
	movl 112(%rsp), %ebp
	movl 120(%rsp), %ebx
	movl 128(%rsp), %r8d
	movl 136(%rsp), %r12d
.fun1_0:
	movl %edi, %r13d
	addl %esi, %r13d
	movl %esi, %r15d
	imull %edx, %r15d
	movl $4, %r9d
	cltd
	idivl %r9d
	movl %eax, 96(%rsp)
	movl $32, %esi
	movl $8, %r9d
	movl %ecx, %eax
	cltd
	idivl %r9d
	movl %edx, %r9d
	movl $10, %edi
	movl $1, %eax
	movl $9, %ecx
	cltd
	idivl %ecx
	movl $300, %edx
	imull $300, %edx
	imull $9, %eax
	movl $3, %ecx
	addl %eax, %ecx
	addl $0, %ecx
	movl %edx, 100(%rsp)
	sall %cl, 100(%rsp)
	imull $4, %r12d
	movl %r14d, %ecx
	andl %ebp, %ecx
	movl %ebx, %edx
	xorl %r8d, %edx
	movl %ecx, %r14d
	orl %edx, %r14d
	movl $0, %ebx
	movl %r15d, %eax
	movl 96(%rsp), %edx
	movl %esi, %ecx
	movl %r9d, %r8d
	movl %edi, %r9d
	movl 100(%rsp), %r10d
	movl %r10d, 0(%rsp)
	movl %r12d, 8(%rsp)
	movl %r14d, 16(%rsp)
	movl %ebx, 24(%rsp)
	movl %r13d, %edi
	movl %eax, %esi
	callq _c0_fun0
	movq 48(%rsp), %rbp
	movq 56(%rsp), %r15
	movq 64(%rsp), %r14
	movq 72(%rsp), %r13
	movq 80(%rsp), %r12
	movq 88(%rsp), %rbx
	addq $104, %rsp
	ret
_c0_fun2:
	addq $-104, %rsp
	movq %rbp, 48(%rsp)
	movq %r15, 56(%rsp)
	movq %r14, 64(%rsp)
	movq %r13, 72(%rsp)
	movq %r12, 80(%rsp)
	movq %rbx, 88(%rsp)
	movl %ecx, %eax
	movl %r8d, %ecx
	movl %r9d, %r14d
	movl 112(%rsp), %ebp
	movl 120(%rsp), %ebx
	movl 128(%rsp), %r8d
	movl 136(%rsp), %r12d
.fun2_0:
	movl %edi, %r13d
	addl %esi, %r13d
	movl %esi, %r15d
	imull %edx, %r15d
	movl $4, %r9d
	cltd
	idivl %r9d
	movl %eax, 96(%rsp)
	movl $42, %esi
	movl $8, %r9d
	movl %ecx, %eax
	cltd
	idivl %r9d
	movl %edx, %r9d
	movl $10, %edi
	movl $1, %eax
	movl $9, %ecx
	cltd
	idivl %ecx
	movl $300, %edx
	imull $300, %edx
	imull $9, %eax
	movl $3, %ecx
	addl %eax, %ecx
	addl $0, %ecx
	movl %edx, 100(%rsp)
	sall %cl, 100(%rsp)
	imull $4, %r12d
	movl %r14d, %ecx
	andl %ebp, %ecx
	movl %ebx, %edx
	xorl %r8d, %edx
	movl %ecx, %r14d
	orl %edx, %r14d
	movl $0, %ebx
	movl %r15d, %eax
	movl 96(%rsp), %edx
	movl %esi, %ecx
	movl %r9d, %r8d
	movl %edi, %r9d
	movl 100(%rsp), %r10d
	movl %r10d, 0(%rsp)
	movl %r12d, 8(%rsp)
	movl %r14d, 16(%rsp)
	movl %ebx, 24(%rsp)
	movl %r13d, %edi
	movl %eax, %esi
	callq _c0_fun1
	movq 48(%rsp), %rbp
	movq 56(%rsp), %r15
	movq 64(%rsp), %r14
	movq 72(%rsp), %r13
	movq 80(%rsp), %r12
	movq 88(%rsp), %rbx
	addq $104, %rsp
	ret
_c0_fun3:
	addq $-104, %rsp
	movq %rbp, 48(%rsp)
	movq %r15, 56(%rsp)
	movq %r14, 64(%rsp)
	movq %r13, 72(%rsp)
	movq %r12, 80(%rsp)
	movq %rbx, 88(%rsp)
	movl %ecx, %eax
	movl %r8d, %ecx
	movl %r9d, %r14d
	movl 112(%rsp), %ebp
	movl 120(%rsp), %ebx
	movl 128(%rsp), %r8d
	movl 136(%rsp), %r12d
.fun3_0:
	movl %edi, %r13d
	addl %esi, %r13d
	movl %esi, %r15d
	imull %edx, %r15d
	movl $4, %r9d
	cltd
	idivl %r9d
	movl %eax, 96(%rsp)
	movl $9, %esi
	movl $8, %r9d
	movl %ecx, %eax
	cltd
	idivl %r9d
	movl %edx, %r9d
	movl $10, %edi
	movl $1, %eax
	movl $9, %ecx
	cltd
	idivl %ecx
	movl $300, %edx
	imull $300, %edx
	imull $9, %eax
	movl $3, %ecx
	addl %eax, %ecx
	addl $0, %ecx
	movl %edx, 100(%rsp)
	sall %cl, 100(%rsp)
	imull $4, %r12d
	movl %r14d, %ecx
	andl %ebp, %ecx
	movl %ebx, %edx
	xorl %r8d, %edx
	movl %ecx, %r14d
	orl %edx, %r14d
	movl $0, %ebx
	movl %r15d, %eax
	movl 96(%rsp), %edx
	movl %esi, %ecx
	movl %r9d, %r8d
	movl %edi, %r9d
	movl 100(%rsp), %r10d
	movl %r10d, 0(%rsp)
	movl %r12d, 8(%rsp)
	movl %r14d, 16(%rsp)
	movl %ebx, 24(%rsp)
	movl %r13d, %edi
	movl %eax, %esi
	callq _c0_fun2
	movq 48(%rsp), %rbp
	movq 56(%rsp), %r15
	movq 64(%rsp), %r14
	movq 72(%rsp), %r13
	movq 80(%rsp), %r12
	movq 88(%rsp), %rbx
	addq $104, %rsp
	ret
_c0_fun4:
	addq $-104, %rsp
	movq %rbp, 48(%rsp)
	movq %r15, 56(%rsp)
	movq %r14, 64(%rsp)
	movq %r13, 72(%rsp)
	movq %r12, 80(%rsp)
	movq %rbx, 88(%rsp)
	movl %ecx, %eax
	movl %r8d, %ecx
	movl %r9d, %r14d
	movl 112(%rsp), %ebp
	movl 120(%rsp), %ebx
	movl 128(%rsp), %r8d
	movl 136(%rsp), %r12d
.fun4_0:
	movl %edi, %r13d
	addl %esi, %r13d
	movl %esi, %r15d
	imull %edx, %r15d
	movl $4, %r9d
	cltd
	idivl %r9d
	movl %eax, 96(%rsp)
	movl $42, %esi
	movl $8, %r9d
	movl %ecx, %eax
	cltd
	idivl %r9d
	movl %edx, %r9d
	movl $10, %edi
	movl $1, %eax
	movl $9, %ecx
	cltd
	idivl %ecx
	movl $300, %edx
	imull $300, %edx
	imull $9, %eax
	movl $3, %ecx
	addl %eax, %ecx
	addl $0, %ecx
	movl %edx, 100(%rsp)
	sall %cl, 100(%rsp)
	imull $4, %r12d
	movl %r14d, %ecx
	andl %ebp, %ecx
	movl %ebx, %edx
	xorl %r8d, %edx
	movl %ecx, %r14d
	orl %edx, %r14d
	movl $0, %ebx
	movl %r15d, %eax
	movl 96(%rsp), %edx
	movl %esi, %ecx
	movl %r9d, %r8d
	movl %edi, %r9d
	movl 100(%rsp), %r10d
	movl %r10d, 0(%rsp)
	movl %r12d, 8(%rsp)
	movl %r14d, 16(%rsp)
	movl %ebx, 24(%rsp)
	movl %r13d, %edi
	movl %eax, %esi
	callq _c0_fun3
	movq 48(%rsp), %rbp
	movq 56(%rsp), %r15
	movq 64(%rsp), %r14
	movq 72(%rsp), %r13
	movq 80(%rsp), %r12
	movq 88(%rsp), %rbx
	addq $104, %rsp
	ret
_c0_fun5:
	addq $-104, %rsp
	movq %rbp, 48(%rsp)
	movq %r15, 56(%rsp)
	movq %r14, 64(%rsp)
	movq %r13, 72(%rsp)
	movq %r12, 80(%rsp)
	movq %rbx, 88(%rsp)
	movl %ecx, %eax
	movl %r8d, %ecx
	movl %r9d, %r14d
	movl 112(%rsp), %ebp
	movl 120(%rsp), %ebx
	movl 128(%rsp), %r8d
	movl 136(%rsp), %r12d
.fun5_0:
	movl %edi, %r13d
	addl %esi, %r13d
	movl %esi, %r15d
	imull %edx, %r15d
	movl $4, %r9d
	cltd
	idivl %r9d
	movl %eax, 96(%rsp)
	movl $42, %esi
	movl $8, %r9d
	movl %ecx, %eax
	cltd
	idivl %r9d
	movl %edx, %r9d
	movl $10, %edi
	movl $1, %eax
	movl $9, %ecx
	cltd
	idivl %ecx
	movl $300, %edx
	imull $300, %edx
	imull $9, %eax
	movl $3, %ecx
	addl %eax, %ecx
	addl $0, %ecx
	movl %edx, 100(%rsp)
	sall %cl, 100(%rsp)
	imull $4, %r12d
	movl %r14d, %ecx
	andl %ebp, %ecx
	movl %ebx, %edx
	xorl %r8d, %edx
	movl %ecx, %r14d
	orl %edx, %r14d
	movl $0, %ebx
	movl %r15d, %eax
	movl 96(%rsp), %edx
	movl %esi, %ecx
	movl %r9d, %r8d
	movl %edi, %r9d
	movl 100(%rsp), %r10d
	movl %r10d, 0(%rsp)
	movl %r12d, 8(%rsp)
	movl %r14d, 16(%rsp)
	movl %ebx, 24(%rsp)
	movl %r13d, %edi
	movl %eax, %esi
	callq _c0_fun4
	movq 48(%rsp), %rbp
	movq 56(%rsp), %r15
	movq 64(%rsp), %r14
	movq 72(%rsp), %r13
	movq 80(%rsp), %r12
	movq 88(%rsp), %rbx
	addq $104, %rsp
	ret
_c0_fun6:
	addq $-104, %rsp
	movq %rbp, 48(%rsp)
	movq %r15, 56(%rsp)
	movq %r14, 64(%rsp)
	movq %r13, 72(%rsp)
	movq %r12, 80(%rsp)
	movq %rbx, 88(%rsp)
	movl %ecx, %eax
	movl %r8d, %ecx
	movl %r9d, %r14d
	movl 112(%rsp), %ebp
	movl 120(%rsp), %ebx
	movl 128(%rsp), %r8d
	movl 136(%rsp), %r12d
.fun6_0:
	movl %edi, %r13d
	addl %esi, %r13d
	movl %esi, %r15d
	imull %edx, %r15d
	movl $4, %r9d
	cltd
	idivl %r9d
	movl %eax, 96(%rsp)
	movl $42, %esi
	movl $8, %r9d
	movl %ecx, %eax
	cltd
	idivl %r9d
	movl %edx, %r9d
	movl $10, %edi
	movl $1, %eax
	movl $9, %ecx
	cltd
	idivl %ecx
	movl $300, %edx
	imull $300, %edx
	imull $9, %eax
	movl $3, %ecx
	addl %eax, %ecx
	addl $0, %ecx
	movl %edx, 100(%rsp)
	sall %cl, 100(%rsp)
	imull $4, %r12d
	movl %r14d, %ecx
	andl %ebp, %ecx
	movl %ebx, %edx
	xorl %r8d, %edx
	movl %ecx, %r14d
	orl %edx, %r14d
	movl $0, %ebx
	movl %r15d, %eax
	movl 96(%rsp), %edx
	movl %esi, %ecx
	movl %r9d, %r8d
	movl %edi, %r9d
	movl 100(%rsp), %r10d
	movl %r10d, 0(%rsp)
	movl %r12d, 8(%rsp)
	movl %r14d, 16(%rsp)
	movl %ebx, 24(%rsp)
	movl %r13d, %edi
	movl %eax, %esi
	callq _c0_fun5
	movq 48(%rsp), %rbp
	movq 56(%rsp), %r15
	movq 64(%rsp), %r14
	movq 72(%rsp), %r13
	movq 80(%rsp), %r12
	movq 88(%rsp), %rbx
	addq $104, %rsp
	ret
_c0_fun7:
	addq $-104, %rsp
	movq %rbp, 48(%rsp)
	movq %r15, 56(%rsp)
	movq %r14, 64(%rsp)
	movq %r13, 72(%rsp)
	movq %r12, 80(%rsp)
	movq %rbx, 88(%rsp)
	movl %ecx, %eax
	movl %r8d, %ecx
	movl %r9d, %r14d
	movl 112(%rsp), %ebp
	movl 120(%rsp), %ebx
	movl 128(%rsp), %r8d
	movl 136(%rsp), %r12d
.fun7_0:
	movl %edi, %r13d
	addl %esi, %r13d
	movl %esi, %r15d
	imull %edx, %r15d
	movl $4, %r9d
	cltd
	idivl %r9d
	movl %eax, 96(%rsp)
	movl $42, %esi
	movl $8, %r9d
	movl %ecx, %eax
	cltd
	idivl %r9d
	movl %edx, %r9d
	movl $10, %edi
	movl $1, %eax
	movl $9, %ecx
	cltd
	idivl %ecx
	movl $300, %edx
	imull $300, %edx
	imull $9, %eax
	movl $3, %ecx
	addl %eax, %ecx
	addl $0, %ecx
	movl %edx, 100(%rsp)
	sall %cl, 100(%rsp)
	imull $4, %r12d
	movl %r14d, %ecx
	andl %ebp, %ecx
	movl %ebx, %edx
	xorl %r8d, %edx
	movl %ecx, %r14d
	orl %edx, %r14d
	movl $0, %ebx
	movl %r15d, %eax
	movl 96(%rsp), %edx
	movl %esi, %ecx
	movl %r9d, %r8d
	movl %edi, %r9d
	movl 100(%rsp), %r10d
	movl %r10d, 0(%rsp)
	movl %r12d, 8(%rsp)
	movl %r14d, 16(%rsp)
	movl %ebx, 24(%rsp)
	movl %r13d, %edi
	movl %eax, %esi
	callq _c0_fun6
	movq 48(%rsp), %rbp
	movq 56(%rsp), %r15
	movq 64(%rsp), %r14
	movq 72(%rsp), %r13
	movq 80(%rsp), %r12
	movq 88(%rsp), %rbx
	addq $104, %rsp
	ret
_c0_fun8:
	addq $-104, %rsp
	movq %rbp, 48(%rsp)
	movq %r15, 56(%rsp)
	movq %r14, 64(%rsp)
	movq %r13, 72(%rsp)
	movq %r12, 80(%rsp)
	movq %rbx, 88(%rsp)
	movl %ecx, %eax
	movl %r8d, %ecx
	movl %r9d, %r14d
	movl 112(%rsp), %ebp
	movl 120(%rsp), %ebx
	movl 128(%rsp), %r8d
	movl 136(%rsp), %r12d
.fun8_0:
	movl %edi, %r13d
	addl %esi, %r13d
	movl %esi, %r15d
	imull %edx, %r15d
	movl $4, %r9d
	cltd
	idivl %r9d
	movl %eax, 96(%rsp)
	movl $42, %esi
	movl $8, %r9d
	movl %ecx, %eax
	cltd
	idivl %r9d
	movl %edx, %r9d
	movl $10, %edi
	movl $1, %eax
	movl $9, %ecx
	cltd
	idivl %ecx
	movl $300, %edx
	imull $300, %edx
	imull $9, %eax
	movl $3, %ecx
	addl %eax, %ecx
	addl $0, %ecx
	movl %edx, 100(%rsp)
	sall %cl, 100(%rsp)
	imull $4, %r12d
	movl %r14d, %ecx
	andl %ebp, %ecx
	movl %ebx, %edx
	xorl %r8d, %edx
	movl %ecx, %r14d
	orl %edx, %r14d
	movl $0, %ebx
	movl %r15d, %eax
	movl 96(%rsp), %edx
	movl %esi, %ecx
	movl %r9d, %r8d
	movl %edi, %r9d
	movl 100(%rsp), %r10d
	movl %r10d, 0(%rsp)
	movl %r12d, 8(%rsp)
	movl %r14d, 16(%rsp)
	movl %ebx, 24(%rsp)
	movl %r13d, %edi
	movl %eax, %esi
	callq _c0_fun7
	movq 48(%rsp), %rbp
	movq 56(%rsp), %r15
	movq 64(%rsp), %r14
	movq 72(%rsp), %r13
	movq 80(%rsp), %r12
	movq 88(%rsp), %rbx
	addq $104, %rsp
	ret
_c0_fun9:
	addq $-104, %rsp
	movq %rbp, 48(%rsp)
	movq %r15, 56(%rsp)
	movq %r14, 64(%rsp)
	movq %r13, 72(%rsp)
	movq %r12, 80(%rsp)
	movq %rbx, 88(%rsp)
	movl %ecx, %eax
	movl %r8d, %ecx
	movl %r9d, %r14d
	movl 112(%rsp), %ebp
	movl 120(%rsp), %ebx
	movl 128(%rsp), %r8d
	movl 136(%rsp), %r12d
.fun9_0:
	movl %edi, %r13d
	addl %esi, %r13d
	movl %esi, %r15d
	imull %edx, %r15d
	movl $4, %r9d
	cltd
	idivl %r9d
	movl %eax, 96(%rsp)
	movl $42, %esi
	movl $8, %r9d
	movl %ecx, %eax
	cltd
	idivl %r9d
	movl %edx, %r9d
	movl $10, %edi
	movl $1, %eax
	movl $9, %ecx
	cltd
	idivl %ecx
	movl $300, %edx
	imull $300, %edx
	imull $9, %eax
	movl $3, %ecx
	addl %eax, %ecx
	addl $0, %ecx
	movl %edx, 100(%rsp)
	sall %cl, 100(%rsp)
	imull $4, %r12d
	movl %r14d, %ecx
	andl %ebp, %ecx
	movl %ebx, %edx
	xorl %r8d, %edx
	movl %ecx, %r14d
	orl %edx, %r14d
	movl $0, %ebx
	movl %r15d, %eax
	movl 96(%rsp), %edx
	movl %esi, %ecx
	movl %r9d, %r8d
	movl %edi, %r9d
	movl 100(%rsp), %r10d
	movl %r10d, 0(%rsp)
	movl %r12d, 8(%rsp)
	movl %r14d, 16(%rsp)
	movl %ebx, 24(%rsp)
	movl %r13d, %edi
	movl %eax, %esi
	callq _c0_fun8
	movq 48(%rsp), %rbp
	movq 56(%rsp), %r15
	movq 64(%rsp), %r14
	movq 72(%rsp), %r13
	movq 80(%rsp), %r12
	movq 88(%rsp), %rbx
	addq $104, %rsp
	ret
_c0_main:
	addq $-40, %rsp
.main_0:
	movl $0, %edi
	movl $1, %esi
	movl $2, %edx
	movl $3, %ecx
	movl $4, %r8d
	movl $5, %r9d
	movl $6, 0(%rsp)
	movl $7, 8(%rsp)
	movl $8, 16(%rsp)
	movl $9, 24(%rsp)
	callq _c0_fun9
	addq $40, %rsp
	ret
.ident	"15-411 L4 reference compiler"
