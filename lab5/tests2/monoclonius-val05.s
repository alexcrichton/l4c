.file	"../tests2/monoclonius-val05.l3"
.globl _c0_main
_c0_foo:
	addq $-8, %rsp
.foo_0:
	movl $2, %r8d
	movl %edi, %eax
	cltd
	idivl %r8d
	movl %edi, %r8d
	imull %edi, %r8d
	movl %r8d, %r9d
	addl %eax, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
_c0_bar:
	addq $-8, %rsp
.bar_0:
	movl $17, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movl $5, %edi
	callq _c0_foo
	movl %eax, %r9d
	movl $6, %edi
	movq %r9, %rbx
	callq _c0_bar
	movq %rbx, %r9
	addl %eax, %r9d
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
