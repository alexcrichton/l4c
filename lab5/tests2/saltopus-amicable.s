.file	"../tests2/saltopus-amicable.l3"
.globl _c0_main
_c0_d:
	addq $-8, %rsp
	movl %edi, %r9d
.d_0:
	movl $0, %r8d
	movl $1, %ecx
.d_8:
.d_1:
	movl $1, %edi
	movl %r9d, %edx
	sarl $1, %edx
	movl %edx, %esi
	addl $1, %esi
	movl %ecx, %edx
	cmpl %esi, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %edi
	jnz .d_6
.d_2:
	movl %r9d, %eax
	cltd
	idivl %ecx
	movl $1, %edi
	movl $0, %esi
	cmpl %esi, %edx
	sete %dl
	movzbl %dl, %edx
	cmpl %edx, %edi
	jnz .d_4
.d_3:
	addl %ecx, %r8d
.d_10:
	movl %r8d, %edx
.d_5:
	addl $1, %ecx
.d_7:
	movl %edx, %r8d
	jmp .d_1
.d_4:
.d_9:
	movl %r8d, %edx
	jmp .d_5
.d_6:
	movl %r8d, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-40, %rsp
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
.main_0:
	movl $0, %r9d
	movl $1, %r8d
.main_8:
.main_1:
	movl $1, %ecx
	movl $10000, %esi
	movl %r8d, %edx
	cmpl %esi, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %ecx
	jnz .main_6
.main_2:
	movl %r8d, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_d
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %ecx
	movl %ecx, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_d
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	cmpl %eax, %r8d
	jz .ternary_true1
	movl $0, %edx
	jmp .ternary_end2
.ternary_true1:
	movl %r8d, %edx
	cmpl %ecx, %edx
	setne %dl
	movzbl %dl, %edx
.ternary_end2:
	movl $1, %ecx
	cmpl %edx, %ecx
	jnz .main_4
.main_3:
	addl %r8d, %r9d
.main_10:
	movl %r9d, %ecx
.main_5:
	addl $1, %r8d
.main_7:
	movl %ecx, %r9d
	jmp .main_1
.main_4:
.main_9:
	movl %r9d, %ecx
	jmp .main_5
.main_6:
	movl %r9d, %eax
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.ident	"15-411 L4 reference compiler"
