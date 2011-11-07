.file	"../tests1/lammergeier-typhlosion.l3"
.globl _c0_main
_c0_collatz:
	addq $-8, %rsp
.collatz_0:
	movl $2, %r8d
	movl %edi, %eax
	cltd
	idivl %r8d
	movl %edx, %r8d
	movl $1, %edx
	movl $0, %ecx
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .collatz_3
.collatz_1:
	movl $2, %r8d
	movl %edi, %eax
	cltd
	idivl %r8d
	addq $8, %rsp
	ret
.collatz_3:
.collatz_4:
	movl $3, %r8d
	imull %edi, %r8d
	movl %r8d, %eax
	addl $1, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movl $2, %r9d
.main_8:
.main_1:
	movl $1, %ecx
	movl $1, %r8d
	cmpl %r8d, %ecx
	jnz .main_6
.main_2:
	movl %r9d, %r8d
.main_10:
	movl %r8d, %esi
.main_3:
	movl $1, %edx
	movl $1, %ecx
	movl %esi, %r8d
	cmpl %ecx, %r8d
	setne %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_5
.main_4:
	movl %esi, %edi
	movq %r9, %rbx
	callq _c0_collatz
	movq %rbx, %r9
	movl %eax, %r8d
.main_9:
	movl %r8d, %esi
	jmp .main_3
.main_5:
	addl $1, %r9d
.main_7:
	jmp .main_1
.main_6:
	movl $0, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
