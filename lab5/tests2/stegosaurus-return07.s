.file	"../tests2/stegosaurus-return07.l2"
.globl _c0_main
_c0_main:
	addq $-40, %rsp
	movq %r14, 8(%rsp)
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
.main_0:
	movl $37000, %r9d
	movl $0, %ecx
	movl $0, %r8d
.main_11:
	movl %ecx, %ebx
	movl %r8d, %r12d
.main_1:
	movl $1, %ecx
	movl %r12d, %r8d
	cmpl %r9d, %r8d
	setle %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .main_9
.main_2:
	movl $1, %r8d
	movl %r12d, %edx
	movl $2, %ecx
.main_13:
	movl %edx, %edi
	movl %r8d, %edx
	movl %ecx, %r13d
.main_3:
	movl $1, %ecx
	movl %r13d, %r8d
	cmpl %edi, %r8d
	setle %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .main_8
.main_4:
.main_15:
	movl %eax, %r8d
	movl %edi, %ecx
	movl %edx, %esi
.main_5:
	movl %ecx, %eax
	cltd
	idivl %r13d
	movl %edx, %edi
	movl $1, %r14d
	movl $0, %eax
	movl %edi, %edx
	cmpl %eax, %edx
	sete %dl
	movzbl %dl, %edx
	cmpl %edx, %r14d
	jnz .main_7
.main_6:
	movl %ecx, %eax
	cltd
	idivl %r13d
	movl %eax, %r8d
	movl %r8d, %eax
	movl %r13d, %ecx
	addl $1, %ecx
	movl %esi, %edx
	imull %ecx, %edx
.main_14:
	movl %eax, %ecx
	movl %edx, %esi
	jmp .main_5
.main_7:
	addl $1, %r13d
.main_12:
	movl %r8d, %eax
	movl %edi, %r14d
	movl %ecx, %edi
	movl %esi, %edx
	jmp .main_3
.main_8:
	movl %ebx, %ecx
	addl %edx, %ecx
	movl %r12d, %r8d
	addl $1, %r8d
.main_10:
	movl %ecx, %ebx
	movl %r8d, %r12d
	jmp .main_1
.main_9:
	movl %ebx, %eax
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.ident	"15-411 L4 reference compiler"
