.file	"../tests2/ouranosaurus-return02.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $7, %edx
	movl $4, %r9d
	movl %edx, %ecx
	addl %r9d, %ecx
	movl $0, %r8d
	subl %ecx, %r8d
	movl %r8d, %esi
	imull %edx, %esi
	movl %esi, %ecx
	addl %edx, %ecx
	movl $0, %r8d
	subl %ecx, %r8d
	addl %r9d, %r8d
	subl %esi, %edx
	movl $0, %eax
	subl %edx, %eax
	cltd
	idivl %r9d
	movl %r8d, %r9d
	addl %eax, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
