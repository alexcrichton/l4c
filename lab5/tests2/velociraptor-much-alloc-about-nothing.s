.file	"../tests2/velociraptor-much-alloc-about-nothing.l4"
.globl _c0_main
_c0_sum:
	addq $-8, %rsp
	movq %rdi, %r9
	movl %esi, %edi
.sum_0:
	movl $0, %ecx
	movl $0, %r8d
.sum_5:
	movl %r8d, %esi
	movl %ecx, %edx
.sum_1:
	movl $1, %ecx
	movl %edx, %r8d
	cmpl %edi, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .sum_3
.sum_2:
	movl %edx, %r8d
	imull $8, %r8d
	movslq %r8d, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movq $0, %rcx
	addq %rcx, %r8
	movl (%r8), %r8d
	movl %esi, %ecx
	addl %r8d, %ecx
	movl %edx, %r8d
	addl $1, %r8d
.sum_4:
	movl %ecx, %esi
	movl %r8d, %edx
	jmp .sum_1
.sum_3:
	movl %esi, %eax
	addq $8, %rsp
	ret
_c0_init:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movl %edi, %r9d
.init_0:
	movq $1, %rdi
	movq $4, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movq $0, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movl %r9d, (%r8)
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_main:
	addq $-40, %rsp
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
.main_0:
	movl $65535, %r9d
	movslq %r9d, %rdi
	movq $8, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movq %rax, %r8
	movl $0, %ecx
.main_5:
.main_1:
	movl $1, %edx
	movl %ecx, %esi
	cmpl %r9d, %esi
	setl %sil
	movzbl %sil, %esi
	cmpl %esi, %edx
	jnz .main_3
.main_2:
	movl %ecx, %edi
	addl $1, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_init
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl %ecx, %edx
	imull $8, %edx
	movslq %edx, %rsi
	movq %r8, %rdx
	addq %rsi, %rdx
	movq %rax, (%rdx)
	addl $1, %ecx
.main_4:
	jmp .main_1
.main_3:
	movq %r8, %rdi
	movl %r9d, %esi
	callq _c0_sum
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.ident	"15-411 L4 reference compiler"
