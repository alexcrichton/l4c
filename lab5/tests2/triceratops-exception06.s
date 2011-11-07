.file	"../tests2/triceratops-exception06.l3"
.globl _c0_main
_c0_function:
	addq $-8, %rsp
.function_0:
	movl $1, %eax
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
	movl $1, %ecx
	movl $0, %esi
	movl %edi, %edx
	cmpl %esi, %edx
	setne %dl
	movzbl %dl, %edx
	cmpl %edx, %ecx
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
	movl $0, %r9d
	cltd
	idivl %r9d
	movl %eax, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
