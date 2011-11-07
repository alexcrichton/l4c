.file	"../tests2/saltopus-goldbach.l3"
.globl _c0_main
_c0_sqroot_sub:
	addq $-8, %rsp
	movl %edi, %r9d
	movl %edx, %ecx
.sqroot_sub_0:
	movl $1, %edi
	movl $0, %edx
	movl %esi, %r8d
	cmpl %edx, %r8d
	setne %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edi
	jnz .sqroot_sub_6
.sqroot_sub_1:
	movl %ecx, %edi
	xorl %esi, %edi
	movl $1, %eax
	movl %edi, %edx
	imull %edi, %edx
	movl %r9d, %r8d
	cmpl %edx, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %eax
	jnz .sqroot_sub_3
.sqroot_sub_2:
	movl %edi, %r8d
	xorl %esi, %r8d
.sqroot_sub_9:
.sqroot_sub_4:
	movl $2, %ecx
	movl %esi, %eax
	cltd
	idivl %ecx
	movl %r9d, %edi
	movl %eax, %esi
	movl %r8d, %edx
	callq _c0_sqroot_sub
	addq $8, %rsp
	ret
.sqroot_sub_3:
.sqroot_sub_8:
	movl %edi, %r8d
	jmp .sqroot_sub_4
.sqroot_sub_6:
.sqroot_sub_7:
	movl %ecx, %eax
	addq $8, %rsp
	ret
_c0_sqroot:
	addq $-8, %rsp
.sqroot_0:
	movl $1, %esi
	sall $15, %esi
	movl $0, %edx
	callq _c0_sqroot_sub
	addq $8, %rsp
	ret
_c0_prime:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movl %edi, %r9d
.prime_0:
	movl $2, %r8d
	movl %r9d, %eax
	cltd
	idivl %r8d
	movl %edx, %r8d
	movl $1, %edx
	movl $0, %ecx
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .prime_3
.prime_1:
	movl $0, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.prime_3:
.prime_4:
	movl %r9d, %edi
	movq %r9, %rbx
	callq _c0_sqroot
	movq %rbx, %r9
	movl %eax, %r8d
	movl $3, %ecx
.prime_13:
.prime_5:
	movl $1, %esi
	movl %ecx, %edx
	cmpl %r8d, %edx
	setle %dl
	movzbl %dl, %edx
	cmpl %edx, %esi
	jnz .prime_11
.prime_6:
	movl %r9d, %eax
	cltd
	idivl %ecx
	movl $1, %edi
	movl $0, %esi
	cmpl %esi, %edx
	sete %dl
	movzbl %dl, %edx
	cmpl %edx, %edi
	jnz .prime_9
.prime_7:
	movl $0, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.prime_9:
.prime_10:
	addl $2, %ecx
.prime_12:
	jmp .prime_5
.prime_11:
	movl $1, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_goldbach:
	addq $-56, %rsp
	movq %rbp, 8(%rsp)
	movq %r15, 16(%rsp)
	movq %r14, 24(%rsp)
	movq %r13, 32(%rsp)
	movq %r12, 40(%rsp)
	movq %rbx, 48(%rsp)
.goldbach_0:
	movl $2, %edx
.goldbach_16:
	movl %edx, %ebx
.goldbach_1:
	movl $1, %edx
	movl $1, %edi
	cmpl %edi, %edx
	jnz .goldbach_14
.goldbach_2:
	movl %ebx, %edx
	subl $1, %edx
.goldbach_18:
.goldbach_3:
	movl $1, %eax
	movl $0, %edi
	cmpl %edx, %edi
	setl %dil
	movzbl %dil, %edi
	cmpl %edi, %eax
	jnz .goldbach_20
.goldbach_4:
	movl %edx, %edi
	movq %rsi, %rbp
	movq %rdx, %r15
	movq %rcx, %r14
	movq %r8, %r13
	movq %r9, %r12
	callq _c0_prime
	movq %rbp, %rsi
	movq %r15, %rdx
	movq %r14, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movl %eax, %r12d
	cmpl $0, %r12d
	jnz .ternary_true1
	movl $0, %eax
	jmp .ternary_end2
.ternary_true1:
	movl %ebx, %edi
	subl %edx, %edi
	movq %rsi, %rbp
	movq %rdx, %r15
	movq %r8, %r14
	movq %r9, %r13
	callq _c0_prime
	movq %rbp, %rsi
	movq %r15, %rdx
	movq %r14, %r8
	movq %r13, %r9
	movl %eax, %ecx
	movl %ecx, %eax
.ternary_end2:
	movl $1, %edi
	cmpl %eax, %edi
	jnz .goldbach_7
.goldbach_5:
	jmp .goldbach_19
.goldbach_7:
.goldbach_8:
	subl $1, %edx
.goldbach_17:
	movl %ecx, %esi
	movl %r12d, %r8d
	movl %eax, %r9d
	jmp .goldbach_3
.goldbach_20:
.goldbach_9:
	movl $1, %eax
	movl $0, %edi
	cmpl %edi, %edx
	setle %dl
	movzbl %dl, %edx
	cmpl %edx, %eax
	jnz .goldbach_12
.goldbach_10:
	movl $0, %eax
	movq 8(%rsp), %rbp
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
.goldbach_12:
.goldbach_13:
	movl %ebx, %edx
	addl $2, %edx
.goldbach_15:
	movl %edx, %ebx
	jmp .goldbach_1
.goldbach_14:
	movl $1, %eax
	movq 8(%rsp), %rbp
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
.goldbach_19:
	jmp .goldbach_9
_c0_main:
	addq $-8, %rsp
.main_0:
	callq _c0_goldbach
	movl %eax, %edi
	callq booltoint
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
