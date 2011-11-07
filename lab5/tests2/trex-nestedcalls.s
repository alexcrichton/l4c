.file	"../tests2/trex-nestedcalls.l3"
.globl _c0_main
_c0_f:
	addq $-8, %rsp
.f_0:
	movl %edi, %eax
	addl $1, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_f
	movl %eax, %edi
	callq _c0_f
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
