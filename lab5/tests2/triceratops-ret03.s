.file	"../tests2/triceratops-ret03.l4"
.globl _c0_main
_c0_a:
	addq $-8, %rsp
.a_0:
	movl $0, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movq $0, %r9
	movq %r9, %rdi
	callq _c0_a
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
