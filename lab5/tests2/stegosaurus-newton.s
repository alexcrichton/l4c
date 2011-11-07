.file	"../tests2/stegosaurus-newton.l3"
.globl _c0_main
_c0_fabs:
	addq $-8, %rsp
.fabs_0:
	movl %edi, %eax
	andl $2147483647, %eax
	addq $8, %rsp
	ret
_c0_A:
	addq $-40, %rsp
	movq %r14, 8(%rsp)
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
	movl %edi, %r9d
	movl %esi, %r8d
.A_0:
	movl %r8d, %edi
	movl %r8d, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq fmul
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %ecx
	movl %r9d, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq tofloat
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl %ecx, %edi
	movl %eax, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq fsub
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %ecx
	movl $2, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq tofloat
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %edi
	movl %r8d, %esi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq fmul
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl %ecx, %edi
	movl %eax, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq fdiv
	movq %r12, %r8
	movq %rbx, %r9
	movl %r8d, %edi
	movl %eax, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq fsub
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %ecx
	movl %ecx, %edi
	movl %r8d, %esi
	movq %rcx, %r12
	movq %r9, %rbx
	callq fsub
	movq %r12, %rcx
	movq %rbx, %r9
	movl %eax, %edi
	movq %rcx, %r12
	movq %r9, %rbx
	callq _c0_fabs
	movq %r12, %rcx
	movq %rbx, %r9
	movl %eax, %r8d
	movl $1, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq tofloat
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %edx
	movl $100, %edi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq tofloat
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl %edx, %edi
	movl %eax, %esi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq fdiv
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl %r8d, %edi
	movl %eax, %esi
	movq %rcx, %r12
	movq %r9, %rbx
	callq fsub
	movq %r12, %rcx
	movq %rbx, %r9
	movl $1, %r8d
	movl $0, %esi
	movl %eax, %edx
	cmpl %esi, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %r8d
	jnz .A_2
.A_1:
	movl %ecx, %eax
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.A_2:
	movl %r9d, %edi
	movl %ecx, %esi
	callq _c0_A
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $10, %edi
	callq tofloat
	movl $499999999, %edi
	movl %eax, %esi
	callq _c0_A
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
