.file	"../tests2/styracosaurus-linkedlist.l4"
.globl _c0_main
_c0_main:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
.main_0:
	movq $0, %r9
	movl $1, %r8d
.main_8:
.main_1:
	movl $1, %esi
	movl $6, %edx
	movl %r8d, %ecx
	cmpl %edx, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .main_3
.main_2:
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
	movq $8, %rdx
	movq %rax, %rcx
	addq %rdx, %rcx
	movq %r9, (%rcx)
	movq %rax, %r9
	addl $1, %r8d
.main_7:
	jmp .main_1
.main_3:
	movl $0, %r8d
.main_10:
	movq %r9, %rsi
	movl %r8d, %edx
.main_4:
	movl $1, %ecx
	movq $0, %r8
	movq %rsi, %r9
	cmpq %r8, %r9
	setne %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_6
.main_5:
	movl %edx, %ecx
	imull $10, %ecx
	movq $0, %r8
	movq %rsi, %r9
	addq %r8, %r9
	movl (%r9), %r9d
	addl %r9d, %ecx
	movq $8, %r8
	movq %rsi, %r9
	addq %r8, %r9
	movq (%r9), %r9
.main_9:
	movq %r9, %rsi
	movl %ecx, %edx
	jmp .main_4
.main_6:
	movl %edx, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
