.file	"../tests2/apatosaurus-fn-decl02.l3"
.globl _c0_main
_c0_notused:
	addq $-8, %rsp
.notused_0:
	movl $0, %eax
	subl $9, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $777, %eax
	addq $8, %rsp
	ret
_c0_notused2:
	addq $-8, %rsp
.notused2_0:
	movl $0, %edi
	subl $9, %edi
	callq _c0_notused
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
