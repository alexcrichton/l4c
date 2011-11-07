.file	"../tests1/griffon-tests5.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $5, %r8d
	movl $3, %ecx
	movl $0, %r9d
.main_9:
	movl %r9d, %edi
	movl %ecx, %eax
	movl %r8d, %r9d
.main_1:
	movl $1, %edx
	movl $5, %ecx
	movl %edi, %r8d
	cmpl %ecx, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_3
.main_2:
	movl %r9d, %ecx
	subl $1, %ecx
	movl %eax, %r8d
	addl $1, %r8d
	movl %edi, %r9d
	addl $1, %r9d
.main_8:
	movl %r9d, %edi
	movl %r8d, %eax
	movl %ecx, %r9d
	jmp .main_1
.main_3:
	movl $1, %edx
	movl $0, %ecx
	movl %edi, %r8d
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_5
.main_4:
	movl %r9d, %eax
	addq $8, %rsp
	ret
.main_5:
	cltd
	idivl %r9d
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
