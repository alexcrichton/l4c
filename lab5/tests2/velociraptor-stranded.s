.file	"../tests2/velociraptor-stranded.l4"
.globl _c0_main
_c0_insert:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
	movq %rdi, %r9
	movl %esi, %r8d
.insert_0:
	movq $1, %rdi
	movq $16, %rsi
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r12, %r8
	movq %rbx, %r9
	movq $0, %rdx
	movq %rax, %rcx
	addq %rdx, %rcx
	movl %r8d, (%rcx)
	movq $8, %r8
	movq %rax, %rcx
	addq %r8, %rcx
	movq %r9, (%rcx)
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_pullstrand:
	addq $-56, %rsp
	movq %r15, 16(%rsp)
	movq %r14, 24(%rsp)
	movq %r13, 32(%rsp)
	movq %r12, 40(%rsp)
	movq %rbx, 48(%rsp)
	movq %rdi, %r9
.pullstrand_0:
	movq $0, %r8
	movq $0, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movl (%rcx), %ecx
	movq $0, %rdi
	movl %ecx, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, %rcx
	movq $1, %rdi
	movq $16, %rsi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, %rbx
	movq $8, %rdx
	addq %rdx, %r9
	movq (%r9), %r9
.pullstrand_8:
	movq %r8, %rdx
.pullstrand_1:
	movl $1, %edi
	movq $0, %rsi
	movq %r9, %r8
	cmpq %rsi, %r8
	setne %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edi
	jnz .pullstrand_6
.pullstrand_2:
	movq $0, %rsi
	movq %rcx, %r8
	addq %rsi, %r8
	movl (%r8), %eax
	movq $0, %rsi
	movq %r9, %r8
	addq %rsi, %r8
	movl (%r8), %edi
	movl $1, %esi
	movl %eax, %r8d
	cmpl %edi, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %esi
	jnz .pullstrand_4
.pullstrand_3:
	movq $0, %rsi
	movq %r9, %r8
	addq %rsi, %r8
	movl (%r8), %r8d
	movq %rcx, %rdi
	movl %r8d, %esi
	movq %rdx, %r14
	movq %r8, %r13
	movq %r9, %r12
	callq _c0_insert
	movq %r14, %rdx
	movq %r13, %r8
	movq %r12, %r9
	movq %rax, %rcx
.pullstrand_10:
	movq %rcx, %rdi
	movq %rdx, %rsi
.pullstrand_5:
	movq $8, %r8
	addq %r8, %r9
	movq (%r9), %r9
.pullstrand_7:
	movq %rdi, %rcx
	movq %rsi, %rdx
	jmp .pullstrand_1
.pullstrand_4:
	movq $0, %rsi
	movq %r9, %r8
	addq %rsi, %r8
	movl (%r8), %r8d
	movq %rdx, %rdi
	movl %r8d, %esi
	movq %rdx, %r15
	movq %rcx, %r14
	movq %r8, %r13
	movq %r9, %r12
	callq _c0_insert
	movq %r15, %rdx
	movq %r14, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movq %rax, %rsi
.pullstrand_9:
	movq %rcx, %rdi
	jmp .pullstrand_5
.pullstrand_6:
	movq $0, %r8
	movq %rbx, %r9
	addq %r8, %r9
	movq %rdx, (%r9)
	movq $8, %r9
	movq %rbx, %r8
	addq %r9, %r8
	movq %rcx, (%r8)
	movq %rbx, %rax
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
_c0_merge:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movq %rdi, %r9
	movq %rsi, %r8
.merge_0:
	movl $1, %esi
	movq $0, %rdx
	movq %r9, %rcx
	cmpq %rdx, %rcx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .merge_3
.merge_1:
	movq %r8, %rax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.merge_3:
.merge_4:
	movl $1, %esi
	movq $0, %rcx
	movq %r8, %rdx
	cmpq %rcx, %rdx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .merge_7
.merge_5:
	movq %r9, %rax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.merge_7:
.merge_8:
	movq $0, %rdx
	movq %r8, %rcx
	addq %rdx, %rcx
	movl (%rcx), %edx
	movq $0, %rsi
	movq %r9, %rcx
	addq %rsi, %rcx
	movl (%rcx), %esi
	movl $1, %ecx
	cmpl %esi, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %ecx
	jnz .merge_10
.merge_9:
	movq $8, %rcx
	movq %r9, %rdx
	addq %rcx, %rdx
	movq (%rdx), %rcx
	movq %rcx, %rdi
	movq %r8, %rsi
	movq %r9, %rbx
	callq _c0_merge
	movq %rbx, %r9
	movq $0, %r8
	addq %r8, %r9
	movl (%r9), %r9d
	movq %rax, %rdi
	movl %r9d, %esi
	callq _c0_insert
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.merge_10:
	movq $8, %rdx
	movq %r8, %rcx
	addq %rdx, %rcx
	movq (%rcx), %rdx
	movq %r9, %rdi
	movq %rdx, %rsi
	movq %r8, %rbx
	callq _c0_merge
	movq %rbx, %r8
	movq $0, %rcx
	movq %r8, %r9
	addq %rcx, %r9
	movl (%r9), %r9d
	movq %rax, %rdi
	movl %r9d, %esi
	callq _c0_insert
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_reverse:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.reverse_0:
	movl $1, %edx
	movq $0, %rcx
	movq %rdi, %r9
	cmpq %rcx, %r9
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %edx
	jnz .reverse_3
.reverse_1:
	movq %rsi, %rax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.reverse_3:
.reverse_4:
	movq $8, %r9
	movq %rdi, %rcx
	addq %r9, %rcx
	movq (%rcx), %r9
	movq $0, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl (%r8), %r8d
	movq %rsi, %rdi
	movl %r8d, %esi
	movq %r9, %rbx
	callq _c0_insert
	movq %rbx, %r9
	movq %r9, %rdi
	movq %rax, %rsi
	callq _c0_reverse
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_strandsort:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.strandsort_0:
	movq $0, %r9
	movl $1, %ecx
	movq $0, %rdx
	movq %rdi, %r8
	cmpq %rdx, %r8
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .strandsort_3
.strandsort_1:
	movq %rdi, %rax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.strandsort_3:
.strandsort_4:
	movq %r9, %rbx
	callq _c0_pullstrand
	movq %rbx, %r9
	movq %rax, %r8
.strandsort_9:
	movq %r9, %rsi
	movq %r8, %r9
.strandsort_5:
	movq $0, %r8
	movq %r9, %rcx
	addq %r8, %rcx
	movq (%rcx), %r8
	movl $1, %edx
	movq $0, %rcx
	cmpq %rcx, %r8
	setne %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .strandsort_7
.strandsort_6:
	movq $8, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movq %rsi, %rdi
	movq %r8, %rsi
	movq %r9, %rbx
	callq _c0_merge
	movq %rbx, %r9
	movq %rax, %r8
	movq $0, %rcx
	addq %rcx, %r9
	movq (%r9), %r9
	movq %r9, %rdi
	movq %r8, %rbx
	callq _c0_pullstrand
	movq %rbx, %r8
	movq %rax, %r9
.strandsort_8:
	movq %r8, %rsi
	jmp .strandsort_5
.strandsort_7:
	movq $8, %r8
	addq %r8, %r9
	movq (%r9), %r9
	movq %rsi, %rdi
	movq %r9, %rsi
	callq _c0_merge
	movq %rax, %r9
	movq %r9, %rdi
	movq $0, %rsi
	callq _c0_reverse
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_main:
	addq $-56, %rsp
	movq %rbp, 8(%rsp)
	movq %r15, 16(%rsp)
	movq %r14, 24(%rsp)
	movq %r13, 32(%rsp)
	movq %r12, 40(%rsp)
	movq %rbx, 48(%rsp)
.main_0:
	movq $0, %rdi
	movl $75, %esi
	callq _c0_insert
	movq %rax, %r9
	movq $0, %rdi
	movl $7, %esi
	movq %r9, %rbx
	callq _c0_insert
	movq %rbx, %r9
	movq %rax, %r8
	movl $0, %ecx
	movl $0, %edx
	movq %r9, %rdi
	movl $82, %esi
	movq %rdx, %r13
	movq %rcx, %r12
	movq %r8, %rbx
	callq _c0_insert
	movq %r13, %rdx
	movq %r12, %rcx
	movq %rbx, %r8
	movq %rax, %r9
	movq %r9, %rdi
	movl $92, %esi
	movq %rdx, %r13
	movq %rcx, %r12
	movq %r8, %rbx
	callq _c0_insert
	movq %r13, %rdx
	movq %r12, %rcx
	movq %rbx, %r8
	movq %rax, %r9
	movq %r9, %rdi
	movl $96, %esi
	movq %rdx, %r13
	movq %rcx, %r12
	movq %r8, %rbx
	callq _c0_insert
	movq %r13, %rdx
	movq %r12, %rcx
	movq %rbx, %r8
	movq %rax, %r9
	movq %r9, %rdi
	movl $77, %esi
	movq %rdx, %r13
	movq %rcx, %r12
	movq %r8, %rbx
	callq _c0_insert
	movq %r13, %rdx
	movq %r12, %rcx
	movq %rbx, %r8
	movq %rax, %r9
	movq %r9, %rdi
	movl $48, %esi
	movq %rdx, %r13
	movq %rcx, %r12
	movq %r8, %rbx
	callq _c0_insert
	movq %r13, %rdx
	movq %r12, %rcx
	movq %rbx, %r8
	movq %rax, %r9
	movq %r9, %rdi
	movl $49, %esi
	movq %rdx, %r13
	movq %rcx, %r12
	movq %r8, %rbx
	callq _c0_insert
	movq %r13, %rdx
	movq %r12, %rcx
	movq %rbx, %r8
	movq %rax, %r9
	movq %r9, %rdi
	movl $28, %esi
	movq %rdx, %r13
	movq %rcx, %r12
	movq %r8, %rbx
	callq _c0_insert
	movq %r13, %rdx
	movq %r12, %rcx
	movq %rbx, %r8
	movq %rax, %r9
	movq %r9, %rdi
	movl $14, %esi
	movq %rdx, %r13
	movq %rcx, %r12
	movq %r8, %rbx
	callq _c0_insert
	movq %r13, %rdx
	movq %r12, %rcx
	movq %rbx, %r8
	movq %rax, %r9
	movq %r9, %rdi
	movl $30, %esi
	movq %rdx, %r13
	movq %rcx, %r12
	movq %r8, %rbx
	callq _c0_insert
	movq %r13, %rdx
	movq %r12, %rcx
	movq %rbx, %r8
	movq %rax, %r9
	movq %r9, %rdi
	movl $40, %esi
	movq %rdx, %r13
	movq %rcx, %r12
	movq %r8, %rbx
	callq _c0_insert
	movq %r13, %rdx
	movq %r12, %rcx
	movq %rbx, %r8
	movq %rax, %r9
	movq %r9, %rdi
	movl $75, %esi
.main_22:
	movq %rdi, %rbx
.main_1:
	movl $1, %r12d
	movl $10, %edi
	movl %edx, %eax
	cmpl %edi, %eax
	setl %al
	movzbl %al, %eax
	cmpl %eax, %r12d
	jnz .main_3
.main_2:
	movq $0, %rdi
	movq %rbx, %rax
	addq %rdi, %rax
	movl (%rax), %edi
	movq %rsi, %rbp
	movq %rdx, %r15
	movq %rcx, %r14
	movq %r8, %r13
	movq %r9, %r12
	callq printint
	movq %rbp, %rsi
	movq %r15, %rdx
	movq %r14, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movl $32, %edi
	movq %rsi, %rbp
	movq %rdx, %r15
	movq %rcx, %r14
	movq %r8, %r13
	movq %r9, %r12
	callq printchar
	movq %rbp, %rsi
	movq %r15, %rdx
	movq %r14, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movq $8, %rax
	movq %rbx, %rdi
	addq %rax, %rdi
	movq (%rdi), %rdi
	addl $1, %edx
.main_21:
	movq %rdi, %rbx
	jmp .main_1
.main_3:
	movl $10, %edi
	movq %rsi, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq printchar
	movq %r14, %rsi
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movq %r9, %rdi
	movq %rsi, %r13
	movq %rcx, %r12
	movq %r8, %rbx
	callq _c0_strandsort
	movq %r13, %rsi
	movq %r12, %rcx
	movq %rbx, %r8
	movq %rax, %r9
	movl $1, %edi
.main_24:
	movq %r9, %rdx
	movl %esi, %r9d
	movl %edi, %esi
.main_4:
	movl $1, %ebx
	movl $10, %eax
	movl %esi, %edi
	cmpl %eax, %edi
	setle %dil
	movzbl %dil, %edi
	cmpl %edi, %ebx
	jnz .main_10
.main_5:
	movq $0, %rax
	movq %rdx, %rdi
	addq %rax, %rdi
	movl (%rdi), %edi
	movq %rsi, %r15
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq printint
	movq %r15, %rsi
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $1, %edi
	cmpl %esi, %edi
	jl .ternary_true1
	movl $0, %edi
	jmp .ternary_end2
.ternary_true1:
	movq $0, %rax
	movq %rdx, %rdi
	addq %rax, %rdi
	movl (%rdi), %edi
	cmpl %r9d, %edi
	setl %dil
	movzbl %dil, %edi
.ternary_end2:
	movl $1, %r9d
	cmpl %edi, %r9d
	jnz .main_8
.main_6:
	movl $0, %eax
	subl $1, %eax
	movq 8(%rsp), %rbp
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
.main_8:
.main_9:
	movl $32, %edi
	movq %rsi, %r14
	movq %rdx, %r13
	movq %rcx, %r12
	movq %r8, %rbx
	callq printchar
	movq %r14, %rsi
	movq %r13, %rdx
	movq %r12, %rcx
	movq %rbx, %r8
	movq $0, %rdi
	movq %rdx, %r9
	addq %rdi, %r9
	movl (%r9), %r9d
	movl %r9d, %eax
	movq $8, %rdi
	movq %rdx, %r9
	addq %rdi, %r9
	movq (%r9), %r9
	addl $1, %esi
.main_23:
	movq %r9, %rdx
	movl %eax, %r9d
	jmp .main_4
.main_10:
	movl $10, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq printchar
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movq %r8, %rdi
	movl $2, %esi
	movq %rcx, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r12, %rcx
	movq %rbx, %r9
	movq %rax, %r8
	movq %r8, %rdi
	movl $5, %esi
	movq %rcx, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r12, %rcx
	movq %rbx, %r9
	movq %rax, %r8
	movq %r8, %rdi
	movl $9, %esi
	movq %rcx, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r12, %rcx
	movq %rbx, %r9
	movq %rax, %r8
	movq %r8, %rdi
	movl $3, %esi
	movq %rcx, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r12, %rcx
	movq %rbx, %r9
	movq %rax, %r8
	movq %r8, %rdi
	movl $6, %esi
	movq %rcx, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r12, %rcx
	movq %rbx, %r9
	movq %rax, %r8
	movq %r8, %rdi
	movl $8, %esi
	movq %rcx, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r12, %rcx
	movq %rbx, %r9
	movq %rax, %r8
	movq %r8, %rdi
	movl $1, %esi
	movq %rcx, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r12, %rcx
	movq %rbx, %r9
	movq %rax, %r8
	movq %r8, %rdi
	movl $4, %esi
	movq %rcx, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r12, %rcx
	movq %rbx, %r9
	movq %rax, %r8
	movq %r8, %rdx
	movl $1, %esi
.main_26:
.main_11:
	movl $1, %ebx
	movl $9, %eax
	movl %esi, %edi
	cmpl %eax, %edi
	setle %dil
	movzbl %dil, %edi
	cmpl %edi, %ebx
	jnz .main_13
.main_12:
	movq $0, %rax
	movq %rdx, %rdi
	addq %rax, %rdi
	movl (%rdi), %edi
	movq %rsi, %r15
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq printint
	movq %r15, %rsi
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $32, %edi
	movq %rsi, %r15
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq printchar
	movq %r15, %rsi
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movq $8, %rdi
	addq %rdi, %rdx
	movq (%rdx), %rdx
	addl $1, %esi
.main_25:
	jmp .main_11
.main_13:
	movl $10, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq printchar
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movq %r8, %rdi
	movq %rcx, %r12
	movq %r9, %rbx
	callq _c0_strandsort
	movq %r12, %rcx
	movq %rbx, %r9
	movq %rax, %r8
	movl $1, %edx
.main_28:
	movl %edx, %r9d
.main_14:
	movl $1, %edx
	movl $9, %edi
	movl %r9d, %esi
	cmpl %edi, %esi
	setle %sil
	movzbl %sil, %esi
	cmpl %esi, %edx
	jnz .main_20
.main_15:
	movq $0, %rsi
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
	movq $0, %rsi
	movq %r8, %rdx
	addq %rsi, %rdx
	movl (%rdx), %edx
	movl $1, %esi
	cmpl %r9d, %edx
	setne %dl
	movzbl %dl, %edx
	cmpl %edx, %esi
	jnz .main_18
.main_16:
	movl $0, %eax
	subl $1, %eax
	movq 8(%rsp), %rbp
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
.main_18:
.main_19:
	movl $32, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq printchar
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movq $0, %rdx
	movq %r8, %rsi
	addq %rdx, %rsi
	movl (%rsi), %esi
	movl $10, %edx
	imull %ecx, %edx
	movl %edx, %ecx
	addl %esi, %ecx
	movq $0, %rsi
	movq %r8, %rdx
	addq %rsi, %rdx
	movl (%rdx), %edx
	movl %edx, %esi
	movq $8, %rdx
	addq %rdx, %r8
	movq (%r8), %r8
	addl $1, %r9d
.main_27:
	jmp .main_14
.main_20:
	movl $10, %edi
	movq %rcx, %rbx
	callq printchar
	movq %rbx, %rcx
	movl %ecx, %eax
	movq 8(%rsp), %rbp
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
.ident	"15-411 L4 reference compiler"
