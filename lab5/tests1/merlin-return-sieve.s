.file	"../tests1/merlin-return-sieve.l4"
.globl _c0_main
_c0_get_num_primes:
	addq $-8, %rsp
	movq %rdi, %r9
	movl %esi, %eax
.get_num_primes_0:
	movl $0, %ecx
	movl $0, %r8d
.get_num_primes_8:
	movl %r8d, %edi
	movl %ecx, %esi
.get_num_primes_1:
	movl $1, %ecx
	movl %edi, %r8d
	cmpl %eax, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .get_num_primes_6
.get_num_primes_2:
	movl %edi, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl (%r8), %edx
	movl $1, %ecx
	movl $0, %r8d
	cmpl %edx, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .get_num_primes_4
.get_num_primes_3:
	movl %esi, %r8d
	addl $1, %r8d
.get_num_primes_10:
	movl %r8d, %ecx
.get_num_primes_5:
	movl %edi, %r8d
	addl $1, %r8d
.get_num_primes_7:
	movl %r8d, %edi
	movl %ecx, %esi
	jmp .get_num_primes_1
.get_num_primes_4:
.get_num_primes_9:
	movl %esi, %ecx
	jmp .get_num_primes_5
.get_num_primes_6:
	movl %esi, %eax
	addq $8, %rsp
	ret
_c0_sieve:
	addq $-72, %rsp
	movq %rbp, 8(%rsp)
	movq %r15, 16(%rsp)
	movq %r14, 24(%rsp)
	movq %r13, 32(%rsp)
	movq %r12, 40(%rsp)
	movq %rbx, 48(%rsp)
.sieve_0:
	movl $0, %eax
.sieve_14:
	movl %eax, %r15d
.sieve_1:
	movl $1, 64(%rsp)
	movl %esi, %ebp
	subl $1, %ebp
	movl %r15d, %eax
	cmpl %ebp, %eax
	setl %al
	movzbl %al, %eax
	cmpl %eax, 64(%rsp)
	jnz .sieve_12
.sieve_2:
	movl %r15d, %eax
	imull $4, %eax
	movslq %eax, %rbp
	movq %rdi, %rax
	addq %rbp, %rax
	movl (%rax), %r10d
	movl %r10d, 64(%rsp)
	movl $1, %ebp
	movl $0, %eax
	cmpl 64(%rsp), %eax
	setl %al
	movzbl %al, %eax
	cmpl %eax, %ebp
	jnz .sieve_10
.sieve_3:
	movl %r15d, %eax
	addl $1, %eax
.sieve_16:
	movl %eax, %ebp
.sieve_4:
	movl $1, 64(%rsp)
	movl %ebp, %eax
	cmpl %esi, %eax
	setl %al
	movzbl %al, %eax
	cmpl %eax, 64(%rsp)
	jnz .sieve_9
.sieve_5:
	movl %ebp, %eax
	imull $4, %eax
	movslq %eax, %rax
	movq %rax, 56(%rsp)
	movq %rdi, %rax
	addq 56(%rsp), %rax
	movl (%rax), %r10d
	movl %r10d, 64(%rsp)
	movl $0, %eax
	cmpl 64(%rsp), %eax
	jl .ternary_true1
	movl $0, %eax
	jmp .ternary_end2
.ternary_true1:
	movl %ebp, %edx
	imull $4, %edx
	movslq %edx, %rax
	movq %rdi, %rdx
	addq %rax, %rdx
	movl (%rdx), %ebx
	movl %r15d, %edx
	imull $4, %edx
	movslq %edx, %rax
	movq %rdi, %rdx
	addq %rax, %rdx
	movl (%rdx), %r14d
	movl %ebx, %eax
	cltd
	idivl %r14d
	movl $0, 68(%rsp)
	movl %edx, %eax
	cmpl 68(%rsp), %eax
	sete %al
	movzbl %al, %eax
.ternary_end2:
	movl $1, 68(%rsp)
	cmpl %eax, 68(%rsp)
	jnz .sieve_7
.sieve_6:
	movl %ebp, %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq %rdi, %r9
	addq %r8, %r9
	movl $0, (%r9)
	subl $1, (%r9)
.sieve_8:
	addl $1, %ebp
.sieve_15:
	movl %edx, %r12d
	movl %r14d, %ecx
	movl %ebx, %r13d
	movl 64(%rsp), %r8d
	movl %eax, %r9d
	jmp .sieve_4
.sieve_7:
	jmp .sieve_8
.sieve_9:
.sieve_18:
.sieve_11:
	movl %r15d, %eax
	addl $1, %eax
.sieve_13:
	movl %eax, %r15d
	jmp .sieve_1
.sieve_10:
.sieve_17:
	jmp .sieve_11
.sieve_12:
	callq _c0_get_num_primes
	movq 8(%rsp), %rbp
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $72, %rsp
	ret
_c0_make_sieve:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movl %edi, %r9d
.make_sieve_0:
	movslq %r9d, %rdi
	movq $4, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movl $0, %r8d
.make_sieve_5:
	movl %r8d, %edx
.make_sieve_1:
	movl $1, %ecx
	movl %edx, %r8d
	cmpl %r9d, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .make_sieve_3
.make_sieve_2:
	movl %edx, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movl %edx, (%r8)
	addl $2, (%r8)
	movl %edx, %r8d
	addl $1, %r8d
.make_sieve_4:
	movl %r8d, %edx
	jmp .make_sieve_1
.make_sieve_3:
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movl $900, %r9d
	movl %r9d, %edi
	movq %r9, %rbx
	callq _c0_make_sieve
	movq %rbx, %r9
	movq %rax, %r8
	movq %r8, %rdi
	movl %r9d, %esi
	callq _c0_sieve
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
