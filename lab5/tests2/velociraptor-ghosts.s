.file	"../tests2/velociraptor-ghosts.l4"
.globl _c0_main
_c0_swap:
	addq $-8, %rsp
.swap_0:
	movq %rdi, %r8
	movq (%r8), %r8
	movq %r8, %rcx
	movq %rsi, %r8
	movq (%r8), %r8
	movq %rdi, %r9
	movq %r8, (%r9)
	movq %rsi, %r9
	movq %rcx, (%r9)
	movl $1, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
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
	movq %rax, %r8
	movq %r9, %rdi
	movq %r8, %rsi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_swap
	movq %r12, %r8
	movq %rbx, %r9
	movq (%r9), %rcx
	movq $0, %r9
	cmpq %r9, %rcx
	jz .ternary_true3
	movl $0, %r9d
	jmp .ternary_end4
.ternary_true3:
	movq %r8, %r9
	movq (%r9), %r9
	movq $0, %r8
	cmpq %r8, %r9
	sete %r9b
	movzbl %r9b, %r9d
.ternary_end4:
	cmpl $0, %r9d
	jnz .ternary_true1
	movl $0, %r9d
	subl $1, %r9d
	jmp .ternary_end2
.ternary_true1:
	movl $1, %r9d
.ternary_end2:
	movl %r9d, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
