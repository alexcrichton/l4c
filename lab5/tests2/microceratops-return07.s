.file	"../tests2/microceratops-return07.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %r9d
	movl $1, %r8d
.main_14:
.main_1:
	movl $1, %edx
	movl $1000, %ecx
	movl %r8d, %esi
	cmpl %ecx, %esi
	setle %sil
	movzbl %sil, %esi
	cmpl %esi, %edx
	jnz .main_12
.main_2:
	movl $1, %edx
	movl $0, %ecx
.main_16:
	movl %edx, %edi
.main_3:
	movl $1, %edx
	movl %ecx, %esi
	cmpl %r8d, %esi
	setl %sil
	movzbl %sil, %esi
	cmpl %esi, %edx
	jnz .main_5
.main_4:
	movl %edi, %eax
	imull $10, %eax
	cltd
	idivl %r8d
	movl %edx, %esi
	movl %esi, %edx
	addl $1, %ecx
.main_15:
	movl %edx, %edi
	jmp .main_3
.main_5:
	movl %edi, %ecx
	movl $0, %esi
	movl %edi, %eax
	imull $10, %eax
	cltd
	idivl %r8d
	movl %edx, %edi
	movl %esi, %edx
	addl $1, %edx
.main_18:
	movl %edi, %eax
	movl %edx, %esi
.main_6:
	movl $1, %edi
	movl %eax, %edx
	cmpl %ecx, %edx
	setne %dl
	movzbl %dl, %edx
	cmpl %edx, %edi
	jnz .main_8
.main_7:
	imull $10, %eax
	cltd
	idivl %r8d
	movl %edx, %eax
	movl %eax, %edi
	movl %esi, %edx
	addl $1, %edx
.main_17:
	movl %edi, %eax
	movl %edx, %esi
	jmp .main_6
.main_8:
	movl $1, %ecx
	movl %r9d, %edx
	cmpl %esi, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %ecx
	jnz .main_10
.main_9:
	movl %esi, %r9d
.main_20:
	movl %r9d, %ecx
.main_11:
	addl $1, %r8d
.main_13:
	movl %ecx, %r9d
	jmp .main_1
.main_10:
.main_19:
	movl %r9d, %ecx
	jmp .main_11
.main_12:
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
