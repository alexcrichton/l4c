.file	"../tests2/stegosaurus-122-lcg.l4"
.globl _c0_main
_c0_init_rand:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movl %edi, %r9d
.init_rand_0:
	movq $1, %rdi
	movq $4, %rsi
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
_c0_rand:
	addq $-8, %rsp
.rand_0:
	movq $0, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl (%r8), %edx
	movq $0, %r8
	movq %rdi, %rcx
	addq %r8, %rcx
	movl %edx, %r8d
	imull $1664525, %r8d
	movl %r8d, (%rcx)
	addl $1013904223, (%rcx)
	movq $0, %r8
	movq %rdi, %r9
	addq %r8, %r9
	movl (%r9), %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
.main_0:
	movl $1234567890, %edi
	callq _c0_init_rand
	movq %rax, %r9
	movl $0, %r8d
.main_5:
.main_1:
	movl $1, %esi
	movl $10000, %edx
	movl %r8d, %ecx
	cmpl %edx, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .main_3
.main_2:
	movq %r9, %rdi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_rand
	movq %r12, %r8
	movq %rbx, %r9
	addl $1, %r8d
.main_4:
	jmp .main_1
.main_3:
	movq %r9, %rdi
	callq _c0_rand
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
