.file	"../tests2/velociraptor-return_10.l2"
.globl _c0_main
_c0_main:
	addq $-56, %rsp
	movq %rbp, 8(%rsp)
	movq %r15, 16(%rsp)
	movq %r14, 24(%rsp)
	movq %r13, 32(%rsp)
	movq %r12, 40(%rsp)
	movq %rbx, 48(%rsp)
.main_0:
	movl $0, %r8d
	movl $0, %ecx
	movl $0, %r9d
.main_14:
.main_1:
	movl $1, %eax
	movl $3, %edi
	movl %r9d, %edx
	cmpl %edi, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %eax
	jnz .main_12
.main_2:
	movl %r8d, %r12d
	addl $1, %r12d
	movl %r12d, %edx
.main_16:
	movl %edx, %eax
	movl %ecx, %edx
.main_3:
	movl $1, %ecx
	cmpl %ecx, %eax
	jnz .ternary_true1
	movl $0, %ecx
	jmp .ternary_end2
.ternary_true1:
	movl $4, %edi
	movl %eax, %ecx
	cmpl %edi, %ecx
	setne %cl
	movzbl %cl, %ecx
.ternary_end2:
	movl $1, %edi
	cmpl %ecx, %edi
	jnz .main_8
.main_4:
	movl $0, %edx
.main_18:
	movl %esi, %ebp
	movl %r13d, %r15d
	movl %eax, %r13d
	movl %edx, %edi
.main_5:
	movl $1, %esi
	movl $0, %edx
	cmpl %r13d, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %esi
	jnz .main_7
.main_6:
	movl $10, %esi
	movl %r13d, %eax
	cltd
	idivl %esi
	movl %edx, %r14d
	movl $10, %esi
	movl %r13d, %eax
	cltd
	idivl %esi
	movl %edx, %esi
	movl %r14d, %edx
	imull %esi, %edx
	addl %edx, %edi
	movl $10, %ebx
	movl %r13d, %eax
	cltd
	idivl %ebx
	movl %eax, %edx
	movl %edx, %eax
.main_17:
	movl %edx, %ebp
	movl %esi, %r15d
	movl %r14d, %ebx
	movl %eax, %r13d
	jmp .main_5
.main_7:
	movl %edi, %edx
.main_15:
	movl %ebp, %esi
	movl %r15d, %r13d
	movl %edx, %eax
	movl %edi, %edx
	jmp .main_3
.main_8:
	movl $1, %r14d
	movl $1, %edi
	movl %eax, %ecx
	cmpl %edi, %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %r14d
	jnz .main_10
.main_9:
	addl $1, %r9d
.main_20:
.main_11:
.main_13:
	movl %edx, %ecx
	movl %r12d, %r8d
	jmp .main_1
.main_10:
.main_19:
	jmp .main_11
.main_12:
	movl %r8d, %eax
	movq 8(%rsp), %rbp
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
.ident	"15-411 L4 reference compiler"
