.file	"../tests2/apatosaurus-shift02.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1, %r9d
	sall $4, %r9d
	sall $2, %r9d
	movl $1, %ecx
	sall %cl, %r9d
	movl $1024, %r8d
	sarl $7, %r8d
	movl %r8d, %ecx
	sarl $1, %ecx
	movl $48, %r8d
	sarl %cl, %r8d
	movl %r9d, %eax
	addl %r8d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
