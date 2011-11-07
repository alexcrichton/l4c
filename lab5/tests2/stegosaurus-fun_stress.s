.file	"../tests2/stegosaurus-fun_stress.l3"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1, %edi
	callq _c0_f26
	addq $8, %rsp
	ret
_c0_f0:
	addq $-8, %rsp
.f0_0:
	movl $1, %eax
	addq $8, %rsp
	ret
_c0_f1:
	addq $-8, %rsp
.f1_0:
	callq _c0_f0
	movl $2, %r8d
	imull %eax, %r8d
	movl $1, %r9d
	movl %r8d, %eax
	cltd
	idivl %r9d
	movl $2, %r9d
	addl %eax, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
_c0_f2:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movl %edi, %r9d
.f2_0:
	movl %r9d, %edi
	movq %r9, %rbx
	callq _c0_f0
	movq %rbx, %r9
	movl $2, %ecx
	imull %eax, %ecx
	movl $1, %r8d
	movl %ecx, %eax
	cltd
	idivl %r8d
	movl %eax, %r8d
	movl %r9d, %edi
	movq %r8, %rbx
	callq _c0_f1
	movq %rbx, %r8
	movl $2, %ecx
	imull %eax, %ecx
	movl $1, %r9d
	movl %ecx, %eax
	cltd
	idivl %r9d
	movl $3, %r9d
	addl %r8d, %r9d
	addl %eax, %r9d
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_f3:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
	movl %edi, %r9d
.f3_0:
	movl %r9d, %edi
	movq %r9, %rbx
	callq _c0_f0
	movq %rbx, %r9
	movl $2, %ecx
	imull %eax, %ecx
	movl $1, %r8d
	movl %ecx, %eax
	cltd
	idivl %r8d
	movl %eax, %ecx
	movl %r9d, %edi
	movq %rcx, %r12
	movq %r9, %rbx
	callq _c0_f1
	movq %r12, %rcx
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %r8d
	movl %edx, %eax
	cltd
	idivl %r8d
	movl %eax, %r8d
	movl %r9d, %edi
	movq %rcx, %r12
	movq %r8, %rbx
	callq _c0_f2
	movq %r12, %rcx
	movq %rbx, %r8
	movl $2, %edx
	imull %eax, %edx
	movl $1, %r9d
	movl %edx, %eax
	cltd
	idivl %r9d
	movl $4, %r9d
	addl %ecx, %r9d
	addl %r8d, %r9d
	addl %eax, %r9d
	movl %r9d, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_f4:
	addq $-40, %rsp
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
	movl %edi, %r9d
.f4_0:
	movl %r9d, %edi
	movq %r9, %rbx
	callq _c0_f0
	movq %rbx, %r9
	movl $2, %ecx
	imull %eax, %ecx
	movl $1, %r8d
	movl %ecx, %eax
	cltd
	idivl %r8d
	movl %eax, %esi
	movl %r9d, %edi
	movq %rsi, %r12
	movq %r9, %rbx
	callq _c0_f1
	movq %r12, %rsi
	movq %rbx, %r9
	movl $2, %ecx
	imull %eax, %ecx
	movl $1, %r8d
	movl %ecx, %eax
	cltd
	idivl %r8d
	movl %eax, %r8d
	movl %r9d, %edi
	movq %rsi, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f2
	movq %r13, %rsi
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %ecx
	movl %edx, %eax
	cltd
	idivl %ecx
	movl %eax, %ecx
	movl %r9d, %edi
	movq %rsi, %r13
	movq %rcx, %r12
	movq %r8, %rbx
	callq _c0_f3
	movq %r13, %rsi
	movq %r12, %rcx
	movq %rbx, %r8
	movl $2, %edx
	imull %eax, %edx
	movl $1, %r9d
	movl %edx, %eax
	cltd
	idivl %r9d
	movl $5, %r9d
	addl %esi, %r9d
	addl %r8d, %r9d
	addl %ecx, %r9d
	addl %eax, %r9d
	movl %r9d, %eax
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
_c0_f5:
	addq $-40, %rsp
	movq %r14, 8(%rsp)
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
	movl %edi, %r9d
.f5_0:
	movl %r9d, %edi
	movq %r9, %rbx
	callq _c0_f0
	movq %rbx, %r9
	movl $2, %ecx
	imull %eax, %ecx
	movl $1, %r8d
	movl %ecx, %eax
	cltd
	idivl %r8d
	movl %eax, %ebx
	movl %r9d, %edi
	movq %r9, %r12
	callq _c0_f1
	movq %r12, %r9
	movl $2, %ecx
	imull %eax, %ecx
	movl $1, %r8d
	movl %ecx, %eax
	cltd
	idivl %r8d
	movl %eax, %r8d
	movl %r9d, %edi
	movq %r8, %r13
	movq %r9, %r12
	callq _c0_f2
	movq %r13, %r8
	movq %r12, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %ecx
	movl %edx, %eax
	cltd
	idivl %ecx
	movl %eax, %ecx
	movl %r9d, %edi
	movq %rcx, %r14
	movq %r8, %r13
	movq %r9, %r12
	callq _c0_f3
	movq %r14, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, %esi
	movl %r9d, %edi
	movq %rsi, %r14
	movq %rcx, %r13
	movq %r8, %r12
	callq _c0_f4
	movq %r14, %rsi
	movq %r13, %rcx
	movq %r12, %r8
	movl $2, %edx
	imull %eax, %edx
	movl $1, %r9d
	movl %edx, %eax
	cltd
	idivl %r9d
	movl $6, %r9d
	addl %ebx, %r9d
	addl %r8d, %r9d
	addl %ecx, %r9d
	addl %esi, %r9d
	addl %eax, %r9d
	movl %r9d, %eax
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
_c0_f6:
	addq $-56, %rsp
	movq %r15, 16(%rsp)
	movq %r14, 24(%rsp)
	movq %r13, 32(%rsp)
	movq %r12, 40(%rsp)
	movq %rbx, 48(%rsp)
	movl %edi, %r9d
.f6_0:
	movl %r9d, %edi
	movq %r9, %rbx
	callq _c0_f0
	movq %rbx, %r9
	movl $2, %ecx
	imull %eax, %ecx
	movl $1, %r8d
	movl %ecx, %eax
	cltd
	idivl %r8d
	movl %eax, %ebx
	movl %r9d, %edi
	movq %r9, %r12
	callq _c0_f1
	movq %r12, %r9
	movl $2, %ecx
	imull %eax, %ecx
	movl $1, %r8d
	movl %ecx, %eax
	cltd
	idivl %r8d
	movl %eax, %r8d
	movl %r9d, %edi
	movq %r8, %r13
	movq %r9, %r12
	callq _c0_f2
	movq %r13, %r8
	movq %r12, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %ecx
	movl %edx, %eax
	cltd
	idivl %ecx
	movl %eax, %ecx
	movl %r9d, %edi
	movq %rcx, %r14
	movq %r8, %r13
	movq %r9, %r12
	callq _c0_f3
	movq %r14, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, %esi
	movl %r9d, %edi
	movq %rsi, %r15
	movq %rcx, %r14
	movq %r8, %r13
	movq %r9, %r12
	callq _c0_f4
	movq %r15, %rsi
	movq %r14, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, %r12d
	movl %r9d, %edi
	movq %rsi, %r15
	movq %rcx, %r14
	movq %r8, %r13
	callq _c0_f5
	movq %r15, %rsi
	movq %r14, %rcx
	movq %r13, %r8
	movl $2, %edx
	imull %eax, %edx
	movl $1, %r9d
	movl %edx, %eax
	cltd
	idivl %r9d
	movl $7, %r9d
	addl %ebx, %r9d
	addl %r8d, %r9d
	addl %ecx, %r9d
	addl %esi, %r9d
	addl %r12d, %r9d
	addl %eax, %r9d
	movl %r9d, %eax
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
_c0_f7:
	addq $-56, %rsp
	movq %rbp, 8(%rsp)
	movq %r15, 16(%rsp)
	movq %r14, 24(%rsp)
	movq %r13, 32(%rsp)
	movq %r12, 40(%rsp)
	movq %rbx, 48(%rsp)
	movl %edi, %r9d
.f7_0:
	movl %r9d, %edi
	movq %r9, %rbx
	callq _c0_f0
	movq %rbx, %r9
	movl $2, %ecx
	imull %eax, %ecx
	movl $1, %r8d
	movl %ecx, %eax
	cltd
	idivl %r8d
	movl %eax, %ebx
	movl %r9d, %edi
	movq %r9, %r12
	callq _c0_f1
	movq %r12, %r9
	movl $2, %ecx
	imull %eax, %ecx
	movl $1, %r8d
	movl %ecx, %eax
	cltd
	idivl %r8d
	movl %eax, %r8d
	movl %r9d, %edi
	movq %r8, %r13
	movq %r9, %r12
	callq _c0_f2
	movq %r13, %r8
	movq %r12, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %ecx
	movl %edx, %eax
	cltd
	idivl %ecx
	movl %eax, %ecx
	movl %r9d, %edi
	movq %rcx, %r14
	movq %r8, %r13
	movq %r9, %r12
	callq _c0_f3
	movq %r14, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, %esi
	movl %r9d, %edi
	movq %rsi, %r15
	movq %rcx, %r14
	movq %r8, %r13
	movq %r9, %r12
	callq _c0_f4
	movq %r15, %rsi
	movq %r14, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, %r12d
	movl %r9d, %edi
	movq %rsi, %rbp
	movq %rcx, %r15
	movq %r8, %r14
	movq %r9, %r13
	callq _c0_f5
	movq %rbp, %rsi
	movq %r15, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, %r13d
	movl %r9d, %edi
	movq %rsi, %rbp
	movq %rcx, %r15
	movq %r8, %r14
	callq _c0_f6
	movq %rbp, %rsi
	movq %r15, %rcx
	movq %r14, %r8
	movl $2, %edx
	imull %eax, %edx
	movl $1, %r9d
	movl %edx, %eax
	cltd
	idivl %r9d
	movl $8, %r9d
	addl %ebx, %r9d
	addl %r8d, %r9d
	addl %ecx, %r9d
	addl %esi, %r9d
	addl %r12d, %r9d
	addl %r13d, %r9d
	addl %eax, %r9d
	movl %r9d, %eax
	movq 8(%rsp), %rbp
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
_c0_f8:
	addq $-72, %rsp
	movq %rbp, 16(%rsp)
	movq %r15, 24(%rsp)
	movq %r14, 32(%rsp)
	movq %r13, 40(%rsp)
	movq %r12, 48(%rsp)
	movq %rbx, 56(%rsp)
	movl %edi, %r9d
.f8_0:
	movl %r9d, %edi
	movq %r9, %rbx
	callq _c0_f0
	movq %rbx, %r9
	movl $2, %ecx
	imull %eax, %ecx
	movl $1, %r8d
	movl %ecx, %eax
	cltd
	idivl %r8d
	movl %eax, %r12d
	movl %r9d, %edi
	movq %r9, %rbx
	callq _c0_f1
	movq %rbx, %r9
	movl $2, %ecx
	imull %eax, %ecx
	movl $1, %r8d
	movl %ecx, %eax
	cltd
	idivl %r8d
	movl %eax, %r8d
	movl %r9d, %edi
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f2
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %ecx
	movl %edx, %eax
	cltd
	idivl %ecx
	movl %eax, %ecx
	movl %r9d, %edi
	movq %rcx, %r14
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f3
	movq %r14, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, %ebx
	movl %r9d, %edi
	movq %rcx, %r15
	movq %r8, %r14
	movq %r9, %r13
	callq _c0_f4
	movq %r15, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, %r13d
	movl %r9d, %edi
	movq %rcx, %rbp
	movq %r8, %r15
	movq %r9, %r14
	callq _c0_f5
	movq %rbp, %rcx
	movq %r15, %r8
	movq %r14, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, %r14d
	movl %r9d, %edi
	movq %rcx, 64(%rsp)
	movq %r8, %rbp
	movq %r9, %r15
	callq _c0_f6
	movq 64(%rsp), %rcx
	movq %rbp, %r8
	movq %r15, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, %esi
	movl %r9d, %edi
	movq %rsi, 64(%rsp)
	movq %rcx, %rbp
	movq %r8, %r15
	callq _c0_f7
	movq 64(%rsp), %rsi
	movq %rbp, %rcx
	movq %r15, %r8
	movl $2, %edx
	imull %eax, %edx
	movl $1, %r9d
	movl %edx, %eax
	cltd
	idivl %r9d
	movl $9, %r9d
	addl %r12d, %r9d
	addl %r8d, %r9d
	addl %ecx, %r9d
	addl %ebx, %r9d
	addl %r13d, %r9d
	addl %r14d, %r9d
	addl %esi, %r9d
	addl %eax, %r9d
	movl %r9d, %eax
	movq 16(%rsp), %rbp
	movq 24(%rsp), %r15
	movq 32(%rsp), %r14
	movq 40(%rsp), %r13
	movq 48(%rsp), %r12
	movq 56(%rsp), %rbx
	addq $72, %rsp
	ret
_c0_f9:
	addq $-72, %rsp
	movq %rbp, 8(%rsp)
	movq %r15, 16(%rsp)
	movq %r14, 24(%rsp)
	movq %r13, 32(%rsp)
	movq %r12, 40(%rsp)
	movq %rbx, 48(%rsp)
	movl %edi, %r9d
.f9_0:
	movl %r9d, %edi
	movq %r9, %rbx
	callq _c0_f0
	movq %rbx, %r9
	movl $2, %ecx
	imull %eax, %ecx
	movl $1, %r8d
	movl %ecx, %eax
	cltd
	idivl %r8d
	movl %eax, %r13d
	movl %r9d, %edi
	movq %r9, %rbx
	callq _c0_f1
	movq %rbx, %r9
	movl $2, %ecx
	imull %eax, %ecx
	movl $1, %r8d
	movl %ecx, %eax
	cltd
	idivl %r8d
	movl %eax, %r8d
	movl %r9d, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f2
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %ecx
	movl %edx, %eax
	cltd
	idivl %ecx
	movl %eax, %ecx
	movl %r9d, %edi
	movq %rcx, %r14
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f3
	movq %r14, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edi
	imull %eax, %edi
	movl $1, %esi
	movl %edi, %eax
	cltd
	idivl %esi
	movl %eax, %ebx
	movl %r9d, %edi
	movq %rcx, %r15
	movq %r8, %r14
	movq %r9, %r12
	callq _c0_f4
	movq %r15, %rcx
	movq %r14, %r8
	movq %r12, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, %r14d
	movl %r9d, %edi
	movq %rcx, %rbp
	movq %r8, %r15
	movq %r9, %r12
	callq _c0_f5
	movq %rbp, %rcx
	movq %r15, %r8
	movq %r12, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, %r15d
	movl %r9d, %edi
	movq %rcx, 56(%rsp)
	movq %r8, %rbp
	movq %r9, %r12
	callq _c0_f6
	movq 56(%rsp), %rcx
	movq %rbp, %r8
	movq %r12, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, %esi
	movl %r9d, %edi
	movq %rsi, 64(%rsp)
	movq %rcx, 56(%rsp)
	movq %r8, %rbp
	movq %r9, %r12
	callq _c0_f7
	movq 64(%rsp), %rsi
	movq 56(%rsp), %rcx
	movq %rbp, %r8
	movq %r12, %r9
	movl %eax, %edx
	movl $2, %eax
	imull %edx, %eax
	movl $1, %edi
	cltd
	idivl %edi
	movl %eax, %r12d
	movl %r9d, %edi
	movq %rsi, 64(%rsp)
	movq %rcx, 56(%rsp)
	movq %r8, %rbp
	callq _c0_f8
	movq 64(%rsp), %rsi
	movq 56(%rsp), %rcx
	movq %rbp, %r8
	movl $2, %edx
	imull %eax, %edx
	movl $1, %r9d
	movl %edx, %eax
	cltd
	idivl %r9d
	movl $10, %r9d
	addl %r13d, %r9d
	addl %r8d, %r9d
	addl %ecx, %r9d
	addl %ebx, %r9d
	addl %r14d, %r9d
	addl %r15d, %r9d
	addl %esi, %r9d
	addl %r12d, %r9d
	addl %eax, %r9d
	movl %r9d, %eax
	movq 8(%rsp), %rbp
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $72, %rsp
	ret
_c0_f10:
	addq $-88, %rsp
	movq %rbp, 16(%rsp)
	movq %r15, 24(%rsp)
	movq %r14, 32(%rsp)
	movq %r13, 40(%rsp)
	movq %r12, 48(%rsp)
	movq %rbx, 56(%rsp)
	movl %edi, %r9d
.f10_0:
	movl %r9d, %edi
	movq %r9, %rbx
	callq _c0_f0
	movq %rbx, %r9
	movl $2, %ecx
	imull %eax, %ecx
	movl $1, %r8d
	movl %ecx, %eax
	cltd
	idivl %r8d
	movl %eax, %r14d
	movl %r9d, %edi
	movq %r9, %rbx
	callq _c0_f1
	movq %rbx, %r9
	movl $2, %ecx
	imull %eax, %ecx
	movl $1, %r8d
	movl %ecx, %eax
	cltd
	idivl %r8d
	movl %eax, %r8d
	movl %r9d, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f2
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %ecx
	movl %edx, %eax
	cltd
	idivl %ecx
	movl %eax, %ecx
	movl %r9d, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f3
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edi
	imull %eax, %edi
	movl $1, %esi
	movl %edi, %eax
	cltd
	idivl %esi
	movl %eax, %ebx
	movl %r9d, %edi
	movq %rcx, %r15
	movq %r8, %r13
	movq %r9, %r12
	callq _c0_f4
	movq %r15, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, %r15d
	movl %r9d, %edi
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %r12
	callq _c0_f5
	movq %rbp, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, %ebp
	movl %r9d, %edi
	movq %rcx, 64(%rsp)
	movq %r8, %r13
	movq %r9, %r12
	callq _c0_f6
	movq 64(%rsp), %rcx
	movq %r13, %r8
	movq %r12, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, %esi
	movl %r9d, %edi
	movq %rsi, 72(%rsp)
	movq %rcx, 64(%rsp)
	movq %r8, %r13
	movq %r9, %r12
	callq _c0_f7
	movq 72(%rsp), %rsi
	movq 64(%rsp), %rcx
	movq %r13, %r8
	movq %r12, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, %r12d
	movl %r9d, %edi
	movq %rsi, 80(%rsp)
	movq %rcx, 72(%rsp)
	movq %r8, 64(%rsp)
	movq %r9, %r13
	callq _c0_f8
	movq 80(%rsp), %rsi
	movq 72(%rsp), %rcx
	movq 64(%rsp), %r8
	movq %r13, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, %r13d
	movl %r9d, %edi
	movq %rsi, 80(%rsp)
	movq %rcx, 72(%rsp)
	movq %r8, 64(%rsp)
	callq _c0_f9
	movq 80(%rsp), %rsi
	movq 72(%rsp), %rcx
	movq 64(%rsp), %r8
	movl $2, %edx
	imull %eax, %edx
	movl $1, %r9d
	movl %edx, %eax
	cltd
	idivl %r9d
	movl $11, %r9d
	addl %r14d, %r9d
	addl %r8d, %r9d
	addl %ecx, %r9d
	addl %ebx, %r9d
	addl %r15d, %r9d
	addl %ebp, %r9d
	addl %esi, %r9d
	addl %r12d, %r9d
	addl %r13d, %r9d
	addl %eax, %r9d
	movl %r9d, %eax
	movq 16(%rsp), %rbp
	movq 24(%rsp), %r15
	movq 32(%rsp), %r14
	movq 40(%rsp), %r13
	movq 48(%rsp), %r12
	movq 56(%rsp), %rbx
	addq $88, %rsp
	ret
_c0_f11:
	addq $-88, %rsp
	movq %rbp, 12(%rsp)
	movq %r15, 20(%rsp)
	movq %r14, 28(%rsp)
	movq %r13, 36(%rsp)
	movq %r12, 44(%rsp)
	movq %rbx, 52(%rsp)
	movl %edi, %r9d
.f11_0:
	movl %r9d, %edi
	movq %r9, %rbx
	callq _c0_f0
	movq %rbx, %r9
	movl $2, %ecx
	imull %eax, %ecx
	movl $1, %r8d
	movl %ecx, %eax
	cltd
	idivl %r8d
	movl %eax, %r14d
	movl %r9d, %edi
	movq %r9, %rbx
	callq _c0_f1
	movq %rbx, %r9
	movl $2, %ecx
	imull %eax, %ecx
	movl $1, %r8d
	movl %ecx, %eax
	cltd
	idivl %r8d
	movl %eax, %r8d
	movl %r9d, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f2
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %ecx
	movl %edx, %eax
	cltd
	idivl %ecx
	movl %eax, %ecx
	movl %r9d, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f3
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edi
	imull %eax, %edi
	movl $1, %esi
	movl %edi, %eax
	cltd
	idivl %esi
	movl %eax, %ebx
	movl %r9d, %edi
	movq %rcx, %r15
	movq %r8, %r13
	movq %r9, %r12
	callq _c0_f4
	movq %r15, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movl $2, %edi
	imull %eax, %edi
	movl $1, %esi
	movl %edi, %eax
	cltd
	idivl %esi
	movl %eax, %r15d
	movl %r9d, %edi
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %r12
	callq _c0_f5
	movq %rbp, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, 84(%rsp)
	movl %r9d, %edi
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %r12
	callq _c0_f6
	movq %rbp, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, %esi
	movl %r9d, %edi
	movq %rsi, 60(%rsp)
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %r12
	callq _c0_f7
	movq 60(%rsp), %rsi
	movq %rbp, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, %r12d
	movl %r9d, %edi
	movq %rsi, 68(%rsp)
	movq %rcx, 60(%rsp)
	movq %r8, %rbp
	movq %r9, %r13
	callq _c0_f8
	movq 68(%rsp), %rsi
	movq 60(%rsp), %rcx
	movq %rbp, %r8
	movq %r13, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, %r13d
	movl %r9d, %edi
	movq %rsi, 76(%rsp)
	movq %rcx, 68(%rsp)
	movq %r8, 60(%rsp)
	movq %r9, %rbp
	callq _c0_f9
	movq 76(%rsp), %rsi
	movq 68(%rsp), %rcx
	movq 60(%rsp), %r8
	movq %rbp, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, %ebp
	movl %r9d, %edi
	movq %rsi, 76(%rsp)
	movq %rcx, 68(%rsp)
	movq %r8, 60(%rsp)
	callq _c0_f10
	movq 76(%rsp), %rsi
	movq 68(%rsp), %rcx
	movq 60(%rsp), %r8
	movl $2, %edx
	imull %eax, %edx
	movl $1, %r9d
	movl %edx, %eax
	cltd
	idivl %r9d
	movl $12, %r9d
	addl %r14d, %r9d
	addl %r8d, %r9d
	addl %ecx, %r9d
	addl %ebx, %r9d
	addl %r15d, %r9d
	addl 84(%rsp), %r9d
	addl %esi, %r9d
	addl %r12d, %r9d
	addl %r13d, %r9d
	addl %ebp, %r9d
	addl %eax, %r9d
	movl %r9d, %eax
	movq 12(%rsp), %rbp
	movq 20(%rsp), %r15
	movq 28(%rsp), %r14
	movq 36(%rsp), %r13
	movq 44(%rsp), %r12
	movq 52(%rsp), %rbx
	addq $88, %rsp
	ret
_c0_f12:
	addq $-104, %rsp
	movq %rbp, 16(%rsp)
	movq %r15, 24(%rsp)
	movq %r14, 32(%rsp)
	movq %r13, 40(%rsp)
	movq %r12, 48(%rsp)
	movq %rbx, 56(%rsp)
	movl %edi, %r9d
.f12_0:
	movl %r9d, %edi
	movq %r9, %rbx
	callq _c0_f0
	movq %rbx, %r9
	movl $2, %ecx
	imull %eax, %ecx
	movl $1, %r8d
	movl %ecx, %eax
	cltd
	idivl %r8d
	movl %eax, %r14d
	movl %r9d, %edi
	movq %r9, %rbx
	callq _c0_f1
	movq %rbx, %r9
	movl $2, %ecx
	imull %eax, %ecx
	movl $1, %r8d
	movl %ecx, %eax
	cltd
	idivl %r8d
	movl %eax, %r8d
	movl %r9d, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f2
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %ecx
	movl %edx, %eax
	cltd
	idivl %ecx
	movl %eax, %ecx
	movl %r9d, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f3
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edi
	imull %eax, %edi
	movl $1, %esi
	movl %edi, %eax
	cltd
	idivl %esi
	movl %eax, %ebx
	movl %r9d, %edi
	movq %rcx, %r15
	movq %r8, %r13
	movq %r9, %r12
	callq _c0_f4
	movq %r15, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movl $2, %edi
	imull %eax, %edi
	movl $1, %esi
	movl %edi, %eax
	cltd
	idivl %esi
	movl %eax, %r15d
	movl %r9d, %edi
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %r12
	callq _c0_f5
	movq %rbp, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, 96(%rsp)
	movl %r9d, %edi
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %r12
	callq _c0_f6
	movq %rbp, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, %esi
	movl %r9d, %edi
	movq %rsi, 64(%rsp)
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %r12
	callq _c0_f7
	movq 64(%rsp), %rsi
	movq %rbp, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, %r12d
	movl %r9d, %edi
	movq %rsi, 72(%rsp)
	movq %rcx, 64(%rsp)
	movq %r8, %rbp
	movq %r9, %r13
	callq _c0_f8
	movq 72(%rsp), %rsi
	movq 64(%rsp), %rcx
	movq %rbp, %r8
	movq %r13, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, %r13d
	movl %r9d, %edi
	movq %rsi, 80(%rsp)
	movq %rcx, 72(%rsp)
	movq %r8, 64(%rsp)
	movq %r9, %rbp
	callq _c0_f9
	movq 80(%rsp), %rsi
	movq 72(%rsp), %rcx
	movq 64(%rsp), %r8
	movq %rbp, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, %ebp
	movl %r9d, %edi
	movq %rsi, 88(%rsp)
	movq %rcx, 80(%rsp)
	movq %r8, 72(%rsp)
	movq %r9, 64(%rsp)
	callq _c0_f10
	movq 88(%rsp), %rsi
	movq 80(%rsp), %rcx
	movq 72(%rsp), %r8
	movq 64(%rsp), %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, 100(%rsp)
	movl %r9d, %edi
	movq %rsi, 88(%rsp)
	movq %rcx, 80(%rsp)
	movq %r8, 72(%rsp)
	callq _c0_f11
	movq 88(%rsp), %rsi
	movq 80(%rsp), %rcx
	movq 72(%rsp), %r8
	movl $2, %edx
	imull %eax, %edx
	movl $1, %r9d
	movl %edx, %eax
	cltd
	idivl %r9d
	movl $13, %r9d
	addl %r14d, %r9d
	addl %r8d, %r9d
	addl %ecx, %r9d
	addl %ebx, %r9d
	addl %r15d, %r9d
	addl 96(%rsp), %r9d
	addl %esi, %r9d
	addl %r12d, %r9d
	addl %r13d, %r9d
	addl %ebp, %r9d
	addl 100(%rsp), %r9d
	addl %eax, %r9d
	movl %r9d, %eax
	movq 16(%rsp), %rbp
	movq 24(%rsp), %r15
	movq 32(%rsp), %r14
	movq 40(%rsp), %r13
	movq 48(%rsp), %r12
	movq 56(%rsp), %rbx
	addq $104, %rsp
	ret
_c0_f13:
	addq $-104, %rsp
	movq %rbp, 4(%rsp)
	movq %r15, 12(%rsp)
	movq %r14, 20(%rsp)
	movq %r13, 28(%rsp)
	movq %r12, 36(%rsp)
	movq %rbx, 44(%rsp)
	movl %edi, %r9d
.f13_0:
	movl %r9d, %edi
	movq %r9, %rbx
	callq _c0_f0
	movq %rbx, %r9
	movl $2, %ecx
	imull %eax, %ecx
	movl $1, %r8d
	movl %ecx, %eax
	cltd
	idivl %r8d
	movl %eax, %r14d
	movl %r9d, %edi
	movq %r9, %rbx
	callq _c0_f1
	movq %rbx, %r9
	movl $2, %ecx
	imull %eax, %ecx
	movl $1, %r8d
	movl %ecx, %eax
	cltd
	idivl %r8d
	movl %eax, %r8d
	movl %r9d, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f2
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %ecx
	movl %edx, %eax
	cltd
	idivl %ecx
	movl %eax, %ecx
	movl %r9d, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f3
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edi
	imull %eax, %edi
	movl $1, %esi
	movl %edi, %eax
	cltd
	idivl %esi
	movl %eax, %ebx
	movl %r9d, %edi
	movq %rcx, %r15
	movq %r8, %r13
	movq %r9, %r12
	callq _c0_f4
	movq %r15, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movl $2, %edi
	imull %eax, %edi
	movl $1, %esi
	movl %edi, %eax
	cltd
	idivl %esi
	movl %eax, %r15d
	movl %r9d, %edi
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %r12
	callq _c0_f5
	movq %rbp, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, 92(%rsp)
	movl %r9d, %edi
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %r12
	callq _c0_f6
	movq %rbp, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, %esi
	movl %r9d, %edi
	movq %rsi, 52(%rsp)
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %r12
	callq _c0_f7
	movq 52(%rsp), %rsi
	movq %rbp, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, %r12d
	movl %r9d, %edi
	movq %rsi, 60(%rsp)
	movq %rcx, 52(%rsp)
	movq %r8, %rbp
	movq %r9, %r13
	callq _c0_f8
	movq 60(%rsp), %rsi
	movq 52(%rsp), %rcx
	movq %rbp, %r8
	movq %r13, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, %r13d
	movl %r9d, %edi
	movq %rsi, 68(%rsp)
	movq %rcx, 60(%rsp)
	movq %r8, 52(%rsp)
	movq %r9, %rbp
	callq _c0_f9
	movq 68(%rsp), %rsi
	movq 60(%rsp), %rcx
	movq 52(%rsp), %r8
	movq %rbp, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, %ebp
	movl %r9d, %edi
	movq %rsi, 76(%rsp)
	movq %rcx, 68(%rsp)
	movq %r8, 60(%rsp)
	movq %r9, 52(%rsp)
	callq _c0_f10
	movq 76(%rsp), %rsi
	movq 68(%rsp), %rcx
	movq 60(%rsp), %r8
	movq 52(%rsp), %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, 96(%rsp)
	movl %r9d, %edi
	movq %rsi, 84(%rsp)
	movq %rcx, 76(%rsp)
	movq %r8, 68(%rsp)
	movq %r9, 60(%rsp)
	callq _c0_f11
	movq 84(%rsp), %rsi
	movq 76(%rsp), %rcx
	movq 68(%rsp), %r8
	movq 60(%rsp), %r9
	movl %eax, %edx
	movl $2, %eax
	imull %edx, %eax
	movl $1, %edi
	cltd
	idivl %edi
	movl %eax, 100(%rsp)
	movl %r9d, %edi
	movq %rsi, 84(%rsp)
	movq %rcx, 76(%rsp)
	movq %r8, 68(%rsp)
	callq _c0_f12
	movq 84(%rsp), %rsi
	movq 76(%rsp), %rcx
	movq 68(%rsp), %r8
	movl $2, %edx
	imull %eax, %edx
	movl $1, %r9d
	movl %edx, %eax
	cltd
	idivl %r9d
	movl $14, %r9d
	addl %r14d, %r9d
	addl %r8d, %r9d
	addl %ecx, %r9d
	addl %ebx, %r9d
	addl %r15d, %r9d
	addl 92(%rsp), %r9d
	addl %esi, %r9d
	addl %r12d, %r9d
	addl %r13d, %r9d
	addl %ebp, %r9d
	addl 96(%rsp), %r9d
	addl 100(%rsp), %r9d
	addl %eax, %r9d
	movl %r9d, %eax
	movq 4(%rsp), %rbp
	movq 12(%rsp), %r15
	movq 20(%rsp), %r14
	movq 28(%rsp), %r13
	movq 36(%rsp), %r12
	movq 44(%rsp), %rbx
	addq $104, %rsp
	ret
_c0_f14:
	addq $-120, %rsp
	movq %rbp, 8(%rsp)
	movq %r15, 16(%rsp)
	movq %r14, 24(%rsp)
	movq %r13, 32(%rsp)
	movq %r12, 40(%rsp)
	movq %rbx, 48(%rsp)
	movl %edi, %r9d
.f14_0:
	movl %r9d, %edi
	movq %r9, %rbx
	callq _c0_f0
	movq %rbx, %r9
	movl $2, %ecx
	imull %eax, %ecx
	movl $1, %r8d
	movl %ecx, %eax
	cltd
	idivl %r8d
	movl %eax, %r15d
	movl %r9d, %edi
	movq %r9, %rbx
	callq _c0_f1
	movq %rbx, %r9
	movl $2, %ecx
	imull %eax, %ecx
	movl $1, %r8d
	movl %ecx, %eax
	cltd
	idivl %r8d
	movl %eax, %r8d
	movl %r9d, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f2
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %ecx
	movl %edx, %eax
	cltd
	idivl %ecx
	movl %eax, %ecx
	movl %r9d, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f3
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edi
	imull %eax, %edi
	movl $1, %esi
	movl %edi, %eax
	cltd
	idivl %esi
	movl %eax, %r12d
	movl %r9d, %edi
	movq %rcx, %r14
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f4
	movq %r14, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edi
	imull %eax, %edi
	movl $1, %esi
	movl %edi, %eax
	cltd
	idivl %esi
	movl %eax, %ebp
	movl %r9d, %edi
	movq %rcx, %r14
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f5
	movq %r14, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edi
	imull %eax, %edi
	movl $1, %esi
	movl %edi, %eax
	cltd
	idivl %esi
	movl %eax, 104(%rsp)
	movl %r9d, %edi
	movq %rcx, %r14
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f6
	movq %r14, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, %ebx
	movl %r9d, %edi
	movq %rcx, 56(%rsp)
	movq %r8, %r14
	movq %r9, %r13
	callq _c0_f7
	movq 56(%rsp), %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, %r13d
	movl %r9d, %edi
	movq %rcx, 64(%rsp)
	movq %r8, 56(%rsp)
	movq %r9, %r14
	callq _c0_f8
	movq 64(%rsp), %rcx
	movq 56(%rsp), %r8
	movq %r14, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, %r14d
	movl %r9d, %edi
	movq %rcx, 72(%rsp)
	movq %r8, 64(%rsp)
	movq %r9, 56(%rsp)
	callq _c0_f9
	movq 72(%rsp), %rcx
	movq 64(%rsp), %r8
	movq 56(%rsp), %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, 108(%rsp)
	movl %r9d, %edi
	movq %rcx, 80(%rsp)
	movq %r8, 72(%rsp)
	movq %r9, 64(%rsp)
	callq _c0_f10
	movq 80(%rsp), %rcx
	movq 72(%rsp), %r8
	movq 64(%rsp), %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, 112(%rsp)
	movl %r9d, %edi
	movq %rcx, 88(%rsp)
	movq %r8, 80(%rsp)
	movq %r9, 72(%rsp)
	callq _c0_f11
	movq 88(%rsp), %rcx
	movq 80(%rsp), %r8
	movq 72(%rsp), %r9
	movl $2, %edi
	imull %eax, %edi
	movl $1, %esi
	movl %edi, %eax
	cltd
	idivl %esi
	movl %eax, 116(%rsp)
	movl %r9d, %edi
	movq %rcx, 96(%rsp)
	movq %r8, 88(%rsp)
	movq %r9, 80(%rsp)
	callq _c0_f12
	movq 96(%rsp), %rcx
	movq 88(%rsp), %r8
	movq 80(%rsp), %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, %esi
	movl %r9d, %edi
	movq %rsi, 96(%rsp)
	movq %rcx, 88(%rsp)
	movq %r8, 80(%rsp)
	callq _c0_f13
	movq 96(%rsp), %rsi
	movq 88(%rsp), %rcx
	movq 80(%rsp), %r8
	movl $2, %edx
	imull %eax, %edx
	movl $1, %r9d
	movl %edx, %eax
	cltd
	idivl %r9d
	movl $15, %r9d
	addl %r15d, %r9d
	addl %r8d, %r9d
	addl %ecx, %r9d
	addl %r12d, %r9d
	addl %ebp, %r9d
	addl 104(%rsp), %r9d
	addl %ebx, %r9d
	addl %r13d, %r9d
	addl %r14d, %r9d
	addl 108(%rsp), %r9d
	addl 112(%rsp), %r9d
	addl 116(%rsp), %r9d
	addl %esi, %r9d
	addl %eax, %r9d
	movl %r9d, %eax
	movq 8(%rsp), %rbp
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $120, %rsp
	ret
_c0_f15:
	addq $-120, %rsp
	movq %rbp, 4(%rsp)
	movq %r15, 12(%rsp)
	movq %r14, 20(%rsp)
	movq %r13, 28(%rsp)
	movq %r12, 36(%rsp)
	movq %rbx, 44(%rsp)
	movl %edi, %r9d
.f15_0:
	movl %r9d, %edi
	movq %r9, %rbx
	callq _c0_f0
	movq %rbx, %r9
	movl $2, %ecx
	imull %eax, %ecx
	movl $1, %r8d
	movl %ecx, %eax
	cltd
	idivl %r8d
	movl %eax, %ebp
	movl %r9d, %edi
	movq %r9, %rbx
	callq _c0_f1
	movq %rbx, %r9
	movl $2, %ecx
	imull %eax, %ecx
	movl $1, %r8d
	movl %ecx, %eax
	cltd
	idivl %r8d
	movl %eax, %r8d
	movl %r9d, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f2
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %ecx
	movl %edx, %eax
	cltd
	idivl %ecx
	movl %eax, %ecx
	movl %r9d, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f3
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edi
	imull %eax, %edi
	movl $1, %esi
	movl %edi, %eax
	cltd
	idivl %esi
	movl %eax, %r13d
	movl %r9d, %edi
	movq %rcx, %r14
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f4
	movq %r14, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edi
	imull %eax, %edi
	movl $1, %esi
	movl %edi, %eax
	cltd
	idivl %esi
	movl %eax, 100(%rsp)
	movl %r9d, %edi
	movq %rcx, %r14
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f5
	movq %r14, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edi
	imull %eax, %edi
	movl $1, %esi
	movl %edi, %eax
	cltd
	idivl %esi
	movl %eax, 104(%rsp)
	movl %r9d, %edi
	movq %rcx, %r14
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f6
	movq %r14, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, %r12d
	movl %r9d, %edi
	movq %rcx, %r15
	movq %r8, %r14
	movq %r9, %rbx
	callq _c0_f7
	movq %r15, %rcx
	movq %r14, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, %r14d
	movl %r9d, %edi
	movq %rcx, 52(%rsp)
	movq %r8, %r15
	movq %r9, %rbx
	callq _c0_f8
	movq 52(%rsp), %rcx
	movq %r15, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, %r15d
	movl %r9d, %edi
	movq %rcx, 60(%rsp)
	movq %r8, 52(%rsp)
	movq %r9, %rbx
	callq _c0_f9
	movq 60(%rsp), %rcx
	movq 52(%rsp), %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, 108(%rsp)
	movl %r9d, %edi
	movq %rcx, 68(%rsp)
	movq %r8, 60(%rsp)
	movq %r9, %rbx
	callq _c0_f10
	movq 68(%rsp), %rcx
	movq 60(%rsp), %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, 112(%rsp)
	movl %r9d, %edi
	movq %rcx, 76(%rsp)
	movq %r8, 68(%rsp)
	movq %r9, %rbx
	callq _c0_f11
	movq 76(%rsp), %rcx
	movq 68(%rsp), %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, 116(%rsp)
	movl %r9d, %edi
	movq %rcx, 84(%rsp)
	movq %r8, 76(%rsp)
	movq %r9, %rbx
	callq _c0_f12
	movq 84(%rsp), %rcx
	movq 76(%rsp), %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, %esi
	movl %r9d, %edi
	movq %rsi, 92(%rsp)
	movq %rcx, 84(%rsp)
	movq %r8, 76(%rsp)
	movq %r9, %rbx
	callq _c0_f13
	movq 92(%rsp), %rsi
	movq 84(%rsp), %rcx
	movq 76(%rsp), %r8
	movq %rbx, %r9
	movl %eax, %edx
	movl $2, %eax
	imull %edx, %eax
	movl $1, %edi
	cltd
	idivl %edi
	movl %eax, %ebx
	movl %r9d, %edi
	movq %rsi, 92(%rsp)
	movq %rcx, 84(%rsp)
	movq %r8, 76(%rsp)
	callq _c0_f14
	movq 92(%rsp), %rsi
	movq 84(%rsp), %rcx
	movq 76(%rsp), %r8
	movl $2, %edx
	imull %eax, %edx
	movl $1, %r9d
	movl %edx, %eax
	cltd
	idivl %r9d
	movl $16, %r9d
	addl %ebp, %r9d
	addl %r8d, %r9d
	addl %ecx, %r9d
	addl %r13d, %r9d
	addl 100(%rsp), %r9d
	addl 104(%rsp), %r9d
	addl %r12d, %r9d
	addl %r14d, %r9d
	addl %r15d, %r9d
	addl 108(%rsp), %r9d
	addl 112(%rsp), %r9d
	addl 116(%rsp), %r9d
	addl %esi, %r9d
	addl %ebx, %r9d
	addl %eax, %r9d
	movl %r9d, %eax
	movq 4(%rsp), %rbp
	movq 12(%rsp), %r15
	movq 20(%rsp), %r14
	movq 28(%rsp), %r13
	movq 36(%rsp), %r12
	movq 44(%rsp), %rbx
	addq $120, %rsp
	ret
_c0_f16:
	addq $-136, %rsp
	movq %rbp, 16(%rsp)
	movq %r15, 24(%rsp)
	movq %r14, 32(%rsp)
	movq %r13, 40(%rsp)
	movq %r12, 48(%rsp)
	movq %rbx, 56(%rsp)
	movl %edi, %r9d
.f16_0:
	movl %r9d, %edi
	movq %r9, %rbx
	callq _c0_f0
	movq %rbx, %r9
	movl $2, %ecx
	imull %eax, %ecx
	movl $1, %r8d
	movl %ecx, %eax
	cltd
	idivl %r8d
	movl %eax, 112(%rsp)
	movl %r9d, %edi
	movq %r9, %rbx
	callq _c0_f1
	movq %rbx, %r9
	movl $2, %ecx
	imull %eax, %ecx
	movl $1, %r8d
	movl %ecx, %eax
	cltd
	idivl %r8d
	movl %eax, %r8d
	movl %r9d, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f2
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %ecx
	movl %edx, %eax
	cltd
	idivl %ecx
	movl %eax, %ecx
	movl %r9d, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f3
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, %r14d
	movl %r9d, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f4
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edi
	imull %eax, %edi
	movl $1, %esi
	movl %edi, %eax
	cltd
	idivl %esi
	movl %eax, 116(%rsp)
	movl %r9d, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f5
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edi
	imull %eax, %edi
	movl $1, %esi
	movl %edi, %eax
	cltd
	idivl %esi
	movl %eax, 120(%rsp)
	movl %r9d, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f6
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edi
	imull %eax, %edi
	movl $1, %esi
	movl %edi, %eax
	cltd
	idivl %esi
	movl %eax, %r12d
	movl %r9d, %edi
	movq %rcx, %r15
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f7
	movq %r15, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, %r15d
	movl %r9d, %edi
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f8
	movq %rbp, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, %ebp
	movl %r9d, %edi
	movq %rcx, 64(%rsp)
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f9
	movq 64(%rsp), %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, 124(%rsp)
	movl %r9d, %edi
	movq %rcx, 72(%rsp)
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f10
	movq 72(%rsp), %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, 128(%rsp)
	movl %r9d, %edi
	movq %rcx, 80(%rsp)
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f11
	movq 80(%rsp), %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, 132(%rsp)
	movl %r9d, %edi
	movq %rcx, 88(%rsp)
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f12
	movq 88(%rsp), %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, %esi
	movl %r9d, %edi
	movq %rsi, 96(%rsp)
	movq %rcx, 88(%rsp)
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f13
	movq 96(%rsp), %rsi
	movq 88(%rsp), %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, %ebx
	movl %r9d, %edi
	movq %rsi, 104(%rsp)
	movq %rcx, 96(%rsp)
	movq %r8, 88(%rsp)
	movq %r9, %r13
	callq _c0_f14
	movq 104(%rsp), %rsi
	movq 96(%rsp), %rcx
	movq 88(%rsp), %r8
	movq %r13, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, %r13d
	movl %r9d, %edi
	movq %rsi, 104(%rsp)
	movq %rcx, 96(%rsp)
	movq %r8, 88(%rsp)
	callq _c0_f15
	movq 104(%rsp), %rsi
	movq 96(%rsp), %rcx
	movq 88(%rsp), %r8
	movl $2, %edx
	imull %eax, %edx
	movl $1, %r9d
	movl %edx, %eax
	cltd
	idivl %r9d
	movl $17, %r9d
	addl 112(%rsp), %r9d
	addl %r8d, %r9d
	addl %ecx, %r9d
	addl %r14d, %r9d
	addl 116(%rsp), %r9d
	addl 120(%rsp), %r9d
	addl %r12d, %r9d
	addl %r15d, %r9d
	addl %ebp, %r9d
	addl 124(%rsp), %r9d
	addl 128(%rsp), %r9d
	addl 132(%rsp), %r9d
	addl %esi, %r9d
	addl %ebx, %r9d
	addl %r13d, %r9d
	addl %eax, %r9d
	movl %r9d, %eax
	movq 16(%rsp), %rbp
	movq 24(%rsp), %r15
	movq 32(%rsp), %r14
	movq 40(%rsp), %r13
	movq 48(%rsp), %r12
	movq 56(%rsp), %rbx
	addq $136, %rsp
	ret
_c0_f17:
	addq $-104, %rsp
	movq %rbp, 4(%rsp)
	movq %r15, 12(%rsp)
	movq %r14, 20(%rsp)
	movq %r13, 28(%rsp)
	movq %r12, 36(%rsp)
	movq %rbx, 44(%rsp)
	movl %edi, %r9d
.f17_0:
	movl %r9d, %edi
	movq %r9, %rbx
	callq _c0_f0
	movq %rbx, %r9
	movl $2, %ecx
	imull %eax, %ecx
	movl $1, %r8d
	movl %ecx, %eax
	cltd
	idivl %r8d
	movl %eax, 76(%rsp)
	movl %r9d, %edi
	movq %r9, %rbx
	callq _c0_f1
	movq %rbx, %r9
	movl $2, %ecx
	imull %eax, %ecx
	movl $1, %r8d
	movl %ecx, %eax
	cltd
	idivl %r8d
	movl %eax, %r8d
	movl %r9d, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f2
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %ecx
	movl %edx, %eax
	cltd
	idivl %ecx
	movl %eax, %ecx
	movl %r9d, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f3
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, %r14d
	movl %r9d, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f4
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edi
	imull %eax, %edi
	movl $1, %esi
	movl %edi, %eax
	cltd
	idivl %esi
	movl %eax, 80(%rsp)
	movl %r9d, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f5
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edi
	imull %eax, %edi
	movl $1, %esi
	movl %edi, %eax
	cltd
	idivl %esi
	movl %eax, 84(%rsp)
	movl %r9d, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f6
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edi
	imull %eax, %edi
	movl $1, %esi
	movl %edi, %eax
	cltd
	idivl %esi
	movl %eax, %r12d
	movl %r9d, %edi
	movq %rcx, %r15
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f7
	movq %r15, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, %r15d
	movl %r9d, %edi
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f8
	movq %rbp, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, 88(%rsp)
	movl %r9d, %edi
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f9
	movq %rbp, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, 92(%rsp)
	movl %r9d, %edi
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f10
	movq %rbp, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, 96(%rsp)
	movl %r9d, %edi
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f11
	movq %rbp, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, 100(%rsp)
	movl %r9d, %edi
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f12
	movq %rbp, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, %esi
	movl %r9d, %edi
	movq %rsi, 52(%rsp)
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f13
	movq 52(%rsp), %rsi
	movq %rbp, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, %ebx
	movl %r9d, %edi
	movq %rsi, 60(%rsp)
	movq %rcx, 52(%rsp)
	movq %r8, %rbp
	movq %r9, %r13
	callq _c0_f14
	movq 60(%rsp), %rsi
	movq 52(%rsp), %rcx
	movq %rbp, %r8
	movq %r13, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, %r13d
	movl %r9d, %edi
	movq %rsi, 68(%rsp)
	movq %rcx, 60(%rsp)
	movq %r8, 52(%rsp)
	movq %r9, %rbp
	callq _c0_f15
	movq 68(%rsp), %rsi
	movq 60(%rsp), %rcx
	movq 52(%rsp), %r8
	movq %rbp, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, %ebp
	movl %r9d, %edi
	movq %rsi, 68(%rsp)
	movq %rcx, 60(%rsp)
	movq %r8, 52(%rsp)
	callq _c0_f16
	movq 68(%rsp), %rsi
	movq 60(%rsp), %rcx
	movq 52(%rsp), %r8
	movl $2, %edx
	imull %eax, %edx
	movl $1, %r9d
	movl %edx, %eax
	cltd
	idivl %r9d
	movl $18, %r9d
	addl 76(%rsp), %r9d
	addl %r8d, %r9d
	addl %ecx, %r9d
	addl %r14d, %r9d
	addl 80(%rsp), %r9d
	addl 84(%rsp), %r9d
	addl %r12d, %r9d
	addl %r15d, %r9d
	addl 88(%rsp), %r9d
	addl 92(%rsp), %r9d
	addl 96(%rsp), %r9d
	addl 100(%rsp), %r9d
	addl %esi, %r9d
	addl %ebx, %r9d
	addl %r13d, %r9d
	addl %ebp, %r9d
	addl %eax, %r9d
	movl %r9d, %eax
	movq 4(%rsp), %rbp
	movq 12(%rsp), %r15
	movq 20(%rsp), %r14
	movq 28(%rsp), %r13
	movq 36(%rsp), %r12
	movq 44(%rsp), %rbx
	addq $104, %rsp
	ret
_c0_f18:
	addq $-120, %rsp
	movq %rbp, 8(%rsp)
	movq %r15, 16(%rsp)
	movq %r14, 24(%rsp)
	movq %r13, 32(%rsp)
	movq %r12, 40(%rsp)
	movq %rbx, 48(%rsp)
	movl %edi, %r9d
.f18_0:
	movl %r9d, %edi
	movq %r9, %rbx
	callq _c0_f0
	movq %rbx, %r9
	movl $2, %ecx
	imull %eax, %ecx
	movl $1, %r8d
	movl %ecx, %eax
	cltd
	idivl %r8d
	movl %eax, 88(%rsp)
	movl %r9d, %edi
	movq %r9, %rbx
	callq _c0_f1
	movq %rbx, %r9
	movl $2, %ecx
	imull %eax, %ecx
	movl $1, %r8d
	movl %ecx, %eax
	cltd
	idivl %r8d
	movl %eax, %r8d
	movl %r9d, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f2
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %ecx
	movl %edx, %eax
	cltd
	idivl %ecx
	movl %eax, %ecx
	movl %r9d, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f3
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, %r14d
	movl %r9d, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f4
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edi
	imull %eax, %edi
	movl $1, %esi
	movl %edi, %eax
	cltd
	idivl %esi
	movl %eax, 92(%rsp)
	movl %r9d, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f5
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edi
	imull %eax, %edi
	movl $1, %esi
	movl %edi, %eax
	cltd
	idivl %esi
	movl %eax, 96(%rsp)
	movl %r9d, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f6
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edi
	imull %eax, %edi
	movl $1, %esi
	movl %edi, %eax
	cltd
	idivl %esi
	movl %eax, %r12d
	movl %r9d, %edi
	movq %rcx, %r15
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f7
	movq %r15, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, %r15d
	movl %r9d, %edi
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f8
	movq %rbp, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, 100(%rsp)
	movl %r9d, %edi
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f9
	movq %rbp, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, 104(%rsp)
	movl %r9d, %edi
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f10
	movq %rbp, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, 108(%rsp)
	movl %r9d, %edi
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f11
	movq %rbp, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, 112(%rsp)
	movl %r9d, %edi
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f12
	movq %rbp, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, %esi
	movl %r9d, %edi
	movq %rsi, 56(%rsp)
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f13
	movq 56(%rsp), %rsi
	movq %rbp, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, %ebx
	movl %r9d, %edi
	movq %rsi, 64(%rsp)
	movq %rcx, 56(%rsp)
	movq %r8, %rbp
	movq %r9, %r13
	callq _c0_f14
	movq 64(%rsp), %rsi
	movq 56(%rsp), %rcx
	movq %rbp, %r8
	movq %r13, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, %r13d
	movl %r9d, %edi
	movq %rsi, 72(%rsp)
	movq %rcx, 64(%rsp)
	movq %r8, 56(%rsp)
	movq %r9, %rbp
	callq _c0_f15
	movq 72(%rsp), %rsi
	movq 64(%rsp), %rcx
	movq 56(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %edx
	movl $2, %eax
	imull %edx, %eax
	movl $1, %edi
	cltd
	idivl %edi
	movl %eax, %ebp
	movl %r9d, %edi
	movq %rsi, 80(%rsp)
	movq %rcx, 72(%rsp)
	movq %r8, 64(%rsp)
	movq %r9, 56(%rsp)
	callq _c0_f16
	movq 80(%rsp), %rsi
	movq 72(%rsp), %rcx
	movq 64(%rsp), %r8
	movq 56(%rsp), %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, 116(%rsp)
	movl %r9d, %edi
	movq %rsi, 80(%rsp)
	movq %rcx, 72(%rsp)
	movq %r8, 64(%rsp)
	callq _c0_f17
	movq 80(%rsp), %rsi
	movq 72(%rsp), %rcx
	movq 64(%rsp), %r8
	movl $2, %edx
	imull %eax, %edx
	movl $1, %r9d
	movl %edx, %eax
	cltd
	idivl %r9d
	movl $19, %r9d
	addl 88(%rsp), %r9d
	addl %r8d, %r9d
	addl %ecx, %r9d
	addl %r14d, %r9d
	addl 92(%rsp), %r9d
	addl 96(%rsp), %r9d
	addl %r12d, %r9d
	addl %r15d, %r9d
	addl 100(%rsp), %r9d
	addl 104(%rsp), %r9d
	addl 108(%rsp), %r9d
	addl 112(%rsp), %r9d
	addl %esi, %r9d
	addl %ebx, %r9d
	addl %r13d, %r9d
	addl %ebp, %r9d
	addl 116(%rsp), %r9d
	addl %eax, %r9d
	movl %r9d, %eax
	movq 8(%rsp), %rbp
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $120, %rsp
	ret
_c0_f19:
	addq $-136, %rsp
	movq %rbp, 12(%rsp)
	movq %r15, 20(%rsp)
	movq %r14, 28(%rsp)
	movq %r13, 36(%rsp)
	movq %r12, 44(%rsp)
	movq %rbx, 52(%rsp)
	movl %edi, %r9d
.f19_0:
	movl %r9d, %edi
	movq %r9, %rbx
	callq _c0_f0
	movq %rbx, %r9
	movl $2, %ecx
	imull %eax, %ecx
	movl $1, %r8d
	movl %ecx, %eax
	cltd
	idivl %r8d
	movl %eax, 100(%rsp)
	movl %r9d, %edi
	movq %r9, %rbx
	callq _c0_f1
	movq %rbx, %r9
	movl $2, %ecx
	imull %eax, %ecx
	movl $1, %r8d
	movl %ecx, %eax
	cltd
	idivl %r8d
	movl %eax, %r8d
	movl %r9d, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f2
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %ecx
	movl %edx, %eax
	cltd
	idivl %ecx
	movl %eax, %ecx
	movl %r9d, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f3
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, %r14d
	movl %r9d, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f4
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edi
	imull %eax, %edi
	movl $1, %esi
	movl %edi, %eax
	cltd
	idivl %esi
	movl %eax, 104(%rsp)
	movl %r9d, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f5
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edi
	imull %eax, %edi
	movl $1, %esi
	movl %edi, %eax
	cltd
	idivl %esi
	movl %eax, 108(%rsp)
	movl %r9d, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f6
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edi
	imull %eax, %edi
	movl $1, %esi
	movl %edi, %eax
	cltd
	idivl %esi
	movl %eax, %r12d
	movl %r9d, %edi
	movq %rcx, %r15
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f7
	movq %r15, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edi
	imull %eax, %edi
	movl $1, %esi
	movl %edi, %eax
	cltd
	idivl %esi
	movl %eax, %r15d
	movl %r9d, %edi
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f8
	movq %rbp, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, 112(%rsp)
	movl %r9d, %edi
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f9
	movq %rbp, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, 116(%rsp)
	movl %r9d, %edi
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f10
	movq %rbp, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, 120(%rsp)
	movl %r9d, %edi
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f11
	movq %rbp, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, 124(%rsp)
	movl %r9d, %edi
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f12
	movq %rbp, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, %esi
	movl %r9d, %edi
	movq %rsi, 60(%rsp)
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f13
	movq 60(%rsp), %rsi
	movq %rbp, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, %ebx
	movl %r9d, %edi
	movq %rsi, 68(%rsp)
	movq %rcx, 60(%rsp)
	movq %r8, %rbp
	movq %r9, %r13
	callq _c0_f14
	movq 68(%rsp), %rsi
	movq 60(%rsp), %rcx
	movq %rbp, %r8
	movq %r13, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, %r13d
	movl %r9d, %edi
	movq %rsi, 76(%rsp)
	movq %rcx, 68(%rsp)
	movq %r8, 60(%rsp)
	movq %r9, %rbp
	callq _c0_f15
	movq 76(%rsp), %rsi
	movq 68(%rsp), %rcx
	movq 60(%rsp), %r8
	movq %rbp, %r9
	movl %eax, %edx
	movl $2, %eax
	imull %edx, %eax
	movl $1, %edi
	cltd
	idivl %edi
	movl %eax, %ebp
	movl %r9d, %edi
	movq %rsi, 84(%rsp)
	movq %rcx, 76(%rsp)
	movq %r8, 68(%rsp)
	movq %r9, 60(%rsp)
	callq _c0_f16
	movq 84(%rsp), %rsi
	movq 76(%rsp), %rcx
	movq 68(%rsp), %r8
	movq 60(%rsp), %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, 128(%rsp)
	movl %r9d, %edi
	movq %rsi, 92(%rsp)
	movq %rcx, 84(%rsp)
	movq %r8, 76(%rsp)
	movq %r9, 68(%rsp)
	callq _c0_f17
	movq 92(%rsp), %rsi
	movq 84(%rsp), %rcx
	movq 76(%rsp), %r8
	movq 68(%rsp), %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, 132(%rsp)
	movl %r9d, %edi
	movq %rsi, 92(%rsp)
	movq %rcx, 84(%rsp)
	movq %r8, 76(%rsp)
	callq _c0_f18
	movq 92(%rsp), %rsi
	movq 84(%rsp), %rcx
	movq 76(%rsp), %r8
	movl $2, %edx
	imull %eax, %edx
	movl $1, %r9d
	movl %edx, %eax
	cltd
	idivl %r9d
	movl $20, %r9d
	addl 100(%rsp), %r9d
	addl %r8d, %r9d
	addl %ecx, %r9d
	addl %r14d, %r9d
	addl 104(%rsp), %r9d
	addl 108(%rsp), %r9d
	addl %r12d, %r9d
	addl %r15d, %r9d
	addl 112(%rsp), %r9d
	addl 116(%rsp), %r9d
	addl 120(%rsp), %r9d
	addl 124(%rsp), %r9d
	addl %esi, %r9d
	addl %ebx, %r9d
	addl %r13d, %r9d
	addl %ebp, %r9d
	addl 128(%rsp), %r9d
	addl 132(%rsp), %r9d
	addl %eax, %r9d
	movl %r9d, %eax
	movq 12(%rsp), %rbp
	movq 20(%rsp), %r15
	movq 28(%rsp), %r14
	movq 36(%rsp), %r13
	movq 44(%rsp), %r12
	movq 52(%rsp), %rbx
	addq $136, %rsp
	ret
_c0_f20:
	addq $-152, %rsp
	movq %rbp, 16(%rsp)
	movq %r15, 24(%rsp)
	movq %r14, 32(%rsp)
	movq %r13, 40(%rsp)
	movq %r12, 48(%rsp)
	movq %rbx, 56(%rsp)
	movl %edi, %r9d
.f20_0:
	movl %r9d, %edi
	movq %r9, %rbx
	callq _c0_f0
	movq %rbx, %r9
	movl $2, %ecx
	imull %eax, %ecx
	movl $1, %r8d
	movl %ecx, %eax
	cltd
	idivl %r8d
	movl %eax, 112(%rsp)
	movl %r9d, %edi
	movq %r9, %rbx
	callq _c0_f1
	movq %rbx, %r9
	movl $2, %ecx
	imull %eax, %ecx
	movl $1, %r8d
	movl %ecx, %eax
	cltd
	idivl %r8d
	movl %eax, %r8d
	movl %r9d, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f2
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %ecx
	movl %edx, %eax
	cltd
	idivl %ecx
	movl %eax, %ecx
	movl %r9d, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f3
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, %r14d
	movl %r9d, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f4
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, 116(%rsp)
	movl %r9d, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f5
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edi
	imull %eax, %edi
	movl $1, %esi
	movl %edi, %eax
	cltd
	idivl %esi
	movl %eax, 120(%rsp)
	movl %r9d, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f6
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edi
	imull %eax, %edi
	movl $1, %esi
	movl %edi, %eax
	cltd
	idivl %esi
	movl %eax, %r12d
	movl %r9d, %edi
	movq %rcx, %r15
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f7
	movq %r15, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edi
	imull %eax, %edi
	movl $1, %esi
	movl %edi, %eax
	cltd
	idivl %esi
	movl %eax, %r15d
	movl %r9d, %edi
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f8
	movq %rbp, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, 124(%rsp)
	movl %r9d, %edi
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f9
	movq %rbp, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, 128(%rsp)
	movl %r9d, %edi
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f10
	movq %rbp, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, 132(%rsp)
	movl %r9d, %edi
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f11
	movq %rbp, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, 136(%rsp)
	movl %r9d, %edi
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f12
	movq %rbp, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, %esi
	movl %r9d, %edi
	movq %rsi, 64(%rsp)
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f13
	movq 64(%rsp), %rsi
	movq %rbp, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, %ebx
	movl %r9d, %edi
	movq %rsi, 72(%rsp)
	movq %rcx, 64(%rsp)
	movq %r8, %rbp
	movq %r9, %r13
	callq _c0_f14
	movq 72(%rsp), %rsi
	movq 64(%rsp), %rcx
	movq %rbp, %r8
	movq %r13, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, %r13d
	movl %r9d, %edi
	movq %rsi, 80(%rsp)
	movq %rcx, 72(%rsp)
	movq %r8, 64(%rsp)
	movq %r9, %rbp
	callq _c0_f15
	movq 80(%rsp), %rsi
	movq 72(%rsp), %rcx
	movq 64(%rsp), %r8
	movq %rbp, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, %ebp
	movl %r9d, %edi
	movq %rsi, 88(%rsp)
	movq %rcx, 80(%rsp)
	movq %r8, 72(%rsp)
	movq %r9, 64(%rsp)
	callq _c0_f16
	movq 88(%rsp), %rsi
	movq 80(%rsp), %rcx
	movq 72(%rsp), %r8
	movq 64(%rsp), %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, 140(%rsp)
	movl %r9d, %edi
	movq %rsi, 96(%rsp)
	movq %rcx, 88(%rsp)
	movq %r8, 80(%rsp)
	movq %r9, 72(%rsp)
	callq _c0_f17
	movq 96(%rsp), %rsi
	movq 88(%rsp), %rcx
	movq 80(%rsp), %r8
	movq 72(%rsp), %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, 144(%rsp)
	movl %r9d, %edi
	movq %rsi, 104(%rsp)
	movq %rcx, 96(%rsp)
	movq %r8, 88(%rsp)
	movq %r9, 80(%rsp)
	callq _c0_f18
	movq 104(%rsp), %rsi
	movq 96(%rsp), %rcx
	movq 88(%rsp), %r8
	movq 80(%rsp), %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, 148(%rsp)
	movl %r9d, %edi
	movq %rsi, 104(%rsp)
	movq %rcx, 96(%rsp)
	movq %r8, 88(%rsp)
	callq _c0_f19
	movq 104(%rsp), %rsi
	movq 96(%rsp), %rcx
	movq 88(%rsp), %r8
	movl $2, %edx
	imull %eax, %edx
	movl $1, %r9d
	movl %edx, %eax
	cltd
	idivl %r9d
	movl $21, %r9d
	addl 112(%rsp), %r9d
	addl %r8d, %r9d
	addl %ecx, %r9d
	addl %r14d, %r9d
	addl 116(%rsp), %r9d
	addl 120(%rsp), %r9d
	addl %r12d, %r9d
	addl %r15d, %r9d
	addl 124(%rsp), %r9d
	addl 128(%rsp), %r9d
	addl 132(%rsp), %r9d
	addl 136(%rsp), %r9d
	addl %esi, %r9d
	addl %ebx, %r9d
	addl %r13d, %r9d
	addl %ebp, %r9d
	addl 140(%rsp), %r9d
	addl 144(%rsp), %r9d
	addl 148(%rsp), %r9d
	addl %eax, %r9d
	movl %r9d, %eax
	movq 16(%rsp), %rbp
	movq 24(%rsp), %r15
	movq 32(%rsp), %r14
	movq 40(%rsp), %r13
	movq 48(%rsp), %r12
	movq 56(%rsp), %rbx
	addq $152, %rsp
	ret
_c0_f21:
	addq $-152, %rsp
	movq %rbp, 4(%rsp)
	movq %r15, 12(%rsp)
	movq %r14, 20(%rsp)
	movq %r13, 28(%rsp)
	movq %r12, 36(%rsp)
	movq %rbx, 44(%rsp)
	movl %edi, %r9d
.f21_0:
	movl %r9d, %edi
	movq %r9, %rbx
	callq _c0_f0
	movq %rbx, %r9
	movl $2, %ecx
	imull %eax, %ecx
	movl $1, %r8d
	movl %ecx, %eax
	cltd
	idivl %r8d
	movl %eax, 108(%rsp)
	movl %r9d, %edi
	movq %r9, %rbx
	callq _c0_f1
	movq %rbx, %r9
	movl $2, %ecx
	imull %eax, %ecx
	movl $1, %r8d
	movl %ecx, %eax
	cltd
	idivl %r8d
	movl %eax, %r8d
	movl %r9d, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f2
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %ecx
	movl %edx, %eax
	cltd
	idivl %ecx
	movl %eax, %ecx
	movl %r9d, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f3
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, %r14d
	movl %r9d, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f4
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, 112(%rsp)
	movl %r9d, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f5
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edi
	imull %eax, %edi
	movl $1, %esi
	movl %edi, %eax
	cltd
	idivl %esi
	movl %eax, 116(%rsp)
	movl %r9d, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f6
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edi
	imull %eax, %edi
	movl $1, %esi
	movl %edi, %eax
	cltd
	idivl %esi
	movl %eax, %r12d
	movl %r9d, %edi
	movq %rcx, %r15
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f7
	movq %r15, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edi
	imull %eax, %edi
	movl $1, %esi
	movl %edi, %eax
	cltd
	idivl %esi
	movl %eax, %r15d
	movl %r9d, %edi
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f8
	movq %rbp, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edi
	imull %eax, %edi
	movl $1, %esi
	movl %edi, %eax
	cltd
	idivl %esi
	movl %eax, 120(%rsp)
	movl %r9d, %edi
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f9
	movq %rbp, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, 124(%rsp)
	movl %r9d, %edi
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f10
	movq %rbp, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, 128(%rsp)
	movl %r9d, %edi
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f11
	movq %rbp, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, 132(%rsp)
	movl %r9d, %edi
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f12
	movq %rbp, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, %esi
	movl %r9d, %edi
	movq %rsi, 52(%rsp)
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f13
	movq 52(%rsp), %rsi
	movq %rbp, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, %ebx
	movl %r9d, %edi
	movq %rsi, 60(%rsp)
	movq %rcx, 52(%rsp)
	movq %r8, %rbp
	movq %r9, %r13
	callq _c0_f14
	movq 60(%rsp), %rsi
	movq 52(%rsp), %rcx
	movq %rbp, %r8
	movq %r13, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, %r13d
	movl %r9d, %edi
	movq %rsi, 68(%rsp)
	movq %rcx, 60(%rsp)
	movq %r8, 52(%rsp)
	movq %r9, %rbp
	callq _c0_f15
	movq 68(%rsp), %rsi
	movq 60(%rsp), %rcx
	movq 52(%rsp), %r8
	movq %rbp, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, %ebp
	movl %r9d, %edi
	movq %rsi, 76(%rsp)
	movq %rcx, 68(%rsp)
	movq %r8, 60(%rsp)
	movq %r9, 52(%rsp)
	callq _c0_f16
	movq 76(%rsp), %rsi
	movq 68(%rsp), %rcx
	movq 60(%rsp), %r8
	movq 52(%rsp), %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, 136(%rsp)
	movl %r9d, %edi
	movq %rsi, 84(%rsp)
	movq %rcx, 76(%rsp)
	movq %r8, 68(%rsp)
	movq %r9, 60(%rsp)
	callq _c0_f17
	movq 84(%rsp), %rsi
	movq 76(%rsp), %rcx
	movq 68(%rsp), %r8
	movq 60(%rsp), %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, 140(%rsp)
	movl %r9d, %edi
	movq %rsi, 92(%rsp)
	movq %rcx, 84(%rsp)
	movq %r8, 76(%rsp)
	movq %r9, 68(%rsp)
	callq _c0_f18
	movq 92(%rsp), %rsi
	movq 84(%rsp), %rcx
	movq 76(%rsp), %r8
	movq 68(%rsp), %r9
	movl %eax, %edx
	movl $2, %eax
	imull %edx, %eax
	movl $1, %edi
	cltd
	idivl %edi
	movl %eax, 144(%rsp)
	movl %r9d, %edi
	movq %rsi, 100(%rsp)
	movq %rcx, 92(%rsp)
	movq %r8, 84(%rsp)
	movq %r9, 76(%rsp)
	callq _c0_f19
	movq 100(%rsp), %rsi
	movq 92(%rsp), %rcx
	movq 84(%rsp), %r8
	movq 76(%rsp), %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, 148(%rsp)
	movl %r9d, %edi
	movq %rsi, 100(%rsp)
	movq %rcx, 92(%rsp)
	movq %r8, 84(%rsp)
	callq _c0_f20
	movq 100(%rsp), %rsi
	movq 92(%rsp), %rcx
	movq 84(%rsp), %r8
	movl $2, %edx
	imull %eax, %edx
	movl $1, %r9d
	movl %edx, %eax
	cltd
	idivl %r9d
	movl $22, %r9d
	addl 108(%rsp), %r9d
	addl %r8d, %r9d
	addl %ecx, %r9d
	addl %r14d, %r9d
	addl 112(%rsp), %r9d
	addl 116(%rsp), %r9d
	addl %r12d, %r9d
	addl %r15d, %r9d
	addl 120(%rsp), %r9d
	addl 124(%rsp), %r9d
	addl 128(%rsp), %r9d
	addl 132(%rsp), %r9d
	addl %esi, %r9d
	addl %ebx, %r9d
	addl %r13d, %r9d
	addl %ebp, %r9d
	addl 136(%rsp), %r9d
	addl 140(%rsp), %r9d
	addl 144(%rsp), %r9d
	addl 148(%rsp), %r9d
	addl %eax, %r9d
	movl %r9d, %eax
	movq 4(%rsp), %rbp
	movq 12(%rsp), %r15
	movq 20(%rsp), %r14
	movq 28(%rsp), %r13
	movq 36(%rsp), %r12
	movq 44(%rsp), %rbx
	addq $152, %rsp
	ret
_c0_f22:
	addq $-168, %rsp
	movq %rbp, 8(%rsp)
	movq %r15, 16(%rsp)
	movq %r14, 24(%rsp)
	movq %r13, 32(%rsp)
	movq %r12, 40(%rsp)
	movq %rbx, 48(%rsp)
	movl %edi, %r9d
.f22_0:
	movl %r9d, %edi
	movq %r9, %rbx
	callq _c0_f0
	movq %rbx, %r9
	movl $2, %ecx
	imull %eax, %ecx
	movl $1, %r8d
	movl %ecx, %eax
	cltd
	idivl %r8d
	movl %eax, 120(%rsp)
	movl %r9d, %edi
	movq %r9, %rbx
	callq _c0_f1
	movq %rbx, %r9
	movl $2, %ecx
	imull %eax, %ecx
	movl $1, %r8d
	movl %ecx, %eax
	cltd
	idivl %r8d
	movl %eax, %r8d
	movl %r9d, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f2
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %ecx
	movl %edx, %eax
	cltd
	idivl %ecx
	movl %eax, %ecx
	movl %r9d, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f3
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, %r14d
	movl %r9d, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f4
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, 124(%rsp)
	movl %r9d, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f5
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edi
	imull %eax, %edi
	movl $1, %esi
	movl %edi, %eax
	cltd
	idivl %esi
	movl %eax, 128(%rsp)
	movl %r9d, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f6
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edi
	imull %eax, %edi
	movl $1, %esi
	movl %edi, %eax
	cltd
	idivl %esi
	movl %eax, %r12d
	movl %r9d, %edi
	movq %rcx, %r15
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f7
	movq %r15, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edi
	imull %eax, %edi
	movl $1, %esi
	movl %edi, %eax
	cltd
	idivl %esi
	movl %eax, %r15d
	movl %r9d, %edi
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f8
	movq %rbp, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edi
	imull %eax, %edi
	movl $1, %esi
	movl %edi, %eax
	cltd
	idivl %esi
	movl %eax, 132(%rsp)
	movl %r9d, %edi
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f9
	movq %rbp, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, 136(%rsp)
	movl %r9d, %edi
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f10
	movq %rbp, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, 140(%rsp)
	movl %r9d, %edi
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f11
	movq %rbp, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, 144(%rsp)
	movl %r9d, %edi
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f12
	movq %rbp, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, %esi
	movl %r9d, %edi
	movq %rsi, 56(%rsp)
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f13
	movq 56(%rsp), %rsi
	movq %rbp, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, %ebx
	movl %r9d, %edi
	movq %rsi, 64(%rsp)
	movq %rcx, 56(%rsp)
	movq %r8, %rbp
	movq %r9, %r13
	callq _c0_f14
	movq 64(%rsp), %rsi
	movq 56(%rsp), %rcx
	movq %rbp, %r8
	movq %r13, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, %r13d
	movl %r9d, %edi
	movq %rsi, 72(%rsp)
	movq %rcx, 64(%rsp)
	movq %r8, 56(%rsp)
	movq %r9, %rbp
	callq _c0_f15
	movq 72(%rsp), %rsi
	movq 64(%rsp), %rcx
	movq 56(%rsp), %r8
	movq %rbp, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, %ebp
	movl %r9d, %edi
	movq %rsi, 80(%rsp)
	movq %rcx, 72(%rsp)
	movq %r8, 64(%rsp)
	movq %r9, 56(%rsp)
	callq _c0_f16
	movq 80(%rsp), %rsi
	movq 72(%rsp), %rcx
	movq 64(%rsp), %r8
	movq 56(%rsp), %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, 148(%rsp)
	movl %r9d, %edi
	movq %rsi, 88(%rsp)
	movq %rcx, 80(%rsp)
	movq %r8, 72(%rsp)
	movq %r9, 64(%rsp)
	callq _c0_f17
	movq 88(%rsp), %rsi
	movq 80(%rsp), %rcx
	movq 72(%rsp), %r8
	movq 64(%rsp), %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, 152(%rsp)
	movl %r9d, %edi
	movq %rsi, 96(%rsp)
	movq %rcx, 88(%rsp)
	movq %r8, 80(%rsp)
	movq %r9, 72(%rsp)
	callq _c0_f18
	movq 96(%rsp), %rsi
	movq 88(%rsp), %rcx
	movq 80(%rsp), %r8
	movq 72(%rsp), %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, 156(%rsp)
	movl %r9d, %edi
	movq %rsi, 104(%rsp)
	movq %rcx, 96(%rsp)
	movq %r8, 88(%rsp)
	movq %r9, 80(%rsp)
	callq _c0_f19
	movq 104(%rsp), %rsi
	movq 96(%rsp), %rcx
	movq 88(%rsp), %r8
	movq 80(%rsp), %r9
	movl %eax, %edx
	movl $2, %eax
	imull %edx, %eax
	movl $1, %edi
	cltd
	idivl %edi
	movl %eax, 160(%rsp)
	movl %r9d, %edi
	movq %rsi, 112(%rsp)
	movq %rcx, 104(%rsp)
	movq %r8, 96(%rsp)
	movq %r9, 88(%rsp)
	callq _c0_f20
	movq 112(%rsp), %rsi
	movq 104(%rsp), %rcx
	movq 96(%rsp), %r8
	movq 88(%rsp), %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, 164(%rsp)
	movl %r9d, %edi
	movq %rsi, 112(%rsp)
	movq %rcx, 104(%rsp)
	movq %r8, 96(%rsp)
	callq _c0_f21
	movq 112(%rsp), %rsi
	movq 104(%rsp), %rcx
	movq 96(%rsp), %r8
	movl $2, %edx
	imull %eax, %edx
	movl $1, %r9d
	movl %edx, %eax
	cltd
	idivl %r9d
	movl $23, %r9d
	addl 120(%rsp), %r9d
	addl %r8d, %r9d
	addl %ecx, %r9d
	addl %r14d, %r9d
	addl 124(%rsp), %r9d
	addl 128(%rsp), %r9d
	addl %r12d, %r9d
	addl %r15d, %r9d
	addl 132(%rsp), %r9d
	addl 136(%rsp), %r9d
	addl 140(%rsp), %r9d
	addl 144(%rsp), %r9d
	addl %esi, %r9d
	addl %ebx, %r9d
	addl %r13d, %r9d
	addl %ebp, %r9d
	addl 148(%rsp), %r9d
	addl 152(%rsp), %r9d
	addl 156(%rsp), %r9d
	addl 160(%rsp), %r9d
	addl 164(%rsp), %r9d
	addl %eax, %r9d
	movl %r9d, %eax
	movq 8(%rsp), %rbp
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $168, %rsp
	ret
_c0_f23:
	addq $-184, %rsp
	movq %rbp, 12(%rsp)
	movq %r15, 20(%rsp)
	movq %r14, 28(%rsp)
	movq %r13, 36(%rsp)
	movq %r12, 44(%rsp)
	movq %rbx, 52(%rsp)
	movl %edi, %r9d
.f23_0:
	movl %r9d, %edi
	movq %r9, %rbx
	callq _c0_f0
	movq %rbx, %r9
	movl $2, %ecx
	imull %eax, %ecx
	movl $1, %r8d
	movl %ecx, %eax
	cltd
	idivl %r8d
	movl %eax, 132(%rsp)
	movl %r9d, %edi
	movq %r9, %rbx
	callq _c0_f1
	movq %rbx, %r9
	movl $2, %ecx
	imull %eax, %ecx
	movl $1, %r8d
	movl %ecx, %eax
	cltd
	idivl %r8d
	movl %eax, %r8d
	movl %r9d, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f2
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %ecx
	movl %edx, %eax
	cltd
	idivl %ecx
	movl %eax, %ecx
	movl %r9d, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f3
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, %r14d
	movl %r9d, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f4
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, 136(%rsp)
	movl %r9d, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f5
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edi
	imull %eax, %edi
	movl $1, %esi
	movl %edi, %eax
	cltd
	idivl %esi
	movl %eax, 140(%rsp)
	movl %r9d, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f6
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edi
	imull %eax, %edi
	movl $1, %esi
	movl %edi, %eax
	cltd
	idivl %esi
	movl %eax, %r12d
	movl %r9d, %edi
	movq %rcx, %r15
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f7
	movq %r15, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edi
	imull %eax, %edi
	movl $1, %esi
	movl %edi, %eax
	cltd
	idivl %esi
	movl %eax, %r15d
	movl %r9d, %edi
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f8
	movq %rbp, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edi
	imull %eax, %edi
	movl $1, %esi
	movl %edi, %eax
	cltd
	idivl %esi
	movl %eax, 144(%rsp)
	movl %r9d, %edi
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f9
	movq %rbp, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, 148(%rsp)
	movl %r9d, %edi
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f10
	movq %rbp, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, 152(%rsp)
	movl %r9d, %edi
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f11
	movq %rbp, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, 156(%rsp)
	movl %r9d, %edi
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f12
	movq %rbp, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, %esi
	movl %r9d, %edi
	movq %rsi, 60(%rsp)
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f13
	movq 60(%rsp), %rsi
	movq %rbp, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, %ebx
	movl %r9d, %edi
	movq %rsi, 68(%rsp)
	movq %rcx, 60(%rsp)
	movq %r8, %rbp
	movq %r9, %r13
	callq _c0_f14
	movq 68(%rsp), %rsi
	movq 60(%rsp), %rcx
	movq %rbp, %r8
	movq %r13, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, %r13d
	movl %r9d, %edi
	movq %rsi, 76(%rsp)
	movq %rcx, 68(%rsp)
	movq %r8, 60(%rsp)
	movq %r9, %rbp
	callq _c0_f15
	movq 76(%rsp), %rsi
	movq 68(%rsp), %rcx
	movq 60(%rsp), %r8
	movq %rbp, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, %ebp
	movl %r9d, %edi
	movq %rsi, 84(%rsp)
	movq %rcx, 76(%rsp)
	movq %r8, 68(%rsp)
	movq %r9, 60(%rsp)
	callq _c0_f16
	movq 84(%rsp), %rsi
	movq 76(%rsp), %rcx
	movq 68(%rsp), %r8
	movq 60(%rsp), %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, 160(%rsp)
	movl %r9d, %edi
	movq %rsi, 92(%rsp)
	movq %rcx, 84(%rsp)
	movq %r8, 76(%rsp)
	movq %r9, 68(%rsp)
	callq _c0_f17
	movq 92(%rsp), %rsi
	movq 84(%rsp), %rcx
	movq 76(%rsp), %r8
	movq 68(%rsp), %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, 164(%rsp)
	movl %r9d, %edi
	movq %rsi, 100(%rsp)
	movq %rcx, 92(%rsp)
	movq %r8, 84(%rsp)
	movq %r9, 76(%rsp)
	callq _c0_f18
	movq 100(%rsp), %rsi
	movq 92(%rsp), %rcx
	movq 84(%rsp), %r8
	movq 76(%rsp), %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, 168(%rsp)
	movl %r9d, %edi
	movq %rsi, 108(%rsp)
	movq %rcx, 100(%rsp)
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq _c0_f19
	movq 108(%rsp), %rsi
	movq 100(%rsp), %rcx
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, %edx
	movl $2, %eax
	imull %edx, %eax
	movl $1, %edi
	cltd
	idivl %edi
	movl %eax, 172(%rsp)
	movl %r9d, %edi
	movq %rsi, 116(%rsp)
	movq %rcx, 108(%rsp)
	movq %r8, 100(%rsp)
	movq %r9, 92(%rsp)
	callq _c0_f20
	movq 116(%rsp), %rsi
	movq 108(%rsp), %rcx
	movq 100(%rsp), %r8
	movq 92(%rsp), %r9
	movl %eax, %edx
	movl $2, %eax
	imull %edx, %eax
	movl $1, %edi
	cltd
	idivl %edi
	movl %eax, 176(%rsp)
	movl %r9d, %edi
	movq %rsi, 124(%rsp)
	movq %rcx, 116(%rsp)
	movq %r8, 108(%rsp)
	movq %r9, 100(%rsp)
	callq _c0_f21
	movq 124(%rsp), %rsi
	movq 116(%rsp), %rcx
	movq 108(%rsp), %r8
	movq 100(%rsp), %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, 180(%rsp)
	movl %r9d, %edi
	movq %rsi, 124(%rsp)
	movq %rcx, 116(%rsp)
	movq %r8, 108(%rsp)
	callq _c0_f22
	movq 124(%rsp), %rsi
	movq 116(%rsp), %rcx
	movq 108(%rsp), %r8
	movl $2, %edx
	imull %eax, %edx
	movl $1, %r9d
	movl %edx, %eax
	cltd
	idivl %r9d
	movl $24, %r9d
	addl 132(%rsp), %r9d
	addl %r8d, %r9d
	addl %ecx, %r9d
	addl %r14d, %r9d
	addl 136(%rsp), %r9d
	addl 140(%rsp), %r9d
	addl %r12d, %r9d
	addl %r15d, %r9d
	addl 144(%rsp), %r9d
	addl 148(%rsp), %r9d
	addl 152(%rsp), %r9d
	addl 156(%rsp), %r9d
	addl %esi, %r9d
	addl %ebx, %r9d
	addl %r13d, %r9d
	addl %ebp, %r9d
	addl 160(%rsp), %r9d
	addl 164(%rsp), %r9d
	addl 168(%rsp), %r9d
	addl 172(%rsp), %r9d
	addl 176(%rsp), %r9d
	addl 180(%rsp), %r9d
	addl %eax, %r9d
	movl %r9d, %eax
	movq 12(%rsp), %rbp
	movq 20(%rsp), %r15
	movq 28(%rsp), %r14
	movq 36(%rsp), %r13
	movq 44(%rsp), %r12
	movq 52(%rsp), %rbx
	addq $184, %rsp
	ret
_c0_f24:
	addq $-200, %rsp
	movq %rbp, 16(%rsp)
	movq %r15, 24(%rsp)
	movq %r14, 32(%rsp)
	movq %r13, 40(%rsp)
	movq %r12, 48(%rsp)
	movq %rbx, 56(%rsp)
	movl %edi, %r9d
.f24_0:
	movl %r9d, %edi
	movq %r9, %rbx
	callq _c0_f0
	movq %rbx, %r9
	movl $2, %ecx
	imull %eax, %ecx
	movl $1, %r8d
	movl %ecx, %eax
	cltd
	idivl %r8d
	movl %eax, 144(%rsp)
	movl %r9d, %edi
	movq %r9, %rbx
	callq _c0_f1
	movq %rbx, %r9
	movl $2, %ecx
	imull %eax, %ecx
	movl $1, %r8d
	movl %ecx, %eax
	cltd
	idivl %r8d
	movl %eax, %r8d
	movl %r9d, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f2
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %ecx
	movl %edx, %eax
	cltd
	idivl %ecx
	movl %eax, %ecx
	movl %r9d, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f3
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, %r14d
	movl %r9d, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f4
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, 148(%rsp)
	movl %r9d, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f5
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, 152(%rsp)
	movl %r9d, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f6
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edi
	imull %eax, %edi
	movl $1, %esi
	movl %edi, %eax
	cltd
	idivl %esi
	movl %eax, %r12d
	movl %r9d, %edi
	movq %rcx, %r15
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f7
	movq %r15, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edi
	imull %eax, %edi
	movl $1, %esi
	movl %edi, %eax
	cltd
	idivl %esi
	movl %eax, %r15d
	movl %r9d, %edi
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f8
	movq %rbp, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edi
	imull %eax, %edi
	movl $1, %esi
	movl %edi, %eax
	cltd
	idivl %esi
	movl %eax, 156(%rsp)
	movl %r9d, %edi
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f9
	movq %rbp, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edi
	imull %eax, %edi
	movl $1, %esi
	movl %edi, %eax
	cltd
	idivl %esi
	movl %eax, 160(%rsp)
	movl %r9d, %edi
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f10
	movq %rbp, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, 164(%rsp)
	movl %r9d, %edi
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f11
	movq %rbp, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, 168(%rsp)
	movl %r9d, %edi
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f12
	movq %rbp, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, %esi
	movl %r9d, %edi
	movq %rsi, 64(%rsp)
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f13
	movq 64(%rsp), %rsi
	movq %rbp, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, %ebx
	movl %r9d, %edi
	movq %rsi, 72(%rsp)
	movq %rcx, 64(%rsp)
	movq %r8, %rbp
	movq %r9, %r13
	callq _c0_f14
	movq 72(%rsp), %rsi
	movq 64(%rsp), %rcx
	movq %rbp, %r8
	movq %r13, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, %r13d
	movl %r9d, %edi
	movq %rsi, 80(%rsp)
	movq %rcx, 72(%rsp)
	movq %r8, 64(%rsp)
	movq %r9, %rbp
	callq _c0_f15
	movq 80(%rsp), %rsi
	movq 72(%rsp), %rcx
	movq 64(%rsp), %r8
	movq %rbp, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, %ebp
	movl %r9d, %edi
	movq %rsi, 88(%rsp)
	movq %rcx, 80(%rsp)
	movq %r8, 72(%rsp)
	movq %r9, 64(%rsp)
	callq _c0_f16
	movq 88(%rsp), %rsi
	movq 80(%rsp), %rcx
	movq 72(%rsp), %r8
	movq 64(%rsp), %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, 172(%rsp)
	movl %r9d, %edi
	movq %rsi, 96(%rsp)
	movq %rcx, 88(%rsp)
	movq %r8, 80(%rsp)
	movq %r9, 72(%rsp)
	callq _c0_f17
	movq 96(%rsp), %rsi
	movq 88(%rsp), %rcx
	movq 80(%rsp), %r8
	movq 72(%rsp), %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, 176(%rsp)
	movl %r9d, %edi
	movq %rsi, 104(%rsp)
	movq %rcx, 96(%rsp)
	movq %r8, 88(%rsp)
	movq %r9, 80(%rsp)
	callq _c0_f18
	movq 104(%rsp), %rsi
	movq 96(%rsp), %rcx
	movq 88(%rsp), %r8
	movq 80(%rsp), %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, 180(%rsp)
	movl %r9d, %edi
	movq %rsi, 112(%rsp)
	movq %rcx, 104(%rsp)
	movq %r8, 96(%rsp)
	movq %r9, 88(%rsp)
	callq _c0_f19
	movq 112(%rsp), %rsi
	movq 104(%rsp), %rcx
	movq 96(%rsp), %r8
	movq 88(%rsp), %r9
	movl %eax, %edx
	movl $2, %eax
	imull %edx, %eax
	movl $1, %edi
	cltd
	idivl %edi
	movl %eax, 184(%rsp)
	movl %r9d, %edi
	movq %rsi, 120(%rsp)
	movq %rcx, 112(%rsp)
	movq %r8, 104(%rsp)
	movq %r9, 96(%rsp)
	callq _c0_f20
	movq 120(%rsp), %rsi
	movq 112(%rsp), %rcx
	movq 104(%rsp), %r8
	movq 96(%rsp), %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, 188(%rsp)
	movl %r9d, %edi
	movq %rsi, 128(%rsp)
	movq %rcx, 120(%rsp)
	movq %r8, 112(%rsp)
	movq %r9, 104(%rsp)
	callq _c0_f21
	movq 128(%rsp), %rsi
	movq 120(%rsp), %rcx
	movq 112(%rsp), %r8
	movq 104(%rsp), %r9
	movl %eax, %edx
	movl $2, %eax
	imull %edx, %eax
	movl $1, %edi
	cltd
	idivl %edi
	movl %eax, 192(%rsp)
	movl %r9d, %edi
	movq %rsi, 136(%rsp)
	movq %rcx, 128(%rsp)
	movq %r8, 120(%rsp)
	movq %r9, 112(%rsp)
	callq _c0_f22
	movq 136(%rsp), %rsi
	movq 128(%rsp), %rcx
	movq 120(%rsp), %r8
	movq 112(%rsp), %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, 196(%rsp)
	movl %r9d, %edi
	movq %rsi, 136(%rsp)
	movq %rcx, 128(%rsp)
	movq %r8, 120(%rsp)
	callq _c0_f23
	movq 136(%rsp), %rsi
	movq 128(%rsp), %rcx
	movq 120(%rsp), %r8
	movl $2, %edx
	imull %eax, %edx
	movl $1, %r9d
	movl %edx, %eax
	cltd
	idivl %r9d
	movl $25, %r9d
	addl 144(%rsp), %r9d
	addl %r8d, %r9d
	addl %ecx, %r9d
	addl %r14d, %r9d
	addl 148(%rsp), %r9d
	addl 152(%rsp), %r9d
	addl %r12d, %r9d
	addl %r15d, %r9d
	addl 156(%rsp), %r9d
	addl 160(%rsp), %r9d
	addl 164(%rsp), %r9d
	addl 168(%rsp), %r9d
	addl %esi, %r9d
	addl %ebx, %r9d
	addl %r13d, %r9d
	addl %ebp, %r9d
	addl 172(%rsp), %r9d
	addl 176(%rsp), %r9d
	addl 180(%rsp), %r9d
	addl 184(%rsp), %r9d
	addl 188(%rsp), %r9d
	addl 192(%rsp), %r9d
	addl 196(%rsp), %r9d
	addl %eax, %r9d
	movl %r9d, %eax
	movq 16(%rsp), %rbp
	movq 24(%rsp), %r15
	movq 32(%rsp), %r14
	movq 40(%rsp), %r13
	movq 48(%rsp), %r12
	movq 56(%rsp), %rbx
	addq $200, %rsp
	ret
_c0_f25:
	addq $-200, %rsp
	movq %rbp, 4(%rsp)
	movq %r15, 12(%rsp)
	movq %r14, 20(%rsp)
	movq %r13, 28(%rsp)
	movq %r12, 36(%rsp)
	movq %rbx, 44(%rsp)
	movl %edi, %r9d
.f25_0:
	movl %r9d, %edi
	movq %r9, %rbx
	callq _c0_f0
	movq %rbx, %r9
	movl $2, %ecx
	imull %eax, %ecx
	movl $1, %r8d
	movl %ecx, %eax
	cltd
	idivl %r8d
	movl %eax, 140(%rsp)
	movl %r9d, %edi
	movq %r9, %rbx
	callq _c0_f1
	movq %rbx, %r9
	movl $2, %ecx
	imull %eax, %ecx
	movl $1, %r8d
	movl %ecx, %eax
	cltd
	idivl %r8d
	movl %eax, %r8d
	movl %r9d, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f2
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %ecx
	movl %edx, %eax
	cltd
	idivl %ecx
	movl %eax, %ecx
	movl %r9d, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f3
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, %r14d
	movl %r9d, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f4
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, 144(%rsp)
	movl %r9d, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f5
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, 148(%rsp)
	movl %r9d, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f6
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edi
	imull %eax, %edi
	movl $1, %esi
	movl %edi, %eax
	cltd
	idivl %esi
	movl %eax, %r12d
	movl %r9d, %edi
	movq %rcx, %r15
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f7
	movq %r15, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edi
	imull %eax, %edi
	movl $1, %esi
	movl %edi, %eax
	cltd
	idivl %esi
	movl %eax, %r15d
	movl %r9d, %edi
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f8
	movq %rbp, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edi
	imull %eax, %edi
	movl $1, %esi
	movl %edi, %eax
	cltd
	idivl %esi
	movl %eax, 152(%rsp)
	movl %r9d, %edi
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f9
	movq %rbp, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edi
	imull %eax, %edi
	movl $1, %esi
	movl %edi, %eax
	cltd
	idivl %esi
	movl %eax, 156(%rsp)
	movl %r9d, %edi
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f10
	movq %rbp, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, 160(%rsp)
	movl %r9d, %edi
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f11
	movq %rbp, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, 164(%rsp)
	movl %r9d, %edi
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f12
	movq %rbp, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, %esi
	movl %r9d, %edi
	movq %rsi, 52(%rsp)
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f13
	movq 52(%rsp), %rsi
	movq %rbp, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, %ebx
	movl %r9d, %edi
	movq %rsi, 60(%rsp)
	movq %rcx, 52(%rsp)
	movq %r8, %rbp
	movq %r9, %r13
	callq _c0_f14
	movq 60(%rsp), %rsi
	movq 52(%rsp), %rcx
	movq %rbp, %r8
	movq %r13, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, %r13d
	movl %r9d, %edi
	movq %rsi, 68(%rsp)
	movq %rcx, 60(%rsp)
	movq %r8, 52(%rsp)
	movq %r9, %rbp
	callq _c0_f15
	movq 68(%rsp), %rsi
	movq 60(%rsp), %rcx
	movq 52(%rsp), %r8
	movq %rbp, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, %ebp
	movl %r9d, %edi
	movq %rsi, 76(%rsp)
	movq %rcx, 68(%rsp)
	movq %r8, 60(%rsp)
	movq %r9, 52(%rsp)
	callq _c0_f16
	movq 76(%rsp), %rsi
	movq 68(%rsp), %rcx
	movq 60(%rsp), %r8
	movq 52(%rsp), %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, 168(%rsp)
	movl %r9d, %edi
	movq %rsi, 84(%rsp)
	movq %rcx, 76(%rsp)
	movq %r8, 68(%rsp)
	movq %r9, 60(%rsp)
	callq _c0_f17
	movq 84(%rsp), %rsi
	movq 76(%rsp), %rcx
	movq 68(%rsp), %r8
	movq 60(%rsp), %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, 172(%rsp)
	movl %r9d, %edi
	movq %rsi, 92(%rsp)
	movq %rcx, 84(%rsp)
	movq %r8, 76(%rsp)
	movq %r9, 68(%rsp)
	callq _c0_f18
	movq 92(%rsp), %rsi
	movq 84(%rsp), %rcx
	movq 76(%rsp), %r8
	movq 68(%rsp), %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, 176(%rsp)
	movl %r9d, %edi
	movq %rsi, 100(%rsp)
	movq %rcx, 92(%rsp)
	movq %r8, 84(%rsp)
	movq %r9, 76(%rsp)
	callq _c0_f19
	movq 100(%rsp), %rsi
	movq 92(%rsp), %rcx
	movq 84(%rsp), %r8
	movq 76(%rsp), %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, 180(%rsp)
	movl %r9d, %edi
	movq %rsi, 108(%rsp)
	movq %rcx, 100(%rsp)
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq _c0_f20
	movq 108(%rsp), %rsi
	movq 100(%rsp), %rcx
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, 184(%rsp)
	movl %r9d, %edi
	movq %rsi, 116(%rsp)
	movq %rcx, 108(%rsp)
	movq %r8, 100(%rsp)
	movq %r9, 92(%rsp)
	callq _c0_f21
	movq 116(%rsp), %rsi
	movq 108(%rsp), %rcx
	movq 100(%rsp), %r8
	movq 92(%rsp), %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, 188(%rsp)
	movl %r9d, %edi
	movq %rsi, 124(%rsp)
	movq %rcx, 116(%rsp)
	movq %r8, 108(%rsp)
	movq %r9, 100(%rsp)
	callq _c0_f22
	movq 124(%rsp), %rsi
	movq 116(%rsp), %rcx
	movq 108(%rsp), %r8
	movq 100(%rsp), %r9
	movl %eax, %edx
	movl $2, %eax
	imull %edx, %eax
	movl $1, %edi
	cltd
	idivl %edi
	movl %eax, 192(%rsp)
	movl %r9d, %edi
	movq %rsi, 132(%rsp)
	movq %rcx, 124(%rsp)
	movq %r8, 116(%rsp)
	movq %r9, 108(%rsp)
	callq _c0_f23
	movq 132(%rsp), %rsi
	movq 124(%rsp), %rcx
	movq 116(%rsp), %r8
	movq 108(%rsp), %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, 196(%rsp)
	movl %r9d, %edi
	movq %rsi, 132(%rsp)
	movq %rcx, 124(%rsp)
	movq %r8, 116(%rsp)
	callq _c0_f24
	movq 132(%rsp), %rsi
	movq 124(%rsp), %rcx
	movq 116(%rsp), %r8
	movl $2, %edx
	imull %eax, %edx
	movl $1, %r9d
	movl %edx, %eax
	cltd
	idivl %r9d
	movl $26, %r9d
	addl 140(%rsp), %r9d
	addl %r8d, %r9d
	addl %ecx, %r9d
	addl %r14d, %r9d
	addl 144(%rsp), %r9d
	addl 148(%rsp), %r9d
	addl %r12d, %r9d
	addl %r15d, %r9d
	addl 152(%rsp), %r9d
	addl 156(%rsp), %r9d
	addl 160(%rsp), %r9d
	addl 164(%rsp), %r9d
	addl %esi, %r9d
	addl %ebx, %r9d
	addl %r13d, %r9d
	addl %ebp, %r9d
	addl 168(%rsp), %r9d
	addl 172(%rsp), %r9d
	addl 176(%rsp), %r9d
	addl 180(%rsp), %r9d
	addl 184(%rsp), %r9d
	addl 188(%rsp), %r9d
	addl 192(%rsp), %r9d
	addl 196(%rsp), %r9d
	addl %eax, %r9d
	movl %r9d, %eax
	movq 4(%rsp), %rbp
	movq 12(%rsp), %r15
	movq 20(%rsp), %r14
	movq 28(%rsp), %r13
	movq 36(%rsp), %r12
	movq 44(%rsp), %rbx
	addq $200, %rsp
	ret
_c0_f26:
	addq $-216, %rsp
	movq %rbp, 8(%rsp)
	movq %r15, 16(%rsp)
	movq %r14, 24(%rsp)
	movq %r13, 32(%rsp)
	movq %r12, 40(%rsp)
	movq %rbx, 48(%rsp)
	movl %edi, %r9d
.f26_0:
	movl %r9d, %edi
	movq %r9, %rbx
	callq _c0_f0
	movq %rbx, %r9
	movl $2, %ecx
	imull %eax, %ecx
	movl $1, %r8d
	movl %ecx, %eax
	cltd
	idivl %r8d
	movl %eax, 152(%rsp)
	movl %r9d, %edi
	movq %r9, %rbx
	callq _c0_f1
	movq %rbx, %r9
	movl $2, %ecx
	imull %eax, %ecx
	movl $1, %r8d
	movl %ecx, %eax
	cltd
	idivl %r8d
	movl %eax, %r8d
	movl %r9d, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f2
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %ecx
	movl %edx, %eax
	cltd
	idivl %ecx
	movl %eax, %ecx
	movl %r9d, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f3
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, %r14d
	movl %r9d, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f4
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, 156(%rsp)
	movl %r9d, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f5
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, 160(%rsp)
	movl %r9d, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f6
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $2, %edi
	imull %eax, %edi
	movl $1, %esi
	movl %edi, %eax
	cltd
	idivl %esi
	movl %eax, %r12d
	movl %r9d, %edi
	movq %rcx, %r15
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f7
	movq %r15, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edi
	imull %eax, %edi
	movl $1, %esi
	movl %edi, %eax
	cltd
	idivl %esi
	movl %eax, %r15d
	movl %r9d, %edi
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f8
	movq %rbp, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edi
	imull %eax, %edi
	movl $1, %esi
	movl %edi, %eax
	cltd
	idivl %esi
	movl %eax, 164(%rsp)
	movl %r9d, %edi
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f9
	movq %rbp, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edi
	imull %eax, %edi
	movl $1, %esi
	movl %edi, %eax
	cltd
	idivl %esi
	movl %eax, 168(%rsp)
	movl %r9d, %edi
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f10
	movq %rbp, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edi
	imull %eax, %edi
	movl $1, %esi
	movl %edi, %eax
	cltd
	idivl %esi
	movl %eax, 172(%rsp)
	movl %r9d, %edi
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f11
	movq %rbp, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, 176(%rsp)
	movl %r9d, %edi
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f12
	movq %rbp, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %esi
	movl %edx, %eax
	cltd
	idivl %esi
	movl %eax, %esi
	movl %r9d, %edi
	movq %rsi, 56(%rsp)
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0_f13
	movq 56(%rsp), %rsi
	movq %rbp, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, %ebx
	movl %r9d, %edi
	movq %rsi, 64(%rsp)
	movq %rcx, 56(%rsp)
	movq %r8, %rbp
	movq %r9, %r13
	callq _c0_f14
	movq 64(%rsp), %rsi
	movq 56(%rsp), %rcx
	movq %rbp, %r8
	movq %r13, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, %r13d
	movl %r9d, %edi
	movq %rsi, 72(%rsp)
	movq %rcx, 64(%rsp)
	movq %r8, 56(%rsp)
	movq %r9, %rbp
	callq _c0_f15
	movq 72(%rsp), %rsi
	movq 64(%rsp), %rcx
	movq 56(%rsp), %r8
	movq %rbp, %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, %ebp
	movl %r9d, %edi
	movq %rsi, 80(%rsp)
	movq %rcx, 72(%rsp)
	movq %r8, 64(%rsp)
	movq %r9, 56(%rsp)
	callq _c0_f16
	movq 80(%rsp), %rsi
	movq 72(%rsp), %rcx
	movq 64(%rsp), %r8
	movq 56(%rsp), %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, 180(%rsp)
	movl %r9d, %edi
	movq %rsi, 88(%rsp)
	movq %rcx, 80(%rsp)
	movq %r8, 72(%rsp)
	movq %r9, 64(%rsp)
	callq _c0_f17
	movq 88(%rsp), %rsi
	movq 80(%rsp), %rcx
	movq 72(%rsp), %r8
	movq 64(%rsp), %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, 184(%rsp)
	movl %r9d, %edi
	movq %rsi, 96(%rsp)
	movq %rcx, 88(%rsp)
	movq %r8, 80(%rsp)
	movq %r9, 72(%rsp)
	callq _c0_f18
	movq 96(%rsp), %rsi
	movq 88(%rsp), %rcx
	movq 80(%rsp), %r8
	movq 72(%rsp), %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, 188(%rsp)
	movl %r9d, %edi
	movq %rsi, 104(%rsp)
	movq %rcx, 96(%rsp)
	movq %r8, 88(%rsp)
	movq %r9, 80(%rsp)
	callq _c0_f19
	movq 104(%rsp), %rsi
	movq 96(%rsp), %rcx
	movq 88(%rsp), %r8
	movq 80(%rsp), %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, 192(%rsp)
	movl %r9d, %edi
	movq %rsi, 112(%rsp)
	movq %rcx, 104(%rsp)
	movq %r8, 96(%rsp)
	movq %r9, 88(%rsp)
	callq _c0_f20
	movq 112(%rsp), %rsi
	movq 104(%rsp), %rcx
	movq 96(%rsp), %r8
	movq 88(%rsp), %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, 196(%rsp)
	movl %r9d, %edi
	movq %rsi, 120(%rsp)
	movq %rcx, 112(%rsp)
	movq %r8, 104(%rsp)
	movq %r9, 96(%rsp)
	callq _c0_f21
	movq 120(%rsp), %rsi
	movq 112(%rsp), %rcx
	movq 104(%rsp), %r8
	movq 96(%rsp), %r9
	movl $2, %edx
	imull %eax, %edx
	movl $1, %edi
	movl %edx, %eax
	cltd
	idivl %edi
	movl %eax, 200(%rsp)
	movl %r9d, %edi
	movq %rsi, 128(%rsp)
	movq %rcx, 120(%rsp)
	movq %r8, 112(%rsp)
	movq %r9, 104(%rsp)
	callq _c0_f22
	movq 128(%rsp), %rsi
	movq 120(%rsp), %rcx
	movq 112(%rsp), %r8
	movq 104(%rsp), %r9
	movl %eax, %edx
	movl $2, %eax
	imull %edx, %eax
	movl $1, %edi
	cltd
	idivl %edi
	movl %eax, 204(%rsp)
	movl %r9d, %edi
	movq %rsi, 136(%rsp)
	movq %rcx, 128(%rsp)
	movq %r8, 120(%rsp)
	movq %r9, 112(%rsp)
	callq _c0_f23
	movq 136(%rsp), %rsi
	movq 128(%rsp), %rcx
	movq 120(%rsp), %r8
	movq 112(%rsp), %r9
	movl %eax, %edx
	movl $2, %eax
	imull %edx, %eax
	movl $1, %edi
	cltd
	idivl %edi
	movl %eax, 208(%rsp)
	movl %r9d, %edi
	movq %rsi, 144(%rsp)
	movq %rcx, 136(%rsp)
	movq %r8, 128(%rsp)
	movq %r9, 120(%rsp)
	callq _c0_f24
	movq 144(%rsp), %rsi
	movq 136(%rsp), %rcx
	movq 128(%rsp), %r8
	movq 120(%rsp), %r9
	movl %eax, %edx
	movl $2, %eax
	imull %edx, %eax
	movl $1, %edi
	cltd
	idivl %edi
	movl %eax, 212(%rsp)
	movl %r9d, %edi
	movq %rsi, 144(%rsp)
	movq %rcx, 136(%rsp)
	movq %r8, 128(%rsp)
	callq _c0_f25
	movq 144(%rsp), %rsi
	movq 136(%rsp), %rcx
	movq 128(%rsp), %r8
	movl $2, %edx
	imull %eax, %edx
	movl $1, %r9d
	movl %edx, %eax
	cltd
	idivl %r9d
	movl $27, %r9d
	addl 152(%rsp), %r9d
	addl %r8d, %r9d
	addl %ecx, %r9d
	addl %r14d, %r9d
	addl 156(%rsp), %r9d
	addl 160(%rsp), %r9d
	addl %r12d, %r9d
	addl %r15d, %r9d
	addl 164(%rsp), %r9d
	addl 168(%rsp), %r9d
	addl 172(%rsp), %r9d
	addl 176(%rsp), %r9d
	addl %esi, %r9d
	addl %ebx, %r9d
	addl %r13d, %r9d
	addl %ebp, %r9d
	addl 180(%rsp), %r9d
	addl 184(%rsp), %r9d
	addl 188(%rsp), %r9d
	addl 192(%rsp), %r9d
	addl 196(%rsp), %r9d
	addl 200(%rsp), %r9d
	addl 204(%rsp), %r9d
	addl 208(%rsp), %r9d
	addl 212(%rsp), %r9d
	addl %eax, %r9d
	movl %r9d, %eax
	movq 8(%rsp), %rbp
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $216, %rsp
	ret
.ident	"15-411 L4 reference compiler"
