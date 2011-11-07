.file	"../tests1/kite-magic.l4"
.globl _c0_main
_c0_main:
	addq $-56, %rsp
	movq %r15, 16(%rsp)
	movq %r14, 24(%rsp)
	movq %r13, 32(%rsp)
	movq %r12, 40(%rsp)
	movq %rbx, 48(%rsp)
.main_0:
	callq readint
	movl %eax, %r9d
	movl %r9d, %ecx
	movl $2, %r8d
	movl %r9d, %eax
	cltd
	idivl %r8d
	movl %edx, %esi
	movl $1, %edx
	movl $0, %r8d
	cmpl %r8d, %esi
	sete %sil
	movzbl %sil, %esi
	cmpl %esi, %edx
	jnz .main_2
.main_1:
	movl %ecx, %r8d
	addl $1, %r8d
.main_17:
.main_3:
	movl %r8d, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq printint
	movq %r12, %r8
	movq %rbx, %r9
	movl $0, %ecx
.main_19:
.main_4:
	movl $1, %edx
	movl %r9d, %edi
	imull %r9d, %edi
	movl %ecx, %esi
	cmpl %edi, %esi
	setl %sil
	movzbl %sil, %esi
	cmpl %esi, %edx
	jnz .main_9
.main_5:
	movl %ecx, %eax
	cltd
	idivl %r9d
	movl %edx, %esi
	movl %ecx, %eax
	cltd
	idivl %r9d
	movl %eax, %edi
	movl $2, %edx
	cmpl %edx, %ecx
	jnz .ternary_true1
	movl $0, %edx
	jmp .ternary_end2
.ternary_true1:
	movl %esi, %eax
	addl %edi, %eax
	movl $2, %esi
	cltd
	idivl %esi
	movl $0, %esi
	cmpl %esi, %edx
	sete %dl
	movzbl %dl, %edx
.ternary_end2:
	movl $1, %esi
	cmpl %edx, %esi
	jnz .main_7
.main_6:
	movl $32, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq printchar
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %edx
	movslq %edx, %rsi
	movl %ecx, %edi
	addl $1, %edi
	movq %rsi, %r15
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq printint
	movq %r15, %rsi
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movslq %eax, %rdi
.main_21:
.main_8:
	addl $1, %ecx
.main_18:
	jmp .main_4
.main_7:
.main_20:
	jmp .main_8
.main_9:
	movl $10, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq printchar
	movq %r12, %r8
	movq %rbx, %r9
	addl $2, %r8d
	movl %r8d, %edi
	movq %r9, %rbx
	callq printint
	movq %rbx, %r9
	movl $0, %r8d
.main_23:
.main_10:
	movl $1, %esi
	movl %r9d, %edx
	imull %r9d, %edx
	movl %r8d, %ecx
	cmpl %edx, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .main_15
.main_11:
	movl %r8d, %eax
	cltd
	idivl %r9d
	movl %edx, %ecx
	movl %r8d, %eax
	cltd
	idivl %r9d
	movl %eax, %esi
	movl %ecx, %eax
	addl %esi, %eax
	movl $2, %ecx
	cltd
	idivl %ecx
	movl %edx, %ecx
	movl $1, %esi
	movl $1, %edx
	cmpl %edx, %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .main_13
.main_12:
	movl $32, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq printchar
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %ecx
	movslq %ecx, %rdx
	movl %r8d, %edi
	addl $1, %edi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq printint
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movslq %eax, %rsi
.main_25:
.main_14:
	addl $1, %r8d
.main_22:
	jmp .main_10
.main_13:
.main_24:
	jmp .main_14
.main_15:
	movl $10, %edi
	callq printchar
	movl $0, %eax
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
.main_2:
.main_16:
	movl %ecx, %r8d
	jmp .main_3
.ident	"15-411 L4 reference compiler"
