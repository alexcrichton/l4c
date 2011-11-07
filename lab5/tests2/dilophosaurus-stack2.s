.file	"../tests2/dilophosaurus-stack2.l3"
.globl _c0_main
_c0_stackOverflow:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movl %edi, %r9d
	movl %ecx, %edi
	movl %r8d, %ebx
.stackOverflow_0:
	movl %r9d, %eax
	addl $1, %eax
	addl $2, %esi
	addl $3, %edx
	movl %edi, %ecx
	addl $4, %ecx
	movl %ebx, %r8d
	addl $5, %r8d
	movl %eax, %edi
	callq _c0_stackOverflow
	movl $42, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_eval:
	addq $-8, %rsp
.eval_0:
	movl $0, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movl $1, %eax
	movl $0, %r9d
	cltd
	idivl %r9d
	movl %eax, %r9d
	movl $1, %edi
	movl $1, %esi
	movl $1, %edx
	movl $1, %ecx
	movl $1, %r8d
	movq %r9, %rbx
	callq _c0_stackOverflow
	movq %rbx, %r9
	movl $1, %edi
	movl %r9d, %esi
	movl %eax, %edx
	callq _c0_eval
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
