.file	"../tests2/allosaurus-return-palindrome-true.l2"
.globl _c0_main
_c0_main:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
.main_0:
	movl $12321, %r9d
	movl $10, %ecx
	movl $1, %r8d
.main_18:
.main_1:
	movl %r9d, %eax
	cltd
	idivl %ecx
	movl $1, %edi
	movl $0, %esi
	movl %eax, %edx
	cmpl %esi, %edx
	setne %dl
	movzbl %dl, %edx
	cmpl %edx, %edi
	jnz .main_3
.main_2:
	imull $10, %ecx
	addl $1, %r8d
.main_17:
	jmp .main_1
.main_3:
	movl %r8d, %ecx
.main_20:
	movl %ecx, %r12d
.main_4:
	movl $2, %ecx
	movl %r8d, %eax
	cltd
	idivl %ecx
	movl $1, %ecx
	movl %eax, %edx
	cmpl %r12d, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %ecx
	jnz .main_16
.main_5:
	movl %r8d, %ecx
	subl %r12d, %ecx
	addl $1, %ecx
	movl $10, %esi
	movl $10, %eax
	movl %r12d, %edx
.main_22:
	movl %edx, %edi
	movl %esi, %ebx
.main_6:
	movl $1, %esi
	movl $1, %edx
	cmpl %edi, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %esi
	jnz .main_8
.main_7:
	movl %ebx, %esi
	imull $10, %esi
	movl %edi, %edx
	subl $1, %edx
.main_21:
	movl %edx, %edi
	movl %esi, %ebx
	jmp .main_6
.main_8:
.main_24:
	movl %ecx, %edi
	movl %eax, %ecx
.main_9:
	movl $1, %esi
	movl $1, %edx
	cmpl %edi, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %esi
	jnz .main_11
.main_10:
	movl %ecx, %edx
	imull $10, %edx
	movl %edi, %ecx
	subl $1, %ecx
.main_23:
	movl %ecx, %edi
	movl %edx, %ecx
	jmp .main_9
.main_11:
	movl %r9d, %eax
	cltd
	idivl %ebx
	movl %edx, %esi
	movl $10, %edi
	movl %ebx, %eax
	cltd
	idivl %edi
	movl %eax, %edi
	movl %esi, %eax
	cltd
	idivl %edi
	movl %eax, %esi
	movl %r9d, %eax
	cltd
	idivl %ecx
	movl %edx, %edi
	movl $10, %ebx
	movl %ecx, %eax
	cltd
	idivl %ebx
	movl %eax, %ecx
	movl %edi, %eax
	cltd
	idivl %ecx
	movl %eax, %edx
	movl $1, %ecx
	cmpl %edx, %esi
	setne %sil
	movzbl %sil, %esi
	cmpl %esi, %ecx
	jnz .main_14
.main_12:
	movl $0, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.main_14:
.main_15:
	movl %r12d, %ecx
	subl $1, %ecx
.main_19:
	movl %ecx, %r12d
	jmp .main_4
.main_16:
	movl $1, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
