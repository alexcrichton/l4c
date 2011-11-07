.file	"../tests2/seismosaurus-exception02.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %r9d
	subl $-2147483648, %r9d
	movl $2147483647, %r8d
	movl %r8d, %eax
	cltd
	idivl %r9d
	movl %r9d, %eax
	cltd
	idivl %r8d
	movl $0, %eax
	cltd
	idivl %r9d
	movl $0, %ecx
	subl $1, %ecx
	movl %r8d, %eax
	cltd
	idivl %ecx
	movl $0, %r8d
	subl $1, %r8d
	movl %r9d, %eax
	cltd
	idivl %r8d
	movl %eax, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
