.file	"../tests2/dilophosaurus-stack3.l3"
.globl _c0_main
_c0_sum2:
	addq $-40, %rsp
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
	movl %edi, %r9d
	movl %esi, %ebx
.sum2_0:
	movl %r9d, %edi
	movl %ebx, %esi
	movq %rdx, %r13
	movq %r9, %r12
	callq _c0_mod
	movq %r13, %rdx
	movq %r12, %r9
	subl %ebx, %r9d
	movl %edx, %ecx
	imull %eax, %ecx
	movl %r9d, %eax
	addl %ecx, %eax
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
_c0_sum1:
	addq $-40, %rsp
	movq %r14, 8(%rsp)
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
	movl %edi, %r9d
	movl %esi, %ebx
	movl %edx, %r13d
	movl %ecx, %r12d
.sum1_0:
	movl %r9d, %edi
	movl %ebx, %esi
	movl %r13d, %edx
	movl %r12d, %ecx
	movq %r9, %r14
	callq _c0_sum2
	movq %r14, %r9
	addl %ebx, %r9d
	addl %r13d, %r9d
	addl %r12d, %r9d
	addl %eax, %r9d
	movl %r9d, %eax
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
_c0_mod:
	addq $-8, %rsp
	movl %esi, %eax
.mod_0:
	cltd
	idivl %edi
	movl %edx, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $2, %edi
	movl $0, %esi
	movl $2, %edx
	movl $3, %ecx
	movl $4, %r8d
	callq _c0_sum1
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
