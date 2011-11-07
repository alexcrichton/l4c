.file	"../tests2/microceratops-return11.l3"
.globl _c0_main
_c0_retX:
	addq $-8, %rsp
.retX_0:
	movl %edi, %r9d
	sall $2, %r9d
	sarl $2, %r9d
	movl %r9d, %r8d
	orl %r9d, %r8d
	movl %r8d, %r9d
	andl %r8d, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movl $242, %r9d
	movl %r9d, %edi
	movq %r9, %rbx
	callq _c0_retX
	movq %rbx, %r9
	movl %r9d, %edi
	cmpl %eax, %edi
	sete %dil
	movzbl %dil, %edi
	callq booltoint
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
