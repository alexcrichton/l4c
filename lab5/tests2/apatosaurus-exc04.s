.file	"../tests2/apatosaurus-exc04.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $500000, %r9d
.main_5:
	movl %r9d, %eax
.main_1:
	movl $1, %r8d
	movl $0, %edx
	movl %eax, %r9d
	cmpl %edx, %r9d
	setne %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %r8d
	jnz .main_3
.main_2:
	movl $2, %r9d
	cltd
	idivl %r9d
	movl %eax, %r9d
.main_4:
	movl %r9d, %eax
	jmp .main_1
.main_3:
	movl $50, %eax
	movl $0, %r9d
	cltd
	idivl %r9d
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
