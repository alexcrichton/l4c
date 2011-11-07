.file	"../tests2/galimimus-bst.l4"
.globl _c0_main
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movq $0, %r9
	movq %r9, %rdi
	movl $2, %esi
	callq _c0_insertBST
	movq %rax, %r9
	movq %r9, %rdi
	movl $1, %esi
	callq _c0_insertBST
	movq %rax, %r9
	movq %r9, %rdi
	movl $8, %esi
	callq _c0_insertBST
	movq %rax, %r9
	movq %r9, %rdi
	movl $8, %esi
	callq _c0_insertBST
	movq %rax, %r9
	movq %r9, %rdi
	movl $5, %esi
	callq _c0_insertBST
	movq %rax, %r9
	movq %r9, %rdi
	movl $9, %esi
	callq _c0_insertBST
	movq %rax, %r9
	movq %r9, %rdi
	movl $3, %esi
	callq _c0_insertBST
	movq %rax, %r9
	movq %r9, %rdi
	movq %r9, %rbx
	callq _c0_printInOrderBST
	movq %rbx, %r9
	movl $10, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movq %r9, %rdi
	movl $0, %esi
	movq %r9, %rbx
	callq _c0_searchBST
	movq %rbx, %r9
	movq $0, %rcx
	movq %rax, %r8
	cmpq %rcx, %r8
	sete %dil
	movzbl %dil, %edi
	movq %r9, %rbx
	callq _c0_myassert
	movq %rbx, %r9
	movq %r9, %rdi
	movl $4, %esi
	movq %r9, %rbx
	callq _c0_searchBST
	movq %rbx, %r9
	movq $0, %rcx
	movq %rax, %r8
	cmpq %rcx, %r8
	sete %dil
	movzbl %dil, %edi
	movq %r9, %rbx
	callq _c0_myassert
	movq %rbx, %r9
	movq %r9, %rdi
	movl $2, %esi
	movq %r9, %rbx
	callq _c0_searchBST
	movq %rbx, %r9
	movq $0, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movl (%r8), %r8d
	movl $2, %ecx
	movl %r8d, %edi
	cmpl %ecx, %edi
	sete %dil
	movzbl %dil, %edi
	movq %r9, %rbx
	callq _c0_myassert
	movq %rbx, %r9
	movq %r9, %rdi
	movl $1, %esi
	movq %r9, %rbx
	callq _c0_searchBST
	movq %rbx, %r9
	movq $0, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movl (%r8), %r8d
	movl $1, %ecx
	movl %r8d, %edi
	cmpl %ecx, %edi
	sete %dil
	movzbl %dil, %edi
	movq %r9, %rbx
	callq _c0_myassert
	movq %rbx, %r9
	movq %r9, %rdi
	movl $8, %esi
	movq %r9, %rbx
	callq _c0_searchBST
	movq %rbx, %r9
	movq $0, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movl (%r8), %r8d
	movl $8, %ecx
	movl %r8d, %edi
	cmpl %ecx, %edi
	sete %dil
	movzbl %dil, %edi
	movq %r9, %rbx
	callq _c0_myassert
	movq %rbx, %r9
	movq %r9, %rdi
	movl $5, %esi
	movq %r9, %rbx
	callq _c0_searchBST
	movq %rbx, %r9
	movq $0, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movl (%r8), %r8d
	movl $5, %ecx
	movl %r8d, %edi
	cmpl %ecx, %edi
	sete %dil
	movzbl %dil, %edi
	movq %r9, %rbx
	callq _c0_myassert
	movq %rbx, %r9
	movq %r9, %rdi
	movl $9, %esi
	movq %r9, %rbx
	callq _c0_searchBST
	movq %rbx, %r9
	movq $0, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movl (%r8), %ecx
	movl $9, %r8d
	movl %ecx, %edi
	cmpl %r8d, %edi
	sete %dil
	movzbl %dil, %edi
	movq %r9, %rbx
	callq _c0_myassert
	movq %rbx, %r9
	movq %r9, %rdi
	movl $3, %esi
	movq %r9, %rbx
	callq _c0_searchBST
	movq %rbx, %r9
	movq $0, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movl (%r8), %r8d
	movl $3, %ecx
	movl %r8d, %edi
	cmpl %ecx, %edi
	sete %dil
	movzbl %dil, %edi
	movq %r9, %rbx
	callq _c0_myassert
	movq %rbx, %r9
	movq %r9, %rdi
	movl $2, %esi
	callq _c0_deleteBST
	movq %rax, %r9
	movq %r9, %rdi
	movl $2, %esi
	movq %r9, %rbx
	callq _c0_searchBST
	movq %rbx, %r9
	movq $0, %rcx
	movq %rax, %r8
	cmpq %rcx, %r8
	sete %dil
	movzbl %dil, %edi
	movq %r9, %rbx
	callq _c0_myassert
	movq %rbx, %r9
	movq %r9, %rdi
	movl $1, %esi
	callq _c0_deleteBST
	movq %rax, %r9
	movq %r9, %rdi
	movl $1, %esi
	movq %r9, %rbx
	callq _c0_searchBST
	movq %rbx, %r9
	movq $0, %rcx
	movq %rax, %r8
	cmpq %rcx, %r8
	sete %dil
	movzbl %dil, %edi
	movq %r9, %rbx
	callq _c0_myassert
	movq %rbx, %r9
	movq %r9, %rdi
	movl $3, %esi
	callq _c0_insertBST
	movq %rax, %r9
	movq %r9, %rdi
	movl $3, %esi
	movq %r9, %rbx
	callq _c0_searchBST
	movq %rbx, %r9
	movq $0, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movl (%r8), %r8d
	movl $3, %ecx
	movl %r8d, %edi
	cmpl %ecx, %edi
	sete %dil
	movzbl %dil, %edi
	movq %r9, %rbx
	callq _c0_myassert
	movq %rbx, %r9
	movq %r9, %rdi
	movl $5, %esi
	callq _c0_deleteBST
	movq %rax, %r9
	movq %r9, %rdi
	movl $5, %esi
	movq %r9, %rbx
	callq _c0_searchBST
	movq %rbx, %r9
	movq $0, %rcx
	movq %rax, %r8
	cmpq %rcx, %r8
	sete %dil
	movzbl %dil, %edi
	movq %r9, %rbx
	callq _c0_myassert
	movq %rbx, %r9
	movq %r9, %rdi
	movl $8, %esi
	callq _c0_deleteBST
	movq %rax, %r9
	movq %r9, %rdi
	movl $8, %esi
	movq %r9, %rbx
	callq _c0_searchBST
	movq %rbx, %r9
	movq $0, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movl (%r8), %r8d
	movl $8, %ecx
	movl %r8d, %edi
	cmpl %ecx, %edi
	sete %dil
	movzbl %dil, %edi
	movq %r9, %rbx
	callq _c0_myassert
	movq %rbx, %r9
	movq %r9, %rdi
	movl $3, %esi
	callq _c0_deleteBST
	movq %rax, %r9
	movq %r9, %rdi
	movl $3, %esi
	movq %r9, %rbx
	callq _c0_searchBST
	movq %rbx, %r9
	movq $0, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movl (%r8), %r8d
	movl $3, %ecx
	movl %r8d, %edi
	cmpl %ecx, %edi
	sete %dil
	movzbl %dil, %edi
	movq %r9, %rbx
	callq _c0_myassert
	movq %rbx, %r9
	movq %r9, %rdi
	movl $8, %esi
	callq _c0_deleteBST
	movq %rax, %r9
	movq %r9, %rdi
	movl $9, %esi
	callq _c0_deleteBST
	movq %rax, %r9
	movq %r9, %rdi
	movl $3, %esi
	callq _c0_deleteBST
	movq %rax, %r9
	movq $0, %r8
	cmpq %r9, %r8
	sete %dil
	movzbl %dil, %edi
	movq %r9, %rbx
	callq _c0_myassert
	movq %rbx, %r9
	movq %r9, %rdi
	callq _c0_printInOrderBST
	movl $10, %edi
	callq printchar
	movl $0, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_insertBST:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movq %rdi, %r9
	movl %esi, %r8d
.insertBST_0:
	movl $1, %edx
	movq $0, %rcx
	movq %r9, %rsi
	cmpq %rcx, %rsi
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %edx
	jnz .insertBST_3
.insertBST_1:
	movq $1, %rdi
	movq $24, %rsi
	movq %r8, %rbx
	callq calloc
	movq %rbx, %r8
	movq $0, %rcx
	movq %rax, %r9
	addq %rcx, %r9
	movl %r8d, (%r9)
	movq $8, %r8
	movq %rax, %r9
	addq %r8, %r9
	movq $0, (%r9)
	movq $16, %r8
	movq %rax, %r9
	addq %r8, %r9
	movq $0, (%r9)
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.insertBST_3:
.insertBST_4:
	movq $0, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movl (%rcx), %ecx
	movl $1, %edx
	cmpl %r8d, %ecx
	setle %cl
	movzbl %cl, %ecx
	cmpl %ecx, %edx
	jnz .insertBST_6
.insertBST_5:
	movq $16, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movq (%rcx), %rcx
	movq %rcx, %rdi
	movl %r8d, %esi
	movq %r9, %rbx
	callq _c0_insertBST
	movq %rbx, %r9
	movq $16, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq %rax, (%r8)
.insertBST_7:
	movq %r9, %rax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.insertBST_6:
	movq $8, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movq (%rcx), %rcx
	movq %rcx, %rdi
	movl %r8d, %esi
	movq %r9, %rbx
	callq _c0_insertBST
	movq %rbx, %r9
	movq $8, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq %rax, (%r8)
	jmp .insertBST_7
_c0_printInOrderBST:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movq %rdi, %r9
.printInOrderBST_0:
	movl $1, %edx
	movq $0, %rcx
	movq %r9, %r8
	cmpq %rcx, %r8
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .printInOrderBST_3
.printInOrderBST_1:
	movl $0, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.printInOrderBST_3:
.printInOrderBST_4:
	movq $8, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movq %r8, %rdi
	movq %r9, %rbx
	callq _c0_printInOrderBST
	movq %rbx, %r9
	movq $0, %rcx
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
	movq $16, %r8
	addq %r8, %r9
	movq (%r9), %r9
	movq %r9, %rdi
	callq _c0_printInOrderBST
	movl $0, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_searchBST:
	addq $-8, %rsp
	movl %esi, %edx
.searchBST_0:
	movl $1, %ecx
	movq $0, %rsi
	movq %rdi, %r8
	cmpq %rsi, %r8
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .searchBST_3
.searchBST_1:
	movq $0, %rax
	addq $8, %rsp
	ret
.searchBST_3:
.searchBST_4:
	movq $0, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl (%r8), %ecx
	movl $1, %r8d
	cmpl %edx, %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %r8d
	jnz .searchBST_6
.searchBST_5:
	movq %rdi, %rax
	addq $8, %rsp
	ret
.searchBST_6:
	movq $0, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl (%r8), %r8d
	movl $1, %ecx
	cmpl %edx, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .searchBST_8
.searchBST_7:
	movq $16, %r8
	movq %rdi, %r9
	addq %r8, %r9
	movq (%r9), %r9
	movq %r9, %rdi
	movl %edx, %esi
	callq _c0_searchBST
	addq $8, %rsp
	ret
.searchBST_8:
	movq $8, %r8
	movq %rdi, %r9
	addq %r8, %r9
	movq (%r9), %r9
	movq %r9, %rdi
	movl %edx, %esi
	callq _c0_searchBST
	addq $8, %rsp
	ret
_c0_deleteBST:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
	movq %rdi, %r9
.deleteBST_0:
	movl $1, %edx
	movq $0, %rcx
	movq %r9, %r8
	cmpq %rcx, %r8
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .deleteBST_3
.deleteBST_1:
	movq $0, %rax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.deleteBST_3:
.deleteBST_4:
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl (%r8), %edx
	movl $1, %r8d
	movl %esi, %ecx
	cmpl %edx, %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %r8d
	jnz .deleteBST_18
.deleteBST_5:
	movq $8, %r8
	movq %r9, %rcx
	addq %r8, %rcx
	movq (%rcx), %r8
	movq $0, %rcx
	cmpq %rcx, %r8
	jz .ternary_true1
	movl $0, %ecx
	jmp .ternary_end2
.ternary_true1:
	movq $16, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movq $0, %rcx
	cmpq %rcx, %r8
	sete %cl
	movzbl %cl, %ecx
.ternary_end2:
	movl $1, %r8d
	cmpl %ecx, %r8d
	jnz .deleteBST_7
.deleteBST_6:
	movq $0, %rax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.deleteBST_7:
	movq $8, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movl $1, %edx
	movq $0, %rcx
	cmpq %rcx, %r8
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .deleteBST_9
.deleteBST_8:
	movq $16, %r8
	addq %r8, %r9
	movq (%r9), %r9
	movq %r9, %rax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.deleteBST_9:
	movq $16, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %rcx
	movl $1, %r8d
	movq $0, %rdx
	cmpq %rdx, %rcx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %r8d
	jnz .deleteBST_11
.deleteBST_10:
	movq $8, %r8
	addq %r8, %r9
	movq (%r9), %r9
	movq %r9, %rax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.deleteBST_11:
	movq $16, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movq %r8, %rdi
	movq %r9, %rbx
	callq _c0_getMinBST
	movq %rbx, %r9
	movq %rax, %r8
	movq $16, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movq (%rcx), %rsi
	movq $0, %rdx
	movq %r8, %rcx
	addq %rdx, %rcx
	movl (%rcx), %ecx
	movq %rsi, %rdi
	movl %ecx, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_deleteBST
	movq %r12, %r8
	movq %rbx, %r9
	movq $16, %rdx
	movq %r8, %rcx
	addq %rdx, %rcx
	movq %rax, (%rcx)
	movq $8, %rcx
	addq %rcx, %r9
	movq (%r9), %rdx
	movq $8, %rcx
	movq %r8, %r9
	addq %rcx, %r9
	movq %rdx, (%r9)
	movq %r8, %rax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.deleteBST_18:
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl (%r8), %r8d
	movl $1, %ecx
	cmpl %esi, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .deleteBST_20
.deleteBST_19:
	movq $16, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movq %r8, %rdi
	movq %r9, %rbx
	callq _c0_deleteBST
	movq %rbx, %r9
	movq $16, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq %rax, (%r8)
	movq %r9, %rax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.deleteBST_20:
	movq $8, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movq %r8, %rdi
	movq %r9, %rbx
	callq _c0_deleteBST
	movq %rbx, %r9
	movq $8, %rdx
	movq %r9, %r8
	addq %rdx, %r8
	movq %rax, (%r8)
	movq %r9, %rax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_getMinBST:
	addq $-8, %rsp
.getMinBST_0:
	movl $1, %edx
	movq $0, %rcx
	movq %rdi, %r8
	cmpq %rcx, %r8
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .getMinBST_3
.getMinBST_1:
	movq $0, %rax
	addq $8, %rsp
	ret
.getMinBST_3:
.getMinBST_4:
	movq $8, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movl $1, %edx
	movq $0, %rcx
	cmpq %rcx, %r8
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .getMinBST_6
.getMinBST_5:
	movq %rdi, %rax
	addq $8, %rsp
	ret
.getMinBST_6:
	movq $8, %r8
	movq %rdi, %r9
	addq %r8, %r9
	movq (%r9), %r9
	movq %r9, %rdi
	callq _c0_getMinBST
	addq $8, %rsp
	ret
_c0_myassert:
	addq $-8, %rsp
.myassert_0:
	movl $1, %r9d
	movl $1, %r8d
	xorl %edi, %r8d
	cmpl %r8d, %r9d
	jnz .myassert_3
.myassert_1:
	movl $1, %eax
	movl $0, %r9d
	cltd
	idivl %r9d
	addq $8, %rsp
	ret
.myassert_3:
.myassert_4:
	movl $0, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
