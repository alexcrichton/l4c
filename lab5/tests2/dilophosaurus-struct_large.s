.file	"../tests2/dilophosaurus-struct_large.l4"
.globl _c0_main
_c0_product:
	addq $-8, %rsp
	movq %rdi, %r9
	movq %rsi, %rax
.product_0:
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl (%r8), %edi
	movq $0, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movl (%r8), %esi
	movq $4, %r8
	addq %r8, %r9
	movl (%r9), %edx
	movq $4, %r8
	movq %rax, %r9
	addq %r8, %r9
	movl (%r9), %ecx
	movl %edi, %r9d
	imull %esi, %r9d
	movl %edx, %r8d
	imull %ecx, %r8d
	movl %r9d, %eax
	addl %r8d, %eax
	addq $8, %rsp
	ret
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
	movq $0, %r8
	movq %r9, %rcx
	addq %r8, %rcx
	movl $5, (%rcx)
	movq $0, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movl $4, (%r8)
	movq $4, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl $4, (%r8)
	movq $4, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movl $3, (%r8)
	movq %r9, %rdi
	movq %rax, %rsi
	callq _c0_product
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
