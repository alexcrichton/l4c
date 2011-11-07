.file	"../tests1/kestrel-fun2.l3"
.globl _c0_main
_c0_collatz:
	addq $-8, %rsp
	movl %esi, %r8d
.collatz_0:
	movl $1, %ecx
	movl $1, %esi
	movl %edi, %edx
	cmpl %esi, %edx
	sete %dl
	movzbl %dl, %edx
	cmpl %edx, %ecx
	jnz .collatz_2
.collatz_1:
	movl %r8d, %eax
	addq $8, %rsp
	ret
.collatz_2:
	movl $2, %ecx
	movl %edi, %eax
	cltd
	idivl %ecx
	movl %edx, %ecx
	movl $1, %edx
	movl $0, %esi
	cmpl %esi, %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %edx
	jnz .collatz_4
.collatz_3:
	movl $2, %ecx
	movl %edi, %eax
	cltd
	idivl %ecx
	movl %eax, %edi
	movl %r8d, %esi
	addl $1, %esi
	callq _c0_collatz
	addq $8, %rsp
	ret
.collatz_4:
	movl $3, %ecx
	imull %edi, %ecx
	movl %ecx, %edi
	addl $1, %edi
	movl %r8d, %esi
	addl $1, %esi
	callq _c0_collatz
	addq $8, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $27, %edi
	movl $0, %esi
	callq _c0_collatz
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
