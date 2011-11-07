.file	"../tests2/ouranosaurus-reverselist.l4"
.globl _c0_main
_c0_upto:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
.upto_0:
	movq $0, %r9
.upto_5:
	movl %edi, %r8d
.upto_1:
	movl $1, %edx
	movl $0, %ecx
	cmpl %r8d, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %edx
	jnz .upto_3
.upto_2:
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
	subl $1, %r8d
.upto_4:
	jmp .upto_1
.upto_3:
	movq %r9, %rax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_reverseList:
	addq $-8, %rsp
	movq %rdi, %r9
.reverseList_0:
	movq $0, %rdi
	movq %r9, %rsi
	movl $1, %edx
	movq $0, %rcx
	movq %r9, %r8
	cmpq %rcx, %r8
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .reverseList_3
.reverseList_1:
	movq %r9, %rax
	addq $8, %rsp
	ret
.reverseList_3:
.reverseList_4:
.reverseList_9:
	movq %rdi, %rdx
.reverseList_5:
	movq $8, %r8
	movq %rsi, %r9
	addq %r8, %r9
	movq (%r9), %r9
	movl $1, %ecx
	movq $0, %r8
	cmpq %r8, %r9
	setne %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .reverseList_7
.reverseList_6:
	movq $8, %r8
	movq %rsi, %r9
	addq %r8, %r9
	movq (%r9), %r9
	movq %r9, %rcx
	movq $8, %r8
	movq %rsi, %r9
	addq %r8, %r9
	movq %rdx, (%r9)
	movq %rsi, %r8
	movq %rcx, %r9
.reverseList_8:
	movq %r9, %rsi
	movq %r8, %rdx
	jmp .reverseList_5
.reverseList_7:
	movq $8, %r8
	movq %rsi, %r9
	addq %r8, %r9
	movq %rdx, (%r9)
	movq %rsi, %rax
	addq $8, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $100, %edi
	callq _c0_upto
	movq %rax, %r9
	movq %r9, %rdi
	callq _c0_reverseList
	movq %rax, %r9
	movq $0, %r8
	addq %r8, %r9
	movl (%r9), %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
