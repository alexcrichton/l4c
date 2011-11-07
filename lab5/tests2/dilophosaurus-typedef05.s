.file	"../tests2/dilophosaurus-typedef05.l3"
.globl _c0_main
_c0_plus:
	addq $-8, %rsp
.plus_0:
	movl %edi, %eax
	addl %esi, %eax
	addq $8, %rsp
	ret
_c0_times:
	addq $-8, %rsp
.times_0:
	movl %edi, %eax
	imull %esi, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movl $5, %r8d
	movl $7, %r9d
	movl %r8d, %edi
	movl %r9d, %esi
	movq %r9, %rbx
	callq _c0_times
	movq %rbx, %r9
	movl %eax, %edi
	movl %r9d, %esi
	callq _c0_plus
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
