.file	"../tests2/diplodocus-nulltest.l4"
.globl _c0_main
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movq $0, %r9
	movq $1, %rdi
	movq $8, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movq $0, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movq $0, (%r8)
	movq $0, %rcx
	movq $0, %r8
	cmpq %r8, %rcx
	jz .ternary_true3
	movl $0, %r8d
	jmp .ternary_end4
.ternary_true3:
	movq $0, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	cmpq %r9, %r8
	sete %r8b
	movzbl %r8b, %r8d
.ternary_end4:
	cmpl $0, %r8d
	jnz .ternary_true1
	movl $0, %r8d
	jmp .ternary_end2
.ternary_true1:
	movq $0, %r8
	movq %rax, %r9
	addq %r8, %r9
	movq (%r9), %r8
	movq $0, %r9
	cmpq %r8, %r9
	sete %r8b
	movzbl %r8b, %r8d
.ternary_end2:
	movl $1, %r9d
	cmpl %r8d, %r9d
	jnz .main_3
.main_1:
	movl $1, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.main_3:
.main_4:
	movl $0, %eax
	subl $1, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
