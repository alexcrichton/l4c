.file	"../tests1/griffon-tests13.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $5, %r9d
.main_5:
.main_1:
	movl $1, %ecx
	movl $0, %r8d
	cmpl %r9d, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .main_3
.main_2:
	subl $1, %r9d
.main_4:
	jmp .main_1
.main_3:
	movl $5, %eax
	cltd
	idivl %r9d
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
