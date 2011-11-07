.file	"../tests2/utahraptor-exception02.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $10, %r8d
	movl $0, %r9d
.main_5:
	movl %r8d, %eax
.main_1:
	movl $1, %edx
	movl $10, %ecx
	movl %r9d, %r8d
	cmpl %ecx, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_3
.main_2:
	cltd
	idivl %r9d
	movl %edx, %r8d
	addl $1, %r9d
.main_4:
	movl %r8d, %eax
	jmp .main_1
.main_3:
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
