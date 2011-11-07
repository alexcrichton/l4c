.file	"../tests2/seismosaurus-error11.l4"
.globl _c0_main
_c0_foo:
	addq $-8, %rsp
.foo_0:
	movq %rdi, %r8
	movl (%r8), %r8d
	movq %rdi, %r9
	movl %r8d, (%r9)
	addl $1, (%r9)
	movl $1, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
.main_0:
	movq $1, %rdi
	movq $4, %rsi
	callq calloc
	movq %rax, %r9
	movl $0, %ecx
	movq %r9, %r8
	movl $0, (%r8)
.main_5:
	movl %ecx, %r8d
.main_1:
	movl $1, %esi
	movl $1000, %edx
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
	callq _c0_foo
	movq %r12, %r8
	movq %rbx, %r9
	addl $1, %r8d
.main_4:
	jmp .main_1
.main_3:
	movl (%r9), %r9d
	movl %r9d, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
