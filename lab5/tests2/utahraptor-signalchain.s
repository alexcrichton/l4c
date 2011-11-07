.file	"../tests2/utahraptor-signalchain.l4"
.globl _c0_main
_c0_chain:
	addq $-40, %rsp
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
	movq %rdi, %r9
	movl %esi, %r8d
.chain_0:
	movl $1, %ecx
	movl $0, %esi
	movl %r8d, %edx
	cmpl %esi, %edx
	setle %dl
	movzbl %dl, %edx
	cmpl %edx, %ecx
	jnz .chain_1
.chain_9:
	movl $1234, (%r9)
.chain_11:
	movl $0, %eax
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.chain_1:
	movq $1, %rdi
	movq $4, %rsi
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, %rcx
	movq %rcx, %rdi
	movl %r8d, %esi
	subl $1, %esi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_chain
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movq %r9, %rdi
	movl %r8d, %esi
	subl $1, %esi
	movq %rcx, %r12
	movq %r9, %rbx
	callq _c0_chain
	movq %r12, %rcx
	movq %rbx, %r9
	movq %rcx, %r8
	movl (%r8), %edi
	movq %r9, %r8
	movl (%r8), %esi
	movl $1, %edx
	movl %edi, %r8d
	cmpl %esi, %r8d
	setne %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .chain_4
.chain_2:
	movl $1, %eax
	movl $0, %r9d
	cltd
	idivl %r9d
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.chain_4:
.chain_5:
	movl $1, %edx
	movq %rcx, %r8
	cmpq %r9, %r8
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %edx
	jnz .chain_8
.chain_6:
	movl $1, %eax
	movl $0, %r9d
	cltd
	idivl %r9d
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.chain_8:
.chain_10:
	jmp .chain_11
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movq $1, %rdi
	movq $4, %rsi
	callq calloc
	movq %rax, %r9
	movq %r9, %rdi
	movl $23, %esi
	movq %r9, %rbx
	callq _c0_chain
	movq %rbx, %r9
	movl (%r9), %r9d
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
