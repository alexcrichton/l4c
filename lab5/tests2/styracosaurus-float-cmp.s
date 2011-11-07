.file	"../tests2/styracosaurus-float-cmp.l3"
.globl _c0_main
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movl $2, %edi
	callq tofloat
	movl %eax, %r9d
	movl $5, %edi
	movq %r9, %rbx
	callq tofloat
	movq %rbx, %r9
	movl %eax, %edi
	movl %r9d, %esi
	movq %r9, %rbx
	callq fdiv
	movq %rbx, %r9
	movl %eax, %ecx
	movl $1, %r8d
	cmpl %ecx, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %r8d
	jnz .main_2
.main_1:
	movl $1, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.main_2:
	movl $0, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
