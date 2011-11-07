.file	"../tests2/styracosaurus-phi.l3"
.globl _c0_main
_c0_approx:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movl %edi, %r8d
.approx_0:
	movl $1, %edi
	movq %r8, %rbx
	callq tofloat
	movq %rbx, %r8
	movl %eax, %r9d
	movl $1, %esi
	movl $0, %edx
	movl %r8d, %ecx
	cmpl %edx, %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .approx_3
.approx_1:
	movl $1, %edi
	callq tofloat
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.approx_3:
.approx_4:
	movl %r8d, %edi
	subl $1, %edi
	movq %r9, %rbx
	callq _c0_approx
	movq %rbx, %r9
	movl %r9d, %edi
	movl %eax, %esi
	movq %r9, %rbx
	callq fadd
	movq %rbx, %r9
	movl %eax, %ecx
	movl %r9d, %edi
	movl %ecx, %esi
	callq fdiv
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
.main_0:
	movl $10000, %edi
	callq _c0_approx
	movl %eax, %r9d
	movl $1, %edi
	movq %r9, %rbx
	callq tofloat
	movq %rbx, %r9
	movl %eax, %ecx
	movl $10, %r8d
	movl %ecx, %edi
	movl %r9d, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq fadd
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq printfloat
	movq %r12, %r8
	movq %rbx, %r9
	movl %r8d, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl %r9d, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
