.file	"../tests2/apatosaurus-fn-decl01.l3"
.globl _c0_main
_c0_f:
	addq $-8, %rsp
.f_0:
	callq _c0_g
	addq $8, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $9, %edi
	callq _c0_f
	addq $8, %rsp
	ret
_c0_g:
	addq $-8, %rsp
.g_0:
	movl %edi, %eax
	imull $2, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
