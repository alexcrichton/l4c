.file	"../tests2/styracosaurus-exception02.l3"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %edi
	subl $1, %edi
	callq _c0_foo
	addq $8, %rsp
	ret
_c0_foo:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.foo_0:
	movl $1, %edx
	movl $0, %r9d
	movl %edi, %r8d
	cmpl %r9d, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .foo_3
.foo_1:
	movl $0, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.foo_3:
.foo_4:
	movl %edi, %r9d
	addl $5, %r9d
	movl %r9d, %edi
	subl $6, %edi
	movq %r9, %rbx
	callq _c0_foo
	movq %rbx, %r9
	movl %eax, %r8d
	movl %r9d, %eax
	addl %r8d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
