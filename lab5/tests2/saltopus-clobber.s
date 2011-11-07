.file	"../tests2/saltopus-clobber.l3"
.globl _c0_main
_c0_f:
	addq $-8, %rsp
	movl %edx, %eax
	movl 16(%rsp), %r9d
.f_0:
	cltd
	idivl %ecx
	movl %esi, %ecx
	addl %r9d, %ecx
	movl %eax, %r9d
	sall %cl, %r9d
	movl %r9d, %eax
	movl %r8d, %ecx
	sall %cl, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-24, %rsp
.main_0:
	movl $10, %edi
	movl $9, %esi
	movl $8, %edx
	movl $7, %ecx
	movl $6, %r8d
	movl $5, %r9d
	movl $4, 0(%rsp)
	callq _c0_f
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
