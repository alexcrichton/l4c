.file	"../tests2/monoclonius-val01.l3"
.globl _c0_main
_c0_catlan:
	addq $-40, %rsp
	movq %r14, 8(%rsp)
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
	movl %edi, %r9d
.catlan_0:
	movl $1, %r8d
	movl $0, %edx
	movl %r9d, %ecx
	cmpl %edx, %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %r8d
	jnz .catlan_3
.catlan_1:
	movl $1, %eax
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.catlan_3:
.catlan_4:
	movl $0, %ecx
	movl $0, %r8d
.catlan_9:
.catlan_5:
	movl $1, %esi
	movl %r8d, %edx
	cmpl %r9d, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %esi
	jnz .catlan_7
.catlan_6:
	movl %r8d, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_catlan
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %edx
	movl %r9d, %esi
	subl %r8d, %esi
	movl %esi, %edi
	subl $1, %edi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_catlan
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	imull %eax, %edx
	addl %edx, %ecx
	addl $1, %r8d
.catlan_8:
	jmp .catlan_5
.catlan_7:
	movl %ecx, %eax
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $8, %edi
	callq _c0_catlan
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
