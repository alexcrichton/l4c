.file	"../tests1/goshawk-transpose.l3"
.globl _c0_main
_c0_transpose:
	addq $-72, %rsp
	movq %rbp, 8(%rsp)
	movq %r15, 16(%rsp)
	movq %r14, 24(%rsp)
	movq %r13, 32(%rsp)
	movq %r12, 40(%rsp)
	movq %rbx, 48(%rsp)
	movl %r9d, %r12d
	movl 80(%rsp), %r13d
	movl 88(%rsp), %r9d
	movl 96(%rsp), %ebx
.transpose_0:
	movq %rsi, 56(%rsp)
	movq %rdx, 64(%rsp)
	movq %rcx, %rbp
	movq %r8, %r15
	movq %r9, %r14
	callq printint
	movq 56(%rsp), %rsi
	movq 64(%rsp), %rdx
	movq %rbp, %rcx
	movq %r15, %r8
	movq %r14, %r9
	movl $32, %edi
	movq %rsi, 56(%rsp)
	movq %rdx, 64(%rsp)
	movq %rcx, %rbp
	movq %r8, %r15
	movq %r9, %r14
	callq printchar
	movq 56(%rsp), %rsi
	movq 64(%rsp), %rdx
	movq %rbp, %rcx
	movq %r15, %r8
	movq %r14, %r9
	movl %ecx, %edi
	movq %rsi, 64(%rsp)
	movq %rdx, %rbp
	movq %r8, %r15
	movq %r9, %r14
	callq printint
	movq 64(%rsp), %rsi
	movq %rbp, %rdx
	movq %r15, %r8
	movq %r14, %r9
	movl $32, %edi
	movq %rsi, 64(%rsp)
	movq %rdx, %rbp
	movq %r8, %r15
	movq %r9, %r14
	callq printchar
	movq 64(%rsp), %rsi
	movq %rbp, %rdx
	movq %r15, %r8
	movq %r14, %r9
	movl %r13d, %edi
	movq %rsi, %rbp
	movq %rdx, %r15
	movq %r8, %r14
	movq %r9, %r13
	callq printint
	movq %rbp, %rsi
	movq %r15, %rdx
	movq %r14, %r8
	movq %r13, %r9
	movl $10, %edi
	movq %rsi, %rbp
	movq %rdx, %r15
	movq %r8, %r14
	movq %r9, %r13
	callq printchar
	movq %rbp, %rsi
	movq %r15, %rdx
	movq %r14, %r8
	movq %r13, %r9
	movl %esi, %edi
	movq %rdx, %r15
	movq %r8, %r14
	movq %r9, %r13
	callq printint
	movq %r15, %rdx
	movq %r14, %r8
	movq %r13, %r9
	movl $32, %edi
	movq %rdx, %r15
	movq %r8, %r14
	movq %r9, %r13
	callq printchar
	movq %r15, %rdx
	movq %r14, %r8
	movq %r13, %r9
	movl %r8d, %edi
	movq %rdx, %r14
	movq %r9, %r13
	callq printint
	movq %r14, %rdx
	movq %r13, %r9
	movl $32, %edi
	movq %rdx, %r14
	movq %r9, %r13
	callq printchar
	movq %r14, %rdx
	movq %r13, %r9
	movl %r9d, %edi
	movq %rdx, %r13
	callq printint
	movq %r13, %rdx
	movl $10, %edi
	movq %rdx, %r13
	callq printchar
	movq %r13, %rdx
	movl %edx, %edi
	callq printint
	movl $32, %edi
	callq printchar
	movl %r12d, %edi
	callq printint
	movl $32, %edi
	callq printchar
	movl %ebx, %edi
	callq printint
	movl $10, %edi
	callq printchar
	movl $0, %eax
	movq 8(%rsp), %rbp
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $72, %rsp
	ret
_c0_main:
	addq $-40, %rsp
.main_0:
	movl $3, %edi
	movl $1, %esi
	movl $4, %edx
	movl $1, %ecx
	movl $5, %r8d
	movl $9, %r9d
	movl $2, 0(%rsp)
	movl $6, 8(%rsp)
	movl $5, 16(%rsp)
	callq _c0_transpose
	addq $40, %rsp
	ret
.ident	"15-411 L4 reference compiler"
