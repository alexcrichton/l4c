.file	"../tests2/ouranosaurus-undef_fun.l3"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $42, %edi
	callq _c0_undefined_fun
	addq $8, %rsp
	ret
_c0_undefined_fun:
	addq $-8, %rsp
.undefined_fun_0:
	movl $0, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
