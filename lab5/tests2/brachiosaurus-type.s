.file	"../tests2/brachiosaurus-type.l4"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $2, %r9d
	movl $1, %ecx
	movl %r9d, %r8d
	imull %ecx, %r8d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
