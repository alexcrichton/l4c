.file	"../tests2/diplodocus-while.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1, %r9d
	movl $0, %r8d
.main_9:
.main_1:
	movl $1, %ecx
	cmpl %r9d, %ecx
	jnz .main_11
.main_2:
	movl $5, %ecx
	subl %r8d, %ecx
	movl $5, %esi
	movl %ecx, %eax
	cltd
	idivl %esi
	movl %edx, %edi
	movl $1, %esi
	movl $1, %edx
	movl %edi, %eax
	cmpl %edx, %eax
	sete %al
	movzbl %al, %eax
	cmpl %eax, %esi
	jnz .main_5
.main_3:
	jmp .main_10
.main_5:
.main_6:
	addl $1, %r8d
.main_8:
	jmp .main_1
.main_11:
.main_7:
	movl $100, %eax
	addq $8, %rsp
	ret
.main_10:
	jmp .main_7
.ident	"15-411 L4 reference compiler"
