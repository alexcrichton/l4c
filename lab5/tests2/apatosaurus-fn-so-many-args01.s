.file	"../tests2/apatosaurus-fn-so-many-args01.l3"
.globl _c0_main
_c0_f:
	addq $-56, %rsp
	movq %rbp, 8(%rsp)
	movq %r15, 16(%rsp)
	movq %r14, 24(%rsp)
	movq %r13, 32(%rsp)
	movq %r12, 40(%rsp)
	movq %rbx, 48(%rsp)
	movl %r9d, %ebp
	movl 64(%rsp), %r15d
	movl 72(%rsp), %r14d
	movl 80(%rsp), %r13d
	movl 88(%rsp), %r12d
	movl 96(%rsp), %ebx
	movl 104(%rsp), %eax
.f_0:
	movl %edi, %r9d
	addl %esi, %r9d
	addl %edx, %r9d
	addl %ecx, %r9d
	addl %r8d, %r9d
	addl %ebp, %r9d
	addl %r15d, %r9d
	addl %r14d, %r9d
	addl %r13d, %r9d
	addl %r12d, %r9d
	addl %ebx, %r9d
	addl %eax, %r9d
	movl %r9d, %eax
	movq 8(%rsp), %rbp
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
_c0_main:
	addq $-56, %rsp
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
	movl $10, 24(%rsp)
	movl $11, 32(%rsp)
	movl $12, 40(%rsp)
	callq _c0_f
	addq $56, %rsp
	ret
.ident	"15-411 L4 reference compiler"
