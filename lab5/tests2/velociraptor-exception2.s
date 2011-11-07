.file	"../tests2/velociraptor-exception2.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $7, %r9d
	movl %r9d, %r8d
	movl $3, %eax
	subl %r8d, %r9d
	cltd
	idivl %r9d
	movl %eax, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
