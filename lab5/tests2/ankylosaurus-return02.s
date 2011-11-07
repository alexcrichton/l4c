.file	"../tests2/ankylosaurus-return02.l1"
.globl _c0_main
_c0_main:
	addq $-72, %rsp
	movq %rbp, 8(%rsp)
	movq %r15, 16(%rsp)
	movq %r14, 24(%rsp)
	movq %r13, 32(%rsp)
	movq %r12, 40(%rsp)
	movq %rbx, 48(%rsp)
.main_0:
	movl $1, %r9d
	movl $1, 56(%rsp)
	movl $1, 60(%rsp)
	movl $1, 64(%rsp)
	movl $1, 68(%rsp)
	movl $1, %ebp
	movl $1, %r15d
	movl $1, %r14d
	movl $1, %r13d
	movl $1, %r12d
	movl $1, %ebx
	movl $1, %eax
	movl $1, %edi
	movl $1, %esi
	movl $1, %edx
	movl $1, %ecx
	movl $1, %r8d
	addl %r9d, %r8d
	movl %r8d, %r9d
	addl 56(%rsp), %r9d
	addl 60(%rsp), %r9d
	addl 64(%rsp), %r9d
	addl 68(%rsp), %r9d
	addl %ebp, %r9d
	addl %r15d, %r9d
	addl %r14d, %r9d
	addl %r13d, %r9d
	addl %r12d, %r9d
	addl %ebx, %r9d
	addl %eax, %r9d
	addl %edi, %r9d
	addl %esi, %r9d
	addl %edx, %r9d
	addl %ecx, %r9d
	movl %r9d, %eax
	movq 8(%rsp), %rbp
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $72, %rsp
	ret
.ident	"15-411 L4 reference compiler"
