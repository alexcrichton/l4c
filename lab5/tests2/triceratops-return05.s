.file	"../tests2/triceratops-return05.l3"
.globl _c0_main
_c0_function:
	addq $-8, %rsp
.function_0:
	movl %edi, %eax
	addl %esi, %eax
	addq $8, %rsp
	ret
_c0_tree_mul:
	addq $-40, %rsp
	movq %r14, 8(%rsp)
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
	movl %edi, %r9d
	movl %esi, %r8d
.tree_mul_0:
	movl $0, %edx
	movl $0, %ecx
.tree_mul_5:
.tree_mul_1:
	movl $1, %esi
	movl %ecx, %edi
	cmpl %r8d, %edi
	setl %dil
	movzbl %dil, %edi
	cmpl %edi, %esi
	jnz .tree_mul_3
.tree_mul_2:
	movl %r9d, %edi
	movl %ecx, %esi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_tree_mul
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl %r9d, %edi
	movl %ecx, %esi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_function
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %edi
	movl %ecx, %esi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_tree_mul
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	addl %eax, %edx
	addl $1, %ecx
.tree_mul_4:
	jmp .tree_mul_1
.tree_mul_3:
	movl %r9d, %eax
	addl %edx, %eax
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $10, %edi
	movl $10, %esi
	callq _c0_tree_mul
	movl %eax, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
