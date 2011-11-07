.file	"../tests2/velociraptor-return_09.l3"
.globl _c0_main
_c0_first:
	addq $-8, %rsp
.first_0:
	movl %edi, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movl $1, %edi
	movl $0, %esi
	callq _c0_first
	movl %eax, %r9d
	movl $0, %edi
	movl $1, %esi
	movq %r9, %rbx
	callq _c0_first
	movq %rbx, %r9
	movl %r9d, %edi
	movl %eax, %esi
	callq _c0_first
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
