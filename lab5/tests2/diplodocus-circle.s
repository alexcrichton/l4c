.file	"../tests2/diplodocus-circle.l4"
.globl _c0_main
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movq $1, %rdi
	movq $8, %rsi
	callq calloc
	movq %rax, %r9
	movq $1, %rdi
	movq $8, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq %rax, (%r8)
	movq $0, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movq %r9, (%r8)
.main_5:
	movq %r9, %rdx
.main_1:
	movq $0, %r8
	movq %rdx, %r9
	addq %r8, %r9
	movq (%r9), %r9
	movl $1, %ecx
	movq $0, %r8
	cmpq %r8, %r9
	setne %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_3
.main_2:
	movq $0, %r8
	movq %rdx, %r9
	addq %r8, %r9
	movq (%r9), %r9
.main_4:
	movq %r9, %rdx
	jmp .main_1
.main_3:
	movl $1, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
