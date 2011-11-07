.file	"../tests2/dilophosaurus-guess.l3"
.globl _c0_main
_c0_sgn:
	addq $-8, %rsp
.sgn_0:
	movl $1, %edx
	movl $0, %ecx
	movl %edi, %r8d
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .sgn_3
.sgn_1:
	movl $0, %eax
	addq $8, %rsp
	ret
.sgn_3:
.sgn_4:
	movl $1, %ecx
	movl $0, %r8d
	cmpl %edi, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .sgn_6
.sgn_5:
	movl $1, %eax
	addq $8, %rsp
	ret
.sgn_6:
	movl $0, %eax
	subl $1, %eax
	addq $8, %rsp
	ret
_c0_guess:
	addq $-8, %rsp
.guess_0:
	movl $42, %r8d
	subl %edi, %r8d
	movl %r8d, %edi
	callq _c0_sgn
	addq $8, %rsp
	ret
_c0_main:
	addq $-56, %rsp
	movq %rbp, 8(%rsp)
	movq %r15, 16(%rsp)
	movq %r14, 24(%rsp)
	movq %r13, 32(%rsp)
	movq %r12, 40(%rsp)
	movq %rbx, 48(%rsp)
.main_0:
	movl $0, %edx
	movl $1000, %ecx
	movl $0, %esi
	subl $1, %esi
	movl $0, %r8d
	subl $1, %r8d
	movl $0, %r9d
.main_15:
	movl %r8d, %edi
	movl %esi, %r8d
	movl %edx, %esi
.main_1:
	movl $1, %eax
	movl $1, %edx
	xorl %r9d, %edx
	cmpl %edx, %eax
	jnz .main_13
.main_2:
	movl %esi, %eax
	addl %ecx, %eax
	movl $2, %ebx
	cltd
	idivl %ebx
	movl %eax, %edx
	movl $1, %eax
	cmpl %edx, %edi
	sete %dil
	movzbl %dil, %edi
	cmpl %edi, %eax
	jnz .main_5
.main_3:
	movl %edx, %eax
	movq 8(%rsp), %rbp
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
.main_5:
.main_6:
	movl %edx, %ebx
	movl %edx, %edi
	movq %rsi, %rbp
	movq %rdx, %r15
	movq %rcx, %r14
	movq %r8, %r13
	movq %r9, %r12
	callq _c0_guess
	movq %rbp, %rsi
	movq %r15, %rdx
	movq %r14, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movl %eax, %r13d
	movl $1, %r12d
	movl $0, %eax
	movl %r13d, %edi
	cmpl %eax, %edi
	sete %dil
	movzbl %dil, %edi
	cmpl %edi, %r12d
	jnz .main_7
.main_10:
	movl $1, %r9d
.main_19:
	movl %r9d, %edi
	movl %esi, %eax
.main_12:
.main_14:
	movl %edi, %r9d
	movl %ebx, %edi
	movl %edx, %r8d
	movl %eax, %esi
	jmp .main_1
.main_7:
	movl $1, %edi
	movl $1, %r12d
	movl %r13d, %eax
	cmpl %r12d, %eax
	sete %al
	movzbl %al, %eax
	cmpl %eax, %edi
	jnz .main_9
.main_8:
	movl %edx, %edi
.main_17:
	movl %edi, %eax
.main_11:
.main_18:
	movl %r9d, %edi
	jmp .main_12
.main_9:
	movl %edx, %ecx
.main_16:
	movl %esi, %eax
	jmp .main_11
.main_13:
	movl %r8d, %eax
	movq 8(%rsp), %rbp
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
.ident	"15-411 L4 reference compiler"
