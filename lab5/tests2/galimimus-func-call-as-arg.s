.file	"../tests2/galimimus-func-call-as-arg.l3"
.globl _c0_main
_c0_square:
	addq $-8, %rsp
.square_0:
	movl %edi, %eax
	imull %edi, %eax
	addq $8, %rsp
	ret
_c0_double:
	addq $-8, %rsp
.double_0:
	movl %edi, %eax
	addl %edi, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $3, %edi
	callq _c0_double
	movl %eax, %edi
	callq _c0_square
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
