.file	"../tests2/diplodocus-nullpointer.l4"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movq $1, %rdi
	movq $8, %rsi
	callq calloc
	movq $0, %rcx
	movl $0, %r9d
	imull $8, %r9d
	movslq %r9d, %r8
	movq %rax, %r9
	addq %r8, %r9
	movq %rcx, (%r9)
	movl $0, %r9d
	imull $8, %r9d
	movslq %r9d, %r8
	movq %rax, %r9
	addq %r8, %r9
	movq (%r9), %r9
	movl $1, %ecx
	movq $0, %r8
	cmpq %r8, %r9
	setne %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_3
.main_1:
	movl $0, %eax
	addq $8, %rsp
	ret
.main_3:
.main_4:
	movl $0, %r9d
	imull $8, %r9d
	movslq %r9d, %r8
	movq %rax, %r9
	addq %r8, %r9
	movq (%r9), %r9
	movl (%r9), %r9d
	movl $0, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
