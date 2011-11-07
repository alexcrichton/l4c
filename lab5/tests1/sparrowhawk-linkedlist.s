.file	"../tests1/sparrowhawk-linkedlist.l4"
.globl _c0_main
_c0_createList:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movl %edi, %r9d
.createList_0:
	movl $1, %edx
	movl $0, %ecx
	movl %r9d, %r8d
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .createList_3
.createList_1:
	movq $0, %rax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.createList_3:
.createList_4:
	movq $1, %rdi
	movq $16, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movq %rax, %r8
	movl %r9d, %edi
	subl $1, %edi
	movq %r8, %rbx
	callq _c0_createList
	movq %rbx, %r8
	movq $8, %r9
	movq %r8, %rdx
	addq %r9, %rdx
	movq %rax, (%rdx)
	movq %r8, %rax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_length:
	addq $-8, %rsp
.length_0:
	movl $1, %edx
	movq $0, %rcx
	movq %rdi, %r8
	cmpq %rcx, %r8
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .length_3
.length_1:
	movl $0, %eax
	addq $8, %rsp
	ret
.length_3:
.length_4:
	movq $8, %r8
	movq %rdi, %r9
	addq %r8, %r9
	movq (%r9), %r9
	movq %r9, %rdi
	callq _c0_length
	movl $1, %r9d
	addl %eax, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $5, %edi
	callq _c0_createList
	movq %rax, %r9
	movq %r9, %rdi
	callq _c0_length
	movl %eax, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
