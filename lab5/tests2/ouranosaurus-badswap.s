.file	"../tests2/ouranosaurus-badswap.l4"
.globl _c0_main
_c0_badswap:
	addq $-8, %rsp
.badswap_0:
	movq %rsi, %r8
	movl (%r8), %edx
	movq %rdi, %rcx
	movq %rdi, %r8
	movl (%r8), %r8d
	movl %r8d, (%rcx)
	xorl %edx, (%rcx)
	movq %rdi, %r8
	movl (%r8), %edx
	movq %rsi, %rcx
	movq %rsi, %r8
	movl (%r8), %r8d
	movl %r8d, (%rcx)
	xorl %edx, (%rcx)
	movq %rsi, %r8
	movl (%r8), %ecx
	movq %rdi, %r8
	movq %rdi, %r9
	movl (%r9), %r9d
	movl %r9d, (%r8)
	xorl %ecx, (%r8)
	movl $1, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movq $1, %rdi
	movq $4, %rsi
	callq calloc
	movq %rax, %r9
	movq %r9, %r8
	movl $5, (%r8)
	movq %r9, %rdi
	movq %r9, %rsi
	movq %r9, %rbx
	callq _c0_badswap
	movq %rbx, %r9
	movl (%r9), %r9d
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
