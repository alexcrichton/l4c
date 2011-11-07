.file	"../tests2/galimimus-op-prec.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $3, %r9d
	addl $2, %r9d
	movl $8, %r8d
	sarl $1, %r8d
	sall $2, %r8d
	movl %r9d, %ecx
	addl %r8d, %ecx
	movl $0, %r9d
	subl $1, %r9d
	movl %r9d, %r8d
	sarl $31, %r8d
	movl %ecx, %eax
	andl %r8d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
