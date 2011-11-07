.file	"../tests2/brachiosaurus-variable3.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $2, %r9d
.main_1:
	movl $1, %ecx
	movl $3, %r8d
	cmpl %r8d, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_4
.main_2:
	jmp .main_4
.main_4:
	movl $0, %eax
	addq $8, %rsp
	ret
	jmp .main_4
.ident	"15-411 L4 reference compiler"
