.file	"../tests2/velociraptor-persis-tree.l4"
.globl _c0_main
_c0_init:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movl %edi, %r9d
.init_0:
	movq $1, %rdi
	movq $24, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movq $0, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movl %r9d, (%r8)
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_insert:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
	movq %rdi, %r9
	movl %esi, %ecx
.insert_0:
	movl $1, %edx
	movq $0, %rsi
	movq %r9, %r8
	cmpq %rsi, %r8
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .insert_3
.insert_1:
	movl %ecx, %edi
	callq _c0_init
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.insert_3:
.insert_4:
	movq $0, %rdx
	movq %r9, %r8
	addq %rdx, %r8
	movl (%r8), %r8d
	movl $1, %esi
	movl %ecx, %edx
	cmpl %r8d, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %esi
	jnz .insert_7
.insert_5:
	movq $0, %rdx
	movq %r9, %r8
	addq %rdx, %r8
	movl (%r8), %r8d
	movl %r8d, %edi
	movq %rcx, %r12
	movq %r9, %rbx
	callq _c0_init
	movq %r12, %rcx
	movq %rbx, %r9
	movq %rax, %r8
	movq $8, %rsi
	movq %r9, %rdx
	addq %rsi, %rdx
	movq (%rdx), %rdx
	movq %rdx, %rdi
	movl %ecx, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r12, %r8
	movq %rbx, %r9
	movq $8, %rdx
	movq %r8, %rcx
	addq %rdx, %rcx
	movq %rax, (%rcx)
	movq $16, %rcx
	addq %rcx, %r9
	movq (%r9), %rdx
	movq $16, %rcx
	movq %r8, %r9
	addq %rcx, %r9
	movq %rdx, (%r9)
	movq %r8, %rax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.insert_7:
.insert_8:
	movq $0, %rdx
	movq %r9, %r8
	addq %rdx, %r8
	movl (%r8), %r8d
	movl $1, %edx
	cmpl %ecx, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .insert_11
.insert_9:
	movq $0, %rdx
	movq %r9, %r8
	addq %rdx, %r8
	movl (%r8), %r8d
	movl %r8d, %edi
	movq %rcx, %r12
	movq %r9, %rbx
	callq _c0_init
	movq %r12, %rcx
	movq %rbx, %r9
	movq %rax, %r8
	movq $16, %rsi
	movq %r9, %rdx
	addq %rsi, %rdx
	movq (%rdx), %rdx
	movq %rdx, %rdi
	movl %ecx, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r12, %r8
	movq %rbx, %r9
	movq $16, %rdx
	movq %r8, %rcx
	addq %rdx, %rcx
	movq %rax, (%rcx)
	movq $8, %rcx
	addq %rcx, %r9
	movq (%r9), %rcx
	movq $8, %r9
	movq %r8, %rdx
	addq %r9, %rdx
	movq %rcx, (%rdx)
	movq %r8, %rax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.insert_11:
.insert_12:
	movq %r9, %rax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_inorder:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
	movq %rdi, %r9
	movq %rsi, %r8
	movl %edx, %ecx
.inorder_0:
	movl $1, %edi
	movq $0, %rsi
	movq %r8, %rdx
	cmpq %rsi, %rdx
	sete %dl
	movzbl %dl, %edx
	cmpl %edx, %edi
	jnz .inorder_3
.inorder_1:
	movl %ecx, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.inorder_3:
.inorder_4:
	movq $8, %rsi
	movq %r8, %rdx
	addq %rsi, %rdx
	movq (%rdx), %rdx
	movq %r9, %rdi
	movq %rdx, %rsi
	movl %ecx, %edx
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_inorder
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %edi
	movq $0, %rdx
	movq %r8, %rcx
	addq %rdx, %rcx
	movl (%rcx), %esi
	movl %edi, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movl %esi, (%rcx)
	movq $16, %rcx
	addq %rcx, %r8
	movq (%r8), %r8
	movq %r9, %rcx
	movq %r8, %rsi
	movl %edi, %edx
	addl $1, %edx
	movq %rcx, %rdi
	callq _c0_inorder
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_main:
	addq $-40, %rsp
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
.main_0:
	movq $0, %rdi
	movl $10, %esi
	callq _c0_insert
	movq %rax, %rcx
	movq $20, %rdi
	movq $4, %rsi
	movq %rcx, %rbx
	callq calloc
	movq %rbx, %rcx
	movq %rax, %r9
	movl $0, %r8d
	movq %rcx, %rdi
	movl $13, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, %rcx
	movq %rcx, %rdi
	movl $7, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, %rcx
	movq %rcx, %rdi
	movl $3, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, %rcx
	movq %rcx, %rdi
	movl $11, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, %rcx
	movq %rcx, %rdi
	movl $5, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, %rcx
	movq %rcx, %rdi
	movl $1, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, %rcx
	movq %rcx, %rdi
	movl $2, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, %rcx
	movq %rcx, %rdi
	movl $12, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, %rcx
	movq %rcx, %rdi
	movl $9, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, %rcx
	movq %rcx, %rdi
	movl $8, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, %rcx
	movq %rcx, %rdi
	movl $17, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, %rcx
	movq %rcx, %rdi
	movl $20, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, %rcx
	movq %rcx, %rdi
	movl $16, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, %rcx
	movq %rcx, %rdi
	movl $4, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, %rcx
	movq %rcx, %rdi
	movl $15, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, %rcx
	movq %rcx, %rdi
	movl $12, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, %rcx
	movq %rcx, %rdi
	movl $14, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, %rcx
	movq %rcx, %rdi
	movl $6, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, %rcx
	movq %rcx, %rdi
	movl $19, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, %rcx
	movq %rcx, %rdi
	movl $18, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, %rcx
	movq %r9, %rdi
	movq %rcx, %rsi
	movl $0, %edx
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_inorder
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
.main_9:
.main_1:
	movl $1, %edi
	movl $20, %esi
	movl %r8d, %edx
	cmpl %esi, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %edi
	jnz .main_7
.main_2:
	movl %r8d, %edx
	imull $4, %edx
	movslq %edx, %rsi
	movq %r9, %rdx
	addq %rsi, %rdx
	movl (%rdx), %edx
	movl %edx, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq printint
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $32, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq printchar
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl %r8d, %edx
	imull $4, %edx
	movslq %edx, %rdx
	movq %r9, %rsi
	addq %rdx, %rsi
	movl (%rsi), %edx
	movl $1, %edi
	movl %r8d, %esi
	addl $1, %esi
	cmpl %esi, %edx
	setne %dl
	movzbl %dl, %edx
	cmpl %edx, %edi
	jnz .main_5
.main_3:
	movl $0, %eax
	subl $1, %eax
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.main_5:
.main_6:
	addl $1, %r8d
.main_8:
	jmp .main_1
.main_7:
	movl $10, %edi
	movq %rcx, %rbx
	callq printchar
	movq %rbx, %rcx
	movq $8, %r9
	movq %rcx, %r8
	addq %r9, %r8
	movq (%r8), %r9
	movq $16, %r8
	addq %r8, %r9
	movq (%r9), %r9
	movq $8, %r8
	addq %r8, %r9
	movq (%r9), %r8
	movq $0, %r9
	addq %r9, %r8
	movl (%r8), %r9d
	movl %r9d, %eax
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.ident	"15-411 L4 reference compiler"
