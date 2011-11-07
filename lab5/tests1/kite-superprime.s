.file	"../tests1/kite-superprime.l4"
.globl _c0_main
_c0_main:
	addq $-152, %rsp
	movq %rbp, 16(%rsp)
	movq %r15, 24(%rsp)
	movq %r14, 32(%rsp)
	movq %r13, 40(%rsp)
	movq %r12, 48(%rsp)
	movq %rbx, 56(%rsp)
.main_0:
	movq $10000, %rdi
	movq $4, %rsi
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %rbx
	callq calloc
	movq %rbp, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movq %rax, %r13
	movq $10000, %rdi
	movq $4, %rsi
	movq %rcx, 64(%rsp)
	movq %r8, %rbp
	movq %r9, %rbx
	callq calloc
	movq 64(%rsp), %rcx
	movq %rbp, %r8
	movq %rbx, %r9
	movq %rax, %rbp
	movl $0, %edx
	movl $0, 112(%rsp)
	movq $10001, %rdi
	movq $4, %rsi
	movq %rdx, 72(%rsp)
	movq %rcx, 80(%rsp)
	movq %r8, 88(%rsp)
	movq %r9, %rbx
	callq calloc
	movq 72(%rsp), %rdx
	movq 80(%rsp), %rcx
	movq 88(%rsp), %r8
	movq %rbx, %r9
	movq %rax, %rbx
	movq $10001, %rdi
	movq $4, %rsi
	movq %rdx, 96(%rsp)
	movq %rcx, 72(%rsp)
	movq %r8, 80(%rsp)
	movq %r9, 88(%rsp)
	callq calloc
	movq 96(%rsp), %rdx
	movq 72(%rsp), %rcx
	movq 80(%rsp), %r8
	movq 88(%rsp), %r9
	movq %rax, %rsi
	movq %rsi, 104(%rsp)
	movq %rdx, 96(%rsp)
	movq %rcx, 72(%rsp)
	movq %r8, 80(%rsp)
	movq %r9, 88(%rsp)
	callq readint
	movq 104(%rsp), %rsi
	movq 96(%rsp), %rdx
	movq 72(%rsp), %rcx
	movq 80(%rsp), %r8
	movq 88(%rsp), %r9
	movl %eax, 116(%rsp)
	movl $2, %edi
.main_41:
	movl %edi, 120(%rsp)
	movl %edx, 124(%rsp)
.main_1:
	movl $1, %eax
	movl $10000, %edi
	movl 120(%rsp), %edx
	cmpl %edi, %edx
	setle %dl
	movzbl %dl, %edx
	cmpl %edx, %eax
	jnz .main_13
.main_2:
	movl $1, 128(%rsp)
	movl $2, %edx
.main_43:
	movl %edx, %edi
.main_3:
	movl $1, %eax
	movl %edi, %edx
	imull %edi, %edx
	cmpl 120(%rsp), %edx
	setle %dl
	movzbl %dl, %edx
	cmpl %edx, %eax
	jnz .main_45
.main_4:
	movl 120(%rsp), %eax
	cltd
	idivl %edi
	movl %edx, 132(%rsp)
	movl $1, 136(%rsp)
	movl $0, %edx
	movl 132(%rsp), %eax
	cmpl %edx, %eax
	sete %al
	movzbl %al, %eax
	cmpl %eax, 136(%rsp)
	jnz .main_7
.main_5:
	movl $0, %r15d
	jmp .main_44
.main_7:
.main_8:
	movl %edi, %edx
	addl $1, %edx
.main_42:
	movl 132(%rsp), %r12d
	movl %edx, %edi
	jmp .main_3
.main_45:
	movl 128(%rsp), %edx
.main_9:
	movl $1, %eax
	movl $1, %edi
	cmpl %edi, %edx
	sete %dl
	movzbl %dl, %edx
	cmpl %edx, %eax
	jnz .main_11
.main_10:
	movl 124(%rsp), %edx
	imull $4, %edx
	movslq %edx, %rdi
	movq %r13, %rdx
	addq %rdi, %rdx
	movl 120(%rsp), %r10d
	movl %r10d, (%rdx)
	movl 124(%rsp), %edx
	addl $1, %edx
.main_47:
	movl %edx, %edi
.main_12:
	movl 120(%rsp), %edx
	addl $1, %edx
.main_40:
	movl %edx, 120(%rsp)
	movl %edi, 124(%rsp)
	jmp .main_1
.main_11:
.main_46:
	movl 124(%rsp), %edi
	jmp .main_12
.main_13:
	movl $0, %edx
.main_49:
	movl %edx, 128(%rsp)
	movl 112(%rsp), %r10d
	movl %r10d, 140(%rsp)
.main_14:
	movl 128(%rsp), %edx
	imull $4, %edx
	movslq %edx, %rdi
	movq %r13, %rdx
	addq %rdi, %rdx
	movl (%rdx), %edx
	movl $1, %edi
	cmpl 124(%rsp), %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %edi
	jnz .main_16
.main_15:
	movl 128(%rsp), %edx
	imull $4, %edx
	movslq %edx, %rdi
	movq %r13, %rdx
	addq %rdi, %rdx
	movl (%rdx), %edx
	subl $1, %edx
	imull $4, %edx
	movslq %edx, %rdi
	movq %r13, %rdx
	addq %rdi, %rdx
	movl (%rdx), %eax
	movl 140(%rsp), %edx
	imull $4, %edx
	movslq %edx, %rdi
	movq %rbp, %rdx
	addq %rdi, %rdx
	movl %eax, (%rdx)
	movl 140(%rsp), %edi
	addl $1, %edi
	movl 128(%rsp), %edx
	addl $1, %edx
.main_48:
	movl %edx, 128(%rsp)
	movl %edi, 140(%rsp)
	jmp .main_14
.main_16:
	movl $0, %edx
.main_51:
	movl %edx, %edi
.main_17:
	movl $1, %eax
	movl %edi, %edx
	cmpl 140(%rsp), %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %eax
	jnz .main_29
.main_18:
	movl %edi, %edx
	imull $4, %edx
	movslq %edx, %rdi
	movq %rbp, %rdx
	addq %rdi, %rdx
	movl (%rdx), %edx
	movl %edx, 144(%rsp)
	movl 144(%rsp), %edx
.main_54:
	movl %edx, 148(%rsp)
.main_19:
	movl $1, %edi
	movl 148(%rsp), %edx
	cmpl 116(%rsp), %edx
	setle %dl
	movzbl %dl, %edx
	cmpl %edx, %edi
	jnz .main_28
.main_20:
	movl 148(%rsp), %r10d
	cmpl %r10d, 144(%rsp)
	jl .ternary_true1
	movl $0, 136(%rsp)
	jmp .ternary_end2
.ternary_true1:
	movl 148(%rsp), %ecx
	subl 144(%rsp), %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %rbx, %rcx
	addq %rdx, %rcx
	movl (%rcx), %ecx
	movl $0, %edx
	movl %ecx, 136(%rsp)
	cmpl %edx, 136(%rsp)
	sete %r11b
	movzbl %r11b, %r11d
	movl %r11d, 136(%rsp)
.ternary_end2:
	movl $1, %edx
	cmpl 136(%rsp), %edx
	jnz .main_23
.main_21:
	movl 148(%rsp), %edx
	addl $1, %edx
	jmp .main_53
.main_23:
.main_24:
	movl 148(%rsp), %edx
	imull $4, %edx
	movslq %edx, %rdi
	movq %rbx, %rdx
	addq %rdi, %rdx
	movl (%rdx), %r10d
	movl %r10d, 128(%rsp)
	movl $0, %edx
	cmpl %edx, 128(%rsp)
	jz .ternary_true3
	movl 148(%rsp), %r8d
	subl 144(%rsp), %r8d
	imull $4, %r8d
	movslq %r8d, %rdx
	movq %rbx, %r8
	addq %rdx, %r8
	movl (%r8), %r14d
	movl 148(%rsp), %r8d
	imull $4, %r8d
	movslq %r8d, %rdx
	movq %rbx, %r8
	addq %rdx, %r8
	movl (%r8), %r8d
	movl $1, %edx
	addl %r14d, %edx
	movl %edx, %eax
	cmpl %r8d, %eax
	setl %al
	movzbl %al, %eax
	jmp .ternary_end4
.ternary_true3:
	movl $1, %eax
.ternary_end4:
	movl $1, %edx
	cmpl %eax, %edx
	jnz .main_26
.main_25:
	movl 148(%rsp), %r9d
	subl 144(%rsp), %r9d
	imull $4, %r9d
	movslq %r9d, %rdx
	movq %rbx, %r9
	addq %rdx, %r9
	movl (%r9), %edi
	movl 148(%rsp), %r9d
	imull $4, %r9d
	movslq %r9d, %rdx
	movq %rbx, %r9
	addq %rdx, %r9
	movl $1, (%r9)
	addl %edi, (%r9)
	movl 148(%rsp), %r9d
	imull $4, %r9d
	movslq %r9d, %rdx
	movq %rsi, %r9
	addq %rdx, %r9
	movl 148(%rsp), %r10d
	movl %r10d, (%r9)
	movl 144(%rsp), %r10d
	subl %r10d, (%r9)
.main_56:
.main_27:
	movl 148(%rsp), %edx
	addl $1, %edx
.main_52:
	movl %edi, %r9d
	movl %edx, 148(%rsp)
	jmp .main_19
.main_26:
.main_55:
	movl %r9d, %edi
	jmp .main_27
.main_28:
	movl 148(%rsp), %edx
	addl $1, %edx
.main_50:
	movl %edx, %edi
	jmp .main_17
.main_29:
	movl 116(%rsp), %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq %rbx, %r9
	addq %r8, %r9
	movl (%r9), %r9d
	movl %r9d, %edi
	movq %rsi, %r12
	callq printint
	movq %r12, %rsi
	movl $10, %edi
	movq %rsi, %r12
	callq printchar
	movq %r12, %rsi
	movl 116(%rsp), %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq %rbx, %r9
	addq %r8, %r9
	movl (%r9), %r9d
	movl $1, %ecx
	movl $0, %r8d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_32
.main_30:
	movl $0, %eax
	movq 16(%rsp), %rbp
	movq 24(%rsp), %r15
	movq 32(%rsp), %r14
	movq 40(%rsp), %r13
	movq 48(%rsp), %r12
	movq 56(%rsp), %rbx
	addq $152, %rsp
	ret
.main_32:
.main_33:
	movl $0, %r8d
	movl 116(%rsp), %r9d
.main_58:
	movl %r8d, %ecx
.main_34:
	movl $1, %edx
	movl $0, %r8d
	cmpl %r9d, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_39
.main_35:
	movl $1, %r8d
	cmpl %ecx, %r8d
	jnz .main_37
.main_36:
	movl $32, %edi
	movq %rsi, %r12
	movq %r9, %rbx
	callq printchar
	movq %r12, %rsi
	movq %rbx, %r9
	movslq %eax, %rcx
.main_60:
.main_38:
	movl $1, %r8d
	movl %r9d, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %rsi, %rcx
	addq %rdx, %rcx
	movl (%rcx), %ecx
	movl %r9d, %edi
	subl %ecx, %edi
	movq %rsi, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq printint
	movq %r13, %rsi
	movq %r12, %r8
	movq %rbx, %r9
	imull $4, %r9d
	movslq %r9d, %rcx
	movq %rsi, %r9
	addq %rcx, %r9
	movl (%r9), %r9d
.main_57:
	movl %r8d, %ecx
	jmp .main_34
.main_37:
.main_59:
	jmp .main_38
.main_39:
	movl $10, %edi
	callq printchar
	movl $0, %eax
	movq 16(%rsp), %rbp
	movq 24(%rsp), %r15
	movq 32(%rsp), %r14
	movq 40(%rsp), %r13
	movq 48(%rsp), %r12
	movq 56(%rsp), %rbx
	addq $152, %rsp
	ret
.main_53:
	movl %edx, 148(%rsp)
	jmp .main_19
.main_44:
	movl %r15d, %edx
	jmp .main_9
.ident	"15-411 L4 reference compiler"
