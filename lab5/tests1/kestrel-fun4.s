.file	"../tests1/kestrel-fun4.l3"
.globl _c0_main
_c0_is_prime:
	addq $-8, %rsp
.is_prime_0:
	movl $2, %r8d
.is_prime_9:
	movl %r8d, %ecx
.is_prime_1:
	movl $2, %r8d
	movl %edi, %eax
	cltd
	idivl %r8d
	movl $1, %edx
	movl %ecx, %r8d
	cmpl %eax, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .is_prime_7
.is_prime_2:
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
	jnz .is_prime_5
.is_prime_3:
	movl $0, %eax
	addq $8, %rsp
	ret
.is_prime_5:
.is_prime_6:
	movl %ecx, %r8d
	addl $1, %r8d
.is_prime_8:
	movl %r8d, %ecx
	jmp .is_prime_1
.is_prime_7:
	movl $1, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
.main_0:
	movl $0, %r8d
	movl $2, %r9d
.main_8:
.main_1:
	movl $1, %esi
	movl $1000, %edx
	movl %r9d, %ecx
	cmpl %edx, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .main_6
.main_2:
	movl %r9d, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_is_prime
	movq %r12, %r8
	movq %rbx, %r9
	cmpl $0, %eax
	jnz .ternary_true1
	movl $0, %edx
	jmp .ternary_end2
.ternary_true1:
	movl %r8d, %edx
	cmpl %r9d, %edx
	setl %dl
	movzbl %dl, %edx
.ternary_end2:
	movl $1, %ecx
	cmpl %edx, %ecx
	jnz .main_4
.main_3:
	movl %r9d, %r8d
.main_10:
	movl %r8d, %ecx
.main_5:
	addl $1, %r9d
.main_7:
	movl %ecx, %r8d
	jmp .main_1
.main_4:
.main_9:
	movl %r8d, %ecx
	jmp .main_5
.main_6:
	movl %r8d, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
