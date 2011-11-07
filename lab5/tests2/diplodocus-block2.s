.file	"../tests2/diplodocus-block2.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $2, %r9d
	movl $1, %ecx
	movl $4, %r8d
	cmpl %r9d, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .main_2
.main_1:
	movl $3, %r9d
.main_5:
.main_3:
	movl %r9d, %eax
	addq $8, %rsp
	ret
.main_2:
	movl $5, %r9d
.main_4:
	jmp .main_3
.ident	"15-411 L4 reference compiler"
