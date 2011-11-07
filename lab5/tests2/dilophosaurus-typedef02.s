.file	"../tests2/dilophosaurus-typedef02.l3"
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
	movl $5, %r9d
	movl %r9d, %edi
	addl $1, %edi
	movl $1, %esi
	movq %r9, %rbx
	callq _c0_plus
	movq %rbx, %r9
	movl %r9d, %edi
	addl $1, %edi
	movl %eax, %esi
	callq _c0_times
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
