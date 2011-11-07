.file	"../tests1/lammergeier-chikorita.l3"
.globl _c0_main
_c0__c0_main:
	addq $-8, %rsp
._c0_main_0:
	movl $17, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	callq _c0__c0_main
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
