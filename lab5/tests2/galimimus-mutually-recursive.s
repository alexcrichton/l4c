.file	"../tests2/galimimus-mutually-recursive.l3"
.globl _c0_main
_c0_foo:
	addq $-8, %rsp
.foo_0:
	movl $1, %edx
	movl $0, %ecx
	movl %edi, %r8d
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .foo_3
.foo_1:
	movl $1, %eax
	addq $8, %rsp
	ret
.foo_3:
.foo_4:
	subl $1, %edi
	callq _c0_bar
	addq $8, %rsp
	ret
_c0_bar:
	addq $-8, %rsp
.bar_0:
	movl $1, %edx
	movl $0, %ecx
	movl %edi, %r8d
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .bar_3
.bar_1:
	movl $0, %eax
	addq $8, %rsp
	ret
.bar_3:
.bar_4:
	subl $1, %edi
	callq _c0_foo
	addq $8, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $3, %edi
	callq _c0_foo
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
