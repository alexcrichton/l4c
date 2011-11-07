.file	"../tests2/ouranosaurus-check_prime.l3"
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
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $31, %edi
	callq _c0_is_prime
	movl $1, %r9d
	cmpl %eax, %r9d
	jnz .main_3
.main_1:
	movl $0, %eax
	addq $8, %rsp
	ret
.main_3:
.main_4:
	movl $0, %eax
	subl $1, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
