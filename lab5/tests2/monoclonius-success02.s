.file	"../tests2/monoclonius-success02.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	jmp .ternary_true3
	movl $1, %eax
	movl $0, %r9d
	cltd
	idivl %r9d
	movl $0, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	jmp .ternary_end4
.ternary_true3:
	movl $1, %r9d
.ternary_end4:
	cmpl $0, %r9d
	jnz .ternary_true1
	movl $4, %r9d
	jmp .ternary_end2
.ternary_true1:
	movl $5, %r9d
.ternary_end2:
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
