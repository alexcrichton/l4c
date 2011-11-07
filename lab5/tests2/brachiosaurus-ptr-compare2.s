.file	"../tests2/brachiosaurus-ptr-compare2.l4"
.globl _c0_main
_c0_foo:
	addq $-8, %rsp
.foo_0:
	movl $1, %ecx
	movq %rdi, %r8
	cmpq %rsi, %r8
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .foo_2
.foo_1:
	movq %rsi, %r8
	movl $89, (%r8)
	movq %rdi, %r9
	movl (%r9), %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.foo_2:
	movq %rdi, %r9
	movl $98, (%r9)
	movq %rsi, %r9
	movl (%r9), %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movq $1, %rdi
	movq $4, %rsi
	callq calloc
	movq %rax, %r9
	movq $1, %rdi
	movq $4, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movq %r9, %rdi
	movq %r9, %rsi
	callq _c0_foo
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
