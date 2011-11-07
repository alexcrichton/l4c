.file	"../tests2/dilophosaurus-args01.l3"
.globl _c0_main
_c0_sum:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
	movl %r9d, %r12d
	movl 32(%rsp), %ebx
	movl 40(%rsp), %eax
.sum_0:
	movl %edi, %r9d
	addl %esi, %r9d
	addl %edx, %r9d
	addl %ecx, %r9d
	addl %r8d, %r9d
	addl %r12d, %r9d
	addl %ebx, %r9d
	addl %eax, %r9d
	movl %r9d, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_main:
	addq $-88, %rsp
	movq %r13, 64(%rsp)
	movq %r12, 72(%rsp)
	movq %rbx, 80(%rsp)
.main_0:
	movl $1, %edi
	movl $2, %r12d
	movl $3, %ebx
	movl %edi, %eax
	movl %r12d, %esi
	movl %ebx, %edx
	movl %ebx, %ecx
	addl %edi, %ecx
	movl %ebx, %r8d
	addl %r12d, %r8d
	movl %ebx, %r9d
	addl %ebx, %r9d
	movl %ebx, %r13d
	addl %ebx, %r13d
	movl %r13d, 0(%rsp)
	addl %edi, 0(%rsp)
	movl %ebx, %edi
	addl %ebx, %edi
	movl %edi, 8(%rsp)
	addl %r12d, 8(%rsp)
	movl $0, 16(%rsp)
	movl $0, 24(%rsp)
	movl $0, 32(%rsp)
	movl $0, 40(%rsp)
	movl %eax, %edi
	callq _c0_sum
	movq 64(%rsp), %r13
	movq 72(%rsp), %r12
	movq 80(%rsp), %rbx
	addq $88, %rsp
	ret
.ident	"15-411 L4 reference compiler"
