.file	"../tests1/hawk-bubble_sort.l4"
.globl _c0_main
_c0_main:
	addq $-56, %rsp
	movq %r15, 16(%rsp)
	movq %r14, 24(%rsp)
	movq %r13, 32(%rsp)
	movq %r12, 40(%rsp)
	movq %rbx, 48(%rsp)
.main_0:
	movq %r9, %rbx
	callq readint
	movq %rbx, %r9
	movl %eax, %r8d
	movslq %r8d, %rdi
	movq $4, %rsi
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, %rcx
	movl $0, %edx
.main_17:
.main_1:
	movl $1, %edi
	movl %edx, %esi
	cmpl %r8d, %esi
	setl %sil
	movzbl %sil, %esi
	cmpl %esi, %edi
	jnz .main_3
.main_2:
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq readint
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl %edx, %esi
	imull $4, %esi
	movslq %esi, %rdi
	movq %rcx, %rsi
	addq %rdi, %rsi
	movl %eax, (%rsi)
	addl $1, %edx
.main_16:
	jmp .main_1
.main_3:
	movl $0, %edx
.main_19:
	movl %edx, %edi
.main_4:
	movl $1, %esi
	movl $1, %edx
	xorl %edi, %edx
	cmpl %edx, %esi
	jnz .main_12
.main_5:
	movl $1, %esi
	movl $0, %edx
.main_21:
	movl %edx, %r15d
	movl %esi, %r14d
.main_6:
	movl $1, %edi
	movl %r8d, %esi
	subl $1, %esi
	movl %r15d, %edx
	cmpl %esi, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %edi
	jnz .main_11
.main_7:
	movl %r15d, %edx
	imull $4, %edx
	movslq %edx, %rsi
	movq %rcx, %rdx
	addq %rsi, %rdx
	movl (%rdx), %edx
	movl %edx, %r13d
	movl %r15d, %esi
	addl $1, %esi
	imull $4, %esi
	movslq %esi, %rdi
	movq %rcx, %rsi
	addq %rdi, %rsi
	movl (%rsi), %r12d
	movl %r15d, %esi
	imull $4, %esi
	movslq %esi, %rdi
	movq %rcx, %rsi
	addq %rdi, %rsi
	movl (%rsi), %ebx
	movl $1, %edi
	movl %r12d, %esi
	cmpl %ebx, %esi
	setl %sil
	movzbl %sil, %esi
	cmpl %esi, %edi
	jnz .main_9
.main_8:
	movl %r15d, %r9d
	addl $1, %r9d
	imull $4, %r9d
	movslq %r9d, %rsi
	movq %rcx, %r9
	addq %rsi, %r9
	movl (%r9), %edi
	movl %r15d, %r9d
	imull $4, %r9d
	movslq %r9d, %rsi
	movq %rcx, %r9
	addq %rsi, %r9
	movl %edi, (%r9)
	movl %r15d, %r9d
	addl $1, %r9d
	imull $4, %r9d
	movslq %r9d, %rsi
	movq %rcx, %r9
	addq %rsi, %r9
	movl %r13d, (%r9)
	movl $0, %r9d
.main_23:
	movl %edi, %eax
	movl %r9d, %edi
.main_10:
	movl %r15d, %esi
	addl $1, %esi
.main_20:
	movl %eax, %r9d
	movl %esi, %r15d
	movl %edi, %r14d
	jmp .main_6
.main_9:
.main_22:
	movl %r9d, %eax
	movl %r14d, %edi
	jmp .main_10
.main_11:
.main_18:
	movl %r14d, %edi
	jmp .main_4
.main_12:
	movl $0, %r9d
.main_25:
.main_13:
	movl $1, %esi
	movl %r9d, %edx
	cmpl %r8d, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %esi
	jnz .main_15
.main_14:
	movl %r9d, %edx
	imull $4, %edx
	movslq %edx, %rsi
	movq %rcx, %rdx
	addq %rsi, %rdx
	movl (%rdx), %edx
	movl %edx, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq printint
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $32, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq printchar
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	addl $1, %r9d
.main_24:
	jmp .main_13
.main_15:
	movl $10, %edi
	callq printchar
	movl $0, %eax
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
.ident	"15-411 L4 reference compiler"
