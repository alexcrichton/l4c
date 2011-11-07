.file	"../tests2/brachiosaurus-conjuration-calling.l3"
.globl _c0_main
_c0_gate:
	addq $-8, %rsp
	movl 16(%rsp), %r9d
	movl 24(%rsp), %edx
	movl 32(%rsp), %ecx
	movl 40(%rsp), %r8d
.gate_0:
	addl %edx, %r9d
	addl %ecx, %r9d
	movl %r9d, %eax
	addl %r8d, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-40, %rsp
.main_0:
	movl $1, %edi
	movl $2, %esi
	movl $3, %edx
	movl $4, %ecx
	movl $5, %r8d
	movl $6, %r9d
	movl $7, 0(%rsp)
	movl $8, 8(%rsp)
	movl $9, 16(%rsp)
	movl $10, 24(%rsp)
	callq _c0_gate
	addq $40, %rsp
	ret
.ident	"15-411 L4 reference compiler"
