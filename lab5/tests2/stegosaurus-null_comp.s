.file	"../tests2/stegosaurus-null_comp.l4"
.globl _c0_main
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movl $4, %r9d
	movq $1, %rdi
	movq $4, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movl $1, %edx
	movq $0, %r8
	movq $0, %rcx
	cmpq %rcx, %r8
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_2
.main_1:
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.main_2:
	movq $0, %r8
	movq %rax, %r9
	addq %r8, %r9
	movl (%r9), %r9d
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
