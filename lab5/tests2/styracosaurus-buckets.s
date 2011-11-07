.file	"../tests2/styracosaurus-buckets.l4"
.globl _c0_main
_c0_main:
	addq $-56, %rsp
	movq %r15, 16(%rsp)
	movq %r14, 24(%rsp)
	movq %r13, 32(%rsp)
	movq %r12, 40(%rsp)
	movq %rbx, 48(%rsp)
.main_0:
	movl $10, %r9d
	movl $0, %r8d
	movslq %r9d, %rdi
	movq $8, %rsi
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, %rcx
	movl $0, %edx
.main_11:
	movl %edx, %esi
.main_1:
	movl $1, %edi
	movl %esi, %edx
	cmpl %r9d, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %edi
	jnz .main_3
.main_2:
	movl %esi, %edx
	imull $8, %edx
	movslq %edx, %rdx
	movq %rcx, %rdi
	addq %rdx, %rdi
	movq $0, (%rdi)
	movl %esi, %edx
	addl $1, %edx
.main_10:
	movl %edx, %esi
	jmp .main_1
.main_3:
	movl $0, %edx
.main_13:
	movl %edx, %ebx
.main_4:
	movl $1, %edi
	movl $12345, %esi
	movl %ebx, %edx
	cmpl %esi, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %edi
	jnz .main_6
.main_5:
	movl %ebx, %eax
	cltd
	idivl %r9d
	movq $1, %rdi
	movq $16, %rsi
	movq %rdx, %r15
	movq %rcx, %r14
	movq %r8, %r13
	movq %r9, %r12
	callq calloc
	movq %r15, %rdx
	movq %r14, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movq %rax, %r12
	movl %edx, %esi
	imull $8, %esi
	movslq %esi, %rdi
	movq %rcx, %rsi
	addq %rdi, %rsi
	movq (%rsi), %rax
	movq $8, %rdi
	movq %r12, %rsi
	addq %rdi, %rsi
	movq %rax, (%rsi)
	imull $8, %edx
	movslq %edx, %rsi
	movq %rcx, %rdx
	addq %rsi, %rdx
	movq %r12, (%rdx)
	movl %ebx, %edx
	addl $1, %edx
.main_12:
	movl %edx, %ebx
	jmp .main_4
.main_6:
.main_15:
	movl %r8d, %esi
.main_7:
	movl $9, %r9d
	imull $8, %r9d
	movslq %r9d, %r8
	movq %rcx, %r9
	addq %r8, %r9
	movq (%r9), %r9
	movl $1, %edx
	movq $0, %r8
	cmpq %r8, %r9
	setne %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %edx
	jnz .main_9
.main_8:
	movl %esi, %edx
	addl $1, %edx
	movl $9, %r9d
	imull $8, %r9d
	movslq %r9d, %r8
	movq %rcx, %r9
	addq %r8, %r9
	movq (%r9), %r8
	movq $8, %r9
	addq %r9, %r8
	movq (%r8), %r8
	movl $9, %r9d
	imull $8, %r9d
	movslq %r9d, %rsi
	movq %rcx, %r9
	addq %rsi, %r9
	movq %r8, (%r9)
.main_14:
	movl %edx, %esi
	jmp .main_7
.main_9:
	movl %esi, %eax
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
.ident	"15-411 L4 reference compiler"
