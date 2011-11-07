.file	"../tests2/diplodocus-arrayinstruct.l4"
.globl _c0_main
_c0_main:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
.main_0:
	movq $1, %rdi
	movq $8, %rsi
	callq calloc
	movq %rax, %r9
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq $5, %rdi
	movq $4, %rsi
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, (%r8)
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %rcx
	movl $4, %r8d
	imull $4, %r8d
	movslq %r8d, %r8
	addq %r8, %rcx
	movl $1337, (%rcx)
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %rdx
	movl $1, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rdx, %r8
	addq %rcx, %r8
	movl (%r8), %r8d
	movl $1, %edx
	movl $0, %ecx
	cmpl %ecx, %r8d
	setne %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_3
.main_1:
	movl $1, %eax
	movl $0, %r9d
	cltd
	idivl %r9d
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.main_3:
.main_4:
	movq $0, %r8
	addq %r8, %r9
	movq (%r9), %r8
	movl $4, %r9d
	imull $4, %r9d
	movslq %r9d, %rcx
	movq %r8, %r9
	addq %rcx, %r9
	movl (%r9), %r9d
	movl %r9d, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
