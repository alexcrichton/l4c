.file	"../tests2/diplodocus-zip.l4"
.globl _c0_main
_c0_zip:
	addq $-56, %rsp
	movq %r15, 16(%rsp)
	movq %r14, 24(%rsp)
	movq %r13, 32(%rsp)
	movq %r12, 40(%rsp)
	movq %rbx, 48(%rsp)
	movq %rdi, %r9
	movq %rsi, %r8
.zip_0:
	movq $10, %rdi
	movq $8, %rsi
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, %rcx
	movl $0, %edx
.zip_5:
.zip_1:
	movl $1, %eax
	movl $10, %edi
	movl %edx, %esi
	cmpl %edi, %esi
	setl %sil
	movzbl %sil, %esi
	cmpl %esi, %eax
	jnz .zip_3
.zip_2:
	movl %edx, %esi
	imull $8, %esi
	movslq %esi, %rsi
	movq %rcx, %rbx
	addq %rsi, %rbx
	movq $1, %rdi
	movq $8, %rsi
	movq %rdx, %r15
	movq %rcx, %r14
	movq %r8, %r13
	movq %r9, %r12
	callq calloc
	movq %r15, %rdx
	movq %r14, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movq %rax, (%rbx)
	movl %edx, %esi
	imull $8, %esi
	movslq %esi, %rdi
	movq %rcx, %rsi
	addq %rdi, %rsi
	movq (%rsi), %rbx
	movl %edx, %esi
	imull $4, %esi
	movslq %esi, %rdi
	movq %r9, %rsi
	addq %rdi, %rsi
	movl (%rsi), %eax
	movq $0, %rdi
	movq %rbx, %rsi
	addq %rdi, %rsi
	movl %eax, (%rsi)
	movl %edx, %esi
	imull $8, %esi
	movslq %esi, %rdi
	movq %rcx, %rsi
	addq %rdi, %rsi
	movq (%rsi), %rdi
	movl %edx, %esi
	imull $4, %esi
	movslq %esi, %rsi
	movq %r8, %rax
	addq %rsi, %rax
	movl (%rax), %eax
	movq $4, %rsi
	addq %rsi, %rdi
	movl %eax, (%rdi)
	addl $1, %edx
.zip_4:
	jmp .zip_1
.zip_3:
	movq %rcx, %rax
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
.main_0:
	movl $0, %r9d
	movq $10, %rdi
	movq $4, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movq %rax, %r8
	movq $10, %rdi
	movq $4, %rsi
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r12, %r8
	movq %rbx, %r9
	movl $0, %ecx
.main_8:
	movl %ecx, %edi
.main_1:
	movl $1, %ecx
	movl $10, %esi
	movl %edi, %edx
	cmpl %esi, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %ecx
	jnz .main_3
.main_2:
	movl %edi, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r8, %rcx
	addq %rdx, %rcx
	movl %edi, (%rcx)
	addl $1, (%rcx)
	movl %edi, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %rax, %rcx
	addq %rdx, %rcx
	movl $10, (%rcx)
	subl %edi, (%rcx)
	movl %edi, %ecx
	addl $1, %ecx
.main_7:
	movl %ecx, %edi
	jmp .main_1
.main_3:
	movq %r8, %rdi
	movq %rax, %rsi
	movq %r9, %rbx
	callq _c0_zip
	movq %rbx, %r9
	movq %rax, %rdi
	movl $0, %r8d
.main_10:
	movl %r9d, %esi
	movl %r8d, %edx
.main_4:
	movl $1, %ecx
	movl $10, %r8d
	movl %edx, %r9d
	cmpl %r8d, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_6
.main_5:
	movl %edx, %r9d
	imull $8, %r9d
	movslq %r9d, %r8
	movq %rdi, %r9
	addq %r8, %r9
	movq (%r9), %r9
	movq $0, %r8
	addq %r8, %r9
	movl (%r9), %ecx
	movl %edx, %r9d
	imull $8, %r9d
	movslq %r9d, %r8
	movq %rdi, %r9
	addq %r8, %r9
	movq (%r9), %r9
	movq $4, %r8
	addq %r8, %r9
	movl (%r9), %r9d
	movl %ecx, %r8d
	imull %r9d, %r8d
	movl %esi, %r9d
	addl %r8d, %r9d
	movl %edx, %r8d
	addl $1, %r8d
.main_9:
	movl %r9d, %esi
	movl %r8d, %edx
	jmp .main_4
.main_6:
	movl %esi, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
