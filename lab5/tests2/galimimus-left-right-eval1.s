.file	"../tests2/galimimus-left-right-eval1.l4"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movq $0, %r9
	movl $1, %eax
	movl $0, %r8d
	cltd
	idivl %r8d
	movl %eax, (%r9)
	movl $0, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
