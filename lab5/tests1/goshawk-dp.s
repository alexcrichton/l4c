.file	"../tests1/goshawk-dp.l4"
.globl _c0_main
_c0_sum_rect:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
	movq %rdi, %r9
	movl %r8d, %r12d
.sum_rect_0:
	movl %ecx, %r8d
	imull $8, %r8d
	movslq %r8d, %rdi
	movq %r9, %r8
	addq %rdi, %r8
	movq (%r8), %rax
	movl %r12d, %r8d
	imull $4, %r8d
	movslq %r8d, %rdi
	movq %rax, %r8
	addq %rdi, %r8
	movl (%r8), %ebx
	movl $0, %r8d
	cmpl %r8d, %esi
	jz .ternary_true1
	movl %esi, %r8d
	subl $1, %r8d
	imull $8, %r8d
	movslq %r8d, %rdi
	movq %r9, %r8
	addq %rdi, %r8
	movq (%r8), %rax
	movl %r12d, %r8d
	imull $4, %r8d
	movslq %r8d, %rdi
	movq %rax, %r8
	addq %rdi, %r8
	movl (%r8), %r8d
	movl %r8d, %eax
	jmp .ternary_end2
.ternary_true1:
	movl $0, %eax
.ternary_end2:
	movl $0, %r8d
	cmpl %r8d, %edx
	jz .ternary_true3
	movl %ecx, %r8d
	imull $8, %r8d
	movslq %r8d, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %rdi
	movl %edx, %r8d
	subl $1, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl (%r8), %r8d
	movl %r8d, %edi
	jmp .ternary_end4
.ternary_true3:
	movl $0, %edi
.ternary_end4:
	movl $0, %r8d
	cmpl %r8d, %esi
	jz .ternary_true7
	movl $0, %ecx
	movl %edx, %r8d
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	jmp .ternary_end8
.ternary_true7:
	movl $1, %r8d
.ternary_end8:
	cmpl $0, %r8d
	jnz .ternary_true5
	movl %esi, %r8d
	subl $1, %r8d
	imull $8, %r8d
	movslq %r8d, %r8
	addq %r8, %r9
	movq (%r9), %rcx
	movl %edx, %r9d
	subl $1, %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq %rcx, %r9
	addq %r8, %r9
	movl (%r9), %r9d
	jmp .ternary_end6
.ternary_true5:
	movl $0, %r9d
.ternary_end6:
	movl %ebx, %r8d
	subl %eax, %r8d
	subl %edi, %r8d
	movl %r8d, %eax
	addl %r9d, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_main:
	addq $-152, %rsp
	movq %rbp, 8(%rsp)
	movq %r15, 16(%rsp)
	movq %r14, 24(%rsp)
	movq %r13, 32(%rsp)
	movq %r12, 40(%rsp)
	movq %rbx, 48(%rsp)
.main_0:
	movq %rdx, %r14
	movq %r8, %r12
	callq readint
	movq %r14, %rdx
	movq %r12, %r8
	movl %eax, %ecx
	movq %rdx, 56(%rsp)
	movq %rcx, %r14
	movq %r8, %r12
	callq readint
	movq 56(%rsp), %rdx
	movq %r14, %rcx
	movq %r12, %r8
	movl %eax, %r12d
	movslq %ecx, %rdi
	movq $8, %rsi
	movq %rdx, 64(%rsp)
	movq %rcx, 56(%rsp)
	movq %r8, %r14
	callq calloc
	movq 64(%rsp), %rdx
	movq 56(%rsp), %rcx
	movq %r14, %r8
	movq %rax, 64(%rsp)
	movl $0, %r9d
.main_23:
	movl %r9d, %r14d
.main_1:
	movl $1, %esi
	movl %r14d, %r9d
	cmpl %ecx, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %esi
	jnz .main_3
.main_2:
	movl %r14d, %r9d
	imull $8, %r9d
	movslq %r9d, %rsi
	movq 64(%rsp), %r9
	addq %rsi, %r9
	movslq %r12d, %rdi
	movq $4, %rsi
	movq %rdx, 72(%rsp)
	movq %rcx, 80(%rsp)
	movq %r8, 88(%rsp)
	movq %r9, 56(%rsp)
	callq calloc
	movq 72(%rsp), %rdx
	movq 80(%rsp), %rcx
	movq 88(%rsp), %r8
	movq 56(%rsp), %r9
	movq %rax, (%r9)
	movl %r14d, %r9d
	addl $1, %r9d
.main_22:
	movl %r9d, %r14d
	jmp .main_1
.main_3:
	movl $0, %r9d
.main_25:
	movl %r9d, %esi
.main_4:
	movl $1, %r9d
	movl %esi, %edi
	cmpl %ecx, %edi
	setl %dil
	movzbl %dil, %edi
	cmpl %edi, %r9d
	jnz .main_9
.main_5:
	movl $0, %r9d
.main_27:
	movl %r9d, %edi
.main_6:
	movl $1, %eax
	movl %edi, %r9d
	cmpl %r12d, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %eax
	jnz .main_8
.main_7:
	movl %esi, %r9d
	imull $8, %r9d
	movslq %r9d, %rax
	movq 64(%rsp), %r9
	addq %rax, %r9
	movq (%r9), %r9
	movq %rdi, 96(%rsp)
	movq %rsi, 72(%rsp)
	movq %rdx, 80(%rsp)
	movq %rcx, 88(%rsp)
	movq %r8, 56(%rsp)
	movq %r9, %r14
	callq readint
	movq 96(%rsp), %rdi
	movq 72(%rsp), %rsi
	movq 80(%rsp), %rdx
	movq 88(%rsp), %rcx
	movq 56(%rsp), %r8
	movq %r14, %r9
	movl %eax, 128(%rsp)
	movl %edi, %eax
	imull $4, %eax
	movslq %eax, %r14
	movq %r9, %rax
	addq %r14, %rax
	movl 128(%rsp), %r10d
	movl %r10d, (%rax)
	addl $1, %edi
.main_26:
	jmp .main_6
.main_8:
	movl %esi, %r9d
	addl $1, %r9d
.main_24:
	movl %r9d, %esi
	jmp .main_4
.main_9:
	movslq %ecx, %rdi
	movq $8, %rsi
	movq %rdx, 88(%rsp)
	movq %rcx, 56(%rsp)
	movq %r8, %r14
	callq calloc
	movq 88(%rsp), %rdx
	movq 56(%rsp), %rcx
	movq %r14, %r8
	movq %rax, %r9
	movl $0, %esi
.main_29:
	movl %esi, %r14d
.main_10:
	movl $1, %edi
	movl %r14d, %esi
	cmpl %ecx, %esi
	setl %sil
	movzbl %sil, %esi
	cmpl %esi, %edi
	jnz .main_12
.main_11:
	movl %r14d, %esi
	imull $8, %esi
	movslq %esi, %rsi
	movq %r9, 56(%rsp)
	addq %rsi, 56(%rsp)
	movslq %r12d, %rdi
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
	movq 56(%rsp), %r11
	movq %rax, (%r11)
	movl %r14d, %esi
	addl $1, %esi
.main_28:
	movl %esi, %r14d
	jmp .main_10
.main_12:
	movl $0, %esi
.main_31:
	movl %esi, 132(%rsp)
.main_13:
	movl $1, %edi
	movl 132(%rsp), %esi
	cmpl %ecx, %esi
	setl %sil
	movzbl %sil, %esi
	cmpl %esi, %edi
	jnz .main_18
.main_14:
	movl $0, %esi
.main_33:
	movl %esi, 136(%rsp)
.main_15:
	movl $1, %edi
	movl 136(%rsp), %esi
	cmpl %r12d, %esi
	setl %sil
	movzbl %sil, %esi
	cmpl %esi, %edi
	jnz .main_17
.main_16:
	movl 132(%rsp), %esi
	imull $8, %esi
	movslq %esi, %rdi
	movq %r9, %rsi
	addq %rdi, %rsi
	movq (%rsi), %r10
	movq %r10, 96(%rsp)
	movl 132(%rsp), %esi
	imull $8, %esi
	movslq %esi, %rdi
	movq 64(%rsp), %rsi
	addq %rdi, %rsi
	movq (%rsi), %r10
	movq %r10, 72(%rsp)
	movl 136(%rsp), %esi
	imull $4, %esi
	movslq %esi, %rsi
	movq 72(%rsp), %rdi
	addq %rsi, %rdi
	movl (%rdi), %r10d
	movl %r10d, 140(%rsp)
	movl 136(%rsp), %esi
	imull $4, %esi
	movslq %esi, %rdi
	movq 96(%rsp), %rsi
	addq %rdi, %rsi
	movl 140(%rsp), %r10d
	movl %r10d, (%rsi)
	movl 132(%rsp), %esi
	imull $8, %esi
	movslq %esi, %rdi
	movq %r9, %rsi
	addq %rdi, %rsi
	movq (%rsi), %r10
	movq %r10, 80(%rsp)
	movl $0, %esi
	cmpl %esi, 132(%rsp)
	jz .ternary_true9
	movl 132(%rsp), %esi
	subl $1, %esi
	imull $8, %esi
	movslq %esi, %rdi
	movq %r9, %rsi
	addq %rdi, %rsi
	movq (%rsi), %rbp
	movl 136(%rsp), %esi
	imull $4, %esi
	movslq %esi, %rdi
	movq %rbp, %rsi
	addq %rdi, %rsi
	movl (%rsi), %r13d
	movl %r13d, 144(%rsp)
	jmp .ternary_end10
.ternary_true9:
	movl $0, 144(%rsp)
.ternary_end10:
	movl 136(%rsp), %esi
	imull $4, %esi
	movslq %esi, %rsi
	movq 80(%rsp), %rax
	addq %rsi, %rax
	movl 136(%rsp), %esi
	imull $4, %esi
	movslq %esi, %rdi
	movq 80(%rsp), %rsi
	addq %rdi, %rsi
	movl (%rsi), %esi
	movl %esi, (%rax)
	movl 144(%rsp), %r10d
	addl %r10d, (%rax)
	movl 132(%rsp), %esi
	imull $8, %esi
	movslq %esi, %rdi
	movq %r9, %rsi
	addq %rdi, %rsi
	movq (%rsi), %r10
	movq %r10, 56(%rsp)
	movl $0, %esi
	cmpl %esi, 136(%rsp)
	jz .ternary_true11
	movl 132(%rsp), %edx
	imull $8, %edx
	movslq %edx, %rsi
	movq %r9, %rdx
	addq %rsi, %rdx
	movq (%rdx), %rdx
	movl 136(%rsp), %esi
	subl $1, %esi
	imull $4, %esi
	movslq %esi, %rdi
	movq %rdx, %rsi
	addq %rdi, %rsi
	movl (%rsi), %r15d
	movl %r15d, %r14d
	jmp .ternary_end12
.ternary_true11:
	movl $0, %r14d
.ternary_end12:
	movl 136(%rsp), %esi
	imull $4, %esi
	movslq %esi, %rsi
	movq 56(%rsp), %rax
	addq %rsi, %rax
	movl 136(%rsp), %esi
	imull $4, %esi
	movslq %esi, %rdi
	movq 56(%rsp), %rsi
	addq %rdi, %rsi
	movl (%rsi), %esi
	movl %esi, (%rax)
	addl %r14d, (%rax)
	movl 132(%rsp), %esi
	imull $8, %esi
	movslq %esi, %rdi
	movq %r9, %rsi
	addq %rdi, %rsi
	movq (%rsi), %rax
	movl $0, %esi
	cmpl %esi, 132(%rsp)
	jz .ternary_true15
	movl $0, %esi
	movl 136(%rsp), %edi
	cmpl %esi, %edi
	sete %dil
	movzbl %dil, %edi
	jmp .ternary_end16
.ternary_true15:
	movl $1, %edi
.ternary_end16:
	cmpl $0, %edi
	jnz .ternary_true13
	movl 132(%rsp), %r8d
	subl $1, %r8d
	imull $8, %r8d
	movslq %r8d, %rsi
	movq %r9, %r8
	addq %rsi, %r8
	movq (%r8), %rbx
	movl 136(%rsp), %r8d
	subl $1, %r8d
	imull $4, %r8d
	movslq %r8d, %rsi
	movq %rbx, %r8
	addq %rsi, %r8
	movl (%r8), %r8d
	movl %r8d, %esi
	jmp .ternary_end14
.ternary_true13:
	movl $0, %esi
.ternary_end14:
	movl 136(%rsp), %r10d
	movl %r10d, 148(%rsp)
	movl 148(%rsp), %r11d
	imull $4, %r11d
	movl %r11d, 148(%rsp)
	movl 148(%rsp), %r10d
	movslq %r10d, %r10
	movq %r10, 104(%rsp)
	movq %rax, 112(%rsp)
	movq 104(%rsp), %r10
	addq %r10, 112(%rsp)
	movl 136(%rsp), %r10d
	movl %r10d, 148(%rsp)
	movl 148(%rsp), %r11d
	imull $4, %r11d
	movl %r11d, 148(%rsp)
	movl 148(%rsp), %r10d
	movslq %r10d, %r10
	movq %r10, 120(%rsp)
	movq %rax, 104(%rsp)
	movq 120(%rsp), %r10
	addq %r10, 104(%rsp)
	movq 104(%rsp), %r10
	movl (%r10), %r10d
	movl %r10d, 148(%rsp)
	movl 148(%rsp), %r10d
	movq 112(%rsp), %r11
	movl %r10d, (%r11)
	movq 112(%rsp), %r11
	subl %esi, (%r11)
	addl $1, 136(%rsp)
.main_32:
	jmp .main_15
.main_17:
	movl 132(%rsp), %esi
	addl $1, %esi
.main_30:
	movl %esi, 132(%rsp)
	jmp .main_13
.main_18:
.main_19:
	movq %r9, %rbx
	callq eof
	movq %rbx, %r9
	movl $1, %edx
	movl $1, %r8d
	xorl %eax, %r8d
	cmpl %r8d, %edx
	jnz .main_21
.main_20:
	movq %r9, %rbx
	callq readint
	movq %rbx, %r9
	movl %eax, %edx
	movq %rdx, %r12
	movq %r9, %rbx
	callq readint
	movq %r12, %rdx
	movq %rbx, %r9
	movl %eax, %r8d
	movq %rdx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq readint
	movq %r13, %rdx
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %ecx
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq readint
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movq %r9, %rdi
	movl %edx, %esi
	movl %r8d, %edx
	movl %eax, %r8d
	movq %r9, %rbx
	callq _c0_sum_rect
	movq %rbx, %r9
	movl %eax, %edi
	movq %r9, %rbx
	callq printint
	movq %rbx, %r9
	movl $10, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	jmp .main_19
.main_21:
	movl $0, %eax
	movq 8(%rsp), %rbp
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $152, %rsp
	ret
.ident	"15-411 L4 reference compiler"
