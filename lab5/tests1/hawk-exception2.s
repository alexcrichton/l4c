.file	"../tests1/hawk-exception2.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $20000, %esi
	movl $34, %r9d
.main_8:
	movl %r9d, %r8d
.main_1:
	movl $1, %r9d
	movl %r8d, %ecx
	cmpl %esi, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %r9d
	jnz .main_3
.main_2:
	movl %r8d, %r9d
	imull $4, %r9d
.main_7:
	movl %r9d, %r8d
	jmp .main_1
.main_3:
.main_10:
	movl %r8d, %eax
	movl %esi, %r9d
.main_4:
	movl $1, %ecx
	movl $1, %r8d
	cmpl %r8d, %ecx
	jnz .main_6
.main_5:
	cltd
	idivl %r9d
	movl %edx, %r8d
	movl %r9d, %eax
	cltd
	idivl %r8d
	movl %edx, %r9d
.main_9:
	movl %r8d, %eax
	jmp .main_4
.main_6:
	movl $1, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
