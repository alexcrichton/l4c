.file	"../tests1/eagle-break-continue-both-work.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %r9d
.main_17:
	movl %r9d, %edx
.main_1:
	movl $1, %r8d
	movl $10, %ecx
	movl %edx, %r9d
	cmpl %ecx, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %r8d
	jnz .main_16
.main_2:
	movl $1, %ecx
	movl $0, %r9d
	movl %edx, %r8d
	cmpl %r9d, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .main_5
.main_3:
	movl %edx, %r9d
	addl $1, %r9d
	jmp .main_18
.main_5:
.main_6:
	movl $1, %r9d
	movl $0, %ecx
	movl %edx, %r8d
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %r9d
	jnz .main_9
.main_7:
	movl $0, %eax
	movl $0, %r9d
	cltd
	idivl %r9d
	addq $8, %rsp
	ret
.main_9:
.main_10:
	movl $1, %ecx
	movl $1, %r8d
	movl %edx, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_13
.main_11:
	jmp .main_16
.main_13:
.main_14:
	movl $0, %eax
	movl $0, %r9d
	cltd
	idivl %r9d
	addq $8, %rsp
	ret
.main_16:
	movl $0, %eax
	addq $8, %rsp
	ret
	jmp .main_16
.main_18:
	movl %r9d, %edx
	jmp .main_1
.ident	"15-411 L4 reference compiler"
