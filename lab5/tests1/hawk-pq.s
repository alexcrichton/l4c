.file	"../tests1/hawk-pq.l4"
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
	movq %rax, %rbx
	movq $0, %rdx
	movq %rbx, %rcx
	addq %rdx, %rcx
	movl %r8d, (%rcx)
	movl $1, %esi
	movq $0, %rdx
	movq %r9, %rcx
	cmpq %rdx, %rcx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .insert_3
.insert_1:
	movl $0, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.insert_3:
.insert_4:
	movq $0, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movq (%rcx), %rcx
	movl $1, %esi
	movq $0, %rdx
	cmpq %rdx, %rcx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .insert_7
.insert_5:
	movq $8, %rcx
	movq %rbx, %r8
	addq %rcx, %r8
	movq $0, (%r8)
	movq $0, %r8
	addq %r8, %r9
	movq %rbx, (%r9)
	movl $0, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.insert_7:
.insert_8:
	movq $0, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movq (%rcx), %rcx
	movq %rcx, %rax
	movq $0, %rdx
	movq %rax, %rcx
	addq %rdx, %rcx
	movl (%rcx), %esi
	movl $1, %edx
	movl %r8d, %ecx
	cmpl %esi, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %edx
	jnz .insert_11
.insert_9:
	movq $8, %rcx
	movq %rbx, %r8
	addq %rcx, %r8
	movq %rax, (%r8)
	movq $0, %r8
	addq %r8, %r9
	movq %rbx, (%r9)
	movl $0, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.insert_11:
.insert_12:
	movq $8, %rcx
	movq %rax, %r9
	addq %rcx, %r9
	movq (%r9), %r9
.insert_21:
	movq %r9, %rdi
	movq %rax, %rsi
.insert_13:
	movl $1, %edx
	movq $0, %rcx
	movq %rdi, %r9
	cmpq %rcx, %r9
	setne %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %edx
	jnz .insert_19
.insert_14:
	movq $0, %rcx
	movq %rdi, %r9
	addq %rcx, %r9
	movl (%r9), %edx
	movl $1, %ecx
	movl %r8d, %r9d
	cmpl %edx, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .insert_17
.insert_15:
	movq $8, %r8
	movq %rbx, %r9
	addq %r8, %r9
	movq %rdi, (%r9)
	movq $8, %r8
	movq %rsi, %r9
	addq %r8, %r9
	movq %rbx, (%r9)
	movl $0, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.insert_17:
.insert_18:
	movq %rdi, %rdx
	movq $8, %rcx
	movq %rdx, %r9
	addq %rcx, %r9
	movq (%r9), %r9
.insert_20:
	movq %r9, %rdi
	movq %rdx, %rsi
	jmp .insert_13
.insert_19:
	movq $8, %r8
	movq %rbx, %r9
	addq %r8, %r9
	movq $0, (%r9)
	movq $8, %r9
	movq %rsi, %r8
	addq %r9, %r8
	movq %rbx, (%r8)
	movl $0, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_pop:
	addq $-8, %rsp
.pop_0:
	movq $0, %r8
	cmpq %r8, %rdi
	jz .ternary_true1
	movq $0, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movq $0, %rcx
	cmpq %rcx, %r8
	sete %cl
	movzbl %cl, %ecx
	jmp .ternary_end2
.ternary_true1:
	movl $1, %ecx
.ternary_end2:
	movl $1, %r8d
	cmpl %ecx, %r8d
	jnz .pop_3
.pop_1:
	movl $0, %eax
	addq $8, %rsp
	ret
.pop_3:
.pop_4:
	movq $0, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movq %r8, %rdx
	movq $8, %rcx
	movq %rdx, %r8
	addq %rcx, %r8
	movq (%r8), %rcx
	movq $0, %r8
	movq %rdi, %r9
	addq %r8, %r9
	movq %rcx, (%r9)
	movq $0, %r8
	movq %rdx, %r9
	addq %r8, %r9
	movl (%r9), %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movq $1, %rdi
	movq $8, %rsi
	callq calloc
	movq %rax, %r9
	movq %r9, %rdi
	movl $6, %esi
	movq %r9, %rbx
	callq _c0_insert
	movq %rbx, %r9
	movq %r9, %rdi
	movl $3, %esi
	movq %r9, %rbx
	callq _c0_insert
	movq %rbx, %r9
	movq %r9, %rdi
	movl $9, %esi
	movq %r9, %rbx
	callq _c0_insert
	movq %rbx, %r9
	movq %r9, %rdi
	movl $27, %esi
	movq %r9, %rbx
	callq _c0_insert
	movq %rbx, %r9
	movq %r9, %rdi
	movl $5, %esi
	movq %r9, %rbx
	callq _c0_insert
	movq %rbx, %r9
	movq %r9, %rdi
	movq %r9, %rbx
	callq _c0_pop
	movq %rbx, %r9
	movq %r9, %rdi
	movq %r9, %rbx
	callq _c0_pop
	movq %rbx, %r9
	movq %r9, %rdi
	callq _c0_pop
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
