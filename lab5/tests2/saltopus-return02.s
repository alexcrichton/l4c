.file	"../tests2/saltopus-return02.l1"
.globl _c0_main
_c0_main:
	addq $-88, %rsp
	movq %rbp, 4(%rsp)
	movq %r15, 12(%rsp)
	movq %r14, 20(%rsp)
	movq %r13, 28(%rsp)
	movq %r12, 36(%rsp)
	movq %rbx, 44(%rsp)
.main_0:
	movl $42, %r9d
	movl $42, 52(%rsp)
	movl $42, 56(%rsp)
	movl $42, 60(%rsp)
	movl $42, 64(%rsp)
	movl $42, 68(%rsp)
	movl $42, 72(%rsp)
	movl $42, 76(%rsp)
	movl $42, 80(%rsp)
	movl $42, 84(%rsp)
	movl $42, %ebp
	movl $42, %r15d
	movl $42, %r14d
	movl $42, %r13d
	movl $42, %r12d
	movl $42, %ebx
	movl $42, %eax
	movl $42, %edi
	movl $42, %esi
	movl $42, %edx
	movl $7, %ecx
	movl $2, %r8d
	addl %ecx, %r8d
	subl %ecx, %r8d
	addl %r9d, %r8d
	movl %r8d, %r9d
	addl 52(%rsp), %r9d
	addl 56(%rsp), %r9d
	addl 60(%rsp), %r9d
	addl 64(%rsp), %r9d
	addl 68(%rsp), %r9d
	addl 72(%rsp), %r9d
	addl 76(%rsp), %r9d
	addl 80(%rsp), %r9d
	addl 84(%rsp), %r9d
	addl %ebp, %r9d
	addl %r15d, %r9d
	addl %r14d, %r9d
	addl %r13d, %r9d
	addl %r12d, %r9d
	addl %ebx, %r9d
	addl %eax, %r9d
	addl %edi, %r9d
	addl %esi, %r9d
	movl %r9d, %eax
	addl %edx, %eax
	movq 4(%rsp), %rbp
	movq 12(%rsp), %r15
	movq 20(%rsp), %r14
	movq 28(%rsp), %r13
	movq 36(%rsp), %r12
	movq 44(%rsp), %rbx
	addq $88, %rsp
	ret
.ident	"15-411 L4 reference compiler"
