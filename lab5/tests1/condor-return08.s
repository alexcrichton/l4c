.file	"../tests1/condor-return08.l4"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movq $1, %rdi
	movq $8, %rsi
	callq calloc
	movq $0, %r8
	movq %rax, %r9
	addq %r8, %r9
	movl $5, (%r9)
	movq $4, %r8
	movq %rax, %r9
	addq %r8, %r9
	movl $3, (%r9)
	movq $4, %r8
	movq %rax, %r9
	addq %r8, %r9
	movl (%r9), %ecx
	movq $0, %r8
	movq %rax, %r9
	addq %r8, %r9
	movl (%r9), %r8d
	movl %ecx, %eax
	addl %r8d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
