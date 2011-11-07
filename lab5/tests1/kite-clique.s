.file	"../tests1/kite-clique.l3"
.globl _c0_main
_c0_choose2:
	addq $-8, %rsp
.choose2_0:
	movl %edi, %r9d
	subl $1, %r9d
	movl %edi, %eax
	imull %r9d, %eax
	movl $2, %r9d
	cltd
	idivl %r9d
	addq $8, %rsp
	ret
_c0_maxedges:
	addq $-56, %rsp
	movq %r15, 16(%rsp)
	movq %r14, 24(%rsp)
	movq %r13, 32(%rsp)
	movq %r12, 40(%rsp)
	movq %rbx, 48(%rsp)
	movl %esi, %ecx
.maxedges_0:
	movl $1, %esi
	movl $1, %edx
	movl %ecx, %r8d
	cmpl %edx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %esi
	jnz .maxedges_3
.maxedges_1:
	movl $0, %eax
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
.maxedges_3:
.maxedges_4:
	movl %ecx, %r8d
	subl $1, %r8d
	movl %edi, %eax
	cltd
	idivl %r8d
	movl %edx, %esi
	movl %edi, %eax
	subl %esi, %eax
	movl %ecx, %r8d
	subl $1, %r8d
	cltd
	idivl %r8d
	movl %eax, %r8d
	movl %edi, %r9d
	subl %esi, %r9d
	addl %ecx, %r9d
	movl %r9d, %eax
	subl $1, %eax
	movl %ecx, %r9d
	subl $1, %r9d
	cltd
	idivl %r9d
	movl %eax, %r9d
	subl $1, %ecx
	subl %esi, %ecx
	movl %esi, %edx
	movl %ecx, %edi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_choose2
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %esi
	movl %edx, %edi
	movq %rsi, %r15
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_choose2
	movq %r15, %rsi
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	imull %r8d, %esi
	imull %r8d, %esi
	imull %edx, %ecx
	imull %r8d, %ecx
	movl %ecx, %r8d
	imull %r9d, %r8d
	movl %esi, %ecx
	addl %r8d, %ecx
	movl %eax, %r8d
	imull %r9d, %r8d
	imull %r9d, %r8d
	movl %ecx, %eax
	addl %r8d, %eax
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
_c0_main:
	addq $-104, %rsp
	movq %rbp, 4(%rsp)
	movq %r15, 12(%rsp)
	movq %r14, 20(%rsp)
	movq %r13, 28(%rsp)
	movq %r12, 36(%rsp)
	movq %rbx, 44(%rsp)
.main_0:
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq readint
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %r15d
	movl $0, %edx
.main_15:
	movl %edx, %ebx
.main_1:
	movl $1, %edx
	movl %ebx, %esi
	cmpl %r15d, %esi
	setl %sil
	movzbl %sil, %esi
	cmpl %esi, %edx
	jnz .main_13
.main_2:
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %r12
	callq readint
	movq %rbp, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movl %eax, %ebp
	movq %rcx, 52(%rsp)
	movq %r8, %r13
	movq %r9, %r12
	callq readint
	movq 52(%rsp), %rcx
	movq %r13, %r8
	movq %r12, %r9
	movl %eax, 92(%rsp)
	movl $1, %esi
	movl %ebp, %edx
.main_17:
	movl %edx, %r12d
	movl %esi, %r13d
.main_3:
	movl $1, %esi
	movl %r13d, %edx
	cmpl %r12d, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %esi
	jnz .main_21
.main_4:
	movl %r13d, %edx
	addl %r12d, %edx
	movl %edx, %eax
	addl $1, %eax
	movl $2, %esi
	cltd
	idivl %esi
	movl %eax, %edx
	movl %edx, 96(%rsp)
	movl %ebp, %edi
	movl 96(%rsp), %esi
	movq %rdx, 60(%rsp)
	movq %rcx, 68(%rsp)
	movq %r8, 76(%rsp)
	movq %r9, 84(%rsp)
	callq _c0_maxedges
	movq 60(%rsp), %rdx
	movq 68(%rsp), %rcx
	movq 76(%rsp), %r8
	movq 84(%rsp), %r9
	movl %eax, 100(%rsp)
	movl 100(%rsp), %eax
	movl $1, %edi
	movl %eax, %esi
	cmpl 92(%rsp), %esi
	sete %sil
	movzbl %sil, %esi
	cmpl %esi, %edi
	jnz .main_6
.main_5:
	movl 96(%rsp), %esi
	subl $1, %esi
	jmp .main_20
.main_6:
	movl $1, %esi
	movl %eax, %edi
	cmpl 92(%rsp), %edi
	setl %dil
	movzbl %dil, %edi
	cmpl %edi, %esi
	jnz .main_8
.main_7:
	movl 96(%rsp), %r9d
.main_19:
	movl %r12d, %esi
	movl %r9d, %edi
.main_10:
.main_11:
.main_16:
	movl 100(%rsp), %ecx
	movl %eax, %r14d
	movl %edx, %r8d
	movl 96(%rsp), %r9d
	movl %esi, %r12d
	movl %edi, %r13d
	jmp .main_3
.main_8:
	movl 96(%rsp), %esi
	subl $1, %esi
.main_18:
	movl %r13d, %edi
	jmp .main_10
.main_21:
	movl %r13d, %edx
.main_12:
	movl %edx, %edi
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %r12
	callq printint
	movq %rbp, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movl $10, %edi
	movq %rcx, %rbp
	movq %r8, %r13
	movq %r9, %r12
	callq printchar
	movq %rbp, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movl %ebx, %edx
	addl $1, %edx
.main_14:
	movl %edx, %ebx
	jmp .main_1
.main_13:
	movl $0, %eax
	movq 4(%rsp), %rbp
	movq 12(%rsp), %r15
	movq 20(%rsp), %r14
	movq 28(%rsp), %r13
	movq 36(%rsp), %r12
	movq 44(%rsp), %rbx
	addq $104, %rsp
	ret
.main_20:
	movl %esi, %edx
	jmp .main_12
.ident	"15-411 L4 reference compiler"
