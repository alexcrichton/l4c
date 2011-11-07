.file	"../tests2/dilophosaurus-binom.l3"
.globl _c0_main
_c0_fact:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movl %edi, %r9d
.fact_0:
	movl $1, %edx
	movl $2, %ecx
	movl %r9d, %r8d
	cmpl %ecx, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .fact_3
.fact_1:
	movl $1, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.fact_3:
.fact_4:
	movl %r9d, %edi
	subl $1, %edi
	movq %r9, %rbx
	callq _c0_fact
	movq %rbx, %r9
	imull %eax, %r9d
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_P:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
	movl %edi, %r9d
.P_0:
	movl %r9d, %edi
	movq %rsi, %r12
	movq %r9, %rbx
	callq _c0_fact
	movq %r12, %rsi
	movq %rbx, %r9
	movl %eax, %ecx
	movl %r9d, %edi
	subl %esi, %edi
	movq %rcx, %rbx
	callq _c0_fact
	movq %rbx, %rcx
	movl %eax, %r9d
	movl %ecx, %eax
	cltd
	idivl %r9d
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_C:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movl %esi, %r9d
.C_0:
	movl %r9d, %esi
	movq %r9, %rbx
	callq _c0_P
	movq %rbx, %r9
	movl %eax, %r8d
	movl %r9d, %edi
	movq %r8, %rbx
	callq _c0_fact
	movq %rbx, %r8
	movl %eax, %r9d
	movl %r8d, %eax
	cltd
	idivl %r9d
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_powerOf2:
	addq $-8, %rsp
	movl %edi, %ecx
.powerOf2_0:
	movl $1, %eax
	sall %cl, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-40, %rsp
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
.main_0:
	movl $0, %r8d
	movl $7, %r9d
	movl $0, %ecx
.main_5:
.main_1:
	movl $1, %esi
	movl %ecx, %edx
	cmpl %r9d, %edx
	setle %dl
	movzbl %dl, %edx
	cmpl %edx, %esi
	jnz .main_3
.main_2:
	movl %r9d, %edi
	movl %ecx, %esi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_C
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	addl %eax, %r8d
	addl $1, %ecx
.main_4:
	jmp .main_1
.main_3:
	movl %r9d, %edi
	movq %r8, %rbx
	callq _c0_powerOf2
	movq %rbx, %r8
	movl %r8d, %r9d
	subl %eax, %r9d
	movl %r9d, %eax
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.ident	"15-411 L4 reference compiler"
