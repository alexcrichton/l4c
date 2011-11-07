.file	"../tests2/ouranosaurus-containsSeq.l4"
.globl _c0_main
_c0_containsSeq:
	addq $-40, %rsp
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
	movq %rdi, %r9
	movl %esi, %r8d
	movl %ecx, %r13d
.containsSeq_0:
	movl $0, %esi
	movl $0, %ecx
.containsSeq_8:
	movl %ecx, %r12d
	movl %esi, %ebx
.containsSeq_1:
	cmpl %r8d, %ebx
	jl .ternary_true1
	movl $0, %esi
	jmp .ternary_end2
.ternary_true1:
	movl %r12d, %esi
	cmpl %r13d, %esi
	setl %sil
	movzbl %sil, %esi
.ternary_end2:
	movl $1, %ecx
	cmpl %esi, %ecx
	jnz .containsSeq_6
.containsSeq_2:
	movl %ebx, %ecx
	imull $4, %ecx
	movslq %ecx, %rsi
	movq %r9, %rcx
	addq %rsi, %rcx
	movl (%rcx), %eax
	movl %r12d, %ecx
	imull $4, %ecx
	movslq %ecx, %rsi
	movq %rdx, %rcx
	addq %rsi, %rcx
	movl (%rcx), %edi
	movl $1, %esi
	movl %eax, %ecx
	cmpl %edi, %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .containsSeq_4
.containsSeq_3:
	movl %r12d, %ecx
	addl $1, %ecx
.containsSeq_10:
	movl %ecx, %esi
.containsSeq_5:
	movl %ebx, %ecx
	addl $1, %ecx
.containsSeq_7:
	movl %esi, %r12d
	movl %ecx, %ebx
	jmp .containsSeq_1
.containsSeq_4:
.containsSeq_9:
	movl %r12d, %esi
	jmp .containsSeq_5
.containsSeq_6:
	cmpl %r13d, %r12d
	jz .ternary_true3
	movl $0, %r9d
	jmp .ternary_end4
.ternary_true3:
	movl $1, %r9d
.ternary_end4:
	movl %r9d, %eax
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
_c0_main:
	addq $-40, %rsp
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
.main_0:
	movl $16, %r9d
	movl $4, %r8d
	movslq %r9d, %rdi
	movq $4, %rsi
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, %rcx
	movslq %r8d, %rdi
	movq $4, %rsi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $0, %edx
	imull $4, %edx
	movslq %edx, %rsi
	movq %rcx, %rdx
	addq %rsi, %rdx
	movl $0, (%rdx)
	movl $1, %edx
	imull $4, %edx
	movslq %edx, %rsi
	movq %rcx, %rdx
	addq %rsi, %rdx
	movl $8, (%rdx)
	movl $2, %edx
	imull $4, %edx
	movslq %edx, %rsi
	movq %rcx, %rdx
	addq %rsi, %rdx
	movl $4, (%rdx)
	movl $3, %edx
	imull $4, %edx
	movslq %edx, %rsi
	movq %rcx, %rdx
	addq %rsi, %rdx
	movl $12, (%rdx)
	movl $4, %edx
	imull $4, %edx
	movslq %edx, %rsi
	movq %rcx, %rdx
	addq %rsi, %rdx
	movl $2, (%rdx)
	movl $5, %edx
	imull $4, %edx
	movslq %edx, %rsi
	movq %rcx, %rdx
	addq %rsi, %rdx
	movl $10, (%rdx)
	movl $6, %edx
	imull $4, %edx
	movslq %edx, %rsi
	movq %rcx, %rdx
	addq %rsi, %rdx
	movl $6, (%rdx)
	movl $7, %edx
	imull $4, %edx
	movslq %edx, %rsi
	movq %rcx, %rdx
	addq %rsi, %rdx
	movl $14, (%rdx)
	movl $8, %edx
	imull $4, %edx
	movslq %edx, %rsi
	movq %rcx, %rdx
	addq %rsi, %rdx
	movl $1, (%rdx)
	movl $9, %edx
	imull $4, %edx
	movslq %edx, %rsi
	movq %rcx, %rdx
	addq %rsi, %rdx
	movl $9, (%rdx)
	movl $10, %edx
	imull $4, %edx
	movslq %edx, %rsi
	movq %rcx, %rdx
	addq %rsi, %rdx
	movl $5, (%rdx)
	movl $11, %edx
	imull $4, %edx
	movslq %edx, %rsi
	movq %rcx, %rdx
	addq %rsi, %rdx
	movl $13, (%rdx)
	movl $12, %edx
	imull $4, %edx
	movslq %edx, %rsi
	movq %rcx, %rdx
	addq %rsi, %rdx
	movl $3, (%rdx)
	movl $13, %edx
	imull $4, %edx
	movslq %edx, %rsi
	movq %rcx, %rdx
	addq %rsi, %rdx
	movl $11, (%rdx)
	movl $14, %edx
	imull $4, %edx
	movslq %edx, %rsi
	movq %rcx, %rdx
	addq %rsi, %rdx
	movl $7, (%rdx)
	movl $15, %edx
	imull $4, %edx
	movslq %edx, %rsi
	movq %rcx, %rdx
	addq %rsi, %rdx
	movl $15, (%rdx)
	movl $0, %edx
	imull $4, %edx
	movslq %edx, %rsi
	movq %rax, %rdx
	addq %rsi, %rdx
	movl $0, (%rdx)
	movl $1, %edx
	imull $4, %edx
	movslq %edx, %rsi
	movq %rax, %rdx
	addq %rsi, %rdx
	movl $12, (%rdx)
	movl $2, %edx
	imull $4, %edx
	movslq %edx, %rsi
	movq %rax, %rdx
	addq %rsi, %rdx
	movl $7, (%rdx)
	movl $3, %edx
	imull $4, %edx
	movslq %edx, %rsi
	movq %rax, %rdx
	addq %rsi, %rdx
	movl $15, (%rdx)
	movq %rcx, %rdi
	movl %r9d, %esi
	movq %rax, %rdx
	movl %r8d, %ecx
	callq _c0_containsSeq
	movl %eax, %r9d
	movl $1, %ecx
	movl $1, %r8d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_2
.main_1:
	movl $1, %eax
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.main_2:
	movl $0, %eax
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.ident	"15-411 L4 reference compiler"
