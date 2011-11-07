.file	"../tests1/lammergeier-mudkip.l4"
.globl _c0_main
_c0_mud_:
	addq $-8, %rsp
.mud__0:
	callq _c0_kip_
	movl $0, %eax
	addq $8, %rsp
	ret
_c0_kip_:
	addq $-8, %rsp
.kip__0:
	callq _c0_mud_
	movl $0, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	callq _c0_mud_
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
