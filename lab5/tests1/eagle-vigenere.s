.file	"../tests1/eagle-vigenere.l3"
.globl _c0_main
_c0_keychar:
	addq $-8, %rsp
.keychar_0:
	movl $7, %r8d
	movl %edi, %eax
	cltd
	idivl %r8d
	movl %edx, %ecx
	movl $1, %r8d
	movl $0, %edx
	cmpl %edx, %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %r8d
	jnz .keychar_2
.keychar_1:
	movl $100, %eax
	addq $8, %rsp
	ret
.keychar_2:
	movl $7, %r8d
	movl %edi, %eax
	cltd
	idivl %r8d
	movl %edx, %ecx
	movl $1, %r8d
	movl $1, %edx
	cmpl %edx, %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %r8d
	jnz .keychar_4
.keychar_3:
	movl $105, %eax
	addq $8, %rsp
	ret
.keychar_4:
	movl $7, %r8d
	movl %edi, %eax
	cltd
	idivl %r8d
	movl %edx, %ecx
	movl $1, %r8d
	movl $2, %edx
	cmpl %edx, %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %r8d
	jnz .keychar_6
.keychar_5:
	movl $99, %eax
	addq $8, %rsp
	ret
.keychar_6:
	movl $7, %r8d
	movl %edi, %eax
	cltd
	idivl %r8d
	movl %edx, %r8d
	movl $1, %edx
	movl $3, %ecx
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .keychar_8
.keychar_7:
	movl $107, %eax
	addq $8, %rsp
	ret
.keychar_8:
	movl $7, %r8d
	movl %edi, %eax
	cltd
	idivl %r8d
	movl %edx, %r8d
	movl $1, %edx
	movl $4, %ecx
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .keychar_10
.keychar_9:
	movl $101, %eax
	addq $8, %rsp
	ret
.keychar_10:
	movl $7, %r8d
	movl %edi, %eax
	cltd
	idivl %r8d
	movl $1, %r9d
	movl $5, %ecx
	movl %edx, %r8d
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %r9d
	jnz .keychar_12
.keychar_11:
	movl $110, %eax
	addq $8, %rsp
	ret
.keychar_12:
	movl $115, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-40, %rsp
	movq %r14, 8(%rsp)
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
.main_0:
	movl $0, %r9d
.main_10:
.main_1:
	movq %r9, %rbx
	callq eof
	movq %rbx, %r9
	movl $1, %ecx
	movl $1, %r8d
	xorl %eax, %r8d
	cmpl %r8d, %ecx
	jnz .main_7
.main_2:
	movq %r9, %rbx
	callq readchar
	movq %rbx, %r9
	movl %eax, %ecx
	movl $97, %r8d
	cmpl %r8d, %ecx
	jl .ternary_true1
	movl $122, %r8d
	movl %r8d, %edx
	cmpl %ecx, %edx
	setl %dl
	movzbl %dl, %edx
	jmp .ternary_end2
.ternary_true1:
	movl $1, %edx
.ternary_end2:
	movl $1, %r8d
	cmpl %edx, %r8d
	jnz .main_5
.main_3:
	movl %ecx, %edi
	movq %rcx, %r12
	movq %r9, %rbx
	callq printchar
	movq %r12, %rcx
	movq %rbx, %r9
	movslq %eax, %r8
	jmp .main_9
.main_5:
.main_6:
	movl %r9d, %edi
	movq %rcx, %r12
	movq %r9, %rbx
	callq _c0_keychar
	movq %r12, %rcx
	movq %rbx, %r9
	movl %eax, %r8d
	subl $97, %ecx
	movl %ecx, %edx
	addl $26, %edx
	movl %r8d, %ecx
	subl $97, %ecx
	movl %edx, %eax
	subl %ecx, %eax
	movl $26, %ecx
	cltd
	idivl %ecx
	movl %edx, %ecx
	movl %ecx, %edx
	movl %edx, %edi
	addl $97, %edi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq printchar
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movslq %eax, %rsi
	addl $1, %r9d
.main_8:
	jmp .main_1
.main_7:
	movl $0, %eax
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.main_9:
	jmp .main_1
.ident	"15-411 L4 reference compiler"
