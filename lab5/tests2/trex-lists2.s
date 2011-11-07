.file	"../tests2/trex-lists2.l4"
.globl _c0_main
_c0_square:
	addq $-8, %rsp
.square_0:
	movl %edi, %eax
	imull %edi, %eax
	addq $8, %rsp
	ret
_c0_map:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movq %rdi, %r9
.map_0:
	movl $1, %edx
	movq $0, %rcx
	movq %r9, %r8
	cmpq %rcx, %r8
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .map_3
.map_1:
	movq $0, %rax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.map_3:
.map_4:
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl (%r8), %r8d
	movl %r8d, %edi
	movq %r9, %rbx
	callq _c0_square
	movq %rbx, %r9
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl %eax, (%r8)
	movq $8, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movq %r8, %rdi
	movq %r9, %rbx
	callq _c0_map
	movq %rbx, %r9
	movq $8, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq %rax, (%r8)
	movq %r9, %rax
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
	movq $1, %rdi
	movq $16, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movq %rax, %r8
	movq $1, %rdi
	movq $16, %rsi
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r12, %r8
	movq %rbx, %r9
	movq $0, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movl $1, (%rcx)
	movq $8, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movq %r8, (%rcx)
	movq $0, %rdx
	movq %r8, %rcx
	addq %rdx, %rcx
	movl $2, (%rcx)
	movq $8, %rcx
	addq %rcx, %r8
	movq %rax, (%r8)
	movq $0, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movl $3, (%r8)
	movq $8, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movq $0, (%r8)
	movq %r9, %rdi
	callq _c0_map
	movq $0, %r8
	movq %rax, %r9
	addq %r8, %r9
	movl (%r9), %r9d
	movl %r9d, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
