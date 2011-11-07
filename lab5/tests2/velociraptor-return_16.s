.file	"../tests2/velociraptor-return_16.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %r9d
	movl $6, %r8d
	movl %r8d, %eax
	subl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
