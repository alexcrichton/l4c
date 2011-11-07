.file	"../tests2/stegosaurus-work-from-home.l4"
.globl _c0_main
_c0_frobulate:
	addq $-8, %rsp
.frobulate_0:
	movq %rdi, %r9
	movl $10, (%r9)
	movl $0, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
.main_0:
	movq $1, %rdi
	movq $4, %rsi
	callq calloc
	movq %rax, %r9
	movq %r9, %r8
	movl $1, (%r8)
	movq %r9, %r8
	movl (%r8), %r8d
	movq %r9, %rdi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_frobulate
	movq %r12, %r8
	movq %rbx, %r9
	movl (%r9), %ecx
	movl $2, %r9d
	imull %r8d, %r9d
	addl %eax, %r9d
	movl %r9d, %eax
	addl %ecx, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
