.file	"../tests2/utahraptor-return09.l2"
.globl _c0_main
_c0_main:
	addq $-40, %rsp
	movq %r14, 8(%rsp)
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
.main_0:
	movl $0, %edx
	movl $2, %ecx
	movl $0, %r8d
.main_15:
	movl %ecx, %esi
	movl %edx, %ebx
.main_1:
	movl $1, %ecx
	movl $5, %edi
	movl %ebx, %edx
	cmpl %edi, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %ecx
	jnz .main_13
.main_2:
	movl %esi, %ecx
	subl $1, %ecx
	movl $1, %edi
	sall %cl, %edi
	movl $1, %edx
	movl %esi, %ecx
	sall %cl, %edx
	movl %edx, %r12d
	subl $1, %r12d
	movl $2, %ecx
.main_17:
.main_3:
	movl $1, %eax
	movl %ecx, %edx
	cmpl %r12d, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %eax
	jnz .main_19
.main_4:
	movl %r12d, %eax
	cltd
	idivl %ecx
	movl %edx, %r14d
	movl $1, %r13d
	movl $0, %eax
	movl %r14d, %edx
	cmpl %eax, %edx
	sete %dl
	movzbl %dl, %edx
	cmpl %edx, %r13d
	jnz .main_7
.main_5:
	jmp .main_18
.main_7:
.main_8:
	addl $1, %ecx
.main_16:
	movl %r14d, %r9d
	jmp .main_3
.main_19:
.main_9:
	movl $1, %edx
	cmpl %r12d, %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %edx
	jnz .main_11
.main_10:
	movl %edi, %ecx
	imull %r12d, %ecx
	addl %ecx, %r8d
	movl %ebx, %ecx
	addl $1, %ecx
.main_21:
	movl %r8d, %edi
.main_12:
	movl %esi, %edx
	addl $1, %edx
.main_14:
	movl %edi, %r8d
	movl %edx, %esi
	movl %ecx, %ebx
	jmp .main_1
.main_11:
.main_20:
	movl %r8d, %edi
	movl %ebx, %ecx
	jmp .main_12
.main_13:
	movl %r8d, %eax
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.main_18:
	jmp .main_9
.ident	"15-411 L4 reference compiler"
