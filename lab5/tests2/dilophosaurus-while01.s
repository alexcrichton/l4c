.file	"../tests2/dilophosaurus-while01.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1, %r9d
.main_5:
	movl %r9d, %eax
.main_1:
	movl $1, %r9d
	movl $0, %r8d
	cmpl %eax, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %r9d
	jnz .main_3
.main_2:
	movl %eax, %r9d
	sall $1, %r9d
.main_4:
	movl %r9d, %eax
	jmp .main_1
.main_3:
	movl %eax, %r9d
	subl %eax, %r9d
	cltd
	idivl %r9d
	movl %eax, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
