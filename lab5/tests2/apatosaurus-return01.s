.file	"../tests2/apatosaurus-return01.l1"
.globl _c0_main
_c0_main:
	addq $-88, %rsp
	movq %rbp, 16(%rsp)
	movq %r15, 24(%rsp)
	movq %r14, 32(%rsp)
	movq %r13, 40(%rsp)
	movq %r12, 48(%rsp)
	movq %rbx, 56(%rsp)
.main_0:
	movl $1, %r9d
	movl $2, 64(%rsp)
	movl $3, 68(%rsp)
	movl $4, 72(%rsp)
	movl $5, 76(%rsp)
	movl $6, 80(%rsp)
	movl $7, 84(%rsp)
	movl $8, %ebp
	movl $9, %r15d
	movl $10, %r14d
	movl $11, %r13d
	movl $12, %r12d
	movl $13, %ebx
	movl $14, %eax
	movl $15, %edi
	movl $16, %esi
	movl $17, %edx
	movl $18, %ecx
	movl $19, %r8d
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
	addl %edx, %r9d
	addl %ecx, %r9d
	addl %r8d, %r9d
	movl %r9d, %eax
	movq 16(%rsp), %rbp
	movq 24(%rsp), %r15
	movq 32(%rsp), %r14
	movq 40(%rsp), %r13
	movq 48(%rsp), %r12
	movq 56(%rsp), %rbx
	addq $88, %rsp
	ret
.ident	"15-411 L4 reference compiler"
