.file	"../tests2/dilophosaurus-return03.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %r9d
	subl $-2147483648, %r9d
	movl %r9d, %ecx
	subl $1, %ecx
	movl $0, %r8d
	subl %r9d, %r8d
	movl %r8d, %r9d
	addl %ecx, %r9d
	movl $0, %r8d
	subl %r9d, %r8d
	movl $0, %r9d
	subl $42, %r9d
	imull %r9d, %r8d
	movl $0, %eax
	subl %r8d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
