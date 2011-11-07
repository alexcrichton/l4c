.file	"../tests2/triceratops-exception04.l3"
.globl _c0_main
_c0_function:
	addq $-8, %rsp
.function_0:
	movl $0, %r9d
	movl %edi, %r8d
.function_5:
	movl %r9d, %eax
	movl %r8d, %r9d
.function_1:
	movl $1, %ecx
	movl $0, %r8d
	cmpl %r9d, %r8d
	setle %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .function_3
.function_2:
	cltd
	idivl %r9d
	movl %eax, %r8d
	subl $1, %r9d
.function_4:
	movl %r8d, %eax
	jmp .function_1
.function_3:
	addq $8, %rsp
	ret
_c0_tree:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
	movl %edi, %r9d
	movl %esi, %edi
.tree_0:
	movl $0, %r8d
	movl $1, %edx
	movl $0, %ecx
	movl %edi, %esi
	cmpl %ecx, %esi
	setne %sil
	movzbl %sil, %esi
	cmpl %esi, %edx
	jnz .tree_2
.tree_1:
	movl %r9d, %edx
	movl %edi, %esi
	subl $1, %esi
	movl %edx, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_tree
	movq %r12, %r8
	movq %rbx, %r9
	movl %r9d, %ecx
	addl %eax, %ecx
	addl %ecx, %r8d
	movl %r9d, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_function
	movq %r12, %r8
	movq %rbx, %r9
.tree_5:
.tree_3:
	movl %r9d, %eax
	addl %r8d, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.tree_2:
.tree_4:
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
.ident	"15-411 L4 reference compiler"
