.file	"../tests1/merlin-return-dynamic-mult.l4"
.globl _c0_main
_c0_mult:
	addq $-56, %rsp
	movq %rbp, 8(%rsp)
	movq %r15, 16(%rsp)
	movq %r14, 24(%rsp)
	movq %r13, 32(%rsp)
	movq %r12, 40(%rsp)
	movq %rbx, 48(%rsp)
	movq %rdi, %rcx
	movl %esi, %ebx
.mult_0:
	movslq %ebx, %rdi
	movq $4, %rsi
	movq %rcx, %r15
	movq %r8, %r14
	movq %r9, %r12
	callq calloc
	movq %r15, %rcx
	movq %r14, %r8
	movq %r12, %r9
	movq %rax, %rdx
	movslq %ebx, %rdi
	movq $4, %rsi
	movq %rdx, %rbp
	movq %rcx, %r15
	movq %r8, %r14
	movq %r9, %r12
	callq calloc
	movq %rbp, %rdx
	movq %r15, %rcx
	movq %r14, %r8
	movq %r12, %r9
	movq %rax, %r12
	movl %ebx, %edi
	subl $1, %edi
	movl $0, %esi
.mult_20:
	movl %esi, %ebp
	movl %edi, %r15d
.mult_1:
	movl $1, %edi
	movl %ebp, %esi
	cmpl %ebx, %esi
	setl %sil
	movzbl %sil, %esi
	cmpl %esi, %edi
	jnz .mult_9
.mult_2:
	movl $1, %eax
	movl $0, %edi
	movl %ebp, %esi
	cmpl %edi, %esi
	sete %sil
	movzbl %sil, %esi
	cmpl %esi, %eax
	jnz .mult_4
.mult_3:
	movl %ebp, %esi
	imull $4, %esi
	movslq %esi, %rdi
	movq %rcx, %rsi
	addq %rdi, %rsi
	movl (%rsi), %eax
	movl %ebp, %esi
	imull $4, %esi
	movslq %esi, %rdi
	movq %rdx, %rsi
	addq %rdi, %rsi
	movl %eax, (%rsi)
.mult_22:
.mult_5:
	movl $1, %eax
	movl %ebx, %edi
	subl $1, %edi
	movl %r15d, %esi
	cmpl %edi, %esi
	sete %sil
	movzbl %sil, %esi
	cmpl %esi, %eax
	jnz .mult_7
.mult_6:
	movl %r15d, %esi
	imull $4, %esi
	movslq %esi, %rdi
	movq %rcx, %rsi
	addq %rdi, %rsi
	movl (%rsi), %eax
	movl %r15d, %esi
	imull $4, %esi
	movslq %esi, %rdi
	movq %r12, %rsi
	addq %rdi, %rsi
	movl %eax, (%rsi)
.mult_24:
.mult_8:
	movl %r15d, %edi
	subl $1, %edi
	movl %ebp, %esi
	addl $1, %esi
.mult_19:
	movl %esi, %ebp
	movl %edi, %r15d
	jmp .mult_1
.mult_7:
	movl %r15d, %esi
	addl $1, %esi
	imull $4, %esi
	movslq %esi, %rdi
	movq %r12, %rsi
	addq %rdi, %rsi
	movl (%rsi), %r14d
	movl %r15d, %esi
	imull $4, %esi
	movslq %esi, %rdi
	movq %rcx, %rsi
	addq %rdi, %rsi
	movl (%rsi), %eax
	movl %r15d, %esi
	imull $4, %esi
	movslq %esi, %rdi
	movq %r12, %rsi
	addq %rdi, %rsi
	movl %r14d, (%rsi)
	movl (%rsi), %r11d
	imull %eax, %r11d
	movl %r11d, (%rsi)
.mult_23:
	jmp .mult_8
.mult_4:
	movl %ebp, %esi
	subl $1, %esi
	imull $4, %esi
	movslq %esi, %rsi
	movq %rdx, %rdi
	addq %rsi, %rdi
	movl (%rdi), %r14d
	movl %ebp, %esi
	imull $4, %esi
	movslq %esi, %rdi
	movq %rcx, %rsi
	addq %rdi, %rsi
	movl (%rsi), %eax
	movl %ebp, %esi
	imull $4, %esi
	movslq %esi, %rdi
	movq %rdx, %rsi
	addq %rdi, %rsi
	movl %r14d, (%rsi)
	movl (%rsi), %r11d
	imull %eax, %r11d
	movl %r11d, (%rsi)
.mult_21:
	jmp .mult_5
.mult_9:
	movl $0, %esi
.mult_26:
	movl %esi, %r14d
.mult_10:
	movl $1, %edi
	movl %r14d, %esi
	cmpl %ebx, %esi
	setl %sil
	movzbl %sil, %esi
	cmpl %esi, %edi
	jnz .mult_18
.mult_11:
	movl $1, %eax
	movl %ebx, %edi
	subl $1, %edi
	movl %r14d, %esi
	cmpl %edi, %esi
	sete %sil
	movzbl %sil, %esi
	cmpl %esi, %eax
	jnz .mult_12
.mult_15:
	movl %r14d, %esi
	subl $1, %esi
	imull $4, %esi
	movslq %esi, %rdi
	movq %rdx, %rsi
	addq %rdi, %rsi
	movl (%rsi), %eax
	movl %r14d, %esi
	imull $4, %esi
	movslq %esi, %rdi
	movq %rcx, %rsi
	addq %rdi, %rsi
	movl %eax, (%rsi)
.mult_30:
.mult_17:
	movl %r14d, %esi
	addl $1, %esi
.mult_25:
	movl %esi, %r14d
	jmp .mult_10
.mult_12:
	movl $1, %eax
	movl $0, %edi
	movl %r14d, %esi
	cmpl %edi, %esi
	sete %sil
	movzbl %sil, %esi
	cmpl %esi, %eax
	jnz .mult_14
.mult_13:
	movl %r14d, %esi
	addl $1, %esi
	imull $4, %esi
	movslq %esi, %rdi
	movq %r12, %rsi
	addq %rdi, %rsi
	movl (%rsi), %eax
	movl %r14d, %esi
	imull $4, %esi
	movslq %esi, %rdi
	movq %rcx, %rsi
	addq %rdi, %rsi
	movl %eax, (%rsi)
.mult_28:
	movl %eax, %r13d
.mult_16:
.mult_29:
	jmp .mult_17
.mult_14:
	movl %r14d, %r9d
	subl $1, %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq %rdx, %r9
	addq %r8, %r9
	movl (%r9), %edi
	movl %r14d, %r9d
	addl $1, %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq %r12, %r9
	addq %r8, %r9
	movl (%r9), %esi
	movl %r14d, %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq %rcx, %r9
	addq %r8, %r9
	movl %edi, (%r9)
	movl (%r9), %r11d
	imull %esi, %r11d
	movl %r11d, (%r9)
.mult_27:
	movl %esi, %r8d
	movl %edi, %r9d
	jmp .mult_16
.mult_18:
	movq %rdx, %rdi
	movl %ebx, %esi
	movq %rcx, %r13
	callq _c0_print_array
	movq %r13, %rcx
	movl $10, %edi
	movq %rcx, %r13
	callq printchar
	movq %r13, %rcx
	movq %r12, %rdi
	movl %ebx, %esi
	movq %rcx, %rbx
	callq _c0_print_array
	movq %rbx, %rcx
	movl $10, %edi
	movq %rcx, %rbx
	callq printchar
	movq %rbx, %rcx
	movq %rcx, %rax
	movq 8(%rsp), %rbp
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
_c0_print_array:
	addq $-40, %rsp
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
	movq %rdi, %r9
	movl %esi, %r8d
.print_array_0:
	movl $0, %ecx
.print_array_5:
.print_array_1:
	movl $1, %esi
	movl %ecx, %edx
	cmpl %r8d, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %esi
	jnz .print_array_3
.print_array_2:
	movl %ecx, %edx
	imull $4, %edx
	movslq %edx, %rsi
	movq %r9, %rdx
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
	addl $1, %ecx
.print_array_4:
	jmp .print_array_1
.print_array_3:
	movl $10, %edi
	callq printchar
	movl $0, %eax
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movl $8, %r9d
	movslq %r9d, %rdi
	movq $4, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movl $0, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movl $5, (%r8)
	movl $1, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movl $5, (%r8)
	movl $2, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movl $9, (%r8)
	movl $3, %r8d
	imull $4, %r8d
	movslq %r8d, %r8
	movq %rax, %rcx
	addq %r8, %rcx
	movl $6, (%rcx)
	movl $4, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movl $8, (%r8)
	movl $5, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movl $3, (%r8)
	movl $6, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movl $8, (%r8)
	movl $7, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movl $2, (%r8)
	movq %rax, %rdi
	movl %r9d, %esi
	movq %r9, %rbx
	callq _c0_mult
	movq %rbx, %r9
	movq %rax, %rdi
	movl %r9d, %esi
	callq _c0_print_array
	movl $0, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
