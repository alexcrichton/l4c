.file	"../tests2/galimimus-left-right-eval3.l4"
.globl _c0_main
_c0_index:
	addq $-8, %rsp
.index_0:
	movq %rdi, %r8
	movl (%r8), %r8d
	movl %r8d, %ecx
	movq %rdi, %r8
	movl (%r8), %r8d
	movq %rdi, %r9
	movl %r8d, (%r9)
	addl $1, (%r9)
	movl %ecx, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-40, %rsp
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
.main_0:
	movq $1, %rdi
	movq $4, %rsi
	callq calloc
	movq %rax, %r9
	movq $3, %rdi
	movq $4, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movq %rax, %rcx
	movl $1, %r8d
	imull $4, %r8d
	movslq %r8d, %rdx
	movq %rcx, %r8
	addq %rdx, %r8
	movl $33, (%r8)
	movl $2, %r8d
	imull $4, %r8d
	movslq %r8d, %rdx
	movq %rcx, %r8
	addq %rdx, %r8
	movl $9, (%r8)
	movq %r9, %rdi
	movq %rcx, %r12
	movq %r9, %rbx
	callq _c0_index
	movq %r12, %rcx
	movq %rbx, %r9
	movl %eax, %edx
	movq %r9, %rdi
	movq %rdx, %r13
	movq %rcx, %r12
	movq %r9, %rbx
	callq _c0_index
	movq %r13, %rdx
	movq %r12, %rcx
	movq %rbx, %r9
	movl %eax, %r8d
	imull $4, %r8d
	movslq %r8d, %rsi
	movq %rcx, %r8
	addq %rsi, %r8
	movl (%r8), %r8d
	movq %r9, %rdi
	movq %rdx, %r13
	movq %rcx, %r12
	movq %r8, %rbx
	callq _c0_index
	movq %r13, %rdx
	movq %r12, %rcx
	movq %rbx, %r8
	movl %eax, %r9d
	imull $4, %r9d
	movslq %r9d, %rsi
	movq %rcx, %r9
	addq %rsi, %r9
	movl (%r9), %esi
	movl %edx, %r9d
	imull $4, %r9d
	movslq %r9d, %rdx
	movq %rcx, %r9
	addq %rdx, %r9
	movl %r8d, (%r9)
	addl %esi, (%r9)
	movl $0, %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq %rcx, %r9
	addq %r8, %r9
	movl (%r9), %r9d
	movl %r9d, %eax
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.ident	"15-411 L4 reference compiler"
