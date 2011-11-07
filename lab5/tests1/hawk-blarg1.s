.file	"../tests1/hawk-blarg1.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %r8d
	movl $1, %ecx
	movl $100, %r9d
.main_12:
	movl %ecx, %esi
.main_1:
	movl $1, %edx
	movl %esi, %ecx
	cmpl %r9d, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %edx
	jnz .main_3
.main_2:
	movl %r8d, %ecx
	addl %esi, %ecx
	movl %esi, %r8d
	addl $1, %r8d
.main_11:
	movl %r8d, %esi
	movl %ecx, %r8d
	jmp .main_1
.main_3:
.main_4:
	movl $1, %edx
	movl $1, %ecx
	cmpl %ecx, %edx
	jnz .main_10
.main_5:
	movl %r9d, %ecx
	imull %r9d, %ecx
	movl %ecx, %eax
	subl %r9d, %eax
	movl $2, %ecx
	cltd
	idivl %ecx
	movl $1, %edx
	movl %r8d, %ecx
	cmpl %eax, %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %edx
	jnz .main_8
.main_6:
	movl $1, %eax
	addq $8, %rsp
	ret
.main_8:
.main_9:
	jmp .main_4
.main_10:
	movl $0, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
