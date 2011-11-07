.file	"../tests2/velociraptor-reverse-linked-list.l4"
.globl _c0_main
_c0_reverse:
	addq $-8, %rsp
.reverse_0:
	movq $8, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movq %r8, %rsi
	movq $16, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movq %r8, %rdx
	movq $8, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movq %rdx, (%r8)
	movq $16, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movq %rsi, (%r8)
	movl $1, %edx
	movq $0, %rcx
	movq %rsi, %r8
	cmpq %rcx, %r8
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .reverse_2
.reverse_1:
	movq %rdi, %rax
	addq $8, %rsp
	ret
.reverse_2:
	movq %rsi, %rdi
	callq _c0_reverse
	addq $8, %rsp
	ret
_c0_main:
	addq $-40, %rsp
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
.main_0:
	movl $0, %r9d
	movq $1, %rdi
	movq $24, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movq %rax, %r8
	movq %r8, %rsi
	movq $16, %rdx
	movq %r8, %rcx
	addq %rdx, %rcx
	movq $0, (%rcx)
.main_5:
	movq %rsi, %rcx
.main_1:
	movl $1, %edi
	movl $10, %esi
	movl %r9d, %edx
	cmpl %esi, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %edi
	jnz .main_3
.main_2:
	movq $0, %rsi
	movq %rcx, %rdx
	addq %rsi, %rdx
	movl %r9d, (%rdx)
	movq $1, %rdi
	movq $24, %rsi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movq $8, %rsi
	movq %rcx, %rdx
	addq %rsi, %rdx
	movq %rax, (%rdx)
	movq $16, %rsi
	movq %rax, %rdx
	addq %rsi, %rdx
	movq %rcx, (%rdx)
	movq $8, %rdx
	addq %rdx, %rcx
	movq (%rcx), %rcx
	addl $1, %r9d
.main_4:
	jmp .main_1
.main_3:
	movq $0, %rsi
	movq %rcx, %rdx
	addq %rsi, %rdx
	movl %r9d, (%rdx)
	movq $8, %rdx
	movq %rcx, %r9
	addq %rdx, %r9
	movq $0, (%r9)
	movq %r8, %rdi
	callq _c0_reverse
	movq %rax, %r9
	movq $8, %r8
	addq %r8, %r9
	movq (%r9), %r9
	movq $8, %r8
	addq %r8, %r9
	movq (%r9), %r9
	movq $8, %r8
	addq %r8, %r9
	movq (%r9), %r9
	movq $8, %r8
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
