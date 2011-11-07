.file	"../tests2/velociraptor-linked-list-basic.l4"
.globl _c0_main
_c0_main:
	addq $-40, %rsp
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
.main_0:
	movl $0, %r9d
	movq $1, %rdi
	movq $16, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movq %rax, %r8
	movq %r8, %rcx
.main_5:
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
	movq $16, %rsi
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
	movq $8, %rdx
	addq %rdx, %rcx
	movq (%rcx), %rcx
	addl $1, %r9d
.main_4:
	jmp .main_1
.main_3:
	movq $8, %rcx
	movq %r8, %r9
	addq %rcx, %r9
	movq (%r9), %r9
	movq $8, %r8
	addq %r8, %r9
	movq (%r9), %r9
	movq $8, %r8
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
