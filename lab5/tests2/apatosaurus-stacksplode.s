.file	"../tests2/apatosaurus-stacksplode.l3"
.globl _c0_main
_c0_f:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.f_0:
	movl %edi, %r9d
	addl %edi, %r9d
	movl %r9d, %edi
	movq %r9, %rbx
	callq _c0_f
	movq %rbx, %r9
	movl %eax, %r8d
	movl %r9d, %edi
	movq %r8, %rbx
	callq _c0_f
	movq %rbx, %r8
	addl %eax, %r8d
	movl %r8d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1, %edi
	callq _c0_f
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
