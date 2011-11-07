.file	"../tests2/trex-divbyzero.l3"
.globl _c0_main
_c0_f:
	addq $-8, %rsp
.f_0:
	movl $0, %eax
	addq $8, %rsp
	ret
_c0_g:
	addq $-8, %rsp
.g_0:
	callq _c0_f
	addq $8, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	callq _c0_f
	movl %eax, %r8d
	movq %r8, %rbx
	callq _c0_g
	movq %rbx, %r8
	movl %eax, %r9d
	movl %r8d, %eax
	cltd
	idivl %r9d
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
