.file	"../tests2/saltopus-collatz_diq.l2"
.globl _c0_main
_c0_main:
	addq $-56, %rsp
	movq %r15, 16(%rsp)
	movq %r14, 24(%rsp)
	movq %r13, 32(%rsp)
	movq %r12, 40(%rsp)
	movq %rbx, 48(%rsp)
.main_0:
	movl $8, %r9d
	movl $1, %edi
	movl $113382, %r8d
	movl $0, %ecx
	movl $0, %esi
.main_14:
	movl %ecx, %edx
	movl %esi, %ecx
.main_1:
	movl $1, %eax
	movl %ecx, %esi
	cmpl %r9d, %esi
	setl %sil
	movzbl %sil, %esi
	cmpl %esi, %eax
	jnz .main_12
.main_2:
	movl $0, %esi
	movl %edi, %edx
.main_16:
	movl %esi, %ebx
	movl %edx, %r12d
.main_3:
	movl $1, %esi
	movl %r12d, %edx
	cmpl %r8d, %edx
	setle %dl
	movzbl %dl, %edx
	cmpl %edx, %esi
	jnz .main_11
.main_4:
	movl $0, %esi
	movl %r12d, %edx
.main_18:
	movl %r13d, %r14d
	movl %edx, %r15d
.main_5:
	movl $1, %r13d
	movl $1, %eax
	movl %r15d, %edx
	cmpl %eax, %edx
	setne %dl
	movzbl %dl, %edx
	cmpl %edx, %r13d
	jnz .main_10
.main_6:
	movl $1, %r13d
	movl %r15d, %edx
	andl $1, %edx
	movl $0, %eax
	cmpl %eax, %edx
	sete %dl
	movzbl %dl, %edx
	cmpl %edx, %r13d
	jnz .main_8
.main_7:
	movl $2, %r13d
	movl %r15d, %eax
	cltd
	idivl %r13d
	movl %eax, %edx
.main_20:
	movl %eax, %r13d
	movl %edx, %eax
.main_9:
	movl %esi, %edx
	addl $1, %edx
.main_17:
	movl %r13d, %r14d
	movl %eax, %r15d
	movl %edx, %esi
	jmp .main_5
.main_8:
	movl $3, %edx
	imull %r15d, %edx
	addl $1, %edx
.main_19:
	movl %r14d, %r13d
	movl %edx, %eax
	jmp .main_9
.main_10:
	movl %ebx, %eax
	addl %esi, %eax
	movl %r12d, %edx
	addl $1, %edx
.main_15:
	movl %r14d, %r13d
	movl %eax, %ebx
	movl %edx, %r12d
	jmp .main_3
.main_11:
	addl $1, %ecx
.main_13:
	movl %ebx, %edx
	jmp .main_1
.main_12:
	movl %r8d, %r9d
	subl %edi, %r9d
	addl $1, %r9d
	movl %edx, %eax
	cltd
	idivl %r9d
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
.ident	"15-411 L4 reference compiler"
