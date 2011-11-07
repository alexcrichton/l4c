.file	"../tests1/merlin-return-binary-tree-inorder.l4"
.globl _c0_main
_c0_preorder:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movq %rdi, %r9
.preorder_0:
	movl $1, %edx
	movq $0, %rcx
	movq %r9, %r8
	cmpq %rcx, %r8
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .preorder_2
.preorder_1:
	movl $0, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.preorder_2:
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movq %r8, %rdi
	movq %r9, %rbx
	callq _c0_preorder
	movq %rbx, %r9
	movq $16, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl (%r8), %r8d
	movl %r8d, %edi
	movq %r9, %rbx
	callq printint
	movq %rbx, %r9
	movl $32, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movq $8, %r8
	addq %r8, %r9
	movq (%r9), %r9
	movq %r9, %rdi
	callq _c0_preorder
	movl $1, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_insert:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movq %rdi, %r9
	movq %rsi, %rdi
.insert_0:
	movl $1, %edx
	movq $0, %rcx
	movq %r9, %r8
	cmpq %rcx, %r8
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .insert_2
.insert_1:
	movq %rdi, %rax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.insert_2:
	movq $16, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl (%r8), %r8d
	movq $16, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movl (%rcx), %edx
	movl $1, %ecx
	cmpl %edx, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .insert_3
.insert_6:
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movq %r8, %rcx
	movq %rdi, %rsi
	movq %rcx, %rdi
	movq %r9, %rbx
	callq _c0_insert
	movq %rbx, %r9
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq %rax, (%r8)
.insert_9:
.insert_10:
	movq %r9, %rax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.insert_3:
	movq $16, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl (%r8), %esi
	movq $16, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl (%r8), %edx
	movl $1, %ecx
	movl %esi, %r8d
	cmpl %edx, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .insert_5
.insert_4:
	movq $8, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movq %r8, %rcx
	movq %rdi, %rsi
	movq %rcx, %rdi
	movq %r9, %rbx
	callq _c0_insert
	movq %rbx, %r9
	movq $8, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movq %rax, (%rcx)
.insert_7:
	jmp .insert_9
.insert_5:
	jmp .insert_7
_c0_new_node:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movl %edi, %r9d
.new_node_0:
	movq $1, %rdi
	movq $20, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movq $16, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movl %r9d, (%r8)
	movq $8, %r8
	movq %rax, %r9
	addq %r8, %r9
	movq $0, (%r9)
	movq $0, %r8
	movq %rax, %r9
	addq %r8, %r9
	movq $0, (%r9)
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_main:
	addq $-40, %rsp
	movq %r14, 8(%rsp)
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
.main_0:
	movl $15, %r9d
	movslq %r9d, %rdi
	movq $4, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movq %rax, %r8
	movl $0, %ecx
	imull $4, %ecx
	movslq %ecx, %rcx
	movq %r8, %rdx
	addq %rcx, %rdx
	movl $50, (%rdx)
	movl $1, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r8, %rcx
	addq %rdx, %rcx
	movl $51, (%rcx)
	movl $2, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r8, %rcx
	addq %rdx, %rcx
	movl $49, (%rcx)
	movl $3, %ecx
	imull $4, %ecx
	movslq %ecx, %rcx
	movq %r8, %rdx
	addq %rcx, %rdx
	movl $66, (%rdx)
	movl $4, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r8, %rcx
	addq %rdx, %rcx
	movl $8, (%rcx)
	movl $5, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r8, %rcx
	addq %rdx, %rcx
	movl $30, (%rcx)
	movl $6, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r8, %rcx
	addq %rdx, %rcx
	movl $93, (%rcx)
	movl $7, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r8, %rcx
	addq %rdx, %rcx
	movl $12, (%rcx)
	movl $8, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r8, %rcx
	addq %rdx, %rcx
	movl $27, (%rcx)
	movl $9, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r8, %rcx
	addq %rdx, %rcx
	movl $90, (%rcx)
	movl $10, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r8, %rcx
	addq %rdx, %rcx
	movl $8, (%rcx)
	movl $11, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r8, %rcx
	addq %rdx, %rcx
	movl $25, (%rcx)
	movl $12, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r8, %rcx
	addq %rdx, %rcx
	movl $63, (%rcx)
	movl $13, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r8, %rcx
	addq %rdx, %rcx
	movl $111, (%rcx)
	movl $14, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r8, %rcx
	addq %rdx, %rcx
	movl $69, (%rcx)
	movq $0, %rdx
	movl $0, %ecx
.main_5:
.main_1:
	movl $1, %edi
	movl %ecx, %esi
	cmpl %r9d, %esi
	setl %sil
	movzbl %sil, %esi
	cmpl %esi, %edi
	jnz .main_3
.main_2:
	movl %ecx, %esi
	imull $4, %esi
	movslq %esi, %rdi
	movq %r8, %rsi
	addq %rdi, %rsi
	movl (%rsi), %esi
	movl %esi, %edi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_new_node
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movq %rdx, %rdi
	movq %rax, %rsi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, %rdx
	addl $1, %ecx
.main_4:
	jmp .main_1
.main_3:
	movq %rdx, %rdi
	callq _c0_preorder
	movl $10, %edi
	callq printchar
	movl $0, %eax
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.ident	"15-411 L4 reference compiler"
