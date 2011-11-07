.file	"../tests2/utahraptor-recSearch.l4"
.globl _c0_main
_c0_binsearch:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
	movq %rdi, %r9
	movl %esi, %r8d
.binsearch_0:
	movl $1, %edx
	movq $0, %rcx
	movq %r9, %rsi
	cmpq %rcx, %rsi
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %edx
	jnz .binsearch_3
.binsearch_1:
	movl $0, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.binsearch_3:
.binsearch_4:
	movq $16, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movl (%rcx), %esi
	movl $1, %edx
	movl %r8d, %ecx
	cmpl %esi, %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %edx
	jnz .binsearch_7
.binsearch_5:
	movl $1, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.binsearch_7:
.binsearch_8:
	movq $0, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movq (%rcx), %rcx
	movq %rcx, %rdi
	movl %r8d, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_binsearch
	movq %r12, %r8
	movq %rbx, %r9
	movl $1, %ecx
	cmpl %eax, %ecx
	jnz .binsearch_11
.binsearch_9:
	movl $1, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.binsearch_11:
.binsearch_12:
	movq $8, %rcx
	addq %rcx, %r9
	movq (%r9), %r9
	movq %r9, %rdi
	movl %r8d, %esi
	callq _c0_binsearch
	movl $1, %r8d
	cmpl %eax, %r8d
	jnz .binsearch_15
.binsearch_13:
	movl $1, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.binsearch_15:
.binsearch_16:
	movl $0, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_asserter:
	addq $-8, %rsp
.asserter_0:
	cmpl $0, %edi
	jnz .ternary_true1
	movl $1, %eax
	movl $0, %r9d
	cltd
	idivl %r9d
	movl %eax, %r9d
	jmp .ternary_end2
.ternary_true1:
	movl $0, %r9d
.ternary_end2:
	movl %r9d, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
.main_0:
	movq $1, %rdi
	movq $20, %rsi
	callq calloc
	movq %rax, %r9
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq $1, %rdi
	movq $20, %rsi
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, (%r8)
	movq $8, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq $1, %rdi
	movq $20, %rsi
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, (%r8)
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movq $0, %rcx
	addq %rcx, %r8
	movq $1, %rdi
	movq $20, %rsi
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, (%r8)
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movq $8, %rcx
	addq %rcx, %r8
	movq $1, %rdi
	movq $20, %rsi
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, (%r8)
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movq $8, %rcx
	addq %rcx, %r8
	movq (%r8), %r8
	movq $0, %rcx
	addq %rcx, %r8
	movq $1, %rdi
	movq $20, %rsi
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, (%r8)
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movq $8, %rcx
	addq %rcx, %r8
	movq (%r8), %r8
	movq $0, %rcx
	addq %rcx, %r8
	movq (%r8), %r8
	movq $16, %rcx
	addq %rcx, %r8
	movl $3, (%r8)
	movq %r9, %rdi
	movl $3, %esi
	movq %r9, %rbx
	callq _c0_binsearch
	movq %rbx, %r9
	movl %eax, %edi
	movq %r9, %rbx
	callq _c0_asserter
	movq %rbx, %r9
	movq %r9, %rdi
	movl $2, %esi
	callq _c0_binsearch
	movl $1, %edi
	xorl %eax, %edi
	callq _c0_asserter
	movl $0, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
