.file	"../tests2/monoclonius-val6.l4"
.globl _c0_main
_c0_main:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
.main_0:
	movq $1, %rdi
	movq $24, %rsi
	callq calloc
	movq %rax, %r9
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl $1, (%r8)
	movq $4, %r8
	movq %r9, %rcx
	addq %r8, %rcx
	movl $1, (%rcx)
	movq $8, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl $1, (%r8)
	movq $16, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq $1, %rdi
	movq $4, %rsi
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, (%r8)
	movq $16, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movq $0, %rcx
	addq %rcx, %r8
	movl $1, (%r8)
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl (%r8), %esi
	movq $4, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl (%r8), %edx
	movq $8, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl (%r8), %ecx
	movq $16, %r8
	addq %r8, %r9
	movq (%r9), %r9
	movq $0, %r8
	addq %r8, %r9
	movl (%r9), %r9d
	movl %esi, %r8d
	addl %edx, %r8d
	addl %ecx, %r8d
	movl %r8d, %eax
	addl %r9d, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
