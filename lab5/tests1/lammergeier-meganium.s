.file	"../tests1/lammergeier-meganium.l3"
.globl _c0_main
_c0_spin:
	addq $-104, %rsp
	movq %rbp, 52(%rsp)
	movq %r15, 60(%rsp)
	movq %r14, 68(%rsp)
	movq %r13, 76(%rsp)
	movq %r12, 84(%rsp)
	movq %rbx, 92(%rsp)
	movl %r9d, %r15d
	movl 112(%rsp), %r14d
	movl 120(%rsp), %r13d
	movl 128(%rsp), %ebp
	movl 136(%rsp), %r10d
	movl %r10d, 100(%rsp)
	movl 144(%rsp), %r12d
.spin_0:
	movl %edi, %ebx
	xorl %ecx, %ebx
	movl $1, %eax
	movl $0, %edi
	movl %ebx, %r9d
	cmpl %edi, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %eax
	jnz .spin_3
.spin_1:
	movl %r12d, %eax
	movq 52(%rsp), %rbp
	movq 60(%rsp), %r15
	movq 68(%rsp), %r14
	movq 76(%rsp), %r13
	movq 84(%rsp), %r12
	movq 92(%rsp), %rbx
	addq $104, %rsp
	ret
.spin_3:
.spin_4:
	movl %esi, %edi
	movl %edx, %esi
	movl %ecx, %edx
	movl %r8d, %ecx
	movl %r15d, %r8d
	movl %r14d, %r9d
	movl %r13d, 0(%rsp)
	movl %ebp, 8(%rsp)
	movl 100(%rsp), %r10d
	movl %r10d, 16(%rsp)
	movl %ebx, 24(%rsp)
	movl %r12d, 32(%rsp)
	addl $1, 32(%rsp)
	callq _c0_spin
	movq 52(%rsp), %rbp
	movq 60(%rsp), %r15
	movq 68(%rsp), %r14
	movq 76(%rsp), %r13
	movq 84(%rsp), %r12
	movq 92(%rsp), %rbx
	addq $104, %rsp
	ret
_c0_main:
	addq $-56, %rsp
.main_0:
	movl $825, %edi
	movl $565, %esi
	movl $424, %edx
	movl $57, %ecx
	movl $440, %r8d
	movl $247, %r9d
	movl $181, 0(%rsp)
	movl $879, 8(%rsp)
	movl $379, 16(%rsp)
	movl $511, 24(%rsp)
	movl $0, 32(%rsp)
	callq _c0_spin
	addq $56, %rsp
	ret
.ident	"15-411 L4 reference compiler"
