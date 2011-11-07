.file	"../tests1/hobby-function-calls.l3"
.globl _c0_main
_c0_even:
	addq $-8, %rsp
	movl %edi, %eax
.even_0:
	movl $2, %r9d
	cltd
	idivl %r9d
	movl $0, %r8d
	movl %edx, %eax
	cmpl %r8d, %eax
	sete %al
	movzbl %al, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
.main_0:
	movl $0, %r8d
	movl $0, %r9d
.main_8:
.main_1:
	movl $1, %esi
	movl $20, %edx
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
	callq _c0_even
	movq %r12, %r8
	movq %rbx, %r9
	movl $1, %edx
	movl $1, %ecx
	xorl %eax, %ecx
	cmpl %ecx, %edx
	jnz .main_4
.main_3:
	addl %r9d, %r8d
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
