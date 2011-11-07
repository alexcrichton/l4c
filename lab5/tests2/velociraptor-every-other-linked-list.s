.file	"../tests2/velociraptor-every-other-linked-list.l4"
.globl _c0_main
_c0_every_other:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movq %rdi, %r9
.every_other_0:
	movl $1, %edx
	movq $0, %rcx
	movq %r9, %r8
	cmpq %rcx, %r8
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .every_other_3
.every_other_1:
	movq %r9, %rax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.every_other_3:
.every_other_4:
	movq $8, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movq %r8, %rsi
	movl $1, %edx
	movq $0, %rcx
	movq %rsi, %r8
	cmpq %rcx, %r8
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .every_other_6
.every_other_5:
	movq $0, %r8
.every_other_9:
.every_other_7:
	movq %r8, %rdi
	movq %r9, %rbx
	callq _c0_every_other
	movq %rbx, %r9
	movq $8, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq %rax, (%r8)
	movq %r9, %rax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.every_other_6:
	movq $8, %rcx
	movq %rsi, %r8
	addq %rcx, %r8
	movq (%r8), %r8
.every_other_8:
	jmp .every_other_7
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
	movq $0, %rsi
	movq %rcx, %rdx
	addq %rsi, %rdx
	movl %r9d, (%rdx)
	movq $8, %rdx
	movq %rcx, %r9
	addq %rdx, %r9
	movq $0, (%r9)
	movq %r8, %rdi
	callq _c0_every_other
	movq %rax, %r9
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
