.file	"../tests2/stegosaurus-return09.l2"
.globl _c0_main
_c0_main:
	addq $-40, %rsp
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
.main_0:
	movl $1000, %ecx
	movl $0, %edx
	movl $2, %r8d
.main_19:
	movl %r8d, %esi
	movl %edx, %edi
.main_1:
	movl $1, %edx
	movl $1, %r8d
	cmpl %r8d, %edx
	jnz .main_27
.main_2:
	movl $2, %r8d
.main_21:
.main_3:
	movl $1, %eax
	movl %r8d, %edx
	cmpl %esi, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %eax
	jnz .main_23
.main_4:
	movl %esi, %eax
	cltd
	idivl %r8d
	movl %edx, %r12d
	movl $1, %ebx
	movl $0, %eax
	movl %r12d, %edx
	cmpl %eax, %edx
	sete %dl
	movzbl %dl, %edx
	cmpl %edx, %ebx
	jnz .main_7
.main_5:
	jmp .main_22
.main_7:
.main_8:
	addl $1, %r8d
.main_20:
	movl %r12d, %r9d
	jmp .main_3
.main_23:
	movl %r9d, %ebx
.main_9:
	movl $1, %eax
	movl %r8d, %edx
	cmpl %esi, %edx
	sete %dl
	movzbl %dl, %edx
	cmpl %edx, %eax
	jnz .main_15
.main_10:
	movl %edi, %eax
	addl $1, %eax
	movl $1, %edx
	movl %ecx, %r13d
	cmpl %eax, %r13d
	setle %r13b
	movzbl %r13b, %r13d
	cmpl %r13d, %edx
	jnz .main_13
.main_11:
	jmp .main_26
.main_13:
.main_14:
.main_25:
	movl %eax, %r8d
.main_16:
	movl %esi, %edx
	addl $1, %edx
.main_18:
	movl %edx, %esi
	movl %r8d, %edi
	jmp .main_1
.main_15:
.main_24:
	movl %edi, %r8d
	jmp .main_16
.main_27:
.main_17:
	movl %esi, %eax
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.main_26:
	jmp .main_17
.main_22:
	movl %r12d, %ebx
	jmp .main_9
.ident	"15-411 L4 reference compiler"
