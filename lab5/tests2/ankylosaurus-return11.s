.file	"../tests2/ankylosaurus-return11.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $2, %r9d
	movl $16, %ecx
	movl $0, %r8d
.main_5:
	movl %ecx, %eax
.main_1:
	movl $1, %edx
	movl $0, %ecx
	cmpl %eax, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %edx
	jnz .main_3
.main_2:
	cltd
	idivl %r9d
	movl %eax, %ecx
	addl $1, %r8d
.main_4:
	movl %ecx, %eax
	jmp .main_1
.main_3:
	movl %r8d, %eax
	subl $1, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
