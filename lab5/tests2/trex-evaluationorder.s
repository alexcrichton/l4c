.file	"../tests2/trex-evaluationorder.l3"
.globl _c0_main
_c0_f:
	addq $-8, %rsp
.f_0:
	movl $1, %eax
	addq $8, %rsp
	ret
_c0_g:
	addq $-8, %rsp
.g_0:
	callq _c0_g
	addq $8, %rsp
	ret
_c0_h:
	addq $-8, %rsp
.h_0:
	movl $1, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	callq _c0_g
	movl %eax, %r9d
	movq %r9, %rbx
	callq _c0_h
	movq %rbx, %r9
	movl %r9d, %edi
	movl %eax, %esi
	callq _c0_f
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
