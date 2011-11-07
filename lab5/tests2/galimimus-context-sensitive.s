.file	"../tests2/galimimus-context-sensitive.l4"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1, %r9d
	movl $0, %ecx
	movl %r9d, %r8d
	imull %ecx, %r8d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
