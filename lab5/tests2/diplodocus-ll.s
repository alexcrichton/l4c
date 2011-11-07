.file	"../tests2/diplodocus-ll.l4"
.globl _c0_main
_c0_insert_front:
	addq $-8, %rsp
.insert_front_0:
	movq $0, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movq (%r8), %rdx
	movq $8, %rcx
	movq %rsi, %r8
	addq %rcx, %r8
	movq %rdx, (%r8)
	movq $0, %r8
	movq %rdi, %r9
	addq %r8, %r9
	movq %rsi, (%r9)
	movl $1, %eax
	addq $8, %rsp
	ret
_c0_new_node:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movl %edi, %r9d
.new_node_0:
	movq $1, %rdi
	movq $16, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movq $0, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movl %r9d, (%r8)
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_new_list:
	addq $-8, %rsp
.new_list_0:
	movq $1, %rdi
	movq $8, %rsi
	callq calloc
	movq $0, %r8
	movq %rax, %r9
	addq %r8, %r9
	movq $0, (%r9)
	addq $8, %rsp
	ret
_c0_remove_front:
	addq $-8, %rsp
.remove_front_0:
	movq $0, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movl $1, %edx
	movq $0, %rcx
	cmpq %rcx, %r8
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .remove_front_2
.remove_front_1:
	movq $0, %rax
	addq $8, %rsp
	ret
.remove_front_2:
	movq $0, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movq %r8, %rdx
	movq $0, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movq $8, %rcx
	addq %rcx, %r8
	movq (%r8), %rcx
	movq $0, %r8
	movq %rdi, %r9
	addq %r8, %r9
	movq %rcx, (%r9)
	movq %rdx, %rax
	addq $8, %rsp
	ret
_c0_main:
	addq $-40, %rsp
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
.main_0:
	callq _c0_new_list
	movq %rax, %r9
	movl $1000, %ecx
	movl $0, %r8d
.main_12:
.main_1:
	movl $1, %esi
	movl %r8d, %edx
	cmpl %ecx, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %esi
	jnz .main_3
.main_2:
	movl %r8d, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_new_node
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movq %r9, %rdi
	movq %rax, %rsi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_insert_front
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	addl $1, %r8d
.main_11:
	jmp .main_1
.main_3:
	movl $0, %r8d
.main_14:
.main_4:
	movl $1, %esi
	movl %r8d, %edx
	cmpl %ecx, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %esi
	jnz .main_10
.main_5:
	movq %r9, %rdi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_remove_front
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, %rbx
	movq $0, %rsi
	movq %rbx, %rdx
	addq %rsi, %rdx
	movl (%rdx), %eax
	movl $1, %edi
	movl %ecx, %edx
	subl $1, %edx
	movl %edx, %esi
	subl %r8d, %esi
	movl %eax, %edx
	cmpl %esi, %edx
	setne %dl
	movzbl %dl, %edx
	cmpl %edx, %edi
	jnz .main_8
.main_6:
	movl $1, %eax
	movl $0, %r9d
	cltd
	idivl %r9d
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.main_8:
.main_9:
	movq $0, %rsi
	movq %rbx, %rdx
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
	movl $10, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq printchar
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	addl $1, %r8d
.main_13:
	jmp .main_4
.main_10:
	movl $1337, %eax
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.ident	"15-411 L4 reference compiler"
