.file	"../tests2/dilophosaurus-primes.l3"
.globl _c0_main
_c0_isPrime:
	addq $-8, %rsp
.isPrime_0:
	movl $2, %r8d
.isPrime_9:
	movl %r8d, %ecx
.isPrime_1:
	movl $2, %r8d
	movl %edi, %eax
	cltd
	idivl %r8d
	movl $1, %esi
	movl %eax, %edx
	addl $1, %edx
	movl %ecx, %r8d
	cmpl %edx, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %esi
	jnz .isPrime_7
.isPrime_2:
	movl %edi, %eax
	cltd
	idivl %ecx
	movl %edx, %r8d
	movl $1, %esi
	movl $0, %edx
	cmpl %edx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %esi
	jnz .isPrime_5
.isPrime_3:
	movl $0, %eax
	addq $8, %rsp
	ret
.isPrime_5:
.isPrime_6:
	movl %ecx, %r8d
	addl $1, %r8d
.isPrime_8:
	movl %r8d, %ecx
	jmp .isPrime_1
.isPrime_7:
	movl $1, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-40, %rsp
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
.main_0:
	movl $2, %ecx
	movl $0, %r8d
	movl $0, %r9d
.main_8:
.main_1:
	movl $1, %edi
	movl $100, %esi
	movl %r9d, %edx
	cmpl %esi, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %edi
	jnz .main_6
.main_2:
	movl %ecx, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_isPrime
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $1, %edx
	cmpl %eax, %edx
	jnz .main_4
.main_3:
	addl %ecx, %r8d
	addl $1, %r9d
.main_10:
	movl %r8d, %edx
.main_5:
	addl $1, %ecx
.main_7:
	movl %edx, %r8d
	jmp .main_1
.main_4:
.main_9:
	movl %r8d, %edx
	jmp .main_5
.main_6:
	movl %r8d, %eax
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.ident	"15-411 L4 reference compiler"
