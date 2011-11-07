.file	"../tests1/gyrfalcon-return03.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $65536, %eax
	movl $2, %r9d
	cltd
	idivl %r9d
	movl $2, %r9d
	cltd
	idivl %r9d
	movl $2, %r9d
	cltd
	idivl %r9d
	movl $2, %r9d
	cltd
	idivl %r9d
	movl $2, %r9d
	cltd
	idivl %r9d
	movl $3, %r9d
	cltd
	idivl %r9d
	movl $3, %r9d
	cltd
	idivl %r9d
	movl $2, %r9d
	cltd
	idivl %r9d
	movl $2, %r9d
	cltd
	idivl %r9d
	movl $2, %r9d
	cltd
	idivl %r9d
	movl $2, %r9d
	cltd
	idivl %r9d
	movl $2, %r9d
	cltd
	idivl %r9d
	movl $2, %r9d
	cltd
	idivl %r9d
	movl $2, %r9d
	cltd
	idivl %r9d
	movl $2, %r9d
	cltd
	idivl %r9d
	movl $2, %r9d
	cltd
	idivl %r9d
	movl $2, %r9d
	cltd
	idivl %r9d
	movl %eax, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
