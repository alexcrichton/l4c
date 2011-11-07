.file	"../tests2/monoclonius-loop05.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1, %r9d
.main_5:
.main_1:
	movl $1, %r8d
	movl $100000000, %edx
	movl %r9d, %ecx
	cmpl %edx, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %r8d
	jnz .main_3
.main_2:
	movl $5, %eax
	movl $2, %r8d
	cltd
	idivl %r8d
	addl $1, %r9d
.main_4:
	jmp .main_1
.main_3:
	movl $0, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
