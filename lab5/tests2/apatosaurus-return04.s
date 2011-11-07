.file	"../tests2/apatosaurus-return04.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	jmp .ternary_true7
	movl $0, %r9d
	jmp .ternary_end8
.ternary_true7:
	movl $1, %r9d
.ternary_end8:
	cmpl $0, %r9d
	jnz .ternary_true5
	movl $0, %r8d
	jmp .ternary_end6
.ternary_true5:
	movl $500, %r8d
	movl $250, %r9d
	sall $1, %r9d
	sarl $1, %r9d
	cmpl %r9d, %r8d
	setne %r8b
	movzbl %r8b, %r8d
.ternary_end6:
	cmpl $0, %r8d
	jnz .ternary_true3
	movl $0, %r8d
	jmp .ternary_end4
.ternary_true3:
	movl $-1, %r8d
	xorl $-65537, %r8d
	movl $65536, %r9d
	cmpl %r9d, %r8d
	sete %r8b
	movzbl %r8b, %r8d
.ternary_end4:
	cmpl $0, %r8d
	jnz .ternary_true1
	movl $0, %r8d
	jmp .ternary_end2
.ternary_true1:
	movl $1001, %eax
	movl $10, %r9d
	cltd
	idivl %r9d
	movl $1, %r9d
	movl %edx, %r8d
	cmpl %r9d, %r8d
	sete %r8b
	movzbl %r8b, %r8d
.ternary_end2:
	movl $1, %r9d
	cmpl %r8d, %r9d
	jnz .main_3
.main_1:
	movl $1, %eax
	addq $8, %rsp
	ret
.main_3:
.main_4:
	movl $0, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
