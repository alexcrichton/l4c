.file	"../tests1/condor-return07.l4"
.globl _c0_main
_c0_sumList:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.sumList_0:
	movl $1, %r8d
	movq $0, %rcx
	movq %rdi, %r9
	cmpq %rcx, %r9
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %r8d
	jnz .sumList_3
.sumList_1:
	movl $0, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.sumList_3:
.sumList_4:
	movq $0, %r8
	movq %rdi, %r9
	addq %r8, %r9
	movl (%r9), %r9d
	movq $8, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movq %r8, %rdi
	movq %r9, %rbx
	callq _c0_sumList
	movq %rbx, %r9
	addl %eax, %r9d
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_addHead:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
	movl %edi, %r9d
	movq %rsi, %r8
.addHead_0:
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
	movl %r9d, (%rcx)
	movq $8, %r9
	movq %rax, %rcx
	addq %r9, %rcx
	movq %r8, (%rcx)
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movq $1, %rdi
	movq $16, %rsi
	callq calloc
	movl $1, %r9d
.main_5:
	movq %rax, %rsi
.main_1:
	movl $1, %edx
	movl $5, %ecx
	movl %r9d, %r8d
	cmpl %ecx, %r8d
	setle %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_3
.main_2:
	movl %r9d, %edi
	movq %r9, %rbx
	callq _c0_addHead
	movq %rbx, %r9
	movq %rax, %r8
	addl $1, %r9d
.main_4:
	movq %r8, %rsi
	jmp .main_1
.main_3:
	movq %rsi, %rdi
	callq _c0_sumList
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
