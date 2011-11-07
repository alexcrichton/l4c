.file	"../tests2/styracosaurus-simple3.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $2, %r9d
	sall $1, %r9d
	movl %r9d, %r8d
	sall $4, %r8d
	movl $5, %ecx
	sarl %cl, %r8d
	movl %r9d, %ecx
	sall %cl, %r8d
	movl %r8d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
