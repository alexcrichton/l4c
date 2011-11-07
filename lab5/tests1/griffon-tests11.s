.file	"../tests1/griffon-tests11.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %r9d
	movl $0, %r8d
.main_8:
.main_1:
	movl $1, %esi
	movl $10, %edx
	movl %r8d, %ecx
	cmpl %edx, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .main_6
.main_2:
	movl $2, %ecx
	movl %r8d, %eax
	cltd
	idivl %ecx
	movl %edx, %ecx
	movl $1, %esi
	movl $0, %edx
	cmpl %edx, %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .main_4
.main_3:
	addl $1, %r9d
.main_10:
	movl %r9d, %ecx
.main_5:
	addl $1, %r8d
.main_7:
	movl %ecx, %r9d
	jmp .main_1
.main_4:
.main_9:
	movl %r9d, %ecx
	jmp .main_5
.main_6:
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
