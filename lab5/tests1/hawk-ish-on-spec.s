.file	"../tests1/hawk-ish-on-spec.l1"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $7, %r9d
	movl %r9d, %ecx
	addl $6, %ecx
	movl %r9d, %r8d
	addl $2, %r8d
	movl %ecx, %r9d
	imull %r8d, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
