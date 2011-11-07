.file	"../tests0/name-val-alias.l4"
.globl _c0_main
_c0_alias:
	addq $-8, %rsp
	movq %rdi, %r9
.alias_0:
	movq $8, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %rdi
	movq $8, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movq $8, %rcx
	addq %rcx, %r8
	movq (%r8), %r8
	movq $0, %rcx
	addq %rcx, %r8
	movl (%r8), %esi
	movq $0, %r8
	movq %rdi, %rdx
	addq %r8, %rdx
	movq $0, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl (%r8), %r8d
	movl %r8d, (%rdx)
	addl %esi, (%rdx)
	movq $0, %r8
	addq %r8, %r9
	movl (%r9), %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
_c0_your:
	addq $-8, %rsp
	movq %rdi, %r9
.your_0:
	movq $8, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %rdi
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl (%r8), %esi
	movq $0, %r8
	movq %rdi, %rdx
	addq %r8, %rdx
	movq $0, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl (%r8), %r8d
	movl %r8d, (%rdx)
	addl %esi, (%rdx)
	movq $0, %r8
	addq %r8, %r9
	movl (%r9), %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
_c0_pointer:
	addq $-8, %rsp
.pointer_0:
	movq $0, %r8
	movq %rdi, %r9
	addq %r8, %r9
	movl (%r9), %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
_c0_lolias:
	addq $-40, %rsp
	movq %r14, 8(%rsp)
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
	movq %rdi, %r8
	movq %rsi, %r9
.lolias_0:
	movq $8, %rcx
	movq %r8, %rsi
	addq %rcx, %rsi
	movq (%rsi), %rcx
	movq $0, %rsi
	addq %rsi, %rcx
	movl (%rcx), %ecx
	movq $8, %rdi
	movq %r9, %rsi
	addq %rdi, %rsi
	movq (%rsi), %rsi
	movq $0, %rdi
	addq %rdi, %rsi
	movl (%rsi), %esi
	movq %r8, %rdi
	movq %rsi, %r14
	movq %rdx, %r13
	movq %rcx, %r12
	movq %r9, %rbx
	callq _c0_alias
	movq %r14, %rsi
	movq %r13, %rdx
	movq %r12, %rcx
	movq %rbx, %r9
	movl %eax, %r8d
	movq %r9, %rdi
	movq %rsi, %r14
	movq %rdx, %r13
	movq %rcx, %r12
	movq %r8, %rbx
	callq _c0_your
	movq %r14, %rsi
	movq %r13, %rdx
	movq %r12, %rcx
	movq %rbx, %r8
	movl %eax, %r9d
	movq %rdx, %rdi
	movq %rsi, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_pointer
	movq %r14, %rsi
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	addl %esi, %ecx
	addl %r8d, %ecx
	movl %ecx, %r8d
	addl %r9d, %r8d
	movl %r8d, %r9d
	addl %eax, %r9d
	movl %r9d, %eax
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
	movq $16, %rsi
	callq calloc
	movq %rax, %r9
	movq $8, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq $1, %rdi
	movq $16, %rsi
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, (%r8)
	movq $8, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movq $8, %rcx
	addq %rcx, %r8
	movq $1, %rdi
	movq $4, %rsi
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, (%r8)
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl $1, (%r8)
	movq $8, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movq $0, %rcx
	addq %rcx, %r8
	movl $10, (%r8)
	movq $8, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movq $8, %rcx
	addq %rcx, %r8
	movq (%r8), %r8
	movq $0, %rcx
	addq %rcx, %r8
	movl $100, (%r8)
	movq $8, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %rdx
	movq $8, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %rcx
	movq $8, %r8
	addq %r8, %rcx
	movq (%rcx), %rsi
	movq %r9, %rdi
	movq %rdx, %r8
	movq %rsi, %rdx
	movq %r8, %rsi
	callq _c0_lolias
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
