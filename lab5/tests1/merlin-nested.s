.file	"../tests1/merlin-nested.l3"
.globl _c0_main
_c0_g:
	addq $-40, %rsp
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
	movl %edi, %r9d
.g_0:
	movl %r9d, %r8d
	movl %r8d, %r13d
	addl $1, %r13d
	movl %r13d, %r12d
	addl $1, %r12d
	movl %r12d, %ebx
	addl $1, %ebx
	movl %ebx, %eax
	addl $1, %eax
	movl %eax, %edi
	addl $1, %edi
	movl %edi, %esi
	addl $1, %esi
	movl %esi, %ecx
	addl $1, %ecx
	movl %ecx, %edx
	addl $1, %edx
	addl %r13d, %r8d
	addl %r12d, %r8d
	addl %ebx, %r8d
	addl %eax, %r8d
	addl %edi, %r8d
	addl %esi, %r8d
	addl %ecx, %r8d
	movl %r8d, %ecx
	addl %edx, %ecx
	movl $8, %r8d
	imull %r9d, %r8d
	movl %ecx, %eax
	subl %r8d, %eax
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
_c0_f:
	addq $-40, %rsp
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
	movl %edi, %r9d
.f_0:
	movl %r9d, %r8d
	movl %r8d, %r13d
	addl $1, %r13d
	movl %r13d, %r12d
	addl $1, %r12d
	movl %r12d, %ebx
	addl $1, %ebx
	movl %ebx, %eax
	addl $1, %eax
	movl %eax, %edi
	addl $1, %edi
	movl %edi, %esi
	addl $1, %esi
	movl %esi, %ecx
	addl $1, %ecx
	movl %ecx, %edx
	addl $1, %edx
	addl %r13d, %r8d
	addl %r12d, %r8d
	addl %ebx, %r8d
	addl %eax, %r8d
	addl %edi, %r8d
	addl %esi, %r8d
	addl %ecx, %r8d
	movl %r8d, %ecx
	addl %edx, %ecx
	movl $8, %r8d
	imull %r9d, %r8d
	movl %ecx, %eax
	subl %r8d, %eax
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_g
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
