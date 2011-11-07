.file	"../tests2/dilophosaurus-block05.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %r9d
	movl $66, %ecx
	sall $24, %ecx
	movl $16728831, %r8d
	orl %ecx, %r8d
	movl $0, %r8d
	addl $1, %r8d
	addl $4, %r8d
	addl %r8d, %r9d
	movl $1, %r8d
	addl %r8d, %r9d
	movl $1, %r8d
	addl %r8d, %r9d
	movl $1, %r8d
	addl %r8d, %r9d
	movl $1, %r8d
	addl %r8d, %r9d
	movl $1, %r8d
	addl %r8d, %r9d
	movl $1, %r8d
	sall $5, %r8d
	movl %r9d, %eax
	orl %r8d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
