.file	"../tests1/harrier-return_5.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $43, %r9d
	movl $2, %esi
	movl $34, %edx
	movl $999999, %ecx
	movl $0, %r8d
	subl $453823, %r8d
	addl %esi, %r9d
	addl %edx, %r9d
	addl %ecx, %r9d
	movl %r9d, %eax
	addl %r8d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
