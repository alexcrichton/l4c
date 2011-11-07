.file	"../tests2/apatosaurus-main01.l3"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %r9d
.main_1:
	movl $1, %r8d
	cmpl %r9d, %r8d
	jnz .main_4
.main_2:
	movl $0, %eax
	addq $8, %rsp
	ret
.main_4:
	movl $100, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
