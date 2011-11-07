.file	"../tests2/diplodocus-arrayarray.l4"
.globl _c0_main
_c0_main:
	addq $-56, %rsp
	movq %r15, 16(%rsp)
	movq %r14, 24(%rsp)
	movq %r13, 32(%rsp)
	movq %r12, 40(%rsp)
	movq %rbx, 48(%rsp)
.main_0:
	movq $5, %rdi
	movq $8, %rsi
	callq calloc
	movq %rax, %r9
	movl $0, %r8d
.main_8:
.main_1:
	movl $1, %ecx
	movl $5, %edx
	movl %r8d, %esi
	cmpl %edx, %esi
	setl %sil
	movzbl %sil, %esi
	cmpl %esi, %ecx
	jnz .main_6
.main_2:
	movl %r8d, %ecx
	imull $8, %ecx
	movslq %ecx, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movq $5, %rdi
	movq $8, %rsi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, (%rcx)
	movl $0, %ecx
.main_10:
	movl %ecx, %edx
.main_3:
	movl $1, %edi
	movl $5, %esi
	movl %edx, %ecx
	cmpl %esi, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %edi
	jnz .main_5
.main_4:
	movl %r8d, %ecx
	imull $8, %ecx
	movslq %ecx, %rsi
	movq %r9, %rcx
	addq %rsi, %rcx
	movq (%rcx), %rcx
	movl %edx, %esi
	imull $8, %esi
	movslq %esi, %rsi
	movq %rcx, %rbx
	addq %rsi, %rbx
	movq $5, %rdi
	movq $4, %rsi
	movq %rdx, %r15
	movq %rcx, %r14
	movq %r8, %r13
	movq %r9, %r12
	callq calloc
	movq %r15, %rdx
	movq %r14, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movq %rax, (%rbx)
	addl $1, %edx
.main_9:
	jmp .main_3
.main_5:
	addl $1, %r8d
.main_7:
	jmp .main_1
.main_6:
	movl $0, %r8d
	imull $8, %r8d
	movslq %r8d, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %rdx
	movl $0, %r8d
	imull $8, %r8d
	movslq %r8d, %rcx
	movq %rdx, %r8
	addq %rcx, %r8
	movq (%r8), %rdx
	movl $0, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rdx, %r8
	addq %rcx, %r8
	movl $1, (%r8)
	movl $0, %r8d
	imull $8, %r8d
	movslq %r8d, %r8
	addq %r8, %r9
	movq (%r9), %r8
	movl $0, %r9d
	imull $8, %r9d
	movslq %r9d, %rcx
	movq %r8, %r9
	addq %rcx, %r9
	movq (%r9), %r8
	movl $0, %r9d
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
.ident	"15-411 L4 reference compiler"
