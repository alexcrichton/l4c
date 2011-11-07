.file	"../tests2/monoclonius-val2.l4"
.globl _c0_main
_c0_catlan:
	addq $-56, %rsp
	movq %r15, 16(%rsp)
	movq %r14, 24(%rsp)
	movq %r13, 32(%rsp)
	movq %r12, 40(%rsp)
	movq %rbx, 48(%rsp)
	movl %edi, %r9d
	movq %rsi, %r8
.catlan_0:
	movl $1, %ecx
	movl $0, %esi
	movl %r9d, %edx
	cmpl %esi, %edx
	sete %dl
	movzbl %dl, %edx
	cmpl %edx, %ecx
	jnz .catlan_3
.catlan_1:
	movl $1, %eax
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
.catlan_3:
.catlan_4:
	movl %r9d, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r8, %rcx
	addq %rdx, %rcx
	movl (%rcx), %ecx
	movl $1, %edx
	movl $0, %esi
	subl $1, %esi
	cmpl %esi, %ecx
	setne %cl
	movzbl %cl, %ecx
	cmpl %ecx, %edx
	jnz .catlan_7
.catlan_5:
	imull $4, %r9d
	movslq %r9d, %r9
	addq %r9, %r8
	movl (%r8), %r9d
	movl %r9d, %eax
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
.catlan_7:
.catlan_8:
	movl $0, %edx
	movl $0, %ecx
.catlan_13:
.catlan_9:
	movl $1, %edi
	movl %ecx, %esi
	cmpl %r9d, %esi
	setl %sil
	movzbl %sil, %esi
	cmpl %esi, %edi
	jnz .catlan_11
.catlan_10:
	movl %ecx, %edi
	movq %r8, %rsi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_catlan
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %ebx
	movl %r9d, %esi
	subl %ecx, %esi
	movl %esi, %edi
	subl $1, %edi
	movq %r8, %rsi
	movq %rdx, %r15
	movq %rcx, %r14
	movq %r8, %r13
	movq %r9, %r12
	callq _c0_catlan
	movq %r15, %rdx
	movq %r14, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movl %ebx, %esi
	imull %eax, %esi
	addl %esi, %edx
	addl $1, %ecx
.catlan_12:
	jmp .catlan_9
.catlan_11:
	imull $4, %r9d
	movslq %r9d, %rcx
	movq %r8, %r9
	addq %rcx, %r9
	movl %edx, (%r9)
	movl %edx, %eax
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movq $100, %rdi
	movq $4, %rsi
	callq calloc
	movl $0, %r9d
.main_5:
	movl %r9d, %esi
.main_1:
	movl $1, %edx
	movl $100, %r9d
	movl %esi, %r8d
	cmpl %r9d, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_3
.main_2:
	movl %esi, %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq %rax, %r9
	addq %r8, %r9
	movl $0, (%r9)
	subl $1, (%r9)
	movl %esi, %r9d
	addl $1, %r9d
.main_4:
	movl %r9d, %esi
	jmp .main_1
.main_3:
	movl $99, %edi
	movq %rax, %rsi
	callq _c0_catlan
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
