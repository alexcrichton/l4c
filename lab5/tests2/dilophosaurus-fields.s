.file	"../tests2/dilophosaurus-fields.l4"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movq $1, %rdi
	movq $8, %rsi
	callq calloc
	movq $0, %r8
	movq %rax, %r9
	addq %r8, %r9
	movl $5, (%r9)
	movq $4, %r8
	movq %rax, %r9
	addq %r8, %r9
	movl $7, (%r9)
	movq $0, %r8
	movq %rax, %r9
	addq %r8, %r9
	movl (%r9), %ecx
	movq $4, %r8
	movq %rax, %r9
	addq %r8, %r9
	movl (%r9), %r8d
	movl %ecx, %eax
	imull %r8d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
