.file	"../tests2/monoclonius-val4.l4"
.globl _c0_main
_c0_increment:
	addq $-8, %rsp
.increment_0:
	movq %rdi, %r8
	movl (%r8), %r8d
	movq %rdi, %r9
	movl %r8d, (%r9)
	addl $1, (%r9)
	movl $0, %eax
	addq $8, %rsp
	ret
_c0_sum:
	addq $-72, %rsp
	movq %rbp, 16(%rsp)
	movq %r15, 24(%rsp)
	movq %r14, 32(%rsp)
	movq %r13, 40(%rsp)
	movq %r12, 48(%rsp)
	movq %rbx, 56(%rsp)
	movl %r9d, 64(%rsp)
	movl 80(%rsp), %r10d
	movl %r10d, 68(%rsp)
	movl 88(%rsp), %ebp
	movl 96(%rsp), %r15d
	movl 104(%rsp), %r14d
	movl 112(%rsp), %r13d
	movl 120(%rsp), %r12d
	movl 128(%rsp), %ebx
	movl 136(%rsp), %eax
.sum_0:
	movl %edi, %r9d
	addl %esi, %r9d
	addl %edx, %r9d
	addl %ecx, %r9d
	addl %r8d, %r9d
	addl 64(%rsp), %r9d
	addl 68(%rsp), %r9d
	addl %ebp, %r9d
	addl %r15d, %r9d
	addl %r14d, %r9d
	addl %r13d, %r9d
	addl %r12d, %r9d
	addl %ebx, %r9d
	addl %eax, %r9d
	movl %r9d, %eax
	movq 16(%rsp), %rbp
	movq 24(%rsp), %r15
	movq 32(%rsp), %r14
	movq 40(%rsp), %r13
	movq 48(%rsp), %r12
	movq 56(%rsp), %rbx
	addq $72, %rsp
	ret
_c0_main:
	addq $-184, %rsp
	movq %rbp, 72(%rsp)
	movq %r15, 80(%rsp)
	movq %r14, 88(%rsp)
	movq %r13, 96(%rsp)
	movq %r12, 104(%rsp)
	movq %rbx, 112(%rsp)
.main_0:
	movq $1, %rdi
	movq $4, %rsi
	callq calloc
	movq %rax, %r9
	movq %r9, %r8
	movl $0, (%r8)
	movq %r9, %rdi
	movq %r9, %rbx
	callq _c0_increment
	movq %rbx, %r9
	movl %eax, %edx
	movq %r9, %r8
	movl (%r8), %r8d
	movq %r9, %rdi
	movq %rdx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_increment
	movq %r13, %rdx
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %ecx
	movq %r9, %rsi
	movl (%rsi), %r14d
	movq %r9, %rdi
	movq %rdx, %r15
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_increment
	movq %r15, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, 168(%rsp)
	movq %r9, %rsi
	movl (%rsi), %esi
	movq %r9, %rdi
	movq %rsi, %rbp
	movq %rdx, %r15
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_increment
	movq %rbp, %rsi
	movq %r15, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %ebx
	movq %r9, %rdi
	movl (%rdi), %r12d
	movq %r9, %rdi
	movq %rsi, 120(%rsp)
	movq %rdx, 128(%rsp)
	movq %rcx, %rbp
	movq %r8, %r15
	movq %r9, %r13
	callq _c0_increment
	movq 120(%rsp), %rsi
	movq 128(%rsp), %rdx
	movq %rbp, %rcx
	movq %r15, %r8
	movq %r13, %r9
	movl %eax, %r13d
	movq %r9, %rdi
	movl (%rdi), %r15d
	movq %r9, %rdi
	movq %rsi, 136(%rsp)
	movq %rdx, 144(%rsp)
	movq %rcx, 120(%rsp)
	movq %r8, 128(%rsp)
	movq %r9, %rbp
	callq _c0_increment
	movq 136(%rsp), %rsi
	movq 144(%rsp), %rdx
	movq 120(%rsp), %rcx
	movq 128(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %ebp
	movq %r9, %rdi
	movl (%rdi), %r10d
	movl %r10d, 172(%rsp)
	movq %r9, %rdi
	movq %rsi, 152(%rsp)
	movq %rdx, 160(%rsp)
	movq %rcx, 136(%rsp)
	movq %r8, 144(%rsp)
	movq %r9, 120(%rsp)
	callq _c0_increment
	movq 152(%rsp), %rsi
	movq 160(%rsp), %rdx
	movq 136(%rsp), %rcx
	movq 144(%rsp), %r8
	movq 120(%rsp), %r9
	movl %eax, 176(%rsp)
	movl (%r9), %r10d
	movl %r10d, 180(%rsp)
	movl %edx, %edi
	movl %r8d, %eax
	movl %ecx, %edx
	movl %r14d, %ecx
	movl 168(%rsp), %r8d
	movl %esi, %r9d
	movl %ebx, 0(%rsp)
	movl %r12d, 8(%rsp)
	movl %r13d, 16(%rsp)
	movl %r15d, 24(%rsp)
	movl %ebp, 32(%rsp)
	movl 172(%rsp), %r10d
	movl %r10d, 40(%rsp)
	movl 176(%rsp), %r10d
	movl %r10d, 48(%rsp)
	movl 180(%rsp), %r10d
	movl %r10d, 56(%rsp)
	movl %eax, %esi
	callq _c0_sum
	movq 72(%rsp), %rbp
	movq 80(%rsp), %r15
	movq 88(%rsp), %r14
	movq 96(%rsp), %r13
	movq 104(%rsp), %r12
	movq 112(%rsp), %rbx
	addq $184, %rsp
	ret
.ident	"15-411 L4 reference compiler"
