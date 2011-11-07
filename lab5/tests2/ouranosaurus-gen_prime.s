.file	"../tests2/ouranosaurus-gen_prime.l3"
.globl _c0_main
_c0_is_prime:
	addq $-8, %rsp
.is_prime_0:
	movl $2, %r8d
	movl %edi, %eax
	cltd
	idivl %r8d
	movl %edx, %ecx
	movl $1, %r8d
	movl $0, %edx
	cmpl %edx, %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %r8d
	jnz .is_prime_3
.is_prime_1:
	movl $0, %eax
	addq $8, %rsp
	ret
.is_prime_3:
.is_prime_4:
	movl $3, %r8d
.is_prime_13:
.is_prime_5:
	movl $1, %edx
	movl %r8d, %ecx
	imull %r8d, %ecx
	cmpl %edi, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %edx
	jnz .is_prime_11
.is_prime_6:
	movl %edi, %eax
	cltd
	idivl %r8d
	movl %edx, %ecx
	movl $1, %esi
	movl $0, %edx
	cmpl %edx, %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .is_prime_9
.is_prime_7:
	movl $0, %eax
	addq $8, %rsp
	ret
.is_prime_9:
.is_prime_10:
	addl $2, %r8d
.is_prime_12:
	jmp .is_prime_5
.is_prime_11:
	movl $1, %eax
	addq $8, %rsp
	ret
_c0_get_prime_helper:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
	movl %esi, %r9d
.get_prime_helper_0:
	movl %edi, %r8d
.get_prime_helper_9:
.get_prime_helper_1:
	movl %r8d, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_is_prime
	movq %r12, %r8
	movq %rbx, %r9
	movl $1, %esi
	movl $1, %ecx
	xorl %eax, %ecx
	cmpl %ecx, %esi
	jnz .get_prime_helper_3
.get_prime_helper_2:
	addl $2, %r8d
.get_prime_helper_8:
	jmp .get_prime_helper_1
.get_prime_helper_3:
	movl $1, %esi
	movl $0, %edx
	movl %r9d, %ecx
	cmpl %edx, %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .get_prime_helper_6
.get_prime_helper_4:
	movl %r8d, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.get_prime_helper_6:
.get_prime_helper_7:
	movl %r8d, %edi
	addl $2, %edi
	movl %r9d, %esi
	subl $1, %esi
	callq _c0_get_prime_helper
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_get_nth_prime:
	addq $-8, %rsp
.get_nth_prime_0:
	movl $1, %r9d
	movl $0, %ecx
	movl %edi, %r8d
	cmpl %ecx, %r8d
	setle %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %r9d
	jnz .get_nth_prime_2
.get_nth_prime_1:
	movl $0, %eax
	subl $1, %eax
	addq $8, %rsp
	ret
.get_nth_prime_2:
	movl $1, %ecx
	movl $1, %r8d
	movl %edi, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .get_nth_prime_4
.get_nth_prime_3:
	movl $2, %eax
	addq $8, %rsp
	ret
.get_nth_prime_4:
	movl $3, %r8d
	movl %edi, %esi
	subl $1, %esi
	movl %r8d, %edi
	callq _c0_get_prime_helper
	addq $8, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $12, %edi
	callq _c0_get_nth_prime
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
