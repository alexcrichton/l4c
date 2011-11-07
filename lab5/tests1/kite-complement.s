.file	"../tests1/kite-complement.l3"
.globl _c0_main
_c0_triv:
	addq $-8, %rsp
.triv_0:
	movl %edi, %ecx
	subl $1, %ecx
	movl $1, %r8d
	sall %cl, %r8d
	movl %edi, %eax
	imull %r8d, %eax
	addq $8, %rsp
	ret
_c0_nupto:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
	movl %edi, %edx
.nupto_0:
	movl $1, %r8d
	movl $1, %r9d
	movl %edx, %ecx
	cmpl %r9d, %ecx
	setle %cl
	movzbl %cl, %ecx
	cmpl %ecx, %r8d
	jnz .nupto_3
.nupto_1:
	movl %edx, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.nupto_3:
.nupto_4:
	movl $0, %ecx
	movl $0, %r9d
.nupto_12:
	movl %r9d, %r8d
	movl %ecx, %r9d
.nupto_5:
	movl $1, %esi
	movl $31, %ecx
	movl %r8d, %edi
	cmpl %ecx, %edi
	setl %dil
	movzbl %dil, %edi
	cmpl %edi, %esi
	jnz .nupto_10
.nupto_6:
	movl $1, %esi
	movl $1, %edi
	movl %r8d, %ecx
	sall %cl, %edi
	movl %edx, %ecx
	andl %edi, %ecx
	movl $0, %edi
	cmpl %edi, %ecx
	setne %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .nupto_8
.nupto_7:
	movl %r8d, %r9d
.nupto_14:
	movl %r9d, %ecx
.nupto_9:
	movl %r8d, %r9d
	addl $1, %r9d
.nupto_11:
	movl %r9d, %r8d
	movl %ecx, %r9d
	jmp .nupto_5
.nupto_8:
.nupto_13:
	movl %r9d, %ecx
	jmp .nupto_9
.nupto_10:
	movl $1, %esi
	movl %r9d, %ecx
	sall %cl, %esi
	movl %edx, %r8d
	subl %esi, %r8d
	movl %r8d, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_nupto
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %ecx
	movl %r9d, %edi
	movq %rcx, %r12
	movq %r8, %rbx
	callq _c0_triv
	movq %r12, %rcx
	movq %rbx, %r8
	movl %r8d, %r9d
	addl $1, %r9d
	addl %ecx, %r9d
	addl %eax, %r9d
	movl %r9d, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_main:
	addq $-72, %rsp
	movq %rbp, 16(%rsp)
	movq %r15, 24(%rsp)
	movq %r14, 32(%rsp)
	movq %r13, 40(%rsp)
	movq %r12, 48(%rsp)
	movq %rbx, 56(%rsp)
.main_0:
	movq %r8, %r13
	movq %r9, %r12
	callq readint
	movq %r13, %r8
	movq %r12, %r9
	movl %eax, %ecx
	movl $0, %edx
.main_11:
	movl %edx, %r13d
.main_1:
	movl $1, %esi
	movl %r13d, %edx
	cmpl %ecx, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %esi
	jnz .main_9
.main_2:
	movq %rcx, %r15
	movq %r8, %r14
	movq %r9, %r12
	callq readint
	movq %r15, %rcx
	movq %r14, %r8
	movq %r12, %r9
	movl %eax, %esi
	movq %rsi, %rbp
	movq %rcx, %r15
	movq %r8, %r14
	movq %r9, %r12
	callq readint
	movq %rbp, %rsi
	movq %r15, %rcx
	movq %r14, %r8
	movq %r12, %r9
	movl %eax, %r12d
	movl $0, %r14d
	movl $0, %edx
	cmpl %edx, %esi
	jl .ternary_true1
	movl %r12d, %edi
	cmpl %esi, %edi
	setl %dil
	movzbl %dil, %edi
	jmp .ternary_end2
.ternary_true1:
	movl $1, %edi
.ternary_end2:
	movl $1, %edx
	cmpl %edi, %edx
	jnz .main_3
.main_6:
	movl $1, %eax
	movl $0, %edi
	cltd
	idivl %edi
	movslq %eax, %rdx
.main_15:
	movl %r14d, %edx
.main_8:
	movl %edx, %edi
	movq %rsi, 64(%rsp)
	movq %rcx, %rbp
	movq %r8, %r15
	movq %r9, %r14
	callq printint
	movq 64(%rsp), %rsi
	movq %rbp, %rcx
	movq %r15, %r8
	movq %r14, %r9
	movl $10, %edi
	movq %rsi, 64(%rsp)
	movq %rcx, %rbp
	movq %r8, %r15
	movq %r9, %r14
	callq printchar
	movq 64(%rsp), %rsi
	movq %rbp, %rcx
	movq %r15, %r8
	movq %r14, %r9
	movl %r13d, %edx
	addl $1, %edx
.main_10:
	movl %edx, %r13d
	jmp .main_1
.main_3:
	movl $1, %eax
	movl $0, %edi
	movl %esi, %edx
	cmpl %edi, %edx
	sete %dl
	movzbl %dl, %edx
	cmpl %edx, %eax
	jnz .main_5
.main_4:
	movl %r12d, %edi
	movq %rsi, %rbp
	movq %rcx, %r15
	movq %r8, %r14
	movq %r9, %rbx
	callq _c0_nupto
	movq %rbp, %rsi
	movq %r15, %rcx
	movq %r14, %r8
	movq %rbx, %r9
	movl %eax, %edi
.main_13:
	movl %eax, %ebx
	movl %edi, %edx
.main_7:
.main_14:
	jmp .main_8
.main_5:
	movl %r12d, %edi
	movq %rsi, %r15
	movq %rcx, %r14
	callq _c0_nupto
	movq %r15, %rsi
	movq %r14, %rcx
	movl %eax, %r9d
	movl %esi, %edi
	subl $1, %edi
	movq %rsi, %rbp
	movq %rcx, %r15
	movq %r9, %r14
	callq _c0_nupto
	movq %rbp, %rsi
	movq %r15, %rcx
	movq %r14, %r9
	movl %r9d, %edx
	subl %eax, %edx
.main_12:
	movl %eax, %r8d
	jmp .main_7
.main_9:
	movl $0, %eax
	movq 16(%rsp), %rbp
	movq 24(%rsp), %r15
	movq 32(%rsp), %r14
	movq 40(%rsp), %r13
	movq 48(%rsp), %r12
	movq 56(%rsp), %rbx
	addq $72, %rsp
	ret
.ident	"15-411 L4 reference compiler"
