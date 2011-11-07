.file	"../tests2/brachiosaurus-struct-little-test.l4"
.globl _c0_main
_c0_init:
	addq $-8, %rsp
.init_0:
	movq $8, %r8
	movq %rdi, %r9
	addq %r8, %r9
	movq $8, %r8
	addq %r8, %r9
	movq (%r9), %r9
	movq $0, %r8
	addq %r8, %r9
	movl $112358, (%r9)
	movl $0, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
.main_0:
	movq $1, %rdi
	movq $36, %rsi
	callq calloc
	movq %rax, %r9
	movq $8, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq $8, %rcx
	addq %rcx, %r8
	movq $1, %rdi
	movq $4, %rsi
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, (%r8)
	movq %r9, %rdi
	movq %r9, %rbx
	callq _c0_init
	movq %rbx, %r9
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl $13, (%r8)
	movq $8, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq $0, %rcx
	addq %rcx, %r8
	movq $0, (%r8)
	movq $8, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq $16, %rcx
	addq %rcx, %r8
	movq $1, %rdi
	movq $4, %rsi
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, (%r8)
	movq $32, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl $21, (%r8)
	movq $8, %r8
	addq %r8, %r9
	movq $8, %r8
	addq %r8, %r9
	movq (%r9), %r9
	movq $0, %r8
	addq %r8, %r9
	movl (%r9), %r9d
	movl %r9d, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
