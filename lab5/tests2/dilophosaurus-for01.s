.file	"../tests2/dilophosaurus-for01.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $-1, %r9d
	xorl $1, %r9d
	movl $255, %r8d
	andl %r9d, %r8d
	movl $1, %ecx
	movl $0, %r9d
.main_17:
	movl %r8d, %esi
.main_1:
	movl $1, %edx
	movl $0, %r8d
	cmpl %esi, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_14
.main_2:
	movl $2, %r8d
	movl %esi, %eax
	cltd
	idivl %r8d
	movl %edx, %edi
	movl $1, %edx
	movl $0, %r8d
	cmpl %r8d, %edi
	sete %dil
	movzbl %dil, %edi
	cmpl %edi, %edx
	jnz .main_4
.main_3:
	movl $0, %r8d
.main_19:
	movl %r8d, %eax
.main_5:
	movl $1, %edi
	movl $0, %edx
	movl %ecx, %r8d
	cmpl %edx, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edi
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
	movl $1, %r8d
	xorl %eax, %r8d
	cmpl %r8d, %edx
	jnz .main_12
.main_10:
	movl %ecx, %r8d
	imull $10, %r8d
	movl $2, %edi
	movl %esi, %eax
	cltd
	idivl %edi
	movl %eax, %edx
	jmp .main_16
.main_12:
.main_13:
	movl %ecx, %edi
	addl %r9d, %edi
	movl %ecx, %r8d
	imull $10, %r8d
	movl $2, %r9d
	movl %esi, %eax
	cltd
	idivl %r9d
	movl %eax, %edx
.main_15:
	movl %edi, %r9d
	movl %r8d, %ecx
	movl %edx, %esi
	jmp .main_1
.main_4:
	movl $1, %r8d
.main_18:
	movl %r8d, %eax
	jmp .main_5
.main_14:
	movl %r9d, %eax
	addq $8, %rsp
	ret
.main_16:
	movl %r8d, %ecx
	movl %edx, %esi
	jmp .main_1
.ident	"15-411 L4 reference compiler"
