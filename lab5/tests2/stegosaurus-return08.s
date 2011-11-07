.file	"../tests2/stegosaurus-return08.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $100000000, %r9d
	movl $0, %ecx
	movl $0, %r8d
.main_8:
.main_1:
	movl $1, %edi
	movl $20000000, %esi
	movl %r8d, %edx
	cmpl %esi, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %edi
	jnz .main_6
.main_2:
	movl $2, %edx
	imull %r8d, %edx
	movl %edx, %esi
	addl $1, %esi
	movl $2, %edi
	movl %r8d, %eax
	cltd
	idivl %edi
	movl $1, %eax
	movl $0, %edi
	cmpl %edi, %edx
	sete %dl
	movzbl %dl, %edx
	cmpl %edx, %eax
	jnz .main_4
.main_3:
	movl %r9d, %eax
	cltd
	idivl %esi
	addl %eax, %ecx
.main_10:
	movl %ecx, %edx
.main_5:
	addl $1, %r8d
.main_7:
	movl %edx, %ecx
	jmp .main_1
.main_4:
	movl %r9d, %eax
	cltd
	idivl %esi
	movl %ecx, %edi
	subl %eax, %edi
.main_9:
	movl %edi, %edx
	jmp .main_5
.main_6:
	movl %ecx, %eax
	imull $4, %eax
	movl $1000, %r9d
	cltd
	idivl %r9d
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
