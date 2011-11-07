.file	"../tests1/goshawk-pascal.l3"
.globl _c0_main
_c0_pascal:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
	movl %edi, %r9d
	movl %esi, %r8d
.pascal_0:
	movl $0, %ecx
	cmpl %ecx, %r8d
	jz .ternary_true1
	movl %r8d, %ecx
	cmpl %r9d, %ecx
	sete %cl
	movzbl %cl, %ecx
	jmp .ternary_end2
.ternary_true1:
	movl $1, %ecx
.ternary_end2:
	movl $1, %edx
	cmpl %ecx, %edx
	jnz .pascal_3
.pascal_1:
	movl $1, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.pascal_3:
.pascal_4:
	movl $0, %ecx
	cmpl %ecx, %r8d
	jl .ternary_true5
	movl %r9d, %ecx
	cmpl %r8d, %ecx
	setl %cl
	movzbl %cl, %ecx
	jmp .ternary_end6
.ternary_true5:
	movl $1, %ecx
.ternary_end6:
	cmpl $0, %ecx
	jnz .ternary_true3
	movl $0, %ecx
	movl %r9d, %edx
	cmpl %ecx, %edx
	setl %dl
	movzbl %dl, %edx
	jmp .ternary_end4
.ternary_true3:
	movl $1, %edx
.ternary_end4:
	movl $1, %ecx
	cmpl %edx, %ecx
	jnz .pascal_7
.pascal_5:
	movl $0, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.pascal_7:
.pascal_8:
	movl %r9d, %edi
	subl $1, %edi
	movl %r8d, %esi
	subl $1, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_pascal
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %ecx
	movl %r9d, %edi
	subl $1, %edi
	movl %r8d, %esi
	movq %rcx, %rbx
	callq _c0_pascal
	movq %rbx, %rcx
	movl %ecx, %r8d
	addl %eax, %r8d
	movl %r8d, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_main:
	addq $-72, %rsp
	movq %rbp, 16(%rsp)
	movq %r15, 24(%rsp)
	movq %r14, 32(%rsp)
	movq %r13, 40(%rsp)
	movq %r12, 48(%rsp)
	movq %rbx, 56(%rsp)
.main_0:
	movl $9, %ebx
	movl $0, %ecx
.main_11:
	movl %ecx, %edx
.main_1:
	movl $1, %esi
	movl %edx, %ecx
	cmpl %ebx, %ecx
	setle %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .main_9
.main_2:
	movl $0, %ecx
.main_13:
.main_3:
	movl $1, %edi
	movl %ecx, %esi
	cmpl %edx, %esi
	setle %sil
	movzbl %sil, %esi
	cmpl %esi, %edi
	jnz .main_8
.main_4:
	movl %edx, %edi
	movl %ecx, %esi
	movq %rdx, %r15
	movq %rcx, %r14
	movq %r8, %r13
	movq %r9, %r12
	callq _c0_pascal
	movq %r15, %rdx
	movq %r14, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movl %eax, %r13d
	movl %r13d, %r14d
	movl %r14d, %edi
	movq %rdx, 64(%rsp)
	movq %rcx, %rbp
	movq %r8, %r15
	movq %r9, %r12
	callq printint
	movq 64(%rsp), %rdx
	movq %rbp, %rcx
	movq %r15, %r8
	movq %r12, %r9
	movl %eax, %esi
	movslq %esi, %r12
	movl $1, %eax
	movl %ecx, %edi
	cmpl %edx, %edi
	setl %dil
	movzbl %dil, %edi
	cmpl %edi, %eax
	jnz .main_6
.main_5:
	movl $32, %edi
	movq %rsi, 64(%rsp)
	movq %rdx, %rbp
	movq %rcx, %r15
	callq printchar
	movq 64(%rsp), %rsi
	movq %rbp, %rdx
	movq %r15, %rcx
	movslq %eax, %r9
.main_15:
	movl %eax, %edi
	movq %r9, %rax
.main_7:
	addl $1, %ecx
.main_12:
	movl %edi, %r8d
	movq %rax, %r9
	jmp .main_3
.main_6:
.main_14:
	movl %r8d, %edi
	movq %r9, %rax
	jmp .main_7
.main_8:
	movl $10, %edi
	movq %rdx, %r14
	movq %r8, %r13
	movq %r9, %r12
	callq printchar
	movq %r14, %rdx
	movq %r13, %r8
	movq %r12, %r9
	movl %edx, %ecx
	addl $1, %ecx
.main_10:
	movl %ecx, %edx
	jmp .main_1
.main_9:
	movl $0, %eax
	movq 16(%rsp), %rbp
	movq 24(%rsp), %r15
	movq 32(%rsp), %r14
	movq 40(%rsp), %r13
	movq 48(%rsp), %r12
	movq 56(%rsp), %rbx
	addq $72, %rsp
	ret
.ident	"15-411 L4 reference compiler"
