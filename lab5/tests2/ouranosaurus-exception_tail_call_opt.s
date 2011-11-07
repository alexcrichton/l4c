.file	"../tests2/ouranosaurus-exception_tail_call_opt.l3"
.globl _c0_main
_c0_f1:
	addq $-8, %rsp
.f1_0:
	callq _c0_f2
	addq $8, %rsp
	ret
_c0_f2:
	addq $-8, %rsp
.f2_0:
	callq _c0_f3
	addq $8, %rsp
	ret
_c0_f3:
	addq $-8, %rsp
.f3_0:
	callq _c0_f1
	addq $8, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	callq _c0_f1
	movl $0, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
