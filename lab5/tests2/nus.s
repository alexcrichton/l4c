.file	"../tests2/nus.l4"
.globl _c0_main
_c0_main:
	addq $-40, %rsp
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
.main_0:
	movq $72, %rdi
	movq $8, %rsi
	callq calloc
	movq %rax, %r9
	movl $0, %r8d
.main_8:
.main_1:
	movl $1, %ecx
	movl $70, %esi
	movl %r8d, %edx
	cmpl %esi, %edx
	setle %dl
	movzbl %dl, %edx
	cmpl %edx, %ecx
	jnz .main_3
.main_2:
	movl %r8d, %ecx
	imull $8, %ecx
	movslq %ecx, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movq $52, %rdi
	movq $4, %rsi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, (%rcx)
	addl $1, %r8d
.main_7:
	jmp .main_1
.main_3:
	movl $0, %r8d
.main_10:
	movl %r8d, %esi
.main_4:
	movl $1, %edx
	movl $50, %ecx
	movl %esi, %r8d
	cmpl %ecx, %r8d
	setle %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_6
.main_5:
	movl $0, %r8d
	imull $8, %r8d
	movslq %r8d, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %rcx
	movl %esi, %r8d
	imull $4, %r8d
	movslq %r8d, %rdx
	movq %rcx, %r8
	addq %rdx, %r8
	movl %esi, (%r8)
	movl %esi, %r8d
	addl $1, %r8d
.main_9:
	movl %r8d, %esi
	jmp .main_4
.main_6:
	movl $0, %eax
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.ident	"15-411 L4 reference compiler"
