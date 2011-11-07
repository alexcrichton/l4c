.file	"../tests1/morepork-test_error_1.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $15, %r9d
	movl $0, %r8d
	movl $2, %eax
	cltd
	idivl %r8d
	movl %eax, %ecx
	subl %ecx, %r9d
	movl $0, %r8d
	subl %r9d, %r8d
	movl %ecx, %r9d
	addl $1, %r9d
	movl %r9d, %eax
	addl %r8d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
