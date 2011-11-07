.file	"../tests1/kite-parse_eof.l3"
.globl _c0_main
_c0_term:
	addq $-56, %rsp
	movq %rbp, 8(%rsp)
	movq %r15, 16(%rsp)
	movq %r14, 24(%rsp)
	movq %r13, 32(%rsp)
	movq %r12, 40(%rsp)
	movq %rbx, 48(%rsp)
.term_0:
	callq readchar
	movl %eax, %r9d
	movl $0, %ebx
	movl $1, %r8d
	movl $48, %ecx
	movl %r9d, %edx
	cmpl %ecx, %edx
	sete %dl
	movzbl %dl, %edx
	cmpl %edx, %r8d
	jnz .term_4
.term_1:
	movq %r9, %r12
	callq readchar
	movq %r12, %r9
	movl %eax, %edx
	movl $1, %ecx
	movl $120, %r8d
	cmpl %r8d, %edx
	setne %dl
	movzbl %dl, %edx
	cmpl %edx, %ecx
	jnz .term_3
.term_2:
	movl $1, %eax
	movl $0, %r8d
	cltd
	idivl %r8d
.term_7:
	movq %r9, %r12
	callq readhex
	movq %r12, %r9
	movl %eax, %r8d
.term_38:
.term_9:
	movq %r8, %r13
	movq %r9, %r12
	callq readchar
	movq %r13, %r8
	movq %r12, %r9
	movl %eax, %ecx
	movl $0, %edi
	movq %rdi, %r15
	movq %rcx, %r14
	movq %r8, %r13
	movq %r9, %r12
	callq readchar
	movq %r15, %rdi
	movq %r14, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movl %eax, %edx
	movl $1, %r12d
	movl $48, %esi
	movl %edx, %eax
	cmpl %esi, %eax
	sete %al
	movzbl %al, %eax
	cmpl %eax, %r12d
	jnz .term_13
.term_10:
	movq %rdi, %rbp
	movq %rdx, %r15
	movq %rcx, %r14
	movq %r8, %r13
	movq %r9, %r12
	callq readchar
	movq %rbp, %rdi
	movq %r15, %rdx
	movq %r14, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movl %eax, %esi
	movl $1, %r12d
	movl $120, %eax
	cmpl %eax, %esi
	setne %sil
	movzbl %sil, %esi
	cmpl %esi, %r12d
	jnz .term_12
.term_11:
	movl $1, %eax
	movl $0, %r9d
	cltd
	idivl %r9d
.term_16:
	movq %rcx, %r12
	movq %r8, %rbx
	callq readhex
	movq %r12, %rcx
	movq %rbx, %r8
	movl %eax, %r9d
.term_42:
	movl %r9d, %esi
.term_18:
	movl $1, %edx
	movl $43, %edi
	movl %ecx, %r9d
	cmpl %edi, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %edx
	jnz .term_19
.term_29:
	movl %r8d, %r9d
	addl %esi, %r9d
.term_48:
.term_31:
	movq %rsi, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq readchar
	movq %r14, %rsi
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %edx
	movl $1, %eax
	movl $41, %edi
	cmpl %edi, %edx
	setne %dl
	movzbl %dl, %edx
	cmpl %edx, %eax
	jnz .term_33
.term_32:
	movl $1, %eax
	movl $0, %r8d
	cltd
	idivl %r8d
.term_34:
	movl %r9d, %eax
	movq 8(%rsp), %rbp
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
.term_33:
	jmp .term_34
.term_19:
	movl $1, %edi
	movl $45, %edx
	movl %ecx, %r9d
	cmpl %edx, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %edi
	jnz .term_20
.term_27:
	movl %r8d, %r9d
	subl %esi, %r9d
.term_46:
.term_30:
.term_47:
	jmp .term_31
.term_20:
	movl $1, %edi
	movl $42, %edx
	movl %ecx, %r9d
	cmpl %edx, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %edi
	jnz .term_21
.term_25:
	movl %r8d, %r9d
	imull %esi, %r9d
.term_44:
.term_28:
.term_45:
	jmp .term_30
.term_21:
	movl $1, %edi
	movl $47, %edx
	movl %ecx, %r9d
	cmpl %edx, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %edi
	jnz .term_22
.term_23:
	movl %r8d, %eax
	cltd
	idivl %esi
	movl %eax, %r9d
.term_26:
.term_43:
	jmp .term_28
.term_22:
	movl $1, %eax
	movl $0, %r9d
	cltd
	idivl %r9d
	movl $0, %eax
	movq 8(%rsp), %rbp
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
.term_12:
	jmp .term_16
.term_13:
	movl $1, %eax
	movl $40, %esi
	cmpl %esi, %edx
	sete %dl
	movzbl %dl, %edx
	cmpl %edx, %eax
	jnz .term_15
.term_14:
	movq %rdi, %r15
	movq %rcx, %r14
	movq %r8, %r13
	movq %r9, %r12
	callq _c0_term
	movq %r15, %rdi
	movq %r14, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movl %eax, %edx
.term_40:
.term_17:
.term_41:
	movl %edx, %esi
	jmp .term_18
.term_15:
	movl $1, %eax
	movl $0, %esi
	cltd
	idivl %esi
.term_39:
	movl %edi, %edx
	jmp .term_17
.term_3:
	jmp .term_7
.term_4:
	movl $1, %edx
	movl $40, %r8d
	movl %r9d, %ecx
	cmpl %r8d, %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %edx
	jnz .term_6
.term_5:
	movq %r9, %r12
	callq _c0_term
	movq %r12, %r9
	movl %eax, %r8d
.term_36:
.term_8:
.term_37:
	jmp .term_9
.term_6:
	movl $1, %eax
	movl $0, %r8d
	cltd
	idivl %r8d
.term_35:
	movl %ebx, %r8d
	jmp .term_8
_c0_main:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
.main_0:
	callq readint
	movl %eax, %r9d
	movl $0, %r8d
.main_8:
.main_1:
	movl $1, %edx
	movl %r8d, %ecx
	cmpl %r9d, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %edx
	jnz .main_6
.main_2:
	movq %r8, %r12
	movq %r9, %rbx
	callq readchar
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %ecx
	movl $1, %esi
	movl $40, %edx
	cmpl %edx, %ecx
	setne %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .main_4
.main_3:
	movl $1, %eax
	movl $0, %ecx
	cltd
	idivl %ecx
	movslq %eax, %rcx
.main_10:
.main_5:
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_term
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq printint
	movq %r12, %r8
	movq %rbx, %r9
	movl $10, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq printchar
	movq %r12, %r8
	movq %rbx, %r9
	movq %r8, %r12
	movq %r9, %rbx
	callq readchar
	movq %r12, %r8
	movq %rbx, %r9
	addl $1, %r8d
.main_7:
	jmp .main_1
.main_4:
.main_9:
	jmp .main_5
.main_6:
	movl $0, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
