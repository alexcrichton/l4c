.file	"../tests2/velociraptor-circle-of-life.l4"
.globl _c0_main
_c0_main:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
.main_0:
	movq $1, %rdi
	movq $16, %rsi
	callq calloc
	movq %rax, %r9
	movq $1, %rdi
	movq $16, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movq %rax, %r8
	movq $1, %rdi
	movq $16, %rsi
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r12, %r8
	movq %rbx, %r9
	movq %r9, %rdi
	movl $0, %esi
	movq $0, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movl $0, (%rcx)
	movq $0, %rdx
	movq %r8, %rcx
	addq %rdx, %rcx
	movl $0, (%rcx)
	movq $0, %rdx
	movq %rax, %rcx
	addq %rdx, %rcx
	movl $1, (%rcx)
	movq $8, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movq %r8, (%rcx)
	movq $8, %rcx
	addq %rcx, %r8
	movq %rax, (%r8)
	movq $8, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movq %r9, (%r8)
.main_5:
	movl %esi, %eax
.main_1:
	movl $1, %edx
	movl $1000, %ecx
	movl %eax, %r8d
	cmpl %ecx, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_3
.main_2:
	movq $8, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movq $0, %rcx
	addq %rcx, %r8
	movl (%r8), %esi
	movq $0, %r8
	movq %rdi, %rdx
	addq %r8, %rdx
	movq $0, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl (%r8), %r8d
	movl %r8d, (%rdx)
	addl %esi, (%rdx)
	movq $8, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movq %r8, %rcx
	movl %eax, %r8d
	addl $1, %r8d
.main_4:
	movl %r8d, %eax
	movq %rcx, %rdi
	jmp .main_1
.main_3:
	movq $0, %r8
	addq %r8, %r9
	movl (%r9), %r9d
	movl %r9d, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
