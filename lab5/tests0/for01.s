.file	"../tests0/for01.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $254, %ecx
	movl $1, %r8d
	movl $0, %r9d
.main_17:
	movl %ecx, %esi
.main_1:
	movl $1, %edx
	movl $0, %ecx
	cmpl %esi, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %edx
	jnz .main_14
.main_2:
	movl $2, %ecx
	movl %esi, %eax
	cltd
	idivl %ecx
	movl $1, %edi
	movl $0, %ecx
	cmpl %ecx, %edx
	sete %dl
	movzbl %dl, %edx
	cmpl %edx, %edi
	jnz .main_4
.main_3:
	movl $0, %ecx
.main_19:
	movl %ecx, %eax
.main_5:
	movl $1, %edi
	movl $0, %edx
	movl %r8d, %ecx
	cmpl %edx, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %edi
	jnz .main_8
.main_6:
	movl $1, %eax
	movl $0, %r9d
	cltd
	idivl %r9d
	addq $8, %rsp
	ret
.main_8:
.main_9:
	movl $1, %edx
	movl $1, %ecx
	xorl %eax, %ecx
	cmpl %ecx, %edx
	jnz .main_12
.main_10:
	movl %r8d, %ecx
	imull $10, %ecx
	movl $2, %edi
	movl %esi, %eax
	cltd
	idivl %edi
	movl %eax, %edx
	jmp .main_16
.main_12:
.main_13:
	movl %r8d, %ecx
	addl %r9d, %ecx
	imull $10, %r8d
	movl $2, %r9d
	movl %esi, %eax
	cltd
	idivl %r9d
	movl %eax, %edx
.main_15:
	movl %ecx, %r9d
	movl %edx, %esi
	jmp .main_1
.main_4:
	movl $1, %ecx
.main_18:
	movl %ecx, %eax
	jmp .main_5
.main_14:
	movl %r9d, %eax
	addq $8, %rsp
	ret
.main_16:
	movl %ecx, %r8d
	movl %edx, %esi
	jmp .main_1
.ident	"15-411 L4 reference compiler"
