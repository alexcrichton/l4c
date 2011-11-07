.file	"../tests1/hobby-bst.l4"
.globl _c0_main
_c0_insert:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
	movq %rdi, %r9
	movl %esi, %r8d
	movl %edx, %ecx
.insert_0:
	movl $1, %edi
	movq $0, %rdx
	movq %r9, %rsi
	cmpq %rdx, %rsi
	sete %dl
	movzbl %dl, %edx
	cmpl %edx, %edi
	jnz .insert_3
.insert_1:
	movq $1, %rdi
	movq $24, %rsi
	movq %rcx, %r12
	movq %r8, %rbx
	callq calloc
	movq %r12, %rcx
	movq %rbx, %r8
	movq $16, %rsi
	movq %rax, %rdx
	addq %rsi, %rdx
	movl %r8d, (%rdx)
	movq $20, %r8
	movq %rax, %rdx
	addq %r8, %rdx
	movl %ecx, (%rdx)
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.insert_3:
.insert_4:
	movq $16, %rsi
	movq %r9, %rdx
	addq %rsi, %rdx
	movl (%rdx), %edi
	movl $1, %esi
	movl %r8d, %edx
	cmpl %edi, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %esi
	jnz .insert_6
.insert_5:
	movq $0, %rsi
	movq %r9, %rdx
	addq %rsi, %rdx
	movq (%rdx), %rdx
	movq %rdx, %rdi
	movl %r8d, %esi
	movl %ecx, %edx
	movq %r9, %rbx
	callq _c0_insert
	movq %rbx, %r9
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq %rax, (%r8)
	movq %r9, %rax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.insert_6:
	movq $16, %rsi
	movq %r9, %rdx
	addq %rsi, %rdx
	movl (%rdx), %edx
	movl $1, %esi
	cmpl %r8d, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %esi
	jnz .insert_9
.insert_7:
	movq $8, %rsi
	movq %r9, %rdx
	addq %rsi, %rdx
	movq (%rdx), %rdx
	movq %rdx, %rdi
	movl %r8d, %esi
	movl %ecx, %edx
	movq %r9, %rbx
	callq _c0_insert
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
.insert_9:
.insert_11:
.insert_12:
	movq $20, %rdx
	movq %r9, %r8
	addq %rdx, %r8
	movl %ecx, (%r8)
	movq %r9, %rax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_contains:
	addq $-8, %rsp
.contains_0:
	movl $1, %ecx
	movq $0, %r8
	movq %rdi, %rdx
	cmpq %r8, %rdx
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .contains_3
.contains_1:
	movl $0, %eax
	addq $8, %rsp
	ret
.contains_3:
.contains_4:
	movq $16, %r8
	movq %rdi, %rcx
	addq %r8, %rcx
	movl (%rcx), %edx
	movl $1, %ecx
	movl %esi, %r8d
	cmpl %edx, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .contains_6
.contains_5:
	movq $0, %r8
	movq %rdi, %r9
	addq %r8, %r9
	movq (%r9), %r9
	movq %r9, %rdi
	callq _c0_contains
	addq $8, %rsp
	ret
.contains_6:
	movq $16, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl (%r8), %r8d
	movl $1, %ecx
	cmpl %esi, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .contains_9
.contains_7:
	movq $8, %r8
	movq %rdi, %r9
	addq %r8, %r9
	movq (%r9), %r9
	movq %r9, %rdi
	callq _c0_contains
	addq $8, %rsp
	ret
.contains_9:
.contains_11:
.contains_12:
	movl $1, %eax
	addq $8, %rsp
	ret
_c0_get:
	addq $-8, %rsp
.get_0:
	movq $16, %r8
	movq %rdi, %rcx
	addq %r8, %rcx
	movl (%rcx), %edx
	movl $1, %r8d
	movl %esi, %ecx
	cmpl %edx, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %r8d
	jnz .get_2
.get_1:
	movq $0, %r8
	movq %rdi, %r9
	addq %r8, %r9
	movq (%r9), %r9
	movq %r9, %rdi
	callq _c0_get
	addq $8, %rsp
	ret
.get_2:
	movq $16, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl (%r8), %r8d
	movl $1, %ecx
	cmpl %esi, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .get_5
.get_3:
	movq $8, %r8
	movq %rdi, %r9
	addq %r8, %r9
	movq (%r9), %r9
	movq %r9, %rdi
	callq _c0_get
	addq $8, %rsp
	ret
.get_5:
.get_7:
.get_8:
	movq $20, %r8
	movq %rdi, %r9
	addq %r8, %r9
	movl (%r9), %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movq $0, %r9
	movq %r9, %rdi
	movl $7, %esi
	movl $2, %edx
	callq _c0_insert
	movq %rax, %r9
	movq %r9, %rdi
	movl $1, %esi
	movl $5, %edx
	callq _c0_insert
	movq %rax, %r9
	movq %r9, %rdi
	movl $10, %esi
	movl $49, %edx
	callq _c0_insert
	movq %rax, %r9
	movq %r9, %rdi
	movl $3, %esi
	movl $237, %edx
	callq _c0_insert
	movq %rax, %r9
	movq %r9, %rdi
	movl $5, %esi
	movl $55, %edx
	callq _c0_insert
	movq %rax, %r9
	movq %r9, %rdi
	movl $2, %esi
	movq %r9, %rbx
	callq _c0_contains
	movq %rbx, %r9
	movl $1, %ecx
	cmpl %eax, %ecx
	jnz .main_3
.main_1:
	movl $3, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.main_3:
.main_4:
	movq %r9, %rdi
	movl $3, %esi
	movq %r9, %rbx
	callq _c0_contains
	movq %rbx, %r9
	movl $1, %ecx
	cmpl %eax, %ecx
	jnz .main_7
.main_5:
	movq %r9, %rdi
	movl $3, %esi
	callq _c0_get
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.main_7:
.main_8:
	movl $20, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
