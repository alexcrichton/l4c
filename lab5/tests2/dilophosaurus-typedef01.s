.file	"../tests2/dilophosaurus-typedef01.l3"
.globl _c0_main
_c0_plus:
	addq $-8, %rsp
.plus_0:
	movl %edi, %eax
	addl %esi, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movl $6, %edi
	movl $7, %esi
	callq _c0_plus
	movl %eax, %r9d
	movl $8, %edi
	movl $9, %esi
	movq %r9, %rbx
	callq _c0_plus
	movq %rbx, %r9
	movl %r9d, %edi
	movl %eax, %esi
	callq _c0_plus
	movl $5, %edi
	movl %eax, %esi
	callq _c0_plus
	movl %eax, %r9d
	orl $8, %r9d
	sarl $1, %r9d
	movl %r9d, %eax
	sall $1, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
