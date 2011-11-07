.file	"../tests2/ouranosaurus-mult_fun_decls.l3"
.globl _c0_main
_c0_def_me_cant_get_defed_again:
	addq $-8, %rsp
.def_me_cant_get_defed_again_0:
	movl $0, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	callq _c0_def_me_cant_get_defed_again
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
