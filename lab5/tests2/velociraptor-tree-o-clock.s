.file	"../tests2/velociraptor-tree-o-clock.l4"
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
_c0_insert:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movq %rdi, %r9
.insert_0:
	movl $1, %ecx
	movq $0, %rdx
	movq %r9, %r8
	cmpq %rdx, %r8
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .insert_3
.insert_1:
	movl $0, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.insert_3:
.insert_4:
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl (%r8), %edx
	movl $1, %ecx
	movl %esi, %r8d
	cmpl %edx, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .insert_11
.insert_5:
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
	jnz .insert_7
.insert_6:
	movl %esi, %edi
	movq %r9, %rbx
	callq _c0_init
	movq %rbx, %r9
	movq $8, %r8
	addq %r8, %r9
	movq %rax, (%r9)
	movl $1, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.insert_7:
	movq $8, %r8
	addq %r8, %r9
	movq (%r9), %r9
	movq %r9, %rdi
	callq _c0_insert
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.insert_11:
.insert_12:
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl (%r8), %r8d
	movl $1, %ecx
	cmpl %esi, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .insert_19
.insert_13:
	movq $16, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movl $1, %edx
	movq $0, %rcx
	cmpq %rcx, %r8
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .insert_15
.insert_14:
	movl %esi, %edi
	movq %r9, %rbx
	callq _c0_init
	movq %rbx, %r9
	movq $16, %r8
	addq %r8, %r9
	movq %rax, (%r9)
	movl $1, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.insert_15:
	movq $16, %r8
	addq %r8, %r9
	movq (%r9), %r9
	movq %r9, %rdi
	callq _c0_insert
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.insert_19:
.insert_20:
	movl $1, %eax
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
	movq $1, %rdi
	movq $24, %rsi
	callq calloc
	movq %rax, %r9
	movq $20, %rdi
	movq $4, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movq %rax, %r8
	movl $0, %ecx
	movq $0, %rdx
	movq %r9, %rsi
	addq %rdx, %rsi
	movl $10, (%rsi)
	movq %r9, %rdi
	movl $13, %esi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movq %r9, %rdi
	movl $7, %esi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movq %r9, %rdi
	movl $3, %esi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movq %r9, %rdi
	movl $11, %esi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movq %r9, %rdi
	movl $5, %esi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movq %r9, %rdi
	movl $1, %esi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movq %r9, %rdi
	movl $2, %esi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movq %r9, %rdi
	movl $12, %esi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movq %r9, %rdi
	movl $9, %esi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movq %r9, %rdi
	movl $8, %esi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movq %r9, %rdi
	movl $17, %esi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movq %r9, %rdi
	movl $20, %esi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movq %r9, %rdi
	movl $16, %esi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movq %r9, %rdi
	movl $4, %esi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movq %r9, %rdi
	movl $15, %esi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movq %r9, %rdi
	movl $12, %esi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movq %r9, %rdi
	movl $14, %esi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movq %r9, %rdi
	movl $6, %esi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movq %r9, %rdi
	movl $19, %esi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movq %r9, %rdi
	movl $18, %esi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movq %r8, %rdi
	movq %r9, %rsi
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
	movl %ecx, %edx
	cmpl %esi, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %edi
	jnz .main_7
.main_2:
	movl %ecx, %edx
	imull $4, %edx
	movslq %edx, %rsi
	movq %r8, %rdx
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
	movl %ecx, %edx
	imull $4, %edx
	movslq %edx, %rsi
	movq %r8, %rdx
	addq %rsi, %rdx
	movl (%rdx), %edi
	movl $1, %esi
	movl %ecx, %edx
	addl $1, %edx
	cmpl %edx, %edi
	setne %dil
	movzbl %dil, %edi
	cmpl %edi, %esi
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
	addl $1, %ecx
.main_8:
	jmp .main_1
.main_7:
	movl $10, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movq $8, %r8
	addq %r8, %r9
	movq (%r9), %r9
	movq $16, %r8
	addq %r8, %r9
	movq (%r9), %r9
	movq $8, %r8
	addq %r8, %r9
	movq (%r9), %r9
	movq $0, %r8
	addq %r8, %r9
	movl (%r9), %r9d
	movl %r9d, %eax
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.ident	"15-411 L4 reference compiler"
