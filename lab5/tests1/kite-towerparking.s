.file	"../tests1/kite-towerparking.l4"
.globl _c0_main
_c0_shift:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movq %rdi, %r9
	movq %r8, %rbx
.shift_0:
	movl $0, %r8d
.shift_11:
	movl %r8d, %eax
.shift_1:
	movl $1, %ecx
	movl %eax, %r8d
	cmpl %edx, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .shift_3
.shift_2:
	movl %eax, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl (%r8), %edi
	movl %eax, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rbx, %r8
	addq %rcx, %r8
	movl %edi, (%r8)
	movl %eax, %r8d
	addl $1, %r8d
.shift_10:
	movl %r8d, %eax
	jmp .shift_1
.shift_3:
	movl $0, %r8d
.shift_13:
	movl %r8d, %eax
.shift_4:
	movl $1, %ecx
	movl %eax, %r8d
	cmpl %edx, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .shift_9
.shift_5:
	movl $1, %ecx
	movl %eax, %r8d
	addl %esi, %r8d
	cmpl %edx, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .shift_7
.shift_6:
	movl %eax, %r8d
	addl %esi, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl (%r8), %edi
	movl %eax, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl %edi, (%r8)
.shift_15:
.shift_8:
	movl %eax, %r8d
	addl $1, %r8d
.shift_12:
	movl %r8d, %eax
	jmp .shift_4
.shift_7:
	movl %eax, %r8d
	addl %esi, %r8d
	subl %edx, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rbx, %r8
	addq %rcx, %r8
	movl (%r8), %ecx
	movl %eax, %r8d
	imull $4, %r8d
	movslq %r8d, %r8
	movq %r9, %rdi
	addq %r8, %rdi
	movl %ecx, (%rdi)
.shift_14:
	jmp .shift_8
.shift_9:
	movl $0, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_main:
	addq $-264, %rsp
	movq %rbp, 16(%rsp)
	movq %r15, 24(%rsp)
	movq %r14, 32(%rsp)
	movq %r13, 40(%rsp)
	movq %r12, 48(%rsp)
	movq %rbx, 56(%rsp)
.main_0:
	movq $50, %rdi
	movq $8, %rsi
	movq %rdx, 64(%rsp)
	movq %rcx, %r15
	movq %r8, %r13
	movq %r9, %r12
	callq calloc
	movq 64(%rsp), %rdx
	movq %r15, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movq %rax, %r12
	movl $0, %esi
.main_36:
	movl %esi, %r13d
.main_1:
	movl $1, %eax
	movl $50, %edi
	movl %r13d, %esi
	cmpl %edi, %esi
	setl %sil
	movzbl %sil, %esi
	cmpl %esi, %eax
	jnz .main_3
.main_2:
	movl %r13d, %esi
	imull $8, %esi
	movslq %esi, %rsi
	movq %r12, %r15
	addq %rsi, %r15
	movq $50, %rdi
	movq $4, %rsi
	movq %rdx, 72(%rsp)
	movq %rcx, 80(%rsp)
	movq %r8, 88(%rsp)
	movq %r9, 64(%rsp)
	callq calloc
	movq 72(%rsp), %rdx
	movq 80(%rsp), %rcx
	movq 88(%rsp), %r8
	movq 64(%rsp), %r9
	movq %rax, (%r15)
	movl %r13d, %esi
	addl $1, %esi
.main_35:
	movl %esi, %r13d
	jmp .main_1
.main_3:
	movq $50, %rdi
	movq $4, %rsi
	movq %rdx, 88(%rsp)
	movq %rcx, 64(%rsp)
	movq %r8, %r15
	movq %r9, %r13
	callq calloc
	movq 88(%rsp), %rdx
	movq 64(%rsp), %rcx
	movq %r15, %r8
	movq %r13, %r9
	movq %rax, %r13
	movq %rdx, 80(%rsp)
	movq %rcx, 88(%rsp)
	movq %r8, 64(%rsp)
	movq %r9, %r15
	callq readint
	movq 80(%rsp), %rdx
	movq 88(%rsp), %rcx
	movq 64(%rsp), %r8
	movq %r15, %r9
	movl %eax, %r15d
	movl $0, %esi
.main_38:
	movl %esi, 192(%rsp)
.main_4:
	movl $1, %edi
	movl 192(%rsp), %esi
	cmpl %r15d, %esi
	setl %sil
	movzbl %sil, %esi
	cmpl %esi, %edi
	jnz .main_34
.main_5:
	movq %rdx, 96(%rsp)
	movq %rcx, 72(%rsp)
	movq %r8, 80(%rsp)
	movq %r9, 88(%rsp)
	callq readint
	movq 96(%rsp), %rdx
	movq 72(%rsp), %rcx
	movq 80(%rsp), %r8
	movq 88(%rsp), %r9
	movl %eax, 196(%rsp)
	movq %rdx, 104(%rsp)
	movq %rcx, 96(%rsp)
	movq %r8, 72(%rsp)
	movq %r9, 80(%rsp)
	callq readint
	movq 104(%rsp), %rdx
	movq 96(%rsp), %rcx
	movq 72(%rsp), %r8
	movq 80(%rsp), %r9
	movl %eax, 200(%rsp)
	movl $0, %edi
	movl $0, %esi
.main_40:
	movl %edi, 204(%rsp)
.main_6:
	movl $1, %edi
	movl %esi, %eax
	cmpl 196(%rsp), %eax
	setl %al
	movzbl %al, %eax
	cmpl %eax, %edi
	jnz .main_14
.main_7:
	movl $0, %eax
.main_42:
	movl 208(%rsp), %edi
	movq 112(%rsp), %r10
	movq %r10, 96(%rsp)
	movl %eax, 212(%rsp)
.main_8:
	movl $1, 216(%rsp)
	movl 212(%rsp), %eax
	cmpl 200(%rsp), %eax
	setl %al
	movzbl %al, %eax
	cmpl %eax, 216(%rsp)
	jnz .main_13
.main_9:
	movl %esi, %eax
	imull $8, %eax
	movslq %eax, %rax
	movq %rax, 112(%rsp)
	movq %r12, %rax
	addq 112(%rsp), %rax
	movq (%rax), %r10
	movq %r10, 112(%rsp)
	movq %rdi, 120(%rsp)
	movq %rsi, 128(%rsp)
	movq %rdx, 136(%rsp)
	movq %rcx, 144(%rsp)
	movq %r8, 152(%rsp)
	movq %r9, 160(%rsp)
	callq readint
	movq 120(%rsp), %rdi
	movq 128(%rsp), %rsi
	movq 136(%rsp), %rdx
	movq 144(%rsp), %rcx
	movq 152(%rsp), %r8
	movq 160(%rsp), %r9
	movl %eax, 220(%rsp)
	movl 212(%rsp), %eax
	imull $4, %eax
	movslq %eax, %rax
	movq %rax, 160(%rsp)
	movq 112(%rsp), %rax
	addq 160(%rsp), %rax
	movl 220(%rsp), %r10d
	movl %r10d, (%rax)
	movl %esi, %eax
	imull $8, %eax
	movslq %eax, %rax
	movq %r12, 160(%rsp)
	addq %rax, 160(%rsp)
	movq 160(%rsp), %r10
	movq (%r10), %r10
	movq %r10, 128(%rsp)
	movl 212(%rsp), %eax
	imull $4, %eax
	movslq %eax, %rax
	movq 128(%rsp), %r10
	movq %r10, 160(%rsp)
	addq %rax, 160(%rsp)
	movq 160(%rsp), %r10
	movl (%r10), %r10d
	movl %r10d, 224(%rsp)
	movl $1, 208(%rsp)
	movl 204(%rsp), %eax
	cmpl 224(%rsp), %eax
	setl %al
	movzbl %al, %eax
	cmpl %eax, 208(%rsp)
	jnz .main_11
.main_10:
	movl %esi, %edi
	imull $8, %edi
	movslq %edi, %rax
	movq %r12, %rdi
	addq %rax, %rdi
	movq (%rdi), %rbx
	movl 212(%rsp), %edi
	imull $4, %edi
	movslq %edi, %rax
	movq %rbx, %rdi
	addq %rax, %rdi
	movl (%rdi), %eax
	movl %eax, %edi
.main_44:
	movl %eax, 228(%rsp)
	movq %rbx, 152(%rsp)
	movl %edi, 208(%rsp)
.main_12:
	movl 212(%rsp), %eax
	addl $1, %eax
.main_41:
	movl 228(%rsp), %edi
	movq 152(%rsp), %r10
	movq %r10, 96(%rsp)
	movl 224(%rsp), %r10d
	movl %r10d, 232(%rsp)
	movq 128(%rsp), %r10
	movq %r10, 168(%rsp)
	movl 220(%rsp), %r10d
	movl %r10d, 236(%rsp)
	movq 112(%rsp), %rbx
	movl %eax, 212(%rsp)
	movl 208(%rsp), %r10d
	movl %r10d, 204(%rsp)
	jmp .main_8
.main_11:
.main_43:
	movl %edi, 228(%rsp)
	movq 96(%rsp), %r10
	movq %r10, 152(%rsp)
	movl 204(%rsp), %r10d
	movl %r10d, 208(%rsp)
	jmp .main_12
.main_13:
	addl $1, %esi
.main_39:
	movl %edi, 208(%rsp)
	movq 96(%rsp), %r10
	movq %r10, 112(%rsp)
	jmp .main_6
.main_14:
	movl $1, %edi
	movl $0, %esi
.main_46:
	movl %esi, 228(%rsp)
	movl %edi, 240(%rsp)
.main_15:
	movl $1, %edi
	movl 240(%rsp), %esi
	cmpl 204(%rsp), %esi
	setle %sil
	movzbl %sil, %esi
	cmpl %esi, %edi
	jnz .main_33
.main_16:
	movl $0, %eax
.main_48:
	movl %edx, 220(%rsp)
	movq %r8, 128(%rsp)
	movq 176(%rsp), %r10
	movq %r10, 152(%rsp)
	movl %r14d, %edi
	movq %rcx, %r14
	movl 244(%rsp), %esi
	movl %ebp, %edx
	movl %eax, 212(%rsp)
	movl 228(%rsp), %eax
.main_17:
	movl $1, %ecx
	movl 212(%rsp), %r8d
	cmpl 196(%rsp), %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .main_56
.main_18:
	movl $0, 244(%rsp)
	movl $0, %edx
.main_50:
	movl 220(%rsp), %r8d
	movq 128(%rsp), %rcx
	movq 152(%rsp), %rsi
	movq %r14, 144(%rsp)
	movl %edx, 248(%rsp)
	movl %eax, 224(%rsp)
.main_19:
	movl $1, %eax
	movl 248(%rsp), %edx
	cmpl 200(%rsp), %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %eax
	jnz .main_27
.main_20:
	movl 212(%rsp), %edx
	imull $8, %edx
	movslq %edx, %rax
	movq %r12, %rdx
	addq %rax, %rdx
	movq (%rdx), %r10
	movq %r10, 152(%rsp)
	movl 248(%rsp), %edx
	imull $4, %edx
	movslq %edx, %rax
	movq 152(%rsp), %rdx
	addq %rax, %rdx
	movl (%rdx), %r14d
	movl $1, %eax
	movl %r14d, %edx
	cmpl 240(%rsp), %edx
	sete %dl
	movzbl %dl, %edx
	cmpl %edx, %eax
	jnz .main_25
.main_21:
	movl $2, %r9d
	movl 200(%rsp), %eax
	cltd
	idivl %r9d
	movl %eax, %r9d
	movl $1, %eax
	movl 248(%rsp), %edx
	cmpl %r9d, %edx
	setle %dl
	movzbl %dl, %edx
	cmpl %edx, %eax
	jnz .main_23
.main_22:
	movl $5, %r8d
	imull 248(%rsp), %r8d
	movl $20, %ecx
	imull 212(%rsp), %ecx
	movl %r8d, %edx
	addl %ecx, %edx
	movl 224(%rsp), %r8d
	addl %edx, %r8d
.main_52:
	movl %r8d, %ebp
.main_24:
	movl 212(%rsp), %r8d
	imull $8, %r8d
	movslq %r8d, %rcx
	movq %r12, %r8
	addq %rcx, %r8
	movq (%r8), %r10
	movq %r10, 184(%rsp)
	movq 184(%rsp), %rdi
	movl 248(%rsp), %esi
	movl 200(%rsp), %edx
	movq %r12, %rcx
	movq %r13, %r8
	movq %r9, 144(%rsp)
	callq _c0_shift
	movq 144(%rsp), %r9
	movslq %eax, %r8
.main_54:
	movq 184(%rsp), %rdx
	movq %r8, 128(%rsp)
	movl %r9d, 220(%rsp)
.main_26:
	addl $1, 248(%rsp)
.main_49:
	movl %eax, %r8d
	movq %rdx, %rcx
	movq 128(%rsp), %rsi
	movl 220(%rsp), %r10d
	movl %r10d, 252(%rsp)
	movl %r14d, %edi
	movq 152(%rsp), %r10
	movq %r10, 144(%rsp)
	movl %ebp, 224(%rsp)
	jmp .main_19
.main_23:
	movl 200(%rsp), %edx
	subl 248(%rsp), %edx
	movl $5, %eax
	imull %edx, %eax
	movl $20, %edx
	imull 212(%rsp), %edx
	addl %edx, %eax
	movl 224(%rsp), %edx
	addl %eax, %edx
.main_51:
	movl %edx, %ebp
	jmp .main_24
.main_25:
.main_53:
	movl %r8d, %eax
	movq %rcx, %rdx
	movq %rsi, 128(%rsp)
	movl 252(%rsp), %r10d
	movl %r10d, 220(%rsp)
	movl 224(%rsp), %ebp
	jmp .main_26
.main_27:
	movl $1, %eax
	movl $1, %r14d
	movl 244(%rsp), %edx
	cmpl %r14d, %edx
	sete %dl
	movzbl %dl, %edx
	cmpl %edx, %eax
	jnz .main_30
.main_28:
	jmp .main_55
.main_30:
.main_31:
	movl 212(%rsp), %eax
	addl $1, %eax
.main_47:
	movl %r8d, 220(%rsp)
	movq %rcx, 128(%rsp)
	movq %rsi, 152(%rsp)
	movq 144(%rsp), %r14
	movl 248(%rsp), %esi
	movl 244(%rsp), %edx
	movl %eax, 212(%rsp)
	movl 224(%rsp), %eax
	jmp .main_17
.main_56:
	movl 220(%rsp), %ebp
	movq 128(%rsp), %r8
	movq 152(%rsp), %rcx
	movl %edi, 256(%rsp)
	movq %r14, 144(%rsp)
	movl %esi, %edi
	movl %edx, 260(%rsp)
.main_32:
	movl 240(%rsp), %esi
	addl $1, %esi
.main_45:
	movl %ebp, %edx
	movq %rcx, 176(%rsp)
	movl 256(%rsp), %r14d
	movq 144(%rsp), %rcx
	movl %edi, 244(%rsp)
	movl 260(%rsp), %ebp
	movl %eax, 228(%rsp)
	movl %esi, 240(%rsp)
	jmp .main_15
.main_33:
	movl 228(%rsp), %edi
	movq %rdx, 96(%rsp)
	movq %rcx, 72(%rsp)
	movq %r8, 80(%rsp)
	movq %r9, 88(%rsp)
	callq printint
	movq 96(%rsp), %rdx
	movq 72(%rsp), %rcx
	movq 80(%rsp), %r8
	movq 88(%rsp), %r9
	movl $10, %edi
	movq %rdx, 96(%rsp)
	movq %rcx, 72(%rsp)
	movq %r8, 80(%rsp)
	movq %r9, 88(%rsp)
	callq printchar
	movq 96(%rsp), %rdx
	movq 72(%rsp), %rcx
	movq 80(%rsp), %r8
	movq 88(%rsp), %r9
	movl 192(%rsp), %esi
	addl $1, %esi
.main_37:
	movl %esi, 192(%rsp)
	jmp .main_4
.main_34:
	movl $0, %eax
	movq 16(%rsp), %rbp
	movq 24(%rsp), %r15
	movq 32(%rsp), %r14
	movq 40(%rsp), %r13
	movq 48(%rsp), %r12
	movq 56(%rsp), %rbx
	addq $264, %rsp
	ret
.main_55:
	movl %r8d, %ebp
	movq %rcx, %r8
	movq %rsi, %rcx
	movl %edi, 256(%rsp)
	movl 248(%rsp), %edi
	movl 244(%rsp), %r10d
	movl %r10d, 260(%rsp)
	movl 224(%rsp), %eax
	jmp .main_32
.ident	"15-411 L4 reference compiler"
