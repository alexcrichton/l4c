.file	"../tests1/lammergeier-torchic.l4"
.globl _c0_main
_c0_chic:
	addq $-8, %rsp
.chic_0:
	movl $0, %eax
	addq $8, %rsp
	ret
_c0_ch1c:
	addq $-8, %rsp
.ch1c_0:
	movl $10000000, %eax
	addq $8, %rsp
	ret
_c0_chick:
	addq $-8, %rsp
.chick_0:
	movl %edi, %eax
	addl $1, %eax
	addq $8, %rsp
	ret
_c0_ch1ck:
	addq $-8, %rsp
.ch1ck_0:
.ch1ck_5:
	movq %rdi, %rdx
	movl %esi, %ecx
.ch1ck_1:
	movl $1, %r8d
	movl $0, %r9d
	cmpl %ecx, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %r8d
	jnz .ch1ck_3
.ch1ck_2:
	movq $8, %r8
	movq %rdx, %r9
	addq %r8, %r9
	movq (%r9), %r9
	movq %r9, %r8
	movl %ecx, %r9d
	subl $1, %r9d
.ch1ck_4:
	movq %r8, %rdx
	movl %r9d, %ecx
	jmp .ch1ck_1
.ch1ck_3:
	movq $0, %r8
	movq %rdx, %r9
	addq %r8, %r9
	movl (%r9), %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
_c0_ch1ckk:
	addq $-8, %rsp
.ch1ckk_0:
	movl %edi, %eax
	xorl %esi, %eax
	addq $8, %rsp
	ret
_c0_ch1k:
	addq $-8, %rsp
.ch1k_0:
	movl $1342, %eax
	addq $8, %rsp
	ret
_c0_ch1kc:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movl %esi, %edx
.ch1kc_0:
	movl $1, %ecx
	movq $0, %rsi
	movq %rdi, %r8
	cmpq %rsi, %r8
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .ch1kc_3
.ch1kc_1:
	movl %edx, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ch1kc_3:
.ch1kc_4:
	movq $8, %r8
	movq %rdi, %r9
	addq %r8, %r9
	movq (%r9), %r9
	movl %edx, %edi
	movq %r9, %rbx
	callq _c0_chick
	movq %rbx, %r9
	movq %r9, %rdi
	movl %eax, %esi
	callq _c0_ch1kc
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_torchic:
	addq $-72, %rsp
	movq %rbp, 16(%rsp)
	movq %r15, 24(%rsp)
	movq %r14, 32(%rsp)
	movq %r13, 40(%rsp)
	movq %r12, 48(%rsp)
	movq %rbx, 56(%rsp)
.torchic_0:
	movq $1, %rdi
	movq $16, %rsi
	callq calloc
	movq %rax, %r9
	movq $1, %rdi
	movq $16, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl $4973, (%r8)
	movq $8, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movq %r9, (%r8)
	movq %rax, %r9
	movq $1, %rdi
	movq $16, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl $6081, (%r8)
	movq $8, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movq %r9, (%r8)
	movq %rax, %r9
	movq $1, %rdi
	movq $16, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movq $0, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movl $9314, (%rcx)
	movq $8, %rdx
	movq %rax, %rcx
	addq %rdx, %rcx
	movq %r9, (%rcx)
	movq %rax, %r9
	movq $1, %rdi
	movq $16, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl $5771, (%r8)
	movq $8, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movq %r9, (%r8)
	movq %rax, %r9
	movq $1, %rdi
	movq $16, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl $527, (%r8)
	movq $8, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movq %r9, (%r8)
	movq %rax, %r9
	movq $1, %rdi
	movq $16, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movq $0, %r8
	movq %r9, %rdx
	addq %r8, %rdx
	movl $628, (%rdx)
	movq $8, %rdx
	movq %rax, %r8
	addq %rdx, %r8
	movq %r9, (%r8)
	movq %rax, %r9
	movq $1, %rdi
	movq $16, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movq $0, %r8
	movq %r9, %rdx
	addq %r8, %rdx
	movl $2645, (%rdx)
	movq $8, %rdx
	movq %rax, %r8
	addq %rdx, %r8
	movq %r9, (%r8)
	movq %rax, %r9
	movq $1, %rdi
	movq $16, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl $251, (%r8)
	movq $8, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movq %r9, (%r8)
	movq %rax, %r9
	movq $1, %rdi
	movq $16, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl $8758, (%r8)
	movq $8, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movq %r9, (%r8)
	movq %rax, %r9
	movq $1, %rdi
	movq $16, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl $3030, (%r8)
	movq $8, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movq %r9, (%r8)
	movq %rax, %r9
	movq $1, %rdi
	movq $16, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl $2860, (%r8)
	movq $8, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movq %r9, (%r8)
	movq %rax, %r9
	movq $1, %rdi
	movq $16, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movq %rax, %r8
	movq $0, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movl $7483, (%rcx)
	movq $8, %rdx
	movq %r8, %rcx
	addq %rdx, %rcx
	movq %r9, (%rcx)
	movq %r8, %rcx
	movq %rcx, %r12
	movq %r8, %rbx
	callq _c0_chic
	movq %r12, %rcx
	movq %rbx, %r8
	movl %eax, %r9d
.torchic_9:
	movq %r8, %rdx
	movq %rcx, %r8
.torchic_1:
	movq %rdx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_ch1c
	movq %r13, %rdx
	movq %r12, %r8
	movq %rbx, %r9
	movl $1, %esi
	movl %r9d, %edi
	cmpl %eax, %edi
	setl %dil
	movzbl %dil, %edi
	cmpl %edi, %esi
	jnz .torchic_11
.torchic_2:
	movq $1, %rdi
	movq $16, %rsi
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, %rcx
	movq %r8, %rdi
	movl $7, %esi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_ch1ck
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %edx
	movq %r8, %rdi
	movl $10, %esi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_ch1ck
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %ebx
	movl %edx, %edi
	movl %ebx, %esi
	movq %rdx, %r15
	movq %rcx, %r14
	movq %r8, %r13
	movq %r9, %r12
	callq _c0_ch1ckk
	movq %r15, %rdx
	movq %r14, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movl %eax, %esi
	movq $0, %rax
	movq %r8, %rdi
	addq %rax, %rdi
	movl %esi, (%rdi)
	movq $0, %rax
	movq %r8, %rdi
	addq %rax, %rdi
	movl (%rdi), %edi
	movq %rdi, 64(%rsp)
	movq %rsi, %rbp
	movq %rdx, %r15
	movq %rcx, %r14
	movq %r8, %r13
	movq %r9, %r12
	callq _c0_ch1k
	movq 64(%rsp), %rdi
	movq %rbp, %rsi
	movq %r15, %rdx
	movq %r14, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movl $1, %r13d
	movl %edi, %r12d
	cmpl %eax, %r12d
	sete %r12b
	movzbl %r12b, %r12d
	cmpl %r12d, %r13d
	jnz .torchic_5
.torchic_3:
	jmp .torchic_10
.torchic_5:
.torchic_6:
	movq $8, %rsi
	movq %rcx, %rdx
	addq %rsi, %rdx
	movq %r8, (%rdx)
	movq %rcx, %r8
	movl %r9d, %edi
	movq %rcx, %r12
	movq %r8, %rbx
	callq _c0_chick
	movq %r12, %rcx
	movq %rbx, %r8
	movl %eax, %r9d
.torchic_8:
	movq %rcx, %rdx
	jmp .torchic_1
.torchic_11:
.torchic_7:
	movq %r8, %rbx
	callq _c0_chic
	movq %rbx, %r8
	movq %r8, %rdi
	movl %eax, %esi
	callq _c0_ch1kc
	movq 16(%rsp), %rbp
	movq 24(%rsp), %r15
	movq 32(%rsp), %r14
	movq 40(%rsp), %r13
	movq 48(%rsp), %r12
	movq 56(%rsp), %rbx
	addq $72, %rsp
	ret
.torchic_10:
	jmp .torchic_7
_c0_main:
	addq $-8, %rsp
.main_0:
	callq _c0_torchic
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
