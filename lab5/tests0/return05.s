.file	"../tests0/return05.l3"
.globl _c0_main
_c0_main:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
.main_0:
	movl $10, %edi
	callq tofloat
	movl %eax, %r9d
	movl $5, %edi
	movq %r9, %rbx
	callq tofloat
	movq %rbx, %r9
	movl %r9d, %edi
	movl %eax, %esi
	movq %r9, %rbx
	callq fadd
	movq %rbx, %r9
	movl %eax, %r8d
	movl $2, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq tofloat
	movq %r12, %r8
	movq %rbx, %r9
	movl %r8d, %edi
	movl %eax, %esi
	movq %r9, %rbx
	callq fdiv
	movq %rbx, %r9
	movl %r9d, %edi
	movl %eax, %esi
	callq fmul
	movl %eax, %r9d
	movl %r9d, %edi
	movq %r9, %rbx
	callq printfloat
	movq %rbx, %r9
	movl $10, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl %r9d, %edi
	callq fromfloat
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
