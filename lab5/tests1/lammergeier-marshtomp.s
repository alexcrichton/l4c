.file	"../tests1/lammergeier-marshtomp.l4"
.globl _c0_main
_c0_rand:
	addq $-8, %rsp
.rand_0:
	movl $6, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl (%r8), %edx
	movl $2, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl (%r8), %r8d
	movl %edx, %esi
	xorl %r8d, %esi
	movl $1, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl (%r8), %edx
	movl $0, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl %edx, (%r8)
	movl $2, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl (%r8), %edx
	movl $1, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl %edx, (%r8)
	movl $3, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl (%r8), %edx
	movl $2, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl %edx, (%r8)
	movl $4, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl (%r8), %edx
	movl $3, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl %edx, (%r8)
	movl $5, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl (%r8), %edx
	movl $4, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl %edx, (%r8)
	movl $6, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl (%r8), %edx
	movl $5, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl %edx, (%r8)
	movl $6, %r8d
	imull $4, %r8d
	movslq %r8d, %r8
	movq %rdi, %r9
	addq %r8, %r9
	movl %esi, (%r9)
	movl %esi, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-40, %rsp
	movq %r14, 8(%rsp)
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
.main_0:
	movq $7, %rdi
	movq $4, %rsi
	callq calloc
	movq %rax, %r9
	movl $0, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl $304, (%r8)
	movl $1, %r8d
	imull $4, %r8d
	movslq %r8d, %r8
	movq %r9, %rcx
	addq %r8, %rcx
	movl $679, (%rcx)
	movl $2, %r8d
	imull $4, %r8d
	movslq %r8d, %r8
	movq %r9, %rcx
	addq %r8, %rcx
	movl $760, (%rcx)
	movl $3, %r8d
	imull $4, %r8d
	movslq %r8d, %r8
	movq %r9, %rcx
	addq %r8, %rcx
	movl $584, (%rcx)
	movl $4, %r8d
	imull $4, %r8d
	movslq %r8d, %r8
	movq %r9, %rcx
	addq %r8, %rcx
	movl $436, (%rcx)
	movl $5, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl $462, (%r8)
	movl $6, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl $852, (%r8)
	movl $0, %edx
	movl $0, %r8d
.main_8:
	movl %r8d, %ecx
.main_1:
	movl $1, %edi
	movl $1000000, %esi
	movl %ecx, %r8d
	cmpl %esi, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edi
	jnz .main_6
.main_2:
	movq %r9, %rdi
	movq %rdx, %r13
	movq %rcx, %r12
	movq %r9, %rbx
	callq _c0_rand
	movq %r13, %rdx
	movq %r12, %rcx
	movq %rbx, %r9
	movl %eax, %r8d
	movq %r9, %rdi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_rand
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %ebx
	movl $1, %eax
	movl %r8d, %edi
	imull %r8d, %edi
	movl %ebx, %esi
	imull %ebx, %esi
	movl %edi, %r8d
	addl %esi, %r8d
	movl $1024, %esi
	imull $1024, %esi
	cmpl %esi, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %eax
	jnz .main_4
.main_3:
	movl %edx, %r8d
	addl $1, %r8d
.main_10:
	movl %r8d, %esi
.main_5:
	movl %ecx, %r8d
	addl $1, %r8d
.main_7:
	movl %r8d, %ecx
	movl %esi, %edx
	jmp .main_1
.main_4:
.main_9:
	movl %edx, %esi
	jmp .main_5
.main_6:
	movl $1000, %r9d
	movl %edx, %eax
	cltd
	idivl %r9d
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.ident	"15-411 L4 reference compiler"
