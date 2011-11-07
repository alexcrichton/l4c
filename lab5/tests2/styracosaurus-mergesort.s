.file	"../tests2/styracosaurus-mergesort.l4"
.globl _c0_main
_c0_merge:
	addq $-136, %rsp
	movq %rbp, 8(%rsp)
	movq %r15, 16(%rsp)
	movq %r14, 24(%rsp)
	movq %r13, 32(%rsp)
	movq %r12, 40(%rsp)
	movq %rbx, 48(%rsp)
	movl %edi, %r13d
	movl %esi, %r15d
	movq %rcx, 56(%rsp)
.merge_0:
	movl $0, 104(%rsp)
	movl $0, 108(%rsp)
	movl $0, 112(%rsp)
	movq $1, %rdi
	movq $8, %rsi
	movq %rdx, 64(%rsp)
	movq %r8, 72(%rsp)
	movq %r9, 80(%rsp)
	callq calloc
	movq 64(%rsp), %rdx
	movq 72(%rsp), %r8
	movq 80(%rsp), %r9
	movq %rax, %rcx
	movq %rcx, 80(%rsp)
	movl %r13d, %esi
	addl %r15d, %esi
	movslq %esi, %rdi
	movq $4, %rsi
	movq %rdx, 88(%rsp)
	movq %rcx, 96(%rsp)
	movq %r8, 64(%rsp)
	movq %r9, 72(%rsp)
	callq calloc
	movq 88(%rsp), %rdx
	movq 96(%rsp), %rcx
	movq 64(%rsp), %r8
	movq 72(%rsp), %r9
	movq 80(%rsp), %r11
	movq %rax, (%r11)
.merge_18:
	movl 112(%rsp), %r10d
	movl %r10d, 116(%rsp)
	movl 108(%rsp), %r10d
	movl %r10d, 112(%rsp)
	movl 104(%rsp), %r10d
	movl %r10d, 108(%rsp)
.merge_1:
	movl $1, %eax
	movl %r13d, %edi
	addl %r15d, %edi
	movl 108(%rsp), %esi
	cmpl %edi, %esi
	setl %sil
	movzbl %sil, %esi
	cmpl %esi, %eax
	jnz .merge_14
.merge_2:
	movl $1, %edi
	movl %r13d, %esi
	cmpl 112(%rsp), %esi
	setle %sil
	movzbl %sil, %esi
	cmpl %esi, %edi
	jnz .merge_5
.merge_3:
	movq %rcx, %rsi
	movq (%rsi), %r12
	movl 116(%rsp), %esi
	imull $4, %esi
	movslq %esi, %rdi
	movq 56(%rsp), %rsi
	addq %rdi, %rsi
	movl (%rsi), %r10d
	movl %r10d, 120(%rsp)
	movl 108(%rsp), %esi
	imull $4, %esi
	movslq %esi, %rdi
	movq %r12, %rsi
	addq %rdi, %rsi
	movl 120(%rsp), %r10d
	movl %r10d, (%rsi)
	movl 116(%rsp), %r10d
	movl %r10d, 124(%rsp)
	addl $1, 124(%rsp)
	movl 108(%rsp), %r14d
	addl $1, %r14d
	jmp .merge_17
.merge_5:
.merge_6:
	movl $1, %edi
	movl %r15d, %esi
	cmpl 116(%rsp), %esi
	setle %sil
	movzbl %sil, %esi
	cmpl %esi, %edi
	jnz .merge_9
.merge_7:
	movq %rcx, %rsi
	movq (%rsi), %r10
	movq %r10, 80(%rsp)
	movl 112(%rsp), %esi
	imull $4, %esi
	movslq %esi, %rdi
	movq %rdx, %rsi
	addq %rdi, %rsi
	movl (%rsi), %eax
	movl 108(%rsp), %esi
	imull $4, %esi
	movslq %esi, %rdi
	movq 80(%rsp), %rsi
	addq %rdi, %rsi
	movl %eax, (%rsi)
	movl 112(%rsp), %edi
	addl $1, %edi
	movl 108(%rsp), %esi
	addl $1, %esi
	jmp .merge_16
.merge_9:
.merge_10:
	movl 112(%rsp), %esi
	imull $4, %esi
	movslq %esi, %rdi
	movq %rdx, %rsi
	addq %rdi, %rsi
	movl (%rsi), %r10d
	movl %r10d, 104(%rsp)
	movl 116(%rsp), %esi
	imull $4, %esi
	movslq %esi, %rdi
	movq 56(%rsp), %rsi
	addq %rdi, %rsi
	movl (%rsi), %r10d
	movl %r10d, 128(%rsp)
	movl $1, %edi
	movl 104(%rsp), %esi
	cmpl 128(%rsp), %esi
	setl %sil
	movzbl %sil, %esi
	cmpl %esi, %edi
	jnz .merge_12
.merge_11:
	movq %rcx, %r9
	movq (%r9), %rax
	movl 112(%rsp), %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq %rdx, %r9
	addq %r8, %r9
	movl (%r9), %edi
	movl 108(%rsp), %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq %rax, %r9
	addq %r8, %r9
	movl %edi, (%r9)
	movl 112(%rsp), %r8d
	addl $1, %r8d
	movl 108(%rsp), %r9d
	addl $1, %r9d
.merge_20:
	movl %ebx, %esi
	movl %edi, 132(%rsp)
	movq %rax, 96(%rsp)
	movl 116(%rsp), %r10d
	movl %r10d, 108(%rsp)
	movl %r8d, %edi
	movl %r9d, %eax
.merge_13:
.merge_15:
	movl %esi, %ebx
	movl 132(%rsp), %r8d
	movq 96(%rsp), %r9
	movl 108(%rsp), %r10d
	movl %r10d, 116(%rsp)
	movl %edi, 112(%rsp)
	movl %eax, 108(%rsp)
	jmp .merge_1
.merge_12:
	movq %rcx, %rsi
	movq (%rsi), %rbp
	movl 116(%rsp), %esi
	imull $4, %esi
	movslq %esi, %rdi
	movq 56(%rsp), %rsi
	addq %rdi, %rsi
	movl (%rsi), %ebx
	movl 108(%rsp), %esi
	imull $4, %esi
	movslq %esi, %rsi
	movq %rbp, %rdi
	addq %rsi, %rdi
	movl %ebx, (%rdi)
	movl 116(%rsp), %edi
	addl $1, %edi
	movl 108(%rsp), %eax
	addl $1, %eax
.merge_19:
	movl %ebx, %esi
	movl %r8d, 132(%rsp)
	movq %r9, 96(%rsp)
	movl %edi, 108(%rsp)
	movl 112(%rsp), %edi
	jmp .merge_13
.merge_14:
	movq %rcx, %rax
	movq 8(%rsp), %rbp
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $136, %rsp
	ret
.merge_16:
	movl %edi, 112(%rsp)
	movl %esi, 108(%rsp)
	jmp .merge_1
.merge_17:
	movl 124(%rsp), %r10d
	movl %r10d, 116(%rsp)
	movl %r14d, 108(%rsp)
	jmp .merge_1
_c0_mergesort:
	addq $-40, %rsp
	movq %r14, 8(%rsp)
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
	movl %edi, %r9d
	movl %esi, %r8d
	movq %rdx, %rcx
.mergesort_0:
	movl $1, %esi
	movl %r8d, %edi
	subl $1, %edi
	movl %r9d, %edx
	cmpl %edi, %edx
	sete %dl
	movzbl %dl, %edx
	cmpl %edx, %esi
	jnz .mergesort_3
.mergesort_1:
	movq $1, %rdi
	movq $8, %rsi
	movq %rcx, %r12
	movq %r9, %rbx
	callq calloc
	movq %r12, %rcx
	movq %rbx, %r9
	movq %rax, %r8
	movq %r8, %rdx
	movq $1, %rdi
	movq $4, %rsi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, (%rdx)
	movq %r8, %rdx
	movq (%rdx), %rdx
	imull $4, %r9d
	movslq %r9d, %rsi
	movq %rcx, %r9
	addq %rsi, %r9
	movl (%r9), %ecx
	movl $0, %r9d
	imull $4, %r9d
	movslq %r9d, %r9
	addq %r9, %rdx
	movl %ecx, (%rdx)
	movq %r8, %rax
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.mergesort_3:
.mergesort_4:
	movl %r9d, %eax
	addl %r8d, %eax
	movl $2, %esi
	cltd
	idivl %esi
	movl %eax, %ebx
	movl %r9d, %edi
	movl %ebx, %esi
	movq %rcx, %rdx
	movq %rcx, %r14
	movq %r8, %r13
	movq %r9, %r12
	callq _c0_mergesort
	movq %r14, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movq %rax, %r12
	movl %ebx, %edi
	movl %r8d, %esi
	movq %rcx, %rdx
	movq %r8, %r14
	movq %r9, %r13
	callq _c0_mergesort
	movq %r14, %r8
	movq %r13, %r9
	movq %rax, %rdx
	movq %r12, %rcx
	movq (%rcx), %rsi
	movq %rdx, %rcx
	movq (%rcx), %rdi
	movl %ebx, %edx
	subl %r9d, %edx
	movl %r8d, %ecx
	subl %ebx, %ecx
	movq %rsi, %r8
	movq %rdi, %r9
	movl %edx, %edi
	movl %ecx, %esi
	movq %r8, %rdx
	movq %r9, %rcx
	callq _c0_merge
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
.main_0:
	movq $100, %rdi
	movq $4, %rsi
	callq calloc
	movq %rax, %r9
	movl $0, %r8d
.main_11:
.main_1:
	movl $1, %esi
	movl $100, %edx
	movl %r8d, %ecx
	cmpl %edx, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .main_3
.main_2:
	movl %r8d, %eax
	addl $17, %eax
	movl $28, %ecx
	cltd
	idivl %ecx
	movl %edx, %esi
	movl %r8d, %eax
	addl $3, %eax
	movl $13, %ecx
	cltd
	idivl %ecx
	movl %edx, %edi
	movl %r8d, %eax
	addl $21, %eax
	movl $75, %ecx
	cltd
	idivl %ecx
	movl %edx, %eax
	movl %r8d, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movl %esi, %edx
	addl %edi, %edx
	movl %edx, (%rcx)
	addl %eax, (%rcx)
	addl $1, %r8d
.main_10:
	jmp .main_1
.main_3:
	movl $0, %r8d
.main_13:
.main_4:
	movl $1, %esi
	movl $100, %edx
	movl %r8d, %ecx
	cmpl %edx, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .main_6
.main_5:
	movl %r8d, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movl (%rcx), %ecx
	movl %ecx, %edi
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
	addl $1, %r8d
.main_12:
	jmp .main_4
.main_6:
	movl $0, %edi
	movl $100, %esi
	movq %r9, %rdx
	callq _c0_mergesort
	movq %rax, %r9
	movl $10, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $10, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $10, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $0, %r8d
.main_15:
.main_7:
	movl $1, %esi
	movl $100, %edx
	movl %r8d, %ecx
	cmpl %edx, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .main_9
.main_8:
	movq %r9, %rcx
	movq (%rcx), %rsi
	movl %r8d, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %rsi, %rcx
	addq %rdx, %rcx
	movl (%rcx), %ecx
	movl %ecx, %edi
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
	addl $1, %r8d
.main_14:
	jmp .main_7
.main_9:
	movq (%r9), %r8
	movl $0, %r9d
	imull $4, %r9d
	movslq %r9d, %r9
	addq %r9, %r8
	movl (%r8), %r9d
	movl %r9d, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
