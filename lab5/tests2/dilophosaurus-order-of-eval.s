.file	"../tests2/dilophosaurus-order-of-eval.l3"
.globl _c0_main
_c0_next:
	addq $-8, %rsp
.next_0:
	movl %edi, %eax
	addl $1, %eax
	addq $8, %rsp
	ret
_c0_f:
	addq $-8, %rsp
	movl %edi, %eax
	movl %edx, %ecx
.f_0:
	cltd
	idivl %esi
	cltd
	idivl %ecx
	addq $8, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %edi
	subl $1, %edi
	callq _c0_next
	movl $1, %edi
	movl $2, %esi
	movl %eax, %edx
	callq _c0_f
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
