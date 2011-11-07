.file	"../tests2/velociraptor-eval-order.l4"
.globl _c0_main
_c0_nullify:
	addq $-8, %rsp
.nullify_0:
	movq %rdi, %r8
	movq (%r8), %r8
	movl (%r8), %r8d
	movq %rdi, %r9
	movq $0, (%r9)
	movl %r8d, %eax
	addq $8, %rsp
	ret
_c0_deref:
	addq $-8, %rsp
.deref_0:
	movq %rsi, %r8
	movq (%r8), %r8
	movl (%r8), %r8d
	movl %edi, %eax
	addl %r8d, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movq $1, %rdi
	movq $8, %rsi
	callq calloc
	movq %rax, %r9
	movq %r9, %r8
	movq (%r8), %r8
	movl $7, (%r8)
	movq %r9, %rdi
	movq %r9, %rbx
	callq _c0_nullify
	movq %rbx, %r9
	movl %eax, %edi
	movq %r9, %rsi
	callq _c0_deref
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
