.file	"../tests2/stegosaurus-exception02.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $4, %r8d
	movl $3, %ecx
	movl %r8d, %r9d
	subl %ecx, %r9d
	movl %ecx, %eax
	subl %r8d, %eax
	cltd
	idivl %r9d
	movl %eax, %r9d
	movl $0, %eax
	subl $-2147483648, %eax
	cltd
	idivl %r9d
	movl %edx, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
