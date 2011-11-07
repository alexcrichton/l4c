.file	"../tests2/stegosaurus-digits.l3"
.globl _c0_main
_c0_f:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.f_0:
	movl $1, %edx
	movl $0, %r8d
	movl %edi, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %edx
	jnz .f_3
.f_1:
	movl $0, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.f_3:
.f_4:
	movl $10, %r9d
	movl %edi, %eax
	cltd
	idivl %r9d
	movl %edx, %r9d
	movl $10, %r8d
	movl %edi, %eax
	cltd
	idivl %r8d
	movl %eax, %edi
	movq %r9, %rbx
	callq _c0_f
	movq %rbx, %r9
	addl %eax, %r9d
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
.main_0:
	movl $0, %r9d
	movl $0, %r8d
.main_5:
.main_1:
	movl $1, %esi
	movl $2000000, %edx
	movl %r8d, %ecx
	cmpl %edx, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .main_3
.main_2:
	movl %r8d, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_f
	movq %r12, %r8
	movq %rbx, %r9
	addl %eax, %r9d
	addl $1, %r8d
.main_4:
	jmp .main_1
.main_3:
	movl %r9d, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
