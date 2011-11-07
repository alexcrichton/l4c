.file	"../tests1/merlin-return-union-find.l4"
.globl _c0_main
_c0_makeset:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movq %rdi, %r9
.makeset_0:
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl (%r8), %esi
	movq $4, %r8
	movq %r9, %rcx
	addq %r8, %rcx
	movl (%rcx), %r8d
	movl $1, %edx
	movl %esi, %ecx
	cmpl %r8d, %ecx
	setle %cl
	movzbl %cl, %ecx
	cmpl %ecx, %edx
	jnz .makeset_5
.makeset_1:
	movq $0, %r8
	movq %r9, %rcx
	addq %r8, %rcx
	movl (%rcx), %r8d
	imull $2, %r8d
	movslq %r8d, %rdi
	movq $8, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movl $0, %r8d
.makeset_8:
	movl %r8d, %esi
.makeset_2:
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl (%r8), %r8d
	movl $1, %edx
	movl %esi, %ecx
	cmpl %r8d, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %edx
	jnz .makeset_4
.makeset_3:
	movq $8, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %rdx
	movl %esi, %r8d
	imull $8, %r8d
	movslq %r8d, %rcx
	movq %rdx, %r8
	addq %rcx, %r8
	movq (%r8), %rdx
	movl %esi, %r8d
	imull $8, %r8d
	movslq %r8d, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movq %rdx, (%r8)
	movl %esi, %r8d
	addl $1, %r8d
.makeset_7:
	movl %r8d, %esi
	jmp .makeset_2
.makeset_4:
	movq $8, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq %rax, (%r8)
	movq $0, %r8
	movq %r9, %rdx
	addq %r8, %rdx
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl (%r8), %r8d
	movl %r8d, (%rdx)
	movl (%rdx), %r11d
	imull $2, %r11d
	movl %r11d, (%rdx)
.makeset_6:
	movq $1, %rdi
	movq $12, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movq $4, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl (%r8), %edx
	movq $0, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movl %edx, (%r8)
	movq $4, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl (%r8), %edx
	movq $4, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movl %edx, (%r8)
	movq $8, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movl $0, (%r8)
	movq $8, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %rdx
	movq $4, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl (%r8), %r8d
	imull $8, %r8d
	movslq %r8d, %rcx
	movq %rdx, %r8
	addq %rcx, %r8
	movq %rax, (%r8)
	movq $4, %r8
	movq %r9, %rcx
	addq %r8, %rcx
	movq $4, %r8
	addq %r8, %r9
	movl (%r9), %r9d
	movl %r9d, (%rcx)
	addl $1, (%rcx)
	movl $1, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.makeset_5:
	jmp .makeset_6
_c0_find:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movq %rdi, %r9
	movq %rsi, %rdi
.find_0:
	movq $4, %r8
	movq %r9, %rcx
	addq %r8, %rcx
	movl (%rcx), %esi
	movq $0, %r8
	movq %r9, %rcx
	addq %r8, %rcx
	movl (%rcx), %edx
	movl $1, %ecx
	movl %esi, %r8d
	cmpl %edx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .find_2
.find_1:
	movq $4, %r8
	addq %r8, %r9
	movl (%r9), %r9d
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.find_2:
	movq $8, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movq (%r8), %rdx
	movq $4, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl (%r8), %r8d
	imull $8, %r8d
	movslq %r8d, %rcx
	movq %rdx, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movq %r8, %rcx
	movq %rdi, %rsi
	movq %rcx, %rdi
	movq %r9, %rbx
	callq _c0_find
	movq %rbx, %r9
	movq $4, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl %eax, (%r8)
	movq $4, %r8
	addq %r8, %r9
	movl (%r9), %r9d
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_union:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
	movq %rsi, %r9
	movq %rdx, %r8
.union_0:
	movq %r8, %rsi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_find
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %ecx
	movq %r9, %rdi
	movq %r8, %rsi
	movq %rcx, %r12
	movq %r8, %rbx
	callq _c0_find
	movq %r12, %rcx
	movq %rbx, %r8
	movl %eax, %esi
	movl $1, %edx
	movl %ecx, %r9d
	cmpl %esi, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %edx
	jnz .union_3
.union_1:
	movl $1, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.union_3:
.union_4:
	movq $8, %rdx
	movq %r8, %r9
	addq %rdx, %r9
	movq (%r9), %rdx
	movl %ecx, %r9d
	imull $8, %r9d
	movslq %r9d, %rcx
	movq %rdx, %r9
	addq %rcx, %r9
	movq (%r9), %r9
	movq %r9, %rdi
	movq $8, %rcx
	movq %r8, %r9
	addq %rcx, %r9
	movq (%r9), %rcx
	movl %esi, %r9d
	imull $8, %r9d
	movslq %r9d, %r8
	movq %rcx, %r9
	addq %r8, %r9
	movq (%r9), %r9
	movq %r9, %rsi
	movq $8, %r8
	movq %rdi, %r9
	addq %r8, %r9
	movl (%r9), %edx
	movq $8, %r8
	movq %rsi, %r9
	addq %r8, %r9
	movl (%r9), %ecx
	movl $1, %r8d
	movl %edx, %r9d
	cmpl %ecx, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %r8d
	jnz .union_5
.union_8:
	movq $0, %r8
	movq %rsi, %r9
	addq %r8, %r9
	movl (%r9), %ecx
	movq $4, %r8
	movq %rdi, %r9
	addq %r8, %r9
	movl %ecx, (%r9)
.union_10:
	movl $1, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.union_5:
	movq $8, %r8
	movq %rsi, %r9
	addq %r8, %r9
	movl (%r9), %edx
	movq $8, %r8
	movq %rdi, %r9
	addq %r8, %r9
	movl (%r9), %ecx
	movl $1, %r8d
	movl %edx, %r9d
	cmpl %ecx, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %r8d
	jnz .union_7
.union_6:
	movq $0, %r8
	movq %rdi, %r9
	addq %r8, %r9
	movl (%r9), %ecx
	movq $4, %r8
	movq %rsi, %r9
	addq %r8, %r9
	movl %ecx, (%r9)
.union_9:
	jmp .union_10
.union_7:
	movq $0, %r8
	movq %rdi, %r9
	addq %r8, %r9
	movl (%r9), %ecx
	movq $4, %r8
	movq %rsi, %r9
	addq %r8, %r9
	movl %ecx, (%r9)
	movq $8, %r8
	movq %rdi, %r9
	addq %r8, %r9
	movl (%r9), %r8d
	movq $8, %rcx
	movq %rdi, %r9
	addq %rcx, %r9
	movl %r8d, (%r9)
	addl $1, (%r9)
	jmp .union_9
_c0_main:
	addq $-40, %rsp
	movq %r14, 8(%rsp)
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
.main_0:
	movq $1, %rdi
	movq $16, %rsi
	callq calloc
	movq %rax, %r9
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl $1, (%r8)
	movq $4, %r8
	movq %r9, %rcx
	addq %r8, %rcx
	movl $0, (%rcx)
	movq $8, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq $1, %rdi
	movq $8, %rsi
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, (%r8)
	movl $0, %r8d
.main_11:
.main_1:
	movl $1, %esi
	movl $500, %edx
	movl %r8d, %ecx
	cmpl %edx, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .main_3
.main_2:
	movq %r9, %rdi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_makeset
	movq %r12, %r8
	movq %rbx, %r9
	addl $1, %r8d
.main_10:
	jmp .main_1
.main_3:
	movq $8, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %rdx
	movq $8, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %rcx
	movl $10, %r8d
	imull $8, %r8d
	movslq %r8d, %r8
	addq %r8, %rcx
	movq (%rcx), %r8
	movq $4, %rcx
	addq %rcx, %r8
	movl (%r8), %r8d
	imull $8, %r8d
	movslq %r8d, %rcx
	movq %rdx, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movq %r8, %rdi
	movq %r9, %rsi
	movq %r9, %rbx
	callq _c0_find
	movq %rbx, %r9
	movl %eax, %r8d
	movq $8, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movq (%rcx), %rdi
	movq $8, %rcx
	movq %r9, %rdx
	addq %rcx, %rdx
	movq (%rdx), %rsi
	movl $125, %ecx
	imull $8, %ecx
	movslq %ecx, %rdx
	movq %rsi, %rcx
	addq %rdx, %rcx
	movq (%rcx), %rcx
	movq $4, %rdx
	addq %rdx, %rcx
	movl (%rcx), %ecx
	imull $8, %ecx
	movslq %ecx, %rdx
	movq %rdi, %rcx
	addq %rdx, %rcx
	movq (%rcx), %rcx
	movq %rcx, %rdi
	movq %r9, %rsi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_find
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %ebx
	movl $0, %ecx
.main_13:
.main_4:
	movl $1, %edi
	movl $249, %esi
	movl %ecx, %edx
	cmpl %esi, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %edi
	jnz .main_6
.main_5:
	movq $8, %rsi
	movq %r9, %rdx
	addq %rsi, %rdx
	movq (%rdx), %rdi
	movl %ecx, %edx
	imull $8, %edx
	movslq %edx, %rsi
	movq %rdi, %rdx
	addq %rsi, %rdx
	movq (%rdx), %rax
	movq $8, %rdx
	movq %r9, %rsi
	addq %rdx, %rsi
	movq (%rsi), %rdi
	movl %ecx, %edx
	addl $1, %edx
	imull $8, %edx
	movslq %edx, %rsi
	movq %rdi, %rdx
	addq %rsi, %rdx
	movq (%rdx), %rdx
	movq %rax, %rdi
	movq %rdx, %rsi
	movq %r9, %rdx
	movq %rcx, %r14
	movq %r8, %r13
	movq %r9, %r12
	callq _c0_union
	movq %r14, %rcx
	movq %r13, %r8
	movq %r12, %r9
	addl $1, %ecx
.main_12:
	jmp .main_4
.main_6:
	movl $250, %ecx
.main_15:
.main_7:
	movl $1, %edi
	movl $499, %esi
	movl %ecx, %edx
	cmpl %esi, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %edi
	jnz .main_9
.main_8:
	movq $8, %rsi
	movq %r9, %rdx
	addq %rsi, %rdx
	movq (%rdx), %rdi
	movl %ecx, %edx
	imull $8, %edx
	movslq %edx, %rsi
	movq %rdi, %rdx
	addq %rsi, %rdx
	movq (%rdx), %rax
	movq $8, %rsi
	movq %r9, %rdx
	addq %rsi, %rdx
	movq (%rdx), %rdi
	movl %ecx, %edx
	addl $1, %edx
	imull $8, %edx
	movslq %edx, %rsi
	movq %rdi, %rdx
	addq %rsi, %rdx
	movq (%rdx), %rdx
	movq %rax, %rdi
	movq %rdx, %rsi
	movq %r9, %rdx
	movq %rcx, %r14
	movq %r8, %r13
	movq %r9, %r12
	callq _c0_union
	movq %r14, %rcx
	movq %r13, %r8
	movq %r12, %r9
	addl $1, %ecx
.main_14:
	jmp .main_7
.main_9:
	movq $8, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movq (%rcx), %rdi
	movq $8, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movq (%rcx), %rsi
	movl $110, %ecx
	imull $8, %ecx
	movslq %ecx, %rdx
	movq %rsi, %rcx
	addq %rdx, %rcx
	movq (%rcx), %rcx
	movq $4, %rdx
	addq %rdx, %rcx
	movl (%rcx), %ecx
	imull $8, %ecx
	movslq %ecx, %rdx
	movq %rdi, %rcx
	addq %rdx, %rcx
	movq (%rcx), %rcx
	movq %rcx, %rdi
	movq %r9, %rsi
	movq %r8, %r13
	movq %r9, %r12
	callq _c0_find
	movq %r13, %r8
	movq %r12, %r9
	movl %eax, %ecx
	movq $8, %rsi
	movq %r9, %rdx
	addq %rsi, %rdx
	movq (%rdx), %rdi
	movq $8, %rsi
	movq %r9, %rdx
	addq %rsi, %rdx
	movq (%rdx), %rsi
	movl $411, %edx
	imull $8, %edx
	movslq %edx, %rax
	movq %rsi, %rdx
	addq %rax, %rdx
	movq (%rdx), %rdx
	movq $4, %rsi
	addq %rsi, %rdx
	movl (%rdx), %edx
	imull $8, %edx
	movslq %edx, %rsi
	movq %rdi, %rdx
	addq %rsi, %rdx
	movq (%rdx), %rdx
	movq %rdx, %rdi
	movq %r9, %rsi
	movq %rcx, %r13
	movq %r8, %r12
	callq _c0_find
	movq %r13, %rcx
	movq %r12, %r8
	movl %eax, %edx
	movl %r8d, %r9d
	addl %ebx, %r9d
	addl %ecx, %r9d
	movl %r9d, %eax
	addl %edx, %eax
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.ident	"15-411 L4 reference compiler"
