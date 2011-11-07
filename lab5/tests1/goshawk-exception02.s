.file	"../tests1/goshawk-exception02.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $2234, %eax
	movl $2343, %r9d
	cltd
	idivl %r9d
	movl $3423, %r9d
	cltd
	idivl %r9d
	movl $123, %r9d
	cltd
	idivl %r9d
	movl $234, %r9d
	cltd
	idivl %r9d
	movl %edx, %eax
	movl $2, %r9d
	cltd
	idivl %r9d
	movl %edx, %eax
	movl $1, %r9d
	cltd
	idivl %r9d
	movl %edx, %r8d
	movl $765, %eax
	movl $2, %r9d
	cltd
	idivl %r9d
	movl $6, %r9d
	cltd
	idivl %r9d
	movl $854, %r9d
	cltd
	idivl %r9d
	movl $234234, %r9d
	cltd
	idivl %r9d
	movl %eax, %r9d
	movl $111, %eax
	cltd
	idivl %r9d
	movl $234, %ecx
	addl $543542, %ecx
	subl %r8d, %ecx
	movl %ecx, %eax
	addl %edx, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
