.file	"../tests1/kestrel-runtime2.l3"
.globl _c0_main
_c0_blerg:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.blerg_0:
	movl %edi, %eax
	cltd
	idivl %esi
	movl %eax, %r8d
	addl $1, %edi
	subl $1, %esi
	movq %r8, %rbx
	callq _c0_blerg
	movq %rbx, %r8
	movl %r8d, %r9d
	addl %eax, %r9d
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movl $42, %r9d
	movl %r9d, %edi
	movl %r9d, %esi
	movq %r9, %rbx
	callq _c0_blerg
	movq %rbx, %r9
	addl %eax, %r9d
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
