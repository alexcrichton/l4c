.file	"../tests2/dilophosaurus-prime.l3"
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
	addq $-8, %rsp
.main_0:
	movl $50, %edi
	callq _c0_isPrime
	cmpl $0, %eax
	jnz .ternary_true3
	movl $99, %edi
	callq _c0_isPrime
	movl %eax, %r9d
	jmp .ternary_end4
.ternary_true3:
	movl $1, %r9d
.ternary_end4:
	cmpl $0, %r9d
	jnz .ternary_true1
	movl $42967, %edi
	callq _c0_isPrime
	movl %eax, %r9d
	jmp .ternary_end2
.ternary_true1:
	movl $1, %r9d
.ternary_end2:
	cmpl $0, %r9d
	jnz .ternary_true5
	movl $0, %r9d
	subl $1, %r9d
	jmp .ternary_end6
.ternary_true5:
	movl $42967, %r9d
.ternary_end6:
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
