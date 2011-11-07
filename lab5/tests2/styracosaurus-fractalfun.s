.file	"../tests2/styracosaurus-fractalfun.l4"
.globl _c0_main
_c0_fractalize:
	addq $-344, %rsp
	movq %rbp, 8(%rsp)
	movq %r15, 16(%rsp)
	movq %r14, 24(%rsp)
	movq %r13, 32(%rsp)
	movq %r12, 40(%rsp)
	movq %rbx, 48(%rsp)
	movq %rdi, 56(%rsp)
	movl %esi, 232(%rsp)
.fractalize_0:
	movq $1, %rdi
	movq $16, %rsi
	movq %rdx, 64(%rsp)
	movq %rcx, 72(%rsp)
	movq %r8, %rbp
	movq %r9, %r12
	callq calloc
	movq 64(%rsp), %rdx
	movq 72(%rsp), %rcx
	movq %rbp, %r8
	movq %r12, %r9
	movq %rax, %rbp
	movq $8, %rsi
	movq %rbp, %rdi
	addq %rsi, %rdi
	movl $1, (%rdi)
	movq $12, %rdi
	movq %rbp, %rsi
	addq %rdi, %rsi
	movl $1, (%rsi)
	movq $0, %rsi
	movq %rbp, %r12
	addq %rsi, %r12
	movq $1, %rdi
	movq $8, %rsi
	movq %rdx, 80(%rsp)
	movq %rcx, 88(%rsp)
	movq %r8, 64(%rsp)
	movq %r9, 72(%rsp)
	callq calloc
	movq 80(%rsp), %rdx
	movq 88(%rsp), %rcx
	movq 64(%rsp), %r8
	movq 72(%rsp), %r9
	movq %rax, (%r12)
	movq $0, %rdi
	movq %rbp, %rsi
	addq %rdi, %rsi
	movq (%rsi), %rdi
	movl $0, %esi
	imull $8, %esi
	movslq %esi, %rsi
	movq %rdi, %r12
	addq %rsi, %r12
	movq $1, %rdi
	movq $4, %rsi
	movq %rdx, 80(%rsp)
	movq %rcx, 88(%rsp)
	movq %r8, 64(%rsp)
	movq %r9, 72(%rsp)
	callq calloc
	movq 80(%rsp), %rdx
	movq 88(%rsp), %rcx
	movq 64(%rsp), %r8
	movq 72(%rsp), %r9
	movq %rax, (%r12)
	movq $0, %rdi
	movq %rbp, %rsi
	addq %rdi, %rsi
	movq (%rsi), %rdi
	movl $0, %esi
	imull $8, %esi
	movslq %esi, %rax
	movq %rdi, %rsi
	addq %rax, %rsi
	movq (%rsi), %rax
	movl $0, %esi
	imull $4, %esi
	movslq %esi, %rdi
	movq %rax, %rsi
	addq %rdi, %rsi
	movl $1, (%rsi)
	movl $0, %esi
.fractalize_26:
	movl %esi, 236(%rsp)
	movq %rbp, 96(%rsp)
.fractalize_1:
	movl $1, %edi
	movl 236(%rsp), %esi
	cmpl 232(%rsp), %esi
	setl %sil
	movzbl %sil, %esi
	cmpl %esi, %edi
	jnz .fractalize_24
.fractalize_2:
	movq $8, %rdi
	movq 96(%rsp), %rsi
	addq %rdi, %rsi
	movl (%rsi), %eax
	movq $8, %rdi
	movq 56(%rsp), %rsi
	addq %rdi, %rsi
	movl (%rsi), %esi
	movl %eax, %r12d
	imull %esi, %r12d
	movq $12, %rdi
	movq 96(%rsp), %rsi
	addq %rdi, %rsi
	movl (%rsi), %eax
	movq $12, %rdi
	movq 56(%rsp), %rsi
	addq %rdi, %rsi
	movl (%rsi), %esi
	movl %eax, %ebp
	imull %esi, %ebp
	movq $1, %rdi
	movq $16, %rsi
	movq %rdx, 80(%rsp)
	movq %rcx, 88(%rsp)
	movq %r8, 64(%rsp)
	movq %r9, 72(%rsp)
	callq calloc
	movq 80(%rsp), %rdx
	movq 88(%rsp), %rcx
	movq 64(%rsp), %r8
	movq 72(%rsp), %r9
	movq %rax, 72(%rsp)
	movq $8, %rdi
	movq 72(%rsp), %rsi
	addq %rdi, %rsi
	movl %r12d, (%rsi)
	movq $12, %rdi
	movq 72(%rsp), %rsi
	addq %rdi, %rsi
	movl %ebp, (%rsi)
	movq $0, %rsi
	movq 72(%rsp), %r10
	movq %r10, 64(%rsp)
	addq %rsi, 64(%rsp)
	movslq %ebp, %rdi
	movq $8, %rsi
	movq %rdx, 104(%rsp)
	movq %rcx, 112(%rsp)
	movq %r8, 80(%rsp)
	movq %r9, 88(%rsp)
	callq calloc
	movq 104(%rsp), %rdx
	movq 112(%rsp), %rcx
	movq 80(%rsp), %r8
	movq 88(%rsp), %r9
	movq 64(%rsp), %r11
	movq %rax, (%r11)
	movl $0, %esi
.fractalize_28:
	movl %esi, 240(%rsp)
.fractalize_3:
	movl $1, %edi
	movl 240(%rsp), %esi
	cmpl %ebp, %esi
	setl %sil
	movzbl %sil, %esi
	cmpl %esi, %edi
	jnz .fractalize_5
.fractalize_4:
	movq $0, %rdi
	movq 72(%rsp), %rsi
	addq %rdi, %rsi
	movq (%rsi), %r10
	movq %r10, 88(%rsp)
	movl 240(%rsp), %esi
	imull $8, %esi
	movslq %esi, %rsi
	movq 88(%rsp), %r10
	movq %r10, 80(%rsp)
	addq %rsi, 80(%rsp)
	movslq %r12d, %rdi
	movq $4, %rsi
	movq %rdx, 120(%rsp)
	movq %rcx, 128(%rsp)
	movq %r8, 104(%rsp)
	movq %r9, 112(%rsp)
	callq calloc
	movq 120(%rsp), %rdx
	movq 128(%rsp), %rcx
	movq 104(%rsp), %r8
	movq 112(%rsp), %r9
	movq 80(%rsp), %r11
	movq %rax, (%r11)
	movl 240(%rsp), %esi
	addl $1, %esi
.fractalize_27:
	movl %esi, 240(%rsp)
	jmp .fractalize_3
.fractalize_5:
	movl $0, %esi
.fractalize_30:
	movl %esi, 244(%rsp)
.fractalize_6:
	movq $12, %rdi
	movq 96(%rsp), %rsi
	addq %rdi, %rsi
	movl (%rsi), %r10d
	movl %r10d, 248(%rsp)
	movl $1, %edi
	movl 244(%rsp), %esi
	cmpl 248(%rsp), %esi
	setl %sil
	movzbl %sil, %esi
	cmpl %esi, %edi
	jnz .fractalize_23
.fractalize_7:
	movq $8, %rdi
	movq 96(%rsp), %rsi
	addq %rdi, %rsi
	movl (%rsi), %r10d
	movl %r10d, 252(%rsp)
	movq $12, %rdi
	movq 96(%rsp), %rsi
	addq %rdi, %rsi
	movl (%rsi), %r10d
	movl %r10d, 256(%rsp)
	movl 252(%rsp), %r10d
	movl %r10d, 260(%rsp)
	movl 256(%rsp), %r10d
	subl %r10d, 260(%rsp)
	movl $0, 264(%rsp)
.fractalize_32:
	movl 268(%rsp), %r10d
	movl %r10d, 272(%rsp)
	movl 276(%rsp), %r10d
	movl %r10d, 240(%rsp)
	movl 280(%rsp), %ebp
	movl 284(%rsp), %r12d
	movl %ecx, %eax
	movq 136(%rsp), %rdi
	movq %r8, %rsi
	movl 260(%rsp), %r10d
	movl %r10d, 288(%rsp)
	movl 264(%rsp), %r10d
	movl %r10d, 292(%rsp)
.fractalize_8:
	movq $8, %r8
	movq 96(%rsp), %r9
	addq %r8, %r9
	movl (%r9), %r10d
	movl %r10d, 296(%rsp)
	movl $1, %r8d
	movl 292(%rsp), %r9d
	cmpl 296(%rsp), %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %r8d
	jnz .fractalize_22
.fractalize_9:
	movq $0, %r8
	movq 96(%rsp), %r9
	addq %r8, %r9
	movq (%r9), %r10
	movq %r10, 144(%rsp)
	movl 244(%rsp), %r9d
	imull $8, %r9d
	movslq %r9d, %r8
	movq 144(%rsp), %r9
	addq %r8, %r9
	movq (%r9), %r10
	movq %r10, 136(%rsp)
	movl 292(%rsp), %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq 136(%rsp), %r9
	addq %r8, %r9
	movl (%r9), %r10d
	movl %r10d, 260(%rsp)
	movl $1, %ecx
	movl $1, %r8d
	movl 260(%rsp), %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .fractalize_20
.fractalize_10:
	movq $12, %r8
	movq 56(%rsp), %r9
	addq %r8, %r9
	movl (%r9), %r10d
	movl %r10d, 264(%rsp)
	movl 244(%rsp), %r10d
	movl %r10d, 300(%rsp)
	movl 264(%rsp), %r10d
	movl 300(%rsp), %r11d
	imull %r10d, %r11d
	movl %r11d, 300(%rsp)
	movq $8, %r8
	movq 56(%rsp), %r9
	addq %r8, %r9
	movl (%r9), %r10d
	movl %r10d, 268(%rsp)
	movl 292(%rsp), %r10d
	movl %r10d, 304(%rsp)
	movl 268(%rsp), %r10d
	movl 304(%rsp), %r11d
	imull %r10d, %r11d
	movl %r11d, 304(%rsp)
	movl $0, %r9d
.fractalize_34:
	movl 308(%rsp), %r10d
	movl %r10d, 312(%rsp)
	movq 152(%rsp), %r10
	movq %r10, 160(%rsp)
	movq %r15, 152(%rsp)
	movq %r13, %r12
	movl 316(%rsp), %edi
	movq 168(%rsp), %rsi
	movq 176(%rsp), %rdx
	movl 320(%rsp), %eax
	movl %ebp, %ecx
	movl %r9d, 240(%rsp)
.fractalize_11:
	movq $12, %r8
	movq 56(%rsp), %r9
	addq %r8, %r9
	movl (%r9), %r10d
	movl %r10d, 308(%rsp)
	movl $1, %r8d
	movl 240(%rsp), %r9d
	cmpl 308(%rsp), %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %r8d
	jnz .fractalize_19
.fractalize_12:
	movl $0, %r9d
.fractalize_36:
	movq %r12, %rbp
	movq %rbx, %r15
	movl %r9d, %r14d
.fractalize_13:
	movq $8, %r8
	movq 56(%rsp), %r9
	addq %r8, %r9
	movl (%r9), %r13d
	movl $1, %r8d
	movl %r14d, %r9d
	cmpl %r13d, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %r8d
	jnz .fractalize_18
.fractalize_14:
	movq $0, %r8
	movq 56(%rsp), %r9
	addq %r8, %r9
	movq (%r9), %r12
	movl 240(%rsp), %r9d
	imull $8, %r9d
	movslq %r9d, %r8
	movq %r12, %r9
	addq %r8, %r9
	movq (%r9), %rbx
	movl %r14d, %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq %rbx, %r9
	addq %r8, %r9
	movl (%r9), %eax
	movl $1, %ecx
	movl $1, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .fractalize_16
.fractalize_15:
	movq $0, %r8
	movq 72(%rsp), %r9
	addq %r8, %r9
	movq (%r9), %rdi
	movl 300(%rsp), %r9d
	addl 240(%rsp), %r9d
	imull $8, %r9d
	movslq %r9d, %r8
	movq %rdi, %r9
	addq %r8, %r9
	movq (%r9), %rsi
	movq $0, %r8
	movq 56(%rsp), %r9
	addq %r8, %r9
	movq (%r9), %rdx
	movl 240(%rsp), %r9d
	imull $8, %r9d
	movslq %r9d, %r8
	movq %rdx, %r9
	addq %r8, %r9
	movq (%r9), %rcx
	movl %r14d, %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq %rcx, %r9
	addq %r8, %r9
	movl (%r9), %r9d
	movl 304(%rsp), %r8d
	addl %r14d, %r8d
	addl 288(%rsp), %r8d
	imull $4, %r8d
	movslq %r8d, %r8
	movq %rsi, %r15
	addq %r8, %r15
	movl %r9d, (%r15)
.fractalize_38:
	movl %r9d, 276(%rsp)
	movq %rcx, 176(%rsp)
	movq %rdx, 184(%rsp)
	movq %rsi, %r8
	movq %rdi, %rcx
.fractalize_17:
	movl %r14d, %r9d
	addl $1, %r9d
.fractalize_35:
	movl 276(%rsp), %r10d
	movl %r10d, 312(%rsp)
	movq 176(%rsp), %r10
	movq %r10, 160(%rsp)
	movq 184(%rsp), %r10
	movq %r10, 152(%rsp)
	movq %r8, %rbp
	movq %rcx, %r15
	movl %eax, %edi
	movq %rbx, %rsi
	movq %r12, %rdx
	movl %r9d, %r14d
	jmp .fractalize_13
.fractalize_16:
.fractalize_37:
	movl 312(%rsp), %r10d
	movl %r10d, 276(%rsp)
	movq 160(%rsp), %r10
	movq %r10, 176(%rsp)
	movq 152(%rsp), %r10
	movq %r10, 184(%rsp)
	movq %rbp, %r8
	movq %r15, %rcx
	jmp .fractalize_17
.fractalize_18:
	movl 240(%rsp), %r9d
	addl $1, %r9d
.fractalize_33:
	movq %rbp, %r12
	movq %r15, %rbx
	movl %r13d, %eax
	movl %r14d, %ecx
	movl %r9d, 240(%rsp)
	jmp .fractalize_11
.fractalize_19:
.fractalize_40:
	movl 312(%rsp), %r10d
	movl %r10d, 324(%rsp)
	movq 160(%rsp), %r10
	movq %r10, 192(%rsp)
	movq 152(%rsp), %r8
	movq %r12, 200(%rsp)
	movq %rbx, 208(%rsp)
	movl %edi, 328(%rsp)
	movq %rsi, 216(%rsp)
	movq %rdx, 224(%rsp)
	movl %eax, 284(%rsp)
	movl 308(%rsp), %r10d
	movl %r10d, 276(%rsp)
	movl 268(%rsp), %r10d
	movl %r10d, 332(%rsp)
	movl 304(%rsp), %r10d
	movl %r10d, 268(%rsp)
	movl 264(%rsp), %r10d
	movl %r10d, 336(%rsp)
	movl 300(%rsp), %r10d
	movl %r10d, 264(%rsp)
	movl 240(%rsp), %r10d
	movl %r10d, 340(%rsp)
.fractalize_21:
	movq $8, %r9
	movq 56(%rsp), %rdx
	addq %r9, %rdx
	movl (%rdx), %esi
	movq $12, %rdx
	movq 56(%rsp), %r9
	addq %rdx, %r9
	movl (%r9), %edx
	movl %esi, %r9d
	subl %edx, %r9d
	subl %r9d, 288(%rsp)
	movl 292(%rsp), %r9d
	addl $1, %r9d
.fractalize_31:
	movl %edx, 300(%rsp)
	movl %esi, 304(%rsp)
	movl 324(%rsp), %r10d
	movl %r10d, 308(%rsp)
	movq 192(%rsp), %r10
	movq %r10, 152(%rsp)
	movq %r8, %r15
	movq 200(%rsp), %r13
	movq 208(%rsp), %rbx
	movl 328(%rsp), %r10d
	movl %r10d, 316(%rsp)
	movq 216(%rsp), %r10
	movq %r10, 168(%rsp)
	movq 224(%rsp), %r10
	movq %r10, 176(%rsp)
	movl 284(%rsp), %r10d
	movl %r10d, 320(%rsp)
	movl 276(%rsp), %r10d
	movl %r10d, 272(%rsp)
	movl 332(%rsp), %r10d
	movl %r10d, 312(%rsp)
	movl 268(%rsp), %r14d
	movl 336(%rsp), %edx
	movl 264(%rsp), %r10d
	movl %r10d, 240(%rsp)
	movl %ecx, %ebp
	movl 340(%rsp), %r12d
	movl 260(%rsp), %eax
	movq 136(%rsp), %rdi
	movq 144(%rsp), %rsi
	movl %r9d, 292(%rsp)
	jmp .fractalize_8
.fractalize_20:
.fractalize_39:
	movl 308(%rsp), %r10d
	movl %r10d, 324(%rsp)
	movq 152(%rsp), %r10
	movq %r10, 192(%rsp)
	movq %r15, %r8
	movq %r13, 200(%rsp)
	movq %rbx, 208(%rsp)
	movl 316(%rsp), %r10d
	movl %r10d, 328(%rsp)
	movq 168(%rsp), %r10
	movq %r10, 216(%rsp)
	movq 176(%rsp), %r10
	movq %r10, 224(%rsp)
	movl 320(%rsp), %r10d
	movl %r10d, 284(%rsp)
	movl 272(%rsp), %r10d
	movl %r10d, 276(%rsp)
	movl 312(%rsp), %r10d
	movl %r10d, 332(%rsp)
	movl %r14d, 268(%rsp)
	movl %edx, 336(%rsp)
	movl 240(%rsp), %r10d
	movl %r10d, 264(%rsp)
	movl %ebp, %ecx
	movl %r12d, 340(%rsp)
	jmp .fractalize_21
.fractalize_22:
	movl 244(%rsp), %r10d
	movl %r10d, 264(%rsp)
	addl $1, 264(%rsp)
.fractalize_29:
	movl 272(%rsp), %r10d
	movl %r10d, 268(%rsp)
	movl 240(%rsp), %r10d
	movl %r10d, 276(%rsp)
	movl %ebp, 280(%rsp)
	movl %r12d, 284(%rsp)
	movl %eax, %ecx
	movq %rdi, 136(%rsp)
	movq %rsi, %r8
	movl 296(%rsp), %r9d
	movl 264(%rsp), %r10d
	movl %r10d, 244(%rsp)
	jmp .fractalize_6
.fractalize_23:
	movq 72(%rsp), %rdi
	movl 236(%rsp), %esi
	addl $1, %esi
.fractalize_25:
	movl %esi, 236(%rsp)
	movq %rdi, 96(%rsp)
	jmp .fractalize_1
.fractalize_24:
	movq 96(%rsp), %rax
	movq 8(%rsp), %rbp
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $344, %rsp
	ret
_c0_main:
	addq $-120, %rsp
	movq %rbp, 16(%rsp)
	movq %r15, 24(%rsp)
	movq %r14, 32(%rsp)
	movq %r13, 40(%rsp)
	movq %r12, 48(%rsp)
	movq %rbx, 56(%rsp)
.main_0:
	movq $1, %rdi
	movq $16, %rsi
	movq %rcx, %r14
	movq %r8, %r13
	movq %r9, %r12
	callq calloc
	movq %r14, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movq %rax, %r12
	movq $8, %rdx
	movq %r12, %rsi
	addq %rdx, %rsi
	movl $3, (%rsi)
	movq $12, %rsi
	movq %r12, %rdx
	addq %rsi, %rdx
	movl $2, (%rdx)
	movq $0, %rsi
	movq %r12, %rdx
	addq %rsi, %rdx
	movq $2, %rdi
	movq $8, %rsi
	movq %rdx, %rbp
	movq %rcx, %r15
	movq %r8, %r14
	movq %r9, %r13
	callq calloc
	movq %rbp, %rdx
	movq %r15, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movq %rax, (%rdx)
	movq $0, %rdx
	movq %r12, %rsi
	addq %rdx, %rsi
	movq (%rsi), %rdi
	movl $0, %edx
	imull $8, %edx
	movslq %edx, %rsi
	movq %rdi, %rdx
	addq %rsi, %rdx
	movq $3, %rdi
	movq $4, %rsi
	movq %rdx, %rbp
	movq %rcx, %r15
	movq %r8, %r14
	movq %r9, %r13
	callq calloc
	movq %rbp, %rdx
	movq %r15, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movq %rax, (%rdx)
	movq $0, %rdx
	movq %r12, %rsi
	addq %rdx, %rsi
	movq (%rsi), %rdi
	movl $1, %edx
	imull $8, %edx
	movslq %edx, %rsi
	movq %rdi, %rdx
	addq %rsi, %rdx
	movq $3, %rdi
	movq $4, %rsi
	movq %rdx, %rbp
	movq %rcx, %r15
	movq %r8, %r14
	movq %r9, %r13
	callq calloc
	movq %rbp, %rdx
	movq %r15, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movq %rax, (%rdx)
	movq $0, %rdx
	movq %r12, %rsi
	addq %rdx, %rsi
	movq (%rsi), %rdi
	movl $0, %edx
	imull $8, %edx
	movslq %edx, %rsi
	movq %rdi, %rdx
	addq %rsi, %rdx
	movq (%rdx), %rdi
	movl $0, %edx
	imull $4, %edx
	movslq %edx, %rsi
	movq %rdi, %rdx
	addq %rsi, %rdx
	movl $0, (%rdx)
	movq $0, %rsi
	movq %r12, %rdx
	addq %rsi, %rdx
	movq (%rdx), %rdi
	movl $0, %edx
	imull $8, %edx
	movslq %edx, %rsi
	movq %rdi, %rdx
	addq %rsi, %rdx
	movq (%rdx), %rdx
	movl $1, %esi
	imull $4, %esi
	movslq %esi, %rsi
	addq %rsi, %rdx
	movl $1, (%rdx)
	movq $0, %rsi
	movq %r12, %rdx
	addq %rsi, %rdx
	movq (%rdx), %rsi
	movl $0, %edx
	imull $8, %edx
	movslq %edx, %rdx
	addq %rdx, %rsi
	movq (%rsi), %rdi
	movl $2, %edx
	imull $4, %edx
	movslq %edx, %rsi
	movq %rdi, %rdx
	addq %rsi, %rdx
	movl $0, (%rdx)
	movq $0, %rsi
	movq %r12, %rdx
	addq %rsi, %rdx
	movq (%rdx), %rdx
	movl $1, %esi
	imull $8, %esi
	movslq %esi, %rsi
	addq %rsi, %rdx
	movq (%rdx), %rdi
	movl $0, %edx
	imull $4, %edx
	movslq %edx, %rsi
	movq %rdi, %rdx
	addq %rsi, %rdx
	movl $1, (%rdx)
	movq $0, %rsi
	movq %r12, %rdx
	addq %rsi, %rdx
	movq (%rdx), %rdi
	movl $1, %edx
	imull $8, %edx
	movslq %edx, %rsi
	movq %rdi, %rdx
	addq %rsi, %rdx
	movq (%rdx), %rdi
	movl $1, %edx
	imull $4, %edx
	movslq %edx, %rsi
	movq %rdi, %rdx
	addq %rsi, %rdx
	movl $0, (%rdx)
	movq $0, %rsi
	movq %r12, %rdx
	addq %rsi, %rdx
	movq (%rdx), %rdi
	movl $1, %edx
	imull $8, %edx
	movslq %edx, %rsi
	movq %rdi, %rdx
	addq %rsi, %rdx
	movq (%rdx), %rdi
	movl $2, %edx
	imull $4, %edx
	movslq %edx, %rsi
	movq %rdi, %rdx
	addq %rsi, %rdx
	movl $1, (%rdx)
	movq %r12, %rdi
	movl $6, %esi
	movq %rcx, %r14
	movq %r8, %r13
	movq %r9, %r12
	callq _c0_fractalize
	movq %r14, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movq %rax, %rsi
	movl $0, %edx
.main_11:
	movl %edx, %r12d
.main_1:
	movq $12, %rdi
	movq %rsi, %rdx
	addq %rdi, %rdx
	movl (%rdx), %eax
	movl $1, %edi
	movl %r12d, %edx
	cmpl %eax, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %edi
	jnz .main_9
.main_2:
	movq $8, %rdi
	movq %rsi, %rdx
	addq %rdi, %rdx
	movl (%rdx), %eax
	movl $2, %edi
	cltd
	idivl %edi
	movl %eax, %r13d
	addl $109, %r13d
	movl $0, %edx
.main_13:
	movl %edx, %r14d
.main_3:
	movq $12, %rdi
	movq %rsi, %rdx
	addq %rdi, %rdx
	movl (%rdx), %r15d
	movl $1, %eax
	movl %r15d, %edi
	imull $2, %edi
	movl %r14d, %edx
	cmpl %edi, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %eax
	jnz .main_8
.main_4:
	movq $0, %rdi
	movq %rsi, %rdx
	addq %rdi, %rdx
	movq (%rdx), %rbp
	movl %r12d, %edx
	imull $8, %edx
	movslq %edx, %rdi
	movq %rbp, %rdx
	addq %rdi, %rdx
	movq (%rdx), %r10
	movq %r10, 64(%rsp)
	movl %r14d, %edx
	addl %r13d, %edx
	imull $4, %edx
	movslq %edx, %rdi
	movq 64(%rsp), %rdx
	addq %rdi, %rdx
	movl (%rdx), %edx
	movl $1, 112(%rsp)
	movl $0, %eax
	movl %edx, %edi
	cmpl %eax, %edi
	sete %dil
	movzbl %dil, %edi
	cmpl %edi, 112(%rsp)
	jnz .main_6
.main_5:
	movl $32, %edi
	movq %rsi, 72(%rsp)
	movq %rdx, 80(%rsp)
	movq %rcx, 88(%rsp)
	callq printchar
	movq 72(%rsp), %rsi
	movq 80(%rsp), %rdx
	movq 88(%rsp), %rcx
	movslq %eax, %r9
.main_15:
	movl %ecx, 116(%rsp)
	movq %rbx, 80(%rsp)
	movl %eax, 112(%rsp)
	movq %r9, %rdi
.main_7:
	movl %r14d, %eax
	addl $1, %eax
.main_12:
	movl 116(%rsp), %ecx
	movq 80(%rsp), %rbx
	movl 112(%rsp), %r8d
	movq %rdi, %r9
	movl %eax, %r14d
	jmp .main_3
.main_6:
	movl $42, %edi
	movq %rsi, 96(%rsp)
	movq %rdx, 104(%rsp)
	movq %rcx, 72(%rsp)
	movq %r8, 80(%rsp)
	movq %r9, 88(%rsp)
	callq printchar
	movq 96(%rsp), %rsi
	movq 104(%rsp), %rdx
	movq 72(%rsp), %rcx
	movq 80(%rsp), %r8
	movq 88(%rsp), %r9
	movslq %eax, %rdi
.main_14:
	movl %eax, 116(%rsp)
	movq %rdi, 80(%rsp)
	movl %r8d, 112(%rsp)
	movq %r9, %rdi
	jmp .main_7
.main_8:
	movl $10, %edi
	movq %rsi, %rbp
	movq %rcx, %r15
	movq %r8, %r14
	movq %r9, %r13
	callq printchar
	movq %rbp, %rsi
	movq %r15, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl %r12d, %edx
	addl $1, %edx
.main_10:
	movl %edx, %r12d
	jmp .main_1
.main_9:
	movq $8, %r8
	movq %rsi, %r9
	addq %r8, %r9
	movl (%r9), %ecx
	movq $12, %r9
	movq %rsi, %r8
	addq %r9, %r8
	movl (%r8), %r9d
	movl %ecx, %eax
	imull %r9d, %eax
	movq 16(%rsp), %rbp
	movq 24(%rsp), %r15
	movq 32(%rsp), %r14
	movq 40(%rsp), %r13
	movq 48(%rsp), %r12
	movq 56(%rsp), %rbx
	addq $120, %rsp
	ret
.ident	"15-411 L4 reference compiler"
