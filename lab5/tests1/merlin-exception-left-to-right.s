.file	"../tests1/merlin-exception-left-to-right.l4"
.globl _c0_main
_c0_set:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
	movq %rdi, %r9
.set_0:
	movq $8, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq $20, %rdi
	movq $4, %rsi
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, (%r8)
	movq $8, %r8
	addq %r8, %r9
	movq (%r9), %r8
	movl $0, %r9d
	imull $4, %r9d
	movslq %r9d, %r9
	addq %r9, %r8
	movl $0, (%r8)
	movl $0, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
.main_0:
	movq $1, %rdi
	movq $16, %rsi
	callq calloc
	movq %rax, %r9
	movq $0, %r8
	movq %r9, %rcx
	addq %r8, %rcx
	movl $1, (%rcx)
	movq $8, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq $20, %rdi
	movq $4, %rsi
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, (%r8)
	movq $8, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movq %r9, %rdi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_set
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %ecx
	imull $4, %ecx
	movslq %ecx, %rcx
	addq %rcx, %r8
	movl $1, (%r8)
	movq $8, %r8
	addq %r8, %r9
	movq (%r9), %r8
	movl $0, %r9d
	imull $4, %r9d
	movslq %r9d, %r9
	addq %r9, %r8
	movl (%r8), %r9d
	movl $1, %eax
	cltd
	idivl %r9d
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
