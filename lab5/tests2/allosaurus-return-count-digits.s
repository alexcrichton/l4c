.file	"../tests2/allosaurus-return-count-digits.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $12345, %r9d
	movl $1, %r8d
	movl $10, %ecx
.main_5:
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
	addl $1, %r8d
	imull $10, %ecx
.main_4:
	jmp .main_1
.main_3:
	movl %r8d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
