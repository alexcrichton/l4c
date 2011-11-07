.file	"../tests2/diplodocus-binom.l3"
.globl _c0_main
_c0_factorial:
	addq $-8, %rsp
.factorial_0:
	movl $1, %r8d
	movl %edi, %r9d
.factorial_5:
	movl %r8d, %edx
	movl %r9d, %ecx
.factorial_1:
	movl $1, %r8d
	movl $0, %r9d
	cmpl %ecx, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %r8d
	jnz .factorial_3
.factorial_2:
	movl %edx, %r8d
	imull %ecx, %r8d
	movl %ecx, %r9d
	subl $1, %r9d
.factorial_4:
	movl %r8d, %edx
	movl %r9d, %ecx
	jmp .factorial_1
.factorial_3:
	movl %edx, %eax
	addq $8, %rsp
	ret
_c0_binom:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
	movl %edi, %r9d
.binom_0:
	movl %r9d, %edi
	movq %rsi, %r12
	movq %r9, %rbx
	callq _c0_factorial
	movq %r12, %rsi
	movq %rbx, %r9
	movl %eax, %ecx
	movl %r9d, %edi
	subl %esi, %edi
	movq %rsi, %r12
	movq %rcx, %rbx
	callq _c0_factorial
	movq %r12, %rsi
	movq %rbx, %rcx
	movl %eax, %r9d
	movl %esi, %edi
	movq %rcx, %r12
	movq %r9, %rbx
	callq _c0_factorial
	movq %r12, %rcx
	movq %rbx, %r9
	imull %eax, %r9d
	movl %ecx, %eax
	cltd
	idivl %r9d
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_main:
	addq $-40, %rsp
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
.main_0:
	movl $0, %r9d
	movl $7, %edi
	movl $4, %esi
	movq %r9, %rbx
	callq _c0_binom
	movq %rbx, %r9
	movl %eax, %r8d
	movl $4, %ecx
.main_9:
.main_1:
	movl $1, %edi
	movl $6, %esi
	movl %ecx, %edx
	cmpl %esi, %edx
	setle %dl
	movzbl %dl, %edx
	cmpl %edx, %edi
	jnz .main_3
.main_2:
	movl %ecx, %edi
	movl $3, %esi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_binom
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	addl %eax, %r9d
	addl $1, %ecx
.main_8:
	jmp .main_1
.main_3:
	movl $1, %ecx
	cmpl %r9d, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .main_6
.main_4:
	movl $1, %eax
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.main_6:
.main_7:
	movl $0, %eax
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.ident	"15-411 L4 reference compiler"
