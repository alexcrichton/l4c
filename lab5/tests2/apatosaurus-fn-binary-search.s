.file	"../tests2/apatosaurus-fn-binary-search.l3"
.globl _c0_main
_c0_guess:
	addq $-56, %rsp
	movq %r15, 16(%rsp)
	movq %r14, 24(%rsp)
	movq %r13, 32(%rsp)
	movq %r12, 40(%rsp)
	movq %rbx, 48(%rsp)
	movl %edi, %r9d
	movl %esi, %r8d
	movl %edx, %esi
.guess_0:
	movl %r8d, %eax
	addl %esi, %eax
	movl $2, %edi
	cltd
	idivl %edi
	movl %eax, %edx
	movl %edx, %edi
	movq %rsi, %r15
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq printint
	movq %r15, %rsi
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $32, %edi
	movq %rsi, %r15
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq printchar
	movq %r15, %rsi
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl %ecx, %eax
	addl $1, %eax
	movl $1, %edi
	movl %r9d, %ecx
	cmpl %edx, %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %edi
	jnz .guess_2
.guess_1:
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
.guess_2:
	movl $1, %edi
	movl %r9d, %ecx
	cmpl %edx, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %edi
	jnz .guess_4
.guess_3:
	movl %r9d, %edi
	movl %r8d, %esi
	movl %eax, %ecx
	callq _c0_guess
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
.guess_4:
	movl %r9d, %edi
	movl %edx, %ecx
	movl %esi, %edx
	movl %eax, %r9d
	movl %ecx, %esi
	movl %r9d, %ecx
	callq _c0_guess
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $44, %edi
	movl $0, %esi
	movl $100, %edx
	movl $0, %ecx
	callq _c0_guess
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
