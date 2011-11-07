.file	"../tests2/diplodocus-return-typedef.l3"
.globl _c0_main
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movl $5, %r9d
	movl $1, %r8d
	movl %r9d, %edi
	movl $0, %esi
	movl $5, %edx
	movl %r8d, %ecx
	movq %r9, %rbx
	callq _c0_foo
	movq %rbx, %r9
	movl $3, %edi
	movl $1, %esi
	movl %r9d, %edx
	movl %eax, %ecx
	callq _c0_bar
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_foo:
	addq $-8, %rsp
	movl %edi, %r9d
	movl %esi, %r8d
	movl %ecx, %edi
.foo_0:
	movl $1, %esi
	movl %edx, %ecx
	cmpl %r9d, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .foo_2
.foo_1:
	movl %r8d, %eax
	addq $8, %rsp
	ret
.foo_2:
	movl %edi, %eax
	addq $8, %rsp
	ret
_c0_bar:
	addq $-8, %rsp
	movl %esi, %r8d
	movl %ecx, %esi
.bar_0:
	cmpl $0, %r8d
	jnz .ternary_true1
	movl $0, %ecx
	jmp .ternary_end2
.ternary_true1:
	movl %esi, %ecx
.ternary_end2:
	movl $1, %r8d
	cmpl %ecx, %r8d
	jnz .bar_3
.bar_1:
	movl %edi, %eax
	addl %edx, %eax
	addq $8, %rsp
	ret
.bar_3:
.bar_4:
	movl %edi, %eax
	subl %edx, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
