.file	"../tests2/saltopus-for02.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %r9d
.main_1:
	movl $1, %edx
	movl $42, %ecx
	movl %r9d, %r8d
	cmpl %ecx, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_4
.main_2:
	jmp .main_4
.main_4:
	movl %r9d, %eax
	addq $8, %rsp
	ret
	jmp .main_4
.ident	"15-411 L4 reference compiler"
