.file	"../tests2/stegosaurus-tm.l4"
.globl _c0_main
_c0_run:
	addq $-152, %rsp
	movq %rbp, 16(%rsp)
	movq %r15, 24(%rsp)
	movq %r14, 32(%rsp)
	movq %r13, 40(%rsp)
	movq %r12, 48(%rsp)
	movq %rbx, 56(%rsp)
	movq %rsi, 64(%rsp)
.run_0:
	movl $30, %r15d
	movl $0, %esi
.run_20:
	movl %esi, 104(%rsp)
	movl %r15d, 108(%rsp)
.run_1:
	movl $1, %r15d
	movl $1, %esi
	cmpl %esi, %r15d
	jnz .run_18
.run_2:
	movl $0, %esi
.run_22:
	movl %esi, 112(%rsp)
.run_3:
	movq $8, %r15
	movq %rdi, %rsi
	addq %r15, %rsi
	movl (%rsi), %r10d
	movl %r10d, 116(%rsp)
	movl $1, %r15d
	movl 112(%rsp), %esi
	cmpl 116(%rsp), %esi
	setl %sil
	movzbl %sil, %esi
	cmpl %esi, %r15d
	jnz .run_24
.run_4:
	movq $0, %r15
	movq %rdi, %rsi
	addq %r15, %rsi
	movq (%rsi), %r10
	movq %r10, 72(%rsp)
	movl 112(%rsp), %esi
	imull $24, %esi
	movslq %esi, %r15
	movq 72(%rsp), %rsi
	addq %r15, %rsi
	movq $0, %r15
	addq %r15, %rsi
	movl (%rsi), %r10d
	movl %r10d, 120(%rsp)
	movl 104(%rsp), %r10d
	cmpl %r10d, 120(%rsp)
	jz .ternary_true1
	movl $0, 124(%rsp)
	jmp .ternary_end2
.ternary_true1:
	movq $0, %rsi
	movq %rdi, %rdx
	addq %rsi, %rdx
	movq (%rdx), %rax
	movl 112(%rsp), %edx
	imull $24, %edx
	movslq %edx, %rsi
	movq %rax, %rdx
	addq %rsi, %rdx
	movq $4, %rsi
	addq %rsi, %rdx
	movl (%rdx), %edx
	movl 108(%rsp), %esi
	imull $4, %esi
	movslq %esi, %r14
	movq 64(%rsp), %rsi
	addq %r14, %rsi
	movl (%rsi), %r14d
	movl %edx, 124(%rsp)
	cmpl %r14d, 124(%rsp)
	sete %r11b
	movzbl %r11b, %r11d
	movl %r11d, 124(%rsp)
.ternary_end2:
	movl $1, %esi
	cmpl 124(%rsp), %esi
	jnz .run_11
.run_5:
	movq $0, %r15
	movq %rdi, %rsi
	addq %r15, %rsi
	movq (%rsi), %r10
	movq %r10, 80(%rsp)
	movl 112(%rsp), %esi
	imull $24, %esi
	movslq %esi, %r15
	movq 80(%rsp), %rsi
	addq %r15, %rsi
	movq $8, %r15
	addq %r15, %rsi
	movl (%rsi), %r10d
	movl %r10d, 128(%rsp)
	movl 128(%rsp), %r10d
	movl %r10d, 132(%rsp)
	movq $0, %r15
	movq %rdi, %rsi
	addq %r15, %rsi
	movq (%rsi), %r10
	movq %r10, 88(%rsp)
	movl 112(%rsp), %esi
	imull $24, %esi
	movslq %esi, %r15
	movq 88(%rsp), %rsi
	addq %r15, %rsi
	movq $12, %r15
	addq %r15, %rsi
	movl (%rsi), %r10d
	movl %r10d, 136(%rsp)
	movl 108(%rsp), %esi
	imull $4, %esi
	movslq %esi, %r15
	movq 64(%rsp), %rsi
	addq %r15, %rsi
	movl 136(%rsp), %r10d
	movl %r10d, (%rsi)
	movq $0, %r15
	movq %rdi, %rsi
	addq %r15, %rsi
	movq (%rsi), %r10
	movq %r10, 96(%rsp)
	movl 112(%rsp), %esi
	imull $24, %esi
	movslq %esi, %r15
	movq 96(%rsp), %rsi
	addq %r15, %rsi
	movq $16, %r15
	addq %r15, %rsi
	movl (%rsi), %r10d
	movl %r10d, 140(%rsp)
	cmpl $0, 140(%rsp)
	jnz .ternary_true3
	movl $0, 144(%rsp)
	subl $1, 144(%rsp)
	jmp .ternary_end4
.ternary_true3:
	movl $1, 144(%rsp)
.ternary_end4:
	movl 108(%rsp), %r10d
	movl %r10d, 148(%rsp)
	movl 144(%rsp), %r10d
	addl %r10d, 148(%rsp)
	movq $0, %r15
	movq %rdi, %rsi
	addq %r15, %rsi
	movq (%rsi), %rbp
	movl 112(%rsp), %esi
	imull $24, %esi
	movslq %esi, %r15
	movq %rbp, %rsi
	addq %r15, %rsi
	movq $20, %r15
	addq %r15, %rsi
	movl (%rsi), %r15d
	movl $1, %esi
	cmpl %r15d, %esi
	jnz .run_8
.run_6:
	movl $1, %eax
	movq 16(%rsp), %rbp
	movq 24(%rsp), %r15
	movq 32(%rsp), %r14
	movq 40(%rsp), %r13
	movq 48(%rsp), %r12
	movq 56(%rsp), %rbx
	addq $152, %rsp
	ret
.run_8:
.run_9:
	jmp .run_23
.run_11:
.run_12:
	movl 112(%rsp), %esi
	addl $1, %esi
.run_21:
	movl %r14d, %r13d
	movl %edx, %ebx
	movq %rax, %rcx
	movl 120(%rsp), %r12d
	movq 72(%rsp), %r8
	movl 124(%rsp), %r9d
	movl %esi, 112(%rsp)
	jmp .run_3
.run_24:
	movl 104(%rsp), %r10d
	movl %r10d, 144(%rsp)
	movl 108(%rsp), %r10d
	movl %r10d, 148(%rsp)
.run_13:
	movq $8, %rsi
	movq %rdi, %r15
	addq %rsi, %r15
	movl (%r15), %r15d
	movl $1, %esi
	movl 112(%rsp), %ebp
	cmpl %r15d, %ebp
	sete %bpl
	movzbl %bpl, %ebp
	cmpl %ebp, %esi
	jnz .run_16
.run_14:
	movl $0, %eax
	movq 16(%rsp), %rbp
	movq 24(%rsp), %r15
	movq 32(%rsp), %r14
	movq 40(%rsp), %r13
	movq 48(%rsp), %r12
	movq 56(%rsp), %rbx
	addq $152, %rsp
	ret
.run_16:
.run_17:
.run_19:
	movl 144(%rsp), %r10d
	movl %r10d, 104(%rsp)
	movl 148(%rsp), %r10d
	movl %r10d, 108(%rsp)
	jmp .run_1
.run_18:
	movl $0, %eax
	movq 16(%rsp), %rbp
	movq 24(%rsp), %r15
	movq 32(%rsp), %r14
	movq 40(%rsp), %r13
	movq 48(%rsp), %r12
	movq 56(%rsp), %rbx
	addq $152, %rsp
	ret
.run_23:
	movl 132(%rsp), %r10d
	movl %r10d, 144(%rsp)
	jmp .run_13
_c0_addrow:
	addq $-40, %rsp
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
	movl %r9d, %r13d
	movl 48(%rsp), %r12d
	movl 56(%rsp), %ebx
.addrow_0:
	movl %esi, %r9d
	imull $24, %r9d
	movslq %r9d, %rax
	movq %rdi, %r9
	addq %rax, %r9
	movq $0, %rax
	addq %rax, %r9
	movl %edx, (%r9)
	movl %esi, %r9d
	imull $24, %r9d
	movslq %r9d, %rdx
	movq %rdi, %r9
	addq %rdx, %r9
	movq $4, %rdx
	addq %rdx, %r9
	movl %ecx, (%r9)
	movl %esi, %r9d
	imull $24, %r9d
	movslq %r9d, %rcx
	movq %rdi, %r9
	addq %rcx, %r9
	movq $8, %rcx
	addq %rcx, %r9
	movl %r8d, (%r9)
	movl %esi, %r9d
	imull $24, %r9d
	movslq %r9d, %r8
	movq %rdi, %r9
	addq %r8, %r9
	movq $12, %r8
	addq %r8, %r9
	movl %r13d, (%r9)
	movl %esi, %r9d
	imull $24, %r9d
	movslq %r9d, %r8
	movq %rdi, %r9
	addq %r8, %r9
	movq $16, %r8
	addq %r8, %r9
	movl %r12d, (%r9)
	movl %esi, %r9d
	imull $24, %r9d
	movslq %r9d, %r9
	movq %rdi, %r8
	addq %r9, %r8
	movq $20, %r9
	addq %r9, %r8
	movl %ebx, (%r8)
	movl %esi, %eax
	addl $1, %eax
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
_c0_main:
	addq $-88, %rsp
	movq %rbp, 20(%rsp)
	movq %r15, 28(%rsp)
	movq %r14, 36(%rsp)
	movq %r13, 44(%rsp)
	movq %r12, 52(%rsp)
	movq %rbx, 60(%rsp)
.main_0:
	movl $100, %ebx
	movq $100, %rdi
	movq $4, %rsi
	callq calloc
	movq %rax, %r12
	movq $1, %rdi
	movq $12, %rsi
	callq calloc
	movq %rax, %rbp
	movl $0, %r9d
	movl $0, %r13d
	subl $1, %r13d
	movl $0, %r14d
	movl $1, %r15d
	movl $0, 84(%rsp)
	movq $0, %rcx
	movq %rbp, %r8
	addq %rcx, %r8
	movq $100, %rdi
	movq $24, %rsi
	movq %r8, 68(%rsp)
	movq %r9, 76(%rsp)
	callq calloc
	movq 68(%rsp), %r8
	movq 76(%rsp), %r9
	movq %rax, (%r8)
	movq $0, %rcx
	movq %rbp, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movq %r8, %rdi
	movl %r9d, %esi
	movl $0, %edx
	movl $0, %ecx
	movl $1, %r8d
	movl %r13d, %r9d
	movl %r15d, 0(%rsp)
	movl $0, 8(%rsp)
	callq _c0_addrow
	movl %eax, %r8d
	movq $0, %r9
	movq %rbp, %rcx
	addq %r9, %rcx
	movq (%rcx), %r9
	movq %r9, %rdi
	movl %r8d, %esi
	movl $0, %edx
	movl $1, %ecx
	movl $2, %r8d
	movl %r13d, %r9d
	movl %r15d, 0(%rsp)
	movl $0, 8(%rsp)
	callq _c0_addrow
	movl %eax, %r8d
	movq $0, %r9
	movq %rbp, %rcx
	addq %r9, %rcx
	movq (%rcx), %r9
	movq %r9, %rdi
	movl %r8d, %esi
	movl $0, %edx
	movl %r13d, %ecx
	movl %r14d, %r8d
	movl %r13d, %r9d
	movl %r15d, 0(%rsp)
	movl $1, 8(%rsp)
	callq _c0_addrow
	movl %eax, %ecx
	movq $0, %r8
	movq %rbp, %r9
	addq %r8, %r9
	movq (%r9), %r9
	movq %r9, %rdi
	movl %ecx, %esi
	movl $1, %edx
	movl $0, %ecx
	movl $1, %r8d
	movl $0, %r9d
	movl %r15d, 0(%rsp)
	movl $0, 8(%rsp)
	callq _c0_addrow
	movl %eax, %ecx
	movq $0, %r8
	movq %rbp, %r9
	addq %r8, %r9
	movq (%r9), %r9
	movq %r9, %rdi
	movl %ecx, %esi
	movl $1, %edx
	movl $1, %ecx
	movl $1, %r8d
	movl $1, %r9d
	movl %r15d, 0(%rsp)
	movl $0, 8(%rsp)
	callq _c0_addrow
	movl %eax, %ecx
	movq $0, %r8
	movq %rbp, %r9
	addq %r8, %r9
	movq (%r9), %r9
	movq %r9, %rdi
	movl %ecx, %esi
	movl $1, %edx
	movl %r13d, %ecx
	movl $3, %r8d
	movl %r13d, %r9d
	movl 84(%rsp), %r10d
	movl %r10d, 0(%rsp)
	movl $0, 8(%rsp)
	callq _c0_addrow
	movl %eax, %ecx
	movq $0, %r8
	movq %rbp, %r9
	addq %r8, %r9
	movq (%r9), %r9
	movq %r9, %rdi
	movl %ecx, %esi
	movl $2, %edx
	movl $0, %ecx
	movl $2, %r8d
	movl $0, %r9d
	movl %r15d, 0(%rsp)
	movl $0, 8(%rsp)
	callq _c0_addrow
	movl %eax, %r8d
	movq $0, %r9
	movq %rbp, %rcx
	addq %r9, %rcx
	movq (%rcx), %r9
	movq %r9, %rdi
	movl %r8d, %esi
	movl $2, %edx
	movl $1, %ecx
	movl $2, %r8d
	movl $1, %r9d
	movl %r15d, 0(%rsp)
	movl $0, 8(%rsp)
	callq _c0_addrow
	movl %eax, %ecx
	movq $0, %r8
	movq %rbp, %r9
	addq %r8, %r9
	movq (%r9), %r9
	movq %r9, %rdi
	movl %ecx, %esi
	movl $2, %edx
	movl %r13d, %ecx
	movl $4, %r8d
	movl %r13d, %r9d
	movl 84(%rsp), %r10d
	movl %r10d, 0(%rsp)
	movl $0, 8(%rsp)
	callq _c0_addrow
	movl %eax, %ecx
	movq $0, %r8
	movq %rbp, %r9
	addq %r8, %r9
	movq (%r9), %r9
	movq %r9, %rdi
	movl %ecx, %esi
	movl $3, %edx
	movl $0, %ecx
	movl $5, %r8d
	movl %r13d, %r9d
	movl 84(%rsp), %r10d
	movl %r10d, 0(%rsp)
	movl $0, 8(%rsp)
	callq _c0_addrow
	movl %eax, %ecx
	movq $0, %r8
	movq %rbp, %r9
	addq %r8, %r9
	movq (%r9), %r9
	movq %r9, %rdi
	movl %ecx, %esi
	movl $3, %edx
	movl %r13d, %ecx
	movl %r14d, %r8d
	movl %r13d, %r9d
	movl 84(%rsp), %r10d
	movl %r10d, 0(%rsp)
	movl $1, 8(%rsp)
	callq _c0_addrow
	movl %eax, %ecx
	movq $0, %r8
	movq %rbp, %r9
	addq %r8, %r9
	movq (%r9), %r9
	movq %r9, %rdi
	movl %ecx, %esi
	movl $4, %edx
	movl $1, %ecx
	movl $5, %r8d
	movl %r13d, %r9d
	movl 84(%rsp), %r10d
	movl %r10d, 0(%rsp)
	movl $0, 8(%rsp)
	callq _c0_addrow
	movl %eax, %ecx
	movq $0, %r8
	movq %rbp, %r9
	addq %r8, %r9
	movq (%r9), %r9
	movq %r9, %rdi
	movl %ecx, %esi
	movl $4, %edx
	movl %r13d, %ecx
	movl %r14d, %r8d
	movl %r13d, %r9d
	movl 84(%rsp), %r10d
	movl %r10d, 0(%rsp)
	movl $1, 8(%rsp)
	callq _c0_addrow
	movl %eax, %ecx
	movq $0, %r8
	movq %rbp, %r9
	addq %r8, %r9
	movq (%r9), %r9
	movq %r9, %rdi
	movl %ecx, %esi
	movl $5, %edx
	movl $0, %ecx
	movl $5, %r8d
	movl $0, %r9d
	movl 84(%rsp), %r10d
	movl %r10d, 0(%rsp)
	movl $0, 8(%rsp)
	callq _c0_addrow
	movl %eax, %ecx
	movq $0, %r8
	movq %rbp, %r9
	addq %r8, %r9
	movq (%r9), %r9
	movq %r9, %rdi
	movl %ecx, %esi
	movl $5, %edx
	movl $1, %ecx
	movl $5, %r8d
	movl $1, %r9d
	movl 84(%rsp), %r10d
	movl %r10d, 0(%rsp)
	movl $0, 8(%rsp)
	callq _c0_addrow
	movl %eax, %ecx
	movq $0, %r9
	movq %rbp, %r8
	addq %r9, %r8
	movq (%r8), %r9
	movq %r9, %rdi
	movl %ecx, %esi
	movl $5, %edx
	movl %r13d, %ecx
	movl $0, %r8d
	movl %r13d, %r9d
	movl %r15d, 0(%rsp)
	movl $0, 8(%rsp)
	callq _c0_addrow
	movl %eax, %r8d
	movq $8, %r9
	movq %rbp, %rcx
	addq %r9, %rcx
	movl %r8d, (%rcx)
	movl $0, %r9d
.main_5:
	movl %r9d, %ecx
.main_1:
	movl $1, %r8d
	movl %ecx, %r9d
	cmpl %ebx, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %r8d
	jnz .main_3
.main_2:
	movl %ecx, %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq %r12, %r9
	addq %r8, %r9
	movl %r13d, (%r9)
	movl %ecx, %r9d
	addl $1, %r9d
.main_4:
	movl %r9d, %ecx
	jmp .main_1
.main_3:
	movl $30, %r9d
	imull $4, %r9d
	movslq %r9d, %r9
	movq %r12, %r8
	addq %r9, %r8
	movl $1, (%r8)
	movl $31, %r9d
	imull $4, %r9d
	movslq %r9d, %r9
	movq %r12, %r8
	addq %r9, %r8
	movl $0, (%r8)
	movl $32, %r9d
	imull $4, %r9d
	movslq %r9d, %r9
	movq %r12, %r8
	addq %r9, %r8
	movl $0, (%r8)
	movl $33, %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq %r12, %r9
	addq %r8, %r9
	movl $1, (%r9)
	movl $34, %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq %r12, %r9
	addq %r8, %r9
	movl $0, (%r9)
	movl $35, %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq %r12, %r9
	addq %r8, %r9
	movl $1, (%r9)
	movl $36, %r9d
	imull $4, %r9d
	movslq %r9d, %r9
	movq %r12, %r8
	addq %r9, %r8
	movl $1, (%r8)
	movl $37, %r9d
	imull $4, %r9d
	movslq %r9d, %r9
	movq %r12, %r8
	addq %r9, %r8
	movl $1, (%r8)
	movl $38, %r9d
	imull $4, %r9d
	movslq %r9d, %r9
	movq %r12, %r8
	addq %r9, %r8
	movl $1, (%r8)
	movl $39, %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq %r12, %r9
	addq %r8, %r9
	movl $0, (%r9)
	movl $40, %r9d
	imull $4, %r9d
	movslq %r9d, %r9
	movq %r12, %r8
	addq %r9, %r8
	movl $1, (%r8)
	movl $41, %r9d
	imull $4, %r9d
	movslq %r9d, %r9
	movq %r12, %r8
	addq %r9, %r8
	movl $1, (%r8)
	movl $42, %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq %r12, %r9
	addq %r8, %r9
	movl $1, (%r9)
	movl $43, %r9d
	imull $4, %r9d
	movslq %r9d, %r9
	movq %r12, %r8
	addq %r9, %r8
	movl $1, (%r8)
	movl $44, %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq %r12, %r9
	addq %r8, %r9
	movl $0, (%r9)
	movl $45, %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq %r12, %r9
	addq %r8, %r9
	movl $1, (%r9)
	movl $46, %r9d
	imull $4, %r9d
	movslq %r9d, %r9
	movq %r12, %r8
	addq %r9, %r8
	movl $0, (%r8)
	movl $47, %r9d
	imull $4, %r9d
	movslq %r9d, %r9
	movq %r12, %r8
	addq %r9, %r8
	movl $0, (%r8)
	movl $48, %r9d
	imull $4, %r9d
	movslq %r9d, %r9
	movq %r12, %r8
	addq %r9, %r8
	movl $1, (%r8)
	movq %rbp, %rdi
	movq %r12, %rsi
	callq _c0_run
	movl %eax, %edi
	callq booltoint
	movq 20(%rsp), %rbp
	movq 28(%rsp), %r15
	movq 36(%rsp), %r14
	movq 44(%rsp), %r13
	movq 52(%rsp), %r12
	movq 60(%rsp), %rbx
	addq $88, %rsp
	ret
.ident	"15-411 L4 reference compiler"
