.file	"../tests2/triceratops-exception05.l3"
.globl _c0_main
_c0_tree:
	addq $-40, %rsp
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
	movl %edi, %r9d
	movl %esi, %r8d
.tree_0:
	movl $0, %ecx
	movl $1, %esi
	movl $0, %edx
	movl %r8d, %edi
	cmpl %edx, %edi
	setne %dil
	movzbl %dil, %edi
	cmpl %edi, %esi
	jnz .tree_2
.tree_1:
	movl %r9d, %edi
	movl %r8d, %esi
	subl $1, %esi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_tree
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl %r9d, %esi
	addl %eax, %esi
	addl %esi, %ecx
	movl %r8d, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_function
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl %r9d, %edi
	movl %eax, %esi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_tree
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl %r8d, %edi
	movq %rcx, %r12
	movq %r9, %rbx
	callq _c0_function2
	movq %r12, %rcx
	movq %rbx, %r9
	movl %r9d, %edi
	movl %eax, %esi
	movq %rcx, %r12
	movq %r9, %rbx
	callq _c0_tree
	movq %r12, %rcx
	movq %rbx, %r9
.tree_5:
	movl %ecx, %r8d
.tree_3:
	movl %r9d, %eax
	addl %r8d, %eax
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.tree_2:
.tree_4:
	movl %ecx, %r8d
	jmp .tree_3
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $10, %edi
	movl $10, %esi
	callq _c0_tree
	movl %eax, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
_c0_function:
	addq $-8, %rsp
.function_0:
	movl %edi, %eax
	cltd
	idivl %edi
	movl %edx, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
_c0_function2:
	addq $-8, %rsp
.function2_0:
	movl %edi, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
