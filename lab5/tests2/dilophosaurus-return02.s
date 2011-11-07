.file	"../tests2/dilophosaurus-return02.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $42, %eax
	movl $43, %r9d
	cltd
	idivl %r9d
	movl %edx, %r8d
	movl $43, %eax
	movl $43, %r9d
	cltd
	idivl %r9d
	movl %eax, %ecx
	movl $0, %eax
	subl $42, %eax
	movl $41, %r9d
	cltd
	idivl %r9d
	subl %ecx, %r8d
	movl %r8d, %eax
	subl %edx, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
