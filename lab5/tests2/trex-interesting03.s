.file	"../tests2/trex-interesting03.l2"
.globl _c0_main
_c0_main:
	addq $-56, %rsp
	movq %r15, 16(%rsp)
	movq %r14, 24(%rsp)
	movq %r13, 32(%rsp)
	movq %r12, 40(%rsp)
	movq %rbx, 48(%rsp)
.main_0:
	movl $2520, %r8d
	movl $11, %ebx
	movl $20, %ecx
	movl $1, %edx
	sall $31, %edx
	movl %edx, %r12d
	subl $1, %r12d
	movl %r8d, %edx
.main_16:
	movl %edx, %esi
.main_1:
	movl $1, %edi
	movl %esi, %edx
	cmpl %r12d, %edx
	setle %dl
	movzbl %dl, %edx
	cmpl %edx, %edi
	jnz .main_14
.main_2:
	movl $1, %edi
	movl %ebx, %edx
.main_18:
	movl %edx, %r13d
.main_3:
	movl $1, %eax
	movl %r13d, %edx
	cmpl %ecx, %edx
	setle %dl
	movzbl %dl, %edx
	cmpl %edx, %eax
	jnz .main_20
.main_4:
	movl %esi, %eax
	cltd
	idivl %r13d
	movl %edx, %r15d
	movl $1, %r14d
	movl $0, %eax
	movl %r15d, %edx
	cmpl %eax, %edx
	setne %dl
	movzbl %dl, %edx
	cmpl %edx, %r14d
	jnz .main_7
.main_5:
	movl $0, %edx
	jmp .main_19
.main_7:
.main_8:
	movl %r13d, %edx
	addl $1, %edx
.main_17:
	movl %r15d, %r9d
	movl %edx, %r13d
	jmp .main_3
.main_20:
	movl %edi, %edx
.main_9:
	movl $1, %edi
	cmpl %edx, %edi
	jnz .main_12
.main_10:
	movl %esi, %eax
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
.main_12:
.main_13:
	movl %esi, %edx
	addl %r8d, %edx
.main_15:
	movl %edx, %esi
	jmp .main_1
.main_14:
	movl %esi, %eax
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
.main_19:
	jmp .main_9
.ident	"15-411 L4 reference compiler"
