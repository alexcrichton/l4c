.file	"../tests2/brachiosaurus-shift-little-little-test.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $6, %r9d
	movl %r9d, %eax
	sall $2, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
