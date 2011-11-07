.file	"../tests1/sparrowhawk-exception03.l3"
.globl _c0_main
_c0_factorial:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movl %edi, %r9d
.factorial_0:
	movl $1, %edx
	movl $0, %r8d
	movl %r9d, %ecx
	cmpl %r8d, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %edx
	jnz .factorial_3
.factorial_1:
	movl $1, %eax
	movl $0, %r9d
	cltd
	idivl %r9d
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.factorial_3:
.factorial_4:
	movl $1, %edx
	movl $2, %ecx
	movl %r9d, %r8d
	cmpl %ecx, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .factorial_7
.factorial_5:
	movl $1, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.factorial_7:
.factorial_8:
	movl %r9d, %edi
	subl $1, %edi
	movq %r9, %rbx
	callq _c0_factorial
	movq %rbx, %r9
	imull %eax, %r9d
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %edi
	subl $1, %edi
	callq _c0_factorial
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
