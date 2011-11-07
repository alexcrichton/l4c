.file	"../tests1/goshawk-find_treasure.l4"
.globl _c0_main
_c0_setup:
	addq $-56, %rsp
	movq %rbp, 8(%rsp)
	movq %r15, 16(%rsp)
	movq %r14, 24(%rsp)
	movq %r13, 32(%rsp)
	movq %r12, 40(%rsp)
	movq %rbx, 48(%rsp)
	movl %edi, %r9d
.setup_0:
	movq $1, %rdi
	movq $88, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movq %rax, %r8
	movq $40, %rdx
	movq %r8, %rcx
	addq %rdx, %rcx
	movq $1, %rdi
	movq $16, %rsi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, (%rcx)
	movq $40, %rcx
	movq %r8, %rdx
	addq %rcx, %rdx
	movq (%rdx), %rcx
	movq $0, %rdx
	addq %rdx, %rcx
	movl $6, (%rcx)
	movq $40, %rcx
	movq %r8, %rdx
	addq %rcx, %rdx
	movq (%rdx), %rdi
	movq $40, %rdx
	movq %r8, %rcx
	addq %rdx, %rcx
	movq (%rcx), %rcx
	movq $0, %rdx
	addq %rdx, %rcx
	movl (%rcx), %esi
	movq $8, %rdx
	movq %rdi, %rcx
	addq %rdx, %rcx
	movslq %esi, %rdi
	movq $16, %rsi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, (%rcx)
	movl $0, %ecx
.setup_8:
	movl %ecx, %edx
.setup_1:
	movq $40, %rsi
	movq %r8, %rcx
	addq %rsi, %rcx
	movq (%rcx), %rcx
	movq $0, %rsi
	addq %rsi, %rcx
	movl (%rcx), %edi
	movl $1, %esi
	movl %edx, %ecx
	cmpl %edi, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .setup_6
.setup_2:
	movq $40, %rsi
	movq %r8, %rcx
	addq %rsi, %rcx
	movq (%rcx), %rcx
	movq $8, %rsi
	addq %rsi, %rcx
	movq (%rcx), %rdi
	movl %edx, %ecx
	imull $16, %ecx
	movslq %ecx, %rsi
	movq %rdi, %rcx
	addq %rsi, %rcx
	movq $0, %rsi
	addq %rsi, %rcx
	movl %edx, (%rcx)
	movl (%rcx), %r11d
	imull $10, %r11d
	movl %r11d, (%rcx)
	movq $40, %rsi
	movq %r8, %rcx
	addq %rsi, %rcx
	movq (%rcx), %rcx
	movq $8, %rsi
	addq %rsi, %rcx
	movq (%rcx), %rax
	movq $40, %rsi
	movq %r8, %rcx
	addq %rsi, %rcx
	movq (%rcx), %rcx
	movq $8, %rsi
	addq %rsi, %rcx
	movq (%rcx), %rdi
	movl %edx, %ecx
	imull $16, %ecx
	movslq %ecx, %rsi
	movq %rdi, %rcx
	addq %rsi, %rcx
	movq $0, %rsi
	addq %rsi, %rcx
	movl (%rcx), %edi
	movl %edx, %ecx
	imull $16, %ecx
	movslq %ecx, %rsi
	movq %rax, %rcx
	addq %rsi, %rcx
	movq $8, %rsi
	addq %rsi, %rcx
	movslq %edi, %rdi
	movq $8, %rsi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, (%rcx)
	movl $0, %ecx
.setup_10:
	movl %ecx, %r14d
.setup_3:
	movq $40, %rsi
	movq %r8, %rcx
	addq %rsi, %rcx
	movq (%rcx), %r13
	movq $8, %rsi
	movq %r13, %rcx
	addq %rsi, %rcx
	movq (%rcx), %r12
	movl %edx, %ecx
	imull $16, %ecx
	movslq %ecx, %rsi
	movq %r12, %rcx
	addq %rsi, %rcx
	movq $0, %rsi
	addq %rsi, %rcx
	movl (%rcx), %ebx
	movl $1, %esi
	movl %r14d, %ecx
	cmpl %ebx, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .setup_5
.setup_4:
	movq $40, %rsi
	movq %r8, %rcx
	addq %rsi, %rcx
	movq (%rcx), %rax
	movq $8, %rsi
	movq %rax, %rcx
	addq %rsi, %rcx
	movq (%rcx), %rdi
	movl %edx, %ecx
	imull $16, %ecx
	movslq %ecx, %rsi
	movq %rdi, %rcx
	addq %rsi, %rcx
	movq $8, %rsi
	addq %rsi, %rcx
	movq (%rcx), %rcx
	cmpl %r14d, %r9d
	jz .ternary_true1
	movl $0, %ebp
	jmp .ternary_end2
.ternary_true1:
	movl $1, %ebp
.ternary_end2:
	movl %r14d, %esi
	imull $8, %esi
	movslq %esi, %rsi
	movq %rcx, %r15
	addq %rsi, %r15
	movq $0, %rsi
	addq %rsi, %r15
	movl %ebp, (%r15)
	movl %r14d, %esi
	addl $1, %esi
.setup_9:
	movl %esi, %r14d
	jmp .setup_3
.setup_5:
	movl %edx, %ecx
	addl $1, %ecx
.setup_7:
	movl %ecx, %edx
	jmp .setup_1
.setup_6:
	movq %r8, %rax
	movq 8(%rsp), %rbp
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
_c0_locate_treasure:
	addq $-40, %rsp
	movq %r14, 8(%rsp)
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
	movq %rdi, %r9
.locate_treasure_0:
	movl $0, %r8d
.locate_treasure_12:
	movl %r8d, %r14d
.locate_treasure_1:
	movq $40, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movq $0, %rcx
	addq %rcx, %r8
	movl (%r8), %edx
	movl $1, %ecx
	movl %r14d, %r8d
	cmpl %edx, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .locate_treasure_10
.locate_treasure_2:
	movl $0, %r8d
.locate_treasure_14:
	movl %r8d, %r13d
.locate_treasure_3:
	movq $40, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %r12
	movq $8, %rcx
	movq %r12, %r8
	addq %rcx, %r8
	movq (%r8), %rbx
	movl %r14d, %r8d
	imull $16, %r8d
	movslq %r8d, %rcx
	movq %rbx, %r8
	addq %rcx, %r8
	movq $0, %rcx
	addq %rcx, %r8
	movl (%r8), %eax
	movl $1, %ecx
	movl %r13d, %r8d
	cmpl %eax, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .locate_treasure_9
.locate_treasure_4:
	movq $40, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %rdi
	movq $8, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movq (%r8), %rsi
	movl %r14d, %r8d
	imull $16, %r8d
	movslq %r8d, %rcx
	movq %rsi, %r8
	addq %rcx, %r8
	movq $8, %rcx
	addq %rcx, %r8
	movq (%r8), %rdx
	movl %r13d, %r8d
	imull $8, %r8d
	movslq %r8d, %rcx
	movq %rdx, %r8
	addq %rcx, %r8
	movq $0, %rcx
	addq %rcx, %r8
	movl (%r8), %ecx
	movl $1, %r8d
	cmpl %ecx, %r8d
	jnz .locate_treasure_7
.locate_treasure_5:
	movl %r13d, %eax
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.locate_treasure_7:
.locate_treasure_8:
	movl %r13d, %r8d
	addl $1, %r8d
.locate_treasure_13:
	movl %r8d, %r13d
	jmp .locate_treasure_3
.locate_treasure_9:
	movl %r14d, %r8d
	addl $1, %r8d
.locate_treasure_11:
	movl %r8d, %r14d
	jmp .locate_treasure_1
.locate_treasure_10:
	movl $0, %eax
	subl $1, %eax
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $42, %edi
	callq _c0_setup
	movq %rax, %r9
	movq %r9, %rdi
	callq _c0_locate_treasure
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
