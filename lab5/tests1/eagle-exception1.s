.file	"../tests1/eagle-exception1.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1, %edx
	movl $2, %esi
	movl $3, %r9d
	movl $4, %r8d
	movl %r8d, %ecx
	subl %r9d, %ecx
	movl %esi, %r8d
	subl %edx, %r8d
	movl %ecx, %r9d
	subl %r8d, %r9d
	movl %r9d, %eax
	cltd
	idivl %r9d
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
