.file	"../tests1/eagle-return1.l1"
.globl _c0_main
_c0_main:
	addq $-40, %rsp
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
.main_0:
	movl $1, %r9d
	movl $2, %r13d
	movl $3, %r12d
	movl $4, %ebx
	movl $5, %eax
	movl $6, %edi
	movl $7, %ecx
	movl $8, %r8d
	movl %r8d, %esi
	subl %r9d, %esi
	movl %ecx, %edx
	subl %r13d, %edx
	movl %edi, %ecx
	subl %r12d, %ecx
	movl %eax, %r8d
	subl %ebx, %r8d
	movl %esi, %r9d
	addl %r8d, %r9d
	movl %edx, %r8d
	addl %ecx, %r8d
	subl %r8d, %r9d
	movl %r9d, %eax
	addl $1, %eax
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.ident	"15-411 L4 reference compiler"
