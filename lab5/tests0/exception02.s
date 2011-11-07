.file	"../tests0/exception02.l3"
.globl _c0_main
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movl $1, %edi
	callq tofloat
	movl %eax, %r9d
	movl $0, %edi
	movq %r9, %rbx
	callq tofloat
	movq %rbx, %r9
	movl %r9d, %edi
	movl %eax, %esi
	callq fdiv
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
	movq %r9, %rbx
	callq printhex
	movq %rbx, %r9
	movl $10, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
