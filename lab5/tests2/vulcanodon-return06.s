.file	"../tests2/vulcanodon-return06.l2"
.globl _c0_main
_c0_main:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
.main_0:
	movl $0, %edi
	movl $1, %edx
.main_21:
	movl %edx, %esi
	movl %edi, %edx
.main_1:
	movl $1, %r12d
	movl $11, %eax
	movl %esi, %edi
	cmpl %eax, %edi
	setl %dil
	movzbl %dil, %edi
	cmpl %edi, %r12d
	jnz .main_23
.main_2:
	movl %esi, %ecx
	imull %esi, %ecx
	movl %ecx, %edi
	imull %esi, %edi
	movl %edx, %ecx
	addl %edi, %ecx
	movl $2, %edi
	movl %esi, %eax
	cltd
	idivl %edi
	movl %edx, %ebx
	movl $1, %eax
	movl $0, %edx
	movl %ebx, %edi
	cmpl %edx, %edi
	sete %dil
	movzbl %dil, %edi
	cmpl %edi, %eax
	jnz .main_5
.main_3:
	movl %ecx, %r8d
	subl $1, %r8d
	movl %esi, %r9d
	addl $1, %r9d
	jmp .main_20
.main_5:
.main_6:
	movl $1, %eax
	movl $5, %edi
	movl %esi, %edx
	cmpl %edi, %edx
	sete %dl
	movzbl %dl, %edx
	cmpl %edx, %eax
	jnz .main_9
.main_7:
	jmp .main_22
.main_9:
.main_10:
	movl %ecx, %edi
	addl $1, %edi
	movl %esi, %edx
	addl $1, %edx
.main_19:
	movl %edx, %esi
	movl %edi, %edx
	jmp .main_1
.main_23:
	movl %edx, %esi
.main_11:
	movl $6, %edx
.main_26:
	movl %edx, %r12d
	movl %esi, %eax
.main_12:
	movl $1, %edi
	movl $11, %esi
	movl %r12d, %edx
	cmpl %esi, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %edi
	jnz .main_18
.main_13:
	movl %r12d, %edx
	imull %r12d, %edx
	imull %r12d, %edx
	movl %eax, %esi
	addl %edx, %esi
	movl $2, %edi
	movl %r12d, %eax
	cltd
	idivl %edi
	movl %edx, %edi
	movl $1, %edx
	movl $0, %eax
	cmpl %eax, %edi
	sete %dil
	movzbl %dil, %edi
	cmpl %edi, %edx
	jnz .main_16
.main_14:
	movl %esi, %edx
	subl $1, %edx
	movl %r12d, %edi
	addl $1, %edi
	jmp .main_25
.main_16:
.main_17:
	addl $1, %esi
	movl %r12d, %edx
	addl $1, %edx
.main_24:
	movl %edx, %r12d
	movl %esi, %eax
	jmp .main_12
.main_18:
	movl %eax, %r9d
	addl $1, %r9d
	movl %r9d, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.main_25:
	movl %edi, %r12d
	movl %edx, %eax
	jmp .main_12
.main_22:
	movl %ecx, %esi
	jmp .main_11
.main_20:
	movl %r9d, %esi
	movl %r8d, %edx
	jmp .main_1
.ident	"15-411 L4 reference compiler"
