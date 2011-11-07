.file	"../tests1/hobby-reverse-list.l4"
.globl _c0_main
_c0_insert:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
	movq %rdi, %r9
	movl %esi, %r8d
.insert_0:
	movq $1, %rdi
	movq $16, %rsi
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r12, %r8
	movq %rbx, %r9
	movq $0, %rdx
	movq %rax, %rcx
	addq %rdx, %rcx
	movl %r8d, (%rcx)
	movq $8, %r8
	movq %rax, %rcx
	addq %r8, %rcx
	movq %r9, (%rcx)
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_reverse:
	addq $-8, %rsp
	movq %rdi, %r9
.reverse_0:
	movq $0, %rcx
	movq $0, %r8
.reverse_5:
	movq %r8, %rdi
	movq %r9, %rsi
.reverse_1:
	movl $1, %ecx
	movq $0, %r8
	movq %rsi, %r9
	cmpq %r8, %r9
	setne %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .reverse_3
.reverse_2:
	movq %rsi, %rdx
	movq $8, %r8
	movq %rsi, %r9
	addq %r8, %r9
	movq (%r9), %r9
	movq %r9, %rcx
	movq $8, %r8
	movq %rdx, %r9
	addq %r8, %r9
	movq %rdi, (%r9)
	movq %rdx, %r9
.reverse_4:
	movq %r9, %rdi
	movq %rcx, %rsi
	jmp .reverse_1
.reverse_3:
	movq %rdi, %rax
	addq $8, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
.main_0:
	movq $0, %rcx
	movl $0, %r9d
	movl $0, %r8d
.main_8:
.main_1:
	movl $1, %edi
	movl $9, %esi
	movl %r8d, %edx
	cmpl %esi, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %edi
	jnz .main_3
.main_2:
	movq %rcx, %rdi
	movl %r8d, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_insert
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, %rcx
	addl $1, %r8d
.main_7:
	jmp .main_1
.main_3:
	movq %rcx, %rdi
	movq %r9, %rbx
	callq _c0_reverse
	movq %rbx, %r9
	movq %rax, %rcx
	movl $0, %r8d
.main_10:
	movl %r8d, %edi
	movl %r9d, %esi
	movq %rcx, %rdx
.main_4:
	movl $1, %ecx
	movl $9, %r8d
	movl %edi, %r9d
	cmpl %r8d, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_6
.main_5:
	movq $0, %r8
	movq %rdx, %r9
	addq %r8, %r9
	movl (%r9), %r8d
	movl $10, %r9d
	imull %esi, %r9d
	movl %r9d, %ecx
	addl %r8d, %ecx
	movq $8, %r8
	movq %rdx, %r9
	addq %r8, %r9
	movq (%r9), %r9
	movl %edi, %r8d
	addl $1, %r8d
.main_9:
	movl %r8d, %edi
	movl %ecx, %esi
	movq %r9, %rdx
	jmp .main_4
.main_6:
	movl %esi, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
