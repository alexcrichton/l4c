.file	"../tests1/merlin-online_variance.l3"
.globl _c0_main
_c0_main:
	addq $-40, %rsp
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
.main_0:
	movl $0, %ecx
	movl $0, %r8d
	movl $0, %r9d
.main_5:
	movl %ecx, %esi
.main_1:
	movq %rsi, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq eof
	movq %r13, %rsi
	movq %r12, %r8
	movq %rbx, %r9
	movl $1, %edx
	movl $1, %ecx
	xorl %eax, %ecx
	cmpl %ecx, %edx
	jnz .main_3
.main_2:
	movq %rsi, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq readint
	movq %r13, %rsi
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %ecx
	addl $1, %r9d
	movl %ecx, %edi
	subl %esi, %edi
	movl %edi, %eax
	cltd
	idivl %r9d
	addl %eax, %esi
	movl %ecx, %edx
	subl %esi, %edx
	movl %edi, %ecx
	imull %edx, %ecx
	addl %ecx, %r8d
.main_4:
	jmp .main_1
.main_3:
	movl %r8d, %eax
	cltd
	idivl %r9d
	movl %eax, %edi
	callq printint
	movl $10, %edi
	callq printchar
	movl $0, %eax
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.ident	"15-411 L4 reference compiler"
