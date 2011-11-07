.file	"../tests2/styracosaurus-pi.l3"
.globl _c0_main
_c0_approx:
	addq $-56, %rsp
	movq %rbp, 8(%rsp)
	movq %r15, 16(%rsp)
	movq %r14, 24(%rsp)
	movq %r13, 32(%rsp)
	movq %r12, 40(%rsp)
	movq %rbx, 48(%rsp)
	movl %edi, %r9d
.approx_0:
	movl $0, %edi
	movq %r9, %rbx
	callq tofloat
	movq %rbx, %r9
	movl %eax, %ecx
	movl $4, %edi
	movq %rcx, %r12
	movq %r9, %rbx
	callq tofloat
	movq %r12, %rcx
	movq %rbx, %r9
	movl %eax, %ebx
	movl $0, %r8d
	movl $1, %edx
.approx_8:
	movl %ecx, %r12d
.approx_1:
	movl $1, %esi
	movl %edx, %ecx
	cmpl %r9d, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .approx_6
.approx_2:
	movl $1, %ecx
	cmpl %r8d, %ecx
	jnz .approx_4
.approx_3:
	movl $0, %edi
	subl %edx, %edi
	movq %rdx, %r15
	movq %r8, %r14
	movq %r9, %r13
	callq tofloat
	movq %r15, %rdx
	movq %r14, %r8
	movq %r13, %r9
	movl %eax, %ecx
	movl %ebx, %edi
	movl %ecx, %esi
	movq %rdx, %rbp
	movq %rcx, %r15
	movq %r8, %r14
	movq %r9, %r13
	callq fdiv
	movq %rbp, %rdx
	movq %r15, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl %eax, %esi
.approx_10:
	movl %esi, %edi
.approx_5:
	movl $1, %ecx
	xorl %r8d, %ecx
	movl %r12d, %esi
	movl %edi, %r8d
	movl %esi, %edi
	movl %r8d, %esi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r9, %r12
	callq fadd
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r9
	movl %eax, %esi
	addl $2, %edx
.approx_7:
	movl %ecx, %r8d
	movl %esi, %r12d
	jmp .approx_1
.approx_4:
	movl %edx, %edi
	movq %rdx, %r15
	movq %r8, %r14
	movq %r9, %r13
	callq tofloat
	movq %r15, %rdx
	movq %r14, %r8
	movq %r13, %r9
	movl %eax, %ecx
	movl %ebx, %edi
	movl %ecx, %esi
	movq %rdx, %rbp
	movq %rcx, %r15
	movq %r8, %r14
	movq %r9, %r13
	callq fdiv
	movq %rbp, %rdx
	movq %r15, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl %eax, %esi
.approx_9:
	movl %esi, %edi
	jmp .approx_5
.approx_6:
	movl %r12d, %eax
	movq 8(%rsp), %rbp
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
.main_0:
	movl $1000000, %edi
	callq _c0_approx
	movl %eax, %r9d
	movl $10, %r8d
	movl %r9d, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq printfloat
	movq %r12, %r8
	movq %rbx, %r9
	movl %r8d, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl %r9d, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
