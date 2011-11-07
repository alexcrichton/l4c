.file	"../tests0/intmap.l4"
.globl _c0_main
_c0_lookup:
	addq $-8, %rsp
	movl %esi, %r8d
	movq %rdx, %rsi
.lookup_0:
.lookup_9:
	movq %rdi, %rdx
.lookup_1:
	movq $0, %r9
	cmpq %r9, %rdx
	jnz .ternary_true1
	movl $0, %ecx
	jmp .ternary_end2
.ternary_true1:
	movq $0, %rcx
	movq %rdx, %r9
	addq %rcx, %r9
	movl (%r9), %r9d
	movl %r9d, %ecx
	cmpl %r8d, %ecx
	setle %cl
	movzbl %cl, %ecx
.ternary_end2:
	movl $1, %r9d
	cmpl %ecx, %r9d
	jnz .lookup_7
.lookup_2:
	movq $0, %rcx
	movq %rdx, %r9
	addq %rcx, %r9
	movl (%r9), %r9d
	movl $1, %ecx
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .lookup_5
.lookup_3:
	movq $8, %r8
	movq %rdx, %r9
	addq %r8, %r9
	movq (%r9), %r9
	movq $0, %r8
	addq %r8, %r9
	movl (%r9), %r8d
	movq %rsi, %r9
	movl %r8d, (%r9)
	movl $0, %eax
	addq $8, %rsp
	ret
.lookup_5:
.lookup_6:
	movq $8, %rcx
	movq %rdx, %r9
	addq %rcx, %r9
	movq (%r9), %r9
	movq $8, %rcx
	addq %rcx, %r9
	movq (%r9), %r9
.lookup_8:
	movq %r9, %rdx
	jmp .lookup_1
.lookup_7:
	movl $0, %eax
	subl $1, %eax
	addq $8, %rsp
	ret
_c0_insert:
	addq $-40, %rsp
	movq %r14, 8(%rsp)
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
	movl %edx, %r9d
	movl %ecx, %r8d
.insert_0:
.insert_9:
	movq %rdi, %rdx
	movq %rsi, %rbx
.insert_1:
	movq $0, %rcx
	cmpq %rcx, %rbx
	jnz .ternary_true3
	movl $0, %ecx
	jmp .ternary_end4
.ternary_true3:
	movq $0, %rsi
	movq %rbx, %rcx
	addq %rsi, %rcx
	movl (%rcx), %ecx
	cmpl %r9d, %ecx
	setle %cl
	movzbl %cl, %ecx
.ternary_end4:
	movl $1, %esi
	cmpl %ecx, %esi
	jnz .insert_7
.insert_2:
	movq $0, %rdx
	movq %rbx, %rcx
	addq %rdx, %rcx
	movl (%rcx), %ecx
	movl $1, %edx
	cmpl %r9d, %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %edx
	jnz .insert_5
.insert_3:
	movq $8, %rcx
	movq %rbx, %r9
	addq %rcx, %r9
	movq (%r9), %r9
	movq $0, %rcx
	addq %rcx, %r9
	movl %r8d, (%r9)
	movl $0, %eax
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.insert_5:
.insert_6:
	movq $8, %rdx
	movq %rbx, %rcx
	addq %rdx, %rcx
	movq (%rcx), %rcx
	movq %rcx, %rsi
	movq $8, %rdx
	movq %rsi, %rcx
	addq %rdx, %rcx
	movq (%rcx), %rcx
.insert_8:
	movq %rsi, %rdx
	movq %rcx, %rbx
	jmp .insert_1
.insert_7:
	movq $1, %rdi
	movq $16, %rsi
	movq %rdx, %r14
	movq %r8, %r13
	movq %r9, %r12
	callq calloc
	movq %r14, %rdx
	movq %r13, %r8
	movq %r12, %r9
	movq %rax, %rcx
	movq $0, %rdi
	movq %rcx, %rsi
	addq %rdi, %rsi
	movl %r8d, (%rsi)
	movq $8, %rsi
	movq %rcx, %r8
	addq %rsi, %r8
	movq %rbx, (%r8)
	movq $1, %rdi
	movq $16, %rsi
	movq %rdx, %r13
	movq %rcx, %r12
	movq %r9, %rbx
	callq calloc
	movq %r13, %rdx
	movq %r12, %rcx
	movq %rbx, %r9
	movq $0, %r8
	movq %rax, %rsi
	addq %r8, %rsi
	movl %r9d, (%rsi)
	movq $8, %r8
	movq %rax, %r9
	addq %r8, %r9
	movq %rcx, (%r9)
	movq $8, %r8
	movq %rdx, %r9
	addq %r8, %r9
	movq %rax, (%r9)
	movl $1, %eax
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
.main_0:
	movq $1, %rdi
	movq $4, %rsi
	callq calloc
	movq %rax, %r9
	movq $1, %rdi
	movq $16, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movq %rax, %r8
	movq $8, %rcx
	movq %r8, %rdx
	addq %rcx, %rdx
	movq $0, (%rdx)
	movq $8, %rdx
	movq %r8, %rcx
	addq %rdx, %rcx
	movq (%rcx), %rcx
	movq %r8, %rdi
	movq %rcx, %rsi
	movl $2, %edx
	movl $3, %ecx
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r12, %r8
	movq %rbx, %r9
	movq $8, %rcx
	movq %r8, %rdx
	addq %rcx, %rdx
	movq (%rdx), %rcx
	movq %r8, %rdi
	movq %rcx, %rsi
	movl $6, %edx
	movl $7, %ecx
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r12, %r8
	movq %rbx, %r9
	movq $8, %rdx
	movq %r8, %rcx
	addq %rdx, %rcx
	movq (%rcx), %rcx
	movq %r8, %rdi
	movq %rcx, %rsi
	movl $4, %edx
	movl $5, %ecx
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r12, %r8
	movq %rbx, %r9
	movq $8, %rcx
	movq %r8, %rdx
	addq %rcx, %rdx
	movq (%rdx), %rcx
	movq %r8, %rdi
	movq %rcx, %rsi
	movl $8, %edx
	movl $9, %ecx
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r12, %r8
	movq %rbx, %r9
	movq $8, %rcx
	addq %rcx, %r8
	movq (%r8), %r8
	movq %r8, %rdi
	movl $6, %esi
	movq %r9, %rdx
	movq %r9, %rbx
	callq _c0_lookup
	movq %rbx, %r9
	movl (%r9), %r9d
	movl %r9d, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
