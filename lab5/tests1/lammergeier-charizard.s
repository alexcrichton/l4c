.file	"../tests1/lammergeier-charizard.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1, %r9d
	sall $4, %r9d
.main_5:
.main_1:
	movl $1, %edx
	movl $0, %ecx
	movl %r9d, %r8d
	cmpl %ecx, %r8d
	setne %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_3
.main_2:
	movl $1, %r8d
	sall $4, %r8d
	addl %r8d, %r9d
.main_4:
	jmp .main_1
.main_3:
	movl $1, %eax
	cltd
	idivl %r9d
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
