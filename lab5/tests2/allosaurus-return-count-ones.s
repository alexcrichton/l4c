.file	"../tests2/allosaurus-return-count-ones.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $21125491, %r9d
	movl $0, %ecx
	movl $10, %r8d
.main_8:
.main_1:
	movl %r9d, %eax
	cltd
	idivl %r8d
	movl $1, %edi
	movl $0, %esi
	movl %eax, %edx
	cmpl %esi, %edx
	setne %dl
	movzbl %dl, %edx
	cmpl %edx, %edi
	jnz .main_6
.main_2:
	movl %r9d, %eax
	cltd
	idivl %r8d
	movl %edx, %esi
	movl $10, %edi
	movl %r8d, %eax
	cltd
	idivl %edi
	movl %eax, %edi
	movl %esi, %eax
	cltd
	idivl %edi
	movl %eax, %edi
	movl $1, %esi
	movl $1, %edx
	cmpl %edx, %edi
	sete %dil
	movzbl %dil, %edi
	cmpl %edi, %esi
	jnz .main_4
.main_3:
	addl $1, %ecx
.main_10:
	movl %ecx, %edx
.main_5:
	imull $10, %r8d
.main_7:
	movl %edx, %ecx
	jmp .main_1
.main_4:
.main_9:
	movl %ecx, %edx
	jmp .main_5
.main_6:
	movl %ecx, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
