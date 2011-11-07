.file	"../tests2/ouranosaurus-exception_stack_overflow.l3"
.globl _c0_main
_c0_overflow:
	addq $-8, %rsp
.overflow_0:
	callq _c0_overflow
	movl %eax, %r9d
	addl $1, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	callq _c0_overflow
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
