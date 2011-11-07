.file	"../tests2/saltopus-collatz.l2"
.globl _c0_main
_c0_main:
	addq $-40, %rsp
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
.main_0:
	movl $0, %edx
	movl $1, %r9d
	movl $113382, %r8d
	movl %r9d, %ecx
.main_11:
	movl %edx, %esi
	movl %ecx, %ebx
.main_1:
	movl $1, %ecx
	movl %ebx, %edx
	cmpl %r8d, %edx
	setle %dl
	movzbl %dl, %edx
	cmpl %edx, %ecx
	jnz .main_9
.main_2:
	movl $0, %ecx
	movl %ebx, %edx
.main_13:
	movl %edx, %r13d
	movl %ecx, %edi
.main_3:
	movl $1, %edx
	movl $1, %ecx
	movl %r13d, %eax
	cmpl %ecx, %eax
	setne %al
	movzbl %al, %eax
	cmpl %eax, %edx
	jnz .main_8
.main_4:
	movl $1, %eax
	movl %r13d, %ecx
	andl $1, %ecx
	movl $0, %edx
	cmpl %edx, %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %eax
	jnz .main_6
.main_5:
	movl $2, %ecx
	movl %r13d, %eax
	cltd
	idivl %ecx
	movl %eax, %ecx
.main_15:
	movl %ecx, %edx
.main_7:
	movl %edi, %ecx
	addl $1, %ecx
.main_12:
	movl %eax, %r12d
	movl %edx, %r13d
	movl %ecx, %edi
	jmp .main_3
.main_6:
	movl $3, %ecx
	imull %r13d, %ecx
	addl $1, %ecx
.main_14:
	movl %r12d, %eax
	movl %ecx, %edx
	jmp .main_7
.main_8:
	movl %esi, %edx
	addl %edi, %edx
	movl %ebx, %ecx
	addl $1, %ecx
.main_10:
	movl %edx, %esi
	movl %ecx, %ebx
	jmp .main_1
.main_9:
	subl %r9d, %r8d
	movl %r8d, %r9d
	addl $1, %r9d
	movl %esi, %eax
	cltd
	idivl %r9d
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.ident	"15-411 L4 reference compiler"
