.file	"../tests2/velociraptor-lots-of-arrays.l4"
.globl _c0_main
_c0_main:
	addq $-40, %rsp
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
.main_0:
	movq $1, %rdi
	movq $8, %rsi
	callq calloc
	movq %rax, %r9
	movq %r9, %r8
	movq $1, %rdi
	movq $8, %rsi
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, (%r8)
	movq %r9, %r8
	movq (%r8), %r8
	movq $1, %rdi
	movq $8, %rsi
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, (%r8)
	movq %r9, %r8
	movq (%r8), %r8
	movq (%r8), %r8
	movq $1, %rdi
	movq $8, %rsi
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, (%r8)
	movq %r9, %r8
	movq (%r8), %r8
	movq (%r8), %r8
	movq (%r8), %r8
	movq $1, %rdi
	movq $4, %rsi
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, (%r8)
	movq %r9, %r8
	movq (%r8), %r8
	movq (%r8), %r8
	movq (%r8), %r8
	movq (%r8), %r8
	movl $4, (%r8)
	movq $1, %rdi
	movq $8, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movq %rax, %r8
	movq %r8, %rcx
	movq $1, %rdi
	movq $8, %rsi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, (%rcx)
	movq %r8, %rcx
	movq (%rcx), %rcx
	movq $1, %rdi
	movq $8, %rsi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, (%rcx)
	movq %r8, %rcx
	movq (%rcx), %rcx
	movq (%rcx), %rcx
	movq $1, %rdi
	movq $4, %rsi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, (%rcx)
	movq %r8, %rcx
	movq (%rcx), %rcx
	movq (%rcx), %rcx
	movq (%rcx), %rcx
	movl $5, (%rcx)
	movq (%r9), %r9
	movq (%r9), %r9
	movq (%r9), %r9
	movq (%r9), %r9
	movl (%r9), %ecx
	movq %r8, %r9
	movq (%r9), %r9
	movq (%r9), %r9
	movq (%r9), %r9
	movl (%r9), %r9d
	movl %ecx, %eax
	addl %r9d, %eax
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.ident	"15-411 L4 reference compiler"
