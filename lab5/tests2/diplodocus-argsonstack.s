.file	"../tests2/diplodocus-argsonstack.l3"
.globl _c0_main
_c0_bigargs:
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
	movl 152(%rsp), %eax
.bigargs_0:
	cmpl $0, %esi
	jnz .ternary_true5
	movl $0, %r9d
	jmp .ternary_end6
.ternary_true5:
	movl %ecx, %r9d
.ternary_end6:
	cmpl $0, %r9d
	jnz .ternary_true3
	movl $0, %r9d
	jmp .ternary_end4
.ternary_true3:
	movl 64(%rsp), %r9d
.ternary_end4:
	cmpl $0, %r9d
	jnz .ternary_true1
	movl $0, %ecx
	jmp .ternary_end2
.ternary_true1:
	movl %r12d, %ecx
.ternary_end2:
	movl $1, %r9d
	cmpl %ecx, %r9d
	jnz .bigargs_2
.bigargs_1:
	movl %edi, %r9d
	addl %edx, %r9d
	addl %r8d, %r9d
	addl 68(%rsp), %r9d
	addl %ebp, %r9d
	addl %r15d, %r9d
	addl %r14d, %r9d
	addl %r13d, %r9d
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
.bigargs_2:
	movl $0, %eax
	subl $1, %eax
	movq 16(%rsp), %rbp
	movq 24(%rsp), %r15
	movq 32(%rsp), %r14
	movq 40(%rsp), %r13
	movq 48(%rsp), %r12
	movq 56(%rsp), %rbx
	addq $72, %rsp
	ret
_c0_main:
	addq $-88, %rsp
.main_0:
	movl $1, %edi
	movl $1, %esi
	movl $1, %edx
	movl $1, %ecx
	movl $1, %r8d
	movl $1, %r9d
	movl $1, 0(%rsp)
	movl $1, 8(%rsp)
	movl $1, 16(%rsp)
	movl $1, 24(%rsp)
	movl $1, 32(%rsp)
	movl $1, 40(%rsp)
	movl $1, 48(%rsp)
	movl $9999, 56(%rsp)
	movl $0, 64(%rsp)
	subl $914, 64(%rsp)
	movl $1, 72(%rsp)
	callq _c0_bigargs
	addq $88, %rsp
	ret
.ident	"15-411 L4 reference compiler"
