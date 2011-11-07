.file	"../tests2/dilophosaurus-wrongSwap.l4"
.globl _c0_main
_c0_swap:
	addq $-8, %rsp
.swap_0:
	movl %edi, %r9d
	movl $0, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movq $1, %rdi
	movq $4, %rsi
	callq calloc
	movq %rax, %r9
	movq $1, %rdi
	movq $4, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movq %r9, %r8
	movl $3, (%r8)
	movq %rax, %r8
	movl $7, (%r8)
	movq %r9, %r8
	movl (%r8), %ecx
	movq %rax, %r8
	movl (%r8), %r8d
	movl %ecx, %edi
	movl %r8d, %esi
	movq %r9, %rbx
	callq _c0_swap
	movq %rbx, %r9
	movl (%r9), %r9d
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
